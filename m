Return-Path: <linux-kernel+bounces-108192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C99880749
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48BC1F2325D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE985F870;
	Tue, 19 Mar 2024 22:29:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE945FB8B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887362; cv=none; b=hDMc16t2BfjK7jKy4GNSZD5ONCfCtOR43GxSIpOlkKYnGXwtY8AccIXGruwniwO8QtwEO5mAD4bW7rj12ghJzcEPsFmzViOlo3d+4ivpcpLbXF3XtBMpmvqBSeYzFX3pkXewcOEN5kh0EdWvrO3VyRYyQPqINUgk19vw8xdHWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887362; c=relaxed/simple;
	bh=v3JQ5HCfxYlc5IWmLd+V4RX9z2cmrw6GoEPjPt9EG9c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tDtA4W1LwO1aDUWkA+ikd9FYCne9QrA4skckxFtC79q6hgESWYXhLpTeRyjLoROIoUBWLIzqIxX/6bZQiEk8YSqKyfNKpxjtfYI2ubQWCZBI6sBYi9PwQNQYSYDpMd8BnBrsVk8ijpJmes8qkVxUyhPrbV5YHwN3fHS8t6Po7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf092a502so485163039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710887359; x=1711492159;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8yMplJ5H27V7Saruh/8xYS7ccVNIag84FxZ6rZk7x8=;
        b=RSSFKiNyBWlV5fOYSASPFFGK+HIEHugrCNV5Iq/7z6oZN4jL8a4KRyXL4b+mYVuvcs
         DEqB2KNDP7N/qagWzYzAOcIG5br+3uQ+Ck20jMx0B8UEaMeLyRihUtbQGn5TJDwSai2i
         625Zg031HDG0gfxuVghlHU14nOxO2UPUTpoLQAQ1VTIMp7HEQJIUKvfUUmbXnQdMx+Zd
         D1sfaAbPe17qz0auO7GhnicerSU8HNbfsAk7i/w1TAjwQIGiOujQnNJ9SDUKMeUFFlMR
         dPJCrheO2jdb8mPMBLsfMxhpF4xfAWSwpfh8ulTkUyayVuvYG6yJ6GQXzxkRbqCWdCNb
         5sAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3NUaEK4xz8fQ0F4PgYp+AKy4yvLttCZdSJCYmvsF/AxGfzjkyU3dUJR2OMGiVXQx0xMlQLmEG1hHN9KqhiLCrrQn0SCWVx0YnR5Mg
X-Gm-Message-State: AOJu0YwYn8OylqZSoauZIbiEiWBHSWBDRA2nbpDcLQhA5EwwqMMiYxEq
	A4z0F3g1pNG8t2MGLNY0Otv+wFBw2LeHQxEZt9huGKS4wAO7Wp0OBaGSEDdJMHsDsKR/bgTjULi
	sp5IwhCyosleKourWRJZB2CWEdiFtd3Sv71E/jPjNDbPlC3leb9Ivzp4=
X-Google-Smtp-Source: AGHT+IHJuUwoYQGzSzU6Aow7Wm/wdqMmMh9tByF/cu0e4ouAJp5XpIeqKlrUo9fTd8jVHUxnRvyKbMWzheUAWP6iMHut/wctEXxK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc2:b0:7c8:b551:b219 with SMTP id
 fc2-20020a0566023fc200b007c8b551b219mr289138iob.3.1710887359146; Tue, 19 Mar
 2024 15:29:19 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:29:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b02a206140b016b@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in hrtimer_run_queues
From: syzbot <syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea80e3ed09ab net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=149c06a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f311e026553fee3459a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1292e1a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c64e31180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c6c49a7ef5c/disk-ea80e3ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/242942b30f2d/vmlinux-ea80e3ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74dcc2059655/bzImage-ea80e3ed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f311e026553fee3459a0@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05221-gea80e3ed09ab #0 Not tainted
-----------------------------------------------------
syz-executor294/5060 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88802abb60f8 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802abb60f8 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

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
  __rdmsr arch/x86/include/asm/msr.h:86 [inline]
  native_read_msr arch/x86/include/asm/msr.h:133 [inline]
  __mcheck_cpu_cap_init arch/x86/kernel/cpu/mce/core.c:1770 [inline]
  mcheck_cpu_init+0x176/0x1200 arch/x86/kernel/cpu/mce/core.c:2225
  identify_cpu+0x1939/0x3280 arch/x86/kernel/cpu/common.c:1889
  identify_boot_cpu+0xd/0xe0 arch/x86/kernel/cpu/common.c:1928
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
  sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
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

