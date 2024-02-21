Return-Path: <linux-kernel+bounces-74591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76C85D677
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436E728469E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A13F8E4;
	Wed, 21 Feb 2024 11:08:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D743D974
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513702; cv=none; b=se4OrwXNAPlg0UBAW6l3nmv+3e1xwWW5i6rT3Ptfeqyf1uTFy1Bz4fgXIBP7f3Nby1ArfswIbVEk5ijnZBQz0BataTxRTu3f1dVHBExzBe/8AT1u8a8ncbqLCsYnmgkaI5/tW6nF3AknoRPoaoopBhr0DV7ABsPx8WoGnrjt9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513702; c=relaxed/simple;
	bh=lQawOJS6dFCogScAuQLn4vV25EU0ccc4Vkr0aDx3Lac=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OfJN2AAnZm6yW+5MRwQOD1/cfutVsh4N8IPEATb/iVXorpXwiALTAP1RPdtSqj122B3UHswQexlGoKS1Su9sgkaKLCxwt++b+14GpA3KJc3f4i2bEseRfuIPrIz+tWE8/dAcCdd0cZoK9JTueP7tB/xnC/7EwWUasdpDDLTaoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3651fd50053so43147775ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513700; x=1709118500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9a+EyhpFXVw97MBpEci4wIUex1rfag7eWUaEzpmAUw=;
        b=WW6uBLA7jsHjUZ4/lkXsEiMZ7lyVvQvzqRe/B6cR6SzLDwYP7evAUtC709ohoI4KFl
         kxzSsaF7qC7kFf/JwmRqsoPrB/WvzSToY/FvkGzX5IxjRhYEPRWYMwXXktz8bZYT7EPZ
         Wh+6zpH6GxjTviwDrCOuowPImMS/EpnjGENAh22ykDqioJw6rIeUeaeOmrfvduN2Ygfn
         sm4oZH2+H2aOQyho8m9h8fK1LZSFMdbeNOJWY1BARQFfCZgXEMQqPo1dKuqkblQfmraH
         weZk8AvPV8vdfmRre+/QcCZ4JfiQnrt5/F9h/W9Wm8wUkEhuIrhbCd6VhEnGK7kcIs+H
         ym3w==
X-Forwarded-Encrypted: i=1; AJvYcCWVIrbg8wPqa8i5NOcS6qMSuWmespLPWT6VcHYEgWaHw0ekmGhowtKZflNcdO31a27tMwT5kJx9ZeLDMWfp7iN5deBMsktmpyvSzWNC
X-Gm-Message-State: AOJu0Yzdo3Yp0JobmahDP2Ukoc7oxEf6LmN/Fyno7orA2i9DMEefRcD6
	sR5kq22jV1aMJu16nIDuYv4NRDg5OQiEjof6rY2WzOzhswmxeZj/r82A1+/dgOrL9kfHgBWdm0+
	tuD4jHpzgrTe3I0y/j8VPUu4kDRo3Xjba6eJzBQ5td5b/r31rYh8RGRI=
X-Google-Smtp-Source: AGHT+IFm3FyKN+CoA8ol7iaen95Tc5OlPlWPBOXxYOIZ9HeunGi+HGiTMD4rzmXCajcqvmuF2tOHSUMHG5Sha7XxDyIWd9OL/uQL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188c:b0:365:21f4:7030 with SMTP id
 o12-20020a056e02188c00b0036521f47030mr1052525ilu.4.1708513700065; Wed, 21 Feb
 2024 03:08:20 -0800 (PST)
