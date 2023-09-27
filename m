Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49F17B0769
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjI0Oza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjI0Oz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:55:28 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16BF9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:55:26 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1dd51b98342so12253956fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826525; x=1696431325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBWVgveX+Gy18voOjfm0pQ+cpi+lx5U5ZfTJiFJTenI=;
        b=sG+1Gb2VzLIX8GwPV8U5S5+eFnRixyfco5WQQMtZZgURNRVAxJXdw3ZL/soH+MWsNa
         Dt/qM2pChU5nN00MRNMknxSgFkP3kuTlnbpI+eVZBpSrB9zEyeiZYC8RMCC1lSDCW7+0
         n3X/jRQ7qAd+9ptgIrEuFtkq1LbK1ok44Jq0/rOWTT/YEEYGHUrvaGfJN/0iv3U2i1nV
         eysCJ15E1t2RJz/RZupMDX9RHuJ6BzIxCOMtkRG3mb5c91aOaZgiGtms+dRFe5DWj+P1
         vQiWjYLjJdM3s7ab6AqiKtQAPA3xbXTyQbmNktRqJzY1X3Dt4/Td4CortyFiPl9EsX/6
         4Q0A==
X-Gm-Message-State: AOJu0Yw4y7bOrdduNRC+UWNFFlIesoUqCC1LM4cXRDZdo7cddra4UIWg
        J2g+47ASjiIFl4ENW/9sNPksnk2e3Zfk0yYChwqTVaSVOWqk
X-Google-Smtp-Source: AGHT+IFu+UhBkt/FQcj8P5/rQdxSln4WN9Ws82IxG014NHtA0BQTNz7umpFu7HPlIFEY687z1hb4nsZODK+6rTOnGPtkGasNMu4b
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a99:b0:1d6:8292:b0f9 with SMTP id
 dt25-20020a0568705a9900b001d68292b0f9mr783361oab.7.1695826525491; Wed, 27 Sep
 2023 07:55:25 -0700 (PDT)
Date:   Wed, 27 Sep 2023 07:55:25 -0700
In-Reply-To: <gugiuvjgpoogf3k5cm4px4jwevg5torsu3d7afbbhvnrxho4zu@wkcxeb5sr5ez>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a71ad80606586122@google.com>
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
usb 1-1: USB disconnect, device number 102
pvrusb2: Device being rendered inoperable
==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2fa/0x350 drivers/media/usb/pvrusb2/pvrusb2-context.c:42
Read of size 4 at addr ffff8881093becd8 by task kworker/0:0/8

CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.0-rc2-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 pvr2_context_set_notify+0x2fa/0x350 drivers/media/usb/pvrusb2/pvrusb2-context.c:42
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

Allocated by task 8:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:208
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

Freed by task 901:
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
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:144 [inline]
 pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:159
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff8881093bec00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff8881093bec00, ffff8881093bed00)

The buggy address belongs to the physical page:
page:ffffea000424ef80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1093be
head:ffffea000424ef80 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000840(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000840 ffff888100041b40 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 8817323426, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10e1/0x2fd0 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_page_interleave+0x1e/0x230 mm/mempolicy.c:2131
 alloc_pages+0x22a/0x270 mm/mempolicy.c:2293
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
 bus_add_driver+0x92/0x630 drivers/base/bus.c:657
 driver_register+0x15c/0x4a0 drivers/base/driver.c:246
 usb_register_driver+0x24f/0x500 drivers/usb/core/driver.c:1062
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5bd/0x8f0 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881093beb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881093bec00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881093bec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8881093bed00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881093bed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         ce9ecca0 Linux 6.6-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13f01d0a680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59eae8406319284a
dashboard link: https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ca2656680000

