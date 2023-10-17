Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61827CC74C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjJQPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbjJQPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:20:59 -0400
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702649F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:20:57 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-581ed663023so130837eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556057; x=1698160857;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLyjbBHzm8zSDA2CdkSkN7NZXD6muo+11DDcGDVcfos=;
        b=rXiLkjrrfo7Mpw8B8PTq/7e4aIoebB6pNa9vEQKfxs2r53SgpxUZ3JvUVY2Qk8k1YZ
         HN2VrKQ/Xwv0lou3ln+mproVaehrzMLAG3Xg9ySSFGdwaVYQDmxWq9oOZEf1nj2dKg9e
         mMf8xld6lmXNJuytISqNo3aXwfVhjXnl8MK5UyUuhqF2CK3oG3pUV6oAZLg/HsQ/fhRs
         ZxHeOmykUgq3ogt+3WvHA5uDJF2E2/kobXP/8k+68yOrLHnLYKLV8+GJ0vP1NDXJ/scF
         nrhTnaKeoBPV9A3cN0dWENY5ijwliU+eiM4FiNcjsVF5wEOOk/ckwttvFNayWNTpL4G8
         PaCA==
X-Gm-Message-State: AOJu0YwtNVGFZnGyc6umr3KWLmpg98YAed98CnxpIwy7MvTrmhdLWbnR
        60TpQd0TrTsTmbbAuxoT5r8gaJCIW1g2xKdFAsNHSZAs12Gz0XggmQ==
X-Google-Smtp-Source: AGHT+IGe2AxnfMvZbQGfEKwdZq/NCV2ZV2qI6BiQNC8dblrJT3MxdJnc3QMoluFXbwcP+f++6UyDQs2w/dcSTrQRFnX4rivjoAL1
MIME-Version: 1.0
X-Received: by 2002:a4a:b406:0:b0:581:e323:1b05 with SMTP id
 y6-20020a4ab406000000b00581e3231b05mr398426oon.0.1697556056828; Tue, 17 Oct
 2023 08:20:56 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:20:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0f3970607eb11a0@google.com>
Subject: [syzbot] [kernel?] usb-testing boot error: KASAN: slab-out-of-bounds
 Write in vhci_start
From:   syzbot <syzbot+2c502e3d1f388a6ea2fd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1034cc423f1b gpio: update Intel LJCA USB GPIO driver
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1346549d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2978ac6b274c8961
dashboard link: https://syzkaller.appspot.com/bug?extid=2c502e3d1f388a6ea2fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2d563dc9f85/disk-1034cc42.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad2ee75b14c0/vmlinux-1034cc42.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e21b4099d7d/bzImage-1034cc42.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c502e3d1f388a6ea2fd@syzkaller.appspotmail.com

usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Dummy host controller
usb usb4: Manufacturer: Linux 6.6.0-rc4-syzkaller-00083-g1034cc423f1b dummy_hcd
usb usb4: SerialNumber: dummy_hcd.3
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
dummy_hcd dummy_hcd.4: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.4: Dummy host controller
dummy_hcd dummy_hcd.4: new USB bus registered, assigned bus number 5
usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: Dummy host controller
usb usb5: Manufacturer: Linux 6.6.0-rc4-syzkaller-00083-g1034cc423f1b dummy_hcd
usb usb5: SerialNumber: dummy_hcd.4
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
dummy_hcd dummy_hcd.5: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.5: Dummy host controller
dummy_hcd dummy_hcd.5: new USB bus registered, assigned bus number 6
usb usb6: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: Dummy host controller
usb usb6: Manufacturer: Linux 6.6.0-rc4-syzkaller-00083-g1034cc423f1b dummy_hcd
usb usb6: SerialNumber: dummy_hcd.5
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 1 port detected
dummy_hcd dummy_hcd.6: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.6: Dummy host controller
dummy_hcd dummy_hcd.6: new USB bus registered, assigned bus number 7
usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: Dummy host controller
usb usb7: Manufacturer: Linux 6.6.0-rc4-syzkaller-00083-g1034cc423f1b dummy_hcd
usb usb7: SerialNumber: dummy_hcd.6
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 1 port detected
dummy_hcd dummy_hcd.7: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.7: Dummy host controller
dummy_hcd dummy_hcd.7: new USB bus registered, assigned bus number 8
usb usb8: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb8: Product: Dummy host controller
usb usb8: Manufacturer: Linux 6.6.0-rc4-syzkaller-00083-g1034cc423f1b dummy_hcd
usb usb8: SerialNumber: dummy_hcd.7
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 1 port detected
vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 9
==================================================================
BUG: KASAN: slab-out-of-bounds in lockdep_init_map_type+0x6ff/0x7c0 kernel/locking/lockdep.c:4862
Write of size 8 at addr ffff888106392fe8 by task swapper/0/1

CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4-syzkaller-00083-g1034cc423f1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 lockdep_init_map_type+0x6ff/0x7c0 kernel/locking/lockdep.c:4862
 lockdep_init_map_waits include/linux/lockdep.h:192 [inline]
 lockdep_init_map_wait include/linux/lockdep.h:199 [inline]
 __raw_spin_lock_init+0x3a/0x110 kernel/locking/spinlock_debug.c:24
 vhci_start+0x63d/0x880 drivers/usb/usbip/vhci_hcd.c:1181
 usb_add_hcd+0x958/0x1770 drivers/usb/core/hcd.c:2944
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
 kmemdup+0x29/0x60 mm/util.c:131
 kmemdup include/linux/fortify-string.h:765 [inline]
 platform_device_add_data+0x30/0xc0 drivers/base/platform.c:638
 platform_device_register_full+0x376/0x550 drivers/base/platform.c:832
 vhci_hcd_init+0x1ad/0x360 drivers/usb/usbip/vhci_hcd.c:1532
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5bd/0x8f0 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888106392fc8
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 24 bytes to the right of
 allocated 8-byte region [ffff888106392fc8, ffff888106392fd0)

The buggy address belongs to the physical page:
page:ffffea000418e480 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106392
flags: 0x200000000000800(slab|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000800 ffff888100041280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 6905814461, free_ts 0
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
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1043
 kvasprintf+0xbd/0x150 lib/kasprintf.c:25
 kvasprintf_const+0x66/0x190 lib/kasprintf.c:49
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 dev_set_name+0xc8/0x100 drivers/base/core.c:3427
 usb_create_ep_devs+0x158/0x2a0 drivers/usb/core/endpoint.c:167
 usb_new_device+0xfd8/0x1960 drivers/usb/core/hub.c:2617
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888106392e80: fc fa fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc
 ffff888106392f00: 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc fa
>ffff888106392f80: fc fc fc fc 07 fc fc fc fc 00 fc fc fc fc fc fc
                                                          ^
 ffff888106393000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888106393080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
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
