Return-Path: <linux-kernel+bounces-120651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E188DB07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86441B2252A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E204CB4B;
	Wed, 27 Mar 2024 10:14:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A44C618
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534464; cv=none; b=DNYRTUFQ9k3gxSaE2ttTEFSeSl3ly71QrrauVoNRMXqMkwb1xqbKKkgdvz70GC+C+ICGfNfVBX1aIJUJz/fQzZUhZtWS7i1vZyzCB+uVhc6wy/86qwIuP5GEdrm7zIov94DcUtX6GOM/0taQGsklUVRZmIVgg0XppG4FUyg+RWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534464; c=relaxed/simple;
	bh=MYUxqwJ15Au6j+tzRF+Kb1ngq4X8ptxy3u0nngYX5D0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y21c1c64Gd1U1tsR9c/Vk4o37QpqRcjHTvl4ljy1zhUQqARwxTVwqXOIVHUDk/ceO8aTGWuQhXktk+eiiZaioN90vwqVClec1CL740KesZ6yKBqvgyAhGNm+u+tQmOp65DBi1R/EcKYyV7ZscBhXwW4gw6INmwxCKEzlZLv1eMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368a72042b9so5796745ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711534461; x=1712139261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0x6QznP0naXlFBKhvXrKZHgMeDX4diMgnDySQGYLOM=;
        b=bmHUyKTgH47+byOPKRW7ti8sD4dOCLi86TAffQAaEeizMmuHyy2UC0OK1tX2KUM6cY
         QNgDe5/1BSafjwtAvLwWCJC2BmF3+ey16kfUsR/seZTNHpJTNfn/MBwm2ia/98XmNaUJ
         id/oGFudfrXu0YUyyFkapmGPnH2gd/2LtQBwJxG99vln0aBZPR2bXyMLV1WesXJAmZ1b
         xksmPiZ5pkhxa7D4IzY0HS7A9gtHMWys9iWUWt+RTHz7PmrRj13/TkhNdb9uXfT+8uPH
         d8VxxGPOGK/xzvB9AU1Zl1i8OUf5tqXwVat/w/+n0BBiDEiynl7k437twZ6EW9bytWo0
         nuiw==
X-Forwarded-Encrypted: i=1; AJvYcCUovzuFmnLH54bN5oxe2jIwphgivGB5OTovyHNFCkDMkLdmC8Tqu2UW5Ii/HRSM+7HTumEte20+U2h79O799c2hKvrnhZem4j0F6crn
X-Gm-Message-State: AOJu0YxSEw+RT7imA8SGPwnlWfBxI2oXh2D2LzxOX/RSwxgZK/upxWMQ
	jBNGnYiaLpZqt9E2E+GmcbY4r8TEhqzCr5QwDqsyn8c/HBmgPCzbG38U8OgNtmiuosmXF3PNGUw
	N0xDwKpAPvhHDUFJy/NPasr8DfOQgDiAMI0B8OzNh/JRy3JmUJOWW8w8=
X-Google-Smtp-Source: AGHT+IETCBh5u6IdKmQut9xl9QiE3UB3Uunj6qxqrxg1m73vxJVwunBZ9Ja5YUCwg2CzfITLrhbLAsIyH5Oo+nNw+3dQaw2TkSgz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:366:bbfb:5866 with SMTP id
 i14-20020a056e021d0e00b00366bbfb5866mr192030ila.3.1711534460953; Wed, 27 Mar
 2024 03:14:20 -0700 (PDT)
