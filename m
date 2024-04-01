Return-Path: <linux-kernel+bounces-126486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5415989388C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B51D2817B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC12C129;
	Mon,  1 Apr 2024 07:07:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15974BE62
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955226; cv=none; b=urCU+41c+n5aSrQNIg38Tl1jKC0hV5gciFV5SNqGXDHqvVNvw/8Y+fk2kPJJ3SClXARt8CRss1od6NMW5MEF3g/2LT1tGcGKXamD+gKo/fQPShXxuJwV7Mq9STbeE9mR78weksiB2zUehoF2Y8gXbqfF9bQXMnQE2ak6t/lt380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955226; c=relaxed/simple;
	bh=Iwjz1lAFt3BdNE4dqWFd01iPi1Ota/0Yb2yrdWB0zG4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TJ3fCSqsKERZqc1EYSZcuUwiEDP+Yphx5WlCW8rOCH+HfR3WRSGLa4ehr1Jwow720Kz135Y+6umf7wmLJyeVW3JQpBNqVLWMURUzh7d0vGR0EJzZePYpvBL8gv2TKB4wQ7y7ow81RjRs9lvK7svipqMM7fMx6zOp2JLOTxe4MX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c88a694b46so333326339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 00:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711955223; x=1712560023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhZG9mr/Z9NNPJFFD+UCz8BOJ+GBmrGAg8I1iG03m+w=;
        b=eB5AljUnHBot1ybc9r9qAlW875hpfIeEMrlKoNJ4cOrYcm+JqpAx5Lh87y7zp2mNFl
         RUiIB6Vah/H+TV4vgJvmqC4OGDhIUftWzXlD63v2XLS5KCCPu2mgaS9U1cPSxL8W7Xo0
         Bs8TEeOfgSVh3OnDmX4OUIseZ5bCnJALmJD36kobiTi3eq1Qkwh77XGo7R6ifq1TRMBa
         pjBH0j3HgiIPpl6loLyQ24oKmEd5KrtgXSUEdt9EjmSQM+gdRAHqN7LWrn5bOJdP+c2F
         d4fv+3GhQX5EDCUtk/OUcW7gdnxDBG3EJ3dt4N5+gGZgOzpL1kyNgcSkQnyoLU4WErVK
         hARQ==
X-Gm-Message-State: AOJu0YwxJkkgJkmv4CqvcSt/aoHcbK4WZ5jnU29WSSbgqdKJ03ZjsY5e
	QuiIs/jP/1IKiyo9WucLoxY+NeIv4DQuyN/T+iProZDQSmhhwHHxtDTLUEr9ow4/NDJ4yt7nkV3
	4r1hJL0enu1Y7JqLAlEKvk8PZSOYLT7E8//0mfR0PbMJPSLmGT9DbSw1hKQ==
X-Google-Smtp-Source: AGHT+IEd5qcEFGy94J4nm1apc0tes7qlt6YhbAzZ8TtRQCa0ye/mDKBYgTmgFxVXZTzqwFot9TT7a3WwIz3zReTxbQhiTaEMUIbn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:350d:b0:366:9539:84dc with SMTP id
 bu13-20020a056e02350d00b00366953984dcmr608847ilb.0.1711955223212; Mon, 01 Apr
 2024 00:07:03 -0700 (PDT)
Date: Mon, 01 Apr 2024 00:07:03 -0700
In-Reply-To: <20240401064606.3240303-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f383f4061503a297@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in console_flush_all

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/5485 is trying to acquire lock:
ffffffff8d6bdea0 (console_owner){....}-{0:0}, at: console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
ffffffff8d6bdea0 (console_owner){....}-{0:0}, at: console_emit_next_record kernel/printk/printk.c:2901 [inline]
ffffffff8d6bdea0 (console_owner){....}-{0:0}, at: console_flush_all+0x4ff/0xd70 kernel/printk/printk.c:2973

