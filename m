Return-Path: <linux-kernel+bounces-112255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B388777E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCE21C20E35
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA03DDC1;
	Sat, 23 Mar 2024 08:09:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ADBA50
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711181371; cv=none; b=Cg6WrNoFZ5+JXFd0fnhY76da4W8SVrort6y127lhjKHfhVHcKeazXNQYrFHM80fbAF2IX2bO+jto+2bwFzoEnvUe+1qlNKLE/0mgcp6bOKfAxxtUjb3Drl4VFRfbWogfvtA4QNosBVTpUv/8590HwrvWY0QAz4dW2owoFGj54/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711181371; c=relaxed/simple;
	bh=TPYTAg+k46Ce4+Za5AyfI52kZGELoI0Jp9fT4gqQ4KM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TFEcX7gfpbJf1OlEC5CR8D9UcJr8WMUZx29A+8GU/T8SBqViqng3XraJGAskWI4d49AAYlVXJRd/9tuFRYUdeAtzrjiO9gZWzp7Qo/HUvTJ13JeG32Kl8RS9m6wSmH6iMLxHAppscs8lykf8Yc67cWX7Rc1Up3w2G0mIUxAKQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c88a694b46so263707839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 01:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711181369; x=1711786169;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQl3VaBaRx2B2xK8CSjkwlBxC9Q2i+vABQL7/aaWuog=;
        b=V15p3c/e1vXmcuVD2oWtjDV9KGx5EAoax04M5hi+R/fKm23nwTMNGwbPvkHx0M7Szv
         eHWsaN8hQslCPV8sMzG4VKN9jwwuXKl73IG/fsm2Ag8B9JVcXiW0SLe/noSrESWUDqFs
         NtVGl9yHmxLMQGz0LTjqHXpqEm+OS8xOkMn3SzyDzzR/CWl6sS820ZaXx3o/v0BAe7QA
         BZ7aGLnF1q6goV6shA1xJB5MEidH8g0SOCIe/tZKwpLbzAtQRHQ5MTZxpYyqfIGa5DZZ
         +LxqO/og3RxUwIW/Rl+/YPD95hdaKrTtp+Vrdow0ar+s/stp9zRIMJRQvVmtCGgopXXb
         uR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/xj5V96HF2UzTPFRTo6CAAKzbcHomVcWKi2TfPXJyBXiJlW0Kq1GXGtITvzzpA5VGR9ScYxSG06MCfRYB10y9KaOMyMKdfLOgM2MH
X-Gm-Message-State: AOJu0Yx8FCij5S94ywDaz9nfVvHDDTYZ0m7hV4Quj1h9KvY/hB98TY/h
	nzg4gYEylR61/53KNnguSBHwKbJ7pE+QNCRaS9K26XfQW/gLh65B91BXvAVa0+IqsAZEZaXskMe
	MP9h2ZFUeHJRyf0OXSD0EqpMDuW2EJy/W85xgITWQCcQllTQvNqRyCQU=
X-Google-Smtp-Source: AGHT+IHbYFvhSZtx3bKQhh4R4UATZGvp8tPpbkdCdLl49Z8n9wrq+ai4rVfxq+hCuT9PldborgrCJRBS1NjmgcuO7Xqnp6BAWKRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1608:b0:47c:1c7:6be5 with SMTP id
 x8-20020a056638160800b0047c01c76be5mr69310jas.6.1711181368768; Sat, 23 Mar
 2024 01:09:28 -0700 (PDT)
Date: Sat, 23 Mar 2024 01:09:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1ce0006144f7533@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_icwalk_ag
From: syzbot <syzbot+7766d4a620956dfe7070@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11525d81180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=7766d4a620956dfe7070
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7766d4a620956dfe7070@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
kswapd0/89 is trying to acquire lock:
ffff88814af18118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
ffff88814af18118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
ffff88814af18118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_icwalk_ag+0x1216/0x1aa0 fs/xfs/xfs_icache.c:1713

but task is already holding lock:
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6774 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb3f/0x36e0 mm/vmscan.c:7146

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
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
       vfs_fchown fs/open.c:858 [inline]
       ksys_fchown+0xea/0x160 fs/open.c:869
       __do_sys_fchown fs/open.c:877 [inline]
       __se_sys_fchown fs/open.c:875 [inline]
       __x64_sys_fchown+0x7a/0x90 fs/open.c:875
       do_syscall_64+0xfd/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&qinf->qi_tree_lock){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       xfs_qm_dqget_cache_lookup+0x30/0x870 fs/xfs/xfs_dquot.c:784
       xfs_qm_dqget_inode+0x353/0xaa0 fs/xfs/xfs_dquot.c:986
       xfs_qm_dqattach_one+0x185/0x5e0 fs/xfs/xfs_qm.c:278
       xfs_qm_dqattach_locked+0x3d1/0x4e0 fs/xfs/xfs_qm.c:329
       xfs_qm_vop_dqalloc+0x3fd/0xef0 fs/xfs/xfs_qm.c:1710
       xfs_create+0x568/0x1300 fs/xfs/xfs_inode.c:1041
       xfs_generic_create+0x495/0xd70 fs/xfs/xfs_iops.c:199
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1427/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_open fs/open.c:1429 [inline]
       __se_sys_open fs/open.c:1425 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1425
       do_syscall_64+0xfd/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&xfs_dir_ilock_class){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
       xfs_icwalk_ag+0x1216/0x1aa0 fs/xfs/xfs_icache.c:1713
       xfs_icwalk fs/xfs/xfs_icache.c:1762 [inline]
       xfs_reclaim_inodes_nr+0x257/0x360 fs/xfs/xfs_icache.c:1011
       super_cache_scan+0x411/0x4b0 fs/super.c:227
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

other info that might help us debug this:

Chain exists of:
  &xfs_dir_ilock_class --> &qinf->qi_tree_lock --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&qinf->qi_tree_lock);
                               lock(fs_reclaim);
  lock(&xfs_dir_ilock_class);

 *** DEADLOCK ***

2 locks held by kswapd0/89:
 #0: ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6774 [inline]
 #0: ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb3f/0x36e0 mm/vmscan.c:7146
 #1: ffff88807c6c60e0 (&type->s_umount_key#55){.+.+}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88807c6c60e0 (&type->s_umount_key#55){.+.+}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 1 PID: 89 Comm: kswapd0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
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
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
 xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
 xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
 xfs_icwalk_ag+0x1216/0x1aa0 fs/xfs/xfs_icache.c:1713
 xfs_icwalk fs/xfs/xfs_icache.c:1762 [inline]
 xfs_reclaim_inodes_nr+0x257/0x360 fs/xfs/xfs_icache.c:1011
 super_cache_scan+0x411/0x4b0 fs/super.c:227
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

