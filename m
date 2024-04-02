Return-Path: <linux-kernel+bounces-128431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A6895ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642BC28AFE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557915AAD8;
	Tue,  2 Apr 2024 17:32:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E915A49D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079149; cv=none; b=LyJxvQuLTj1KFjLO//8AkWYjkUWrUrVYbN55k6Rtj0DfJT4V14VN3UqulA5XDXvuuEg6k/U6VXYtB/ZCv+VEIx1cS/rRsE0km6mnjgyE/H0FRb63rJUwiD2SyZ4zQYEkqwzhMSx5XPDt7MAaxsEj2ftpTuYfnPdJqJfDA6aihgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079149; c=relaxed/simple;
	bh=3HXSLjYunyfrDKa6WG2Bkal8wCcPqI4EJimPfBLRoY8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UxMi5QuypTubkKWXsRMAA3oZHfoSKv3VY2ncLod99viYeNfGUt0YXtXcE0xHAlOeuVtt7Um2/p6+nucfYGQhlnvmOX6i68qK8JSkUqlAhoDfa7qSvoPqp0Hir/C9VPuwsPfH2+FDxeXvKDJsK7vTRu+sqYuhRivja9feft5lxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368966d79f5so56016645ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079146; x=1712683946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VO6vDX10wKxISOJuwBREQU0vwhB2bDt1mbSBa5RSCZw=;
        b=YnxQpD57kDogXqzyB7J5jlbt4gMNu2nFTlFVGqcEUDk4KCm8UonIwQsMVFF5t6uKj6
         Urxn0KCEGlmBmV+UZfcx/Acn8iVwRmlce0TR+CqTpP/oDPY9tOeEzqvEI3qyiG3jGbdU
         wqgAGRF/m0LF+cLraHUQ/UT4uaqpDOB/UalkmVMkvKN1HDc2l/1cZemJqMfQV6h9HT+d
         3MWnUkQGM68RVBVp11I46Gel0UfRw1fQLdOIgRRMq9vxuvJ0JvVBrAwUb21bvGEPG+UN
         Zbxm6mw4eYdMWLVfaQcCeBwqcwwfg7zYf2YCD3FzW1aBqdFGFrCtwTd+REyHS2FjuNKL
         djFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKV4FxvYA9kcNNAdOV5sbaxfCneCtxaoTen9RzzQ3vEZKrU9AM2FFU1n+veX77togGouXz80CQsBNitlOFUM5UW17EpvJFVHBlb32g
X-Gm-Message-State: AOJu0Yw2Bcd7KTgmIWg0aDVpu9Hs6poW5d+yywguq5uU10JTh9nCv31y
	YShKTng069OvqTEzV7JhsdSZlgxxrtN02V/UX/0ToQHD+xkBlaRggtpb0gZS2Tsi5QfVVHhudJ4
	ICruP7LNFhwFx5bZ9AKw2pWbDNe+LlAnP5cvYBRrnZ5ux9GZiyAUlXWo=
X-Google-Smtp-Source: AGHT+IFZG3O7kMO/g1ezdBfcuoBGnHDIWwF5hD4c8XOgki/yCqddrWONC0C7gBA+zn6wnne3jEd3HCit6Prib6SaYV6h/DK3ezBE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3206:b0:368:c21e:3898 with SMTP id
 cd6-20020a056e02320600b00368c21e3898mr921604ilb.3.1712079146713; Tue, 02 Apr
 2024 10:32:26 -0700 (PDT)
