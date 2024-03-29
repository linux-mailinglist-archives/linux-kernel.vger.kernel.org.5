Return-Path: <linux-kernel+bounces-125053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12535891F41
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7E528708B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D4613F00C;
	Fri, 29 Mar 2024 13:06:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8013E41A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717583; cv=none; b=QzFHJKt+5Kt54iLX3j+9/2Ue2HdjnmCjqv8nUHy60uyHV2yVRuHo2jsa9h2KjLbGcYybDrqOZQf3+9wj0AXST8m6qicaBkUq0dFgXM1OCrCx8HbVkSVCPgBqzNTb2CwGX7c24TI6m5iV/wAihFpSn3roEjJzRTv1nU52dyqt8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717583; c=relaxed/simple;
	bh=8ovlNW7/szjlK/bECUQ6scAoXLodJrB2ZD5JObgKLiY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XaUlqvx2aNJfL7riXyuWrllgc1FTdM38z9JsyKCvox8tiXqkT4ChVNrEWkrRu2JHQnooXZwvmfch+j7tZ3dzudOcMyEc53jk2oD/v89YKVfVSBCT1dLeIRPrU5e6gXnuDmS5/2hRNnn/YcjTW6BT8YoGoG8Ch4bmXtjOQ6YTwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d0330ce3d4so206473339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711717580; x=1712322380;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YnP0p+iOwXEaXmMUFQSEdcHEGqtl4hJsrYDZ6+5/KWI=;
        b=CsSx/AuDh/QSJZyRnFlg3u4SuBWpN1lOb4uQt1PkwaaAFfrFSetM3qd/ztydYmaT/U
         pETW0ruXQFdBRk/Zh07EjZzEmCwj42JMaFjkTD3qbiTGi+8LBZp6N/I9pCHWwyl3GDsq
         PXgC0sOFRTqfiJIiSDa56z8v1Q6a94r1D/1bQBTL6QzHXssgH5SZjhTIaYu7gqc8VYbM
         Zuqwqj7t0vltVcIQxskHBCVD0tAHOdBEOdDuOxCqHwAAEtneuiWCKVc/Q//CQHHESbbz
         VH/zOm4m9sh1Y4YETvls/SU21w3fp+g0oC509AcVjZQApNfSOy7838QyFSIS8MpXOv0l
         dVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnUIKyjFVv7z5dIKQOW4f+fINSu4hZeAzPLWzT81w7FZkE/3oetbcrwiRCvfJUSJYIY9q0sHHEuJY1nCAgAfYhvXGQNxdpYp4Iv+4J
X-Gm-Message-State: AOJu0Yxdo7C32BKTnCY/Vg/I3xQkiMPncigsB1emN9asml6G4tYwyG4s
	l71KNtCaXoKhBzxA9v6sKtXc0qGah1TxAjOQUjmt4nes4AePJu/UrpLjIzKv4sMLZ+X+qceCicT
	kHe7D7WgeWTDrWuvyg4zGiEtBkaYmk0v2Ow0iqyIoDeEe5GcVuVOtsN0=
X-Google-Smtp-Source: AGHT+IF9JfaRrg3bohG+NUJbYdCpZhKNIDBIznBRUlObsKeSjXXng+CqZpoFfpeSYlN28kwPxts3cBVK54cFmV1sX+MuRGmagEEC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c5:b0:47e:c495:3a19 with SMTP id
 i5-20020a05663813c500b0047ec4953a19mr56345jaj.2.1711717579990; Fri, 29 Mar
 2024 06:06:19 -0700 (PDT)
Date: Fri, 29 Mar 2024 06:06:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fbc7a0614cc4eb9@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
From: syzbot <syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=169feab1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=e4374f6c021d422de3d1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1422aeb1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17103c51180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
-----------------------------------------------------
swapper/0/0 [HC0[0]:SC1[3]:HE0:SE0] is trying to acquire:
ffffc900036083e0 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffffc900036083e0 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939

