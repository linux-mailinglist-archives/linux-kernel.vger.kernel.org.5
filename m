Return-Path: <linux-kernel+bounces-130861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBA897E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C831C2188F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519DE1CD03;
	Thu,  4 Apr 2024 03:59:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD51CFBD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203170; cv=none; b=Eyegzn+BzBmp/MOKqJ3Zgubu9K5d96ub/6pV5MADedMguxYvOXEk6IlWEQqFqz1gJ1NqJf2I9B6astP2Zx8pbvbd5fkYxPBwg6BfFCudYeGYzPhak2ALsN/+sjfZMvtodMMZX6Voug3HGTb7/9i0HB/UFyiqSC1mNtPZAEM+yUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203170; c=relaxed/simple;
	bh=4cumwTd7VQvkI4Spav/SRpjOG+ckcNQPrhJq/+eXHes=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=omluYJpUO+m9vowi5VBwf0PTH2gE+/TmCA156L/i3Z2b990NyD5DYPsV7n+oe7nn+1+KyNpF2BbG2Gv438P6CV+Z7Qzw/bX7QpzEjRh/08eOZlX2FHfZjuJbSZWdqeR2rDTLHPcO/KimwcZWIAUayIlMElQf2ct1yeWRgNG0EQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d096c4d663so73785639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 20:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712203167; x=1712807967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVT42tMndBToZX27SlFshsvIbbKqqKgG6zw0CeYV+xs=;
        b=G1SZdMJ7dl0oZvpEk5QmTxuPQPsqbQ54rnNoW8mYzJbNTlpk5RL+LW/UPZ1v9/Qzke
         vclQGZnlOhQuQGqJcNoSHDbcNvhD+ZyDepU1RpvxiJYvHIgb1OTmRdIXcuPwZ6MMhrMs
         4yyn7RSI97KNkPzxx3PDUXkJqOutnVoPfmODdnjCaeo1IjTgh8BxwbTLwa0CR4EcgZG+
         TjII1vK2BbomyQgEw17NbKHPJqWEtB3PX/YdDgMWkTah9hl7AFMnXkaQKGF8YRR5ds0S
         eHUeYC6KdFyeoEKGy2AqigFe436+DAODXHzEwrcfmgACTkx8esZRFBLNa2Vd79dfYuqR
         G9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUM4kGrW5OewclX1lZTYUdyH/6050fJh6ekLpFa1QvyjUgadcenapFG3OvJIjtf82ieRC6ofq0tJpZbNebwhq+zFrg6N1QKX6lNuoPN
X-Gm-Message-State: AOJu0Yyms4RjfOpBHkrg3aK1BrRrBJLHzC3i2TwsxIqjBThPmdQQsNbD
	eZ/Eg9fMBDNTPthHIPWDuvBUMO4GC9YGe1V5SOUk4MpHkiL7a+CQ9fNIurWWToyK920aYnnBFoF
	pjv39VNoM9Hya4NArcor7qXI7ctDuvxM6n23BlD5UPKWiPOSGL0hoWMo=
X-Google-Smtp-Source: AGHT+IFaSXyPCpXKShZqconFvZLIjsx3HHPSDxXu2NmedY0NIeP4FT18hp/3lKkyxLnDcj4jXYZDhE8xEYmiBTyfZnHGF8evLPzn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379e:b0:47e:e557:ba45 with SMTP id
 w30-20020a056638379e00b0047ee557ba45mr67466jal.0.1712203167149; Wed, 03 Apr
 2024 20:59:27 -0700 (PDT)
Date: Wed, 03 Apr 2024 20:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fc7ca06153d5d30@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in pit_timer_fn
From: syzbot <syzbot+2cd91b51c468ad5df25b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16b5ffe6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0058bda1436e073
dashboard link: https://syzkaller.appspot.com/bug?extid=2cd91b51c468ad5df25b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c1618ff7d25/disk-a6bd6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/875519f620fe/vmlinux-a6bd6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad92b057fb96/bzImage-a6bd6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cd91b51c468ad5df25b@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.9.0-rc1-next-20240328-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/6478 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff88805d4cea18 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88805d4cea18 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939

