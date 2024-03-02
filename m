Return-Path: <linux-kernel+bounces-89622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C72F86F328
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DC5283BDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FE53E2E;
	Sat,  2 Mar 2024 23:39:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79398F5D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709422744; cv=none; b=qRvS3/NZjWbZxVLkNhkTBgF/icTzPSiB530Adweb9E2r+yE3JIp0H6/R7FreyHLKfhn1n4JGq4Y0oswAsDdKyXsWerqtDOtceXb1AQwO9u5LYBJC+CCqaPbtJmXJmOhMHccfdVh77K4fRXYP38zOTfQrA754NFsfDqUH987fv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709422744; c=relaxed/simple;
	bh=sQM387bJZYIbaXTVDYj5UG3koMqCCKeFa7lj4cswTXs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OojOoxmlRAjSP8HIQ5TrYx1LmfqEswIqtyQ+U82tEL0bmreJeMaNYtjoeuQK6SYHeljMiJy5IXS3qiH3qBearLMCXj6gniwD6IN2Aocfb0iQPoP/Qq9A5gsm0TqQAl1Ct2qETkOc2s64LJN+dXkipCui1o6lBCJtkzeDc1zlJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3659343e9bfso38366915ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 15:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422742; x=1710027542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvMkM2wmfuLmP4w9pf8wweEm8Wsimn6J1pwVxeK67O4=;
        b=ezvBUYVd06ovm/byloSuLEGxLTe2fIu74YhDu72KjSs6OQm85gaWsacODsDNx8+A02
         u/96txE1GuN08hP+o9GVeRu6CSRLTiEee+vJ2Pvx5zSS5IO+7+O4EAdLUTvizpbnHyUb
         miOGF8Tt+Dp87Wv7mCJl8+LSIMxRdsp/khlCvXAQUMVsOl6jA2RptsA1NDXB5qbj0rGF
         c2oaelAZTYt2NTIZPVI5XDefkQ3i6D47uYXVJjUM4KOwiYmz6nBG0rlosSJ9+HUIo5lr
         I+MzISitwqeBdH/2rwlMfK78iG7BMHrt8VscRpAPIHsOrz672YWW8Q8zCo5k2CXEd3aK
         urEw==
X-Forwarded-Encrypted: i=1; AJvYcCW1fxfQ5fWM7AwoN7mkZKa0+NmNE6Hre3ReLel88jOMVTUJn3TvrV/4Dcm//6Waaa93zC4rzFBnPu+8b5K6j7xlCDerMMhLXWhpFcok
X-Gm-Message-State: AOJu0YxXnWn37OjVTPG0S8F/CBvnUUIFqOvebZxB0hbRFNaixR+ygLBI
	fETHYmMHZ+KaxQL9OnSKCigNtDfR+xRGQ9Upsj6pxnXosiB+ivHg60SOJiI/cRzqUqrmLhm4w/G
	w7RQ1HdQt5R7id5dQay41Q/AbrA7QGn5wZS2lsaoPQvKTdnY5hy4SAkQ=
X-Google-Smtp-Source: AGHT+IFVOh45ZadkID0lwr30Y++PNCfbuZPaEi7S1eUkbVKxdf6TP/u+dNNDOJvr25VxmNSW0IAIAvBOct99DLA+7YbPc2P97EWf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:365:c659:58f3 with SMTP id
 w14-20020a056e021c8e00b00365c65958f3mr357951ill.6.1709422742092; Sat, 02 Mar
 2024 15:39:02 -0800 (PST)
Date: Sat, 02 Mar 2024 15:39:02 -0800
In-Reply-To: <20240302230702.1207-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005043250612b5ffb1@google.com>
Subject: Re: [syzbot] [usb?] [media?] KASAN: use-after-free Read in v4l2_fh_open
From: syzbot <syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in v4l2_open

==================================================================
BUG: KASAN: slab-use-after-free in v4l2_open+0x342/0x360 drivers/media/v4l2-core/v4l2-dev.c:432
Read of size 4 at addr ffff8880257b8800 by task v4l_id/5638

