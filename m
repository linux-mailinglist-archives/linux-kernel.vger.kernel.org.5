Return-Path: <linux-kernel+bounces-110193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7254885B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F3D285BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D986241;
	Thu, 21 Mar 2024 15:04:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8A8565C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033447; cv=none; b=p7XNrXP/Uac+SwnB25UBSKUDSIy96EphhDzUa6eQ5UqFBUc3IMB+jreWHfC+PTAzMOnZeqimKSVqskYwvgOXy4ET1P75OiCIf39uqy28H3qQ1D6N9UC9iM/Lkm2CZ25Kfg8+HkWrCOG16al3JoawwKqcrGtBiDcB+dmZinE97pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033447; c=relaxed/simple;
	bh=9oMXf/1vXtIyiyUedrD3DUM3qt8Oncs3AJLV6K7yESE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bpN/isw++HLyT58FDDWS8nFfG6SpNgWwWWTTb2PU7tLja/bXjcncWGNcrcnCBW6trwM9UPZBzp2s6rtjCsYLxhh0BZM9orNzsabBBfJ0db0OSf2bbTSI4lm7jbJRQ9bKABbEwT/ZRLFqZsJ00VTBg3SvdbXrxBqqS9a2kb8d7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc74ea8606so103628639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033444; x=1711638244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tD8PyLq0PUsTuPRXHviH68ygNKPgjNhHZ49XGGTuN90=;
        b=FDr2hUKXlKtErKjzyEOw9EV8JqpUkfOE6Sp++b/eWwzxMEdh2oMt9PLYwGRNUJeF4l
         Dh2sHX9inTh7m1zm1EyemruS4D2EoY3EqLjkvNLBcz5bG19cNiJwH5hBYKXvANrBkfWH
         Lh13HRd1OQfpyJgoEBsinvK8WT/3nzwasr36MFmOHDnhAHDBVH7iciQhn1plBD/YOh1O
         UTSyWQP+bxZ9TS8WGKzMV0GGowYUQ0zNwvvCnDHKbogFkJEp5FioE60DM4wYfUxlx95z
         T1iJBV6iui0Eg7WWmAhYzvuhWjofipkNkhS5NQH5SEIA4135RmBA1NoCni3McpsqW4Id
         r2vA==
X-Forwarded-Encrypted: i=1; AJvYcCXtfyreu56HI1pnd+QYra2d9flEQYJFkctsJOjAo7YjcYFtD+icAHrD0WsOCvAGMrpoGskkbKNk1T5Po8NU7XWafdFDvWKna2Nd/8At
X-Gm-Message-State: AOJu0YyKDfOIQXjv7+G4u72MOEYqUYTom/97IIP4CQvWamqG2HMf8q/F
	V4zaxWqFNcg92TX5920Ufz+pAAy5G+Bl+S2XRQsZaeqk4rmvsObM/IzPo0nncouV4tZq2VMuvNT
	O33BOhve83knp/jtnelKFJtZsqj+frTOGqWnr9RmdH0J71aBMlzvcg3k=
X-Google-Smtp-Source: AGHT+IEjXrik8ORbsbJjBwRzpAnhcmgGgjjkGGsthxctStwy5FnFG3gb4pw5LxpbaoDT4YRw20p3+u0tXLZ7LG9hfwCimn1NBfRD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:360a:0:b0:366:9ead:645b with SMTP id
 d10-20020a92360a000000b003669ead645bmr449259ila.1.1711033444453; Thu, 21 Mar
 2024 08:04:04 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:04:04 -0700
In-Reply-To: <tencent_C086D8D2CB0650C9932EECAECC0CBFE7EB06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7e4fe06142d048c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in rcu_report_exp_cpu_mult
From: syzbot <syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in add_timer_on

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05231-ga51cd6bf8e10-dirty #0 Not tainted
-----------------------------------------------------
udevd/5417 [HC0[0]:SC1[1]:HE0:SE0] is trying to acquire:
ffff88806c3c9020 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940