but task is already holding lock:
ffff8880b953e698 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
       rq_lock kernel/sched/sched.h:1699 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12629
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4845
       copy_process+0x4106/0x9160 kernel/fork.c:2498
       kernel_clone+0xfd/0x940 kernel/fork.c:2796
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2874
       rest_init+0x27/0x2b0 init/main.c:695
       arch_call_rest_init+0x13/0x40 init/main.c:831
       start_kernel+0x3a3/0x490 init/main.c:1077
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
       common_startup_64+0x13e/0x148

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0x9a/0x13e0 kernel/sched/core.c:4262
       __wake_up_common+0x131/0x1e0 kernel/sched/wait.c:89
       __wake_up_common_lock kernel/sched/wait.c:106 [inline]
       __wake_up+0x31/0x60 kernel/sched/wait.c:127
       tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x55a/0x8b0 drivers/tty/serial/8250/8250_port.c:1835
       serial8250_handle_irq+0x5d3/0x780 drivers/tty/serial/8250/8250_port.c:1942
       serial8250_default_handle_irq+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:1962
       serial8250_interrupt+0x103/0x210 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x229/0x750 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
       handle_irq arch/x86/kernel/irq.c:238 [inline]
       __common_interrupt+0xde/0x250 arch/x86/kernel/irq.c:257
       common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
       _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inline]
       serial_port_runtime_resume+0x2b7/0x340 drivers/tty/serial/serial_port.c:41
       __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:394
       rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:448
       rpm_resume+0xcf9/0x12f0 drivers/base/power/runtime.c:914
       pm_runtime_work+0x10c/0x150 drivers/base/power/runtime.c:979
       process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
       process_scheduled_works kernel/workqueue.c:3335 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #2 (&tty->write_wait){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:105 [inline]
       __wake_up+0x1c/0x60 kernel/sched/wait.c:127
       tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x55a/0x8b0 drivers/tty/serial/8250/8250_port.c:1835
       serial8250_handle_irq+0x5d3/0x780 drivers/tty/serial/8250/8250_port.c:1942
       serial8250_default_handle_irq+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:1962
       serial8250_interrupt+0x103/0x210 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x229/0x750 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
       handle_irq arch/x86/kernel/irq.c:238 [inline]
       __common_interrupt+0xde/0x250 arch/x86/kernel/irq.c:257
       common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
       _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inline]
       serial_port_runtime_resume+0x2b7/0x340 drivers/tty/serial/serial_port.c:41
       __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:394
       rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:448
       rpm_resume+0xcf9/0x12f0 drivers/base/power/runtime.c:914
       pm_runtime_work+0x10c/0x150 drivers/base/power/runtime.c:979
       process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
       process_scheduled_works kernel/workqueue.c:3335 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
       serial8250_console_write+0xaa6/0x1090 drivers/tty/serial/8250/8250_port.c:3403
       console_emit_next_record kernel/printk/printk.c:2907 [inline]
       console_flush_all+0x53f/0xd70 kernel/printk/printk.c:2973
       console_unlock+0xae/0x290 kernel/printk/printk.c:3042
       vprintk_emit kernel/printk/printk.c:2342 [inline]
       vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
       vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2367
       register_console+0xa7b/0x1060 kernel/printk/printk.c:3548
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0xcc/0x5e0 kernel/printk/printk.c:3694
       start_kernel+0x259/0x490 init/main.c:1012
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
       common_startup_64+0x13e/0x148

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
       console_emit_next_record kernel/printk/printk.c:2901 [inline]
       console_flush_all+0x514/0xd70 kernel/printk/printk.c:2973
       console_unlock+0xae/0x290 kernel/printk/printk.c:3042
       vprintk_emit kernel/printk/printk.c:2342 [inline]
       vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
       vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2367
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x4ac/0x580 lib/bug.c:219
       handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
       spin_unlock_bh include/linux/spinlock.h:396 [inline]
       sock_hash_delete_elem+0x1f4/0x260 net/core/sock_map.c:947
       ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
       __bpf_trace_sched_switch+0x13e/0x190 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2266/0x5c70 kernel/sched/core.c:6733
       preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6915
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
       class_preempt_destructor include/linux/preempt.h:480 [inline]
       class_preempt_destructor include/linux/preempt.h:480 [inline]
       try_to_wake_up+0xc08/0x13e0 kernel/sched/core.c:4233
       wake_up_process kernel/sched/core.c:4510 [inline]
       wake_up_q+0x91/0x140 kernel/sched/core.c:1029
       futex_wake+0x43e/0x4e0 kernel/futex/waitwake.c:199
       do_futex+0x1e5/0x350 kernel/futex/syscalls.c:107
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex kernel/futex/syscalls.c:160 [inline]
       __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  console_owner --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(console_owner);

 *** DEADLOCK ***

