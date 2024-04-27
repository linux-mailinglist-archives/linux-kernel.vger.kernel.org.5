Return-Path: <linux-kernel+bounces-160873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21BC8B43DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A3DB219D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE843A1DA;
	Sat, 27 Apr 2024 02:58:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60FE2E852
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714186685; cv=none; b=gbe8nmyV2jbzSwNHULQ2sAv25MYXNvbm4B2a8FfHuoLtcCcEXo1MUJBJpFpmE9n9HaJF8PDQT4uK12r6im+DEYPf8GRLJfcOoxTYzWMMRf9o5y/XGuRUv9F5Ghrmp5ANXAWqtB5/oilr5ZDUWpYrRfro6dicAMvW6UAdDOJnKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714186685; c=relaxed/simple;
	bh=ucNEDN/dQFoOk9VDQmydpKQE25DmiyxrNFIdUwbpgGk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l59hM96XYW+QUxNOVBooTLtqDcYETBQABDap6vk4Dc/P0tIaAyqWXbFG//4jantW/mWSHz6Aodg6YAuq5SMEbMhfZb5eYISgBXc3gz+5ErJPsLxn9wE5yXzloFiydu5D7Tol+li8G6LzMuW7mi1PpEzNa1wtD215kjnXPC5oYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c05c86944so29751045ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714186683; x=1714791483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KLPcle9dYsxSOes5/QgIH1a5ePOxxCd8cfc4wdRvSk=;
        b=su4/DYlxHCDQeme0FfibmGxvhyq8CuZztbjDTfhnKxxe9IQUeSwgIyyit9ROOLe5t8
         6qijSRQXBo0EOjF0LcbUGu3QADt6D9EkcYW1K8Q3lVRHIdWBw7nlzI1CVComc/q8/p31
         wB6j3UsGoI9OVhqrvMCmBFpkNTHt6DjRpQpbZMqEEF/tN8IsrtsW7XuMDO8yvO/ee2i2
         rZeDxXWhoFVvXssP+ZtgPQRMU0Lz7UwXOqascoTZyyPBiSz4yVXA7tmx3vizp7JeTFYS
         c4I+ItRIBYy/XZ5wSQxrXwLWXoFC0f2WDsajv2L9P09fHpISHaH7WbRVYpHbpLYfWTIo
         wYyg==
X-Forwarded-Encrypted: i=1; AJvYcCUjbo6M5dKqVm6qqfUXeXkMDDntM5SEP42hF7VW7wrmvATdqyXdaa4ozA8qUQFN2jtudJJp1lDpNEDMXJIQeZedZ+QnjfJ4Nx1ZyzyV
X-Gm-Message-State: AOJu0Yx2h7RAwLWutnFeYvTWg6hPaiFYpJ1GAwXL8CysMhvLsUgL+qpE
	IhkTxWNDTnn3Ym5NZUJ/Qus2yBxKYzWhG2YvwXmj5cdgUewZH6RNa6Yg3QQEHtWGAZOm3qiXB66
	xAfFAMW4UtYpsq3U0NGpeYcUGFwtT5H98kdTjhBgXflwTdXJAiBAvvt4=
X-Google-Smtp-Source: AGHT+IEYNDptGFikLokqFWhwUhYFkmMP4Ip+ZX1Wz/zz0H0eenZKZstTl3Pb3KYiuGTnZ6pDlkzRc/VqvHx391ht0OhSEfXfHjJ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12eb:b0:369:f7ca:a361 with SMTP id
 l11-20020a056e0212eb00b00369f7caa361mr161182iln.1.1714186682961; Fri, 26 Apr
 2024 19:58:02 -0700 (PDT)
Date: Fri, 26 Apr 2024 19:58:02 -0700
In-Reply-To: <20240427020615.3615-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051236f06170b30c9@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in chrdev_open

loop0: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
Read of size 8 at addr ffff888065670e08 by task syz-executor.0/5500

CPU: 1 PID: 5500 Comm: syz-executor.0 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 chrdev_open+0x2a9/0x630 fs/char_dev.c:396
 do_dentry_open+0x907/0x15a0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2915/0x3350 fs/namei.c:3800
 do_filp_open+0x235/0x490 fs/namei.c:3829
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8392c7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8393a480c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f8392dabf80 RCX: 00007f8392c7dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007f8392cca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8392dabf80 R15: 00007ffea989b878
 </TASK>

Allocated by task 5490:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_lru+0x178/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:557
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 ntfs_new_inode+0x45/0x100 fs/ntfs3/fsntfs.c:1688
 ntfs_create_inode+0x687/0x3c30 fs/ntfs3/inode.c:1333
 ntfs_mknod+0x41/0x60 fs/ntfs3/namei.c:128
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4004
 do_mknodat+0x3ec/0x5b0
 __do_sys_mknodat fs/namei.c:4082 [inline]
 __se_sys_mknodat fs/namei.c:4079 [inline]
 __x64_sys_mknodat+0xa9/0xc0 fs/namei.c:4079
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x10b/0x2c0 mm/slub.c:4344
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:2734 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2838
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1538
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1555
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:619
 kill_block_super+0x44/0x90 fs/super.c:1675
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1785
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888065670760
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff888065670760, ffff888065670e40)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65670
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802a080d01
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff8880197f43c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080110011 00000001ffffffff ffff88802a080d01
head: 00fff80000000840 ffff8880197f43c0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080110011 00000001ffffffff ffff88802a080d01
head: 00fff80000000003 ffffea0001959c01 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5489, tgid -418021809 (syz-executor.0), ts 5490, free_ts 17403651762
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x253/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:557
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 ntfs_new_inode+0x45/0x100 fs/ntfs3/fsntfs.c:1688
 ntfs_create_inode+0x687/0x3c30 fs/ntfs3/inode.c:1333
 ntfs_atomic_open+0x423/0x570 fs/ntfs3/namei.c:434
 atomic_open fs/namei.c:3360 [inline]
 lookup_open fs/namei.c:3468 [inline]
 open_last_lookups fs/namei.c:3566 [inline]
 path_openat+0x10bb/0x3350 fs/namei.c:3796
 do_filp_open+0x235/0x490 fs/namei.c:3829
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6572
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1036
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1416
 do_one_initcall+0x248/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
 do_initcalls+0x3f/0x80 init/main.c:1323
 kernel_init_freeable+0x435/0x5d0 init/main.c:1555
 kernel_init+0x1d/0x2b0 init/main.c:1444
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888065670d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065670d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888065670e00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff888065670e80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888065670f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e33c4963 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17912d17180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=144757d8980000


