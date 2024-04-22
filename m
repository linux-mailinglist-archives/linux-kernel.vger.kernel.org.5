Return-Path: <linux-kernel+bounces-152860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315A8AC556
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AEF1F20DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829248CDD;
	Mon, 22 Apr 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr4a8H3Y"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CF4F217;
	Mon, 22 Apr 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770346; cv=none; b=OjCXgteo2+BP8yECvH8rJOO65cl4grhJDEnraYuoisdry5wqcdqiWLTMsDO4YCRd/Z3WTelqFcLpIWz4UwJNKI+8gbORIYCubDwHMV3+YY0EZUAAcU86aQEmKfao2edYnTTI2/+/TTxNQuTvc68C4//pB0V7VMpSbf3fefkxAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770346; c=relaxed/simple;
	bh=JAoZIOG5ChPYTBBdUic+pMiDjPdCmY5kzV1e6ONkz+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EcShdRccO78XfiwLJ25R9clxuYGnA0AenITQfg9oq14VR3NMBxZeIP70i9D76CGABT25RGFmB+lLQR2r9J/8AuOd1wV8fRKJMvuXN+VWgeqPHRaYSXV4Jm+JhK+ymfQcS5VmMHPrQXpXTTEIuAXrvPGXhVm2eoCfmRhirP1UfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr4a8H3Y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed5109d924so3419016b3a.0;
        Mon, 22 Apr 2024 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713770344; x=1714375144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVOE8e81CT0jvrPWLIoXETu7jiLEFUeToj8lVThSyog=;
        b=Zr4a8H3Yol9QD3rytIbzSiMV8t/0bCOQWCmUJO3EuZq7xSTPs+e89wwmdxxeWKYtZU
         YCoZ09PY7ARnbk5L+sMVetqJghJcmplxnK3g1axNfp+8dMcvURvBYjCrhG5Ty4fBikIg
         0BaoiTPpbdEYXG8ZGO3fW+kR/TpUt/6OSeq/u8S+QLSf2+dEfQiYLeTBuYkW41wuGT+h
         mo+E4MzsDiF+4ZzvQjAEmB98fG3yX/lzw2na8JMLMVaNFkDePMTJ1X09JGNUofdLw6ct
         mQbp0QqoMCxVMJktz0Tkx+Jdcvzy/vxB6CqbJpdWu0G0MoV1m8jf1ziDngqwW2AHakWa
         ye6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770344; x=1714375144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVOE8e81CT0jvrPWLIoXETu7jiLEFUeToj8lVThSyog=;
        b=XI+ecYOltc8s1P0yFh7MXmiFl2jvmJOqiWJFqaZBeQMABLTgFMH2p3flaeERuVEiHq
         qwJe+0Z4eO4m05SELZM5mKRW3q2n8almuwZLK8H3khrHIglnRtPTM+hKQ6+o7e24nSib
         8fcTcsqcOBYBbDIjv3OOsuuqpVPzhdpffAhnNolV7/08OI2rq+UnU7p1Q3qSMG/lj7f2
         jBDAEp5p4mTC5SAkRHyMUEDqoLRz0llz4922Xd6BiYlw2P1IAsXHCIj3+YHnIKae0hby
         GhAta+R19Fv7vY5eGyN9bEtoaX48EGX1N4q5qSN35SP5CYdbGu2jfsxKFww3iL2U3qdb
         eVsg==
X-Forwarded-Encrypted: i=1; AJvYcCVc/L/sc9qqd+/IWsFAGJ3Sz3ajD1iq+aKCFriisp8uPXrY099AzsvglY2uddNLel6V0HCiYTL4X2lII1RyaKDvfWkwDlWKGP3MlMGBOxW1/gRsuHfadPTYYUcsLyDLSZnNElp76RXp4MxSR0EK3aBNPOruSoerIcNh9qfoy4hj
X-Gm-Message-State: AOJu0YwL3Miw51M2RjoL1iTXqmh6dTDpurHcMftEJb+L1DsYaZQb7CXx
	whe4pCHt1Sye2EuOcRC/ooT+RjfyHL4Old3k/udIR1Ua4+vw/NLbMY72FuCMt9M=