2 locks held by syz-executor294/5060:
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
                    __rdmsr arch/x86/include/asm/msr.h:86 [inline]
                    native_read_msr arch/x86/include/asm/msr.h:133 [inline]
                    __mcheck_cpu_cap_init arch/x86/kernel/cpu/mce/core.c:1770 [inline]
                    mcheck_cpu_init+0x176/0x1200 arch/x86/kernel/cpu/mce/core.c:2225
                    identify_cpu+0x1939/0x3280 arch/x86/kernel/cpu/common.c:1889
                    identify_boot_cpu+0xd/0xe0 arch/x86/kernel/cpu/common.c:1928
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
                    __sanitizer_cov_trace_switch+0x90/0x120
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
                    kfree+0x14a/0x380 mm/slub.c:4409
                    security_cred_free+0xbc/0x100 security/security.c:3031
                    put_cred_rcu+0x69/0x2e0 kernel/cred.c:78
                    rcu_do_batch kernel/rcu/tree.c:2196 [inline]
                    rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    unwind_next_frame+0x56/0x2a00 arch/x86/kernel/unwind_orc.c:470
                    arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                    unpoison_slab_object mm/kasan/common.c:312 [inline]
                    __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
                    kasan_slab_alloc include/linux/kasan.h:201 [inline]
                    slab_post_alloc_hook mm/slub.c:3813 [inline]
                    slab_alloc_node mm/slub.c:3860 [inline]
                    kmem_cache_alloc_node+0x192/0x380 mm/slub.c:3903
                    scsi_mq_init_request+0x5a/0x2b0 drivers/scsi/scsi_lib.c:1817
                    blk_mq_init_request block/blk-mq.c:3378 [inline]
                    blk_mq_alloc_rqs block/blk-mq.c:3448 [inline]
                    blk_mq_alloc_map_and_rqs+0x697/0x970 block/blk-mq.c:3803
                    __blk_mq_alloc_map_and_rqs block/blk-mq.c:3821 [inline]
                    __blk_mq_alloc_rq_maps block/blk-mq.c:4320 [inline]
                    blk_mq_alloc_set_map_and_rqs+0x19c/0x830 block/blk-mq.c:4351
                    blk_mq_alloc_tag_set+0x7b4/0xf40 block/blk-mq.c:4523
                    scsi_add_host_with_dma+0x2a6/0xbe0 drivers/scsi/hosts.c:254
                    scsi_add_host include/scsi/scsi_host.h:783 [inline]
                    virtscsi_probe+0x8a9/0xf60 drivers/scsi/virtio_scsi.c:980
                    virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
                    really_probe+0x29e/0xc50 drivers/base/dd.c:658
                    __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
                    driver_probe_device+0x50/0x430 drivers/base/dd.c:830
                    __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
                    bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
                    bus_add_driver+0x347/0x620 drivers/base/bus.c:673
                    driver_register+0x23a/0x320 drivers/base/driver.c:246
                    virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
                    do_one_initcall+0x238/0x830 init/main.c:1241
                    do_initcall_level+0x157/0x210 init/main.c:1303
                    do_initcalls+0x3f/0x80 init/main.c:1319
                    kernel_init_freeable+0x435/0x5d0 init/main.c:1557
                    kernel_init+0x1d/0x2a0 init/main.c:1446
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
                   __rdmsr arch/x86/include/asm/msr.h:86 [inline]
                   native_read_msr arch/x86/include/asm/msr.h:133 [inline]
                   __mcheck_cpu_cap_init arch/x86/kernel/cpu/mce/core.c:1770 [inline]
                   mcheck_cpu_init+0x176/0x1200 arch/x86/kernel/cpu/mce/core.c:2225
                   identify_cpu+0x1939/0x3280 arch/x86/kernel/cpu/common.c:1889
                   identify_boot_cpu+0xd/0xe0 arch/x86/kernel/cpu/common.c:1928
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
                    sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
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
                   sock_hash_free+0x164/0x820 net/core/sock_map.c:1154
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
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
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
CPU: 1 PID: 5060 Comm: syz-executor294 Not tainted 6.8.0-syzkaller-05221-gea80e3ed09ab #0
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
RIP: 0033:0x7f3db8d876b3
Code: 00 00 00 00 0f 1f 00 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d ce e9 03 00 00 74 14 b8 e6 00 00 00 0f 05 <f7> d8 c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10
RSP: 002b:00007ffeab7b0778 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00000000000013c7 RCX: 00007f3db8d876b3
RDX: 00007ffeab7b0790 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000dd4e R08: 0000000000000010 R09: 00007f3db8d0d0b0
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffeab7b07cc
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

