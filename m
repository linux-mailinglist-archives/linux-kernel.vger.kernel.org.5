Return-Path: <linux-kernel+bounces-152219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2CE8ABAE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959841F21CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99F175A5;
	Sat, 20 Apr 2024 09:53:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BA199A2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713606786; cv=none; b=bB1kQWd/dp0ZRpQSlncyb9e8rTC5yodlWHj2XPApQCF4ukHiHmgcz+cIGd4fA0v5ZVVNlzCTgFEptm1w1agvkqPKuAlVYOv1985z+ulI8+xr0Cn0EG3IN1j3ajT/I1rQpMiMVwN2PyPcKWlDx2F5OncGTw8kDTtgmxIN47xfppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713606786; c=relaxed/simple;
	bh=zwh29fc/lCtJ2REqlq55TRKWFBnfERBlPPZG+vmPnlw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WUvGi7T/1UPLWO96YOPsqwklPTRz6Kig76ek9x1DZNXMWZjNWTcPH6Z1DSsmS4diiwBzhHtZqbf1WGh7uOW84diB5v550Wg0kke4ZExC4OaHVrb/xt7PAV5Ryu8TKuSJWiiadsqlAr5flU3MR6T/yDoAKbHkJeQ9fLkLRcrgC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so422919639f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713606783; x=1714211583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbu6dVAg7d07ipD/C9btSpbAMNFBEpjkWXmIulGD0B8=;
        b=f53jEu7bxVlhY3/u0tyYgoKPB62dvLq5TjkI9iy9Gql5QD74R3WYOI/uzjvYIZExgE
         o9GGwKPZ0x29EKGlOb+xF1hYYwMphyIjqd6neUxQIsFhaCMiKqviwVBoXJqiFvuNogiU
         5DXWOSSSsIt6NCoG00kvNaZVycvgYHB+nCEAwU+BZZxwzUNMmLuLUBGAyce7cXIKiLhg
         wkotb1Io4bdNzEqyQXlNfBHrE4NWZydESvM2E9DVxWyW1ug0rw1qLCOgFQ8IKv3/GZto
         lWJbBnOWfpJHQZvlizwDzK8WgzqAm8dCSKWOnKU6eMUL3vi9jEhbCHK9MewGB/vWEyl+
         dHWg==
X-Forwarded-Encrypted: i=1; AJvYcCXouMwAboaVm2/1QV+MtKTPsQqtkbK27QZ5kaVPcej2+3xHihxXGbtKHH/xENyN/wM3KzyME2yHaQmg/jSMCX2Q/T0jF2GHcPeQ/Jc2
X-Gm-Message-State: AOJu0Yym2mAvCAK2WeLfILuQT6V6F1OXM+3+P4vuT9zX/YLs3rZPvRp9
	FnhUmkENRQV2IRLxLmB51MK+6wLSvumZCl/PeXiKfdOeyctbkJP66GtHG8lpLBbbtnu3W5PJF2H
	OJLnCDznFj6WSbkl2nsR4g0kIhO6xdcIevqzMtvxGSQNqRo7mdI5853k=
X-Google-Smtp-Source: AGHT+IE0RxPvijBZ9R0W0SaBGq88avM6BBCVd6C0aOyA2xazP8GsJNkncbPAIgwtxoDqt8brUef6ScPqVAKnnALTk39urBq5dLpb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:36b:26df:cce4 with SMTP id
 s10-20020a056e02216a00b0036b26dfcce4mr191516ilv.6.1713606783651; Sat, 20 Apr
 2024 02:53:03 -0700 (PDT)
Date: Sat, 20 Apr 2024 02:53:03 -0700
In-Reply-To: <20240420081409.63736-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fe71c0616842b53@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in input_event (2)
From: syzbot <syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in input_event

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.9.0-rc4-syzkaller-00214-g13a2e429f644-dirty #0 Not tainted
-----------------------------------------------------
syz-executor.0/5495 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8e00a058 (tasklist_lock){.+.+}-{2:2}, at: send_sigurg+0xee/0x3c0 fs/fcntl.c:851

