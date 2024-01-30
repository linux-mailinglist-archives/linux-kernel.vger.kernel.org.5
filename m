Return-Path: <linux-kernel+bounces-45009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E62842A65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C88E28DC45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F95128378;
	Tue, 30 Jan 2024 17:04:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E6128368
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634264; cv=none; b=n7mj9VRUOtlj/TBkCZKwd4/X6dkaNituOnFyNyyMI0iCzB25Us2mWEFUq2iqFsHn6d+nSK/BRjJ3zJuJJMVAxIsU9nGXn0LINNMpWS2ARYI8seJOE+VUxYIoF/D6wIJFXlZBUwBWETeGYr0g9uf80d6dW23L2zny1/FvRUkg74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634264; c=relaxed/simple;
	bh=3pfv8DrhOc+NO9nZeVRJo0p/HPKZ2UWJ4tqbn5dy87Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mjz+Oo+3kpn3wvU2/WRnrh99NrK8UyN+AIuPyWBzGwBgLH0SNGU9ooky5Swal/8oizMEeVDm4ArGlDDPF/6Ab61GgMWtpBB/0cVX4Eyv8283MUuurtnlVk50M8F5oEvTI5BukewZBWqajxwpA7MQbxyD4aDt3M5hYfp/h7mhvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3629478945bso23151345ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634261; x=1707239061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3S9Lo3TYEsIsWYicLYwDhSuraYYj/Ce9WNX//uUIpTQ=;
        b=RaLqeTCXEP2BjnbEITOedJLS7MHYN2+lWx4hIuljJSbpgVxLLkxwroKMd0H6JAE2Ks
         KV974IeUlfST+hPBTVKxqNTw1+czvX62nx/vQBIT9yM2FTzzxmevGZHyyqRNfpSmpH2U
         hjrkmzVZp2BMTDNXnqiep7Q50Bv+LunKYcIKfQwWfpjRUMICrKbMFrur7U4XsSK1Rh3D
         h+6Rg14ISe1oY+Ww3RnWEN40pD9MswmEHk2npRvplNJVVQH762R9XKUXgzo2awjIocgn
         ESUI7ZSF039Edx2aAP52IgRdE1YYZ/XIJKbsBsjj+SZPRJHmplsjfq1t4LVtotCVF/fs
         rCdA==
X-Gm-Message-State: AOJu0Yy3gHuPcK9Vw8uez4hk0FNb/cTV2Rpii3wnEzCj7w9JV0YGPOa7
	liuQlpz6XQ/D0YOAJfBd93KeyDWgbe0wy0u0rqwg63uZDi6UtWNaoD+ULT1/HU2TVHaS0rQHlK+
	hqmSVHuXWWXUlB+8Opc5wuEtyJjy1FzrqY33u9CqxLZNjYXd91RtPHV0=
X-Google-Smtp-Source: AGHT+IFs63ZYxaOvC+Vqhsn0I50xYzxrUJhfinQOcbTiRAFPX86m43ozptEjyNHJ8oM5EZnZIaL9lDQT/SSwLpgR7mE1x7qkflfW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:35f:d260:57b3 with SMTP id
 cd7-20020a056e02320700b0035fd26057b3mr894935ilb.3.1706634261720; Tue, 30 Jan
 2024 09:04:21 -0800 (PST)
Date: Tue, 30 Jan 2024 09:04:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee76c406102cc0bf@google.com>
Subject: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (2)
From: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
To: isely@pobox.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, pvrusb2@isely.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1a27f081c1f usb: typec: qcom-pmic-typec: allow different ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=159f19fde80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70204d1d16341bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=ce750e124675d4599449
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c37a861daee/disk-f1a27f08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09f1af46fd09/vmlinux-f1a27f08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82eb085e0be1/bzImage-f1a27f08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com

pvrusb2: Device being rendered inoperable
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff888111b8fed8 by task kworker/0:6/8544

