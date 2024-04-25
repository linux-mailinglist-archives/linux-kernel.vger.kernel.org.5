Return-Path: <linux-kernel+bounces-159013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B910C8B2824
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DBC1F220D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802E15099C;
	Thu, 25 Apr 2024 18:26:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70914EC66
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714069594; cv=none; b=qrUPTxECN0CXLIdRk2XEdHZIxxsHxV5GZ5kdSZ+kv/bK+IXO7QGpiOPZ7VtDffbBMPrzq0R42HT38n9mNVjau5uGWFDY9SgZJFamBmeut0qgIc6BDh3uZCjravK29zT75Xf8IW7E+kDbJLNeCDs67ibekzIx1hSbJXp78DFSJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714069594; c=relaxed/simple;
	bh=rKgnQJHKuThSAvfOmpu3stEv9lH9G9q0WYGSOuCuldc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BRaFBhqHSSTzpaqQYwk/0ND4HHKslg1r7Oe2ZoCWKSsH0WW4C8+raS8AsJCQ7SGq0Hf2z7750cc6EY6J7j3WTwv4VgPWOUyS0pLH1xoV3k3u9pOUQl+dw/vQydCWU07hv67e9YfUykG75gl3kIPbAKRzh9BdaQ1JFNh623zjL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so132093839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714069592; x=1714674392;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZhvqcrp3mpqDPUFH0oJlbkbLXPhKEiUSvbtftFIWX8=;
        b=TVapWArMPy423On0HAiKTWeqnOL7VZ5OBuKtbbQJBNXEJ5pWInlEUILkxsgoLKdcMK
         EpuQmH1MWmLBogGkdvNmXKDwBY9sxPDcEQHLDDHjR1HQF1XXIoNpLAN75kGNftiPlEiK
         K72J7tYR5SfbscdmRCqgWA12wmA7qTSRNC5LYV+1JfecwCiPRIkxVhGiDWMF1UkqjuPC
         q8zcYjEwhnqtOHnTqpviOo/uMBvRySbJFSfAO8zwjxQVqi+ilHCkolE5PgE6VFd9xRxO
         m53wVpfAQCqV+wMJ5oc7ntxTeRdUHN1Fw789WnsbsOQfd9HqKiHAvNDC1uMFl48yvgVz
         YZDw==
X-Forwarded-Encrypted: i=1; AJvYcCUc4biKV2xtoYpMjzcoPMcvz3FrXnykhIEreRaJ+yIQPnjQ2yHGrFccff+Zf41eBkQTm1x8TG5GYtTi+EpZ6hrsgQiC1Jvd3JL8bl1t
X-Gm-Message-State: AOJu0YySPDpHnUF4vt2nTmxWQOg56zIERrdfwk1s9hEo7EjHjLfw++jp
	sFuHtJgGDDUHxz3xHN/ebGX+06VKW0R8TZLZzHgMIGTIPHnW2OgaaKD4uH4FA8/1IsEBYwOGlzp
	4iX2pgRKfldGAz+bCu+c3Wy5Dq86gsexOBTNzxM0P9RATJ76POIA130Q=
X-Google-Smtp-Source: AGHT+IHB4Jg/Qcj994OPrOQk6FK5aUiGYV0Z+ASmPPnIcDLHCMMtFRNv0Q4CibdovCU3CXw76dPo6jjX1Dr/o4Uke3VsO8ddHdMY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860f:b0:487:ce7:2c63 with SMTP id
 iu15-20020a056638860f00b004870ce72c63mr24500jab.3.1714069591211; Thu, 25 Apr
 2024 11:26:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:26:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ae1d40616efed8e@google.com>
