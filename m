Return-Path: <linux-kernel+bounces-64718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CE8541E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3FDB28124
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34866D30B;
	Wed, 14 Feb 2024 03:55:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BCC8DD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882904; cv=none; b=KBuF4XoGK021Tk2PqDwv0OSNxidqCzZfULsiFnv2hLVakGnrs3xqaTSsS0LapTsSLgVe5G7CynoR9QxsvDGfZrt0TpTQz2e8PhRBCaHbT1UbpFyvicd3IkK7IOm2HQWLOgxyp8KgRu+0tGSy0/dEU6nLw1rGMEUSFQoOzxv5Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882904; c=relaxed/simple;
	bh=Mg49Q2CGayMNqCEhgssGluFZqZGt5GJGi3+zxt2uGw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cYfnjE+DAUJmtddpsaNiw9RG4XqRboZRfEOXDr28Lr9+k1i77+JOmrpMomSq1J2mBavNqTf4aYIWcXeQZnOSiIw00/FGqPsz4dCELoiputYWWYlV2FkZ8vEqI/04frRw2e2I/ZOCEsLkLQqN7zoJUpuUhv6ScFYUDtEJtaW3q1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c477fbce84so120638639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707882902; x=1708487702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1x/RiY8N5aN556ImOhYDGWn7L9zJcIZaBoWk0TUdVog=;
        b=acTURv3dZthawIXXQ4gx/Z0oTNMV70krK8aZxdwVrygA7iPBMExEcFsB7lJ1o26wtt
         EhD5D7yB+GDoI8ayionJgi5HmBR1gDHpaFgp909ej9jM0RrzZyPKSmZscNlcPH/NTFIL
         RJXEySSMyPaBnyDsbfI+40+X/IPqbql1RtDQhZyoC0mpVMawNF5k27TWXauQQd8q+yzL
         PlHf5256HT25xTXPZ+LXSJEJOpNz4CtL43svg7LDQe4741mxE2cR+CG7lvQsZqi8y4v4
         6xKNyws0liHKDMaJZzdiKFLeoMvx9I8PbjLkGj12CCYGZNvyBrrqmmMxcCFmHx4HKas1
         uHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1IpbVLxdnd5GKLtkI58fsObu+9ePRWVPrNPc3/bA372NdBNliJNx2JwzF0pBrDEvmYLGsvgTwaCR5mAY6rgVl0UVCg6Mp0F2if3QB
X-Gm-Message-State: AOJu0YzklJlPyHHCS7xmlhL/2+g3HvyZ53ZwGc36/SrXyMHFX7h0kGQh
	yb9hnoIGK8jm4bGoeqNFUohHEMzqi3yZCpSHs60WEsZenORSb6y/cj5sNvXJW33VW6xHjsstyji
	HGT88e/bLNjLV9fOlAuCRCrk7/l24XbJsi6YEh+kXL2NHIN2R7ZI4vy0=
X-Google-Smtp-Source: AGHT+IEJQT3jfEfPVX5whtW5jP9OwMxNd+mnmMaZLmNn4cgGLU6rNxy7vQ27AhgPR6w5Yf4oo7b3xH57025PtzI/aGY0kOrNSzgR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:364:265c:c7ee with SMTP id
 a11-20020a92c54b000000b00364265cc7eemr99843ilj.5.1707882901957; Tue, 13 Feb
 2024 19:55:01 -0800 (PST)
Date: Tue, 13 Feb 2024 19:55:01 -0800
In-Reply-To: <20240214033938.338-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0753706114f79b4@google.com>
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_atomic_helper_wait_for_vblanks (2)
From: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks

==================================================================
BUG: KASAN: slab-use-after-free in drm_atomic_helper_wait_for_vblanks.part.0+0x84f/0x930 drivers/gpu/drm/drm_atomic_helper.c:1661
Read of size 1 at addr ffff88802a5f2409 by task kworker/u16:9/1096

