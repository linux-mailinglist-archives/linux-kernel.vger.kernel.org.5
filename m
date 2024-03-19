Return-Path: <linux-kernel+bounces-107388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D087FBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DA21F22C87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A55674B;
	Tue, 19 Mar 2024 10:33:20 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AB1CD13
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710844399; cv=none; b=LarbVOnaSqCLvwc/AxN55MlRbzWCOHKwD2OQGy1CxYtmYgN42iiVmB1LSnmKX7DJvqD5GghCJ75jZmU/uJHegKktCvFrR0tte4vP1igVrEZybmMqoU2bH3UmYaZ3Cx5Ly/ku+3XkH3XAl5cP9kUwgYTibZLqlT+8MxzshZvdZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710844399; c=relaxed/simple;
	bh=n9G6Seap7FjLajFZYVRk7Eia7g5gUzim2AU4lCJKze0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F2xnH1rzfJPM1h50yxqM+KBfSzacpbYwtJl1KHD7yM77YRILHCX+dq9bGMfAcHBZuNmpqoiga4uSBF/xsUxAq5nTugcBXbgNrp2nssb/qjvPEndxlgYWL/gkYu1cWDNBNh/aylgGC2CrQoBWHmZpJ+01r9ePEw7sWBOlsuVrhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf62a1fe7so399801339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710844397; x=1711449197;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfH616evJHoxgc9RlKueSdsKtzrhRnXKCq+xBkHhWYc=;
        b=PmMGvlqV3LWMj1YupzRUbeivYcjqRlc7rcAtlcSCSjcJ6Ia12PN5oc99V/vvus6vWy
         Ya8jt6f9K4LPp9qwC57+6BD/al1OFrLEE724NguDxzTL/5xBuffbEC3Ijy3mgDxcSGbl
         2wI5EkTNPzCS7daAXa/Fyn0nZNobCxtAKAH413XbRbYpkOfQIfFzflFFofwc5Uo/Sa0o
         TutzCrPB7+87RdXunFMVEFfaHvUOB+71UhKyRuXGmfxkdOmv9kfFJH9SWXCWYjj1G3+b
         89Q4fxqZONLuLlLiQfFI6ay/SxWXBcbkW1yANAz3FpQ0YKYkvzHR6jgAzmkKMB0Q3mw8
         4yPw==
X-Forwarded-Encrypted: i=1; AJvYcCXwVtp+lX4rB1ciyB/HTeklX+VM/Md0iQ+o6I0mmPT8NIAx51QZK5RwBdgeNvMVAwORDBAI4O4zmaLa7XNZrjET/m7hEBEQNejL8wR4
X-Gm-Message-State: AOJu0YzTrBXwoXPBkNaeZOwBz1OJ4/SYEtWrWr6XAzsW2iNSmKt5SQTI
	qmfuE3e+GZ4m/odLYUZ/J02n3uviDxhpVNjMfNlllKXeJQyM2/sCRukeT79k0c7hYpgQ8w8T0/c
	bxrAp5MGOhUAwz3wWJDlAoL5e36dt+O+TzZIy9OMvhKCPYnQCPsjL59w=
X-Google-Smtp-Source: AGHT+IEQ+82wEpKYZLgs0UzhGbaG/fopGadQHCSj12KG9g2jPIb2Kpj1qbNa3YUd/izEr61RA3aDY1mqpqSytY3Ow+SuKPX2jPrG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641f:b0:7cc:4c0:65c5 with SMTP id
 gn31-20020a056602641f00b007cc04c065c5mr175800iob.1.1710844397224; Tue, 19 Mar
 2024 03:33:17 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:33:17 -0700
In-Reply-To: <000000000000c0645805b7f982e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000901b1c0614010091@google.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
From: syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
To: a@unstable.cc, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, 
	christian@brauner.io, daniel@iogearbox.net, davem@davemloft.net, 
	dvyukov@google.com, edumazet@google.com, elver@google.com, glider@google.com, 
	hdanton@sina.com, jakub@cloudflare.com, jannh@google.com, 
	john.fastabend@gmail.com, kasan-dev@googlegroups.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mareklindner@neomailbox.ch, 
	mark.rutland@arm.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	shakeelb@google.com, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    35c3e2791756 Revert "net: Re-use and set mono_delivery_tim..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10569181180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d9fa4e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137afac9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26b55a26fc12/disk-35c3e279.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f39fa55c828/vmlinux-35c3e279.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1e0501539e6/bzImage-35c3e279.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05228-g35c3e2791756 #0 Not tainted
-----------------------------------------------------
rcu_preempt/16 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888021c65020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888021c65020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff8880b952a758
 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
which would create a new lock dependency:
 (&base->lock){-.-.}-{2:2} -> (
&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&base->lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
  add_timer_on+0x1e5/0x5c0 kernel/time/timer.c:1366
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
  lock(&htab->buckets[i].lock
);
                               local_irq_disable();
                               lock(&base->lock);
                               lock(&htab->buckets[i].lock
);
  <Interrupt>
    lock(&base->lock);

 *** DEADLOCK ***

2 locks held by rcu_preempt/16:
 #0: 
ffff8880b952a758
 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
 #1: ffffffff8e131920
 (rcu_read_lock
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&base->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
                    add_timer_on+0x1e5/0x5c0 kernel/time/timer.c:1366
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
                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                    _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
                    __run_timer_base+0x103/0x8e0 kernel/time/timer.c:2418
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
                    cpu_select_mitigations+0x3c/0xa0 arch/x86/kernel/cpu/bugs.c:148
                    arch_cpu_finalize_init+0x20/0xa0 arch/x86/kernel/cpu/common.c:2325
                    start_kernel+0x402/0x500 init/main.c:1043
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   INITIAL USE
 at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
                   __mod_timer+0x1ca/0xeb0 kernel/time/timer.c:1132
                   queue_delayed_work_on+0x15a/0x260 kernel/workqueue.c:2595
                   queue_delayed_work include/linux/workqueue.h:620 [inline]
                   crng_reseed+0xe7/0x220 drivers/char/random.c:258
                   random_init+0x1a9/0x300 drivers/char/random.c:901
                   start_kernel+0x253/0x500 init/main.c:991
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff945023c0>] init_timer_cpu.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
->
 (&htab->buckets[i].lock
){+...}-{2:2} {
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
   INITIAL USE
 at:
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
   trace_timer_start include/trace/events/timer.h:52 [inline]
   enqueue_timer+0x396/0x550 kernel/time/timer.c:663
   internal_add_timer kernel/time/timer.c:688 [inline]
   __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
   schedule_timeout+0x1b9/0x310 kernel/time/timer.c:2571
   rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
   rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 16 Comm: rcu_preempt Not tainted 6.8.0-syzkaller-05228-g35c3e2791756 #0
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
 trace_timer_start include/trace/events/timer.h:52 [inline]
 enqueue_timer+0x396/0x550 kernel/time/timer.c:663
 internal_add_timer kernel/time/timer.c:688 [inline]
 __mod_timer+0xa0e/0xeb0 kernel/time/timer.c:1183
 schedule_timeout+0x1b9/0x310 kernel/time/timer.c:2571
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

