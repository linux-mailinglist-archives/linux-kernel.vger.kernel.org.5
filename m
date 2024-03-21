Return-Path: <linux-kernel+bounces-110178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7433885B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6589E2850FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB28528F;
	Thu, 21 Mar 2024 14:51:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD291E534
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032665; cv=none; b=diL2+8YEm5y/swQtimhL3nbS2sDFiUj1FeRyeQ2GHo9KQ39vHij80qnQbOUu9cv1IRBEAHXhEt4E3nNo8EMzt7AhhewUuPnEJPBfyLfAFq/H6OvNX/Si7dmAULAQAEiRVpgjKQbEaKChGvvtIO0ISwhHEHTtDH/5IodWU06knfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032665; c=relaxed/simple;
	bh=Vb6hy/EsxfrNWlSdWCSPtxA03exJcQdOdoVErL5ZKmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T3bJJ611+6IrrRSdxcJjla483UeYhSmfTjvLCzMQaR3NZ//gFDRVdvRSLLZiD1og39ja1D0dyFPKHNZFzVk8Kn5PK0Aq/m2ZOBFIg/uq2GZg7YZHgLkQWeDfIuYB89OA7HkSnE4d83g2DibNA23xoOOaDaJGHvSyFcCt17dDuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so109010839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032663; x=1711637463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFYfsZV3iixOh7TVWS0a9B5ICUGDMPIWvpK1I+RzBuw=;
        b=IX86u2rQuvUOEkXNNixLEmA7AOHQTGZ35SDWV7vT4iBGNh4rHLRFp3XMquaT2hogdS
         TVwBie3StOYtiyIUIBDtBZRngDKpK6audOslGOPL7nF2l2vvcuekmp4cexSM0tkIkyaB
         quVw0pKPfgdKp0eRAU2zoBUBiqeCwxNshhC/L0ZGEwYpqaiuoHtU5UyWkQer7ipayYwE
         JE7HWud8EZBrNbALJN41wgYnyLcK3vI0ZFxGiYU5KEVJjKqh8Dmm9qIOPZK8yyIV618L
         dJDjV4wohFg+IfbCVQTl7+Zdg1Xb2/MZcEqdu/V0u7p9D5eyrusXj9tG9wcMjEr1so9v
         z7ew==
X-Forwarded-Encrypted: i=1; AJvYcCVMY5Yg6U0chNctN3TlxR7R6u72tl7PvEw7IEKEJ87di6UCHADCzkhUPn8tkZr78jALYYsb4tMZXwaLCxkJP/qR6+eaUpVs5BGifee8
X-Gm-Message-State: AOJu0YwrO5rt3Vk634W5Cxlr6Y/Wf6zuu177BWs9eLlSuMfCYWtsb/nW
	kLL/emHgULug4vKZ+64SG1AQaWb3mDFvPYJlmTxHQBmcCcnKPd7Q/MaAbUnvmSKuTRlLSmnnNIn
	3iYfMZGReAdJJ7l3dls110TD5iPGKqydYebGqyKnVJnwLcmxZYK2mc00=
X-Google-Smtp-Source: AGHT+IHpCK8Rf2X45860gKJ8fqEoUsSHHSFIIzPoZd9dxvD/aDVS4wzYO47BhmAMxBgDSsRILEIMfxn9SVK20KKqWSEowNdjMqmN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a4:b0:367:d6da:8dbd with SMTP id
 e4-20020a056e0204a400b00367d6da8dbdmr446586ils.4.1711032662980; Thu, 21 Mar
 2024 07:51:02 -0700 (PDT)
Date: Thu, 21 Mar 2024 07:51:02 -0700
In-Reply-To: <tencent_897431776767BA3D0B361296C236024BFC09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001388ec06142cd682@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in scheduler_tick (3)
From: syzbot <syzbot+628f63ef3b071e16463e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in scheduler_tick

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05231-ga51cd6bf8e10-dirty #0 Not tainted
-----------------------------------------------------
kworker/u8:5/1087 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88807d83c020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940

