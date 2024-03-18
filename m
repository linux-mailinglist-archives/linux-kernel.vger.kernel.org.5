Return-Path: <linux-kernel+bounces-105941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4487E6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C58B21736
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE052D61B;
	Mon, 18 Mar 2024 10:07:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A828DD6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756442; cv=none; b=UonLgywhPYJ4JxSbS+w+Hm9KPm876eEyO+1gkEWjf0znlF8tXPpzSZowb1ppE8wbYDehkjK1tySq1wTvCAr9DuGUhFAVJMw3mCYiOumOrkNRQN4cZjcaecsKzrhJPtVHn/gHVUWTsDX5VALdnSHAt1a/aCo+y9M6v9qCWUZEtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756442; c=relaxed/simple;
	bh=EjMkd2M6lGsuViHkdiB7ZTNPNhWfWnemqc9FGbLRsIw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fZPpwX33WqXtrmbtfhoZKdN/8MhsDaSbObFfxSMIEohmGJnwCNVCwfuO60VMFpNJGXve1g1FCN9Yo/sKoY7FgTZ/LkmNDrm8K+985RXuW1azUdSsPCypu+WXHOTYyDHFmXKXaAbUf95qqaWCQEhlcHXcvQwG7vgjaAf8OmNxNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so328954339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756439; x=1711361239;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FC585+z9rtf/et2iK/Fy0sBYOLGj8S+AsLkhtaCYjxw=;
        b=jIug2aSQjYSPn9NZ6gZ2zXsBzmi9NltVYQyqQ8brcd4j1N8F7MEm4EHVVLmMBUsBaJ
         zXH4wBf3pxyhmgGM41Vvkd+WeUIpQI7chHkLg/UJkzLakpN8vo079fMi3GKgLvP1tMDm
         cFO7223b106pUoP6v9/TopQrcvFHmOjMfNICXFg0usc8iQtipHyvw16uWnP9yamLZ5wQ
         hp5Fkw7IEeoSG5TFFN38pAVcQINa46yrJUva//d+7inyI7t1IxeJynwXPS7BLNwNSz5I
         6jSEqFUtfgoCw4T4YYMusFUgIlc6yEEZ3wvU6eIX3XyK2YGjsnad/nPoyLbT32WhTRpJ
         SC7g==
X-Forwarded-Encrypted: i=1; AJvYcCWF8PUmArDxgQ1GdxTqLC3k6XzBNG2woSn20DqpPvuLyTtGJZID5J1FN6plvX9lACpNdXz+/2ilr3xPAviQBXUUPSGEVkq8ePTmHrWX
X-Gm-Message-State: AOJu0Ywc2GWOgJ1TA8G2EzGrAQ/1lOx0L8d2DD/bdZ5O55twMixBa60z
	mpBWnpocdeo8ZuI64fAhBi7PmxXnt2oqSVe11GTGEX5OF7u7/Tmm7TRtkK43fV4ICObZLfq62Qj
	t+dibIrto2iwpesjMWv13uYwtDVDI7/aehZtJGDC5oPJspY9n/nrsXWY=
X-Google-Smtp-Source: AGHT+IGDcDHryvjtevhCfL9Nnp2ZLFMB75+5jP/ZpdGfijEddOKvrWwVJdf9xL75BNYcU0+uT9xog3EQptVqZ7h0CqA07A9bkCMR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:366:b9b7:b2d2 with SMTP id
 x10-20020a056e021caa00b00366b9b7b2d2mr140771ill.5.1710756439295; Mon, 18 Mar
 2024 03:07:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 03:07:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc9aca0613ec855c@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in rcu_report_exp_cpu_mult
From: syzbot <syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, peterz@infradead.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea80e3ed09ab net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1249daa5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c4f4d25859c2e5859988
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fd8c81180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1795afc1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c6c49a7ef5c/disk-ea80e3ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/242942b30f2d/vmlinux-ea80e3ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74dcc2059655/bzImage-ea80e3ed.xz

The issue was bisected to:

commit ee042be16cb455116d0fe99b77c6bc8baf87c8c6
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Mar 22 18:57:09 2022 +0000

    locking: Apply contention tracepoints in the slow path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1702c2a5180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1482c2a5180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1082c2a5180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com
