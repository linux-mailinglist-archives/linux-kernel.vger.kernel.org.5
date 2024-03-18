Return-Path: <linux-kernel+bounces-106354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E90C87ECEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13665280A78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8F53804;
	Mon, 18 Mar 2024 16:02:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C553385
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777750; cv=none; b=WEX+hHB3a6CNIZbrZMIKA1gLQAV3HP3lOsMeEdJBj+BzkYyaGsTQ+lJgU+kEW/RqlRtZgywwhj/ngrLTgHZMh30ZEeHxqh3/rC1hWEyHUFhgORRyswJ5nelU5g9daTrgLEfSRNNDVdDqcF4RpsqKhEW+3xqUbLvMBLp5K8i81So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777750; c=relaxed/simple;
	bh=7hMHJSLhWPodmmjwwhv6KZDW+M5apWEeocteOVmzSMA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L5n0nlEXud99vZW9y16fbwrmajLNdVy2KoiiHo8rNYDwl5RBT00/EGyYA6nbHa9k+X1XeZHlSFO0C9zvRcx2IPE89QtNmyz/NLj0BXC4YGcJ+fzzkqTqqZDwGtinR88ppPAPUp3V/5J5hUDeRNGAfxTX8evJ9GjPXzAWvM1vXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cb806fc9f7so451840039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777748; x=1711382548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNp1IWD8EmEN5/TncntnGpnpu/TVOuzrIsBE17NaHoM=;
        b=eK57uqTgrgdyuhx4w2dRRBkmlbrvqjKWdln8lN4Mwwu43Mhpch8yaHlT4llxv/P2mF
         6ThIZkOkhl4WKzj5kxvqXMEdFpXc7LR6L+jmw3Jxhp16b5DvmSGKmKsvCL6HvukUB+Oh
         DQHb4MtFrEcuSFvpUaMCE9+t45VTH6hvE36Ec0IeXcYD52nrTEHhNGpebUZhmZTd8ho7
         +Dc0ryl2l8D+rqauQQHWlYM2fMo6BKPWnUEhZZmCldbuhg1Ke61pL4vFzp44L7PZKqS6
         iWWR3XKD8KNMMvc0cGxtcDSz4ntuvy0Gf6e+hnpCdP49XHQKWG3/YkbxD3gwqWCza2qJ
         5qVg==
X-Forwarded-Encrypted: i=1; AJvYcCW5d3ifv143gfLSSRD4780ZYH8NF4/o1nDIo+WtArMzstm3SKOz2T8rW5kFZi5fwAKNRSwzJ0zN1J694dmSQMezkREwzaClF5cmnESc
X-Gm-Message-State: AOJu0YynmYEhofbDqq2D9PY3CpnEFlBojCNHAALAPyP9wj2tCR5++sFF
	z4S+TLS2tradNtAUdqJIkSXj5lEGSETvweZEI79gcfWRM20fvxph7k3zkGWDlxomT6z8rldf3kM
	jhh0EEIvGHh2BQt9kEP+2fNbj3Rt51XNJUHIHX8DbjHbLxb2Iis7abss=
X-Google-Smtp-Source: AGHT+IEON/XOjd4Xe5HLf/LBQHJZQn9N2XrRw5l6q4OjDRNtb7HPF8jB9wWUVxrQbsTbppGOktaObVVoJ8i//3KldzNZnx2RgSQP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1650:b0:7cc:e3b:f7ec with SMTP id
 y16-20020a056602165000b007cc0e3bf7ecmr269361iow.0.1710777747368; Mon, 18 Mar
 2024 09:02:27 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:02:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebfbdb0613f17b0d@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in try_to_wake_up (4)