Date: Wed, 21 Feb 2024 03:08:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fbad30611e25849@google.com>
Subject: [syzbot] [ppp?] possible deadlock in ppp_asynctty_ioctl
From: syzbot <syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fca7526b7d89 drm/tests/drm_buddy: fix build failure on 32-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170edffc180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7cea39e8c4d7d3
dashboard link: https://syzkaller.appspot.com/bug?extid=8e808eb853386f575d86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee1932a6c45a/disk-fca7526b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f525fc08e238/vmlinux-fca7526b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd501b251c05/bzImage-fca7526b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-rc5-syzkaller-00002-gfca7526b7d89 #0 Not tainted
--------------------------------------------------------
syz-executor.4/9979 just changed the state of lock:
ffffffff8ebf32f8 (disc_data_lock){.?..}-{2:2}, at: ap_get drivers/net/ppp/ppp_async.c:137 [inline]
ffffffff8ebf32f8 (disc_data_lock){.?..}-{2:2}, at: ppp_asynctty_ioctl+0x36/0x3f0 drivers/net/ppp/ppp_async.c:286
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&port_lock_key){-.-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(disc_data_lock);
                               local_irq_disable();
                               lock(&port_lock_key);
                               lock(disc_data_lock);
  <Interrupt>
    lock(&port_lock_key);

 *** DEADLOCK ***

1 lock held by syz-executor.4/9979:
 #0: ffff88802f1dc0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243

the shortest dependencies between 2nd lock and 1st lock:
 -> (&port_lock_key){-.-.}-{2:2} {
    IN-HARDIRQ-W at:
                      lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
                      serial8250_handle_irq+0x81/0x710 drivers/tty/serial/8250/8250_port.c:1913
                      serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1962
                      serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
                      __handle_irq_event_percpu+0x289/0xa30 kernel/irq/handle.c:158
                      handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                      handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                      handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                      generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                      handle_irq arch/x86/kernel/irq.c:238 [inline]
                      __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
                      common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                      asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
                      __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                      _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                      spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                      uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inline]
                      serial_port_runtime_resume+0x204/0x2b0 drivers/tty/serial/serial_port.c:41
                      __rpm_callback+0x2df/0x790 drivers/base/power/runtime.c:393
                      rpm_callback drivers/base/power/runtime.c:447 [inline]
                      rpm_resume+0x10b1/0x1af0 drivers/base/power/runtime.c:913
                      pm_runtime_work+0x147/0x210 drivers/base/power/runtime.c:978
                      process_one_work kernel/workqueue.c:2633 [inline]
                      process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
                      worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
                      kthread+0x2ef/0x390 kernel/kthread.c:388
                      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                      ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
    IN-SOFTIRQ-W at:
                      lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
                      serial8250_handle_irq+0x81/0x710 drivers/tty/serial/8250/8250_port.c:1913
                      serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1962
                      serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
                      __handle_irq_event_percpu+0x289/0xa30 kernel/irq/handle.c:158
                      handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                      handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                      handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                      generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                      handle_irq arch/x86/kernel/irq.c:238 [inline]
                      __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
                      common_interrupt+0x4f/0xd0 arch/x86/kernel/irq.c:247
                      asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
                      arch_local_irq_enable arch/x86/include/asm/irqflags.h:77 [inline]
                      __do_softirq+0x1da/0x942 kernel/softirq.c:537
                      invoke_softirq kernel/softirq.c:427 [inline]
                      __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
                      irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
                      sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
                      console_flush_all+0x9cc/0xec0
                      console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3036
                      vprintk_emit+0x508/0x720 kernel/printk/printk.c:2303
                      _printk+0xd5/0x120 kernel/printk/printk.c:2328
                      check_stack_usage kernel/exit.c:785 [inline]
                      do_exit+0x1d41/0x2740 kernel/exit.c:914
                      do_group_exit+0x206/0x2c0 kernel/exit.c:1020
                      __do_sys_exit_group kernel/exit.c:1031 [inline]
                      __se_sys_exit_group kernel/exit.c:1029 [inline]
                      __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
                      do_syscall_64+0xf9/0x240
                      entry_SYSCALL_64_after_hwframe+0x6f/0x77
    INITIAL USE at:
                     lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                     uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
                     serial8250_do_set_termios+0x531/0x17e0 drivers/tty/serial/8250/8250_port.c:2793
                     uart_set_options+0x3eb/0x730 drivers/tty/serial/serial_core.c:2320
                     serial8250_console_setup+0x3db/0x670 drivers/tty/serial/8250/8250_port.c:3507
                     univ8250_console_setup+0x3ac/0x470 drivers/tty/serial/8250/8250_core.c:632
                     try_enable_preferred_console+0x40d/0x560 kernel/printk/printk.c:3302
                     register_console+0x261/0xcd0 kernel/printk/printk.c:3479
                     univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:717
                     console_init+0x198/0x680 kernel/printk/printk.c:3688
                     start_kernel+0x2d2/0x500 init/main.c:1008
                     x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:555
                     x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:536
                     secondary_startup_64_no_verify+0x171/0x17b
  }
  ... key      at: [<ffffffff9477a680>] port_lock_key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   ap_get drivers/net/ppp/ppp_async.c:137 [inline]
   ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:353
   tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
   tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
   serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
   serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1942
   serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1962
   serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
   __handle_irq_event_percpu+0x289/0xa30 kernel/irq/handle.c:158
   handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
   handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
   handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
   generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
   handle_irq arch/x86/kernel/irq.c:238 [inline]
   __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
   common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
   asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
   check_kcov_mode kernel/kcov.c:175 [inline]
   write_comp_data kernel/kcov.c:236 [inline]
   __sanitizer_cov_trace_cmp8+0x34/0x90 kernel/kcov.c:284
   on_stack arch/x86/include/asm/stacktrace.h:60 [inline]
   unwind_next_frame+0x1df4/0x29e0 arch/x86/kernel/unwind_orc.c:665
   arch_stack_walk+0x150/0x1b0 arch/x86/kernel/stacktrace.c:25
   stack_trace_save+0x117/0x1d0 kernel/stacktrace.c:122
   kasan_save_stack mm/kasan/common.c:47 [inline]
   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
   kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
   poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
   __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
   kasan_slab_free include/linux/kasan.h:184 [inline]
   slab_free_hook mm/slub.c:2121 [inline]
   slab_free mm/slub.c:4299 [inline]
   kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
   vma_lock_free kernel/fork.c:451 [inline]
   __vm_area_free+0xe0/0x110 kernel/fork.c:507
   remove_vma mm/mmap.c:146 [inline]
   exit_mmap+0x6a9/0xd40 mm/mmap.c:3303
   __mmput+0x115/0x3c0 kernel/fork.c:1343
   exit_mm+0x21f/0x310 kernel/exit.c:569
   do_exit+0x9af/0x2740 kernel/exit.c:858
   do_group_exit+0x206/0x2c0 kernel/exit.c:1020
   __do_sys_exit_group kernel/exit.c:1031 [inline]
   __se_sys_exit_group kernel/exit.c:1029 [inline]
   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
   do_syscall_64+0xf9/0x240
   entry_SYSCALL_64_after_hwframe+0x6f/0x77

