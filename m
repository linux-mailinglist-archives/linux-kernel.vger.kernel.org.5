Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3119B7C65B8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjJLGiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJLGit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:38:49 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A29A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:38:47 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6c4717c4745so887592a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092727; x=1697697527;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kugT5vVre2uGxeihnO0uYR0kEGBEhnTzCr35jh6H+EY=;
        b=vjHf52+knGvtbuXGSIyeJ3vtxk3H8eGsVGfoOjtIu37lWmGFVcK7bukafqCf/9doXE
         5xiBFpTLUSRdZ5K1Xi+ATKymlL0nX1xQiYjrayG03QswnnSn8X2qfFTmo/ebl0Ep4ywx
         i6ZwrhmzC+Kt4Cl6BmChKrPDzGlprZWC9GyPyCr2WpXaluS6lfdRdA/X7UTsXLgFeQ6t
         zm57UvDiKqtEgBpyNwGyiDqvTdl9MxCP1zApLp17MQFsQMqlYOP5GMgVPs1c5y4qu6/N
         pzZQmTPhNYeM2j0RbsmxkeSrDhBqy/t4MfSAqLz7ix20qqkXFFRE8gNX8PovpM1DmaCM
         z3cg==
X-Gm-Message-State: AOJu0Yzr+ubN1kB1hRslziEE3zPtRrEbZcxXqHjpSaQKVl2ex4p5sES+
        2wivROvzljBp+AUAUciVD/jqyEWlHYZY3KVf3bFOKrB6tAlx
X-Google-Smtp-Source: AGHT+IETAGaAx/ytVoOkQqmOK2k+tRbbFJYA2kIJ1qQ+ExAhGYZkb+i28SBG2czr2IamMBXIQRQnzOJJ0GWTc7KmuKiCsdHxxu0I
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1699:b0:1e9:b451:bae6 with SMTP id
 j25-20020a056870169900b001e9b451bae6mr375604oae.1.1697092727282; Wed, 11 Oct
 2023 23:38:47 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:38:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029242706077f3145@google.com>
Subject: [syzbot] [usb?] usb-testing boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
From:   syzbot <syzbot+e0dbc33630a092ccf033@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, i@zenithal.me,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        shuah@kernel.org, syzkaller-bugs@googlegroups.com,
        valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    efa33cd89c8a USB: typec: tps6598x: Add status trace for tp..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=162614de680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5e01246f94ceed9
dashboard link: https://syzkaller.appspot.com/bug?extid=e0dbc33630a092ccf033
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d5a3eaf3019b/disk-efa33cd8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32ddfa7a7357/vmlinux-efa33cd8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9525e3de36f/bzImage-efa33cd8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0dbc33630a092ccf033@syzkaller.appspotmail.com

usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Dummy host controller
usb usb4: Manufacturer: Linux 6.6.0-rc4-syzkaller-00079-gefa33cd89c8a dummy_hcd
usb usb4: SerialNumber: dummy_hcd.3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
dummy_hcd dummy_hcd.4: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.4: Dummy host controller
dummy_hcd dummy_hcd.4: new USB bus registered, assigned bus number 5
usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: Dummy host controller
usb usb5: Manufacturer: Linux 6.6.0-rc4-syzkaller-00079-gefa33cd89c8a dummy_hcd
usb usb5: SerialNumber: dummy_hcd.4
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
dummy_hcd dummy_hcd.5: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.5: Dummy host controller
dummy_hcd dummy_hcd.5: new USB bus registered, assigned bus number 6
usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: Dummy host controller
usb usb6: Manufacturer: Linux 6.6.0-rc4-syzkaller-00079-gefa33cd89c8a dummy_hcd
usb usb6: SerialNumber: dummy_hcd.5
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 1 port detected
dummy_hcd dummy_hcd.6: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.6: Dummy host controller
dummy_hcd dummy_hcd.6: new USB bus registered, assigned bus number 7
usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: Dummy host controller
usb usb7: Manufacturer: Linux 6.6.0-rc4-syzkaller-00079-gefa33cd89c8a dummy_hcd
usb usb7: SerialNumber: dummy_hcd.6
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 1 port detected
dummy_hcd dummy_hcd.7: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.7: Dummy host controller
dummy_hcd dummy_hcd.7: new USB bus registered, assigned bus number 8
usb usb8: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb8: Product: Dummy host controller
usb usb8: Manufacturer: Linux 6.6.0-rc4-syzkaller-00079-gefa33cd89c8a dummy_hcd
usb usb8: SerialNumber: dummy_hcd.7
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 1 port detected
vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 9
==================================================================
BUG: KASAN: slab-out-of-bounds in vhci_setup+0x2d3/0x340 drivers/usb/usbip/vhci_hcd.c:1145
Write of size 8 at addr ffff888105f04d18 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4-syzkaller-00079-gefa33cd89c8a #0
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
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 platform_device_add+0x36d/0x840 drivers/base/platform.c:717
 platform_device_register_full+0x3ec/0x550 drivers/base/platform.c:844
 vhci_hcd_init+0x1ad/0x360 drivers/usb/usbip/vhci_hcd.c:1532
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5bd/0x8f0 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x87/0x90 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc_node_track_caller+0x61/0x100 mm/slab_common.c:1043
 kvasprintf+0xbd/0x150 lib/kasprintf.c:25
 kvasprintf_const+0x66/0x190 lib/kasprintf.c:49
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 device_create_groups_vargs+0x1b1/0x270 drivers/base/core.c:4307
 device_create+0xe9/0x120 drivers/base/core.c:4350
 mon_bin_add+0xba/0x160 drivers/usb/mon/mon_bin.c:1366
 mon_bus_init+0x18e/0x320 drivers/usb/mon/mon_main.c:291
 mon_bus_add drivers/usb/mon/mon_main.c:188 [inline]
 mon_notify+0x32e/0x490 drivers/usb/mon/mon_main.c:219
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 blocking_notifier_call_chain kernel/notifier.c:388 [inline]
 blocking_notifier_call_chain+0x69/0x90 kernel/notifier.c:376
 usb_register_bus drivers/usb/core/hcd.c:910 [inline]
 usb_add_hcd+0x34d/0x1770 drivers/usb/core/hcd.c:2852
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
 device_add+0x117e/0x1aa0 drivers/base/core.c:3624
 platform_device_add+0x36d/0x840 drivers/base/platform.c:717
 platform_device_register_full+0x3ec/0x550 drivers/base/platform.c:844
 vhci_hcd_init+0x1ad/0x360 drivers/usb/usbip/vhci_hcd.c:1532
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5bd/0x8f0 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888105f04cf8
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 24 bytes to the right of
 allocated 8-byte region [ffff888105f04cf8, ffff888105f04d00)

The buggy address belongs to the physical page:
page:ffffea000417c100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105f04
flags: 0x200000000000800(slab|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000800 ffff888100041280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 9597611518, free_ts 9330208953
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10e1/0x2fd0 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_page_interleave+0x1e/0x230 mm/mempolicy.c:2130
 alloc_pages+0x22a/0x270 mm/mempolicy.c:2292
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x12c/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 usb_get_status+0x7a/0x270 drivers/usb/core/message.c:1145
 usb_get_std_status include/linux/usb.h:1856 [inline]
 hub_configure drivers/usb/core/hub.c:1602 [inline]
 hub_probe+0x178e/0x3070 drivers/usb/core/hub.c:1922
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x460/0xa20 mm/page_alloc.c:2312
 free_unref_page+0x33/0x2c0 mm/page_alloc.c:2405
 mm_free_pgd kernel/fork.c:803 [inline]
 __mmdrop+0xd7/0x470 kernel/fork.c:919
 mmdrop include/linux/sched/mm.h:54 [inline]
 __mmput kernel/fork.c:1360 [inline]
 mmput+0x376/0x420 kernel/fork.c:1371
 free_bprm+0x144/0x3f0 fs/exec.c:1492
 kernel_execve+0x3e7/0x4e0 fs/exec.c:2026
 call_usermodehelper_exec_async+0x256/0x4c0 kernel/umh.c:110
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888105f04c00: fc 06 fc fc fc fc fa fc fc fc fc 06 fc fc fc fc
 ffff888105f04c80: 06 fc fc fc fc 07 fc fc fc fc 00 fc fc fc fc 00
>ffff888105f04d00: fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc 06 fc
                            ^
 ffff888105f04d80: fc fc fc 05 fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888105f04e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
