Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC297EDF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjKPLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjKPLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:09:32 -0500
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ECBAA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:09:28 -0800 (PST)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-282dcfbcc0aso721032a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132968; x=1700737768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeyI+YW2BMwy1X1u6r1IRHRQqS0zloOyPtT4aMQY910=;
        b=Pnj8uWxC3Ij6WZLkRY91MgmayUWuCuvC9DZ2kVgu/tqDDslu8lJmpXmVqI/aXQ5ULP
         O7lGnoj3RSuqw84Wes6TYRuLBrN4uT7k85Wfzql4L1aI6iWyVjrUnOAhcbmyIscAeTyS
         Wv/rZDQuvbjom0+VEKQtI5qbAuAsVEUuQ7CzG9fn166Ao/XzAjOVxcbZvdWcAvNewm9c
         8+vnvtRPSwbkGoyZAbx1VRV1qk6pVJug9XmC1faKmoUmy24cApi4nPF9b9c4ftNbTz+I
         fOkuU4cZagU8oYM5Olkw6xqXBrSoT5abrin8SobkFSS6PFuoFDdOwrUCWsWKx2Mq1wCc
         lG1g==
X-Gm-Message-State: AOJu0Yw7yxYstz0j1s/Yj+XDFQKbuSWxW4boiDtaGYrmBAzhNS3LylHS
        Hmbl13ckiRwwpEBFJ40I8CBUTu2yL7V/uF5xG3LKuR6XfpMOY1qzEA==
X-Google-Smtp-Source: AGHT+IH/B4+Y3iyKwVcOkWx57AasNx/k1WZNMCZc2MR7U7FE7+q/Bg7AKoKNIj9zjOsJH02uk/lpwkGJ+JLoDsumqdCoQBeBsW0S
MIME-Version: 1.0
X-Received: by 2002:a17:90b:1843:b0:281:37ae:df69 with SMTP id
 mf3-20020a17090b184300b0028137aedf69mr4565874pjb.4.1700132968093; Thu, 16 Nov
 2023 03:09:28 -0800 (PST)
Date:   Thu, 16 Nov 2023 03:09:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a25ea7060a430d3c@google.com>
Subject: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
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

Hello,

syzbot found the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112158fb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

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
syz-executor.1/5657 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff88807ba4a518 (&sighand->siglock){?.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807ba4a518 (&sighand->siglock){?.-.}-{2:2}, at: class_spinlock_constructor include/linux/spinlock.h:530 [inline]
ffff88807ba4a518 (&sighand->siglock){?.-.}-{2:2}, at: ptrace_set_stopped kernel/ptrace.c:391 [inline]
ffff88807ba4a518 (&sighand->siglock){?.-.}-{2:2}, at: ptrace_attach+0x401/0x650 kernel/ptrace.c:478
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
  lock_acquire+0x1f2/0x530 kernel/locking/lockdep.c:5721
  rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
  rcu_read_lock include/linux/rcupdate.h:747 [inline]
  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
  batadv_nc_worker+0x16e/0x10e0 net/batman-adv/network-coding.c:719
  process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2636
  process_scheduled_works kernel/workqueue.c:2709 [inline]
  worker_thread+0x8b6/0x1290 kernel/workqueue.c:2790
  kthread+0x2c1/0x3a0 kernel/kthread.c:388
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
irq event stamp: 1111
hardirqs last  enabled at (1111): [<ffffffff8a84a34e>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1111): [<ffffffff8a84a34e>] _raw_spin_unlock_irqrestore+0x4e/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (1110): [<ffffffff8a84a0fe>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1110): [<ffffffff8a84a0fe>] _raw_spin_lock_irqsave+0x4e/0x50 kernel/locking/spinlock.c:162
softirqs last  enabled at (1016): [<ffffffff81310072>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (1016): [<ffffffff81310072>] fpregs_unlock arch/x86/include/asm/fpu/api.h:80 [inline]
softirqs last  enabled at (1016): [<ffffffff81310072>] fpu_clone+0x342/0xb60 arch/x86/kernel/fpu/core.c:634
softirqs last disabled at (1014): [<ffffffff81310007>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (1014): [<ffffffff81310007>] fpregs_lock arch/x86/include/asm/fpu/api.h:72 [inline]
softirqs last disabled at (1014): [<ffffffff81310007>] fpu_clone+0x2d7/0xb60 arch/x86/kernel/fpu/core.c:630

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&sighand->siglock);
  <Interrupt>
    lock(&sighand->siglock);

 *** DEADLOCK ***

2 locks held by syz-executor.1/5657:
 #0: ffff888022a1e3c8 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: class_mutex_intr_constructor include/linux/mutex.h:225 [inline]
 #0: ffff888022a1e3c8 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: ptrace_attach+0x1eb/0x650 kernel/ptrace.c:455
 #1: ffffffff8cc0a098 (tasklist_lock){++++}-{2:2}, at: class_write_lock_constructor include/linux/spinlock.h:564 [inline]
 #1: ffffffff8cc0a098 (tasklist_lock){++++}-{2:2}, at: ptrace_attach+0x2c3/0x650 kernel/ptrace.c:464

stack backtrace:
CPU: 0 PID: 5657 Comm: syz-executor.1 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
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
RIP: 0033:0x7f390ac7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f390ba5a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 00007f390ad9c1f0 RCX: 00007f390ac7cae9
RDX: 0000000000000000 RSI: 000000000000005c RDI: 0000000000000010
RBP: 00007f390acc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f390ad9c1f0 R15: 00007ffe8ba90308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
