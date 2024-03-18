Return-Path: <linux-kernel+bounces-106718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BF87F27B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56A91F2274B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDA59B73;
	Mon, 18 Mar 2024 21:47:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFF58231
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798445; cv=none; b=B5dEOVcz5Ejxpe8hz4C48+Ip58PeBKPdbZUpCXj/vLOwZjtKz53YTStFGqR/DSe3dMw1YxlvfBgNcjv9dvKTvWXu15ZzH0giRVCZRShclBzGIoYZAOddCH4orHFe28IBPa+M8R5ABFu5+Dl2BkkfCCmMaZvkUKH5YgiiHJkOGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798445; c=relaxed/simple;
	bh=fq72GpsGVd/cPNeO7E1jPHHw7V1Lucl4sTZtKbidRsM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xv0Pzcp0POiSEwfLEtq06M2CID4lb6ZAjCw6qxSfIiQDM8NmoIK7Fz922Qx2Jz2izPLVzW5GtwCiZGLi+Cjw4uzd/PlhqyW/QiE1lhyayrFXYM1CqvxZFjjJyzO2F1uxSV5bBjkhcm5GE8+kTjLzQU6HyvmeVa2Ca2gXoP20IvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so439227239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798443; x=1711403243;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNMEo2lyrGaQy5jomwIpKYATg5r7BMbeiFtEYg5txL8=;
        b=RdJ3PX5Y8n4nd6JENzOoV+fUD/aot5LnISR3AzEPTHi0lqjzvqsHY4SK7c2bBOlkNz
         49maV49lX4Mib5yhcBhmktubdZgvPBCeonuc3CSmhUFR1Y9G1Rcg2r+0NKd1L8YyztEs
         Hm8wMDRDL7601RLaXjOPIcdC2kDssyCK/Ar37FwTOpF6chhOWT0JKSj4zJQrdxkMqlq2
         /kXjhzaYFLWbipO9Bs84cWKUSOkrOXe80aB0FdE6AvJD/PqwJx0DzGjG0FQ4pRuQ6hki
         1iXtfMVu+0InIg0gDzaDzT5mKIyqOoOTUfLDbvH00VRrfjpC/caPMHCFR7BkvK2yQkXU
         QI0A==
X-Forwarded-Encrypted: i=1; AJvYcCUEI1XH18saRG9SQme5+ppbxchsyBeRM5JKBOmWnmmpJ4VpdiCqREN9zMu/o2WgjsKksGK/JE0TIGpYky1QhSAXoHtZUk7PgAPw1UrV
X-Gm-Message-State: AOJu0YwvUdOnwNF9NT83n8e+/cfJaivaHVVEGyqTj5qbzsnh76xmSLh9
	AxqbozFsJQuuptUQTc7IJuy5vcxcc+VOT/rjbZWZwmmy7X5jKUucQa0Ru8iAgbnmn61XoYDqoWG
	LlK4kOHWY+hCoUXDr/OBicawqMy1sURgdtZK/V58krWmy+asuCSx9Ork=
X-Google-Smtp-Source: AGHT+IFKaIzkj69jDzRILH8PNDNLmJX66MRx7KB/h7/xEszxioOrufWqbH7cQs02n629b8e88SRfDUHHZ1KIkUIMgMdgQhoQ6My0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:271e:b0:477:3027:ed75 with SMTP id
 m30-20020a056638271e00b004773027ed75mr836224jav.1.1710798443056; Mon, 18 Mar
 2024 14:47:23 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:47:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b33c00613f64d03@google.com>
