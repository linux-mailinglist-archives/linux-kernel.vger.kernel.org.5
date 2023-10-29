Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD27DAD6F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJ2RJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2RJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:09:22 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FAAF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:09:19 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3b2e2487c6bso5488384b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698599359; x=1699204159;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBd380BSFeRmOvvgknUVVzcx8jV5Amc7bE8eqUKou/M=;
        b=qwkhM7Bwmr/WyAhpWac+a8B7xeS/d2IYqny+BJpKG7tyxh4WuC1qrgBsoZKS4QMb+X
         UnRW5fKuG8vPxLeZ9qxOZ+yCzHG5pNOZWI1h/vwynDh0iaCjMBJa26wa9PRLouF/wS0O
         sV7YHtEhrDjrAscWfMkqcXI1itsPlGmuThiEAGnav5daqSkHNhlQIQ1O9mXhfrd3MqB4
         mkarMwVxW/97RFntH6/jv7hsD2TSOcQu8QJ+1YlA4NDvkDTYP+a2ZbDi8Mmk4RknEYdu
         q6u91TsdGes3NK8d11cUDJQDpQUkRcLakZaqsaiFeQ9MR66zonXxVFyBivublR+QS85Z
         h9/w==
X-Gm-Message-State: AOJu0Yxtu3WKcSNvzzJFXpbjCElQAwp0pqwfv4iBFpbHbcx/BWRjzsWA
        N/RqxNsweFYfklUv6sBx1CRH7DC+uK3v7cL0oMRH2PIaezl3
X-Google-Smtp-Source: AGHT+IH31aGS3RdFZoJwmzguI3F7ZUKzYll6NwAMp46Oy+cHu9lROISeea2c5ts2TQ+7pxjB7s67Edx9fvc64sksmN4FhbiFDgCg
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1882:b0:3b2:e2a4:693f with SMTP id
 bi2-20020a056808188200b003b2e2a4693fmr3114067oib.6.1698599358844; Sun, 29 Oct
 2023 10:09:18 -0700 (PDT)
Date:   Sun, 29 Oct 2023 10:09:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006655c10608ddfb6d@google.com>
Subject: [syzbot] [mm?] general protection fault in __hugetlb_zap_begin
From:   syzbot <syzbot+ec9435c038e451be48ff@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        riel@surriel.com, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a568e3a961b Merge tag 'soc-fixes-6.7-3' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=159d9cdd680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=174a257c5ae6b4fd
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9435c038e451be48ff
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e433eb680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16808d35680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70fcba190275/disk-3a568e3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65a6a954dd61/vmlinux-3a568e3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4d7963284af/bzImage-3a568e3a.xz

The issue was bisected to:

commit bf4916922c60f43efaa329744b3eef539aa6a2b2
Author: Rik van Riel <riel@surriel.com>
Date:   Fri Oct 6 03:59:07 2023 +0000

    hugetlbfs: extend hugetlb_vma_lock to private VMAs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d92743680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14392743680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10392743680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec9435c038e451be48ff@syzkaller.appspotmail.com
Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")

general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 1 PID: 5048 Comm: syz-executor261 Not tainted 6.6.0-rc7-syzkaller-00123-g3a568e3a961b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5004
Code: 85 75 18 00 00 83 3d fd 93 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84 f8 0f 00 00 83 3d 5c 8c b2 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 00 74 1a 48 89 d7 e8 24 c0 7b 00 48 8b 94 24 80 00 00
RSP: 0018:ffffc90003abf440 EFLAGS: 00010006
RAX: 000000000000001d RBX: 1ffff92000757eac RCX: 0000000000000000
RDX: 00000000000000e8 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: ffffc90003abf708 R08: dffffc0000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d32d6e R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88807b34bb80
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbcd77db0d0 CR3: 0000000029b05000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1573
 __hugetlb_zap_begin+0x2e0/0x380 mm/hugetlb.c:5447
 hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
 unmap_vmas+0x364/0x5c0 mm/memory.c:1733
 exit_mmap+0x297/0xc50 mm/mmap.c:3230
 __mmput+0x115/0x3c0 kernel/fork.c:1349
 exit_mm+0x21f/0x300 kernel/exit.c:567
 do_exit+0x9af/0x2650 kernel/exit.c:861
 __do_sys_exit kernel/exit.c:991 [inline]
 __se_sys_exit kernel/exit.c:989 [inline]
 __x64_sys_exit+0x40/0x40 kernel/exit.c:989
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbcd7764af9
Code: Unable to access opcode bytes at 0x7fbcd7764acf.
RSP: 002b:00007ffe3ee5cb58 EFLAGS: 00000246
 ORIG_RAX: 000000000000003c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbcd7764af9
RDX: 00007fbcd779e433 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000011f97 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3ee5cc7c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5004
Code: 85 75 18 00 00 83 3d fd 93 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84 f8 0f 00 00 83 3d 5c 8c b2 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 00 74 1a 48 89 d7 e8 24 c0 7b 00 48 8b 94 24 80 00 00
RSP: 0018:ffffc90003abf440 EFLAGS: 00010006

RAX: 000000000000001d RBX: 1ffff92000757eac RCX: 0000000000000000
RDX: 00000000000000e8 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: ffffc90003abf708 R08: dffffc0000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d32d6e R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88807b34bb80
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbcd77db0d0 CR3: 0000000029b05000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 75 18             	test   %esi,0x18(%rbp)
   3:	00 00                	add    %al,(%rax)
   5:	83 3d fd 93 2c 0d 00 	cmpl   $0x0,0xd2c93fd(%rip)        # 0xd2c9409
   c:	48 89 9c 24 10 01 00 	mov    %rbx,0x110(%rsp)
  13:	00
  14:	0f 84 f8 0f 00 00    	je     0x1012
  1a:	83 3d 5c 8c b2 0b 00 	cmpl   $0x0,0xbb28c5c(%rip)        # 0xbb28c7d
  21:	74 34                	je     0x57
  23:	48 89 d0             	mov    %rdx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1) <-- trapping instruction
  2f:	74 1a                	je     0x4b
  31:	48 89 d7             	mov    %rdx,%rdi
  34:	e8 24 c0 7b 00       	call   0x7bc05d
  39:	48                   	rex.W
  3a:	8b                   	.byte 0x8b
  3b:	94                   	xchg   %eax,%esp
  3c:	24 80                	and    $0x80,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
