Return-Path: <linux-kernel+bounces-127003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D298945A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448F41C215E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A753E0C;
	Mon,  1 Apr 2024 19:44:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7417552
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000670; cv=none; b=qTI3YAbZ4ImaPupIYkM1rPpo2vGAAu3UllrCpILV8PBmPZDnN6xvRf4674YnDYRbPzsJCZD4etKdXPONIBmT+PtO95XLID0hPUhYkWJazwggccFBMQ6XkcG6Sw5ovcoHeU32GgXXlAx91Rq6aUYQuJ1vBW7NnAA8pto7bPK6ZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000670; c=relaxed/simple;
	bh=O6i2Zde2BV24SENW7hl4tITq8chAqFaz8Umt/u+aXeQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tT3pXbKHpXnuE43xSUjT17xZTUo3XV2c/O29UYfZF61Kb2/EI9970J0k0NUsKcotSuiUJH2R1VCanBD7x4jDT4TGx9QJg9tIFn9ej8HJj9hI7kzfIrjpZkyrRhLd0o8zI3BBmRxWUMAQfnoBsXF21PfVV7t9KyzLf2r2m1mujns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so485940939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000667; x=1712605467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kh+dk4s6wdLLkVBw8N7GvJYZPYuPArn8EtRW/88yBHA=;
        b=miSeKtsndpqj63u428zAGrWLxpnxXQGCevNsrayDq78elNdZBgfpRUWHyjE0sUyXb3
         uosR+EMvH9Wu7Rsl+2i1wTy9/zdPmDN1qUBDGRgEZ5EyMuPsPKhwlYwhrXC6bzWoSsJn
         wtce9Ms7obRXAmI8dTVeY122XZwjfI0HA7GhTFyv86ElzTurXx/segrvjp7L/PlkWj2X
         OooJaE4YPJq8cVLydyGvTM/km04AVULVk/wHCf18EGnWzsJe7KpVJftfe1qDuyswb/K6
         ysVeOByApt0zlvZ1l6tgJJWnUOhAATTygJBPzmEOEvOU3P5wb7rBTWTBF9Z30h21IDpe
         bo5A==
X-Forwarded-Encrypted: i=1; AJvYcCUhkzR01O2lCmuXGsFU+BP/l4rArgvyJjIoueiOmM0dWzRv1kBP0uVFF2OyGb5UKOxJPxIZdJkWAwa3RXGmfBkRNARifKkrOc8jKuIW
X-Gm-Message-State: AOJu0Yz7fT56fMTo/UFM8tmG6WhVuacScz/ulVv5fwSCe3JB3b9wsL67
	Oso3ZvsMbMo9o05UJ+zwCIRA64Snndwm99kzoPsG5LyzZCd/2igdDWrmccv6hHOssKsv3LZVvKZ
	7ZyMWaFgjM7teq8YOh5eWvj0SBxJVZMihj80wtZnUwKvLkqD99POGif0=
X-Google-Smtp-Source: AGHT+IElqdptbVn+sPMltaqJlRDZdB8ZHG4TSSLQK/YaRs5R0AAVub+wzmFAOGOUzj2d1A1EKQLcLJOLaHFobJU2JZ29aAy0pLqB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e01:b0:368:a57b:692 with SMTP id
 g1-20020a056e021e0100b00368a57b0692mr650052ila.5.1712000667741; Mon, 01 Apr
 2024 12:44:27 -0700 (PDT)
Date: Mon, 01 Apr 2024 12:44:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a803d606150e375c@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sched_tick
From: syzbot <syzbot+a1d7495c905fa16bea17@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6bd6c933339 Add linux-next specific files for 20240328
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=152c42c5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
dashboard link: https://syzkaller.appspot.com/bug?extid=a1d7495c905fa16bea17
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1d7495c905fa16bea17@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.9.0-rc1-next-20240328-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.4/5791 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88807672ec68 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88807672ec68 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff8880b943e698 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
which would create a new lock dependency:
 (&rq->__lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&rq->__lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
  raw_spin_rq_lock kernel/sched/sched.h:1397 [inline]
  rq_lock kernel/sched/sched.h:1711 [inline]
  sched_tick+0xa1/0x6e0 kernel/sched/core.c:5679
  update_process_times+0x202/0x230 kernel/time/timer.c:2491
  tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
  tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
  timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x29c/0xa80 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
  handle_level_irq+0x3c5/0x6e0 kernel/irq/chip.c:648
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  __setup_irq+0x1335/0x1e20 kernel/irq/manage.c:1823
  request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2207
  request_irq include/linux/interrupt.h:171 [inline]
  setup_default_timer_irq+0x25/0x60 arch/x86/kernel/time.c:70
  x86_late_time_init+0x66/0xc0 arch/x86/kernel/time.c:94
  start_kernel+0x3f3/0x500 init/main.c:1042
  x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
  x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
  common_startup_64+0x13e/0x147

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007
  sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:581
  map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
  __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
  do_syscall_64+0xfb/0x240
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&rq->__lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&rq->__lock);

 *** DEADLOCK ***

