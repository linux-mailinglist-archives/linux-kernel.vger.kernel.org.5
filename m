Return-Path: <linux-kernel+bounces-159446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C808B2EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41061F221FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2390B4A3F;
	Fri, 26 Apr 2024 02:33:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD6187F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098805; cv=none; b=NomK1Drprki3RoFATSMe43o853caxb44DracouhNUaTw2FPLQtkzKTDco8p83H2HMNrErj4Q2m67dazM07sy8etpB4IiKJUFRRyQWdLEPLR3ImqJoV3s+cq3wRuYcZijBd0g606+jA7MRA3VhI3XDgX5YjPi2InkSFXwDHsMOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098805; c=relaxed/simple;
	bh=hQZEqji64UNelqfj1e+i2Jq1JpAsguaZDgRJZj5mn7g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gNN3cV7/P59WZOHC4yjPgAAl+LEvbgLXuKQdkD/LdFM+swnFvDhBvA4REiylShYbDQHhBsoFML15u9Tcagu5Kazgn2EXKca8TvNWa59M6Jgi801X5a85jEFFUZxGEPWx5retpWfPY05dXmQm/zvL4raATCSaNRkyqTyiT1xpotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so158995839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714098803; x=1714703603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4zxKJz6fdYFyHLQamMSRYFyiClrZKDLt33drYE5x6c=;
        b=vWwrhd05CQJtRHm3lXDjCZhVBztmKS5KciWOhc3morj9lCuFkmrxmlprEi1D2WFivO
         mD7mSNrh8n5ENJscPF27bLUX1k0AJ06YQuYYgBwHvbB5NHy6LBEaLtW0zAN3IG9MR0wa
         x3NIBC4haWM4AqNVJZp6JnVGtLydfZEOkkW4Y6nrPRc4tngnUj/6SvKCnhi1I45I9gk6
         uBWKHroLDihoRNwoowqBic/n/ktSqA6cwfpE6+uI6AkbxofJEejYAkVDO4kEUbn87ZwX
         lMy8XjimKV/XAERDR8aiLqp4jekmesx+PY6t6bGaYlXwnllvEst+zEtKnVWP/sAvNJp6
         6qmw==
X-Forwarded-Encrypted: i=1; AJvYcCUAl74LjjmFGpJBShQRl+nQx3vLHTvAuiOyl9zHYN61+T8lDFakgt6DHwk28JJ/IaiBuZICcnO3wgh2eELrtRLXVqZKMedQ1rsTtbMQ
X-Gm-Message-State: AOJu0Yx5R1ixDRKpVRKroEqn7W/O6KUJYneAOy0dI5ypp23WE8nJKdZJ
	aRgpLG/dTo05z5Cek+99LJE4468wniMUWbkcNJjjk1mH9rhMkhFTPVgf7OhX9c6t6Qc1QbDh5oy
	roPgsIsiSYH9XZqWdM+EStjd3SYzaw0MWdWrMQOIR5gZJmflbiPeY7MQ=
X-Google-Smtp-Source: AGHT+IFbDZqzM1KjXb1yCUa524jCACnCJl6qvjkvmKjFmQkxvNeUVahaoEpCALcw1nb22/O7nCC0vUw1PrwP4H5f2vWrtQ5XY/af
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841f:b0:485:23f2:c4db with SMTP id
 iq31-20020a056638841f00b0048523f2c4dbmr68122jab.6.1714098802903; Thu, 25 Apr
 2024 19:33:22 -0700 (PDT)
