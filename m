Return-Path: <linux-kernel+bounces-109367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2788181C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FF728367C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818BF85654;
	Wed, 20 Mar 2024 19:48:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CA69DF4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710964086; cv=none; b=kZDvM2eXFVQHUud/PPDLuJTwrN88Q0QLkcfB5dUlHENu1swAyBsd0toc/RnzL4k0MH74oS1qLE0ORVMB6dFy4e4NRMZbc0/fNqB5CzcWwLvSMVfSR0DUJuDENDfvqhOPWtMysY2KkBZLkkR1CaOR4B4KG32ssFMMrDZx6+Ml/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710964086; c=relaxed/simple;
	bh=jIKqUI0atmf08ev3retf3pI8I/wQuCDA3whygpPCPRc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LfWtPB9RLJEfBKVH0Ajb40JEyzFRQVgEwFgMJMveeY1wUxWkeUlzTGbg5wCSaule7neULTmBmiSYs9RCg+DRocC5PlTVNH4j86i6CSmJ4myRDn3hUf3eQjXoJE0k0UzIF+kwRU6PvDLGCrGc+LKd7ScD2mT8p6abpi3DimSUp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36683ec010eso2520855ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964083; x=1711568883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2Eug9SrzzmlrPTPCfc9SE50t5XyHMQwWhVRR1cHnNY=;
        b=bDkrS/ge1H2PQyFwiT0iEv3JVSCTTev6f2AHfFn1t+SPTIQTfN0S1zshDKafjLYjOU
         3uOEUcxE9rT6rfhaLnYqKUHU2I6ZYsuM7t+K1/RSq0cuE06jsS8f6vAyF7UiXI6D2P6c
         RMiae+JxNAwtXrSEHacdXYPiJaJPyhy/vLsjO95PzMhzUMcH4c4tpxZqSo3l8EBcLkUq
         MImF+k4EvTN7bxz5wKBJaBnYZMGPVNkYSAHXofAhBSiiIwBlKyoXUEGpJoe49PUbR0mk
         ClC5l8d7+3ZHmn9xOS9mnu7UpWTTfX95cNHab8QAMPdkfDKwe7Uk9147zhdmJIeJiWfR
         bdDA==
X-Forwarded-Encrypted: i=1; AJvYcCWquK8Sg54sjiUuJMbE/26C0BHWwWiV0Y5pLdN3nzNT5eEUEHoSsPlBoTyivZ0zV/kboP/EBY5Ut0cHbpwnVP9RLESJHdjLbLWO4nXI
X-Gm-Message-State: AOJu0Yxvnh7Sl1uw0s2bh6Y8rz9jfpJ6mZKHXLi+/U3ZrV6o1lbai5hC
	cqQNdlBeHOL34OmlgaGZ/xhnj3D6DfUT4BeshsJwmsLFoQIiFgzfcIW2RMbCAjKOdNvwSmYdOvu
	aObYbFhVvUtf3y8gtMz9FCozWIyOB/Xy8Szi+bBvm6PjeyVWujXyhmLE=
X-Google-Smtp-Source: AGHT+IGFus/YRpLjuAnHs1y1bqw9mLu56coSdABoV4HOHooxDbLlkeHbdmx2uYIHZ1U2+yc5UZFestdMHZNqlXBSHJcvHiQK8fys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4ae:b0:367:82e8:25e with SMTP id
 e14-20020a056e0204ae00b0036782e8025emr318418ils.0.1710964083557; Wed, 20 Mar
 2024 12:48:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 12:48:03 -0700
In-Reply-To: <20240320105538.2238-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ca87006141cde44@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in hrtimer_run_queues
From: syzbot <syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hrtimer_run_queues

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05221-gea80e3ed09ab-dirty #0 Not tainted
-----------------------------------------------------
syz-executor.0/5423 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88805ae320f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940