Fixes: ee042be16cb4 ("locking: Apply contention tracepoints in the slow path")

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05221-gea80e3ed09ab #0 Not tainted
-----------------------------------------------------
rcu_exp_gp_kthr/18 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
which would create a new lock dependency:
 (rcu_node_0){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (rcu_node_0){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  rcu_report_exp_cpu_mult+0x27/0x2f0 kernel/rcu/tree_exp.h:238
  csd_do_func kernel/smp.c:133 [inline]
  __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
  __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
  instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
  sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
  __sanitizer_cov_trace_switch+0x90/0x120
  update_event_printk kernel/trace/trace_events.c:2750 [inline]
  trace_event_eval_update+0x311/0xf90 kernel/trace/trace_events.c:2922
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
  0xffffffffa0001b0e
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
  trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
  __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
  futex_cleanup_begin kernel/futex/core.c:1091 [inline]
  futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
  exit_mm_release+0x1a/0x30 kernel/fork.c:1652
  exit_mm+0xb0/0x310 kernel/exit.c:542
  do_exit+0x99e/0x27e0 kernel/exit.c:865
  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
  __do_sys_exit_group kernel/exit.c:1038 [inline]
  __se_sys_exit_group kernel/exit.c:1036 [inline]
  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
  do_syscall_64+0xfb/0x240
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(rcu_node_0);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(rcu_node_0);

 *** DEADLOCK ***

2 locks held by rcu_exp_gp_kthr/18:
 #0: ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (rcu_node_0){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    rcu_report_exp_cpu_mult+0x27/0x2f0 kernel/rcu/tree_exp.h:238
                    csd_do_func kernel/smp.c:133 [inline]
                    __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
                    __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
                    instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
                    sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
                    asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
                    __sanitizer_cov_trace_switch+0x90/0x120
                    update_event_printk kernel/trace/trace_events.c:2750 [inline]
                    trace_event_eval_update+0x311/0xf90 kernel/trace/trace_events.c:2922
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
                    rcu_report_qs_rdp kernel/rcu/tree.c:2018 [inline]
                    rcu_check_quiescent_state kernel/rcu/tree.c:2100 [inline]
                    rcu_core+0x3ae/0x1830 kernel/rcu/tree.c:2455
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    unwind_next_frame+0x1d8e/0x2a00 arch/x86/kernel/unwind_orc.c:665
                    arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    save_stack+0xfb/0x1f0 mm/page_owner.c:129
                    __set_page_owner+0x29/0x380 mm/page_owner.c:195
                    set_page_owner include/linux/page_owner.h:31 [inline]
                    post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
                    prep_new_page mm/page_alloc.c:1540 [inline]
                    get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
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
                    kmalloc_trace+0x267/0x360 mm/slub.c:4007
                    kmalloc include/linux/slab.h:590 [inline]
                    kzalloc include/linux/slab.h:711 [inline]
                    ddebug_add_module+0x88/0x800 lib/dynamic_debug.c:1240
                    dynamic_debug_init+0x205/0x5a0 lib/dynamic_debug.c:1446
                    do_one_initcall+0x238/0x830 init/main.c:1241
                    do_pre_smp_initcalls+0x57/0xa0 init/main.c:1347
                    kernel_init_freeable+0x40d/0x5d0 init/main.c:1546
                    kernel_init+0x1d/0x2a0 init/main.c:1446
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   rcutree_prepare_cpu+0x71/0x640 kernel/rcu/tree.c:4484
                   rcu_init+0x9b/0x140 kernel/rcu/tree.c:5224
                   start_kernel+0x1f7/0x500 init/main.c:969
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff945012e0>] rcu_init_one.rcu_node_class+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
                    0xffffffffa0001b0e
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                    trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                    __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                    __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                    futex_cleanup_begin kernel/futex/core.c:1091 [inline]
                    futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
                    exit_mm_release+0x1a/0x30 kernel/fork.c:1652
                    exit_mm+0xb0/0x310 kernel/exit.c:542
                    do_exit+0x99e/0x27e0 kernel/exit.c:865
                    do_group_exit+0x207/0x2c0 kernel/exit.c:1027
                    __do_sys_exit_group kernel/exit.c:1038 [inline]
                    __se_sys_exit_group kernel/exit.c:1036 [inline]
                    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
                   0xffffffffa0001b0e
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                   futex_cleanup_begin kernel/futex/core.c:1091 [inline]
                   futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
                   exit_mm_release+0x1a/0x30 kernel/fork.c:1652
                   exit_mm+0xb0/0x310 kernel/exit.c:542
                   do_exit+0x99e/0x27e0 kernel/exit.c:865
                   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
                   __do_sys_exit_group kernel/exit.c:1038 [inline]
                   __se_sys_exit_group kernel/exit.c:1036 [inline]
                   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff94882300>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
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
   sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
   synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
   synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
   rcu_exp_wait_wake kernel/rcu/tree_exp.h:641 [inline]
   rcu_exp_sel_wait_wake+0x628/0x1df0 kernel/rcu/tree_exp.h:675
   kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 18 Comm: rcu_exp_gp_kthr Not tainted 6.8.0-syzkaller-05221-gea80e3ed09ab #0
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
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
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
 sync_rcu_exp_done_unlocked+0xe/0x140 kernel/rcu/tree_exp.h:169
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
 rcu_exp_wait_wake kernel/rcu/tree_exp.h:641 [inline]
 rcu_exp_sel_wait_wake+0x628/0x1df0 kernel/rcu/tree_exp.h:675
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 18 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 18 Comm: rcu_exp_gp_kthr Not tainted 6.8.0-syzkaller-05221-gea80e3ed09ab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 9e 69 01 04 00 74 06 90 c3 cc cc cc cc c6 05 8f 69 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 e5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000177bb8 EFLAGS: 00010246
RAX: bd04dc17ab040900 RBX: 1ffff9200002ef7c RCX: ffff8880172c1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000177c48 R08: ffffffff8157cc12 R09: 1ffff9200002eecc
R10: dffffc0000000000 R11: fffff5200002eecd R12: dffffc0000000000
R13: 1ffff9200002ef78 R14: ffffc90000177be0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6d95bcb0d0 CR3: 000000002098e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
 sync_rcu_exp_done_unlocked+0xdb/0x140 kernel/rcu/tree_exp.h:171
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
 rcu_exp_wait_wake kernel/rcu/tree_exp.h:641 [inline]
 rcu_exp_sel_wait_wake+0x628/0x1df0 kernel/rcu/tree_exp.h:675
 kthread_worker_fn+0x4bf/0xab0 kernel/kthread.c:841
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