Date: Thu, 25 Apr 2024 19:33:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041df050616f6ba4e@google.com>
Subject: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=13601320980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
------------------------------------------------------
syz-executor.2/5452 is trying to acquire lock:
ffff8880b9538528 (lock#10){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9538528 (lock#10){+.+.}-{2:2}, at: __mmap_lock_do_trace_start_locking+0x83/0x5f0 mm/mmap_lock.c:230

but task is already holding lock:
ffff8880b953e158 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
       rq_lock kernel/sched/sched.h:1699 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12629
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4845
       copy_process+0x2217/0x3df0 kernel/fork.c:2498
       kernel_clone+0x21e/0x8d0 kernel/fork.c:2796
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
       rcu_read_unlock_special+0x3db/0x550 kernel/rcu/tree_plugin.h:655
       __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:426
       rcu_read_unlock include/linux/rcupdate.h:782 [inline]
       get_mem_cgroup_from_mm+0x1a3/0x2a0 mm/memcontrol.c:1112
       get_mm_memcg_path+0x1b/0x600 mm/mmap_lock.c:202
       __mmap_lock_do_trace_start_locking+0x134/0x5f0 mm/mmap_lock.c:230
       __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
       get_mmap_lock_carefully mm/memory.c:5497 [inline]
       lock_mm_and_find_vma+0x1f1/0x2f0 mm/memory.c:5557
       do_user_addr_fault arch/x86/mm/fault.c:1385 [inline]
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x1a9/0x890 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:65
       copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
       raw_copy_from_user arch/x86/include/asm/uaccess_64.h:125 [inline]
       copy_from_user_iter lib/iov_iter.c:55 [inline]
       iterate_ubuf include/linux/iov_iter.h:29 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
       iterate_and_advance include/linux/iov_iter.h:271 [inline]
       __copy_from_iter lib/iov_iter.c:249 [inline]
       _copy_from_iter+0x257/0x1cf0 lib/iov_iter.c:260
       copy_from_iter include/linux/uio.h:204 [inline]
       copy_from_iter_full include/linux/uio.h:211 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2231 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2257 [inline]
       kcm_sendmsg+0xcca/0x27c0 net/kcm/kcmsock.c:858
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       sock_write_iter+0x2dd/0x400 net/socket.c:1160
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (lock#10){+.+.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_start_locking+0x9c/0x5f0 mm/mmap_lock.c:230
       __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
       stack_map_get_build_id_offset+0x98d/0x9d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1975
       bpf_prog_5c8cb7646b59f521+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
       trace_tlb_flush+0xfa/0x120 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x7cb/0xae0
       context_switch kernel/sched/core.c:5393 [inline]
       __schedule+0x1054/0x4a20 kernel/sched/core.c:6736
       __schedule_loop kernel/sched/core.c:6813 [inline]
       schedule+0x14b/0x320 kernel/sched/core.c:6828
       exit_to_user_mode_loop kernel/entry/common.c:96 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       irqentry_exit_to_user_mode+0xe7/0x270 kernel/entry/common.c:225
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

other info that might help us debug this:

Chain exists of:
  lock#10 --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(lock#10);

 *** DEADLOCK ***

2 locks held by syz-executor.2/5452:
 #0: ffff8880b953e158 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 1 PID: 5452 Comm: syz-executor.2 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 __mmap_lock_do_trace_start_locking+0x9c/0x5f0 mm/mmap_lock.c:230
 __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
 stack_map_get_build_id_offset+0x98d/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
 bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1975
 bpf_prog_5c8cb7646b59f521+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 trace_tlb_flush+0xfa/0x120 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x7cb/0xae0
 context_switch kernel/sched/core.c:5393 [inline]
 __schedule+0x1054/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 exit_to_user_mode_loop kernel/entry/common.c:96 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0xe7/0x270 kernel/entry/common.c:225
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0033:0x7fe38f639ba5
Code: Unable to access opcode bytes at 0x7fe38f639b7b.
RSP: 002b:00007ffe0d7da5f0 EFLAGS: 00000a87
RAX: 00000000984f6378 RBX: 00007fe38f7ac018 RCX: 0000000000000415
RDX: ffffffff81408dcc RSI: 0000000080000000 RDI: 00000000984f6378
RBP: 0000000081408000 R08: 0000001b31220000 R09: 0000000000000dcd
R10: 0000000081372dd1 R11: 0000000000000000 R12: 0000000000000415
R13: 0000000000000001 R14: 00007fe38f7a0000 R15: ffffffff81408dcc
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

