Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573E7BB800
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjJFMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:42:31 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7EFCA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:42:30 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6c4ecdd6dc9so2456036a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596149; x=1697200949;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+qTE5USwUbIuOQxd4KZ+uRL8qbIQ2IWDKthvgULu9A=;
        b=EkN9brl1vkfoHLLB7vSUzsmMRqr8LoRFvkhIx1dU7IiIEL5WJCWJ6RpGBe7n+SY+bs
         GSNaS5qXUKxoGCj9FeN9yWSS5VYrF1I0FcwfjNG8KiudQXQIoCoNy5vyEfw/iK0Cbhfb
         d5wIskTp49DHstDk6S4MypOBge8ubJDS+JWdauWokYok+2glKTMljDtw9jD/Blztnghm
         /jCcDMnoH0495TGx6EH89dwASJHMQn+RQAkwUm5urIvMbfQMHhQRWZ8zEoeFECtnISCX
         i2OLlu2Aqw2h27rkl6n+Tu+Gb+IOuSpvy/j9NE5VD+M+ZNIUKe9v1GgG4GwvOpfEgzgD
         cKWw==
X-Gm-Message-State: AOJu0Yz0J96HIdxfKcOpOdzCBrxE2CGU99crQr9U0dfRf8vWqMIabcP0
        nyRgMX9zg3mcGVQYoTZx2eYJuQMJZxd3VJmofsCwjc5YNc0v
X-Google-Smtp-Source: AGHT+IHpDH+LJttmChOLL1xS7t5ipaiFYloUyaauwYVUxKilQk1QYP9P/ZyyC78ly8MxJrDBAXRE5abcJRhtgu8mmXpiXW8CzReI
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4dc:b0:6bc:af19:1d22 with SMTP id
 s28-20020a05683004dc00b006bcaf191d22mr2491834otd.7.1696596149631; Fri, 06 Oct
 2023 05:42:29 -0700 (PDT)
Date:   Fri, 06 Oct 2023 05:42:29 -0700
In-Reply-To: <cb6fm6c65rqbk6hzjii5bqanscy7njfu5k7nnpe4doxytshqpf@ulv5noywsnlv>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3836306070b927a@google.com>
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify
From:   syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, pvrusb2@isely.net, ricardo@marliere.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in pvr2_context_set_notify

pvrusb2: Important functionality might not be entirely working.
pvrusb2: Please consider contacting the driver author to help with further stabilization of the driver.
pvrusb2: **********
usb 1-1: USB disconnect, device number 3
pvrusb2: Device being rendered inoperable
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff88812c3e68d8 by task kworker/0:2/699

CPU: 0 PID: 699 Comm: kworker/0:2 Not tainted 6.6.0-rc4-syzkaller-00064-g1053c4a4b8fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
 pvr_disconnect+0x80/0xf0 drivers/media/usb/pvrusb2/pvrusb2-main.c:79
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3813
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1be0/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 699:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:207
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2e62/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 902:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13c/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xff/0x330 mm/slub.c:3822
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
 pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff88812c3e6800
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff88812c3e6800, ffff88812c3e6900)

The buggy address belongs to the physical page:
page:ffffea0004b0f980 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12c3e6
head:ffffea0004b0f980 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 ffffea0004722a80 dead000000000004
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 699, tgid 699 (kworker/0:2), ts 149486728006, free_ts 149464487231
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10e1/0x2fd0 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2297
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x12c/0x310 mm/slub.c:3517
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:207
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x460/0xa20 mm/page_alloc.c:2312
 free_unref_page+0x33/0x2c0 mm/page_alloc.c:2405
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x4a/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x190/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x241/0x580 security/tomoyo/file.c:723
 security_file_ioctl+0x72/0xb0 security/security.c:2647
 __do_sys_ioctl fs/ioctl.c:865 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0xbb/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88812c3e6780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88812c3e6800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88812c3e6880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88812c3e6900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88812c3e6980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         1053c4a4 Revert "usb: gadget: uvc: stop pump thread on..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1472423a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5e01246f94ceed9
dashboard link: https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