and this task is already holding:
ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
which would create a new lock dependency:
 (hrtimer_bases.lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (hrtimer_bases.lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  hrtimer_run_queues+0x18e/0x460 kernel/time/hrtimer.c:1922
  run_local_timers kernel/time/timer.c:2453 [inline]
  update_process_times+0x80/0x230 kernel/time/timer.c:2475
  tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
  tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
  timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
  handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  console_flush_all+0x9cd/0xec0
  console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
  vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
  _printk+0xd5/0x120 kernel/printk/printk.c:2317
  cpu_detect_tlb arch/x86/kernel/cpu/common.c:864 [inline]
  identify_boot_cpu+0xae/0xe0 arch/x86/kernel/cpu/common.c:1934
  arch_cpu_finalize_init+0x9/0xa0 arch/x86/kernel/cpu/common.c:2310
  start_kernel+0x402/0x500 init/main.c:1043
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
                               lock(hrtimer_bases.lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(hrtimer_bases.lock);

 *** DEADLOCK ***

2 locks held by syz-executor.0/5423:
 #0: ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
 #0: ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (hrtimer_bases.lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    hrtimer_run_queues+0x18e/0x460 kernel/time/hrtimer.c:1922
                    run_local_timers kernel/time/timer.c:2453 [inline]
                    update_process_times+0x80/0x230 kernel/time/timer.c:2475
                    tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
                    tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
                    timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
                    __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                    handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    console_flush_all+0x9cd/0xec0
                    console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
                    vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
                    _printk+0xd5/0x120 kernel/printk/printk.c:2317
                    cpu_detect_tlb arch/x86/kernel/cpu/common.c:864 [inline]
                    identify_boot_cpu+0xae/0xe0 arch/x86/kernel/cpu/common.c:1934
                    arch_cpu_finalize_init+0x9/0xa0 arch/x86/kernel/cpu/common.c:2310
                    start_kernel+0x402/0x500 init/main.c:1043
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    hrtimer_interrupt+0xfb/0x990 kernel/time/hrtimer.c:1799
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __sanitizer_cov_trace_switch+0x9d/0x120 kernel/kcov.c:341
                    unwind_next_frame+0x7be/0x2a00 arch/x86/kernel/unwind_orc.c:515
                    arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                    kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
                    poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
                    __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
                    kasan_slab_free include/linux/kasan.h:184 [inline]
                    slab_free_hook mm/slub.c:2121 [inline]
                    slab_free mm/slub.c:4299 [inline]
                    kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
                    put_signal_struct kernel/fork.c:964 [inline]
                    __put_task_struct+0x1cb/0x290 kernel/fork.c:979
                    put_task_struct include/linux/sched/task.h:138 [inline]
                    delayed_put_task_struct+0x115/0x2d0 kernel/exit.c:229
                    rcu_do_batch kernel/rcu/tree.c:2196 [inline]
                    rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    rmqueue_buddy mm/page_alloc.c:2740 [inline]
                    rmqueue mm/page_alloc.c:2905 [inline]
                    get_page_from_freelist+0x2dfd/0x3580 mm/page_alloc.c:3308
                    __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
                    __alloc_pages_node include/linux/gfp.h:238 [inline]
                    alloc_pages_node include/linux/gfp.h:261 [inline]
                    alloc_slab_page+0x5f/0x160 mm/slub.c:2190
                    allocate_slab mm/slub.c:2354 [inline]
                    new_slab+0x84/0x2f0 mm/slub.c:2407
                    ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
                    __slab_alloc mm/slub.c:3625 [inline]
                    __slab_alloc_node mm/slub.c:3678 [inline]
                    slab_alloc_node mm/slub.c:3850 [inline]
                    kmem_cache_alloc_node+0x248/0x380 mm/slub.c:3903
                    alloc_vmap_area+0x1c5/0x1c10 mm/vmalloc.c:1675
                    __get_vm_area_node+0x16e/0x370 mm/vmalloc.c:2667
                    __vmalloc_node_range+0x3df/0x14a0 mm/vmalloc.c:3352
                    alloc_thread_stack_node kernel/fork.c:309 [inline]
                    dup_task_struct+0x3e9/0x7d0 kernel/fork.c:1114
                    copy_process+0x5d1/0x3df0 kernel/fork.c:2219
                    kernel_clone+0x21e/0x8d0 kernel/fork.c:2796
                    user_mode_thread+0x132/0x1a0 kernel/fork.c:2874
                    call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:172
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
                   hrtimer_run_queues+0x18e/0x460 kernel/time/hrtimer.c:1922
                   run_local_timers kernel/time/timer.c:2453 [inline]
                   update_process_times+0x80/0x230 kernel/time/timer.c:2475
                   tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
                   tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
                   timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
                   __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
                   handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                   handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                   handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                   generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                   handle_irq arch/x86/kernel/irq.c:238 [inline]
                   __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
                   common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                   asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                   console_flush_all+0x9cd/0xec0
                   console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
                   vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
                   _printk+0xd5/0x120 kernel/printk/printk.c:2317
                   cpu_detect_tlb arch/x86/kernel/cpu/common.c:864 [inline]
                   identify_boot_cpu+0xae/0xe0 arch/x86/kernel/cpu/common.c:1934
                   arch_cpu_finalize_init+0x9/0xa0 arch/x86/kernel/cpu/common.c:2310
                   start_kernel+0x402/0x500 init/main.c:1043
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffff8880b942c8d8>] 0xffff8880b942c8d8

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
 }
 ... key      at: [<ffffffff94882300>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
   sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940
   bpf_prog_2c29ac5cdc6b1842+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
   trace_hrtimer_start include/trace/events/timer.h:222 [inline]
   debug_activate kernel/time/hrtimer.c:479 [inline]
   enqueue_hrtimer+0x335/0x3a0 kernel/time/hrtimer.c:1090
   __hrtimer_start_range_ns kernel/time/hrtimer.c:1265 [inline]
   hrtimer_start_range_ns+0xaa0/0xc60 kernel/time/hrtimer.c:1305
   hrtimer_start_expires include/linux/hrtimer.h:289 [inline]
   hrtimer_sleeper_start_expires kernel/time/hrtimer.c:1972 [inline]
   do_nanosleep+0x158/0x600 kernel/time/hrtimer.c:2048
   hrtimer_nanosleep+0x227/0x470 kernel/time/hrtimer.c:2104
   __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
   __se_sys_clock_nanosleep+0x32b/0x3c0 kernel/time/posix-timers.c:1373
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 1 PID: 5423 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-05221-gea80e3ed09ab-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_hrtimer_start include/trace/events/timer.h:222 [inline]
 debug_activate kernel/time/hrtimer.c:479 [inline]
 enqueue_hrtimer+0x335/0x3a0 kernel/time/hrtimer.c:1090
 __hrtimer_start_range_ns kernel/time/hrtimer.c:1265 [inline]
 hrtimer_start_range_ns+0xaa0/0xc60 kernel/time/hrtimer.c:1305
 hrtimer_start_expires include/linux/hrtimer.h:289 [inline]
 hrtimer_sleeper_start_expires kernel/time/hrtimer.c:1972 [inline]
 do_nanosleep+0x158/0x600 kernel/time/hrtimer.c:2048
 hrtimer_nanosleep+0x227/0x470 kernel/time/hrtimer.c:2104
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep+0x32b/0x3c0 kernel/time/posix-timers.c:1373
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fdd9baa91b5
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 b9 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f ba ff ff 48 8b 04 24 48 83 c4 28 f7 d8
RSP: 002b:00007ffce4219df0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000013 RCX: 00007fdd9baa91b5
RDX: 00007ffce4219e30 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffce4219ebc R08: 0000000000000000 R09: 00007fdd9c86d0b0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000001703f R14: 0000000000017038 R15: 0000000000000003
 </TASK>


Tested on:

commit:         ea80e3ed net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14c3ea6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f311e026553fee3459a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163fd231180000


