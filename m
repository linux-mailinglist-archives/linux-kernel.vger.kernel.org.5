Return-Path: <linux-kernel+bounces-46225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC166843C77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15C8296492
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9E69D16;
	Wed, 31 Jan 2024 10:22:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D169D0B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696561; cv=none; b=D7Zj8MvsaRlaYF259J0afWKgdMhic4rfqWndiXtIKh77O8IbpFtdVqNGQ04WRSa7KfJ4ogIng+y+D4OVgiQ1urqQFmYPT9Xz/Oi0+taLb5OwtzWXIP/VbY71NztqyYA5V12Gs1as52SF+pGX49lUjBHVflH8ziur6YLBTiDKOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696561; c=relaxed/simple;
	bh=STJ+RItGOkSEEg0GUrI9fiiQBxRmzMTlARJy2C8F5gQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y9DgHk0YYy9Cm25sbXImhguVKvFEnrxAH1HJp565LJu4x/vEUl8M8s+pAo610CsMUD1IJNsWFuv24FfCcWrvSmWSfTxUe5f3Cvj7WnbDjRIRousDM9iGoW9OsTMVbLAhG/vKIqwSmrbdPlGt7PWXPvV6s+8Wjd7mDN+aNHw54jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3638e475deaso10661775ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696559; x=1707301359;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Khdd7I6fdVlhvPhocwYCvULRzqoVieX6zZAUNRny58=;
        b=fP/tWDRNN+WG+yuc0Gc778KRlIPvc9ZKbp8hDrrhSLu7aSZwT14PJSrG1QC4f50RDF
         TcTKBAgnFjs6goVSvTdB7dAweQYAybCkC722C+0ZhmTlIPc3LRXIrGiCBQ1+E1OASGxW
         61bzGLoh1nHzlP9aq8Sm9PbvkQTpxMRNFg1Ewo4uu3bN0UcZSqop6WoM1QZeBy4pKO+Q
         FKtygLE0JTMzGvCAuLltR+Qq7fAYO1jB4rngMF22lXEU+vVXaiNGtcrtWnRcJkrNRknx
         oPGpl4oyN2T+U1Z27dS3orGYZ16YvI2F/1UETC/0/T/H+wGsSmCm5Ma1GWsva3yw8m8K
         ruXQ==
X-Gm-Message-State: AOJu0YyUq/uofSpiLNRr9IjAGDNMyZxXkAkOhrGyqsvnFAF5IZdxOymQ
	U4yHF9F5/rpjcddYiZY6xMiLp+uFsff04YhQjuZWfAVYyHCYE10vMdqLAKpDBWbN9aflPTsrl+a
	giqJ26wokZi0w5o9Ze6bLaLg2ORi4sDm8nJNisP2ozcVcRGnDdmJ29D0=
X-Google-Smtp-Source: AGHT+IFlNOmhN/+hWbCyAU5hIbOCv0Mu5ysQi4v3Y33P7/8609xx69WjqA5HLmKzirf1hgxKLR5qGtbA3hHIZAGjTm5PKIO3Np1n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:363:91a3:4b60 with SMTP id
 g11-20020a92cdab000000b0036391a34b60mr110019ild.4.1706696559340; Wed, 31 Jan
 2024 02:22:39 -0800 (PST)
Date: Wed, 31 Jan 2024 02:22:39 -0800
In-Reply-To: <mailman.217.1706634262.2961.pvrusb2@isely.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028b68806103b4266@google.com>
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (2)
From: syzbot <syzbot+ce750e124675d4599449@syzkaller.appspotmail.com>
To: isely@pobox.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, pvrusb2-owner@isely.net, 
	pvrusb2@isely.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f1a27f081c1f usb: typec: qcom-pmic-typec: allow different ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14800bdfe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=986ce9258c6856ff
dashboard link: https://syzkaller.appspot.com/bug?extid=ce750e124675d4599449
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c7cad3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429ed40180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77efcf770e8/disk-f1a27f08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a827d6ba40bf/vmlinux-f1a27f08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d21d228bf73/bzImage-f1a27f08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com

pvrusb2: Device being rendered inoperable
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff888112202ad8 by task kworker/0:1/9

CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-rc1-syzkaller-00046-gf1a27f081c1f #0
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
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 9:
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
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 901:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
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
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888112202a00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff888112202a00, ffff888112202b00)

The buggy address belongs to the physical page:
page:ffffea0004488080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x112202
head:ffffea0004488080 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 ffffea0004498080 0000000000000005
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 7680321640, free_ts 0
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
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888112202980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888112202a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888112202a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888112202b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888112202b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