X-Google-Smtp-Source: AGHT+IHQQZ6oXVmf9REe65Ym1Zqu/zL7HG3tQtti567teqeR5rT+8IjKgD4ORShVrcU51fEHAZqx6A==
X-Received: by 2002:a05:6a20:3b83:b0:1aa:58d9:18fa with SMTP id b3-20020a056a203b8300b001aa58d918famr6993923pzh.48.1713770344290;
        Mon, 22 Apr 2024 00:19:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001d8edfec673sm7383356plf.214.2024.04.22.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:19:03 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jirislaby@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net,v3] net: ppp: Fix deadlock caused by unsafe-irq lock in ap_get()
Date: Mon, 22 Apr 2024 16:18:58 +0900
Message-Id: <20240422071858.140237-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0032f249-7787-4875-a782-0847c04d5c9c@kernel.org>
References: <0032f249-7787-4875-a782-0847c04d5c9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0 Not tainted
--------------------------------------------------------
kworker/u4:7/1097 just changed the state of lock:
ffffffff8ec04eb8 (disc_data_lock#2){.?..}-{2:2}, at: ap_get drivers/net/ppp/ppp_async.c:136 [inline]
ffffffff8ec04eb8 (disc_data_lock#2){.?..}-{2:2}, at: ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&port_lock_key){-.-.}-{2:2}


and interrupts could create inverse lock ordering between them.


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

4 locks held by kworker/u4:7/1097:
 #0: ffff888014c8d938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c8d938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90004e97d20 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90004e97d20 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffff88803d92b0b8 (&buf->lock){+.+.}-{3:3}, at: flush_to_ldisc+0x38/0x860 drivers/tty/tty_buffer.c:466
 #3: ffff8880751ac0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x80 drivers/tty/tty_ldisc.c:263

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
                      serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
                      console_emit_next_record kernel/printk/printk.c:2901 [inline]
                      console_flush_all+0x808/0xec0 kernel/printk/printk.c:2967
                      console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3036
                      vprintk_emit+0x508/0x720 kernel/printk/printk.c:2303
                      dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4850
                      dev_printk_emit+0xdd/0x120 drivers/base/core.c:4861
                      _dev_err+0x122/0x170 drivers/base/core.c:4916
                      __usb_hcd_giveback_urb+0x373/0x530 drivers/usb/core/hcd.c:1650
                      dummy_timer+0x8aa/0x3220 drivers/usb/gadget/udc/dummy_hcd.c:1987
                      call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
                      expire_timers kernel/time/timer.c:1751 [inline]
                      __run_timers+0x621/0x830 kernel/time/timer.c:2038
                      run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
                      __do_softirq+0x2bb/0x942 kernel/softirq.c:553
                      invoke_softirq kernel/softirq.c:427 [inline]
                      __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
                      irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
                      sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
                      xt_obj_to_user+0xeb/0x130 net/netfilter/x_tables.c:301
                      xt_compat_target_to_user+0x17e/0x3a0 net/netfilter/x_tables.c:1166
                      compat_copy_entry_to_user net/ipv6/netfilter/ip6_tables.c:1258 [inline]
                      compat_copy_entries_to_user+0x34b/0x680 net/ipv6/netfilter/ip6_tables.c:1569
                      compat_get_entries net/ipv6/netfilter/ip6_tables.c:1605 [inline]
                      do_ip6t_get_ctl+0xe46/0x1820 net/ipv6/netfilter/ip6_tables.c:1666
                      nf_getsockopt+0x299/0x2c0 net/netfilter/nf_sockopt.c:116
                      ipv6_getsockopt+0x263/0x380 net/ipv6/ipv6_sockglue.c:1488
                      tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4372
                      do_sock_getsockopt+0x373/0x850 net/socket.c:2373
                      __sys_getsockopt+0x270/0x330 net/socket.c:2402
                      __do_compat_sys_socketcall net/compat.c:494 [inline]
                      __se_compat_sys_socketcall+0x348/0x1430 net/compat.c:423
                      do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
                      __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
                      do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
                      entry_SYSENTER_compat_after_hwframe+0x7c/0x86
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
  ... key      at: [<ffffffff947ae860>] port_lock_key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   ap_get drivers/net/ppp/ppp_async.c:136 [inline]
   ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:352
   tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
   tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
   serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
   __start_tx+0x32e/0x470 drivers/tty/serial/8250/8250_port.c:1544
   serial_port_runtime_resume+0x1f0/0x2b0 drivers/tty/serial/serial_port.c:40
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

-> (disc_data_lock#2){.?..}-{2:2} {
   IN-HARDIRQ-R at:
                    lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    ap_get drivers/net/ppp/ppp_async.c:136 [inline]
                    ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:352
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
                    obj_cgroup_charge+0x34e/0x630
                    __memcg_slab_pre_alloc_hook+0x28d/0x2b0 mm/slub.c:1929
                    memcg_slab_pre_alloc_hook mm/slub.c:1950 [inline]
                    slab_pre_alloc_hook mm/slub.c:3766 [inline]
                    slab_alloc_node mm/slub.c:3842 [inline]
                    kmem_cache_alloc+0x202/0x340 mm/slub.c:3867
                    vm_area_dup+0x27/0x290 kernel/fork.c:480
                    dup_mmap kernel/fork.c:695 [inline]
                    dup_mm kernel/fork.c:1685 [inline]
                    copy_mm+0xd94/0x21b0 kernel/fork.c:1734
                    copy_process+0x1d73/0x3fc0 kernel/fork.c:2497
                    kernel_clone+0x21d/0x8d0 kernel/fork.c:2902
                    __do_compat_sys_ia32_clone arch/x86/kernel/sys_ia32.c:254 [inline]
                    __se_compat_sys_ia32_clone arch/x86/kernel/sys_ia32.c:240 [inline]
                    __ia32_compat_sys_ia32_clone+0x255/0x2a0 arch/x86/kernel/sys_ia32.c:240
                    do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
                    __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
                    do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
                    entry_SYSENTER_compat_after_hwframe+0x7c/0x86
   HARDIRQ-ON-R at:
                    lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    ap_get drivers/net/ppp/ppp_async.c:136 [inline]
                    ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
                    tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
                    tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
                    receive_buf drivers/tty/tty_buffer.c:444 [inline]
                    flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
                    process_one_work kernel/workqueue.c:2633 [inline]
                    process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
                    worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
                    kthread+0x2ef/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
   INITIAL USE at:
                   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:326
                   ppp_asynctty_close+0x29/0x190 drivers/net/ppp/ppp_async.c:219
                   tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:607
                   tty_ldisc_release+0x1a1/0x200 drivers/tty/tty_ldisc.c:775
                   tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1696
                   tty_release+0xd0c/0x12c0 drivers/tty/tty_io.c:1867
                   __fput+0x429/0x8a0 fs/file_table.c:376
                   __do_sys_close fs/open.c:1554 [inline]
                   __se_sys_close fs/open.c:1539 [inline]
                   __ia32_sys_close+0x7e/0x110 fs/open.c:1539
                   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
                   __do_fast_syscall_32+0xbd/0x120 arch/x86/entry/common.c:321
                   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:346
                   entry_SYSENTER_compat_after_hwframe+0x7c/0x86
   INITIAL READ USE at:
                        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        ap_get drivers/net/ppp/ppp_async.c:136 [inline]
                        ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:352
                        tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
                        tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
                        serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835
                        __start_tx+0x32e/0x470 drivers/tty/serial/8250/8250_port.c:1544
                        serial_port_runtime_resume+0x1f0/0x2b0 drivers/tty/serial/serial_port.c:40
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
 }
 ... key      at: [<ffffffff8ec04eb8>] disc_data_lock+0x18/0x60
 ... acquired at:
   mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
   mark_usage kernel/locking/lockdep.c:4579 [inline]
   __lock_acquire+0x10e0/0x1fd0 kernel/locking/lockdep.c:5091
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   ap_get drivers/net/ppp/ppp_async.c:136 [inline]
   ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
   tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
   tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
   receive_buf drivers/tty/tty_buffer.c:444 [inline]
   flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
   process_one_work kernel/workqueue.c:2633 [inline]
   process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
   worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
   kthread+0x2ef/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242


stack backtrace:
CPU: 1 PID: 1097 Comm: kworker/u4:7 Not tainted 6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound flush_to_ldisc
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
 ap_get drivers/net/ppp/ppp_async.c:136 [inline]
 ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
 tty_ldisc_receive_buf+0x11f/0x170 drivers/tty/tty_buffer.c:390
 tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:444 [inline]
 flush_to_ldisc+0x328/0x860 drivers/tty/tty_buffer.c:494
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

This is the stack trace for the issue causing the deadlock reported 
by syzbot. I think there is definitely a problem with ap_get() and 
this needs to be fixed.

Thanks.