Date: Wed, 27 Mar 2024 03:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090fe770614a1ab17@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bfa8f18691ed Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bbb1be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f186ceee5fcb0b8
dashboard link: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-bfa8f186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7a06d439e10/vmlinux-bfa8f186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8bc8cb9cde60/bzImage-bfa8f186.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-13161-gbfa8f18691ed #0 Not tainted
-----------------------------------------------------
syz-executor.0/5916 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888011e92a00 (&stab->lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888011e92a00 (&stab->lock){+...}-{2:2}, at: __sock_map_delete net/core/sock_map.c:414 [inline]
ffff888011e92a00 (&stab->lock){+...}-{2:2}, at: sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446

and this task is already holding:
ffff888021ffe418 (&host->lock){-.-.}-{2:2}, at: ata_scsi_queuecmd+0x86/0x160 drivers/ata/libata-scsi.c:4194
which would create a new lock dependency:
 (&host->lock){-.-.}-{2:2} -> (&stab->lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&host->lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  ahci_single_level_irq_intr+0xc7/0x120 drivers/ata/libahci.c:2022
  __handle_irq_event_percpu+0x229/0x7c0 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xde/0x250 arch/x86/kernel/irq.c:257
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
  default_idle+0xf/0x20 arch/x86/kernel/process.c:742
  default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
  cpuidle_idle_call kernel/sched/idle.c:191 [inline]
  do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
  start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
  common_startup_64+0x13e/0x148

to a HARDIRQ-irq-unsafe lock:
 (&stab->lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  __sock_map_delete net/core/sock_map.c:414 [inline]
  sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
  ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
  __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
  trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
  __alloc_pages+0x3ad/0x2460 mm/page_alloc.c:4597
  alloc_pages_mpol+0x275/0x610 mm/mempolicy.c:2264
  pipe_write+0xe4a/0x1b50 fs/pipe.c:513
  call_write_iter include/linux/fs.h:2108 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0x6db/0x1100 fs/read_write.c:590
  ksys_write+0x1f8/0x260 fs/read_write.c:643
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&stab->lock);
                               local_irq_disable();
                               lock(&host->lock);
                               lock(&stab->lock);
  <Interrupt>
    lock(&host->lock);

 *** DEADLOCK ***

5 locks held by syz-executor.0/5916:
 #0: ffff888023da0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 #1: ffff888023da2950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1125/0x1620 fs/jbd2/transaction.c:463
 #2: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x619/0x9a0 block/blk-mq.c:2273
 #3: ffff888021ffe418 (&host->lock){-.-.}-{2:2}, at: ata_scsi_queuecmd+0x86/0x160 drivers/ata/libata-scsi.c:4194
 #4: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #4: ffffffff8dbb1420 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&host->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    ahci_single_level_irq_intr+0xc7/0x120 drivers/ata/libahci.c:2022
                    __handle_irq_event_percpu+0x229/0x7c0 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0xde/0x250 arch/x86/kernel/irq.c:257
                    common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0xf/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                    start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
                    common_startup_64+0x13e/0x148
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    ahci_single_level_irq_intr+0xc7/0x120 drivers/ata/libahci.c:2022
                    __handle_irq_event_percpu+0x229/0x7c0 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0xde/0x250 arch/x86/kernel/irq.c:257
                    common_interrupt+0x52/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    variable_ffs arch/x86/include/asm/bitops.h:321 [inline]
                    __do_softirq+0x1dc/0x922 kernel/softirq.c:542
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
                    console_unlock+0xae/0x290 kernel/printk/printk.c:3042
                    vprintk_emit kernel/printk/printk.c:2342 [inline]
                    vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
                    dev_vprintk_emit drivers/base/core.c:4930 [inline]
                    dev_printk_emit+0xfb/0x140 drivers/base/core.c:4941
                    __dev_printk+0xf5/0x270 drivers/base/core.c:4953
                    _dev_printk+0xde/0x120 drivers/base/core.c:4970
                    sdev_prefix_printk+0x1a2/0x230 drivers/scsi/scsi_logging.c:78
                    sd_print_capacity drivers/scsi/sd.c:2824 [inline]
                    sd_revalidate_disk.isra.0+0x2988/0x9d10 drivers/scsi/sd.c:3653
                    sd_probe+0x8ef/0xfe0 drivers/scsi/sd.c:3907
                    call_driver_probe drivers/base/dd.c:578 [inline]
                    really_probe+0x23e/0xa90 drivers/base/dd.c:656
                    __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
                    driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
                    __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
                    bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
                    __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:985
                    async_run_entry_fn+0x9c/0x530 kernel/async.c:129
                    process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                   ata_dev_init+0x1b4/0x410 drivers/ata/libata-core.c:5399
                   ata_link_init+0x19c/0x300 drivers/ata/libata-core.c:5444
                   ata_port_alloc+0x4a1/0x590 drivers/ata/libata-core.c:5519
                   ata_host_alloc+0x21c/0x2c0 drivers/ata/libata-core.c:5631
                   ata_host_alloc_pinfo+0x2b/0x3f0 drivers/ata/libata-core.c:5674
                   ahci_init_one+0x132a/0x2de0 drivers/ata/ahci.c:1885
                   local_pci_probe+0xde/0x1b0 drivers/pci/pci-driver.c:324
                   pci_call_probe drivers/pci/pci-driver.c:392 [inline]
                   __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
                   pci_device_probe+0x29d/0x7b0 drivers/pci/pci-driver.c:451
                   call_driver_probe drivers/base/dd.c:578 [inline]
                   really_probe+0x23e/0xa90 drivers/base/dd.c:656
                   __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
                   driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
                   __driver_attach+0x283/0x580 drivers/base/dd.c:1214
                   bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
                   bus_add_driver+0x2ed/0x640 drivers/base/bus.c:673
                   driver_register+0x15c/0x4b0 drivers/base/driver.c:246
                   do_one_initcall+0x128/0x700 init/main.c:1238
                   do_initcall_level init/main.c:1300 [inline]
                   do_initcalls init/main.c:1316 [inline]
                   do_basic_setup init/main.c:1335 [inline]
                   kernel_init_freeable+0x69d/0xca0 init/main.c:1548
                   kernel_init+0x1c/0x2b0 init/main.c:1437
                   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff94d99ee0>] __key.5+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&stab->lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    __sock_map_delete net/core/sock_map.c:414 [inline]
                    sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
                    ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
                    __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
                    trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
                    __alloc_pages+0x3ad/0x2460 mm/page_alloc.c:4597
                    alloc_pages_mpol+0x275/0x610 mm/mempolicy.c:2264
                    pipe_write+0xe4a/0x1b50 fs/pipe.c:513
                    call_write_iter include/linux/fs.h:2108 [inline]
                    new_sync_write fs/read_write.c:497 [inline]
                    vfs_write+0x6db/0x1100 fs/read_write.c:590
                    ksys_write+0x1f8/0x260 fs/read_write.c:643
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   __sock_map_delete net/core/sock_map.c:414 [inline]
                   sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
                   ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
                   __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
                   trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
                   __alloc_pages+0x3ad/0x2460 mm/page_alloc.c:4597
                   alloc_pages_mpol+0x275/0x610 mm/mempolicy.c:2264
                   pipe_write+0xe4a/0x1b50 fs/pipe.c:513
                   call_write_iter include/linux/fs.h:2108 [inline]
                   new_sync_write fs/read_write.c:497 [inline]
                   vfs_write+0x6db/0x1100 fs/read_write.c:590
                   ksys_write+0x1f8/0x260 fs/read_write.c:643
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff94e2b680>] __key.1+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   __sock_map_delete net/core/sock_map.c:414 [inline]
   sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
   ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
   __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
   trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
   __alloc_pages+0x3ad/0x2460 mm/page_alloc.c:4597
   __alloc_pages_node include/linux/gfp.h:238 [inline]
   alloc_pages_node include/linux/gfp.h:261 [inline]
   alloc_pgtable_page+0xe6/0x1e0 drivers/iommu/intel/iommu.c:306
   pfn_to_dma_pte+0x2ca/0x5a0 drivers/iommu/intel/iommu.c:870
   __domain_mapping+0x35e/0xc20 drivers/iommu/intel/iommu.c:2105
   intel_iommu_map drivers/iommu/intel/iommu.c:4050 [inline]
   intel_iommu_map_pages+0x270/0x390 drivers/iommu/intel/iommu.c:4069
   __iommu_map+0x2f1/0x680 drivers/iommu/iommu.c:2464
   iommu_map_sg+0x1a5/0x4b0 drivers/iommu/iommu.c:2615
   iommu_dma_map_sg+0x79b/0xc80 drivers/iommu/dma-iommu.c:1454
   __dma_map_sg_attrs+0xd6/0x230 kernel/dma/mapping.c:201
   dma_map_sg_attrs+0x34/0x50 kernel/dma/mapping.c:236
   ata_sg_setup drivers/ata/libata-core.c:4741 [inline]
   ata_qc_issue+0x81a/0xf50 drivers/ata/libata-core.c:5043
   ata_scsi_translate drivers/ata/libata-scsi.c:1717 [inline]
   __ata_scsi_queuecmd+0xa39/0x13c0 drivers/ata/libata-scsi.c:4153
   ata_scsi_queuecmd+0xac/0x160 drivers/ata/libata-scsi.c:4198
   scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1610 [inline]
   scsi_queue_rq+0x12af/0x36a0 drivers/scsi/scsi_lib.c:1852
   blk_mq_dispatch_rq_list+0x452/0x2030 block/blk-mq.c:2058
   __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
   blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
   __blk_mq_sched_dispatch_requests+0xcdf/0x1620 block/blk-mq-sched.c:309
   blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
   blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2273
   blk_mq_dispatch_plug_list block/blk-mq.c:2774 [inline]
   blk_mq_flush_plug_list.part.0+0x611/0x1d90 block/blk-mq.c:2822
   blk_mq_flush_plug_list block/blk-mq.c:1296 [inline]
   blk_add_rq_to_plug+0x117/0x540 block/blk-mq.c:1299
   blk_mq_submit_bio+0x1602/0x20f0 block/blk-mq.c:3014
   __submit_bio+0xfd/0x310 block/blk-core.c:619
   __submit_bio_noacct_mq block/blk-core.c:698 [inline]
   submit_bio_noacct_nocheck+0x98a/0xd50 block/blk-core.c:727
   submit_bio_noacct+0x746/0x1ba0 block/blk-core.c:837
   ext4_io_submit fs/ext4/page-io.c:378 [inline]
   io_submit_add_bh fs/ext4/page-io.c:419 [inline]
   ext4_bio_write_folio+0x76f/0x1da0 fs/ext4/page-io.c:563
   mpage_submit_folio+0x1c0/0x350 fs/ext4/inode.c:1869
   mpage_map_and_submit_buffers+0x57b/0xac0 fs/ext4/inode.c:2115
   mpage_map_and_submit_extent fs/ext4/inode.c:2254 [inline]
   ext4_do_writepages+0x186c/0x3250 fs/ext4/inode.c:2679
   ext4_writepages+0x303/0x730 fs/ext4/inode.c:2768
   do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
   filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
   filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
   __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
   ext4_alloc_da_blocks+0x202/0x2c0 fs/ext4/inode.c:3072
   ext4_release_file+0x17c/0x370 fs/ext4/file.c:169
   __fput+0x270/0xb80 fs/file_table.c:422
   task_work_run+0x14e/0x250 kernel/task_work.c:180
   exit_task_work include/linux/task_work.h:38 [inline]
   do_exit+0xa7d/0x2c10 kernel/exit.c:878
   do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
   get_signal+0x2616/0x2710 kernel/signal.c:2911
   arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
   exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
   irqentry_exit_to_user_mode+0x139/0x280 kernel/entry/common.c:225
   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623


