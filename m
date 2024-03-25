Return-Path: <linux-kernel+bounces-117940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4A88B191
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D586296121
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558053365;
	Mon, 25 Mar 2024 20:35:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8B26AFA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398935; cv=none; b=Z3NOiUyoP0VcGxE/UjtNeQ0MjgXqQU6Tebmx9ttulap9hQDAri/QOoPtmrYwJ4gxT3KbXftsnaijot4IAwAhIhbY6+c61DDK+ojFCNHs0Y1qpv5DrYnRb4Mb8wxFoAZBsmeoyXSiimeJ+h/ysQkYidvO0ULWpqz6S08UDkBl774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398935; c=relaxed/simple;
	bh=37ggSoCxozB7Cyl2wDm3qsfZ27NlTK+vQFdVYfei4cA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B894i205fe1IklgXlWj79yiOoBqeWj5O1X5G2r/p3RcrMyB8Wu8JWvd6X/VjbV6JQmQs8XB2EfJG/1DNWqmhmZCtihSBnxLmYq/3dRozycBak2PxQbzoLYCZBKF9tqWlYfBKim8LHz+SeJ5d8W+1dIDACYYBlLi7P1ECpa76d9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-366a7e3099bso48444685ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398933; x=1712003733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlAyYtjNjtQAH1Vx7mUhHpGkqcRI6aawQgkDYlzv1gc=;
        b=ifPIufwFlP/LIvZRPvkCBuLPf3DgIywmIheg93BdUH54IBUfoOnJFAV/LSsQM1pDn8
         xae24UlyWZlap791WMxIYXaGx5pXCczylG22RBU+sYVc675dSb6QwzwhIhmLDbFdnvLj
         WOMF59HwGqsUOmC3U4s5eiXCBarukR6vLmd30Wqifu+5jdE/ZAkyOO2b72Z1j5L4s5Z+
         fl/kYDEHYFK3eLrZFgUysnEsSlrrlk4mID9cpu4yJJNXIQZ2agVOHY4G5v968LS6NNa2
         6UTx+yyrXnqECvCJwUk7H30o2ELNG/tJq0/CazWShyjYp9nZc0lNKUtGhXJcxXVEsdah
         DZtg==
X-Forwarded-Encrypted: i=1; AJvYcCUve/Wp2ObfjQmn40ZiKMMV/98AbipwdXIWtC7DxlotFoMS1g9BmiKJRi4r3Z4JOfZyj9fq+kco4c3fHSNVk1bJnhUWKKnr1f1jDZex
X-Gm-Message-State: AOJu0Yy0Xm9KasEKE/+QP7qSUn2gzGPdAQwXIlTWu+6Uu+KqFIMJ1gu/
	SHLfMgvUT2hvUUCeH/i5YASMRQW91GTVoxPMNqocb88iCx77VV02JQI2UTyDN35HAwSyKlN84xM
	xtaepACM0fnFydEDymSs8YcfBDP2O8hZOl8npJa7cWhDKNHvMFJoaq7c=
X-Google-Smtp-Source: AGHT+IFxotLuc/2BLtMHKiX6jGV63KFZ6RAkinwENKZEE6zwN0DBFvFxwybVEETyWhX1Mlw53tOm4UaVqd3szVXuv0ObRuXoX56F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:368:77f0:7751 with SMTP id
 h4-20020a056e021d8400b0036877f07751mr444046ila.6.1711398933187; Mon, 25 Mar
 2024 13:35:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:35:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b5ec50614821d6f@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_qm_dqget
From: syzbot <syzbot+fa52b47267f5cac8c654@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102618b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=fa52b47267f5cac8c654
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa52b47267f5cac8c654@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.5/6047 is trying to acquire lock:
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc+0x48/0x340 mm/slub.c:3852

