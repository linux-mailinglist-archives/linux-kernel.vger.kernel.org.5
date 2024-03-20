Return-Path: <linux-kernel+bounces-109308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3948881775
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA18DB231AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE285635;
	Wed, 20 Mar 2024 18:46:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748152F78
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960394; cv=none; b=gTCfGEqfWgQMNbcVjgowWn8bCt1bZex5cLldVrFs5EZOy3sYQ97AoV9Eu53Cth9ZJultK84jccSKghRoMIopw0TsSsPzspxMimnAJbaVZ38BK1kYPejsqj5z8XKkQlnkRjlUanGhGSK9IAb35p0KOVR9xdB7LNHtTUjpQl/z9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960394; c=relaxed/simple;
	bh=8pt/XhiMExALm9P1cmiUyF2ZHWgRbeKh7N2P5I+76vM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=brHnSBFscQluCVLHAYSC97I5IPlKSKkdEtrtpKsj4Qu5ZwOeQl9YpxiG1r7kl0y3d+9XtjjRTpirSVLf0np3QRezyeBmBxX5WiG0jlkizkd7o/5Iyz+mV3yp8EfnbDRP+IxI2wxQ+gTomiHmVsFM3vm8XlueRSap/qMZwophp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso10753939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960392; x=1711565192;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBO5ODM1Oz+0BJLlWSPKYLxctRSl4Pb3+wRgJBl7mEA=;
        b=iacGSPhfMZVh6MuiDzzurttaiLDzs8Q9grpDsAWhzbym44HK+2BxZ4iHVlrEntjm6c
         ZJje23ORw++CYotiyWE8SifiDp2G3SddU+5oKuw9OStf0ABiBYKqGSx2JuISex+N7N16
         yGY8J74BMfYR0O68N1U6OBS9ioqsZTh8EjbHJS++iN26jUabNsPVYxQaTmr/WuhSXeMg
         O5hmbhTDFmAW/55lahNzWFLA13KCa0y13mJTDOmSdtio2vKzQxEQugh54ywFuJ6/T+b7
         oTtGZeZHbz2AjoD2Xyndp3H5miVAMolgmbdxau4a+tKwZS/7r3onLaUULhzECTJAf0nV
         3gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWds93T9/Ul/6t3GZQocZS3hrYEY1E7G2QxRM0NxrStJIHCMJWjuI93xBkuuM00ufFc6s6+MeE0nbz35OkYThWOuLLoH7Z479LSBBHE
X-Gm-Message-State: AOJu0YxYd4UsuQtII7luz1dO69hBvfc49ZHxCAIG2tXTPs5OsJz7RGBD
	goCqSmacly4Xnq6oALgBgp1iG7f4SKfHw0h5wdEk5ewdhMkYQcYu9mTLAy/FxPTX5xyofqcgf6Z
	HQ0P33++M8h2V0cOPpww0zmmav0PkmTkE4f+QohTnv4Hkr5ifkU5G1Vc=
X-Google-Smtp-Source: AGHT+IG1Ebk5CiMOfbBp6Z8o85eeOd5NV59smbg1D71uQADD267q2hra8fn3Zh+hmzfjyoMFPeKEkxAfJaNnNIaf5/4gzYoeVlII
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411a:b0:476:e1cc:efab with SMTP id
 ay26-20020a056638411a00b00476e1ccefabmr1097467jab.3.1710960392070; Wed, 20
 Mar 2024 11:46:32 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:46:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064f78806141c027e@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in scheduler_tick (3)