4 locks held by syz-executor.0/5485:
 #0: ffff8880b953e698 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422
 #2: ffffffff8d79e2e0 (console_lock){+.+.}-{0:0}, at: vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 #3: ffffffff8d79e350 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:303 [inline]
 #3: ffffffff8d79e350 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #3: ffffffff8d79e350 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:286 [inline]
 #3: ffffffff8d79e350 (console_srcu){....}-{0:0}, at: console_flush_all+0x12d/0xd70 kernel/printk/printk.c:2965

stack backtrace:
CPU: 1 PID: 5485 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
 console_emit_next_record kernel/printk/printk.c:2901 [inline]
 console_flush_all+0x514/0xd70 kernel/printk/printk.c:2973
 console_unlock+0xae/0x290 kernel/printk/printk.c:3042
 vprintk_emit kernel/printk/printk.c:2342 [inline]
 vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2367
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x4ac/0x580 lib/bug.c:219
 handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Code: 00 e8 81 6c 0b 00 e8 9c 69 42 00 fb 65 8b 05 cc 34 b2 7e 85 c0 74 52 5b 5d c3 cc cc cc cc 65 8b 05 4e e9 b0 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 c3 67 42 00 eb 99 48 89 ef e8 49 e0 19 00 eb a2
RSP: 0018:ffffc900037a7600 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1f3d467
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff88cb2794
RBP: ffffffff88cb2794 R08: 0000000000000000 R09: ffffed100dab841c
R10: ffff88806d5c20e3 R11: ffffffff934716a8 R12: fffffffffffffffe
R13: ffff88806d5c20e0 R14: ffff88806d5c20d8 R15: 0000000023700e53
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1f4/0x260 net/core/sock_map.c:947
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
 __bpf_trace_sched_switch+0x13e/0x190 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2266/0x5c70 kernel/sched/core.c:6733
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6915
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 try_to_wake_up+0xc08/0x13e0 kernel/sched/core.c:4233
 wake_up_process kernel/sched/core.c:4510 [inline]
 wake_up_q+0x91/0x140 kernel/sched/core.c:1029
 futex_wake+0x43e/0x4e0 kernel/futex/waitwake.c:199
 do_futex+0x1e5/0x350 kernel/futex/syscalls.c:107
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1002a7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f100382d178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f1002babf88 RCX: 00007f1002a7dda9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f1002babf8c
RBP: 00007f1002babf80 R08: 0000000000000001 R09: 00007f100382d6c0
R10: 0000000000000005 R11: 0000000000000246 R12: 00007f1002babf8c
R13: 000000000000000b R14: 00007fff6da22fd0 R15: 00007fff6da230b8
 </TASK>
WARNING: CPU: 1 PID: 5485 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Modules linked in:
CPU: 1 PID: 5485 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Code: 00 e8 81 6c 0b 00 e8 9c 69 42 00 fb 65 8b 05 cc 34 b2 7e 85 c0 74 52 5b 5d c3 cc cc cc cc 65 8b 05 4e e9 b0 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 c3 67 42 00 eb 99 48 89 ef e8 49 e0 19 00 eb a2
RSP: 0018:ffffc900037a7600 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1f3d467
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff88cb2794
RBP: ffffffff88cb2794 R08: 0000000000000000 R09: ffffed100dab841c
R10: ffff88806d5c20e3 R11: ffffffff934716a8 R12: fffffffffffffffe
R13: ffff88806d5c20e0 R14: ffff88806d5c20d8 R15: 0000000023700e53
FS:  00007f100382d6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1002ba80c0 CR3: 000000007c110000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1f4/0x260 net/core/sock_map.c:947
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
 __bpf_trace_sched_switch+0x13e/0x190 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2266/0x5c70 kernel/sched/core.c:6733
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6915
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 try_to_wake_up+0xc08/0x13e0 kernel/sched/core.c:4233
 wake_up_process kernel/sched/core.c:4510 [inline]
 wake_up_q+0x91/0x140 kernel/sched/core.c:1029
 futex_wake+0x43e/0x4e0 kernel/futex/waitwake.c:199
 do_futex+0x1e5/0x350 kernel/futex/syscalls.c:107
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1002a7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f100382d178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f1002babf88 RCX: 00007f1002a7dda9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f1002babf8c
RBP: 00007f1002babf80 R08: 0000000000000001 R09: 00007f100382d6c0
R10: 0000000000000005 R11: 0000000000000246 R12: 00007f1002babf8c
R13: 000000000000000b R14: 00007fff6da22fd0 R15: 00007fff6da230b8
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10d4365e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=1dab15008502531a13d2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b605e5180000


