Return-Path: <linux-kernel+bounces-145707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C278A59D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC6DB22302
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0F13B2A2;
	Mon, 15 Apr 2024 18:22:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C913A87E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205341; cv=none; b=OGsUgdmOSkCtqE0LUA2HfxafosvaaRFWudKAbyI4zOJ0YgvcDSmG884uA89nPoE/QdpC3/LSUtg1c3XAOyCRFsMvDM2h1sMW8PypDaAvaaCc4Lq7GbrN8svKz/KZipym051P46HjTNJD9GvuEL/hwStzXcl/5/tCa5CIEeeF84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205341; c=relaxed/simple;
	bh=jHmdICpHVXd7A3KybVf/nFiDM9K4gw1sRPaRNAnXJE8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ctnYQ7z7xUCbX72kxBWBIaGlU9YdfXABeH6guXqSgWg3J+Zm5bNCKmYlrnJKE1aN00i3lQbzZlbCO+k7UgGqMplkgo5VPml8ybL7ZkBLw/HGoAF37BFBIHXNrOdckuSLSyg6tWL3N07n5tvD23jRxkBtYUX2Sm9w2NY4YuI9TEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d676654767so411390239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205339; x=1713810139;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xMyAiycsDE0K9LFJ1bOdI5tgj79htq+mS7mEVZ4iek=;
        b=EYJl5G6WHWRwqCUmrBdRayTMYendHE1VULwnK4Sg+bbe/dhsHFChvTzkAGxAT1rgfZ
         +HbUGVTIHknwx353jhTFnT76RFp1kT43X6zGT0B6uxoPe0yeDZee+iwygwXd2qJmB4gX
         vMistpXF7m6+dgOEFHx5rwKTobGLSgbkvWBM1FDeX2rrqON6VWF4HGRU3hQcqp6o6VX0
         CCUbidQXmyTOHjnrlnTJGhqlalRKA5HaHZmG4P8OpzzPwZILzEJBjIkpkfhGHU4F0FXA
         9W36rwsTNWFudzALM5xoP8DaABC6bcQ+1zElHh/puBfk2ampzCCP3VW4ggXgsYl+Xeer
         QFrg==
X-Forwarded-Encrypted: i=1; AJvYcCWZJqwZlik2Z4xmyLd3DsGBt3ztnU7pqQb+36sBbamTb41TFp6pIfZVoqG10Ei8AllwucbBIwBA8de8FIvz0ynCG7jof1jNW8NZv34y
X-Gm-Message-State: AOJu0Yznq98ewmvri7Qq/Xz4z0riPLpV6jcX5F4Xvhig4Y2kHvtcky4j
	b+AnW7kewx09gVGCpseIot1jkxXZVsdnm5DgCADL50G4vETFtSzLmYch1nTTHYkOhEP7NGeki9c
	ZD7NKY6ZG6tV9MMqt21nxgnSBIe4difoXT7wOddiay2yC4cNlbYb1/1o=
X-Google-Smtp-Source: AGHT+IHmMB7ZsLlxLEs8VYsrWH/ZQc3ctnBGUOKlwMDiST+35aJ9sf/ReAicoUOeSCsfGQM61PKthX6zK+0k+vgAnzk5iLWqdHwe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:482:eade:a878 with SMTP id
 m16-20020a056638271000b00482eadea878mr506698jav.1.1713205338611; Mon, 15 Apr
 2024 11:22:18 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:22:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2b48d061626b3ac@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in swake_up_one
From: syzbot <syzbot+c1571e01da4f845b858f@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1683dbcb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=c1571e01da4f845b858f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10698467180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c80f4d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c1571e01da4f845b858f@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
-----------------------------------------------------
rcu_exp_gp_kthr/18 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88802f1b4820 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802f1b4820 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939

and this task is already holding:
ffffffff8d7bc598 (&rcu_state.expedited_wq){-.-.}-{2:2}, at: finish_swait+0xc5/0x280 kernel/sched/swait.c:139
which would create a new lock dependency:
 (&rcu_state.expedited_wq){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&rcu_state.expedited_wq){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  swake_up_one+0x1a/0x1b0 kernel/sched/swait.c:51
  csd_do_func kernel/smp.c:133 [inline]
  __flush_smp_call_function_queue+0x41f/0x8c0 kernel/smp.c:542
  __sysvec_call_function_single+0x8c/0x3a0 arch/x86/kernel/smp.c:271
  instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
  sysvec_call_function_single+0x90/0xb0 arch/x86/kernel/smp.c:266
  asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
  trace_event_eval_update+0x1de/0xfe0 kernel/trace/trace_events.c:2916
  trace_insert_eval_map kernel/trace/trace.c:6294 [inline]
  eval_map_work_func+0x3d/0x50 kernel/trace/trace.c:10069
  process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
  process_scheduled_works kernel/workqueue.c:3335 [inline]
  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
  kthread+0x2c1/0x3a0 kernel/kthread.c:388
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
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
  bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
  __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
  trace_contention_end+0xce/0x120 include/trace/events/lock.h:122
  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
  __mutex_lock+0x19c/0x9c0 kernel/locking/mutex.c:752
  futex_cleanup_begin kernel/futex/core.c:1091 [inline]
  futex_exit_release+0x2a/0x220 kernel/futex/core.c:1143
  exit_mm_release+0x19/0x30 kernel/fork.c:1652
  exit_mm kernel/exit.c:542 [inline]
  do_exit+0x865/0x2be0 kernel/exit.c:865
  do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
  __do_sys_exit_group kernel/exit.c:1038 [inline]
  __se_sys_exit_group kernel/exit.c:1036 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&rcu_state.expedited_wq);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&rcu_state.expedited_wq);

 *** DEADLOCK ***