and this task is already holding:
ffff88801c7f4398 (&f->f_owner.lock){....}-{2:2}, at: send_sigurg+0x29/0x3c0 fs/fcntl.c:835
which would create a new lock dependency:
 (&f->f_owner.lock){....}-{2:2} -> (tasklist_lock){.+.+}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&dev->event_lock#2){-...}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  input_event+0x91/0xd0 drivers/input/input.c:434
  input_report_key include/linux/input.h:425 [inline]
  psmouse_report_standard_buttons drivers/input/mouse/psmouse-base.c:128 [inline]
  psmouse_report_standard_packet+0x54/0x200 drivers/input/mouse/psmouse-base.c:146
  psmouse_process_byte+0x48c/0x680 drivers/input/mouse/psmouse-base.c:237
  psmouse_handle_byte+0x49/0x4c0 drivers/input/mouse/psmouse-base.c:279
  ps2_interrupt+0x17c/0x8e0 drivers/input/serio/libps2.c:613
  serio_interrupt+0x90/0x140 drivers/input/serio/serio.c:998
  i8042_interrupt+0x375/0x770 drivers/input/serio/i8042.c:606
  __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
  handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:589 [inline]
  queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
  do_raw_spin_unlock+0x118/0x8b0 kernel/locking/spinlock_debug.c:142
  __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
  usb_device_match+0x41b/0x4a0 drivers/usb/core/driver.c:897
  driver_match_device drivers/base/base.h:167 [inline]
  __driver_attach+0x6c/0x710 drivers/base/dd.c:1170
  bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
  bus_add_driver+0x347/0x620 drivers/base/bus.c:673
  driver_register+0x23a/0x320 drivers/base/driver.c:246
  usb_register_driver+0x1f5/0x3b0 drivers/usb/core/driver.c:1068
  do_one_initcall+0x248/0x880 init/main.c:1245
  do_initcall_level+0x157/0x210 init/main.c:1307
  do_initcalls+0x3f/0x80 init/main.c:1323
  kernel_init_freeable+0x435/0x5d0 init/main.c:1555
  kernel_init+0x1d/0x2b0 init/main.c:1444
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

