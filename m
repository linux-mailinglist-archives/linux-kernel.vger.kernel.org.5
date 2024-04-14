Return-Path: <linux-kernel+bounces-143979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8798A4053
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC031C20E46
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713051AACB;
	Sun, 14 Apr 2024 04:26:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320331B94F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713068792; cv=none; b=TrxGYvZVtqtqlOawg7kcpOFUl4XWDYEl2Naw3FsMi94Dv8X3L13cE3TJuzu9lrItK2KjDenuJUaXuT0ZkfeS69RnRAIFiQ5oYxlidPXMBG7FoLbPbJQ9ylsvLbC0w7+5lUHik0diJ7PZlj+dsSJHzo6R4U7cbA+1wZixYs7EVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713068792; c=relaxed/simple;
	bh=K7+94VZ6flk/XGxyRSZSFG9ojdw4d+3TLngtW5x9tzw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qu2Wiy2shpTujog2va/oYk+WskOC+b0rbpMohwhmreXBRp/2d13A77f0ifkFpYssI56tjU8zyP2DQ39a9CPlhFLaBEkyyOeV4Stsx14iNZRIKsFZIjASNnnYgOgyNENfLMjfNDHLiyWyt8ku5bOC8yF5fAb4OnMFsQ+YUhc3U50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5db4ed86bso286841439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713068790; x=1713673590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k66LOr5XJ0LWvTSmA1uuMMGCAFm/HsiE6UPg36IHeCE=;
        b=fuvvLXrNy07r30uYNjO1W4LMkDHD0ui6R6AsmeyVnMuzB04iXHzZOmUzI3bs5BNgxl
         lZcOd1s35+Wt4rm53ZQacAQbAUxWqjCCMHc4orFh5SjXwMkzdAc2OeinjV+XnHcvEsPB
         dHM+YXS/R9Zf6JY0D9hzve+s1GZIhFr7Xq+SMxD9a526CczOVn1zZRjqyRvCV3aESP+8
         Wo5GBFsheBlW9yOC5FXPiFG7jxWxVaRey84FcyWjkDUpepkl+x91ty6XVvubLgr9UaNv
         wEL/sjHwDCnYI6Dj8WJwGcAN37Vm6QlSmjKYoKzyV/Qz9b7WCtfX9ZN8skoyFNH+HYVQ
         FdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr2LFaWxv7Zn4nM3QGLeHmRiGuW8dAjwAHV2ilXb0A9bF2tOvK7whrzq8EPSKKAglOWmGrM3rsKSi/RmAIF9c6xF7UbunNBYCY7h2M
X-Gm-Message-State: AOJu0YzSkQkFi8t+TGR8bIrEck42SUEfYeTohQcq9qtdI1WLTmE7BdpZ
	u3mjvK8Jr8fpCzFmX/uyRa9gzYGsuOFG6soWKD0F9e4chXuLiRm8wCDlZzt9Wcj64xkvjuIjk/e
	+BcwtZgx35/mGiMaAoDaNnCVUBv4aT6vH26d8MuQ+AfnoKXzVKRW0kD4=
X-Google-Smtp-Source: AGHT+IFu3pD69TuJiCe/OBoJte4JcjV3aX620fX55FpXDQNuXuLEmIZJsHzBg0mrSIR93xzRI0u60QkxOzgikTWteCjcO/OfLV1d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1496:b0:47f:1ad4:2c66 with SMTP id
 j22-20020a056638149600b0047f1ad42c66mr286127jak.5.1713068790460; Sat, 13 Apr
 2024 21:26:30 -0700 (PDT)
Date: Sat, 13 Apr 2024 21:26:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb465d061606e827@google.com>
Subject: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (3)
From: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
To: isely@pobox.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, pvrusb2@isely.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a788e53c05ae usb: usb-acpi: Fix oops due to freeing uninit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=157d4305180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=d0f14b2d5a3d1587fbe7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dd1e13180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120ca915180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/070d17d2f510/disk-a788e53c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13f35a4bb3f0/vmlinux-a788e53c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6825f1cdc918/bzImage-a788e53c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com

pvrusb2: Device being rendered inoperable
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff88811356ced8 by task kworker/0:2/720

CPU: 0 PID: 720 Comm: kworker/0:2 Not tainted 6.8.0-rc6-syzkaller-00190-ga788e53c05ae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
 device_del+0x39a/0xa50 drivers/base/core.c:3828
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x910 drivers/usb/core/hub.c:2296
 hub_port_connect drivers/usb/core/hub.c:5352 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x1be0/0x4f40 drivers/usb/core/hub.c:5894
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 720:
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
 device_add+0x117e/0x1aa0 drivers/base/core.c:3639
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2210
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
 device_add+0x117e/0x1aa0 drivers/base/core.c:3639
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2643
 hub_port_connect drivers/usb/core/hub.c:5512 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 port_event drivers/usb/core/hub.c:5812 [inline]
 hub_event+0x2e62/0x4f40 drivers/usb/core/hub.c:5894
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

Freed by task 904:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:643
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x105/0x340 mm/slub.c:4409
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
 pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff88811356ce00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff88811356ce00, ffff88811356cf00)

The buggy address belongs to the physical page:
page:ffffea00044d5b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11356c
head:ffffea00044d5b00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 ffffea000447f900 0000000000000003
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 11334302324, free_ts 0
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
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node_track_caller+0x171/0x420 mm/slub.c:4001
 __do_krealloc mm/slab_common.c:1187 [inline]
 krealloc+0x5d/0xf0 mm/slab_common.c:1220
 add_sysfs_param+0xca/0x960 kernel/params.c:654
 kernel_add_sysfs_param kernel/params.c:817 [inline]
 param_sysfs_builtin kernel/params.c:856 [inline]
 param_sysfs_builtin_init+0x2ca/0x450 kernel/params.c:990
 do_one_initcall+0x11c/0x650 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x682/0xc10 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88811356cd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811356ce00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88811356ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88811356cf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811356cf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