Subject: [syzbot] [net?] [bpf?] possible deadlock in __lock_task_sighand (2)
From: syzbot <syzbot+34267210261c2cbba2da@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=11725ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=34267210261c2cbba2da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34267210261c2cbba2da@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
-----------------------------------------------------
syz-fuzzer/5356 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff888092ee3020 (&htab->buckets[i].lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888092ee3020 (&htab->buckets[i].lock){+.-.}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff888015f2d358 (&sighand->siglock){-.-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff888015f2d358 (&sighand->siglock){-.-.}-{2:2}, at: get_signal+0x247/0x1850 kernel/signal.c:2699
which would create a new lock dependency:
 (&sighand->siglock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+.-.}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&sighand->siglock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  __lock_task_sighand+0x149/0x2e0 kernel/signal.c:1414
  lock_task_sighand include/linux/sched/signal.h:746 [inline]
  send_sigqueue+0x25d/0x760 kernel/signal.c:1997
  posix_timer_event kernel/time/posix-timers.c:298 [inline]
  posix_timer_fn+0x18a/0x3a0 kernel/time/posix-timers.c:324
  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
  __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
  hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
  unlock_timer kernel/time/posix-timers.c:128 [inline]
  do_timer_settime+0x2db/0x340 kernel/time/posix-timers.c:934
  __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
  __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
  __x64_sys_timer_settime+0x19e/0x240 kernel/time/posix-timers.c:940
  do_syscall_64+0xfb/0x240
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+.-.}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
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
                               lock(&sighand->siglock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&sighand->siglock);

 *** DEADLOCK ***

2 locks held by syz-fuzzer/5356:
 #0: ffff888015f2d358 (&sighand->siglock){-.-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #0: ffff888015f2d358 (&sighand->siglock){-.-.}-{2:2}, at: get_signal+0x247/0x1850 kernel/signal.c:2699
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run3+0x14a/0x460 kernel/trace/bpf_trace.c:2421

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&sighand->siglock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    __lock_task_sighand+0x149/0x2e0 kernel/signal.c:1414
                    lock_task_sighand include/linux/sched/signal.h:746 [inline]
                    send_sigqueue+0x25d/0x760 kernel/signal.c:1997
                    posix_timer_event kernel/time/posix-timers.c:298 [inline]
                    posix_timer_fn+0x18a/0x3a0 kernel/time/posix-timers.c:324
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    unlock_timer kernel/time/posix-timers.c:128 [inline]
                    do_timer_settime+0x2db/0x340 kernel/time/posix-timers.c:934
                    __do_sys_timer_settime kernel/time/posix-timers.c:954 [inline]
                    __se_sys_timer_settime kernel/time/posix-timers.c:940 [inline]
                    __x64_sys_timer_settime+0x19e/0x240 kernel/time/posix-timers.c:940
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    __lock_task_sighand+0x149/0x2e0 kernel/signal.c:1414
                    lock_task_sighand include/linux/sched/signal.h:746 [inline]
                    send_sigqueue+0x25d/0x760 kernel/signal.c:1997
                    posix_timer_event kernel/time/posix-timers.c:298 [inline]
                    posix_timer_fn+0x18a/0x3a0 kernel/time/posix-timers.c:324
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    check_kcov_mode kernel/kcov.c:173 [inline]
                    __sanitizer_cov_trace_pc+0x2f/0x70 kernel/kcov.c:207
                    stack_access_ok arch/x86/kernel/unwind_orc.c:393 [inline]
                    deref_stack_reg+0xd5/0x260 arch/x86/kernel/unwind_orc.c:403
                    unwind_next_frame+0x1ab8/0x2a00 arch/x86/kernel/unwind_orc.c:648
                    arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                    unpoison_slab_object mm/kasan/common.c:312 [inline]
                    __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
                    kasan_slab_alloc include/linux/kasan.h:201 [inline]
                    slab_post_alloc_hook mm/slub.c:3798 [inline]
                    slab_alloc_node mm/slub.c:3845 [inline]
                    kmem_cache_alloc_node+0x194/0x380 mm/slub.c:3888
                    __alloc_skb+0x1c3/0x440 net/core/skbuff.c:658
                    __netdev_alloc_skb+0x105/0x560 net/core/skbuff.c:732
                    netdev_alloc_skb include/linux/skbuff.h:3306 [inline]
                    dev_alloc_skb include/linux/skbuff.h:3319 [inline]
                    __ieee80211_beacon_get+0x998/0x15c0 net/mac80211/tx.c:5466
                    ieee80211_beacon_get_tim+0xb4/0x320 net/mac80211/tx.c:5588
                    ieee80211_beacon_get include/net/mac80211.h:5552 [inline]
                    mac80211_hwsim_beacon_tx+0x398/0x7e0 drivers/net/wireless/virtual/mac80211_hwsim.c:2296
                    __iterate_interfaces+0x223/0x4c0 net/mac80211/util.c:772
                    ieee80211_iterate_active_interfaces_atomic+0xd8/0x170 net/mac80211/util.c:808
                    mac80211_hwsim_beacon+0xd4/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2326
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
                    hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1773
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    lock_acquire+0x25b/0x530 kernel/locking/lockdep.c:5758
                    rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
                    rcu_read_lock include/linux/rcupdate.h:750 [inline]
                    batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
                    batadv_nc_worker+0xec/0x610 net/batman-adv/network-coding.c:719
                    process_one_work kernel/workqueue.c:3254 [inline]
                    process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
                    worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   calculate_sigpending+0x4f/0x90 kernel/signal.c:188
                   ret_from_fork+0x24/0x80 arch/x86/kernel/process.c:143
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff926a68c0>] sighand_ctor.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
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
   IN-SOFTIRQ-W at:
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
                    bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
                    trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
                    kmem_cache_free+0x23c/0x2b0 mm/slub.c:4343
                    rcu_do_batch kernel/rcu/tree.c:2196 [inline]
                    rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
                    __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                    run_ksoftirqd+0xc5/0x130 kernel/softirq.c:924
                    smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
                    kthread+0x2f0/0x390 kernel/kthread.c:388
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
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
 ... key      at: [<ffffffff94869300>] sock_hash_alloc.__key+0x0/0x20
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
   bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
   trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
   kmem_cache_free+0x23c/0x2b0 mm/slub.c:4343
   __sigqueue_free kernel/signal.c:451 [inline]
   collect_signal kernel/signal.c:594 [inline]
   __dequeue_signal+0x4ac/0x5c0 kernel/signal.c:616
   dequeue_signal+0xd8/0x5a0 kernel/signal.c:636
   get_signal+0x5f7/0x1850 kernel/signal.c:2787
   arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
   exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
   irqentry_exit_to_user_mode+0x79/0x270 kernel/entry/common.c:225
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702


