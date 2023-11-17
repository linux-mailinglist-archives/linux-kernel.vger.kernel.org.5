Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565727EF6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346157AbjKQRdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjKQRdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:33:08 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F63B3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:33:05 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28079cae9fdso2587825a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242385; x=1700847185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJYW5hA/lrXSBGl54G+cG3+aUTRsqhy33CfSESbWYBI=;
        b=WYrqic7RgM8tXkUa2R60wU+yO8XOIqsAShJDSnrGVZeLRtcJ81FpJ3IEOmnowkexkS
         YsmvIwgQ4QAcs8B3bjbYwe9+Bit/WHrQxnKgAIRtPJ+q2QlzJ5+dthz9UPszZFR5psLD
         teUIjJNRer3uwOeWb0OwKhs81plYRgbY0A7xrWz3KSCIj0CHOrsYsbKVgb6NxdL7LqEI
         cfh6tGG9A9Y05sL7k1MFlWWnf94lN6IjsiLyEmWW8lUnL3vyHRB0bKlzYNRkjbRD2VGw
         akWKZXlu+l80MoCw1sTa0EWFpo16MbkDRUPTm9gsoNPT2a4xzP/pxgq4bfwp2orWIK9y
         wYhQ==
X-Gm-Message-State: AOJu0Yx5l+JUcnL7OHeaToX6Hn+Hhhfjt7cIbUpFjw3N3qOLEoZnZRL6
        3zKIyMtx5r6zl8AcjGHwE16o7S39CaC8eGg711MZflEjhT4KU10=
X-Google-Smtp-Source: AGHT+IHAz4ctcpLxFNrXDwSHvr0wAI5+ztrXLH3/Z2yD4OGu1b1fReu9Rx4YX3VtmuPHn0xlEsllxCcTtoEBzgKwjz2GKSmfzcuY
MIME-Version: 1.0
X-Received: by 2002:a17:90a:77c3:b0:268:1be1:b835 with SMTP id
 e3-20020a17090a77c300b002681be1b835mr28246pjs.2.1700242384878; Fri, 17 Nov
 2023 09:33:04 -0800 (PST)
Date:   Fri, 17 Nov 2023 09:33:04 -0800
In-Reply-To: <CAJjsb4oEUNjc6xM7u98mzBvq0fiZDOYWR7=vWDFEJbcW=2H4Ew@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000620229060a5c8770@google.com>
Subject: Re: [syzbot] [bpf?] [reiserfs?] WARNING: locking bug in corrupted (2)
From:   syzbot <syzbot+3779764ddb7a3e19437f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in __hrtimer_run_queues

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5476 Comm: dhcpcd-run-hook Not tainted 6.7.0-rc1-syzkaller-00139-g6bc40e44f1dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000007e38 EFLAGS: 00010046
RAX: 0000000080010000 RBX: ffff8880b982b9c0 RCX: ffffffff81767893
RDX: ffff888079589dc0 RSI: ffffffff817678a1 RDI: ffffc90004bcfd90
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000081 R11: ffffc90000007ff8 R12: ffff8880b982b940
R13: 0000000000000081 R14: ffffc90004bcfd90 R15: 0000000000000000
FS:  00007f0750eb5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000007b29c000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__init_rwsem+0x13/0x1b0 kernel/locking/rwsem.c:312
Code: 18 4c 89 e7 31 ed e8 1c 49 de 08 eb e8 48 89 df e8 52 86 77 00 eb 9e f3 0f 1e fa 41 54 49 89 d4 55 48 89 f5 be 98 00 00 00 53 <48> 89 fb e8 45 c9 00 00 48 8d 7b 70 45 31 c9 31 c9 6a 00 4c 89 e2
RSP: 0018:ffffc900053f7980 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880152a1800 RCX: 0000000000000001
RDX: ffffffff90667540 RSI: 0000000000000098 RDI: ffff88802767eaf8
RBP: ffffffff8a8b0a60 R08: ffffc900053f7950 R09: 0000000000000000
R10: ffff88802767eaf8 R11: 0000000000000000 R12: ffffffff90667540
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
 vma_lock_alloc kernel/fork.c:463 [inline]
 vm_area_dup+0x9d/0x2f0 kernel/fork.c:512
 dup_mmap+0x93c/0x1d80 kernel/fork.c:710
 dup_mm kernel/fork.c:1691 [inline]
 copy_mm kernel/fork.c:1740 [inline]
 copy_process+0x6cab/0x7490 kernel/fork.c:2502
 kernel_clone+0xe9/0x920 kernel/fork.c:2907
 __do_sys_clone+0xba/0x100 kernel/fork.c:3050
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0750fefa12
Code: 41 5d 41 5e 41 5f c3 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 e7 43 0f 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fffadeb0d88 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 000055a881dc2901 RCX: 00007f0750fefa12
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 000055a881dc3b70 R08: 0000000000000000 R09: 3c00000000001001
R10: 00007f0750eb5650 R11: 0000000000000246 R12: 000055a881dd0640
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90000007e38 EFLAGS: 00010046

RAX: 0000000080010000 RBX: ffff8880b982b9c0 RCX: ffffffff81767893
RDX: ffff888079589dc0 RSI: ffffffff817678a1 RDI: ffffc90004bcfd90
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000081 R11: ffffc90000007ff8 R12: ffff8880b982b940
R13: 0000000000000081 R14: ffffc90004bcfd90 R15: 0000000000000000
FS:  00007f0750eb5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000007b29c000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	18 4c 89 e7          	sbb    %cl,-0x19(%rcx,%rcx,4)
   4:	31 ed                	xor    %ebp,%ebp
   6:	e8 1c 49 de 08       	call   0x8de4927
   b:	eb e8                	jmp    0xfffffff5
   d:	48 89 df             	mov    %rbx,%rdi
  10:	e8 52 86 77 00       	call   0x778667
  15:	eb 9e                	jmp    0xffffffb5
  17:	f3 0f 1e fa          	endbr64
  1b:	41 54                	push   %r12
  1d:	49 89 d4             	mov    %rdx,%r12
  20:	55                   	push   %rbp
  21:	48 89 f5             	mov    %rsi,%rbp
  24:	be 98 00 00 00       	mov    $0x98,%esi
  29:	53                   	push   %rbx
* 2a:	48 89 fb             	mov    %rdi,%rbx <-- trapping instruction
  2d:	e8 45 c9 00 00       	call   0xc977
  32:	48 8d 7b 70          	lea    0x70(%rbx),%rdi
  36:	45 31 c9             	xor    %r9d,%r9d
  39:	31 c9                	xor    %ecx,%ecx
  3b:	6a 00                	push   $0x0
  3d:	4c 89 e2             	mov    %r12,%rdx


Tested on:

commit:         6bc40e44 Merge tag 'ovl-fixes-6.7-rc2' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12241877680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50e80fa8ba9f1bd4
dashboard link: https://syzkaller.appspot.com/bug?extid=3779764ddb7a3e19437f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