CPU: 0 PID: 1096 Comm: kworker/u16:9 Not tainted 6.8.0-rc4-syzkaller-g7e90b5c295ec-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound commit_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 drm_atomic_helper_wait_for_vblanks.part.0+0x84f/0x930 drivers/gpu/drm/drm_atomic_helper.c:1661
 drm_atomic_helper_wait_for_vblanks drivers/gpu/drm/drm_atomic_helper.c:1657 [inline]
 drm_atomic_helper_commit_tail+0xcb/0xf0 drivers/gpu/drm/drm_atomic_helper.c:1757
 commit_tail+0x356/0x410 drivers/gpu/drm/drm_atomic_helper.c:1834
 process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5653:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 drm_atomic_helper_crtc_duplicate_state+0x70/0xd0 drivers/gpu/drm/drm_atomic_state_helper.c:177
 drm_atomic_get_crtc_state+0x162/0x440 drivers/gpu/drm/drm_atomic.c:362
 page_flip_common+0x57/0x320 drivers/gpu/drm/drm_atomic_helper.c:3629
 drm_atomic_helper_page_flip+0xb6/0x190 drivers/gpu/drm/drm_atomic_helper.c:3690
 drm_mode_page_flip_ioctl+0x103f/0x1470 drivers/gpu/drm/drm_plane.c:1489
 drm_ioctl_kernel+0x1ec/0x3e0 drivers/gpu/drm/drm_ioctl.c:744
 drm_ioctl+0x5d8/0xc00 drivers/gpu/drm/drm_ioctl.c:841
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 5652:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 drm_atomic_state_default_clear+0x3aa/0xde0 drivers/gpu/drm/drm_atomic.c:225
 drm_atomic_state_clear drivers/gpu/drm/drm_atomic.c:294 [inline]
 __drm_atomic_state_free+0x185/0x2b0 drivers/gpu/drm/drm_atomic.c:311
 kref_put include/linux/kref.h:65 [inline]
 drm_atomic_state_put include/drm/drm_atomic.h:490 [inline]
 drm_client_modeset_commit_atomic+0x70f/0x850 drivers/gpu/drm/drm_client_modeset.c:1057
 drm_client_modeset_commit_locked+0x14d/0x580 drivers/gpu/drm/drm_client_modeset.c:1156
 drm_client_modeset_commit+0x4f/0x80 drivers/gpu/drm/drm_client_modeset.c:1182
 __drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:251 [inline]
 __drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:230 [inline]
 drm_fb_helper_restore_fbdev_mode_unlocked drivers/gpu/drm/drm_fb_helper.c:278 [inline]
 drm_fb_helper_lastclose+0xc7/0x160 drivers/gpu/drm/drm_fb_helper.c:2005
 drm_fbdev_generic_client_restore+0x2c/0x40 drivers/gpu/drm/drm_fbdev_generic.c:258
 drm_client_dev_restore+0x188/0x2a0 drivers/gpu/drm/drm_client.c:247
 drm_release+0x32f/0x3e0 drivers/gpu/drm/drm_file.c:437
 __fput+0x270/0xb80 fs/file_table.c:376
 __fput_sync+0x47/0x50 fs/file_table.c:461
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x87/0x100 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff88802a5f2400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 9 bytes inside of
 freed 512-byte region [ffff88802a5f2400, ffff88802a5f2600)

The buggy address belongs to the physical page:
page:ffffea0000a97c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802a5f3c00 pfn:0x2a5f0
head:ffffea0000a97c00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000a40(workingset|slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000a40 ffff888014c42c80 ffffea0000a4e410 ffffea00009bd610
raw: ffff88802a5f3c00 000000000010000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5166, tgid 5166 (syz-executor.0), ts 45262333507, free_ts 42769982140
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4af/0x19a0 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x3b8/0x440 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 fib6_info_alloc+0x40/0x100 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x337/0x1b70 net/ipv6/route.c:3749
 ip6_route_add+0x26/0x150 net/ipv6/route.c:3843
 addrconf_prefix_route+0x2fe/0x510 net/ipv6/addrconf.c:2437
 inet6_addr_add+0x609/0xbe0 net/ipv6/addrconf.c:3004
 inet6_rtm_newaddr+0x11de/0x1ab0 net/ipv6/addrconf.c:4976
 rtnetlink_rcv_msg+0x3c7/0xe10 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1367
page last free pid 5115 tgid 5115 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 kmem_cache_alloc_bulk+0x439/0x950 mm/slub.c:4655
 mt_alloc_bulk lib/maple_tree.c:167 [inline]
 mas_alloc_nodes+0x39b/0x860 lib/maple_tree.c:1264
 mas_node_count_gfp+0x105/0x130 lib/maple_tree.c:1322
 mas_preallocate+0x3bb/0x1020 lib/maple_tree.c:5508
 vma_iter_prealloc mm/internal.h:1147 [inline]
 __split_vma+0x47a/0x1190 mm/mmap.c:2348
 split_vma mm/mmap.c:2407 [inline]
 vma_modify+0x32a/0x460 mm/mmap.c:2449
 vma_modify_flags include/linux/mm.h:3283 [inline]
 mprotect_fixup+0x228/0xc90 mm/mprotect.c:635
 do_mprotect_pkey+0x860/0xd70 mm/mprotect.c:809
 __do_sys_mprotect mm/mprotect.c:830 [inline]
 __se_sys_mprotect mm/mprotect.c:827 [inline]
 __x64_sys_mprotect+0x78/0xc0 mm/mprotect.c:827
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff88802a5f2300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802a5f2380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802a5f2400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88802a5f2480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a5f2500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         7e90b5c2 Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15228d14180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df82262440d95bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fc6742180000