but task is already holding lock:
ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:825 [inline]
ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget+0x2c4/0x640 fs/xfs/xfs_dquot.c:901

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&qinf->qi_tree_lock){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       xfs_qm_dqfree_one+0x66/0x170 fs/xfs/xfs_qm.c:1654
       xfs_qm_shrink_scan+0x33f/0x400 fs/xfs/xfs_qm.c:531
       do_shrink_slab+0x6d2/0x1140 mm/shrinker.c:435
       shrink_slab+0x1092/0x14d0 mm/shrinker.c:662
       shrink_one+0x423/0x7f0 mm/vmscan.c:4767
       shrink_many mm/vmscan.c:4828 [inline]
       lru_gen_shrink_node mm/vmscan.c:4929 [inline]
       shrink_node+0x37b8/0x3e70 mm/vmscan.c:5888
       kswapd_shrink_node mm/vmscan.c:6696 [inline]
       balance_pgdat mm/vmscan.c:6886 [inline]
       kswapd+0x17d1/0x36e0 mm/vmscan.c:7146
       kthread+0x2f2/0x390 kernel/kthread.c:388
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3706
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmem_cache_alloc+0x48/0x340 mm/slub.c:3852
       radix_tree_node_alloc+0x8b/0x3c0 lib/radix-tree.c:276
       radix_tree_extend+0x148/0x5c0 lib/radix-tree.c:425
       __radix_tree_create lib/radix-tree.c:613 [inline]
       radix_tree_insert+0x15c/0x680 lib/radix-tree.c:712
       xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:826 [inline]
       xfs_qm_dqget+0x2d4/0x640 fs/xfs/xfs_dquot.c:901
       xfs_qm_vop_dqalloc+0x5a3/0xef0 fs/xfs/xfs_qm.c:1730
       xfs_setattr_nonsize+0x410/0xea0 fs/xfs/xfs_iops.c:707
       xfs_vn_setattr+0x2d1/0x320 fs/xfs/xfs_iops.c:1027
       notify_change+0xb9f/0xe70 fs/attr.c:497
       chown_common+0x501/0x850 fs/open.c:790
       do_fchownat+0x16d/0x250 fs/open.c:821
       __do_sys_chown fs/open.c:841 [inline]
       __se_sys_chown fs/open.c:839 [inline]
       __x64_sys_chown+0x82/0x90 fs/open.c:839
       do_syscall_64+0xfd/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&qinf->qi_tree_lock);
                               lock(fs_reclaim);
                               lock(&qinf->qi_tree_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.5/6047:
 #0: ffff888028a02420 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff8880b4d650b8 (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff8880b4d650b8 (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: chown_common+0x3e1/0x850 fs/open.c:780
 #2: ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:825 [inline]
 #2: ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget+0x2c4/0x640 fs/xfs/xfs_dquot.c:901

stack backtrace:
CPU: 0 PID: 6047 Comm: syz-executor.5 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
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
 __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
 fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3706
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slub.c:3746 [inline]
 slab_alloc_node mm/slub.c:3827 [inline]
 kmem_cache_alloc+0x48/0x340 mm/slub.c:3852
 radix_tree_node_alloc+0x8b/0x3c0 lib/radix-tree.c:276
 radix_tree_extend+0x148/0x5c0 lib/radix-tree.c:425
 __radix_tree_create lib/radix-tree.c:613 [inline]
 radix_tree_insert+0x15c/0x680 lib/radix-tree.c:712
 xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:826 [inline]
 xfs_qm_dqget+0x2d4/0x640 fs/xfs/xfs_dquot.c:901
 xfs_qm_vop_dqalloc+0x5a3/0xef0 fs/xfs/xfs_qm.c:1730
 xfs_setattr_nonsize+0x410/0xea0 fs/xfs/xfs_iops.c:707
 xfs_vn_setattr+0x2d1/0x320 fs/xfs/xfs_iops.c:1027
 notify_change+0xb9f/0xe70 fs/attr.c:497
 chown_common+0x501/0x850 fs/open.c:790
 do_fchownat+0x16d/0x250 fs/open.c:821
 __do_sys_chown fs/open.c:841 [inline]
 __se_sys_chown fs/open.c:839 [inline]
 __x64_sys_chown+0x82/0x90 fs/open.c:839
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe9a027dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe99f5ff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000005c
RAX: ffffffffffffffda RBX: 00007fe9a03abf80 RCX: 00007fe9a027dda9
RDX: 0000000039323420 RSI: 000000000000ee00 RDI: 0000000020000140
RBP: 00007fe9a02ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe9a03abf80 R15: 00007ffd68c11948
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