stack backtrace:
CPU: 1 PID: 5356 Comm: syz-fuzzer Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
 trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
 kmem_cache_free+0x23c/0x2b0 mm/slub.c:4343
 __sigqueue_free kernel/signal.c:451 [inline]
 collect_signal kernel/signal.c:594 [inline]
 __dequeue_signal+0x4ac/0x5c0 kernel/signal.c:616
 dequeue_signal+0xd8/0x5a0 kernel/signal.c:636
 get_signal+0x5f7/0x1850 kernel/signal.c:2787
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x79/0x270 kernel/entry/common.c:225
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0033:0x50f320
Code: c4 18 5d c3 48 8b 4c 24 28 48 8b 11 48 8b 41 08 48 8b 52 18 90 ff d2 48 c1 f8 20 8b 4c 24 14 39 c8 7f e1 8b 4c 24 30 99 f7 f9 <89> d0 48 83 c4 18 5d c3 48 8d 05 d1 0e 56 00 48 8d 1d da 4a 94 00
RSP: 002b:000000c016b891a0 EFLAGS: 00000297
RAX: 0000000000009943 RBX: 0000000000000236 RCX: 000000000000c042
RDX: 0000000000009250 RSI: 731a5596983e0cd1 RDI: 000000000000c040
RBP: 000000c016b891b8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 00007f71e59ceac8 R12: 0000000000470621
R13: 0000000000470621 R14: 000000c00ce076c0 R15: 0000000000000003
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