Subject: [syzbot] [bpf?] possible deadlock in stack_depot_save_flags
From: syzbot <syzbot+c065d8dfbb5ad8cbdceb@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e9daf5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=c065d8dfbb5ad8cbdceb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08d7b6e107aa/disk-977b1ef5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c5e543ffdcf/vmlinux-977b1ef5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04a6d79d2f69/bzImage-977b1ef5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c065d8dfbb5ad8cbdceb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0 Not tainted
------------------------------------------------------
syz-executor.3/5489 is trying to acquire lock:
ffffffff8ea48ea8 (pool_lock#2){-.-.}-{2:2}, at: stack_depot_save_flags+0x240/0x830 lib/stackdepot.c:640

but task is already holding lock:
ffff8880121cf9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&trie->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
       0xffffffffa0000856
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x206/0x420 kernel/trace/bpf_trace.c:2420
       trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
       __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
       pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
       queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
       queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
       do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
       _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
       stack_depot_save_flags+0x240/0x830 lib/stackdepot.c:640
       kasan_save_stack mm/kasan/common.c:48 [inline]
       kasan_save_track+0x51/0x80 mm/kasan/common.c:68
       kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
       poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
       __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
       kasan_slab_free include/linux/kasan.h:184 [inline]
       slab_free_hook mm/slub.c:2106 [inline]
       slab_free mm/slub.c:4280 [inline]
       kfree+0x153/0x3a0 mm/slub.c:4390
       find_tree_dqentry+0xc3c/0xfb0 fs/quota/quota_tree.c:702
       find_tree_dqentry+0x6cd/0xfb0 fs/quota/quota_tree.c:698
       find_dqentry fs/quota/quota_tree.c:716 [inline]
       qtree_read_dquot+0x53e/0x7e0 fs/quota/quota_tree.c:736
       v2_read_dquot+0x11e/0x200 fs/quota/quota_v2.c:344
       dquot_acquire+0x194/0x680 fs/quota/dquot.c:463
       ext4_acquire_dquot+0x301/0x4c0 fs/ext4/super.c:6882
       dqget+0x772/0xeb0 fs/quota/dquot.c:977
       __dquot_initialize+0x468/0xec0 fs/quota/dquot.c:1505
       ext4_create+0xb5/0x550 fs/ext4/namei.c:2823
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1427/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_creat fs/open.c:1497 [inline]
       __se_sys_creat fs/open.c:1491 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1491
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (pool_lock#2){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       stack_depot_save_flags+0x240/0x830 lib/stackdepot.c:640
       kasan_save_stack mm/kasan/common.c:48 [inline]
       kasan_save_track+0x51/0x80 mm/kasan/common.c:68
       poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
       __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
       kasan_kmalloc include/linux/kasan.h:211 [inline]
       __do_kmalloc_node mm/slub.c:3966 [inline]
       __kmalloc_node+0x253/0x4e0 mm/slub.c:3973
       kmalloc_node include/linux/slab.h:648 [inline]
       bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
       trie_update_elem+0x1d3/0xc10 kernel/bpf/lpm_trie.c:333
       bpf_map_update_value+0x4d5/0x540 kernel/bpf/syscall.c:203
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5648
       __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5765
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&trie->lock);
                               lock(pool_lock#2);
                               lock(&trie->lock);
  lock(pool_lock#2);

 *** DEADLOCK ***

2 locks held by syz-executor.3/5489:
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff8880121cf9f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

stack backtrace:
CPU: 1 PID: 5489 Comm: syz-executor.3 Not tainted 6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 stack_depot_save_flags+0x240/0x830 lib/stackdepot.c:640
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node+0x253/0x4e0 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
 trie_update_elem+0x1d3/0xc10 kernel/bpf/lpm_trie.c:333
 bpf_map_update_value+0x4d5/0x540 kernel/bpf/syscall.c:203
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5648
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efe77c7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efe789050c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007efe77dabf80 RCX: 00007efe77c7dea9
RDX: 0000000000000020 RSI: 00000000200002c0 RDI: 0000000000000002
RBP: 00007efe77cca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efe77dabf80 R15: 00007fffff8122a8
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