-> (disc_data_lock){.?..}-{2:2} {
   IN-HARDIRQ-R at:
                    lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    ap_get drivers/net/ppp/ppp_async.c:137 [inline]
                    ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:353
                    tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
                    tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
                    serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
                    serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1942
                    serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1962
                    serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
                    __handle_irq_event_percpu+0x289/0xa30 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                    handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
                    check_kcov_mode kernel/kcov.c:175 [inline]
                    write_comp_data kernel/kcov.c:236 [inline]
                    __sanitizer_cov_trace_cmp8+0x34/0x90 kernel/kcov.c:284
                    on_stack arch/x86/include/asm/stacktrace.h:60 [inline]
                    unwind_next_frame+0x1df4/0x29e0 arch/x86/kernel/unwind_orc.c:665
                    arch_stack_walk+0x150/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x117/0x1d0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                    kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
                    poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
                    __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
                    kasan_slab_free include/linux/kasan.h:184 [inline]
                    slab_free_hook mm/slub.c:2121 [inline]
                    slab_free mm/slub.c:4299 [inline]
                    kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
                    vma_lock_free kernel/fork.c:451 [inline]
                    __vm_area_free+0xe0/0x110 kernel/fork.c:507
                    remove_vma mm/mmap.c:146 [inline]
                    exit_mmap+0x6a9/0xd40 mm/mmap.c:3303
                    __mmput+0x115/0x3c0 kernel/fork.c:1343
                    exit_mm+0x21f/0x310 kernel/exit.c:569
                    do_exit+0x9af/0x2740 kernel/exit.c:858
                    do_group_exit+0x206/0x2c0 kernel/exit.c:1020
                    __do_sys_exit_group kernel/exit.c:1031 [inline]
                    __se_sys_exit_group kernel/exit.c:1029 [inline]
                    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
                    do_syscall_64+0xf9/0x240
                    entry_SYSCALL_64_after_hwframe+0x6f/0x77
   HARDIRQ-ON-R at:
                    lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    ap_get drivers/net/ppp/ppp_async.c:137 [inline]
                    ppp_asynctty_ioctl+0x36/0x3f0 drivers/net/ppp/ppp_async.c:286
                    tty_ioctl+0x99d/0xdc0 drivers/tty/tty_io.c:2812
                    vfs_ioctl fs/ioctl.c:51 [inline]
                    __do_sys_ioctl fs/ioctl.c:871 [inline]
                    __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
                    do_syscall_64+0xf9/0x240
                    entry_SYSCALL_64_after_hwframe+0x6f/0x77
   INITIAL USE at:
                   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                   ppp_asynctty_close+0x29/0x190 drivers/net/ppp/ppp_async.c:220
                   tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:607
                   tty_ldisc_release+0x174/0x200 drivers/tty/tty_ldisc.c:775
                   tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1696
                   tty_release+0xd0c/0x12c0 drivers/tty/tty_io.c:1867
                   __fput+0x429/0x8a0 fs/file_table.c:376
                   __do_sys_close fs/open.c:1554 [inline]
                   __se_sys_close fs/open.c:1539 [inline]
                   __x64_sys_close+0x7e/0x110 fs/open.c:1539
                   do_syscall_64+0xf9/0x240
                   entry_SYSCALL_64_after_hwframe+0x6f/0x77
   INITIAL READ USE at:
                        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        ap_get drivers/net/ppp/ppp_async.c:137 [inline]
                        ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:353
                        tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
                        tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
                        serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
                        serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1942
                        serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1962
                        serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:127
                        __handle_irq_event_percpu+0x289/0xa30 kernel/irq/handle.c:158
                        handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                        handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                        handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                        generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                        handle_irq arch/x86/kernel/irq.c:238 [inline]
                        __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
                        common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                        asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
                        check_kcov_mode kernel/kcov.c:175 [inline]
                        write_comp_data kernel/kcov.c:236 [inline]
                        __sanitizer_cov_trace_cmp8+0x34/0x90 kernel/kcov.c:284
                        on_stack arch/x86/include/asm/stacktrace.h:60 [inline]
                        unwind_next_frame+0x1df4/0x29e0 arch/x86/kernel/unwind_orc.c:665
                        arch_stack_walk+0x150/0x1b0 arch/x86/kernel/stacktrace.c:25
                        stack_trace_save+0x117/0x1d0 kernel/stacktrace.c:122
                        kasan_save_stack mm/kasan/common.c:47 [inline]
                        kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                        kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
                        poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
                        __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
                        kasan_slab_free include/linux/kasan.h:184 [inline]
                        slab_free_hook mm/slub.c:2121 [inline]
                        slab_free mm/slub.c:4299 [inline]
                        kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
                        vma_lock_free kernel/fork.c:451 [inline]
                        __vm_area_free+0xe0/0x110 kernel/fork.c:507
                        remove_vma mm/mmap.c:146 [inline]
                        exit_mmap+0x6a9/0xd40 mm/mmap.c:3303
                        __mmput+0x115/0x3c0 kernel/fork.c:1343
                        exit_mm+0x21f/0x310 kernel/exit.c:569
                        do_exit+0x9af/0x2740 kernel/exit.c:858
                        do_group_exit+0x206/0x2c0 kernel/exit.c:1020
                        __do_sys_exit_group kernel/exit.c:1031 [inline]
                        __se_sys_exit_group kernel/exit.c:1029 [inline]
                        __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
                        do_syscall_64+0xf9/0x240
                        entry_SYSCALL_64_after_hwframe+0x6f/0x77
 }
 ... key      at: [<ffffffff8ebf32f8>] disc_data_lock+0x18/0x60
 ... acquired at:
   mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
   mark_usage kernel/locking/lockdep.c:4579 [inline]
   __lock_acquire+0x10e0/0x1fd0 kernel/locking/lockdep.c:5091
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   ap_get drivers/net/ppp/ppp_async.c:137 [inline]
   ppp_asynctty_ioctl+0x36/0x3f0 drivers/net/ppp/ppp_async.c:286
   tty_ioctl+0x99d/0xdc0 drivers/tty/tty_io.c:2812
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:871 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
   do_syscall_64+0xf9/0x240
   entry_SYSCALL_64_after_hwframe+0x6f/0x77


stack backtrace:
CPU: 1 PID: 9979 Comm: syz-executor.4 Not tainted 6.8.0-rc5-syzkaller-00002-gfca7526b7d89 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 mark_lock_irq+0x867/0xc20 kernel/locking/lockdep.c:4236
 mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4579 [inline]
 __lock_acquire+0x10e0/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
 ap_get drivers/net/ppp/ppp_async.c:137 [inline]
 ppp_asynctty_ioctl+0x36/0x3f0 drivers/net/ppp/ppp_async.c:286
 tty_ioctl+0x99d/0xdc0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f4028e7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4029c0b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4028fabf80 RCX: 00007f4028e7dda9
RDX: 0000000000000000 RSI: 000000000000540b RDI: 0000000000000003
RBP: 00007f4028eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4028fabf80 R15: 00007ffc181829f8
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