Date: Tue, 02 Apr 2024 10:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e18f00615207de6@google.com>
Subject: [syzbot] [hams?] possible deadlock in serial8250_console_write
From: syzbot <syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com>
To: ajk@comnets.uni-bremen.de, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17277dd9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=8e03da5d64bc85098811
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
-----------------------------------------------------
kworker/u8:0/10 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8ec014f8 (disc_data_lock#2){.+.+}-{2:2}, at: sp_get drivers/net/hamradio/6pack.c:376 [inline]
ffffffff8ec014f8 (disc_data_lock#2){.+.+}-{2:2}, at: sixpack_write_wakeup+0x30/0x430 drivers/net/hamradio/6pack.c:397

and this task is already holding:
ffffffff947d1df8 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
ffffffff947d1df8 (&port_lock_key){-.-.}-{2:2}, at: uart_write+0x101/0x5c0 drivers/tty/serial/serial_core.c:595
which would create a new lock dependency:
 (&port_lock_key){-.-.}-{2:2} -> (disc_data_lock#2){.+.+}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&port_lock_key){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
  serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
  console_emit_next_record kernel/printk/printk.c:2907 [inline]
  console_flush_all+0x865/0xfd0 kernel/printk/printk.c:2973
  console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
  vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
  _printk+0xd5/0x120 kernel/printk/printk.c:2367
  vkms_vblank_simulate+0x2f8/0x360 drivers/gpu/drm/vkms/vkms_crtc.c:26
  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
  __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
  hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  __outl arch/x86/include/asm/shared/io.h:24 [inline]
  iowrite32+0x35/0x90 lib/iomap.c:225
  setup_vq+0x166/0x2d0 drivers/virtio/virtio_pci_legacy.c:150
  vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
  vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
  vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
  virtio_find_vqs_ctx include/linux/virtio_config.h:242 [inline]
  virtnet_find_vqs drivers/net/virtio_net.c:4347 [inline]
  init_vqs+0xcdb/0x15d0 drivers/net/virtio_net.c:4436
  virtnet_probe+0x1988/0x3850 drivers/net/virtio_net.c:4756
  virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
  really_probe+0x29e/0xc50 drivers/base/dd.c:658
  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
  __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
  driver_register+0x23a/0x320 drivers/base/driver.c:246
  virtio_net_driver_init+0x92/0xe0 drivers/net/virtio_net.c:5003
  do_one_initcall+0x238/0x830 init/main.c:1241
  do_initcall_level+0x157/0x210 init/main.c:1303
  do_initcalls+0x3f/0x80 init/main.c:1319
  kernel_init_freeable+0x435/0x5d0 init/main.c:1550
  kernel_init+0x1d/0x2a0 init/main.c:1439
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (disc_data_lock#2){.+.+}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  sp_get drivers/net/hamradio/6pack.c:376 [inline]
  sixpack_receive_buf+0x56/0x1380 drivers/net/hamradio/6pack.c:439
  tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
  tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
  receive_buf drivers/tty/tty_buffer.c:444 [inline]
  flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
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
  lock(disc_data_lock#2);
                               local_irq_disable();
                               lock(&port_lock_key);
                               lock(disc_data_lock#2);
  <Interrupt>
    lock(&port_lock_key);

 *** DEADLOCK ***

6 locks held by kworker/u8:0/10:
 #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900000f7d00 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900000f7d00 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffff88801f660ce8 (&buf->lock){+.+.}-{3:3}, at: flush_to_ldisc+0x38/0x860 drivers/tty/tty_buffer.c:466
 #3: ffff88802ca5c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x80 drivers/tty/tty_ldisc.c:263
 #4: ffffffff947d1df8 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
 #4: ffffffff947d1df8 (&port_lock_key){-.-.}-{2:2}, at: uart_write+0x101/0x5c0 drivers/tty/serial/serial_core.c:595
 #5: ffff88802ca5c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x80 drivers/tty/tty_ldisc.c:263

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&port_lock_key){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
                    serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
                    console_emit_next_record kernel/printk/printk.c:2907 [inline]
                    console_flush_all+0x865/0xfd0 kernel/printk/printk.c:2973
                    console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
                    vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
                    _printk+0xd5/0x120 kernel/printk/printk.c:2367
                    vkms_vblank_simulate+0x2f8/0x360 drivers/gpu/drm/vkms/vkms_crtc.c:26
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __outl arch/x86/include/asm/shared/io.h:24 [inline]
                    iowrite32+0x35/0x90 lib/iomap.c:225
                    setup_vq+0x166/0x2d0 drivers/virtio/virtio_pci_legacy.c:150
                    vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
                    vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
                    vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
                    virtio_find_vqs_ctx include/linux/virtio_config.h:242 [inline]
                    virtnet_find_vqs drivers/net/virtio_net.c:4347 [inline]
                    init_vqs+0xcdb/0x15d0 drivers/net/virtio_net.c:4436
                    virtnet_probe+0x1988/0x3850 drivers/net/virtio_net.c:4756
                    virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
                    really_probe+0x29e/0xc50 drivers/base/dd.c:658
                    __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
                    driver_probe_device+0x50/0x430 drivers/base/dd.c:830
                    __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
                    bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
                    bus_add_driver+0x347/0x620 drivers/base/bus.c:673
                    driver_register+0x23a/0x320 drivers/base/driver.c:246
                    virtio_net_driver_init+0x92/0xe0 drivers/net/virtio_net.c:5003
                    do_one_initcall+0x238/0x830 init/main.c:1241
                    do_initcall_level+0x157/0x210 init/main.c:1303
                    do_initcalls+0x3f/0x80 init/main.c:1319
                    kernel_init_freeable+0x435/0x5d0 init/main.c:1550
                    kernel_init+0x1d/0x2a0 init/main.c:1439
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
                    serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
                    console_emit_next_record kernel/printk/printk.c:2907 [inline]
                    console_flush_all+0x865/0xfd0 kernel/printk/printk.c:2973
                    console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3042
                    vprintk_emit+0x5a6/0x770 kernel/printk/printk.c:2342
                    _printk+0xd5/0x120 kernel/printk/printk.c:2367
                    ip_frag_reasm net/ipv4/ip_fragment.c:476 [inline]
                    ip_frag_queue net/ipv4/ip_fragment.c:379 [inline]
                    ip_defrag+0x1bc6/0x26b0 net/ipv4/ip_fragment.c:499
                    nf_ct_ipv4_gather_frags net/ipv4/netfilter/nf_defrag_ipv4.c:32 [inline]
                    ipv4_conntrack_defrag+0x3de/0x5a0 net/ipv4/netfilter/nf_defrag_ipv4.c:87
                    nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
                    nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
                    nf_hook include/linux/netfilter.h:269 [inline]
                    NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
                    __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
                    __netif_receive_skb+0x2bf/0x6a0 net/core/dev.c:5652
                    process_backlog+0x39d/0x7a0 net/core/dev.c:5981
                    __napi_poll+0xcb/0x490 net/core/dev.c:6632
                    napi_poll net/core/dev.c:6701 [inline]
                    net_rx_action+0x7bb/0x1090 net/core/dev.c:6813
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    do_softirq+0x11b/0x1e0 kernel/softirq.c:455
                    __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
                    local_bh_enable include/linux/bottom_half.h:33 [inline]
                    rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
                    __dev_queue_xmit+0x15fd/0x3b10 net/core/dev.c:4362
                    packet_snd net/packet/af_packet.c:3083 [inline]
                    packet_sendmsg+0x4932/0x63d0 net/packet/af_packet.c:3115
                    sock_sendmsg_nosec net/socket.c:730 [inline]
                    __sock_sendmsg+0x221/0x270 net/socket.c:745
                    __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
                    __do_sys_sendto net/socket.c:2203 [inline]
                    __se_sys_sendto net/socket.c:2199 [inline]
                    __x64_sys_sendto+0xde/0x100 net/socket.c:2199
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
                   serial8250_do_set_termios+0x531/0x17e0 drivers/tty/serial/8250/8250_port.c:2793
                   uart_set_options+0x3eb/0x730 drivers/tty/serial/serial_core.c:2320
                   serial8250_console_setup+0x3db/0x670 drivers/tty/serial/8250/8250_port.c:3507
                   univ8250_console_setup+0x3ac/0x470 drivers/tty/serial/8250/8250_core.c:632
                   try_enable_preferred_console+0x40d/0x560 kernel/printk/printk.c:3308
                   register_console+0x261/0xcd0 kernel/printk/printk.c:3485
                   univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:717
                   console_init+0x198/0x680 kernel/printk/printk.c:3694
                   start_kernel+0x2d3/0x500 init/main.c:1012
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff947d1200>] port_lock_key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (disc_data_lock#2){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    sp_get drivers/net/hamradio/6pack.c:376 [inline]
                    sixpack_receive_buf+0x56/0x1380 drivers/net/hamradio/6pack.c:439
                    tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
                    tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
                    receive_buf drivers/tty/tty_buffer.c:444 [inline]
                    flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   SOFTIRQ-ON-R at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    sp_get drivers/net/hamradio/6pack.c:376 [inline]
                    sixpack_receive_buf+0x56/0x1380 drivers/net/hamradio/6pack.c:439
                    tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
                    tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
                    receive_buf drivers/tty/tty_buffer.c:444 [inline]
                    flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL READ USE at:
                        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        sp_get drivers/net/hamradio/6pack.c:376 [inline]
                        sixpack_receive_buf+0x56/0x1380 drivers/net/hamradio/6pack.c:439
                        tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
                        tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
                        receive_buf drivers/tty/tty_buffer.c:444 [inline]
                        flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
                        process_one_work kernel/workqueue.c:3254 [inline]
                        process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                        worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                        kthread+0x2f0/0x390 kernel/kthread.c:388
                        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff8ec014f8>] disc_data_lock+0x18/0x100
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   sp_get drivers/net/hamradio/6pack.c:376 [inline]
   sixpack_write_wakeup+0x30/0x430 drivers/net/hamradio/6pack.c:397
   tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
   tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
   serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
   __start_tx+0x32e/0x470 drivers/tty/serial/8250/8250_port.c:1544
   __uart_start+0x2d6/0x3c0 drivers/tty/serial/serial_core.c:160
   uart_write+0x427/0x5c0 drivers/tty/serial/serial_core.c:615
   decode_prio_command drivers/net/hamradio/6pack.c:888 [inline]
   sixpack_decode drivers/net/hamradio/6pack.c:963 [inline]
   sixpack_receive_buf+0x427/0x1380 drivers/net/hamradio/6pack.c:453
   tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
   tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
   receive_buf drivers/tty/tty_buffer.c:444 [inline]
   flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
   process_one_work kernel/workqueue.c:3254 [inline]
   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 0 PID: 10 Comm: kworker/u8:0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage kernel/locking/lockdep.c:2865 [inline]
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x4dc7/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
 sp_get drivers/net/hamradio/6pack.c:376 [inline]
 sixpack_write_wakeup+0x30/0x430 drivers/net/hamradio/6pack.c:397
 tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
 tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
 serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
 __start_tx+0x32e/0x470 drivers/tty/serial/8250/8250_port.c:1544
 __uart_start+0x2d6/0x3c0 drivers/tty/serial/serial_core.c:160
 uart_write+0x427/0x5c0 drivers/tty/serial/serial_core.c:615
 decode_prio_command drivers/net/hamradio/6pack.c:888 [inline]
 sixpack_decode drivers/net/hamradio/6pack.c:963 [inline]
 sixpack_receive_buf+0x427/0x1380 drivers/net/hamradio/6pack.c:453
 tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
 tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:444 [inline]
 flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
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

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