From: syzbot <syzbot+628f63ef3b071e16463e@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15352985180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=628f63ef3b071e16463e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159321f1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fc324e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/disk-0740b642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmlinux-0740b642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead/bzImage-0740b642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+628f63ef3b071e16463e@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-05226-g0740b6427e90 #0 Not tainted
-----------------------------------------------------
strace-static-x/5062 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888021dde820 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888021dde820 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff8880b943e158 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
which would create a new lock dependency:
 (&rq->__lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&rq->__lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
  raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
  rq_lock kernel/sched/sched.h:1699 [inline]
  scheduler_tick+0xa1/0x6e0 kernel/sched/core.c:5679
  update_process_times+0x202/0x230 kernel/time/timer.c:2481
  tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
  tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
  timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
  handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
  common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  console_flush_all+0x9cd/0xec0
  console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
  vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
  _printk+0xd5/0x120 kernel/printk/printk.c:2317
  spectre_v2_select_mitigation+0x651/0x8f0 arch/x86/kernel/cpu/bugs.c:1722
  cpu_select_mitigations+0x41/0xa0 arch/x86/kernel/cpu/bugs.c:149
  arch_cpu_finalize_init+0x20/0xa0 arch/x86/kernel/cpu/common.c:2325
  start_kernel+0x402/0x500 init/main.c:1043
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
  sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
  bpf_prog_43221478a22f23b5+0x42/0x46
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
  trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
  __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
  pipe_write+0x1c9/0x1a40 fs/pipe.c:455
  call_write_iter include/linux/fs.h:2108 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xa84/0xcb0 fs/read_write.c:590
  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
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

3 locks held by strace-static-x/5062:
 #0: ffff88802a400a10 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock+0x57/0x360 kernel/sched/core.c:659
 #1: ffff8880b943e158 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&rq->__lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                    raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
                    rq_lock kernel/sched/sched.h:1699 [inline]
                    scheduler_tick+0xa1/0x6e0 kernel/sched/core.c:5679
                    update_process_times+0x202/0x230 kernel/time/timer.c:2481
                    tick_periodic+0x190/0x220 kernel/time/tick-common.c:100
                    tick_handle_periodic+0x4a/0x160 kernel/time/tick-common.c:112
                    timer_interrupt+0x5c/0x70 arch/x86/kernel/time.c:57
                    __handle_irq_event_percpu+0x28c/0xa30 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                    handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x13a/0x230 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    console_flush_all+0x9cd/0xec0
                    console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
                    vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
                    _printk+0xd5/0x120 kernel/printk/printk.c:2317
                    spectre_v2_select_mitigation+0x651/0x8f0 arch/x86/kernel/cpu/bugs.c:1722
                    cpu_select_mitigations+0x41/0xa0 arch/x86/kernel/cpu/bugs.c:149
                    arch_cpu_finalize_init+0x20/0xa0 arch/x86/kernel/cpu/common.c:2325
                    start_kernel+0x402/0x500 init/main.c:1043
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                    x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                    common_startup_64+0x13e/0x147
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                    raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
                    rq_lock kernel/sched/sched.h:1699 [inline]
                    ttwu_queue kernel/sched/core.c:4055 [inline]
                    try_to_wake_up+0x7d3/0x1470 kernel/sched/core.c:4378
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
                   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                   raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
                   raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
                   _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1404 [inline]
                   rq_lock_irqsave kernel/sched/sched.h:1683 [inline]
                   rq_attach_root+0xee/0x540 kernel/sched/topology.c:494
                   sched_init+0x64e/0xc30 kernel/sched/core.c:10031
                   start_kernel+0x1ab/0x500 init/main.c:948
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                   x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff926c4080>] sched_init.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
                    bpf_prog_43221478a22f23b5+0x42/0x46
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                    trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                    __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                    __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                    pipe_write+0x1c9/0x1a40 fs/pipe.c:455
                    call_write_iter include/linux/fs.h:2108 [inline]
                    new_sync_write fs/read_write.c:497 [inline]
                    vfs_write+0xa84/0xcb0 fs/read_write.c:590
                    ksys_write+0x1a0/0x2c0 fs/read_write.c:643
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
                   bpf_prog_43221478a22f23b5+0x42/0x46
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
                   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
                   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
                   pipe_write+0x1c9/0x1a40 fs/pipe.c:455
                   call_write_iter include/linux/fs.h:2108 [inline]
                   new_sync_write fs/read_write.c:497 [inline]
                   vfs_write+0xa84/0xcb0 fs/read_write.c:590
                   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff94882300>] sock_hash_alloc.__key+0x0/0x20
 ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
   bpf_prog_43221478a22f23b5+0x42/0x46
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
   trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
   __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
   pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
   queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
   do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
   raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
   raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
   task_rq_lock+0xc6/0x360 kernel/sched/core.c:661
   wait_task_inactive+0x1fa/0x6f0 kernel/sched/core.c:2329
   ptrace_check_attach+0x19d/0x3a0 kernel/ptrace.c:262
   __do_sys_ptrace kernel/ptrace.c:1283 [inline]
   __se_sys_ptrace+0x136/0x450 kernel/ptrace.c:1261
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 1 PID: 5062 Comm: strace-static-x Not tainted 6.8.0-syzkaller-05226-g0740b6427e90 #0
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
 bpf_prog_43221478a22f23b5+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
 task_rq_lock+0xc6/0x360 kernel/sched/core.c:661
 wait_task_inactive+0x1fa/0x6f0 kernel/sched/core.c:2329
 ptrace_check_attach+0x19d/0x3a0 kernel/ptrace.c:262
 __do_sys_ptrace kernel/ptrace.c:1283 [inline]
 __se_sys_ptrace+0x136/0x450 kernel/ptrace.c:1261
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x4e987a
Code: 70 41 83 f8 03 c7 44 24 10 08 00 00 00 48 89 44 24 18 48 8d 44 24 30 8b 70 08 4c 0f 43 d1 48 89 44 24 20 b8 65 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3e 48 85 c0 78 06 41 83 f8 02 76 1b 48 8b 54
RSP: 002b:00007fff4874dff0 EFLAGS: 00000206 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 000000003e957b90 RCX: 00000000004e987a
RDX: 0000000000000058 RSI: 00000000000013c9 RDI: 000000000000420e
RBP: 0000000000664740 R08: 000000000000420d R09: 00000000000003c9
R10: 0000000000664740 R11: 0000000000000206 R12: 00007fff4874e13c
R13: 000000000000857f R14: 000000003e957b90 R15: 000000000063f160
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

