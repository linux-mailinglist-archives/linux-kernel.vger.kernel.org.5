Return-Path: <linux-kernel+bounces-67316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0A8569A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6E0B21AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31E135A68;
	Thu, 15 Feb 2024 16:37:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086891754B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015024; cv=none; b=M2/rArCGQGAL4H/dZ/gjK5gPf+9ZNHLH8ahz8VbokFisfqFktPM+hLWKF6BeBrXkx3ZP/18x0o2L0RpUVKH7ooivhYkvV5SpYk+uX5HYk4ciZApV2wQe1SCRfw2v150LuRQwaCgF4q8pTQVeMhLnZZxTJVkUSzNF6mWPuj61sWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015024; c=relaxed/simple;
	bh=SjhsIwepjenUGscM9ujcgMsHcQEqigjeNEmdxV4gpdo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=psa9eINNuyuMD/h9xIpEjgkg5hpwFGXVSt1uOu+ydpXUNuCEKAKD7bVqLSrUMgWxC3PDOHkt7BzFBwjNH7eN4oOeL1xKFo6fzy8OUuskvREl+H1NcJaLOtary75iEixfrypuIKCxAq1LK9CqUnY/pUX15mNQ+e948mVaq8ftziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b6ee24d3so7696985ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015022; x=1708619822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At8aPq34g0S1dpJEL+5iAzFNnqKIrTdyw2pnuz/fiMs=;
        b=e2v0gFQhZCHsSMCjU8UnheIADvwOtudOSJipE+2drqfWfh+js0L4beFKtaTPO81ZL+
         qNC2Zf1nSj47wFdNnL4gtxKV4g/sktTfKwWYYmQOCUWxwK7nSnsWdnfqPTBQ1H0CCeCD
         +3ksXW5+dF9i8fyeiYGflYcDdcMuDTBC9GVYMCWlHhshznsCMoF7TXVRgE3jf5HEoeUQ
         LLSfN4GPN8dmukn34MiXDS9/c9Nm3kz1LymeJr+O9xYpd6DeeRWxBqDocGRBhOBEaTWw
         csQ3lwmP52t/0hpjYuvB8SOj/4aIjArfulG/FAUD30Un4xsqnM3vYTfLjs6zQ7uwIaVr
         cokA==
X-Gm-Message-State: AOJu0YwYh4WT52RlOzqpJI6jpoaUdkIQWDZtNPsP2sDhLuK9AUrKODyI
	4QXo3to93hk4UTcMXeuvh7idRwo0jiKrHtXAkiS+334SdB2Q052DzL9GbI0HBiXfEQmN8tvKznt
	yEOzuu155c6oJmz5WLs1wzEbJoPB37QPmAfFtgCj4RACaNw5Z2f2MpARpBA==
X-Google-Smtp-Source: AGHT+IFcqJfzj4Hn09q1vXP+A3lR1SF+KT3Twio6XLvYa7j9RFXgg3/Hh4lR+6cO2/p9l6Ld5TCIoUvr1VH1eJByQgMHlPbHPdRn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2501:b0:473:f92b:cdd6 with SMTP id
 v1-20020a056638250100b00473f92bcdd6mr15053jat.4.1708015022212; Thu, 15 Feb
 2024 08:37:02 -0800 (PST)
Date: Thu, 15 Feb 2024 08:37:02 -0800
In-Reply-To: <CZ5SKT22SUPI.1CKVD5QORTT2B@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab8f5f06116e3c5b@google.com>
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (2)
From: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in pvr2_context_set_notify

usb 2-1: USB disconnect, device number 3
pvrusb2: Device being rendered inoperable
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2da/0x330 drivers/media/usb/pvrusb2/pvrusb2-context.c:38
Read of size 4 at addr ffff8881118c18d8 by task kworker/1:3/5383

CPU: 1 PID: 5383 Comm: kworker/1:3 Not tainted 6.8.0-rc3-syzkaller-00049-g88bae831f381-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 pvr2_context_set_notify+0x2da/0x330 drivers/media/usb/pvrusb2/pvrusb2-context.c:38
 pvr2_context_notify drivers/media/usb/pvrusb2/pvrusb2-context.c:98 [inline]
 pvr2_context_disconnect+0x94/0xb0 drivers/media/usb/pvrusb2/pvrusb2-context.c:276
 pvr_disconnect+0x80/0xf0 drivers/media/usb/pvrusb2/pvrusb2-main.c:79
 usb_unbind_interface+0x1e5/0x960 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
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
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5383:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:211
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
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 903:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x105/0x340 mm/slub.c:4409
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:140 [inline]
 pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:162
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff8881118c1800
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff8881118c1800, ffff8881118c1900)

The buggy address belongs to the physical page:
page:ffffea0004463000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1118c0
head:ffffea0004463000 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 725, tgid 725 (kworker/1:2), ts 126894022572, free_ts 126831374891
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
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:211
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x307/0x9c0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
page last free pid 725 tgid 725 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x504/0xae0 mm/page_alloc.c:2346
 free_unref_page+0x33/0x2d0 mm/page_alloc.c:2486
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x20a/0x8c1 kernel/softirq.c:553

Memory state around the buggy address:
 ffff8881118c1780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881118c1800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881118c1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8881118c1900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881118c1980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         88bae831 usb: typec: ucsi: Add qcm6490-pmic-glink as n..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10c5de84180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28a3704ea90ef255
dashboard link: https://syzkaller.appspot.com/bug?extid=ce750e124675d4599449
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1706f648180000