and this task is already holding:
ffff8880b943d5d8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x38e/0x1170 kernel/workqueue.c:2357
which would create a new lock dependency:
 (&pool->lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+.-.}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&pool->lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  __queue_work+0x39e/0x1170 kernel/workqueue.c:2360
  queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
  tick_nohz_activate kernel/time/tick-sched.c:1491 [inline]
  tick_setup_sched_timer+0x47c/0x790 kernel/time/tick-sched.c:1592
  hrtimer_switch_to_hres kernel/time/hrtimer.c:750 [inline]
  hrtimer_run_queues+0x33c/0x450 kernel/time/hrtimer.c:1918
  run_local_timers kernel/time/timer.c:2453 [inline]
  update_process_times+0xcf/0x220 kernel/time/timer.c:2475
  tick_periodic+0x7e/0x230 kernel/time/tick-common.c:100
  tick_handle_periodic+0x45/0x120 kernel/time/tick-common.c:112
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
  console_unlock+0xae/0x290 kernel/printk/printk.c:3042
  vprintk_emit kernel/printk/printk.c:2342 [inline]
  vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
  _printk+0xc8/0x100 kernel/printk/printk.c:2367
  __clocksource_select+0x33f/0x400 kernel/time/clocksource.c:1046
  clocksource_select kernel/time/clocksource.c:1061 [inline]
  clocksource_done_booting+0x39/0x50 kernel/time/clocksource.c:1085
  do_one_initcall+0x128/0x690 init/main.c:1241
  do_initcall_level init/main.c:1303 [inline]
  do_initcalls init/main.c:1319 [inline]
  do_basic_setup init/main.c:1338 [inline]
  kernel_init_freeable+0x69d/0xc40 init/main.c:1550
  kernel_init+0x1c/0x2a0 init/main.c:1439
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+.-.}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_free+0x130/0x820 net/core/sock_map.c:1154
  bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
  process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
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
                               lock(&pool->lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&pool->lock);

 *** DEADLOCK ***

4 locks held by swapper/0/0:
 #0: ffffc90000007cb0 (&(&krcp->monitor_work)->timer){..-.}-{0:0}, at: call_timer_fn+0x11a/0x5b0 kernel/time/timer.c:1789
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf2/0x1170 kernel/workqueue.c:2324
 #2: ffff8880b943d5d8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x38e/0x1170 kernel/workqueue.c:2357
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run1+0xdc/0x410 kernel/trace/bpf_trace.c:2419

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&pool->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    __queue_work+0x39e/0x1170 kernel/workqueue.c:2360
                    queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
                    tick_nohz_activate kernel/time/tick-sched.c:1491 [inline]
                    tick_setup_sched_timer+0x47c/0x790 kernel/time/tick-sched.c:1592
                    hrtimer_switch_to_hres kernel/time/hrtimer.c:750 [inline]
                    hrtimer_run_queues+0x33c/0x450 kernel/time/hrtimer.c:1918
                    run_local_timers kernel/time/timer.c:2453 [inline]
                    update_process_times+0xcf/0x220 kernel/time/timer.c:2475
                    tick_periodic+0x7e/0x230 kernel/time/tick-common.c:100
                    tick_handle_periodic+0x45/0x120 kernel/time/tick-common.c:112
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
                    console_unlock+0xae/0x290 kernel/printk/printk.c:3042
                    vprintk_emit kernel/printk/printk.c:2342 [inline]
                    vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
                    vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
                    _printk+0xc8/0x100 kernel/printk/printk.c:2367
                    __clocksource_select+0x33f/0x400 kernel/time/clocksource.c:1046
                    clocksource_select kernel/time/clocksource.c:1061 [inline]
                    clocksource_done_booting+0x39/0x50 kernel/time/clocksource.c:1085
                    do_one_initcall+0x128/0x690 init/main.c:1241
                    do_initcall_level init/main.c:1303 [inline]
                    do_initcalls init/main.c:1319 [inline]
                    do_basic_setup init/main.c:1338 [inline]
                    kernel_init_freeable+0x69d/0xc40 init/main.c:1550
                    kernel_init+0x1c/0x2a0 init/main.c:1439
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    __queue_work+0x39e/0x1170 kernel/workqueue.c:2360
                    call_timer_fn+0x1a0/0x5b0 kernel/time/timer.c:1792
                    expire_timers kernel/time/timer.c:1838 [inline]
                    __run_timers+0x567/0xab0 kernel/time/timer.c:2408
                    __run_timer_base kernel/time/timer.c:2419 [inline]
                    __run_timer_base kernel/time/timer.c:2412 [inline]
                    run_timer_base+0x111/0x190 kernel/time/timer.c:2428
                    run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2438
                    __do_softirq+0x218/0x8de kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0xf/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                    rest_init+0x16f/0x2b0 init/main.c:730
                    arch_call_rest_init+0x13/0x40 init/main.c:831
                    start_kernel+0x3a3/0x490 init/main.c:1077
                    x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x148
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                   __queue_work+0x39e/0x1170 kernel/workqueue.c:2360
                   queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
                   queue_work include/linux/workqueue.h:605 [inline]
                   start_poll_synchronize_rcu_expedited+0x147/0x180 kernel/rcu/tree_exp.h:1017
                   rcu_init+0x1625/0x20c0 kernel/rcu/tree.c:5240
                   start_kernel+0x19e/0x490 init/main.c:969
                   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x148
 }
 ... key      at: [<ffffffff929d9de0>] __key.17+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_free+0x130/0x820 net/core/sock_map.c:1154
                    bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
                    process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
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
                    bpf_trace_run1+0x149/0x410 kernel/trace/bpf_trace.c:2419
                    __bpf_trace_workqueue_activate_work+0x98/0xd0 include/trace/events/workqueue.h:59
                    trace_workqueue_activate_work include/trace/events/workqueue.h:59 [inline]
                    __queue_work+0xd0d/0x1170 kernel/workqueue.c:2399
                    call_timer_fn+0x1a0/0x5b0 kernel/time/timer.c:1792
                    expire_timers kernel/time/timer.c:1838 [inline]
                    __run_timers+0x567/0xab0 kernel/time/timer.c:2408
                    __run_timer_base kernel/time/timer.c:2419 [inline]
                    __run_timer_base kernel/time/timer.c:2412 [inline]
                    run_timer_base+0x111/0x190 kernel/time/timer.c:2428
                    run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2438
                    __do_softirq+0x218/0x8de kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
                    acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
                    cpuidle_enter_state+0x85/0x510 drivers/cpuidle/cpuidle.c:267
                    cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                    cpuidle_idle_call kernel/sched/idle.c:236 [inline]
                    do_idle+0x313/0x3f0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                    rest_init+0x16f/0x2b0 init/main.c:730
                    arch_call_rest_init+0x13/0x40 init/main.c:831
                    start_kernel+0x3a3/0x490 init/main.c:1077
                    x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x148
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_free+0x130/0x820 net/core/sock_map.c:1154
                   bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
                   process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
                   process_scheduled_works kernel/workqueue.c:3335 [inline]
                   worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                   kthread+0x2c1/0x3a0 kernel/kthread.c:388
                   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff949c67c0>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
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
   bpf_trace_run1+0x149/0x410 kernel/trace/bpf_trace.c:2419
   __bpf_trace_workqueue_activate_work+0x98/0xd0 include/trace/events/workqueue.h:59
   trace_workqueue_activate_work include/trace/events/workqueue.h:59 [inline]
   __queue_work+0xd0d/0x1170 kernel/workqueue.c:2399
   call_timer_fn+0x1a0/0x5b0 kernel/time/timer.c:1792
   expire_timers kernel/time/timer.c:1838 [inline]
   __run_timers+0x567/0xab0 kernel/time/timer.c:2408
   __run_timer_base kernel/time/timer.c:2419 [inline]
   __run_timer_base kernel/time/timer.c:2412 [inline]
   run_timer_base+0x111/0x190 kernel/time/timer.c:2428
   run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2438
   __do_softirq+0x218/0x8de kernel/softirq.c:554
   invoke_softirq kernel/softirq.c:428 [inline]
   __irq_exit_rcu kernel/softirq.c:633 [inline]
   irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
   sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
   native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
   acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
   acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
   cpuidle_enter_state+0x85/0x510 drivers/cpuidle/cpuidle.c:267
   cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
   cpuidle_idle_call kernel/sched/idle.c:236 [inline]
   do_idle+0x313/0x3f0 kernel/sched/idle.c:332
   cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
   rest_init+0x16f/0x2b0 init/main.c:730
   arch_call_rest_init+0x13/0x40 init/main.c:831
   start_kernel+0x3a3/0x490 init/main.c:1077
   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
   x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
   common_startup_64+0x13e/0x148


stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe3c/0x1490 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x248e/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
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
 bpf_trace_run1+0x149/0x410 kernel/trace/bpf_trace.c:2419
 __bpf_trace_workqueue_activate_work+0x98/0xd0 include/trace/events/workqueue.h:59
 trace_workqueue_activate_work include/trace/events/workqueue.h:59 [inline]
 __queue_work+0xd0d/0x1170 kernel/workqueue.c:2399
 call_timer_fn+0x1a0/0x5b0 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1838 [inline]
 __run_timers+0x567/0xab0 kernel/time/timer.c:2408
 __run_timer_base kernel/time/timer.c:2419 [inline]
 __run_timer_base kernel/time/timer.c:2412 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2428
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2438
 __do_softirq+0x218/0x8de kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 d8 60 31 75 48 8b 00 a8 08 75 0c 66 90 0f 00 2d c8 73 a7 00 fb f4 <fa> c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8d407d68 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8ad255f9
RDX: 0000000000000001 RSI: ffff88801bab8000 RDI: ffff88801bab8064
RBP: ffff88801bab8064 R08: 0000000000000001 R09: ffffed1017286fdd
R10: ffff8880b9437eeb R11: 0000000000000000 R12: ffff8880173d4800
R13: ffffffff8e31fbc0 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x85/0x510 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x313/0x3f0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x16f/0x2b0 init/main.c:730
 arch_call_rest_init+0x13/0x40 init/main.c:831
 start_kernel+0x3a3/0x490 init/main.c:1077
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
 common_startup_64+0x13e/0x148
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	65 48 8b 05 d8 60 31 	mov    %gs:0x753160d8(%rip),%rax        # 0x753160f0
  17:	75
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d c8 73 a7 00 	verw   0xa773c8(%rip)        # 0xa773f0
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

