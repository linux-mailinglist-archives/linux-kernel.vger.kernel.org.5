Return-Path: <linux-kernel+bounces-121921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64B288EF76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19BA1C341E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1E15252D;
	Wed, 27 Mar 2024 19:46:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5B1509B2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568788; cv=none; b=nTqW/tKQs/WnZVZyk5qLpB5bCyAU6HwFXnRYIJe3ckNWI0sTYjEd7asCtol3LZCACYnB5AXk3GXUWfUaEVrBkg/xyQUXAvIMwfqIFBfbF7XLLvhRng90lHv2xxOxUp+tN2CfpJTm8QeUNkuf2EM5u3xZV/+90RM39Hean1XPxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568788; c=relaxed/simple;
	bh=T5k5mlnKhbWAZcnP8CL2Rb/ryNihQjvUaIEligr08ZY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Bd3+Q5DXpWJvViXx8frTl5JR/M1am5Y8GYJNiw6aK6MYG25VSowcbKcZ3W1GwhydAYvd8Z4waL3cbuiYphsIoj3apqG1PsSsu2U/DQMqAPIOWDu/USI52Y3ZMOyL1w5kRHToqVAMfa8r9DMJYybE1qd2ezcSPJTQK5M8nsXJ5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so12121239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568785; x=1712173585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhEWPgW4wQwTZn+Fxj2k1NDmx41/bxbRK3of2kG8y+A=;
        b=JU9bziZmleXy5JYMkTnnjEEQV4w9CCW0ZYG1wzKICzhkvHyMo3kwrYgvWX3HZlGbyx
         0x08kttg+RwAbTJSYMtA+RWQDUOrTyRzWoaqfzGlGUwkscXaiK0ayuF3G4opn2oi6K9x
         4YdJ26EkrxHx7InlQCOxWAv2u4d4Ls5um+K6BT4l0QJ7VDEwb4w+6b1kRTKGy6nxk7A2
         ilLBKeLD0HgdWd1mPgTpizOMLkUYGmm88mzduN4d1FCJsFfjx8UyeQHiLBvTGIJ2UAH3
         p6YHgrGdOz/OqEUJ5ZHXgbP3lAGW2YNPMKSM1LsX8D0lsHSPrNKh1U+GaPYZjBC8hvBQ
         uftA==
X-Forwarded-Encrypted: i=1; AJvYcCUn/xwUm7f2eO8w1ajpBGxhybAtxsqEeCZ/8DUvg1WNzwPkZwk+Y0iQzB1VkGU13HmxmqnzLxL7gAicY/viG7f7wp7+2/OTnjS6Ksy6
X-Gm-Message-State: AOJu0Yzb1snz3g0VBv/ZNgnUe8ake00jwsoP87JcL8vdxzTopD4icVXe
	NV9wOrCUq7bkB5HlTl/JIoCAEHwu6TahyGMJ3QR+Ho1hjSyKKGMC1wL4rmt/Ib6RXUvb2M31faR
	9jZE5JzcN6706+opzAP583qmqWG7ACx/3Ex09vaG/QFck9IBBniWmpAE=
X-Google-Smtp-Source: AGHT+IF5A7d/neqNk4dQS6EJAZTJf5z++Wzd97baniNS0xAYnjD4UJP0k4/Rr98p5fpVx5Y6QDjdRcikPPjPAHo2H86UIwg1ne8j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc3:b0:7d0:7b99:42 with SMTP id
 fc3-20020a0566023fc300b007d07b990042mr9268iob.0.1711568785638; Wed, 27 Mar
 2024 12:46:25 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:46:25 -0700
In-Reply-To: <00000000000090fe770614a1ab17@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a208d0614a9a9e0@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    962490525cff Merge tag 'probes-fixes-v6.9-rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13db59e9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13861829180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136fa9e9180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-96249052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5a4f1f7db02/vmlinux-96249052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea148b99c50a/bzImage-96249052.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.9.0-rc1-syzkaller-00021-g962490525cff #0 Not tainted
-----------------------------------------------------
kworker/u32:9/1103 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffffc900058a83e0 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffffc900058a83e0 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939