2 locks held by syz-executor.4/5791:
 #0: ffff8880b943e698 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2395 [inline]
 #1: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x244/0x580 kernel/trace/bpf_trace.c:2439

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&rq->__lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                    raw_spin_rq_lock kernel/sched/sched.h:1397 [inline]
                    rq_lock kernel/sched/sched.h:1711 [inline]
                    sched_tick+0xa1/0x6e0 kernel/sched/core.c:5679
                    update_process_times+0x202/0x230 kernel/time/timer.c:2491
                    tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
                    tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
                    timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
                    __handle_irq_event_percpu+0x29c/0xa80 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                    handle_level_irq+0x3c5/0x6e0 kernel/irq/chip.c:648
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    __setup_irq+0x1335/0x1e20 kernel/irq/manage.c:1823
                    request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2207
                    request_irq include/linux/interrupt.h:171 [inline]
                    setup_default_timer_irq+0x25/0x60 arch/x86/kernel/time.c:70
                    x86_late_time_init+0x66/0xc0 arch/x86/kernel/time.c:94
                    start_kernel+0x3f3/0x500 init/main.c:1042
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
                    common_startup_64+0x13e/0x147
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                    raw_spin_rq_lock kernel/sched/sched.h:1397 [inline]
                    rq_lock kernel/sched/sched.h:1711 [inline]
                    ttwu_queue kernel/sched/core.c:4055 [inline]
                    try_to_wake_up+0x7d3/0x1470 kernel/sched/core.c:4378
                    call_timer_fn+0x18e/0x650 kernel/time/timer.c:1793
                    expire_timers kernel/time/timer.c:1844 [inline]
                    __run_timers kernel/time/timer.c:2418 [inline]
                    __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2429
                    run_timer_base kernel/time/timer.c:2438 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2448
                    __do_softirq+0x2c6/0x980 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0x13/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x22f/0x5d0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
                    rest_init+0x2dc/0x300 init/main.c:738
                    start_kernel+0x47a/0x500 init/main.c:1080
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                   raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                   raw_spin_rq_lock kernel/sched/sched.h:1397 [inline]
                   _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1416 [inline]
                   rq_lock_irqsave kernel/sched/sched.h:1695 [inline]
                   rq_attach_root+0xee/0x540 kernel/sched/topology.c:494
                   sched_init+0x64e/0xc30 kernel/sched/core.c:10041
                   start_kernel+0x1ab/0x500 init/main.c:951
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff92930080>] sched_init.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007
                    sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:581
                    map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
                    __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
                    __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
                    __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
                    __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_update_common+0x20c/0xa30 net/core/sock_map.c:1007
                   sock_map_update_elem_sys+0x5a4/0x910 net/core/sock_map.c:581
                   map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
                   __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
                   __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
                   __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
                   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff94aee2e0>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
   bpf_prog_2c29ac5cdc6b1842+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
   __bpf_prog_run include/linux/filter.h:667 [inline]
   bpf_prog_run include/linux/filter.h:674 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2396 [inline]
   bpf_trace_run4+0x334/0x580 kernel/trace/bpf_trace.c:2439
   __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
   trace_sched_switch include/trace/events/sched.h:222 [inline]
   __schedule+0x2587/0x4a50 kernel/sched/core.c:6743
   preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6925
   preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6949
   preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
   class_preempt_destructor include/linux/preempt.h:480 [inline]
   try_to_wake_up+0x9a8/0x1470 kernel/sched/core.c:4385
   wake_up_process kernel/sched/core.c:4510 [inline]
   wake_up_q+0xc8/0x120 kernel/sched/core.c:1029
   futex_wake+0x523/0x5c0 kernel/futex/waitwake.c:199
   do_futex+0x392/0x560 kernel/futex/syscalls.c:107
   __do_sys_futex kernel/futex/syscalls.c:179 [inline]
   __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 0 PID: 5791 Comm: syz-executor.4 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
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
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:667 [inline]
 bpf_prog_run include/linux/filter.h:674 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2396 [inline]
 bpf_trace_run4+0x334/0x580 kernel/trace/bpf_trace.c:2439
 __traceiter_sched_switch+0x98/0xd0 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2587/0x4a50 kernel/sched/core.c:6743
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6925
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6949
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 try_to_wake_up+0x9a8/0x1470 kernel/sched/core.c:4385
 wake_up_process kernel/sched/core.c:4510 [inline]
 wake_up_q+0xc8/0x120 kernel/sched/core.c:1029
 futex_wake+0x523/0x5c0 kernel/futex/waitwake.c:199
 do_futex+0x392/0x560 kernel/futex/syscalls.c:107
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fbc0887dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc09678178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fbc089abf88 RCX: 00007fbc0887dda9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fbc089abf8c
RBP: 00007fbc089abf80 R08: 00007fbc096790b0 R09: 00007fbc096786c0
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fbc089abf8c
R13: 000000000000000b R14: 00007ffc30232610 R15: 00007ffc302326f8
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

