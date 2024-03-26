Return-Path: <linux-kernel+bounces-118807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3557B88BF94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592AD1C3E45A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DC535A3;
	Tue, 26 Mar 2024 10:32:29 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052F537F8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449148; cv=none; b=EqTEbeuA+u1S6/Ojsj5IdxqJuJ4gnoKIWjHY4j+y/X7ytRapex147qhdmkHNHjrR9DFfjuhtDp0g8I4ZSdHq1RbquVhDmpUhBM4Dg5a9sWb//kBqutRIRzSi/cGiJDNMI6MmxJsQ5FTIYWNJ/V1EgEKTyXaCkO2RKHFa7WZFDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449148; c=relaxed/simple;
	bh=N55DtoRKwASIB7KnjaQUL2lTncwUVei7IlPjiDuxtW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmsB8Q+bMOpbEb8vmI/Zdd66AHIBhuocU1McIceQ+TVYjt16cZ2nU2MD9KtPCCMNOsyVE/EARjn35WcAmJwuXMAZEnBqRuqiFHo7/oMSMhjqTxNvzhzObzzM+UCcY2VGxwFTobY6cJ6OAxUTmwkMhORLkC79b6nhD3RV+IPp03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.118])
	by sina.com (172.16.235.24) with ESMTP
	id 6602A42800001B0A; Tue, 26 Mar 2024 18:32:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 19513145089448
X-SMAIL-UIID: A6BFE9298A0D442783BCA42676583D37-20240326-183212-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bacb240dbeebb88518ae@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de,
	Boqun Feng <boqun.feng@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues (2)
