//
//  GameViewController.m
//  TicTacToe
//
//  Created by Suleiman Younossi on 3/20/16.
//  Copyright © 2016 Suleiman Younossi. All rights reserved.
//

#import "GameViewController.h"
#import "XOButton.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UIView *grid;
@property NSMutableArray *playerOnePlays;
@property NSMutableArray *playerTwoPlays;
@property NSMutableArray *allButtons;
@property BOOL gameOver;


@property (weak, nonatomic) IBOutlet UILabel *gameTitle;



@end

@implementation GameViewController

enum players { PlayerOne, PlayerTwo };
enum players currentPlayer;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allButtons = [NSMutableArray new];
    self.playerOnePlays = [NSMutableArray new];
    self.playerTwoPlays = [NSMutableArray new];
    [self makeGrid];
    
    
    currentPlayer = PlayerOne;
    self.gameOver = NO;
    self.gameTitle.text = @"";
    


}

-(void)makeGrid {
    
    
    for (int y = 0; y < 3; y++) {

        for (int x = 0;  x < 3; x++) {
            XOButton *button = [XOButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor:[UIColor blackColor]];
            [button.layer setBorderWidth:1];
            [button.layer setBorderColor:[UIColor whiteColor].CGColor];
            button.frame = CGRectMake(x * 100, y * 100, 100, 100);
            
            button.x = x;
            button.y = y;
            
            [self.allButtons addObject:button];
            
            
            [self.grid addSubview:button];
        }
    
    }
    
}

-(void)buttonPressed:(UIButton *)sender{

    
    if (currentPlayer == PlayerOne) {
        [sender setTitle:@"X" forState:UIControlStateNormal];
        [self.playerOnePlays addObject:sender];
        currentPlayer = PlayerTwo;
        if  (self.playerOnePlays.count > 2) {

            [self checkColumnsAndRows:self.playerOnePlays];
            [self checkLeftDiagonal];
//            [self checkRightDiagonal];
        }

    } else {
        [sender setTitle:@"O" forState:UIControlStateNormal];
        [self.playerTwoPlays addObject:sender];
        currentPlayer = PlayerOne;
        if  (self.playerTwoPlays.count > 2) {
            
            [self checkColumnsAndRows:self.playerTwoPlays];
            [self checkLeftDiagonal];
//            [self checkRightDiagonal];
        }

    }

    sender.enabled = NO;
    
    if (self.gameOver) {
        [self newGame];
    }
    
    if (self.playerOnePlays.count == 5) {
        [self newGame];
    }
    
}


-(void)checkColumnsAndRows:(NSMutableArray *)playersPlays {
    
    NSMutableArray *xArray = [NSMutableArray new];
    NSMutableArray *yArray = [NSMutableArray new];
    
    for (XOButton *button in playersPlays) {
        [xArray addObject:[NSNumber numberWithInt:button.x]];
        [yArray addObject:[NSNumber numberWithInt:button.y]];
        
    }

    
    NSSet *row = [NSSet setWithArray:xArray];
    NSSet *column = [NSSet setWithArray:yArray];
    
    
    if (row.count == 1 || column.count == 1) {
        self.gameTitle.text = @"Win";
        self.gameOver = YES;
        
    }
 
}



-(void)checkLeftDiagonal {
    
    NSMutableArray *diagonalButtons = [NSMutableArray new];
    
    for (int i = 0 ; i < 9 ; i += 4) {
        [diagonalButtons addObject:[self.allButtons objectAtIndex:i]];
    }
    
    NSMutableArray *diagonalTitles = [NSMutableArray new];
    
    for (XOButton *button in diagonalButtons) {
        
        if (button.titleLabel.text) {
            [diagonalTitles addObject:button.titleLabel.text];
            
            
        }
    }
   
    NSCountedSet *check = [NSCountedSet setWithArray:diagonalTitles];
    
    if ([check countForObject:@"X"] == 3) {
        self.gameTitle.text = @"Win";
        self.gameOver = YES;
    }else if ([check countForObject:@"O"] == 3) {
        self.gameTitle.text = @"Win";
        self.gameOver = YES;
    }
}

-(void)checkRightDiagonal {
    NSMutableArray *diagonalButtons = [NSMutableArray new];
    
    for (int i = 2 ; i <= 6 ; i += 2) {
        [diagonalButtons addObject:[self.allButtons objectAtIndex:i]];
    }
    
    NSMutableArray *diagonalTitles = [NSMutableArray new];
    
    for (XOButton *button in diagonalButtons) {
        
        if (button.titleLabel.text) {
            [diagonalTitles addObject:button.titleLabel.text];

        }
    }
    
    NSCountedSet *check = [NSCountedSet setWithArray:diagonalTitles];
    
    if ([check countForObject:@"X"] == 3) {
        self.gameTitle.text = @"Win";
        self.gameOver = YES;
    }else if ([check countForObject:@"O"] == 3) {
        self.gameTitle.text = @"Win";
        self.gameOver = YES;
    }
}

-(void)newGame {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"Want to play again?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *replayButton = [UIAlertAction actionWithTitle:@"play again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self viewDidLoad];
    }];
    
    [alertController addAction:replayButton];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}




@end
