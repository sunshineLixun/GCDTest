//
//  main.m
//  GCD
//
//  Created by lixun on 2016/12/4.
//  Copyright © 2016年 sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*
        dispatch_group_t group = dispatch_group_create();
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        for (int i = 0; i<100; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_group_async(group, queue, ^{
                NSLog(@"%i",i);
                sleep(2);
                dispatch_semaphore_signal(semaphore);
                
            });
            
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        */
        
    
        
#pragma mark - 并行队列
        //dispatch_queue_t concurrentqueue = dispatch_queue_create("com.starming.serialqueue", DISPATCH_QUEUE_CONCURRENT);
        
#pragma mark - 串行队列
       // dispatch_queue_t serialqueue = dispatch_queue_create("com.starming.serialqueue", DISPATCH_QUEUE_SERIAL);
        
        
#pragma mark - 设置优先级
        /*
         - DISPATCH_QUEUE_PRIORITY_HIGH:         QOS_CLASS_USER_INITIATED
         *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:      QOS_CLASS_DEFAULT
         *  - DISPATCH_QUEUE_PRIORITY_LOW:          QOS_CLASS_UTILITY
         *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:   QOS_CLASS_BACKGROUND
         */
        
       // dispatch_queue_attr_t att = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_DEFAULT, 0);
        
       // dispatch_queue_t queue = dispatch_queue_create("com.starming.serialqueue", att);
        
        //dispatch_queue_t queue =  dispatch_queue_create_with_target("com.starming.serialqueue", att, DISPATCH_QUEUE_PRIORITY_DEFAULT);
        
        
        
        /*
        dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t firstQueue = dispatch_queue_create("com.starming.gcddemo.firstqueue", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t secondQueue = dispatch_queue_create("com.starming.gcddemo.secondqueue", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_set_target_queue(firstQueue, serialQueue);
        dispatch_set_target_queue(secondQueue, serialQueue);
        
        dispatch_async(firstQueue, ^{
            NSLog(@"1");
            [NSThread sleepForTimeInterval:3.f];
        });
        dispatch_async(secondQueue, ^{
            NSLog(@"2");
            [NSThread sleepForTimeInterval:2.f];
        });
        dispatch_async(secondQueue, ^{
            NSLog(@"3");
            [NSThread sleepForTimeInterval:1.f];
        });
        
        NSLog(@"4");
        */
        
        
        NSMutableArray *array = [NSMutableArray array];
        dispatch_semaphore_t semphore = dispatch_semaphore_create(1);
        dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
        
        NSLog(@"%f",CFAbsoluteTimeGetCurrent());
        dispatch_apply(9999, concurrentQueue, ^(size_t i) {
            dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
           
            /*
            @synchronized (array) {
                [array addObject:[NSNumber numberWithUnsignedInteger:i]];
            }
             */
            [array addObject:[NSNumber numberWithUnsignedInteger:i]];
            
            dispatch_semaphore_signal(semphore);
            
        });
        
        NSLog(@"%@",array);
        NSLog(@"%f",CFAbsoluteTimeGetCurrent());
        
        
        /*
        NSLog(@"%f",CFAbsoluteTimeGetCurrent());
        for (NSInteger i = 0; i < 1000; i ++) {
            NSLog(@"%ld",i);
        }
        NSLog(@"%f",CFAbsoluteTimeGetCurrent());
        */
        
        
        /*
        dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"1");
        });
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"2");
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"end");
        });
        NSLog(@"can continue");
        */
        
        
        
        
        /*
        dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_block_t firstBlock = dispatch_block_create(0, ^{
            NSLog(@"first block start");
            [NSThread sleepForTimeInterval:2.f];
            NSLog(@"first block end");
        });
        
        dispatch_async(serialQueue, firstBlock);
        
        dispatch_block_t secondBlock = dispatch_block_create(0, ^{
            NSLog(@"second block run");
        });
        
        //first block执行完才在serial queue中执行second block
        dispatch_block_notify(firstBlock, serialQueue, secondBlock);
        */
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