2 locks held by rcu_exp_gp_kthr/18:
 #0: ffffffff8d7bc598 (&rcu_state.expedited_wq){-.-.}-{2:2}, at: finish_swait+0xc5/0x280 kernel/sched/swait.c:139
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0xe4/0x420 kernel/trace/bpf_trace.c:2420

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&rcu_state.expedited_wq){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    swake_up_one+0x1a/0x1b0 kernel/sched/swait.c:51
                    csd_do_func kernel/smp.c:133 [inline]
                    __flush_smp_call_function_queue+0x41f/0x8c0 kernel/smp.c:542
                    __sysvec_call_function_single+0x8c/0x3a0 arch/x86/kernel/smp.c:271
                    instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
                    sysvec_call_function_single+0x90/0xb0 arch/x86/kernel/smp.c:266
                    asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
                    trace_event_eval_update+0x1de/0xfe0 kernel/trace/trace_events.c:2916
                    trace_insert_eval_map kernel/trace/trace.c:6294 [inline]
                    eval_map_work_func+0x3d/0x50 kernel/trace/trace.c:10069
                    process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    swake_up_one+0x1a/0x1b0 kernel/sched/swait.c:51
                    rcu_report_exp_rdp kernel/rcu/tree_exp.h:260 [inline]
                    rcu_preempt_deferred_qs_irqrestore+0x592/0xb80 kernel/rcu/tree_plugin.h:506
                    rcu_softirq_qs+0x1b/0x1c0 kernel/rcu/tree.c:246
                    __do_softirq+0x71a/0x8de kernel/softirq.c:568
                    run_ksoftirqd kernel/softirq.c:924 [inline]
                    run_ksoftirqd+0x35/0x60 kernel/softirq.c:916
                    smpboot_thread_fn+0x661/0xa10 kernel/smpboot.c:164
                    kthread+0x2c1/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                   prepare_to_swait_event+0x1f/0x470 kernel/sched/swait.c:107
                   synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
                   synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
                   rcu_exp_wait_wake+0x2a2/0x15e0 kernel/rcu/tree_exp.h:641
                   kthread_worker_fn+0x305/0xab0 kernel/kthread.c:841
                   kthread+0x2c1/0x3a0 kernel/kthread.c:388
                   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff946869c0>] __key.3+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
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
                    bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
                    __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
                    trace_contention_end+0xce/0x120 include/trace/events/lock.h:122
                    __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                    __mutex_lock+0x19c/0x9c0 kernel/locking/mutex.c:752
                    futex_cleanup_begin kernel/futex/core.c:1091 [inline]
                    futex_exit_release+0x2a/0x220 kernel/futex/core.c:1143
                    exit_mm_release+0x19/0x30 kernel/fork.c:1652
                    exit_mm kernel/exit.c:542 [inline]
                    do_exit+0x865/0x2be0 kernel/exit.c:865
                    do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
                    __do_sys_exit_group kernel/exit.c:1038 [inline]
                    __se_sys_exit_group kernel/exit.c:1036 [inline]
                    __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
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
                   bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
                   __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
                   trace_contention_end+0xce/0x120 include/trace/events/lock.h:122
                   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
                   __mutex_lock+0x19c/0x9c0 kernel/locking/mutex.c:752
                   futex_cleanup_begin kernel/futex/core.c:1091 [inline]
                   futex_exit_release+0x2a/0x220 kernel/futex/core.c:1143
                   exit_mm_release+0x19/0x30 kernel/fork.c:1652
                   exit_mm kernel/exit.c:542 [inline]
                   do_exit+0x865/0x2be0 kernel/exit.c:865
                   do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
                   __do_sys_exit_group kernel/exit.c:1038 [inline]
                   __se_sys_exit_group kernel/exit.c:1036 [inline]
                   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
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
   bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
   __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
   trace_contention_end.constprop.0+0xe2/0x140 include/trace/events/lock.h:122
   __pv_queued_spin_lock_slowpath+0x266/0xc80 kernel/locking/qspinlock.c:560
   pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
   queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
   do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
   _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
   finish_swait+0xc5/0x280 kernel/sched/swait.c:139
   synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
   synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
   rcu_exp_wait_wake+0x2db/0x15e0 kernel/rcu/tree_exp.h:641
   kthread_worker_fn+0x305/0xab0 kernel/kthread.c:841
   kthread+0x2c1/0x3a0 kernel/kthread.c:388
   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 18 Comm: rcu_exp_gp_kthr Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
 bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
 __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
 trace_contention_end.constprop.0+0xe2/0x140 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x266/0xc80 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
 finish_swait+0xc5/0x280 kernel/sched/swait.c:139
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
 rcu_exp_wait_wake+0x2db/0x15e0 kernel/rcu/tree_exp.h:641
 kthread_worker_fn+0x305/0xab0 kernel/kthread.c:841
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 18 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 18 Comm: rcu_exp_gp_kthr Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d 72 d0 b5 04 00 74 06 90 c3 cc cc cc cc c6 05 63 d0 b5 04 01 90 48 c7 c7 c0 b1 0c 8b e8 78 6b 7d f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000177d38 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8d7bc580 RCX: ffffffff814fafe9
RDX: ffff888016ef9e00 RSI: ffffffff814faff6 RDI: 0000000000000001
RBP: 0000000000000283 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000a42
R13: ffffffff8f9e7034 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558bbfdca8 CR3: 000000000d57a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x74/0x80 kernel/locking/spinlock.c:194
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:516 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:570 [inline]
 rcu_exp_wait_wake+0x2db/0x15e0 kernel/rcu/tree_exp.h:641
 kthread_worker_fn+0x305/0xab0 kernel/kthread.c:841
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

