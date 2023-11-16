Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342A7EE2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjKPOc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKPOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:32:27 -0500
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E18130
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:32:23 -0800 (PST)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1cc40eb7d54so10611345ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145143; x=1700749943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqzVQ4H2nO+H1GNYedwQG5st1bgO2v+aLTv7Jww4d0c=;
        b=Rw+Z/sULzxLo2cdudao3ocupc1WVRfuFcJUsn0S3NSnoGCeLhblUc2Nv5V7TLBoAEw
         SVFlawyMIehcZpUd+c0O9vOY7VnZiuoEuVDCXtQj3S4C7kj+Q+EXEhGxgkg2qg7OKijL
         lrJaDRFNUY21S5r7Ej8DIFo0lBRoCaZ40LjFJ4HuLkbbsfkEYLDcjtjm3Vw3+ddz9Q1b
         hI+1wPqWCmafjJVSy2+/DVYWSexKey3euJRLbh9PvbdEtUz1/Nmd8qlvwOcBMNyXk5V+
         Q3BoeOAD1VdbQWWw3utihcEWUV14obAMZkFH1VZ0EHXCQ4FpDmfaBdDw2Fw/q/8JzTAX
         xKGQ==
X-Gm-Message-State: AOJu0YwduEqNFGEZQCAX58ijZ8n4flxnMPG7yySZU5+sNxHSnoBHNG3y
        lavcx5tqxrW2rytteKLRQh6XOMTWuwhh6N+WUG3jE91GfqktZbkZrg==
X-Google-Smtp-Source: AGHT+IH1ELvduB+lSQpK4f73bRl6tgJ2cOWXwBQ643ykVjIOqtGDofXVcFv9bgTli6gxKjzIuZ4OlQTpWAEM5CznleMN/x0pUfSI
MIME-Version: 1.0
X-Received: by 2002:a17:902:f7c5:b0:1cc:d08:605b with SMTP id
 h5-20020a170902f7c500b001cc0d08605bmr2128719plw.12.1700145143102; Thu, 16 Nov
 2023 06:32:23 -0800 (PST)
Date:   Thu, 16 Nov 2023 06:32:22 -0800
In-Reply-To: <0000000000009cd5bc060a430d80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000524433060a45e38d@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in __lock_task_sighand
From:   syzbot <syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10037920e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf93299f5a30fb4c3829
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13417498e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107bb4b7680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987488cb251e/disk-f31817cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d4a82d8bd4b/vmlinux-f31817cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc43dee9cb86/bzImage-f31817cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf93299f5a30fb4c3829@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.7.0-rc1-next-20231116-syzkaller #0 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
syz-executor325/5066 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff888027362e58 (&sighand->siglock){?.+.}-{2:2}, at: __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
{HARDIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5753 [inline]
  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  class_spinlock_constructor include/linux/spinlock.h:530 [inline]
  ptrace_set_stopped kernel/ptrace.c:391 [inline]
  ptrace_attach+0x401/0x650 kernel/ptrace.c:478
  __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a
irq event stamp: 1126
hardirqs last  enabled at (1125): [<ffffffff8a84a34e>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1125): [<ffffffff8a84a34e>] _raw_spin_unlock_irqrestore+0x4e/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (1126): [<ffffffff8a81011e>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1076
softirqs last  enabled at (1092): [<ffffffff8a84cf61>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (1092): [<ffffffff8a84cf61>] __do_softirq+0x591/0x8d5 kernel/softirq.c:582
softirqs last disabled at (1053): [<ffffffff814fe835>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last disabled at (1053): [<ffffffff814fe835>] __irq_exit_rcu kernel/softirq.c:632 [inline]
softirqs last disabled at (1053): [<ffffffff814fe835>] irq_exit_rcu+0xb5/0x120 kernel/softirq.c:644

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sighand->siglock);
  <Interrupt>
    lock(&sighand->siglock);

 *** DEADLOCK ***

3 locks held by syz-executor325/5066:
 #0: ffff88801c996038 (&new_timer->it_lock){-...}-{2:2}, at: posix_timer_fn+0x2d/0x3d0 kernel/time/posix-timers.c:318
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #1: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: send_sigqueue+0x10c/0x840 kernel/signal.c:1978
 #2: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #2: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #2: ffffffff8cfad060 (rcu_read_lock){....}-{1:2}, at: __lock_task_sighand+0x3f/0x340 kernel/signal.c:1405

stack backtrace:
CPU: 1 PID: 5066 Comm: syz-executor325 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3970 [inline]
 valid_state kernel/locking/lockdep.c:4012 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4215 [inline]
 mark_lock+0x91a/0xc50 kernel/locking/lockdep.c:4677
 mark_usage kernel/locking/lockdep.c:4563 [inline]
 __lock_acquire+0x1347/0x3b10 kernel/locking/lockdep.c:5090
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
 lock_task_sighand include/linux/sched/signal.h:748 [inline]
 send_sigqueue+0x1d4/0x840 kernel/signal.c:1996
 posix_timer_event kernel/time/posix-timers.c:298 [inline]
 posix_timer_fn+0x181/0x3d0 kernel/time/posix-timers.c:324
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x10c/0x410 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 f6 c8 e3 f6 48 89 df e8 ae 40 e4 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 65 ee d5 f6 65 8b 05 86 19 7f 75 85 c0 74 12 5b
RSP: 0018:ffffc90003aefd70 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff88801c996020 RCX: 1ffffffff1e315d1
RDX: 0000000000000000 RSI: ffffffff8accbfe0 RDI: ffffffff8b2f13e0
RBP: 0000000000000293 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f18e117 R11: 0000000000000002 R12: 0000000000000000
R13: 1ffff9200075dfb3 R14: ffffffff81789850 R15: dffffc0000000000
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_timer kernel/time/posix-timers.c:128 [inline]
 do_timer_settime+0x260/0x2f0 kernel/time/posix-timers.c:934
 __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
 __x64_sys_timer_settime+0x266/0x2c0 kernel/time/posix-timers.c:940
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f375844aa39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffefc2c0208 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f375844aa39
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007f37584bd5f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 f6 c8 e3 f6       	call   0xf6e3c909
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 ae 40 e4 f6       	call   0xf6e440c9
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 1f                	jne    0x42
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 2f                	jne    0x59
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 65 ee d5 f6       	call   0xf6d5ee99
  34:	65 8b 05 86 19 7f 75 	mov    %gs:0x757f1986(%rip),%eax        # 0x757f19c1
  3b:	85 c0                	test   %eax,%eax
  3d:	74 12                	je     0x51
  3f:	5b                   	pop    %rbx


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
