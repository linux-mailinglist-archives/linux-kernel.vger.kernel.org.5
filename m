Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A687E025E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjKCLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCLwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:52:10 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471951A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:52:04 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce322bbb63so2122903a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699012323; x=1699617123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzRVIsWAKsuZhEWu14wzGeGNAiK+7dXMuzIMtGAIt10=;
        b=b6CYXauElVHXJ/k5MvB3X+UaOpLSEyp6xPMR8piuUxCcIc8fF2ivrJ2b1bAYX3G5OP
         /Al2HnQg/5kh3AQeUCFKbriaExaPGl4l5P/s/fF1v0iMuAnSRQdB/3CiiiJUUhCovfzY
         vvfn7BsbMqJ/oYfltuJt2FOJExI7WHkisCIoSbbVSRlTO+wCGBo1BNKVn5hIK+u49AbQ
         nElVaP87HzZ2KrnpBFbsx6CtnNazIACFrV+5IOvqevBMp2HsGsdAM+c5P2tpWm+CScxR
         yQxyJqDmVOZjp5BuRDhUZ1qj+KSLvJeOw8LBIXT36ArCmAp0XhWqRrq4o6hM8OU18znz
         PKjQ==
X-Gm-Message-State: AOJu0Yy9kr68G1lx9fLB0tS/hX0xq/XCffC3kJAs0Ocv0gJRDq37BZ3t
        4OluRXwxhX/GZRKG3TwfVuCwM9dEcyiInfc71FqWLba2pJ6V
X-Google-Smtp-Source: AGHT+IHdoTRljrJttUOnk6CzDgI+dlNh605W7FUQEb4OZmHunKtMYW2xMxvudu8iJTrsq+HbiAnST8eajmzkFKLLzVeIE8idexay
MIME-Version: 1.0
X-Received: by 2002:a9d:4c15:0:b0:6ce:262b:630a with SMTP id
 l21-20020a9d4c15000000b006ce262b630amr6119416otf.6.1699012323592; Fri, 03 Nov
 2023 04:52:03 -0700 (PDT)
Date:   Fri, 03 Nov 2023 04:52:03 -0700
In-Reply-To: <tencent_E5C64B4991EEF2AEC68C80A7DF86E092CF06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004515d06093e225d@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in __hugetlb_zap_begin
From:   syzbot <syzbot+ec9435c038e451be48ff@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __hugetlb_zap_begin

general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 1 PID: 5726 Comm: syz-executor.3 Not tainted 6.6.0-rc6-next-20231018-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5004
Code: 85 75 18 00 00 83 3d fd 68 4d 0d 00 48 89 9c 24 10 01 00 00 0f 84 f8 0f 00 00 83 3d 0c 61 d2 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 00 74 1a 48 89 d7 e8 b4 76 7d 00 48 8b 94 24 80 00 00
RSP: 0018:ffffc90005a37440 EFLAGS: 00010006
RAX: 000000000000001d RBX: 1ffff92000b46eac RCX: 0000000000000000
RDX: 00000000000000e8 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: ffffc90005a37708 R08: dffffc0000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d74f1e R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888028368000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe062f6d48 CR3: 00000000282bd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 __hugetlb_zap_begin+0x2e0/0x380 mm/hugetlb.c:5707
 hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
 unmap_vmas+0x364/0x5c0 mm/memory.c:1742
 exit_mmap+0x297/0xc50 mm/mmap.c:3308
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x9b7/0x2750 kernel/exit.c:858
 __do_sys_exit kernel/exit.c:988 [inline]
 __se_sys_exit kernel/exit.c:986 [inline]
 __x64_sys_exit+0x40/0x40 kernel/exit.c:986
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f67fe27cae9
Code: Unable to access opcode bytes at 0x7f67fe27cabf.
RSP: 002b:00007f67fef73078 EFLAGS: 00000246
 ORIG_RAX: 000000000000003c
RAX: ffffffffffffffda RBX: 00007f67fe39bf80 RCX: 00007f67fe27cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f67fe2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f67fe39bf80 R15: 00007ffdf414ed58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5004
Code: 85 75 18 00 00 83 3d fd 68 4d 0d 00 48 89 9c 24 10 01 00 00 0f 84 f8 0f 00 00 83 3d 0c 61 d2 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 00 74 1a 48 89 d7 e8 b4 76 7d 00 48 8b 94 24 80 00 00
RSP: 0018:ffffc90005a37440 EFLAGS: 00010006

RAX: 000000000000001d RBX: 1ffff92000b46eac RCX: 0000000000000000
RDX: 00000000000000e8 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: ffffc90005a37708 R08: dffffc0000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d74f1e R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffff888028368000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe062f6d48 CR3: 00000000282bd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 75 18             	test   %esi,0x18(%rbp)
   3:	00 00                	add    %al,(%rax)
   5:	83 3d fd 68 4d 0d 00 	cmpl   $0x0,0xd4d68fd(%rip)        # 0xd4d6909
   c:	48 89 9c 24 10 01 00 	mov    %rbx,0x110(%rsp)
  13:	00
  14:	0f 84 f8 0f 00 00    	je     0x1012
  1a:	83 3d 0c 61 d2 0b 00 	cmpl   $0x0,0xbd2610c(%rip)        # 0xbd2612d
  21:	74 34                	je     0x57
  23:	48 89 d0             	mov    %rdx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1) <-- trapping instruction
  2f:	74 1a                	je     0x4b
  31:	48 89 d7             	mov    %rdx,%rdi
  34:	e8 b4 76 7d 00       	call   0x7d76ed
  39:	48                   	rex.W
  3a:	8b                   	.byte 0x8b
  3b:	94                   	xchg   %eax,%esp
  3c:	24 80                	and    $0x80,%al


Tested on:

commit:         2dac7569 Add linux-next specific files for 20231018
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc60d7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29e8e23689e6210c
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9435c038e451be48ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1088a55f680000