CPU: 0 PID: 8544 Comm: kworker/0:6 Not tainted 6.8.0-rc1-syzkaller-00046-gf1a27f081c1f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
 pvr2_context_notify drivers/media/usb/pvrusb2/pvrusb2-context.c:95 [inline]
 pvr2_context_disconnect+0x94/0xb0 drivers/media/usb/pvrusb2/pvrusb2-context.c:272
 pvr_disconnect+0x80/0xf0 drivers/media/usb/pvrusb2/pvrusb2-main.c:79
 usb_unbind_interface+0x1e5/0x960 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x910 drivers/usb/core/hub.c:2286
 hub_port_connect drivers/usb/core/hub.c:5334 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5634 [inline]
 port_event drivers/usb/core/hub.c:5794 [inline]
 hub_event+0x1be0/0x4f40 drivers/usb/core/hub.c:5876
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 8544:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:207
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x307/0x9c0 drivers/usb/core/driver.c:399
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
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd80/0x19f0 drivers/usb/core/hub.c:2625
 hub_port_connect drivers/usb/core/hub.c:5494 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5634 [inline]
 port_event drivers/usb/core/hub.c:5794 [inline]
 hub_event+0x2e62/0x4f40 drivers/usb/core/hub.c:5876
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 897:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x105/0x330 mm/slub.c:4409
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
 pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888111b8fe00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff888111b8fe00, ffff888111b8ff00)

The buggy address belongs to the physical page:
page:ffffea000446e380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x111b8e
head:ffffea000446e380 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 ffffea0004698e80 dead000000000003
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6208, tgid 6208 (dhcpcd-run-hook), ts 253184444708, free_ts 252376724208
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x139a/0x3460 mm/page_alloc.c:3311
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab+0xa3/0x360 mm/slub.c:2354
 new_slab mm/slub.c:2407 [inline]
 ___slab_alloc+0x4d2/0x1950 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node+0x177/0x4b0 mm/slub.c:3988
 kmalloc_array_node include/linux/slab.h:688 [inline]
 kcalloc_node include/linux/slab.h:693 [inline]
 memcg_alloc_slab_cgroups+0xa9/0x170 mm/memcontrol.c:2988
 account_slab mm/slub.c:2317 [inline]
 allocate_slab+0x2b5/0x360 mm/slub.c:2372
 new_slab mm/slub.c:2407 [inline]
 ___slab_alloc+0x4d2/0x1950 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc+0x326/0x370 mm/slub.c:3867
 anon_vma_chain_alloc mm/rmap.c:142 [inline]
 anon_vma_fork+0x1fc/0x610 mm/rmap.c:365
 dup_mmap kernel/fork.c:712 [inline]
 dup_mm kernel/fork.c:1685 [inline]
 copy_mm kernel/fork.c:1734 [inline]
 copy_process+0x9306/0x9920 kernel/fork.c:2496
 kernel_clone+0xfc/0x850 kernel/fork.c:2901
 __do_sys_clone+0xba/0x100 kernel/fork.c:3044
page last free pid 4799 tgid 4799 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x503/0xae0 mm/page_alloc.c:2346
 free_unref_page+0x33/0x2c0 mm/page_alloc.c:2486
 __put_partials+0x149/0x160 mm/slub.c:2922
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x4a/0x70 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmalloc_trace+0x13a/0x390 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 usb_control_msg+0xbd/0x4a0 drivers/usb/core/message.c:144
 get_bMaxPacketSize0+0xc3/0x280 drivers/usb/core/hub.c:4779
 hub_port_init+0x6a8/0x3a50 drivers/usb/core/hub.c:4975
 hub_port_connect drivers/usb/core/hub.c:5423 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5634 [inline]
 port_event drivers/usb/core/hub.c:5794 [inline]
 hub_event+0x2c20/0x4f40 drivers/usb/core/hub.c:5876
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888111b8fd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888111b8fe00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888111b8fe80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888111b8ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888111b8ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