From: syzbot <syzbot+21f93e66c95001d6f61a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0740b6427e90 Merge branch 'bpf-arena-followups'
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=14785c6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=21f93e66c95001d6f61a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1240e879180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c9c546180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/disk-0740b642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmlinux-0740b642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead/bzImage-0740b642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21f93e66c95001d6f61a@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05226-g0740b6427e90 #0 Not tainted
-----------------------------------------------------
kworker/u8:1/11 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888021ba0578 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888021ba0578 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff888017ba2810 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
ffff888017ba2810 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
which would create a new lock dependency:
 (&p->pi_lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&p->pi_lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
  try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
  autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
  __wake_up_common kernel/sched/wait.c:89 [inline]
  __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
  irq_work_single+0xe2/0x240 kernel/irq_work.c:221
  irq_work_run_list kernel/irq_work.c:252 [inline]
  irq_work_run+0x18b/0x350 kernel/irq_work.c:261
  __sysvec_irq_work+0xa8/0x3e0 arch/x86/kernel/irq_work.c:22
  instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
  sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
  asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
  __wrmsr arch/x86/include/asm/msr.h:96 [inline]
  native_write_msr arch/x86/include/asm/msr.h:160 [inline]
  wrmsr arch/x86/include/asm/msr.h:269 [inline]
  native_apic_msr_write+0x39/0x50 arch/x86/include/asm/apic.h:207
  __apic_send_IPI_self arch/x86/include/asm/apic.h:458 [inline]
  arch_irq_work_raise+0x6f/0x80 arch/x86/kernel/irq_work.c:31
  irq_work_queue+0xa7/0x150 kernel/irq_work.c:124
  __kfence_alloc+0x22e/0x370 mm/kfence/core.c:1088
  kfence_alloc include/linux/kfence.h:129 [inline]
  slab_alloc_node mm/slub.c:3846 [inline]
  __do_kmalloc_node mm/slub.c:3980 [inline]
  __kmalloc+0x41c/0x4a0 mm/slub.c:3994
  kmalloc include/linux/slab.h:594 [inline]
  kzalloc include/linux/slab.h:711 [inline]
  alloc_workqueue+0x1b0/0x20c0 kernel/workqueue.c:5542
  init_mm_internals+0x17/0x120 mm/vmstat.c:2122
  kernel_init_freeable+0x403/0x5d0 init/main.c:1543
  kernel_init+0x1d/0x2a0 init/main.c:1446
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

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
                               lock(&p->pi_lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&p->pi_lock);

 *** DEADLOCK ***

4 locks held by kworker/u8:1/11:
 #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90000107d00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000107d00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffff888017ba2810 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
 #2: ffff888017ba2810 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&p->pi_lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
                    try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
                    autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
                    __wake_up_common kernel/sched/wait.c:89 [inline]
                    __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
                    irq_work_single+0xe2/0x240 kernel/irq_work.c:221
                    irq_work_run_list kernel/irq_work.c:252 [inline]
                    irq_work_run+0x18b/0x350 kernel/irq_work.c:261
                    __sysvec_irq_work+0xa8/0x3e0 arch/x86/kernel/irq_work.c:22
                    instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
                    sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
                    asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
                    __wrmsr arch/x86/include/asm/msr.h:96 [inline]
                    native_write_msr arch/x86/include/asm/msr.h:160 [inline]
                    wrmsr arch/x86/include/asm/msr.h:269 [inline]
                    native_apic_msr_write+0x39/0x50 arch/x86/include/asm/apic.h:207
                    __apic_send_IPI_self arch/x86/include/asm/apic.h:458 [inline]
                    arch_irq_work_raise+0x6f/0x80 arch/x86/kernel/irq_work.c:31
                    irq_work_queue+0xa7/0x150 kernel/irq_work.c:124
                    __kfence_alloc+0x22e/0x370 mm/kfence/core.c:1088
                    kfence_alloc include/linux/kfence.h:129 [inline]
                    slab_alloc_node mm/slub.c:3846 [inline]
                    __do_kmalloc_node mm/slub.c:3980 [inline]
                    __kmalloc+0x41c/0x4a0 mm/slub.c:3994
                    kmalloc include/linux/slab.h:594 [inline]
                    kzalloc include/linux/slab.h:711 [inline]
                    alloc_workqueue+0x1b0/0x20c0 kernel/workqueue.c:5542
                    init_mm_internals+0x17/0x120 mm/vmstat.c:2122
                    kernel_init_freeable+0x403/0x5d0 init/main.c:1543
                    kernel_init+0x1d/0x2a0 init/main.c:1446
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
                    try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
                    call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
                    expire_timers kernel/time/timer.c:1843 [inline]
                    __run_timers kernel/time/timer.c:2408 [inline]
                    __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
                    run_timer_base kernel/time/timer.c:2428 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
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
                    rest_init+0x2e0/0x300 init/main.c:730
                    arch_call_rest_init+0xe/0x10 init/main.c:831
                    start_kernel+0x47a/0x500 init/main.c:1077
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   sched_cgroup_fork+0x33/0x410 kernel/sched/core.c:4828
                   copy_process+0x2217/0x3df0 kernel/fork.c:2498
                   kernel_clone+0x21e/0x8d0 kernel/fork.c:2796
                   user_mode_thread+0x132/0x1a0 kernel/fork.c:2874
                   rest_init+0x27/0x300 init/main.c:695
                   arch_call_rest_init+0xe/0x10 init/main.c:831
                   start_kernel+0x47a/0x500 init/main.c:1077
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff926bf780>] rt_mutex_init_task.__key+0x0/0x20

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
   trace_sched_migrate_task include/trace/events/sched.h:274 [inline]
   set_task_cpu+0x53d/0x5b0 kernel/sched/core.c:3390
   try_to_wake_up+0x75b/0x1470 kernel/sched/core.c:4372
   wake_up_process kernel/sched/core.c:4510 [inline]
   wake_up_q+0xc8/0x120 kernel/sched/core.c:1029
   __mutex_unlock_slowpath+0x6f9/0x750 kernel/locking/mutex.c:956
   synchronize_rcu_expedited+0x697/0x820 kernel/rcu/tree_exp.h:959
   synchronize_rcu+0x136/0x3e0 kernel/rcu/tree.c:3611
   sock_hash_free+0xac/0x820 net/core/sock_map.c:1144
   bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
   process_one_work kernel/workqueue.c:3254 [inline]
   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
   kthread+0x2f0/0x390 kernel/kthread.c:388
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted 6.8.0-syzkaller-05226-g0740b6427e90 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound bpf_map_free_deferred
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
 trace_sched_migrate_task include/trace/events/sched.h:274 [inline]
 set_task_cpu+0x53d/0x5b0 kernel/sched/core.c:3390
 try_to_wake_up+0x75b/0x1470 kernel/sched/core.c:4372
 wake_up_process kernel/sched/core.c:4510 [inline]
 wake_up_q+0xc8/0x120 kernel/sched/core.c:1029
 __mutex_unlock_slowpath+0x6f9/0x750 kernel/locking/mutex.c:956
 synchronize_rcu_expedited+0x697/0x820 kernel/rcu/tree_exp.h:959
 synchronize_rcu+0x136/0x3e0 kernel/rcu/tree.c:3611
 sock_hash_free+0xac/0x820 net/core/sock_map.c:1144
 bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 11 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted 6.8.0-syzkaller-05226-g0740b6427e90 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 9e 69 01 04 00 74 06 90 c3 cc cc cc cc c6 05 8f 69 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 e5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000107338 EFLAGS: 00010246
RAX: 5cdc287fd92d5000 RBX: 1ffff92000020e6c RCX: ffff8880172abc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900001073d0 R08: ffffffff8157cc12 R09: 1ffffffff1f0d5c5
R10: dffffc0000000000 R11: fffffbfff1f0d5c6 R12: dffffc0000000000
R13: 1ffff92000020e68 R14: ffffc90000107360 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555942e1ca8 CR3: 0000000066096000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
 class_raw_spinlock_irqsave_destructor include/linux/spinlock.h:553 [inline]
 try_to_wake_up+0x902/0x1470 kernel/sched/core.c:4262
 wake_up_process kernel/sched/core.c:4510 [inline]
 wake_up_q+0xc8/0x120 kernel/sched/core.c:1029
 __mutex_unlock_slowpath+0x6f9/0x750 kernel/locking/mutex.c:956
 synchronize_rcu_expedited+0x697/0x820 kernel/rcu/tree_exp.h:959
 synchronize_rcu+0x136/0x3e0 kernel/rcu/tree.c:3611
 sock_hash_free+0xac/0x820 net/core/sock_map.c:1144
 bpf_map_free_deferred+0xe6/0x110 kernel/bpf/syscall.c:734
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

