Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5757893E9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjHZFJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 01:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHZFIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 01:08:49 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005E2685
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 22:08:46 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1c0888c175fso15373545ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 22:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693026525; x=1693631325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFS8hm8LjjBHweqoBE1nJ1SrxNNm5BjNxKLsW9d8J1g=;
        b=cAzp/H6vjxXngE8rI0CJaJZuwwD3zFz5ClQdZaoo7PrNEzooVqDXOLDFHehPt1UyyC
         9/pqOY7IUN2gMoAbpXWzJRjel7n2I+dsHCRdeuVY6aOq2Sg0YqFS3n/CeGJ4yG+xPYqv
         JNYhPiA1F2r0YKJwuRi36NC0srahcseSYZq4XV98moa7aOpFOhtyP0NIcfItxE70VNiD
         ByIVN+w2OVpowvPoQPzAWZP0yG9m08p1musXMin0AEEakztEH/tBaKWi2R2zhXcnMxLu
         +KDUpjeaCzD+oIonyvfZbeX7ALqQSKaQwQ7veRwLVhdrbXmFSdAgfgdvlbrrL0AGu7iU
         LlZA==
X-Gm-Message-State: AOJu0YyB6gNubULN8qI5t80ws9ElIK7fMNQDc0irjPYvgI2FQPmgh8R9
        rHmq3nK6o2SWI1+qNImvShxmvyxeGIXEiJVfkIDrK8I225FJ6gdF2Q==
X-Google-Smtp-Source: AGHT+IGKR5/4TCkmzoTlf5ed7EE6+ocwY0jjHkBU90nHsJK50Kw6dUU1dpIwnRM+jsYm5ULojM0ekNuvbT6X/SJYLrt6M4Fj3MDA
MIME-Version: 1.0
X-Received: by 2002:a17:902:dace:b0:1b5:bd8:5aaa with SMTP id
 q14-20020a170902dace00b001b50bd85aaamr7088565plx.1.1693026525655; Fri, 25 Aug
 2023 22:08:45 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:08:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a838aa0603cc74d6@google.com>
Subject: [syzbot] [media?] [usb?] KASAN: slab-out-of-bounds Read in imon_probe
From:   syzbot <syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    47d9bb711707 Add linux-next specific files for 20230821
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123e50b7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=59875ffef5cb9c9b29e9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b08160680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ffbe03c733b7/disk-47d9bb71.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a61a31d6caf9/vmlinux-47d9bb71.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37e6f882b2d9/bzImage-47d9bb71.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com

usb 1-1: 2:1 : UAC_AS_GENERAL descriptor not found
==================================================================
BUG: KASAN: slab-out-of-bounds in imon_init_intf1 drivers/media/rc/imon.c:2323 [inline]
BUG: KASAN: slab-out-of-bounds in imon_probe+0x298f/0x38f0 drivers/media/rc/imon.c:2449
Read of size 1 at addr ffff888069cbac71 by task kworker/1:3/5066

CPU: 1 PID: 5066 Comm: kworker/1:3 Not tainted 6.5.0-rc7-next-20230821-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 imon_init_intf1 drivers/media/rc/imon.c:2323 [inline]
 imon_probe+0x298f/0x38f0 drivers/media/rc/imon.c:2449
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
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
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2daf/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5066:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1004 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1017
 kmalloc include/linux/slab.h:604 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 snd_card_new+0x74/0x110 sound/core/init.c:184
 snd_usb_audio_create sound/usb/card.c:621 [inline]
 usb_audio_probe+0x1905/0x3c60 sound/usb/card.c:827
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
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
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2daf/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888069cba000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1 bytes to the right of
 allocated 3184-byte region [ffff888069cba000, ffff888069cbac70)

The buggy address belongs to the physical page:
page:ffffea0001a72e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x69cb8
head:ffffea0001a72e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 27, tgid 27 (kworker/1:1), ts 97911259229, free_ts 34249861969
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
 prep_new_page mm/page_alloc.c:1537 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3213
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4469
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1003 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1024
 kmalloc_reserve+0xef/0x270 net/core/skbuff.c:575
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x29e/0xc70 drivers/net/netdevsim/dev.c:850
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1130 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2435
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6385
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d7e/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888069cbab00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888069cbab80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888069cbac00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                                                             ^
 ffff888069cbac80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888069cbad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
