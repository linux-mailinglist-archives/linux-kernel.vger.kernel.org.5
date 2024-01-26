Return-Path: <linux-kernel+bounces-39878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141E83D7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAC6B30BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FFE10A19;
	Fri, 26 Jan 2024 09:04:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C523D6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259871; cv=none; b=BASMAHK1QXRpQGjDFPkanIIbAeed1gg05aSoTp13UVuc/g/ggYGKO4ryPdoCbyoofDLI6SLYjs6xPMSQf5abDVbwj4SWx2Ab28sl0R7rt19oax073KDgJyLJMqwARG7Kl4tbTnKq3xMbFcz5lMn9W1ah0h+kp01ibJVq9wzJ2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259871; c=relaxed/simple;
	bh=XDbimdUWFoooHxeoQEOCAuv79fePvOawtiDbDUeLnHQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bJDvuKYaV2Ys3dcr15dj5okxAJZRQ/RlbNfwUicpQL+yqL5azLSxr9nWJuzOKKQW8HP6xYNyRt9EtcbDHw2q1X+NIKW9TkwQwm+M2fK2RoVc1UKh+ysn+KeQHYbV46DOba3hGlGpEZSGLE+8D0CYXzYTzAlyYm9RDM8yEuaVhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36276d56919so300905ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259869; x=1706864669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdaeC6AnK6g8TWUBcbDr3zSd62fGGI/FAcYK8ZGwfCw=;
        b=b0upmF7VBl5UkUwHQhyyBMyftiOx1nqBs+SsvB+mQudTK7AYiTa5YGxFQyNgzCdRRY
         16akw1MkLhDpyBuBK/vbrp3cv9kyKjnqopMwPfp+v4wwEWwpr6XEMLbOjWwTzJtzAvEI
         0OUQbrBZvFjhfpQWQFhbCm3Ej7DPR+XEEEohi7gkzNhD7+Oy1aqQiml+AEZwvTvE2p6M
         SI8GNnJz5QzKT53k1q9iYTNDs2ktpjoQQa9cuXuq3tY3hAWKT0b3dHRyYLXDvlS9a0LJ
         kXwDWN0UW2JbFalSBve43gIzRyWoFPfLOrzF88hdmjA6pbyNwVMkzlNf0dMD6AniavsI
         ZAog==
X-Gm-Message-State: AOJu0Yzl1oYJywcQZUstFtAGefsBLJq6DnlvZ9S8TVeGhzSSDRgnpjDg
	WNMU0sPwz33mvCf/Me9Edhf/KaUP5HYjLbOCf2mnY6a/g/Cy4fDtyxZKZJa9bElvSJ/31JnSrrb
	EE81+98i93BRPb4Xh3vEEbmzwkqDqXUaQ8wNAxV2Szzm81OQ97XOxM3Y=
X-Google-Smtp-Source: AGHT+IEUBfR6AIqHQeu5mGTnVlYf/wpDjjI1WwySDWfuujP8LyTW5ajqGteW5vnq4uqI5p0hAsPxJ05AS/s9bqalDTw8YQxWHXoY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:361:ae32:f13 with SMTP id
 r11-20020a056e0219cb00b00361ae320f13mr151514ill.6.1706259869040; Fri, 26 Jan
 2024 01:04:29 -0800 (PST)
Date: Fri, 26 Jan 2024 01:04:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063895c060fd59596@google.com>
Subject: [syzbot] [mm?] possible deadlock in __unmap_hugepage_range
From: syzbot <syzbot+a1deb5533794ff31868e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, leitao@debian.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bf1262c53f5 Add linux-next specific files for 20240124
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1218a7abe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4b59a824278780
dashboard link: https://syzkaller.appspot.com/bug?extid=a1deb5533794ff31868e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151a9cf7e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b70cfe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7696d711072d/disk-8bf1262c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92cd47c28072/vmlinux-8bf1262c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/add5c7493418/bzImage-8bf1262c.xz

The issue was bisected to:

commit 947b031634e7af3d265275c26ec17e2f96fdb5a1
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Jan 17 17:10:57 2024 +0000

    mm/hugetlb: restore the reservation if needed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=139660a0180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=105660a0180000
