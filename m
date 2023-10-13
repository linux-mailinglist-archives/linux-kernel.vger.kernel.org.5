Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2017C7DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJMGX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJMGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:23:57 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA1ABD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:23:49 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3ae214a02a6so2895643b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178229; x=1697783029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehp3s3wmDK8jWuZJe23c3aGn8VEvCoZ9nLJEqHmk/rs=;
        b=SL+Lmqan5rlzZa+ETQvjN3FUoJMS5kXCIuGfrv2Yn38HcxfSW3nbCaIp1kTtkOJEO4
         K23G+zrzv/a7CLsMtelu2WVC4nQ2Fw7IdIHQcTLP86HD6pz7Hi5zVNM9xa4rKDu3Qo6Y
         Ap6w9OWuAH2lr+nXaR0wUB/B8xDXhtJD9CwZWMcqg+Fy3YnwIL2gB6cP3PQ1+DKYgA5z
         MzJpzu/hhq7uX1wWSaa62z362JuYH5fvlUU6smCRtZ9fvMLQL6WQvjGOeCawIVYjgmnQ
         ZFU3ZIvH50DAtaAwjgDiDA9VOFNz7qzNvtjybXdrC6/JoUTiWDlns3FqKSw/R4Yko4Yo
         dMIQ==
X-Gm-Message-State: AOJu0Yx+02WK5bygulZWpunWk0a39nCI7duGBwlpaSxEGfnH5rapBHMJ
        DbUsOqCw6xl6ej+CiQ/wSrNg36ktjg88m9ghqdAa9/J5VQyd
X-Google-Smtp-Source: AGHT+IHg2nZgrO+niXj572zpjY4FsLb35hqbQeEWxyv1D+nHtPrnDMpcmyFEQtM51ivs/JlvEtZqxFXj2aZ4UCKFt26l9WwUTfl2
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1916:b0:3ae:2024:837d with SMTP id
 bf22-20020a056808191600b003ae2024837dmr13896975oib.8.1697178229025; Thu, 12
 Oct 2023 23:23:49 -0700 (PDT)
Date:   Thu, 12 Oct 2023 23:23:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007634c1060793197c@google.com>
Subject: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
From:   syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, i@zenithal.me,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-usb@vger.kernel.org, sfr@canb.auug.org.au, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f9a6bea13184 Add linux-next specific files for 20231012
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1534d829680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e549f76cbaa1b13
dashboard link: https://syzkaller.appspot.com/bug?extid=6867a9777f4b8dc4e256
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db1637d9c577/disk-f9a6bea1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16c1010b94c4/vmlinux-f9a6bea1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f804f5e468c9/bzImage-f9a6bea1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com

usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Dummy host controller
usb usb4: Manufacturer: Linux 6.6.0-rc5-next-20231012-syzkaller dummy_hcd
usb usb4: SerialNumber: dummy_hcd.3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
dummy_hcd dummy_hcd.4: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.4: Dummy host controller
dummy_hcd dummy_hcd.4: new USB bus registered, assigned bus number 5
usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: Dummy host controller
usb usb5: Manufacturer: Linux 6.6.0-rc5-next-20231012-syzkaller dummy_hcd
usb usb5: SerialNumber: dummy_hcd.4
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
dummy_hcd dummy_hcd.5: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.5: Dummy host controller
dummy_hcd dummy_hcd.5: new USB bus registered, assigned bus number 6
usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: Dummy host controller
usb usb6: Manufacturer: Linux 6.6.0-rc5-next-20231012-syzkaller dummy_hcd
usb usb6: SerialNumber: dummy_hcd.5
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 1 port detected
dummy_hcd dummy_hcd.6: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.6: Dummy host controller
dummy_hcd dummy_hcd.6: new USB bus registered, assigned bus number 7
usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: Dummy host controller
usb usb7: Manufacturer: Linux 6.6.0-rc5-next-20231012-syzkaller dummy_hcd
usb usb7: SerialNumber: dummy_hcd.6
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 1 port detected
dummy_hcd dummy_hcd.7: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.7: Dummy host controller
dummy_hcd dummy_hcd.7: new USB bus registered, assigned bus number 8
usb usb8: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb8: Product: Dummy host controller
usb usb8: Manufacturer: Linux 6.6.0-rc5-next-20231012-syzkaller dummy_hcd
usb usb8: SerialNumber: dummy_hcd.7
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 1 port detected
gadgetfs: USB Gadget filesystem, version 24 Aug 2004
vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 9
==================================================================
BUG: KASAN: slab-out-of-bounds in vhci_setup+0x2d3/0x340 drivers/usb/usbip/vhci_hcd.c:1145
Write of size 8 at addr ffff8881417e15c0 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc5-next-20231012-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 vhci_setup+0x2d3/0x340 drivers/usb/usbip/vhci_hcd.c:1145
 usb_add_hcd+0x5bc/0x1770 drivers/usb/core/hcd.c:2911
 vhci_hcd_probe+0x12c/0x460 drivers/usb/usbip/vhci_hcd.c:1363
 platform_probe+0xff/0x1e0 drivers/base/platform.c:1404
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 platform_device_add+0x316/0x810 drivers/base/platform.c:716
 platform_device_register_full+0x3ec/0x550 drivers/base/platform.c:844
 vhci_hcd_init+0x1ad/0x360 drivers/usb/usbip/vhci_hcd.c:1532
 do_one_initcall+0x128/0x670 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:291
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node_track_caller+0x65/0x130 mm/slab_common.c:1027
 kvasprintf+0xbd/0x150 lib/kasprintf.c:25
 kvasprintf_const+0x66/0x190 lib/kasprintf.c:49
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 dev_set_name+0xc8/0x100 drivers/base/core.c:3428
 usb_alloc_dev+0xb45/0xdb0 drivers/usb/core/usb.c:696
 usb_add_hcd+0x3a9/0x1770 drivers/usb/core/hcd.c:2856
 vhci_hcd_probe+0x12c/0x460 drivers/usb/usbip/vhci_hcd.c:1363
 platform_probe+0xff/0x1e0 drivers/base/platform.c:1404
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 platform_device_add+0x316/0x810 drivers/base/platform.c:716
 platform_device_register_full+0x3ec/0x550 drivers/base/platform.c:844
 vhci_hcd_init+0x1ad/0x360 drivers/usb/usbip/vhci_hcd.c:1532
 do_one_initcall+0x128/0x670 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:291

The buggy address belongs to the object at ffff8881417e15a0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 27 bytes to the right of
 allocated 5-byte region [ffff8881417e15a0, ffff8881417e15a5)

The buggy address belongs to the physical page:
page:ffffea000505f840 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1417e1
flags: 0x57ff00000000800(slab|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000800 ffff888012c41280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 10541560946, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1540
 prep_new_page mm/page_alloc.c:1547 [inline]
 get_page_from_freelist+0x98f/0x32a0 mm/page_alloc.c:3339
 __alloc_pages+0x1d0/0x4c0 mm/page_alloc.c:4595
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0x54/0x130 mm/slab_common.c:1027
 kstrdup+0x3c/0x70 mm/util.c:62
 kstrdup_const+0x5f/0x70 mm/util.c:85
 kvasprintf_const+0x10b/0x190 lib/kasprintf.c:48
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 dev_set_name+0xc8/0x100 drivers/base/core.c:3428
 netdev_register_kobject+0xc1/0x3f0 net/core/net-sysfs.c:2031
 register_netdevice+0xbcb/0x1490 net/core/dev.c:10162
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881417e1480: fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc
 ffff8881417e1500: 06 fc fc fc fc 05 fc fc fc fc 05 fc fc fc fc 00
>ffff8881417e1580: fc fc fc fc 05 fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff8881417e1600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881417e1680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
