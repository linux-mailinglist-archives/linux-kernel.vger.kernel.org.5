Return-Path: <linux-kernel+bounces-160928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A18B44A0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69063283F1D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B4541A92;
	Sat, 27 Apr 2024 06:52:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC24175A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714200726; cv=none; b=f4ngi3SSWeQY/KKTUuHxIryX7FjdoUFtgRGSOVgPCFaM20WspyMaAGM14Sm3E82+TaKLNAenCs/tG8/AiNpuktlDHHejPVjbKE93m5ilny9TiRKm3UrdrX2FKkox4Bu20jUYJ+WcvYnSFJAvZ09xKAOrJQLKlHCBnPTv3CmECAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714200726; c=relaxed/simple;
	bh=e3FEAwjBQv0c+lDjnF8fORBFZ1H1tATKSsFWTxLIW+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aOJxUbxBCfUctSy4VYGSJFKB2ffnwUAS2EFIIvvPzXytCf3V4JYhLSzuiYBdaMUzeVpaiJ4Zoil0/5nCuE1keLYVCEGFiXwoibzgQjtKU67REKOUQ28RONyNLKr+TTMp3kxgAmylL8IxFct7oCg7vH5nGfws2YoOr7vHbJhZFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so303411939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714200724; x=1714805524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geAs2BSZzkh9VGQ26gdSyOMUEweu6nGx9ApCb/lpz0E=;
        b=Syip58vS6a6bISA82XX9GA5gp7uPRET3bxleiNRVrCM8tWUIfTjVbUDY615oBv+8RU
         mmTHwM0jyGtPAUT9ULB1Zz/70ItH1r3hWGcyYtZbFJWIN44IbtmheSoLsNSBe9R2nfNk
         Q2f2xbgJXTuleMarGbtfoI7oqSjcH+oKdQfMdQPM2vvgxmTefsJiHYMTcEhQ33Pt4Sik
         sTtsPRZP8iZEtd2vaDhDGCCPZRaSp9pHJ639OgNiaSek6+I4NyXr3uAaGrAYE561xIeX
         IwuVlXoFLgP6ad/gJZnwlm3XRGqCxnfsGfC7QIFkk5TRxazbRLK9CSBnoO1O8KsZQAkS
         RC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXPTh9rzT/2Q02nKK86sRY1Q5ghUTR4r0o2Fqb4NvKnOjEuPWGP0m6ClPD8ywruVL2snWNQ8d23sIbpN9sIWGAqvTmwGmfyBiqaZHxr
X-Gm-Message-State: AOJu0Yxb23yK1hy+kmOsDRQcrtRITrb8kL5hhvZYeDqggV+zZeN6+9H5
	M/aZmgYH7VjfOym8jimXiuN64hQpcA0fVR2hLCOllCze/Mo095IRYiUh2cglWc/p2IdCl6eikfF
	/JYSEyNFC8qZNKuEMrUPinLgAgttAZ+PEcACHO42gy6wNNLwImns9cpg=
X-Google-Smtp-Source: AGHT+IFkU20qG/wc2ekZARSzriT5O8CdIbTTsEfP2/e6bHhZd96SE3mCt0CTY50Zke6KG/ctiPBtlbY8i4JzU6eZ0eKxa3+vprlZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8792:b0:482:cfdd:daeb with SMTP id
 ix18-20020a056638879200b00482cfdddaebmr109458jab.5.1714200724170; Fri, 26 Apr
 2024 23:52:04 -0700 (PDT)
Date: Fri, 26 Apr 2024 23:52:04 -0700
In-Reply-To: <20240427062943.3685-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cfb0206170e7568@google.com>
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
Read of size 8 at addr ffff88806dd4e688 by task syz-executor.0/5508

CPU: 0 PID: 5508 Comm: syz-executor.0 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53-dirty #0
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
 do_dentry_open+0x90f/0x15b0 fs/open.c:956
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1408
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8548c7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f85499fd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f8548dabf80 RCX: 00007f8548c7dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007f8548cca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8548dabf80 R15: 00007fff70180958
 </TASK>

Allocated by task 5494:
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
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4001
 do_mknodat+0x3ec/0x5b0
 __do_sys_mknodat fs/namei.c:4079 [inline]
 __se_sys_mknodat fs/namei.c:4076 [inline]
 __x64_sys_mknodat+0xa9/0xc0 fs/namei.c:4076
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5504:
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

The buggy address belongs to the object at ffff88806dd4dfe0
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff88806dd4dfe0, ffff88806dd4e6c0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6dd48
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888029458b01
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888019733b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080110011 00000001ffffffff ffff888029458b01
head: 00fff80000000840 ffff888019733b40 dead000000000122 0000000000000000
head: 0000000000000000 0000000080110011 00000001ffffffff ffff888029458b01
head: 00fff80000000003 ffffea0001b75201 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5493, tgid 401221234 (syz-executor.0), ts 5494, free_ts 64399791889
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
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 ntfs_iget5+0xc7/0x3b70 fs/ntfs3/inode.c:525
 ntfs_fill_super+0x25dc/0x49c0 fs/ntfs3/super.c:1206
 get_tree_bdev+0x3f7/0x570 fs/super.c:1614
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
page last free pid 5059 tgid 5059 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_folios+0x185/0xb30 mm/page_alloc.c:2536
 folios_put_refs+0x8eb/0xa10 mm/swap.c:1034
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:329
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1683 [inline]
 zap_pmd_range mm/memory.c:1722 [inline]
 zap_pud_range mm/memory.c:1751 [inline]
 zap_p4d_range mm/memory.c:1772 [inline]
 unmap_page_range+0x3e36/0x4820 mm/memory.c:1793
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1883
 exit_mmap+0x2cb/0xd60 mm/mmap.c:3267
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:569
 do_exit+0x99e/0x27e0 kernel/exit.c:865
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 get_signal+0x16a1/0x1740 kernel/signal.c:2911
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89

Memory state around the buggy address:
 ffff88806dd4e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806dd4e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806dd4e680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff88806dd4e700: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88806dd4e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e33c4963 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=109b0028980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12632380980000