CPU: 1 PID: 5638 Comm: v4l_id Not tainted 6.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b5/0x2a0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x510 mm/kasan/report.c:488
 kasan_report+0xcd/0x100 mm/kasan/report.c:601
 v4l2_open+0x342/0x360 drivers/media/v4l2-core/v4l2-dev.c:432
 chrdev_open+0x50f/0x5d0 fs/char_dev.c:414
 do_dentry_open+0x8fd/0x1590 fs/open.c:953
 path_openat+0x280d/0x31d0 fs/namei.c:3645
 do_filp_open+0x26d/0x500 fs/namei.c:3829
 do_sys_openat2+0x12f/0x1c0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1430
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x85/0x160 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd0c998f9a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe99c37580 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffe99c37798 RCX: 00007fd0c998f9a4
RDX: 0000000000000000 RSI: 00007ffe99c38f1e RDI: 00000000ffffff9c
RBP: 00007ffe99c38f1e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe99c377b0 R14: 000056109fa30670 R15: 00007fd0c9b4aa80
 </TASK>

Allocated by task 5003:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x60 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1e6/0x400 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 em28xx_v4l2_init+0x107/0x2dd0 drivers/media/usb/em28xx/em28xx-video.c:2539
 em28xx_init_extension+0x11f/0x1c0 drivers/media/usb/em28xx/em28xx-core.c:1116
 process_scheduled_works+0x96f/0x1490 kernel/workqueue.c:2633
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2787
 kthread+0x2cd/0x360 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

Freed by task 5003:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x30/0x60 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x370 mm/slub.c:4409
 em28xx_free_v4l2 drivers/media/usb/em28xx/em28xx-video.c:2120 [inline]
 kref_put include/linux/kref.h:65 [inline]
 em28xx_v4l2_init+0x1618/0x2dd0 drivers/media/usb/em28xx/em28xx-video.c:2909
 em28xx_init_extension+0x11f/0x1c0 drivers/media/usb/em28xx/em28xx-core.c:1116
 process_scheduled_works+0x96f/0x1490 kernel/workqueue.c:2633
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2787
 kthread+0x2cd/0x360 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff8880257b8000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2048 bytes inside of
 freed 8192-byte region [ffff8880257b8000, ffff8880257ba000)

The buggy address belongs to the physical page:
page:ffffea000095ee00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x257b8
head:ffffea000095ee00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888011442280 ffffea00007c9c00 0000000000000006
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4662, tgid 4662 (dhcpcd), ts 31219348806, free_ts 31206911230
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x3355/0x34e0 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4567
 alloc_slab_page+0x5f/0x150 include/linux/gfp.h:238
 new_slab+0x84/0x2f0 mm/slub.c:2354
 ___slab_alloc+0xc77/0x1310 mm/slub.c:3540
 __kmalloc_node_track_caller+0x2e9/0x570 mm/slub.c:3625
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
 __alloc_skb+0x19f/0x3d0 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1296 [inline]
 netlink_dump+0x204/0xc70 net/netlink/af_netlink.c:2231
 netlink_recvmsg+0x671/0x10f0 net/netlink/af_netlink.c:1990
 ____sys_recvmsg+0x28b/0x570 net/socket.c:1046
 __sys_recvmsg+0x280/0x360 net/socket.c:2845
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x85/0x160 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free pid 4662 tgid 4662 stack trace:
 free_unref_page_prepare+0x94d/0xa60 include/linux/page_owner.h:24
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 __put_partials+0xeb/0x130 mm/slub.c:2453
 put_cpu_partial+0x169/0x240 mm/slub.c:2997
 __slab_free+0x2c3/0x400 mm/slub.c:4166
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:163
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x1dd/0x540 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2023 [inline]
 tomoyo_supervisor+0xdf1/0x1370 security/tomoyo/common.c:2095
 tomoyo_path_permission+0x243/0x360 security/tomoyo/file.c:168
 tomoyo_path_perm+0x442/0x5b0 security/tomoyo/file.c:838
 security_inode_getattr+0xd3/0x120 security/security.c:2238
 vfs_fstatat+0xca/0x1b0 fs/stat.c:173
 __se_sys_newfstatat fs/stat.c:468 [inline]
 __x64_sys_newfstatat+0xff/0x170 fs/stat.c:462
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x85/0x160 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff8880257b8700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880257b8780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880257b8800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880257b8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880257b8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10309dca180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa01a41dc74de670
dashboard link: https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112b2732180000