and this task is already holding:
ffff888022666c18 (&host->lock){-.-.}-{2:2}, at: ata_scsi_queuecmd+0x86/0x160 drivers/ata/libata-scsi.c:4194
which would create a new lock dependency:
 (&host->lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

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
  rdtsc_ordered arch/x86/include/asm/msr.h:230 [inline]
  delay_tsc+0x49/0xc0 arch/x86/lib/delay.c:72
  e1000_raise_ee_clk drivers/net/ethernet/intel/e1000/e1000_hw.c:3540 [inline]
  e1000_shift_in_ee_bits+0xcd/0x1e0 drivers/net/ethernet/intel/e1000/e1000_hw.c:3636
  e1000_do_read_eeprom+0x264/0x580 drivers/net/ethernet/intel/e1000/e1000_hw.c:3934
  e1000_read_eeprom drivers/net/ethernet/intel/e1000/e1000_hw.c:3850 [inline]
  e1000_validate_eeprom_checksum+0xbc/0x1a0 drivers/net/ethernet/intel/e1000/e1000_hw.c:3960
  e1000_probe+0x167b/0x3390 drivers/net/ethernet/intel/e1000/e1000_main.c:1089
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
  e1000_init_module+0x46/0xc0 drivers/net/ethernet/intel/e1000/e1000_main.c:227
  do_one_initcall+0x128/0x700 init/main.c:1238
  do_initcall_level init/main.c:1300 [inline]
  do_initcalls init/main.c:1316 [inline]
  do_basic_setup init/main.c:1335 [inline]
  kernel_init_freeable+0x69d/0xca0 init/main.c:1548
  kernel_init+0x1c/0x2b0 init/main.c:1437
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_free+0x130/0x820 net/core/sock_map.c:1154
  bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
  process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
  process_scheduled_works kernel/workqueue.c:3335 [inline]
  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
  kthread+0x2c1/0x3a0 kernel/kthread.c:388
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&host->lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&host->lock);

 *** DEADLOCK ***