to a HARDIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  __do_wait+0x12d/0x850 kernel/exit.c:1587
  do_wait+0x1e9/0x560 kernel/exit.c:1631
  kernel_wait+0xe9/0x240 kernel/exit.c:1807
  call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
  call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &dev->event_lock#2 --> &f->f_owner.lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock#2);
                               lock(&f->f_owner.lock);
  <Interrupt>
    lock(&dev->event_lock#2);

 *** DEADLOCK ***

2 locks held by syz-executor.0/5495:
 #0: ffff88802b50d058 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
 #0: ffff88802b50d058 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sendmsg+0x22/0x50 net/ipv4/tcp.c:1341
 #1: ffff88801c7f4398 (&f->f_owner.lock){....}-{2:2}, at: send_sigurg+0x29/0x3c0 fs/fcntl.c:835

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
   -> (&dev->event_lock#2){-...}-{2:2} {
      IN-HARDIRQ-W at:
                          lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                          __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                          _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                          input_event+0x91/0xd0 drivers/input/input.c:434
                          input_report_key include/linux/input.h:425 [inline]
                          psmouse_report_standard_buttons drivers/input/mouse/psmouse-base.c:128 [inline]
                          psmouse_report_standard_packet+0x54/0x200 drivers/input/mouse/psmouse-base.c:146
                          psmouse_process_byte+0x48c/0x680 drivers/input/mouse/psmouse-base.c:237
                          psmouse_handle_byte+0x49/0x4c0 drivers/input/mouse/psmouse-base.c:279
                          ps2_interrupt+0x17c/0x8e0 drivers/input/serio/libps2.c:613
                          serio_interrupt+0x90/0x140 drivers/input/serio/serio.c:998
                          i8042_interrupt+0x375/0x770 drivers/input/serio/i8042.c:606
                          __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
                          handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                          handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                          handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                          generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                          handle_irq arch/x86/kernel/irq.c:238 [inline]
                          __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
                          common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                          asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                          pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:589 [inline]
                          queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
                          do_raw_spin_unlock+0x118/0x8b0 kernel/locking/spinlock_debug.c:142
                          __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
                          _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
                          usb_device_match+0x41b/0x4a0 drivers/usb/core/driver.c:897
                          driver_match_device drivers/base/base.h:167 [inline]
                          __driver_attach+0x6c/0x710 drivers/base/dd.c:1170
                          bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
                          bus_add_driver+0x347/0x620 drivers/base/bus.c:673
                          driver_register+0x23a/0x320 drivers/base/driver.c:246
                          usb_register_driver+0x1f5/0x3b0 drivers/usb/core/driver.c:1068
                          do_one_initcall+0x248/0x880 init/main.c:1245
                          do_initcall_level+0x157/0x210 init/main.c:1307
                          do_initcalls+0x3f/0x80 init/main.c:1323
                          kernel_init_freeable+0x435/0x5d0 init/main.c:1555
                          kernel_init+0x1d/0x2b0 init/main.c:1444
                          ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                          ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
      INITIAL USE at:
                         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                         _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                         input_inject_event+0xc5/0x340 drivers/input/input.c:460
                         led_trigger_event+0x11c/0x1e0 drivers/leds/led-triggers.c:392
                         kbd_led_trigger_activate+0xbd/0x100 drivers/tty/vt/keyboard.c:1036
                         led_trigger_set+0x541/0x950 drivers/leds/led-triggers.c:198
                         led_match_default_trigger drivers/leds/led-triggers.c:256 [inline]
                         led_trigger_set_default+0x229/0x260 drivers/leds/led-triggers.c:274
                         led_classdev_register_ext+0x773/0x960 drivers/leds/led-class.c:561
                         led_classdev_register include/linux/leds.h:271 [inline]
                         input_leds_connect+0x497/0x640 drivers/input/input-leds.c:145
                         input_attach_handler drivers/input/input.c:1064 [inline]
                         input_register_device+0xcfa/0x1090 drivers/input/input.c:2396
                         atkbd_connect+0x752/0xa00 drivers/input/keyboard/atkbd.c:1342
                         serio_connect_driver drivers/input/serio/serio.c:44 [inline]
                         serio_driver_probe+0x7f/0xa0 drivers/input/serio/serio.c:775
                         really_probe+0x2b8/0xad0 drivers/base/dd.c:656
                         __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
                         driver_probe_device+0x50/0x430 drivers/base/dd.c:828
                         __driver_attach+0x45f/0x710 drivers/base/dd.c:1214
                         bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
                         serio_attach_driver drivers/input/serio/serio.c:804 [inline]
                         serio_handle_event+0x1c7/0x920 drivers/input/serio/serio.c:224
                         process_one_work kernel/workqueue.c:3254 [inline]
                         process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
                         worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                         kthread+0x2f0/0x390 kernel/kthread.c:388
                         ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                         ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
    }
    ... key      at: [<ffffffff94ab3660>] input_allocate_device.__key.5+0x0/0x20
  -> (&client->buffer_lock){....}-{2:2} {
     INITIAL USE at:
                       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                       spin_lock include/linux/spinlock.h:351 [inline]
                       evdev_pass_values+0xf2/0xad0 drivers/input/evdev.c:261
                       evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
                       input_to_handler drivers/input/input.c:129 [inline]
                       input_pass_values+0x84d/0x1200 drivers/input/input.c:161
                       input_event_dispose+0x36c/0x650 drivers/input/input.c:378
                       input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
                       input_inject_event+0x22f/0x340 drivers/input/input.c:465
                       evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
                       vfs_write+0x2a4/0xcb0 fs/read_write.c:588
                       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
                       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
                       entry_SYSCALL_64_after_hwframe+0x77/0x7f
   }
   ... key      at: [<ffffffff94ab3900>] evdev_open.__key.24+0x0/0x20
   ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   evdev_pass_values+0xf2/0xad0 drivers/input/evdev.c:261
   evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
   input_to_handler drivers/input/input.c:129 [inline]
   input_pass_values+0x84d/0x1200 drivers/input/input.c:161
   input_event_dispose+0x36c/0x650 drivers/input/input.c:378
   input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
   input_inject_event+0x22f/0x340 drivers/input/input.c:465
   evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
   vfs_write+0x2a4/0xcb0 fs/read_write.c:588
   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&new->fa_lock){....}-{2:2} {
    INITIAL READ USE at:
                          lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1008 [inline]
                          kill_fasync+0x19e/0x4d0 fs/fcntl.c:1029
                          __pass_event drivers/input/evdev.c:240 [inline]
                          evdev_pass_values+0x58a/0xad0 drivers/input/evdev.c:278
                          evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
                          input_to_handler drivers/input/input.c:129 [inline]
                          input_pass_values+0x84d/0x1200 drivers/input/input.c:161
                          input_event_dispose+0x36c/0x650 drivers/input/input.c:378
                          input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
                          input_inject_event+0x22f/0x340 drivers/input/input.c:465
                          evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
                          vfs_write+0x2a4/0xcb0 fs/read_write.c:588
                          ksys_write+0x1a0/0x2c0 fs/read_write.c:643
                          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                          do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff947baba0>] fasync_insert_entry.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1008 [inline]
   kill_fasync+0x19e/0x4d0 fs/fcntl.c:1029
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x58a/0xad0 drivers/input/evdev.c:278
   evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
   input_to_handler drivers/input/input.c:129 [inline]
   input_pass_values+0x84d/0x1200 drivers/input/input.c:161
   input_event_dispose+0x36c/0x650 drivers/input/input.c:378
   input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
   input_inject_event+0x22f/0x340 drivers/input/input.c:465
   evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
   vfs_write+0x2a4/0xcb0 fs/read_write.c:588
   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&f->f_owner.lock){....}-{2:2} {
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                   f_modown+0x38/0x340 fs/fcntl.c:93
                   __f_setown fs/fcntl.c:112 [inline]
                   f_setown+0x14f/0x200 fs/fcntl.c:140
                   do_fcntl+0x8b1/0x16f0 fs/fcntl.c:393
                   __do_sys_fcntl fs/fcntl.c:472 [inline]
                   __se_sys_fcntl+0xd2/0x1b0 fs/fcntl.c:457
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
                        send_sigio+0x33/0x360 fs/fcntl.c:796
                        kill_fasync_rcu fs/fcntl.c:1015 [inline]
                        kill_fasync+0x23a/0x4d0 fs/fcntl.c:1029
                        __pass_event drivers/input/evdev.c:240 [inline]
                        evdev_pass_values+0x58a/0xad0 drivers/input/evdev.c:278
                        evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
                        input_to_handler drivers/input/input.c:129 [inline]
                        input_pass_values+0x84d/0x1200 drivers/input/input.c:161
                        input_event_dispose+0x36c/0x650 drivers/input/input.c:378
                        input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
                        input_inject_event+0x22f/0x340 drivers/input/input.c:465
                        evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
                        vfs_write+0x2a4/0xcb0 fs/read_write.c:588
                        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
                        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff947b9f40>] init_file.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xdd/0x130 kernel/locking/spinlock.c:236
   send_sigio+0x33/0x360 fs/fcntl.c:796
   kill_fasync_rcu fs/fcntl.c:1015 [inline]
   kill_fasync+0x23a/0x4d0 fs/fcntl.c:1029
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values+0x58a/0xad0 drivers/input/evdev.c:278
   evdev_events+0x1c2/0x300 drivers/input/evdev.c:306
   input_to_handler drivers/input/input.c:129 [inline]
   input_pass_values+0x84d/0x1200 drivers/input/input.c:161
   input_event_dispose+0x36c/0x650 drivers/input/input.c:378
   input_handle_event+0xa71/0xbe0 drivers/input/input.c:406
   input_inject_event+0x22f/0x340 drivers/input/input.c:465
   evdev_write+0x672/0x7c0 drivers/input/evdev.c:530
   vfs_write+0x2a4/0xcb0 fs/read_write.c:588
   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    __do_wait+0x12d/0x850 kernel/exit.c:1587
                    do_wait+0x1e9/0x560 kernel/exit.c:1631
                    kernel_wait+0xe9/0x240 kernel/exit.c:1807
                    call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                    call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
   SOFTIRQ-ON-R at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    __do_wait+0x12d/0x850 kernel/exit.c:1587
                    do_wait+0x1e9/0x560 kernel/exit.c:1631
                    kernel_wait+0xe9/0x240 kernel/exit.c:1807
                    call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                    call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                   copy_process+0x228b/0x3df0 kernel/fork.c:2516
                   kernel_clone+0x226/0x8f0 kernel/fork.c:2797
                   user_mode_thread+0x132/0x1a0 kernel/fork.c:2875
                   rest_init+0x23/0x300 init/main.c:704
                   start_kernel+0x47a/0x500 init/main.c:1081
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
                   common_startup_64+0x13e/0x147
   INITIAL READ USE at:
                        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0x12d/0x850 kernel/exit.c:1587
                        do_wait+0x1e9/0x560 kernel/exit.c:1631
                        kernel_wait+0xe9/0x240 kernel/exit.c:1807
                        call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                        call_usermodehelper_exec_work+0xbd/0x230 kernel/umh.c:164
                        process_one_work kernel/workqueue.c:3254 [inline]
                        process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
                        worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                        kthread+0x2f0/0x390 kernel/kthread.c:388
                        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 }
 ... key      at: [<ffffffff8e00a058>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   __raw_read_lock_irq include/linux/rwlock_api_smp.h:169 [inline]
   _raw_read_lock_irq+0xda/0x120 kernel/locking/spinlock.c:244
   send_sigurg+0xee/0x3c0 fs/fcntl.c:851
   sk_send_sigurg+0x6e/0xc0 net/core/sock.c:3412
   tcp_check_urg+0x207/0x740 net/ipv4/tcp_input.c:5777
   tcp_urg+0x15c/0x450 net/ipv4/tcp_input.c:5818
   tcp_rcv_established+0xfac/0x2020 net/ipv4/tcp_input.c:6167
   tcp_v6_do_rcv+0xa09/0x1300 net/ipv6/tcp_ipv6.c:1644
   sk_backlog_rcv include/net/sock.h:1106 [inline]
   __release_sock+0x1c8/0x350 net/core/sock.c:2984
   release_sock+0x61/0x1f0 net/core/sock.c:3550
   tcp_sendmsg+0x3a/0x50 net/ipv4/tcp.c:1343
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0xef/0x270 net/socket.c:745
   __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
   __do_sys_sendto net/socket.c:2203 [inline]
   __se_sys_sendto net/socket.c:2199 [inline]
   __x64_sys_sendto+0xde/0x100 net/socket.c:2199
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 1 PID: 5495 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00214-g13a2e429f644-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_read_lock_irq include/linux/rwlock_api_smp.h:169 [inline]
 _raw_read_lock_irq+0xda/0x120 kernel/locking/spinlock.c:244
 send_sigurg+0xee/0x3c0 fs/fcntl.c:851
 sk_send_sigurg+0x6e/0xc0 net/core/sock.c:3412
 tcp_check_urg+0x207/0x740 net/ipv4/tcp_input.c:5777
 tcp_urg+0x15c/0x450 net/ipv4/tcp_input.c:5818
 tcp_rcv_established+0xfac/0x2020 net/ipv4/tcp_input.c:6167
 tcp_v6_do_rcv+0xa09/0x1300 net/ipv6/tcp_ipv6.c:1644
 sk_backlog_rcv include/net/sock.h:1106 [inline]
 __release_sock+0x1c8/0x350 net/core/sock.c:2984
 release_sock+0x61/0x1f0 net/core/sock.c:3550
 tcp_sendmsg+0x3a/0x50 net/ipv4/tcp.c:1343
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xef/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f93be67de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f93bf3490c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f93be7abf80 RCX: 00007f93be67de69
RDX: 0000000000000002 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00007f93be6ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f93be7abf80 R15: 00007ffd71560168
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 5495 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 5495 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-00214-g13a2e429f644-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 6f 98 0f 04 00 74 06 90 c3 cc cc cc cc c6 05 60 98 0f 04 01 90 48 c7 c7 a0 b0 ca 8b e8 c8 be d3 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90004a37798 EFLAGS: 00010246
RAX: 7bd43406166ed700 RBX: 1ffff92000946ef8 RCX: ffff88802ab70000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004a37828 R08: ffffffff81588072 R09: fffffbfff1c39b48
R10: dffffc0000000000 R11: fffffbfff1c39b48 R12: dffffc0000000000
R13: 1ffff92000946ef4 R14: ffffc90004a377c0 R15: 0000000000000246
FS:  00007f93bf3496c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020b63fe4 CR3: 000000002a1e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_read_unlock_irqrestore include/linux/rwlock_api_smp.h:241 [inline]
 _raw_read_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:268
 send_sigurg+0x36a/0x3c0 fs/fcntl.c:858
 sk_send_sigurg+0x6e/0xc0 net/core/sock.c:3412
 tcp_check_urg+0x207/0x740 net/ipv4/tcp_input.c:5777
 tcp_urg+0x15c/0x450 net/ipv4/tcp_input.c:5818
 tcp_rcv_established+0xfac/0x2020 net/ipv4/tcp_input.c:6167
 tcp_v6_do_rcv+0xa09/0x1300 net/ipv6/tcp_ipv6.c:1644
 sk_backlog_rcv include/net/sock.h:1106 [inline]
 __release_sock+0x1c8/0x350 net/core/sock.c:2984
 release_sock+0x61/0x1f0 net/core/sock.c:3550
 tcp_sendmsg+0x3a/0x50 net/ipv4/tcp.c:1343
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xef/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f93be67de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f93bf3490c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f93be7abf80 RCX: 00007f93be67de69
RDX: 0000000000000002 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00007f93be6ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f93be7abf80 R15: 00007ffd71560168
 </TASK>


Tested on:

commit:         13a2e429 Merge tag 'perf-tools-fixes-for-v6.9-2024-04-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15316e10980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6e826cf3c9c6ffc
dashboard link: https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11fa4e07180000


