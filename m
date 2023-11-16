Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4757EE802
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjKPUA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKPUAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:00:24 -0500
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C41A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:00:21 -0800 (PST)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-282d66095a4so1505356a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700164821; x=1700769621;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Bo5+gJAeoQtIG2dL3LcjICPrxOq52KxTsrLmLcJmNk=;
        b=sAEkgrgmG12Dv451QilIgxVp5wyczUceTqV1Js41pzrKBlZuyFBcyxKpHy+0J+Ts+D
         eBioBPn4onghPdD+jwJpuleWgSA1Ya36IutpcvhC5pCuey4kHLuGxyh2sCH5mRU7m3I/
         cFdmp6SM2uA32dA9e5NfTj1C85IZWwuPgAASbpa7XWzpC9OY2ZYcnnRR9JtnfpduJH9K
         0CLv3s1FP1K4A82vpkrv2JP5HfOZJr2LxtDBwb+TkxH17ZbhFG6yGvBmuuUN6rF5QA/G
         1JpHk9lObdSQqJYiSJO8Hg5iAR8V2XrvqcCVgSkyBj63cK4CXtZXUO0jU18tTXvaC/ex
         +RTw==
X-Gm-Message-State: AOJu0YxblqbVSsHHTFlTJHWPH5g9LXyoKteaQ1MsJtIvFtMcqiqP9l3v
        pk4fLHmP5o/LWY4BVJmm6tlfn7O723m7u27HkW8PmO6oNW7qZBCpFw==
X-Google-Smtp-Source: AGHT+IGg9Ql2xOlcWc1CGrGk0vJxqEZUjuAJj4Ru29QXyB+zF1OcqcVWYCeYPmXT2j2Ja+t3YPuxMLdVOqpBcioXST4jlhI0/kQn
MIME-Version: 1.0
X-Received: by 2002:a17:90b:240d:b0:27d:2233:d646 with SMTP id
 nr13-20020a17090b240d00b0027d2233d646mr4034797pjb.2.1700164820749; Thu, 16
 Nov 2023 12:00:20 -0800 (PST)
Date:   Thu, 16 Nov 2023 12:00:20 -0800
In-Reply-To: <000000000000a25ea7060a430d3c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003354b1060a4a7855@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
From:   syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168778a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e34b97680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c8aca7680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987488cb251e/disk-f31817cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d4a82d8bd4b/vmlinux-f31817cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc43dee9cb86/bzImage-f31817cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.7.0-rc1-next-20231116-syzkaller #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor207/5059 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff888025c41298 (&sighand->siglock){?...}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888025c41298 (&sighand->siglock){?...}-{2:2}, at: class_spinlock_constructor include/linux/spinlock.h:530 [inline]
ffff888025c41298 (&sighand->siglock){?...}-{2:2}, at: ptrace_set_stopped kernel/ptrace.c:391 [inline]
ffff888025c41298 (&sighand->siglock){?...}-{2:2}, at: ptrace_attach+0x401/0x650 kernel/ptrace.c:478
{IN-HARDIRQ-W} state was registered at:
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
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
  _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
  unlock_timer kernel/time/posix-timers.c:128 [inline]
  do_timer_settime+0x260/0x2f0 kernel/time/posix-timers.c:934
  __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
  __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
  __x64_sys_timer_settime+0x266/0x2c0 kernel/time/posix-timers.c:940
  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
  entry_SYSCALL_64_after_hwframe+0x62/0x6a
irq event stamp: 13807
hardirqs last  enabled at (13807): [<ffffffff8a84a34e>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (13807): [<ffffffff8a84a34e>] _raw_spin_unlock_irqrestore+0x4e/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (13806): [<ffffffff8a84a0fe>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (13806): [<ffffffff8a84a0fe>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (13794): [<ffffffff813146a1>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (13794): [<ffffffff813146a1>] fpregs_unlock arch/x86/include/asm/fpu/api.h:80 [inline]
softirqs last  enabled at (13794): [<ffffffff813146a1>] restore_fpregs_from_user arch/x86/kernel/fpu/signal.c:330 [inline]
softirqs last  enabled at (13794): [<ffffffff813146a1>] __fpu_restore_sig+0x6a1/0x13a0 arch/x86/kernel/fpu/signal.c:361
softirqs last disabled at (13792): [<ffffffff81314365>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (13792): [<ffffffff81314365>] fpregs_lock arch/x86/include/asm/fpu/api.h:72 [inline]
softirqs last disabled at (13792): [<ffffffff81314365>] restore_fpregs_from_user arch/x86/kernel/fpu/signal.c:284 [inline]
softirqs last disabled at (13792): [<ffffffff81314365>] __fpu_restore_sig+0x365/0x13a0 arch/x86/kernel/fpu/signal.c:361

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sighand->siglock);
  <Interrupt>
    lock(&sighand->siglock);

 *** DEADLOCK ***

2 locks held by syz-executor207/5059:
 #0: ffff88801d66e3c8 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: class_mutex_intr_constructor include/linux/mutex.h:225 [inline]
 #0: ffff88801d66e3c8 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: ptrace_attach+0x1eb/0x650 kernel/ptrace.c:455
 #1: ffffffff8cc0a098 (tasklist_lock){++++}-{2:2}, at: class_write_lock_constructor include/linux/spinlock.h:564 [inline]
 #1: ffffffff8cc0a098 (tasklist_lock){++++}-{2:2}, at: ptrace_attach+0x2c3/0x650 kernel/ptrace.c:464

stack backtrace:
CPU: 0 PID: 5059 Comm: syz-executor207 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3970 [inline]
 valid_state kernel/locking/lockdep.c:4012 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4215 [inline]
 mark_lock+0x91a/0xc50 kernel/locking/lockdep.c:4677
 mark_usage kernel/locking/lockdep.c:4586 [inline]
 __lock_acquire+0x919/0x3b10 kernel/locking/lockdep.c:5090
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
RIP: 0033:0x7f726faf87f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f726fab7158 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 00007f726fb7f328 RCX: 00007f726faf87f9
RDX: 0000000000000000 RSI: 00000000000013c4 RDI: 0000000000000010
RBP: 00007f726fb7f320 R08: 00007f726fab76c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f726fb7f32c
R13: 0000000000000000 R14: 00007ffd413eb1b0 R15: 00007ffd413eb298
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