8 locks held by kworker/u32:9/1103:
 #0: ffff8880167d6948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3229
 #1: ffffc900042f7d80 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3230
 #2: ffff888024b8a0e0 (&type->s_umount_key#52){++++}-{3:3}, at: super_trylock_shared+0x1e/0xf0 fs/super.c:561
 #3: ffff888024b8cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2612
 #4: ffff888024b8e950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1125/0x1620 fs/jbd2/transaction.c:463
 #5: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #5: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #5: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x619/0x9a0 block/blk-mq.c:2273
 #6: ffff888022666c18 (&host->lock){-.-.}-{2:2}, at: ata_scsi_queuecmd+0x86/0x160 drivers/ata/libata-scsi.c:4194
 #7: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #7: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #7: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #7: ffffffff8dbb14a0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

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
                    rdtsc_ordered arch/x86/include/asm/msr.h:230 [inline]
                    delay_tsc+0x49/0xc0 arch/x86/lib/delay.c:72
                    e1000_raise_ee_clk drivers/net/ethernet/intel/e1000/e1000_hw.c:3540 [inline]
                    e1000_shift_in_ee_bits+0xcd/0x1e0 drivers/net/ethernet/intel/e1000/e1000_hw.c:3636
                    e1000_do_read_eeprom+0x264/0x580 drivers/net/ethernet/intel/e1000/e1000_hw.c:3934
                    e1000_read_eeprom drivers/net/ethernet/intel/e1000/e1000_hw.c:3850 [inline]
                    e1000_validate_eeprom_checksum+0xbc/0x1a0 drivers/net/ethernet/intel/e1000/e1000_hw.c:3960
                    e1000_probe+0x167b/0x3390 drivers/net/ethernet/intel/e1000/e1000_main.c:1089
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
                    e1000_init_module+0x46/0xc0 drivers/net/ethernet/intel/e1000/e1000_main.c:227
                    do_one_initcall+0x128/0x700 init/main.c:1238
                    do_initcall_level init/main.c:1300 [inline]
                    do_initcalls init/main.c:1316 [inline]
                    do_basic_setup init/main.c:1335 [inline]
                    kernel_init_freeable+0x69d/0xca0 init/main.c:1548
                    kernel_init+0x1c/0x2b0 init/main.c:1437
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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
                    common_interrupt+0xb0/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                    _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
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
                    blk_mq_flush_plug_list+0x62/0x80 block/blk-mq.c:2792
                    __blk_flush_plug+0x2c5/0x480 block/blk-core.c:1188
                    blk_finish_plug block/blk-core.c:1214 [inline]
                    blk_finish_plug+0x53/0xa0 block/blk-core.c:1211
                    __ext4_get_inode_loc+0x982/0x1510 fs/ext4/inode.c:4462
                    __ext4_get_inode_loc_noinmem+0xb9/0x160 fs/ext4/inode.c:4482
                    __ext4_iget+0x43a/0x4370 fs/ext4/inode.c:4704
                    ext4_lookup+0x37e/0x730 fs/ext4/namei.c:1854
                    __lookup_slow+0x24f/0x460 fs/namei.c:1692
                    lookup_slow fs/namei.c:1709 [inline]
                    walk_component+0x350/0x5b0 fs/namei.c:2004
                    link_path_walk.part.0.constprop.0+0x77f/0xcd0 fs/namei.c:2331
                    link_path_walk fs/namei.c:2256 [inline]
                    path_openat+0x22f/0x2990 fs/namei.c:3795
                    do_filp_open+0x1dc/0x430 fs/namei.c:3826
                    do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
                    do_sys_open fs/open.c:1421 [inline]
                    __do_sys_openat fs/open.c:1437 [inline]
                    __se_sys_openat fs/open.c:1432 [inline]
                    __x64_sys_openat+0x175/0x210 fs/open.c:1432
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
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
 ... key      at: [<ffffffff94d9bee0>] __key.5+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_free+0x130/0x820 net/core/sock_map.c:1154
                    bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
                    process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_free+0x130/0x820 net/core/sock_map.c:1154
                   bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
                   process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
                   process_scheduled_works kernel/workqueue.c:3335 [inline]
                   worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                   kthread+0x2c1/0x3a0 kernel/kthread.c:388
                   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff94e2d640>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
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
   alloc_slab_page mm/slub.c:2175 [inline]
   allocate_slab mm/slub.c:2338 [inline]
   new_slab+0xcc/0x3a0 mm/slub.c:2391
   ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
   __slab_alloc_node mm/slub.c:3663 [inline]
   slab_alloc_node mm/slub.c:3835 [inline]
   kmem_cache_alloc+0x2e9/0x320 mm/slub.c:3852
   kmem_cache_zalloc include/linux/slab.h:739 [inline]
   alloc_iova_mem drivers/iommu/iova.c:230 [inline]
   alloc_iova+0x3c/0x800 drivers/iommu/iova.c:258
   alloc_iova_fast+0x403/0xa30 drivers/iommu/iova.c:396
   iommu_dma_alloc_iova+0x2e6/0x450 drivers/iommu/dma-iommu.c:795
   iommu_dma_map_sg+0x765/0xc80 drivers/iommu/dma-iommu.c:1444
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
   __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1650
   writeback_sb_inodes+0x5a6/0x10d0 fs/fs-writeback.c:1941
   __writeback_inodes_wb+0xff/0x2e0 fs/fs-writeback.c:2012
   wb_writeback+0x7db/0xb30 fs/fs-writeback.c:2119
   wb_check_background_flush fs/fs-writeback.c:2189 [inline]
   wb_do_writeback fs/fs-writeback.c:2277 [inline]
   wb_workfn+0x8c4/0xf40 fs/fs-writeback.c:2304
   process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
   process_scheduled_works kernel/workqueue.c:3335 [inline]
   worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
   kthread+0x2c1/0x3a0 kernel/kthread.c:388
   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 0 PID: 1103 Comm: kworker/u32:9 Not tainted 6.9.0-rc1-syzkaller-00021-g962490525cff #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: writeback wb_workfn (flush-8:0)
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
 sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
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
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x2e9/0x320 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 alloc_iova_mem drivers/iommu/iova.c:230 [inline]
 alloc_iova+0x3c/0x800 drivers/iommu/iova.c:258
 alloc_iova_fast+0x403/0xa30 drivers/iommu/iova.c:396
 iommu_dma_alloc_iova+0x2e6/0x450 drivers/iommu/dma-iommu.c:795
 iommu_dma_map_sg+0x765/0xc80 drivers/iommu/dma-iommu.c:1444
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
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x5a6/0x10d0 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0xff/0x2e0 fs/fs-writeback.c:2012
 wb_writeback+0x7db/0xb30 fs/fs-writeback.c:2119
 wb_check_background_flush fs/fs-writeback.c:2189 [inline]
 wb_do_writeback fs/fs-writeback.c:2277 [inline]
 wb_workfn+0x8c4/0xf40 fs/fs-writeback.c:2304
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 1103 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 0 PID: 1103 Comm: kworker/u32:9 Not tainted 6.9.0-rc1-syzkaller-00021-g962490525cff #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 6c e3 ec 04 00 74 06 90 c3 cc cc cc cc c6 05 5d e3 ec 04 01 90 48 c7 c7 c0 c2 2c 8b e8 28 2c 72 f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900042f6748 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888022666c00 RCX: ffffffff814fe149
RDX: ffff888023804880 RSI: ffffffff814fe156 RDI: 0000000000000001
RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 61636f6c5f776172 R12: ffff888020daa680
R13: 0000000000000246 R14: ffff888020da8010 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558a52f788 CR3: 0000000027c3a000 CR4: 0000000000350ef0
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
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x5a6/0x10d0 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0xff/0x2e0 fs/fs-writeback.c:2012
 wb_writeback+0x7db/0xb30 fs/fs-writeback.c:2119
 wb_check_background_flush fs/fs-writeback.c:2189 [inline]
 wb_do_writeback fs/fs-writeback.c:2277 [inline]
 wb_workfn+0x8c4/0xf40 fs/fs-writeback.c:2304
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