and this task is already holding:
ffffffff94697d58 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
which would create a new lock dependency:
 (&obj_hash[i].lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+.-.}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&obj_hash[i].lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  debug_object_assert_init+0x164/0x440 lib/debugobjects.c:897
  debug_timer_assert_init kernel/time/timer.c:846 [inline]
  debug_assert_init kernel/time/timer.c:891 [inline]
  add_timer_on+0xc3/0x5c0 kernel/time/timer.c:1351
  handle_irq_event_percpu kernel/irq/handle.c:195 [inline]
  handle_irq_event+0xad/0x1f0 kernel/irq/handle.c:210
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
 (&htab->buckets[i].lock){+.-.}-{2:2}

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
                               lock(&obj_hash[i].lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&obj_hash[i].lock);

 *** DEADLOCK ***

5 locks held by udevd/5417:
 #0: ffff88802a208420 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff8880758002d0 (&type->i_mutex_dir_key#5){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff8880758002d0 (&type->i_mutex_dir_key#5){++++}-{3:3}, at: open_last_lookups fs/namei.c:3564 [inline]
 #1: ffff8880758002d0 (&type->i_mutex_dir_key#5){++++}-{3:3}, at: path_openat+0x7d3/0x3240 fs/namei.c:3797
 #2: ffffffff8e236790 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #2: ffffffff8e236790 (remove_cache_srcu){.+.+}-{0:0}, at: srcu_read_lock+0x24/0x50 include/linux/srcu.h:215
 #3: ffffffff94697d58 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #4: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&obj_hash[i].lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    debug_object_assert_init+0x164/0x440 lib/debugobjects.c:897
                    debug_timer_assert_init kernel/time/timer.c:846 [inline]
                    debug_assert_init kernel/time/timer.c:891 [inline]
                    add_timer_on+0xc3/0x5c0 kernel/time/timer.c:1351
                    handle_irq_event_percpu kernel/irq/handle.c:195 [inline]
                    handle_irq_event+0xad/0x1f0 kernel/irq/handle.c:210
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
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    debug_object_deactivate+0x158/0x390 lib/debugobjects.c:763
                    debug_timer_deactivate kernel/time/timer.c:841 [inline]
                    debug_deactivate kernel/time/timer.c:885 [inline]
                    detach_timer+0x24/0x300 kernel/time/timer.c:932
                    expire_timers kernel/time/timer.c:1826 [inline]
                    __run_timers kernel/time/timer.c:2408 [inline]
                    __run_timer_base+0x5ef/0x8e0 kernel/time/timer.c:2419
                    run_timer_base kernel/time/timer.c:2428 [inline]
                    run_timer_softirq+0x67/0x170 kernel/time/timer.c:2436
                    __do_softirq+0x2be/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    console_flush_all+0x9cd/0xec0
                    console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
                    vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
                    _printk+0xd5/0x120 kernel/printk/printk.c:2317
                    calibrate_delay+0x1597/0x16b0 init/calibrate.c:308
                    start_kernel+0x3fd/0x500 init/main.c:1041
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
 }
 ... key      at: [<ffffffff9466d4c0>] debug_objects_early_init.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+.-.}-{2:2} {
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
   IN-SOFTIRQ-W at:
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
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
                    _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
                    debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
                    debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
                    rcu_do_batch kernel/rcu/tree.c:2188 [inline]
                    rcu_core+0xa70/0x1830 kernel/rcu/tree.c:2471
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    _compound_head include/linux/page-flags.h:247 [inline]
                    virt_to_folio include/linux/mm.h:1294 [inline]
                    virt_to_slab mm/kasan/../slab.h:204 [inline]
                    qlink_to_cache+0x1c/0xb0 mm/kasan/quarantine.c:131
                    qlist_free_all+0x2e/0xc0 mm/kasan/quarantine.c:176
                    kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
                    __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
                    kasan_slab_alloc include/linux/kasan.h:201 [inline]
                    slab_post_alloc_hook mm/slub.c:3813 [inline]
                    slab_alloc_node mm/slub.c:3860 [inline]
                    kmem_cache_alloc_lru+0x175/0x350 mm/slub.c:3879
                    alloc_inode_sb include/linux/fs.h:3088 [inline]
                    shmem_alloc_inode+0x28/0x40 mm/shmem.c:4425
                    alloc_inode fs/inode.c:261 [inline]
                    new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
                    new_inode+0x22/0x1d0 fs/inode.c:1033
                    __shmem_get_inode mm/shmem.c:2477 [inline]
                    shmem_get_inode+0x34a/0xd40 mm/shmem.c:2548
                    shmem_mknod+0x5f/0x1d0 mm/shmem.c:3242
                    lookup_open fs/namei.c:3498 [inline]
                    open_last_lookups fs/namei.c:3567 [inline]
                    path_openat+0x1425/0x3240 fs/namei.c:3797
                    do_filp_open+0x235/0x490 fs/namei.c:3827
                    do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
                    do_sys_open fs/open.c:1422 [inline]
                    __do_sys_openat fs/open.c:1438 [inline]
                    __se_sys_openat fs/open.c:1433 [inline]
                    __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   sock_hash_delete_elem+0xb1/0x2f0 net/core/sock_map.c:940
                   0xffffffffa000556a
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                   tracepoint_probe_unregister+0x32/0x990 kernel/tracepoint.c:548
                   bpf_raw_tp_link_release+0x63/0x90 kernel/bpf/syscall.c:3482
                   bpf_link_free kernel/bpf/syscall.c:3033 [inline]
                   bpf_link_put_direct+0x123/0x1b0 kernel/bpf/syscall.c:3064
                   bpf_link_release+0x3b/0x50 kernel/bpf/syscall.c:3071
                   __fput+0x429/0x8a0 fs/file_table.c:423
                   __do_sys_close fs/open.c:1557 [inline]
                   __se_sys_close fs/open.c:1542 [inline]
                   __x64_sys_close+0x7f/0x110 fs/open.c:1542
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
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
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
   _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
   debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
   debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
   rcu_do_batch kernel/rcu/tree.c:2188 [inline]
   rcu_core+0xa70/0x1830 kernel/rcu/tree.c:2471
   __do_softirq+0x2bc/0x943 kernel/softirq.c:554
   invoke_softirq kernel/softirq.c:428 [inline]
   __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
   irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
   _compound_head include/linux/page-flags.h:247 [inline]
   virt_to_folio include/linux/mm.h:1294 [inline]
   virt_to_slab mm/kasan/../slab.h:204 [inline]
   qlink_to_cache+0x1c/0xb0 mm/kasan/quarantine.c:131
   qlist_free_all+0x2e/0xc0 mm/kasan/quarantine.c:176
   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
   kasan_slab_alloc include/linux/kasan.h:201 [inline]
   slab_post_alloc_hook mm/slub.c:3813 [inline]
   slab_alloc_node mm/slub.c:3860 [inline]
   kmem_cache_alloc_lru+0x175/0x350 mm/slub.c:3879
   alloc_inode_sb include/linux/fs.h:3088 [inline]
   shmem_alloc_inode+0x28/0x40 mm/shmem.c:4425
   alloc_inode fs/inode.c:261 [inline]
   new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
   new_inode+0x22/0x1d0 fs/inode.c:1033
   __shmem_get_inode mm/shmem.c:2477 [inline]
   shmem_get_inode+0x34a/0xd40 mm/shmem.c:2548
   shmem_mknod+0x5f/0x1d0 mm/shmem.c:3242
   lookup_open fs/namei.c:3498 [inline]
   open_last_lookups fs/namei.c:3567 [inline]
   path_openat+0x1425/0x3240 fs/namei.c:3797
   do_filp_open+0x235/0x490 fs/namei.c:3827
   do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
   do_sys_open fs/open.c:1422 [inline]
   __do_sys_openat fs/open.c:1438 [inline]
   __se_sys_openat fs/open.c:1433 [inline]
   __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 1 PID: 5417 Comm: udevd Not tainted 6.8.0-syzkaller-05231-ga51cd6bf8e10-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
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
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
 debug_rcu_head_unqueue kernel/rcu/rcu.h:236 [inline]
 rcu_do_batch kernel/rcu/tree.c:2188 [inline]
 rcu_core+0xa70/0x1830 kernel/rcu/tree.c:2471
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:_compound_head include/linux/page-flags.h:249 [inline]
RIP: 0010:virt_to_folio include/linux/mm.h:1294 [inline]
RIP: 0010:virt_to_slab mm/kasan/../slab.h:204 [inline]
RIP: 0010:qlink_to_cache+0x1c/0xb0 mm/kasan/quarantine.c:131
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 ab a3 49 ff 48 c1 e8 06 48 83 e0 c0 48 ba 00 00 00 00 00 ea ff ff 48 8b 4c 10 08 <f6> c1 01 75 44 48 01 d0 66 90 48 8b 48 08 f6 c1 01 75 65 66 90 48
RSP: 0018:ffffc90004c1f6d0 EFLAGS: 00000206
RAX: 0000000000ba42c0 RBX: ffff88802e90b300 RCX: ffffea0000ba4201
RDX: ffffea0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88801caa0780 R08: ffffffff8141ef1c R09: 1ffffffff2598ea5
R10: dffffc0000000000 R11: fffffbfff2598ea6 R12: 0000000000000000
R13: ffff88802e90b300 R14: ffffc90004c1f708 R15: 0000000000000000
 qlist_free_all+0x2e/0xc0 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_lru+0x175/0x350 mm/slub.c:3879
 alloc_inode_sb include/linux/fs.h:3088 [inline]
 shmem_alloc_inode+0x28/0x40 mm/shmem.c:4425
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 __shmem_get_inode mm/shmem.c:2477 [inline]
 shmem_get_inode+0x34a/0xd40 mm/shmem.c:2548
 shmem_mknod+0x5f/0x1d0 mm/shmem.c:3242
 lookup_open fs/namei.c:3498 [inline]
 open_last_lookups fs/namei.c:3567 [inline]
 path_openat+0x1425/0x3240 fs/namei.c:3797
 do_filp_open+0x235/0x490 fs/namei.c:3827
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2bc89169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcd2db6460 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f2bc89169a4
RDX: 0000000000080241 RSI: 00007ffcd2db69a8 RDI: 00000000ffffff9c
RBP: 00007ffcd2db69a8 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
R13: 000055cf24a9672e R14: 0000000000000001 R15: 000055cf24ab1160
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	e8 ab a3 49 ff       	call   0xff49a3be
  13:	48 c1 e8 06          	shr    $0x6,%rax
  17:	48 83 e0 c0          	and    $0xffffffffffffffc0,%rax
  1b:	48 ba 00 00 00 00 00 	movabs $0xffffea0000000000,%rdx
  22:	ea ff ff
  25:	48 8b 4c 10 08       	mov    0x8(%rax,%rdx,1),%rcx
* 2a:	f6 c1 01             	test   $0x1,%cl <-- trapping instruction
  2d:	75 44                	jne    0x73
  2f:	48 01 d0             	add    %rdx,%rax
  32:	66 90                	xchg   %ax,%ax
  34:	48 8b 48 08          	mov    0x8(%rax),%rcx
  38:	f6 c1 01             	test   $0x1,%cl
  3b:	75 65                	jne    0xa2
  3d:	66 90                	xchg   %ax,%ax
  3f:	48                   	rex.W


Tested on:

commit:         a51cd6bf arm64: bpf: fix 32bit unconditional bswap
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1797ba81180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c4f4d25859c2e5859988
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100f1d66180000