stack backtrace:
CPU: 3 PID: 5916 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-13161-gbfa8f18691ed #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe3c/0x1490 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x248e/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete net/core/sock_map.c:414 [inline]
 sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
 trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
 __alloc_pages+0x3ad/0x2460 mm/page_alloc.c:4597
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_pgtable_page+0xe6/0x1e0 drivers/iommu/intel/iommu.c:306
 pfn_to_dma_pte+0x2ca/0x5a0 drivers/iommu/intel/iommu.c:870
 __domain_mapping+0x35e/0xc20 drivers/iommu/intel/iommu.c:2105
 intel_iommu_map drivers/iommu/intel/iommu.c:4050 [inline]
 intel_iommu_map_pages+0x270/0x390 drivers/iommu/intel/iommu.c:4069
 __iommu_map+0x2f1/0x680 drivers/iommu/iommu.c:2464
 iommu_map_sg+0x1a5/0x4b0 drivers/iommu/iommu.c:2615
 iommu_dma_map_sg+0x79b/0xc80 drivers/iommu/dma-iommu.c:1454
 __dma_map_sg_attrs+0xd6/0x230 kernel/dma/mapping.c:201
 dma_map_sg_attrs+0x34/0x50 kernel/dma/mapping.c:236
 ata_sg_setup drivers/ata/libata-core.c:4741 [inline]
 ata_qc_issue+0x81a/0xf50 drivers/ata/libata-core.c:5043
 ata_scsi_translate drivers/ata/libata-scsi.c:1717 [inline]
 __ata_scsi_queuecmd+0xa39/0x13c0 drivers/ata/libata-scsi.c:4153
 ata_scsi_queuecmd+0xac/0x160 drivers/ata/libata-scsi.c:4198
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1610 [inline]
 scsi_queue_rq+0x12af/0x36a0 drivers/scsi/scsi_lib.c:1852
 blk_mq_dispatch_rq_list+0x452/0x2030 block/blk-mq.c:2058
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xcdf/0x1620 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2273
 blk_mq_dispatch_plug_list block/blk-mq.c:2774 [inline]
 blk_mq_flush_plug_list.part.0+0x611/0x1d90 block/blk-mq.c:2822
 blk_mq_flush_plug_list block/blk-mq.c:1296 [inline]
 blk_add_rq_to_plug+0x117/0x540 block/blk-mq.c:1299
 blk_mq_submit_bio+0x1602/0x20f0 block/blk-mq.c:3014
 __submit_bio+0xfd/0x310 block/blk-core.c:619
 __submit_bio_noacct_mq block/blk-core.c:698 [inline]
 submit_bio_noacct_nocheck+0x98a/0xd50 block/blk-core.c:727
 submit_bio_noacct+0x746/0x1ba0 block/blk-core.c:837
 ext4_io_submit fs/ext4/page-io.c:378 [inline]
 io_submit_add_bh fs/ext4/page-io.c:419 [inline]
 ext4_bio_write_folio+0x76f/0x1da0 fs/ext4/page-io.c:563
 mpage_submit_folio+0x1c0/0x350 fs/ext4/inode.c:1869
 mpage_map_and_submit_buffers+0x57b/0xac0 fs/ext4/inode.c:2115
 mpage_map_and_submit_extent fs/ext4/inode.c:2254 [inline]
 ext4_do_writepages+0x186c/0x3250 fs/ext4/inode.c:2679
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2768
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 ext4_alloc_da_blocks+0x202/0x2c0 fs/ext4/inode.c:3072
 ext4_release_file+0x17c/0x370 fs/ext4/file.c:169
 __fput+0x270/0xb80 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 get_signal+0x2616/0x2710 kernel/signal.c:2911
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x139/0x280 kernel/entry/common.c:225
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f38e3228807
Code: Unable to access opcode bytes at 0x7f38e32287dd.
RSP: 002b:00007f38e3fc6260 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 000000000000000b RCX: 00007f38e327dda9
RDX: 00007f38e3fc6280 RSI: 00007f38e3fc63b0 RDI: 000000000000000b
RBP: 00007f38e32ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 000000000000000b R14: 00007f38e33abf80 R15: 00007ffc0d25d6f8
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 3 PID: 5916 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 3 PID: 5916 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-13161-gbfa8f18691ed #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d fc f1 ec 04 00 74 06 90 c3 cc cc cc cc c6 05 ed f1 ec 04 01 90 48 c7 c7 c0 c2 2c 8b e8 38 3c 72 f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900038f6978 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888021ffe400 RCX: ffffffff814fe149
RDX: ffff888026514880 RSI: ffffffff814fe156 RDI: 0000000000000001
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 61636f6c5f776172 R12: ffff88802328a680
R13: 0000000000000246 R14: ffff888023288010 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020450000 CR3: 0000000108534000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x74/0x80 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 ata_scsi_queuecmd+0xda/0x160 drivers/ata/libata-scsi.c:4204
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1610 [inline]
 scsi_queue_rq+0x12af/0x36a0 drivers/scsi/scsi_lib.c:1852
 blk_mq_dispatch_rq_list+0x452/0x2030 block/blk-mq.c:2058
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xcdf/0x1620 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2273
 blk_mq_dispatch_plug_list block/blk-mq.c:2774 [inline]
 blk_mq_flush_plug_list.part.0+0x611/0x1d90 block/blk-mq.c:2822
 blk_mq_flush_plug_list block/blk-mq.c:1296 [inline]
 blk_add_rq_to_plug+0x117/0x540 block/blk-mq.c:1299
 blk_mq_submit_bio+0x1602/0x20f0 block/blk-mq.c:3014
 __submit_bio+0xfd/0x310 block/blk-core.c:619
 __submit_bio_noacct_mq block/blk-core.c:698 [inline]
 submit_bio_noacct_nocheck+0x98a/0xd50 block/blk-core.c:727
 submit_bio_noacct+0x746/0x1ba0 block/blk-core.c:837
 ext4_io_submit fs/ext4/page-io.c:378 [inline]
 io_submit_add_bh fs/ext4/page-io.c:419 [inline]
 ext4_bio_write_folio+0x76f/0x1da0 fs/ext4/page-io.c:563
 mpage_submit_folio+0x1c0/0x350 fs/ext4/inode.c:1869
 mpage_map_and_submit_buffers+0x57b/0xac0 fs/ext4/inode.c:2115
 mpage_map_and_submit_extent fs/ext4/inode.c:2254 [inline]
 ext4_do_writepages+0x186c/0x3250 fs/ext4/inode.c:2679
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2768
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 ext4_alloc_da_blocks+0x202/0x2c0 fs/ext4/inode.c:3072
 ext4_release_file+0x17c/0x370 fs/ext4/file.c:169
 __fput+0x270/0xb80 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 get_signal+0x2616/0x2710 kernel/signal.c:2911
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x139/0x280 kernel/entry/common.c:225
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f38e3228807
Code: Unable to access opcode bytes at 0x7f38e32287dd.
RSP: 002b:00007f38e3fc6260 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 000000000000000b RCX: 00007f38e327dda9
RDX: 00007f38e3fc6280 RSI: 00007f38e3fc63b0 RDI: 000000000000000b
RBP: 00007f38e32ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 000000000000000b R14: 00007f38e33abf80 R15: 00007ffc0d25d6f8
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

