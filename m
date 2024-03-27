Return-Path: <linux-kernel+bounces-122141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E259188F2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942112997AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75491154449;
	Wed, 27 Mar 2024 23:12:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258F14F9D5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581144; cv=none; b=toZH/g7OskC0nqSflVM8j1iNeXGyDmDWG0I7veSNfu+G7G+RJm+a0/vPCzxjDiOTkLDwMcuTUO90e9dI86GEZmHS0nEOkNtDGf6Nq9SHcqCwJYh+gM5yBipwWoq65GApdsvvE4lsnzknsZLqJTp2jAMjnsYzXWEkIxa4fi54gYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581144; c=relaxed/simple;
	bh=zbXcsXOs5GrG48yeWY3UZQ4cxB/3rDmRALnGU1j9TG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nqYt37sV1VotpqG3qm1MRDQ3oTTnQhPv/O1Do3xOsUjrc5EBsY6m6mqE04oGCydHTNS4lGjir7yJUpaEGv1dO16wTj6aZRWBV9EfmViHKE2j5wQ4EY21q2CrK9htfvB2HDu5btBcxNUO6H6eod0Fq8RJhuNO1EBXlTDzMAWTGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso26863739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581142; x=1712185942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WL2EHEfkHkj5n+YGdVaZ81Yz8jTFIRn1vqbDxCvS4dM=;
        b=bnsbznd6d1ignUSSz7CEdCKuuyqsvgLCm+Kf6azAWJif8Fvgk5+RU6Q5G8p009hQ9i
         voX3NIeLV47Gr7NEW17TczIyHOI16Zpsx0oUR68gfFzN70H8g1b6d1xaDpN/dVtc8L1c
         bIkNV2TtCVJq3+j28iKk7OLQmzVBELUfOjiocM5y7ZLqrRMBlXgSAz5e4eLGJglrSTuw
         k/XW52JWR7cCrZ3DdeWqlKb2bkPtlJrOddHZJVvy0+EOyjA3yBGUsVPCWPoiHQ7vrn0D
         rjsibu/f+p3u/L/Ut7Q1VBQTKXJMMP60ZZYC5HbHu4gpqp00+GXiglHrvmYslkjtXdsS
         AqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXswMq9USw4M4wFsHwTIHX/joKCD/s6d2f/4zScFZ1R5DJ9wWu0swF8gFiGSU9wHcaS637L4MSBHSIpepSHR6n/hI3W1H6dmq5Jao/7
X-Gm-Message-State: AOJu0YyRnCJnYmsOd41tCaMS45v0d3WYJNdvHLp3L3pyyl1OrQ4N6Ftv
	9nt+cbGNNzmSZzzOpctb24O6S3chplw02jHZnhMuBK8Daoxhc14vBWq6pczHOgjasIOMEs5m02F
	As2M9OOlRS4RynI0xLOyVgcxJYan9BXCwZY9Eu/Ln1tQguM+OF3LmV44=
X-Google-Smtp-Source: AGHT+IHcyGHVHJhulUdISLirq00oKckB1P6h8/Kr1JZDXNGjaVP/sgXu+bw2pu6G/nfiTf0ngKwef7syM46i64PDEjwfYlsV9dx/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891c:b0:47c:6d4:3e57 with SMTP id
 jc28-20020a056638891c00b0047c06d43e57mr57109jab.0.1711581142216; Wed, 27 Mar
 2024 16:12:22 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:12:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc84dd0614ac89b3@google.com>
Subject: [syzbot] [bpf?] possible deadlock in trie_update_elem
From: syzbot <syzbot+ea624e536fee669a05cf@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1404a7b6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea624e536fee669a05cf@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.2/14356 is trying to acquire lock:
ffff88813fffece0 (&pgdat->kswapd_wait){....}-{2:2}, at: __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105

but task is already holding lock:
ffff88807ab571f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&trie->lock){....}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
       0xffffffffa000080e
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x250b/0x49d0 kernel/sched/core.c:6733
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6915
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6939
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
       __local_bh_enable_ip+0x179/0x200 kernel/softirq.c:389
       spin_unlock_bh include/linux/spinlock.h:396 [inline]
       batadv_nc_purge_paths+0x30f/0x3b0 net/batman-adv/network-coding.c:471
       batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
       rq_lock kernel/sched/sched.h:1699 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12629
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4845
       copy_process+0x2217/0x3df0 kernel/fork.c:2498
       kernel_clone+0x223/0x840 kernel/fork.c:2796
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2874
       rest_init+0x27/0x300 init/main.c:695
       arch_call_rest_init+0xe/0x10 init/main.c:831
       start_kernel+0x47a/0x500 init/main.c:1077
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
       autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
       __wake_up_common kernel/sched/wait.c:89 [inline]
       __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
       rmqueue mm/page_alloc.c:2913 [inline]
       get_page_from_freelist+0x30ab/0x3580 mm/page_alloc.c:3308
       __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
       alloc_pages_mpol+0x3de/0x650 mm/mempolicy.c:2133
       shmem_alloc_folio mm/shmem.c:1634 [inline]
       shmem_alloc_and_add_folio+0x250/0xdf0 mm/shmem.c:1674
       shmem_get_folio_gfp+0x82d/0x1f50 mm/shmem.c:2061
       shmem_get_folio mm/shmem.c:2166 [inline]
       shmem_write_begin+0x170/0x4d0 mm/shmem.c:2750
       generic_perform_write+0x322/0x640 mm/filemap.c:3930
       shmem_file_write_iter+0xfc/0x120 mm/shmem.c:2926
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&pgdat->kswapd_wait){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
       rmqueue mm/page_alloc.c:2913 [inline]
       get_page_from_freelist+0x30ab/0x3580 mm/page_alloc.c:3308
       __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
       __alloc_pages_node include/linux/gfp.h:238 [inline]
       alloc_pages_node include/linux/gfp.h:261 [inline]
       __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3911
       __do_kmalloc_node mm/slub.c:3954 [inline]
       __kmalloc_node+0x33e/0x4e0 mm/slub.c:3973
       kmalloc_node include/linux/slab.h:648 [inline]
       bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
       trie_update_elem+0x1d3/0xc10 kernel/bpf/lpm_trie.c:333
       bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
       __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  &pgdat->kswapd_wait --> &rq->__lock --> &trie->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(&rq->__lock);
                               lock(&trie->lock);
  lock(&pgdat->kswapd_wait);

 *** DEADLOCK ***

2 locks held by syz-executor.2/14356:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88807ab571f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

stack backtrace:
CPU: 1 PID: 14356 Comm: syz-executor.2 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
 rmqueue mm/page_alloc.c:2913 [inline]
 get_page_from_freelist+0x30ab/0x3580 mm/page_alloc.c:3308
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3911
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0x33e/0x4e0 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
 trie_update_elem+0x1d3/0xc10 kernel/bpf/lpm_trie.c:333
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7c6647dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7c6728c0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f7c665abf80 RCX: 00007f7c6647dda9
RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000002
RBP: 00007f7c664ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7c665abf80 R15: 00007fff403ef148
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