console output: https://syzkaller.appspot.com/x/log.txt?x=179660a0180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1deb5533794ff31868e@syzkaller.appspotmail.com
Fixes: 947b031634e7 ("mm/hugetlb: restore the reservation if needed")

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc1-next-20240124-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor338/5065 is trying to acquire lock:
ffffffff8d925b00 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8d925b00 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3762 [inline]
ffffffff8d925b00 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3843 [inline]
ffffffff8d925b00 (fs_reclaim){+.+.}-{0:0}, at: kmalloc_trace+0x51/0x330 mm/slub.c:4008

but task is already holding lock:
ffff888024054e28 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888024054e28 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: huge_pte_lock include/linux/hugetlb.h:1232 [inline]
ffff888024054e28 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: __unmap_hugepage_range+0x4e5/0x1bf0 mm/hugetlb.c:5611

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (ptlock_ptr(ptdesc)){+.+.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       pmd_lock include/linux/mm.h:3036 [inline]
       __split_huge_pmd+0x21f/0x3090 mm/huge_memory.c:2625
       split_huge_pmd_address mm/huge_memory.c:2658 [inline]
       split_huge_pmd_if_needed mm/huge_memory.c:2670 [inline]
       split_huge_pmd_if_needed mm/huge_memory.c:2661 [inline]
       vma_adjust_trans_huge+0x2da/0x560 mm/huge_memory.c:2682
       __split_vma+0xcb9/0x1190 mm/mmap.c:2363
       split_vma mm/mmap.c:2399 [inline]
       vma_modify+0x261/0x460 mm/mmap.c:2434
       vma_modify_flags include/linux/mm.h:3283 [inline]
       mprotect_fixup+0x228/0xc90 mm/mprotect.c:635
       do_mprotect_pkey+0x8a4/0xdc0 mm/mprotect.c:809
       __do_sys_mprotect mm/mprotect.c:830 [inline]
       __se_sys_mprotect mm/mprotect.c:827 [inline]
       __x64_sys_mprotect+0x78/0xc0 mm/mprotect.c:827
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&mapping->i_mmap_rwsem){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       i_mmap_lock_write include/linux/fs.h:512 [inline]
       dma_resv_lockdep+0x292/0x620 drivers/dma-buf/dma-resv.c:787
       do_one_initcall+0x128/0x690 init/main.c:1236
       do_initcall_level init/main.c:1298 [inline]
       do_initcalls init/main.c:1314 [inline]
       do_basic_setup init/main.c:1333 [inline]
       kernel_init_freeable+0x698/0xc30 init/main.c:1551
       kernel_init+0x1c/0x2a0 init/main.c:1441
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3728 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3742
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slub.c:3762 [inline]
       slab_alloc_node mm/slub.c:3843 [inline]
       kmalloc_trace+0x51/0x330 mm/slub.c:4008
       kmalloc include/linux/slab.h:590 [inline]
       allocate_file_region_entries+0x1a3/0x620 mm/hugetlb.c:666
       region_chg+0x85/0x140 mm/hugetlb.c:786
       __vma_reservation_common+0x443/0x740 mm/hugetlb.c:2832
       vma_needs_reservation mm/hugetlb.c:2899 [inline]
       __unmap_hugepage_range+0xfdb/0x1bf0 mm/hugetlb.c:5681
       unmap_single_vma+0x24b/0x2b0 mm/memory.c:1813
       unmap_vmas+0x22f/0x490 mm/memory.c:1861
       exit_mmap+0x1c1/0xbe0 mm/mmap.c:3258
       __mmput+0x12a/0x4d0 kernel/fork.c:1343
       mmput+0x62/0x70 kernel/fork.c:1365
       exit_mm kernel/exit.c:569 [inline]
       do_exit+0x999/0x2ac0 kernel/exit.c:858
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1020
       __do_sys_exit_group kernel/exit.c:1031 [inline]
       __se_sys_exit_group kernel/exit.c:1029 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &mapping->i_mmap_rwsem --> ptlock_ptr(ptdesc)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(ptlock_ptr(ptdesc));
                               lock(&mapping->i_mmap_rwsem);
                               lock(ptlock_ptr(ptdesc));
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz-executor338/5065:
 #0: ffff88806c3b27a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:168 [inline]
 #0: ffff88806c3b27a0 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x107/0xbe0 mm/mmap.c:3242
 #1: ffff88806c0e20e8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_write mm/hugetlb.c:300 [inline]
 #1: ffff88806c0e20e8 (&resv_map->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_write+0x105/0x140 mm/hugetlb.c:291
 #2: ffff88802507c3c8 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:512 [inline]
 #2: ffff88802507c3c8 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{3:3}, at: __hugetlb_zap_begin+0x242/0x2b0 mm/hugetlb.c:5726
 #3: ffff888024054e28 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff888024054e28 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: huge_pte_lock include/linux/hugetlb.h:1232 [inline]
 #3: ffff888024054e28 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: __unmap_hugepage_range+0x4e5/0x1bf0 mm/hugetlb.c:5611

stack backtrace:
CPU: 0 PID: 5065 Comm: syz-executor338 Not tainted 6.8.0-rc1-next-20240124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3728 [inline]
 fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3742
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slub.c:3762 [inline]
 slab_alloc_node mm/slub.c:3843 [inline]
 kmalloc_trace+0x51/0x330 mm/slub.c:4008
 kmalloc include/linux/slab.h:590 [inline]
 allocate_file_region_entries+0x1a3/0x620 mm/hugetlb.c:666
 region_chg+0x85/0x140 mm/hugetlb.c:786
 __vma_reservation_common+0x443/0x740 mm/hugetlb.c:2832
 vma_needs_reservation mm/hugetlb.c:2899 [inline]
 __unmap_hugepage_range+0xfdb/0x1bf0 mm/hugetlb.c:5681
 unmap_single_vma+0x24b/0x2b0 mm/memory.c:1813
 unmap_vmas+0x22f/0x490 mm/memory.c:1861
 exit_mmap+0x1c1/0xbe0 mm/mmap.c:3258
 __mmput+0x12a/0x4d0 kernel/fork.c:1343
 mmput+0x62/0x70 kernel/fork.c:1365
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2ac0 kernel/exit.c:858
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f39d1ba2c79
Code: Unable to access opcode bytes at 0x7f39d1ba2c4f.
RSP: 002b:00007ffcc6ad06f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f39d1ba2c79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f39d1c1d270 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f39d1c1d270
R13: 0000000000000000 R14: 00007f39d1c1dcc0 R15: 00007f39d1b74a60
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5065, name: syz-executor338
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5065 Comm: syz-executor338 Not tainted 6.8.0-rc1-next-20240124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c0/0x5e0 kernel/sched/core.c:10178
 might_alloc include/linux/sched/mm.h:306 [inline]
 might_alloc include/linux/sched/mm.h:301 [inline]
 slab_pre_alloc_hook mm/slub.c:3762 [inline]
 slab_alloc_node mm/slub.c:3843 [inline]
 kmalloc_trace+0x2a3/0x330 mm/slub.c:4008
 kmalloc include/linux/slab.h:590 [inline]
 allocate_file_region_entries+0x1a3/0x620 mm/hugetlb.c:666
 region_chg+0x85/0x140 mm/hugetlb.c:786
 __vma_reservation_common+0x443/0x740 mm/hugetlb.c:2832
 vma_needs_reservation mm/hugetlb.c:2899 [inline]
 __unmap_hugepage_range+0xfdb/0x1bf0 mm/hugetlb.c:5681
 unmap_single_vma+0x24b/0x2b0 mm/memory.c:1813
 unmap_vmas+0x22f/0x490 mm/memory.c:1861
 exit_mmap+0x1c1/0xbe0 mm/mmap.c:3258
 __mmput+0x12a/0x4d0 kernel/fork.c:1343
 mmput+0x62/0x70 kernel/fork.c:1365
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2ac0 kernel/exit.c:858
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f39d1ba2c79
Code: Unable to access opcode bytes at 0x7f39d1ba2c4f.
RSP: 002b:00007ffcc6ad06f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f39d1ba2c79
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f39d1c1d270 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000000003 R11: 0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