and this task is already holding:
ffff8880172f0120 ((worker)->lock){-.-.}-{2:2}, at: kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
which would create a new lock dependency:
 ((worker)->lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 ((worker)->lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
  pit_timer_fn+0xa5/0x180 arch/x86/kvm/i8254.c:276
  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
  __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1756
  hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
  __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  kvm_vm_ioctl_set_pit+0x83/0x130 arch/x86/kvm/x86.c:6417
  kvm_arch_vm_ioctl+0xd4a/0x1710 arch/x86/kvm/x86.c:7153
  kvm_vm_ioctl+0x84c/0xd30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5348
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
  do_syscall_64+0xfb/0x240
  entry_SYSCALL_64_after_hwframe+0x6d/0x75

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
                               lock((worker)->lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock((worker)->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.0/6478:
 #0: ffffffff8e33a0f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #0: ffffffff8e33a0f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x39a/0x820 kernel/rcu/tree_exp.h:939
 #1: ffff8880172f0120 ((worker)->lock){-.-.}-{2:2}, at: kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
 #2: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2395 [inline]
 #2: ffffffff8e334d60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x530 kernel/trace/bpf_trace.c:2437

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> ((worker)->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
                    pit_timer_fn+0xa5/0x180 arch/x86/kvm/i8254.c:276
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    kvm_vm_ioctl_set_pit+0x83/0x130 arch/x86/kvm/x86.c:6417
                    kvm_arch_vm_ioctl+0xd4a/0x1710 arch/x86/kvm/x86.c:7153
                    kvm_vm_ioctl+0x84c/0xd30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5348
                    vfs_ioctl fs/ioctl.c:51 [inline]
                    __do_sys_ioctl fs/ioctl.c:907 [inline]
                    __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    kthread_queue_work+0x27/0x180 kernel/kthread.c:1019
                    pit_timer_fn+0xa5/0x180 arch/x86/kvm/i8254.c:276
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1756
                    hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
                    local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
                    __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
                    _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
                    __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
                    debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
                    slab_free_hook mm/slub.c:2152 [inline]
                    slab_free mm/slub.c:4363 [inline]
                    kmem_cache_free+0x10f/0x340 mm/slub.c:4438
                    rcu_do_batch kernel/rcu/tree.c:2196 [inline]
                    rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
                    __do_softirq+0x2c6/0x980 kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    __sanitizer_cov_trace_pc+0x8/0x70 kernel/kcov.c:203
                    unwind_next_frame+0x8d6/0x2a00 arch/x86/kernel/unwind_orc.c:517
                    arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
                    kasan_save_stack mm/kasan/common.c:47 [inline]
                    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
                    poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
                    __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
                    kasan_kmalloc include/linux/kasan.h:211 [inline]
                    kmalloc_node_trace_noprof+0x1d3/0x300 mm/slub.c:4091
                    kmalloc_node_noprof include/linux/slab.h:677 [inline]
                    __get_vm_area_node+0x11a/0x280 mm/vmalloc.c:3070
                    __vmalloc_node_range_noprof+0x3df/0x1490 mm/vmalloc.c:3763
                    __vmalloc_node_noprof mm/vmalloc.c:3868 [inline]
                    __vmalloc_noprof+0x79/0x90 mm/vmalloc.c:3882
                    kvm_alloc_memslot_metadata arch/x86/kvm/x86.c:12802 [inline]
                    kvm_arch_prepare_memory_region+0x2aa/0xdd0 arch/x86/kvm/x86.c:12876
                    kvm_prepare_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1718 [inline]
                    kvm_set_memslot+0x588/0x1280 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1948
                    __kvm_set_memory_region+0x90e/0xaf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2127
                    kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:2148 [inline]
                    kvm_vm_ioctl_set_memory_region+0x6d/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2160
                    kvm_vm_ioctl+0xa45/0xd30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5169
                    vfs_ioctl fs/ioctl.c:51 [inline]
                    __do_sys_ioctl fs/ioctl.c:907 [inline]
                    __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
                   kthread_worker_fn+0x236/0xaf0 kernel/kthread.c:828
                   kthread+0x2f0/0x390 kernel/kthread.c:388
                   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff9292d120>] __kthread_create_worker.__key+0x0/0x20

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
   bpf_trace_run2+0x2ec/0x530 kernel/trace/bpf_trace.c:2437
   trace_sched_kthread_work_queue_work include/trace/events/sched.h:64 [inline]
   kthread_insert_work+0x419/0x480 kernel/kthread.c:993
   kthread_queue_work+0xff/0x180 kernel/kthread.c:1021
   synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:469 [inline]
   synchronize_rcu_expedited+0x593/0x820 kernel/rcu/tree_exp.h:949
   packet_release+0x9ef/0xcc0 net/packet/af_packet.c:3167
   __sock_release net/socket.c:659 [inline]
   sock_release+0x82/0x150 net/socket.c:687
   __sys_socketpair+0x6c9/0x720
   __do_sys_socketpair net/socket.c:1822 [inline]
   __se_sys_socketpair net/socket.c:1819 [inline]
   __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 1 PID: 6478 Comm: syz-executor.0 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
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
 bpf_trace_run2+0x2ec/0x530 kernel/trace/bpf_trace.c:2437
 trace_sched_kthread_work_queue_work include/trace/events/sched.h:64 [inline]
 kthread_insert_work+0x419/0x480 kernel/kthread.c:993
 kthread_queue_work+0xff/0x180 kernel/kthread.c:1021
 synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:469 [inline]
 synchronize_rcu_expedited+0x593/0x820 kernel/rcu/tree_exp.h:949
 packet_release+0x9ef/0xcc0 net/packet/af_packet.c:3167
 __sock_release net/socket.c:659 [inline]
 sock_release+0x82/0x150 net/socket.c:687
 __sys_socketpair+0x6c9/0x720
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f8906c7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8907a530c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
RAX: ffffffffffffffda RBX: 00007f8906dabf80 RCX: 00007f8906c7dda9
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000011
RBP: 00007f8906cca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020001080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8906dabf80 R15: 00007ffd9a605df8
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 6478 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 6478 Comm: syz-executor.0 Not tainted 6.9.0-rc1-next-20240328-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d f4 fc 13 04 00 74 06 90 c3 cc cc cc cc c6 05 e5 fc 13 04 01 90 48 c7 c7 c0 cd ca 8b e8 68 60 d8 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc9000af1f958 EFLAGS: 00010246
RAX: 6b1746de98bfcd00 RBX: 1ffff920015e3f30 RCX: 0000000000040000
RDX: ffffc9000f782000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc9000af1f9f0 R08: ffffffff815802c2 R09: fffffbfff1c39b10
R10: dffffc0000000000 R11: fffffbfff1c39b10 R12: dffffc0000000000
R13: 1ffff920015e3f2c R14: ffffc9000af1f980 R15: 0000000000000246
FS:  00007f8907a536c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001080 CR3: 0000000022368000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
 kthread_queue_work+0x110/0x180 kernel/kthread.c:1024
 synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:469 [inline]
 synchronize_rcu_expedited+0x593/0x820 kernel/rcu/tree_exp.h:949
 packet_release+0x9ef/0xcc0 net/packet/af_packet.c:3167
 __sock_release net/socket.c:659 [inline]
 sock_release+0x82/0x150 net/socket.c:687
 __sys_socketpair+0x6c9/0x720
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f8906c7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8907a530c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
RAX: ffffffffffffffda RBX: 00007f8906dabf80 RCX: 00007f8906c7dda9
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000011
RBP: 00007f8906cca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020001080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8906dabf80 R15: 00007ffd9a605df8
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