and this task is already holding:
ffff8880b943e158 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
which would create a new lock dependency:
 (&rq->__lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&rq->__lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
  raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
  rq_lock kernel/sched/sched.h:1699 [inline]
  scheduler_tick+0xa1/0x6e0 kernel/sched/core.c:5679
  update_process_times+0x202/0x230 kernel/time/timer.c:2481
  tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
  tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
  timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
  handle_level_irq+0x3c5/0x6e0 kernel/irq/chip.c:648
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  __setup_irq+0x1277/0x1cf0 kernel/irq/manage.c:1818
  request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2202
  request_irq include/linux/interrupt.h:168 [inline]
  setup_default_timer_irq+0x25/0x60 arch/x86/kernel/time.c:70
  x86_late_time_init+0x66/0xc0 arch/x86/kernel/time.c:94
  start_kernel+0x3f3/0x500 init/main.c:1039
  x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
  x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
  common_startup_64+0x13e/0x147

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_free+0x164/0x820 net/core/sock_map.c:1155
  bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&rq->__lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&rq->__lock);

 *** DEADLOCK ***

2 locks held by kworker/u8:5/1087:
 #0: ffff8880b943e158 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&rq->__lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                    raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
                    rq_lock kernel/sched/sched.h:1699 [inline]
                    scheduler_tick+0xa1/0x6e0 kernel/sched/core.c:5679
                    update_process_times+0x202/0x230 kernel/time/timer.c:2481
                    tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
                    tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
                    timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
                    __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                    handle_level_irq+0x3c5/0x6e0 kernel/irq/chip.c:648
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    __setup_irq+0x1277/0x1cf0 kernel/irq/manage.c:1818
                    request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2202
                    request_irq include/linux/interrupt.h:168 [inline]
                    setup_default_timer_irq+0x25/0x60 arch/x86/kernel/time.c:70
                    x86_late_time_init+0x66/0xc0 arch/x86/kernel/time.c:94
                    start_kernel+0x3f3/0x500 init/main.c:1039
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                    raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
                    rq_lock kernel/sched/sched.h:1699 [inline]
                    ttwu_queue kernel/sched/core.c:4055 [inline]
                    try_to_wake_up+0x7d3/0x1470 kernel/sched/core.c:4378
                    kick_pool+0x41b/0x5c0 kernel/workqueue.c:1284
                    __queue_work+0xc20/0xec0 kernel/workqueue.c:2401
                    call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
                    expire_timers kernel/time/timer.c:1838 [inline]
                    __run_timers kernel/time/timer.c:2408 [inline]
                    __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2419
                    run_timer_base kernel/time/timer.c:2428 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0x13/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x22f/0x5d0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
                    rest_init+0x2e0/0x300 init/main.c:730
                    arch_call_rest_init+0xe/0x10 init/main.c:831
                    start_kernel+0x47a/0x500 init/main.c:1077
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                   raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                   raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
                   _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1404 [inline]
                   rq_lock_irqsave kernel/sched/sched.h:1683 [inline]
                   rq_attach_root+0xee/0x540 kernel/sched/topology.c:494
                   sched_init+0x64e/0xc30 kernel/sched/core.c:10031
                   start_kernel+0x1ab/0x500 init/main.c:948
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff926c4080>] sched_init.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_free+0x164/0x820 net/core/sock_map.c:1155
                    bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940
                   0xffffffffa00060f6
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                   srcu_advance_state kernel/rcu/srcutree.c:1651 [inline]
                   process_srcu+0x6e/0x13a0 kernel/rcu/srcutree.c:1811
                   process_one_work kernel/workqueue.c:3254 [inline]
                   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                   kthread+0x2f0/0x390 kernel/kthread.c:388
                   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff94882300>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
   sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940
   bpf_prog_43221478a22f23b5+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
   trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
   __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
   pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
   queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
   do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
   raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
   raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
   rq_lock kernel/sched/sched.h:1699 [inline]
   __schedule+0x354/0x4a20 kernel/sched/core.c:6652
   __schedule_loop kernel/sched/core.c:6813 [inline]
   schedule+0x14b/0x320 kernel/sched/core.c:6828
   worker_thread+0xa2c/0xd70 kernel/workqueue.c:3431
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 0 PID: 1087 Comm: kworker/u8:5 Not tainted 6.8.0-syzkaller-05231-ga51cd6bf8e10-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue:  0x0 (ipv6_addrconf)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage kernel/locking/lockdep.c:2865 [inline]
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x4dc7/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940
 bpf_prog_43221478a22f23b5+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
 rq_lock kernel/sched/sched.h:1699 [inline]
 __schedule+0x354/0x4a20 kernel/sched/core.c:6652
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 worker_thread+0xa2c/0xd70 kernel/workqueue.c:3431
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         a51cd6bf arm64: bpf: fix 32bit unconditional bswap
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=127edef1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=628f63ef3b071e16463e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151c1531180000