Date: Tue, 26 Mar 2024 18:32:00 +0800
Message-Id: <20240326103200.2788-1-hdanton@sina.com>
In-Reply-To: <00000000000002a89b06146e6ecb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 24 Mar 2024 14:06:24 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b8bbb9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=bacb240dbeebb88518ae
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bacb240dbeebb88518ae@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> kswapd0/88 is trying to acquire lock:
> ffffffff8e126300 (console_owner){-...}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1997 [inline]
> ffffffff8e126300 (console_owner){-...}-{0:0}, at: vprintk_emit+0x3d6/0x770 kernel/printk/printk.c:2341
> 
> but task is already holding lock:
> ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: __run_hrtimer kernel/time/hrtimer.c:1696 [inline]
> ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_run_queues+0x65a/0xd00 kernel/time/hrtimer.c:1756
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>        lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
>        hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
>        rpm_suspend+0x12c2/0x1780 drivers/base/power/runtime.c:606
>        __pm_runtime_idle+0x131/0x1a0 drivers/base/power/runtime.c:1104
>        pm_runtime_put include/linux/pm_runtime.h:448 [inline]
>        __device_attach+0x3e5/0x520 drivers/base/dd.c:1048
>        bus_probe_device+0x189/0x260 drivers/base/bus.c:532
>        device_add+0x8ff/0xca0 drivers/base/core.c:3639
>        serdev_controller_add+0x83/0x660 drivers/tty/serdev/core.c:782
>        serdev_tty_port_register+0x163/0x260 drivers/tty/serdev/serdev-ttyport.c:302
>        tty_port_register_device_attr_serdev+0xe1/0x160 drivers/tty/tty_port.c:191
>        serial_core_add_one_port drivers/tty/serial/serial_core.c:3191 [inline]
>        serial_core_register_port+0xee0/0x1e30 drivers/tty/serial/serial_core.c:3398
>        serial8250_register_8250_port+0x1433/0x1cd0 drivers/tty/serial/8250/8250_core.c:1138
>        serial_pnp_probe+0x7d5/0xa20 drivers/tty/serial/8250/8250_pnp.c:478
>        pnp_device_probe+0x2bc/0x460 drivers/pnp/driver.c:111
>        really_probe+0x2a0/0xc50 drivers/base/dd.c:658
>        __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
>        driver_probe_device+0x50/0x430 drivers/base/dd.c:830
>        __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
>        bus_for_each_dev+0x23b/0x2b0 drivers/base/bus.c:368
>        bus_add_driver+0x347/0x620 drivers/base/bus.c:673
>        driver_register+0x23a/0x320 drivers/base/driver.c:246
>        serial8250_init+0x9e/0x170 drivers/tty/serial/8250/8250_core.c:1239
>        do_one_initcall+0x23a/0x830 init/main.c:1241
>        do_initcall_level+0x157/0x210 init/main.c:1303
>        do_initcalls+0x3f/0x80 init/main.c:1319
>        kernel_init_freeable+0x435/0x5d0 init/main.c:1550
>        kernel_init+0x1d/0x2a0 init/main.c:1439
>        ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> 
> -> #2 (&dev->power.lock){-...}-{2:2}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>        __pm_runtime_resume+0x112/0x180 drivers/base/power/runtime.c:1171
>        pm_runtime_get include/linux/pm_runtime.h:396 [inline]
>        __uart_start+0x17a/0x3c0 drivers/tty/serial/serial_core.c:148
>        uart_write+0x427/0x5c0 drivers/tty/serial/serial_core.c:615
>        process_output_block drivers/tty/n_tty.c:574 [inline]
>        n_tty_write+0xd6c/0x1230 drivers/tty/n_tty.c:2379
>        iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
>        file_tty_write+0x551/0x9b0 drivers/tty/tty_io.c:1096
>        call_write_iter include/linux/fs.h:2108 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0xa86/0xcb0 fs/read_write.c:590
>        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>        do_syscall_64+0xfd/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> -> #1 (&port_lock_key){-.-.}-{2:2}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>        uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
>        serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
>        console_emit_next_record kernel/printk/printk.c:2907 [inline]
>        console_flush_all+0x867/0xfd0 kernel/printk/printk.c:2973
>        console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
>        vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
>        _printk+0xd5/0x120 kernel/printk/printk.c:2367
>        register_console+0x70a/0xcd0 kernel/printk/printk.c:3548
>        univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:717
>        console_init+0x198/0x680 kernel/printk/printk.c:3694
>        start_kernel+0x2d3/0x500 init/main.c:1012
>        x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
>        x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
>        common_startup_64+0x13e/0x147
> 
> -> #0 (console_owner
> ){-...}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        console_trylock_spinning kernel/printk/printk.c:1997 [inline]
>        vprintk_emit+0x3f3/0x770 kernel/printk/printk.c:2341
>        _printk+0xd5/0x120 kernel/printk/printk.c:2367
>        __report_bug lib/bug.c:195 [inline]
>        report_bug+0x346/0x500 lib/bug.c:219
>        handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
>        exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
>        asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
>        __local_bh_disable_ip+0x1f6/0x220 kernel/softirq.c:307
>        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:125 [inline]
>        _raw_spin_lock_bh+0x1c/0x50 kernel/locking/spinlock.c:178
>        spin_lock_bh include/linux/spinlock.h:356 [inline]
>        __sock_map_delete net/core/sock_map.c:414 [inline]
>        sock_map_delete_elem+0x97/0x140 net/core/sock_map.c:446
>        bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
>        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>        __bpf_prog_run include/linux/filter.h:657 [inline]
>        bpf_prog_run include/linux/filter.h:664 [inline]
>        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>        bpf_trace_run4+0x25c/0x490 kernel/trace/bpf_trace.c:2422
>        trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
>        __alloc_pages+0x657/0x680 mm/page_alloc.c:4591
>        __alloc_pages_node include/linux/gfp.h:238 [inline]
>        alloc_pages_node include/linux/gfp.h:261 [inline]
>        alloc_slab_page+0x5f/0x160 mm/slub.c:2175
>        allocate_slab mm/slub.c:2338 [inline]
>        new_slab+0x84/0x2f0 mm/slub.c:2391
>        ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
>        __slab_alloc mm/slub.c:3610 [inline]
>        __slab_alloc_node mm/slub.c:3663 [inline]
>        slab_alloc_node mm/slub.c:3835 [inline]
>        kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
>        kmem_cache_zalloc include/linux/slab.h:739 [inline]
>        fill_pool lib/debugobjects.c:168 [inline]
>        debug_objects_fill_pool+0x52b/0x9b0 lib/debugobjects.c:615
>        debug_object_activate+0x135/0x510 lib/debugobjects.c:704
>        debug_hrtimer_activate kernel/time/hrtimer.c:423 [inline]
>        debug_activate kernel/time/hrtimer.c:478 [inline]
>        enqueue_hrtimer+0x30/0x3a0 kernel/time/hrtimer.c:1090
>        __run_hrtimer kernel/time/hrtimer.c:1709 [inline]
>        __hrtimer_run_queues+0x6b5/0xd00 kernel/time/hrtimer.c:1756
>        hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
>        local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
>        __sysvec_apic_timer_interrupt+0x109/0x3a0 arch/x86/kernel/apic/apic.c:1049
>        instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>        sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
>        asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
>        srso_safe_ret+0x0/0x20
>        srso_return_thunk+0x5/0x5f arch/x86/lib/retpoline.S:222
>        unwind_next_frame+0xc1/0x2a00 arch/x86/kernel/unwind_orc.c:479
>        __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
>        unwind_start arch/x86/include/asm/unwind.h:64 [inline]
>        arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
>        stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
>        kasan_save_stack mm/kasan/common.c:47 [inline]
>        kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>        unpoison_slab_object mm/kasan/common.c:312 [inline]
>        __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>        kasan_slab_alloc include/linux/kasan.h:201 [inline]
>        slab_post_alloc_hook mm/slub.c:3798 [inline]
>        slab_alloc_node mm/slub.c:3845 [inline]
>        kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
>        kmem_cache_zalloc include/linux/slab.h:739 [inline]
>        fill_pool lib/debugobjects.c:168 [inline]
>        debug_objects_fill_pool+0x4ec/0x9b0 lib/debugobjects.c:615
>        debug_object_activate+0x135/0x510 lib/debugobjects.c:704
>        debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
>        __call_rcu_common kernel/rcu/tree.c:2719 [inline]
>        call_rcu+0x97/0xa70 kernel/rcu/tree.c:2838
>        __dentry_kill+0x20d/0x630 fs/dcache.c:603
>        shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
>        shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
>        prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
>        super_cache_scan+0x34f/0x4b0 fs/super.c:221
>        do_shrink_slab+0x6d2/0x1140 mm/shrinker.c:435
>        shrink_slab+0x1092/0x14d0 mm/shrinker.c:662
>        shrink_one+0x423/0x7f0 mm/vmscan.c:4767
>        shrink_many mm/vmscan.c:4828 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4929 [inline]
>        shrink_node+0x37b8/0x3e70 mm/vmscan.c:5888
>        kswapd_shrink_node mm/vmscan.c:6696 [inline]
>        balance_pgdat mm/vmscan.c:6886 [inline]
>        kswapd+0x17d1/0x36e0 mm/vmscan.c:7146
>        kthread+0x2f2/0x390 kernel/kthread.c:388
>        ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   console_owner --> &dev->power.lock --> hrtimer_bases.lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(hrtimer_bases.lock);
>                                lock(&dev->power.lock);
>                                lock(hrtimer_bases.lock);
>   lock(console_owner);
> 
>  *** DEADLOCK ***
> 
> 6 locks held by kswapd0/88:
>  #0: ffffffff8e21f720
>  (fs_reclaim){+.+.}-{0:0}
> , at: balance_pgdat mm/vmscan.c:6774 [inline]
> , at: kswapd+0xb3f/0x36e0 mm/vmscan.c:7146
>  #1: 
> ffff88802f9d80e0 (&type->s_umount_key#52){.+.+}-{3:3}
> , at: super_trylock_shared fs/super.c:561 [inline]
> , at: super_cache_scan+0x94/0x4b0 fs/super.c:196
>  #2: ffffffff8e81bb40
>  (fill_pool_map-wait-type-override){+.+.}-{3:3}
> , at: debug_objects_fill_pool+0x80/0x9b0 lib/debugobjects.c:614
>  #3: ffff8880b952c8d8
>  (hrtimer_bases.lock){-.-.}-{2:2}
> , at: __run_hrtimer kernel/time/hrtimer.c:1696 [inline]
> , at: __hrtimer_run_queues+0x65a/0xd00 kernel/time/hrtimer.c:1756
>  #4: ffffffff8e81bb40
>  (fill_pool_map-wait-type-override){+.+.}-{3:3}
> , at: debug_objects_fill_pool+0x80/0x9b0 lib/debugobjects.c:614

Given nested acquiring of fill_pool_map-wait-type-override without
any lockdep warning triggered, could locking people shed light on the
sense it may make? IOW why is it needed?

Hillf

>  #5: ffffffff8e132020 (
> rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x490 kernel/trace/bpf_trace.c:2422

