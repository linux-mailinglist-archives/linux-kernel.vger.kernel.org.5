Return-Path: <linux-kernel+bounces-68057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28185756D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06BA2860EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56E14280;
	Fri, 16 Feb 2024 04:58:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AA14265
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059486; cv=none; b=vGVYe/+GHglIT2U5ziXv6EoV9Me6MMuiE9iUMMxf6P0E6doaD/JxsGhZSKurOgf+U1FrzVscQBMehJlhsED81EsCAsVQkIS+w4mOoT67f4qOtxs0pGIgRmqwv8s5WFqsuvGroRpB2WkxxuCajDp7wZ4p8uPG+XyKiO3AYUVL+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059486; c=relaxed/simple;
	bh=c4vBWwzv72j2L3t8qV/isuAr3VkpBcJu5KpMhgvIQCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qa2sp5Sf06jGOggoX3daTuY+hgJtOdRlUmhKR5M4/GGDDFLwL1hkl+QaE4HUSx9o6YB3VaKVmFSi3ocY6ae7ogEBZwX+aT8Fz2yDBEnrnWvsyFyiJBa5c5CHH3TidjO54KUToY2SzxvpvdO7wcRMfwGDPuG+mhApL2P31/g0hEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365032b8456so5162235ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708059483; x=1708664283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLodPXML5Zk0wPwfADQcIfKmNWEntwfZVUv61UvKPR8=;
        b=pKHvnHsOr7hFjdB4cZauUMaBpyoBjU39v1C/XsEIw6Eqm+s8HtAk7BFi4hvDBt1YhY
         HUR7A2Q1hDrn80qOIRjfQsGWq0gVM7YVNi/TgMzHmLr8+xRM5p+sZMoJjaaya4w6C3c4
         mt+F+s4xKTpcljCIjAtz++XOsE/9bpyr7XkSpuFfVWGdBmUhL98rfop06AJsRYkcUpmC
         F6WG+hy6EjKnQYoerfdhIaJzMUF937+mAZMZYQVfbAq3/VoP47BI8/3A35hkOhIvQ3bB
         VLr1B/nU8zHBXhpkfaBBG4ZIcVwIuMG60pN8ed2n7WwZY1KopqZXttUWqmhXygi15I0q
         7vig==
X-Forwarded-Encrypted: i=1; AJvYcCXmukTV35fsT/TPZS+mfeJgH7kCaIwxgoNnYrswWxaXBt8N28WT/dE4PZ0fMQW9+sWcjrOBmromVRVtnoEQ3eXFHQqEwOcu0dSN2OjI
X-Gm-Message-State: AOJu0Yxy+vzyPTRDUbEeCXzM3DwhOe3NzQ42YiUiZENw5H5ChpQn9SZp
	5T7uoKlObcutxF9ndtMVDi2V1r79Si15EkST7zq7sYtbRlA/rkBrxJ8r1pSKchpnYbwuuVw7KvY
	QocqknwgX/YOFpF2iLBBe43fFvGHoYfiPQ9klBYVZ/o0gky9LOwfJIHU=
X-Google-Smtp-Source: AGHT+IGC0XNcohkxga31j5bMr7ITRGazyy6kZVzQStkXeUzJq8sLEP8CloiRAAhFJ3gkJ+jwW4ZFhHX8U6jNgKZPb+nUPJxxEmtm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:de50:f7bb with SMTP id
 j15-20020a056e02154f00b00363de50f7bbmr280369ilu.2.1708059483453; Thu, 15 Feb
 2024 20:58:03 -0800 (PST)
Date: Thu, 15 Feb 2024 20:58:03 -0800
In-Reply-To: <20240216004250.1196-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c43ecc06117896ab@google.com>
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (2)
From: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in pvr2_context_set_notify

pvrusb2: You might need to power cycle the pvrusb2 device in order to recover.
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2ba/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:48
Read of size 4 at addr ffff88810fb02ed8 by task pvrusb2-context/902

CPU: 0 PID: 902 Comm: pvrusb2-context Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 pvr2_context_set_notify+0x2ba/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:48
 pvr2_context_thread_func+0x10d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:157
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 724:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:207
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xad/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x350 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2614
 hub_port_connect drivers/usb/core/hub.c:5483 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x2e62/0x4f40 drivers/usb/core/hub.c:5865
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 724:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x105/0x340 mm/slub.c:4409
 pvr_disconnect+0x80/0xf0 drivers/media/usb/pvrusb2/pvrusb2-main.c:79
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x910 drivers/usb/core/hub.c:2267
 hub_port_connect drivers/usb/core/hub.c:5323 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x1be0/0x4f40 drivers/usb/core/hub.c:5865
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff88810fb02e00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff88810fb02e00, ffff88810fb02f00)

The buggy address belongs to the physical page:
page:ffffea00043ec080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10fb02
head:ffffea00043ec080 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 ffffea00041ef600 0000000000000002
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5358, tgid 5358 (kworker/1:4), ts 131458586273, free_ts 131438325014
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x139c/0x3470 mm/page_alloc.c:3311
 __alloc_pages+0x228/0x2250 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4b0/0x1860 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmalloc_trace+0x2ce/0x300 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:207
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
page last free pid 5341 tgid 5341 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x504/0xae0 mm/page_alloc.c:2346
 free_unref_page+0x33/0x2d0 mm/page_alloc.c:2486
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x4a/0x70 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x131/0x2e0 mm/slub.c:3867
 getname_flags.part.0+0x50/0x4e0 fs/namei.c:140
 getname_flags+0x9c/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x9a/0x140 fs/stat.c:303
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:468
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff88810fb02d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810fb02e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810fb02e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88810fb02f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810fb02f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         4f5e5092 Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17133c1c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f5e432f25b85a97
dashboard link: https://syzkaller.appspot.com/bug?extid=ce750e124675d4599449
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c58494180000


