Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB6782EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbjHUQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjHUQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:48:04 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409DEC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:48:02 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-56c2d67da6aso1185715a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636482; x=1693241282;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQTTJ8fXjIB81GOy5ni1MUXSobm5nylA0yZFhXsnUWw=;
        b=EA//l7vP20YsI2xH9Sn9z/e+SXJ6SnFzFBpfS8nU/9QZUH1c9eeGH4CSQYmYXGw0QF
         HIJgPBAU5Sr61KeKxRYFCnOLvxUSouGRmagvngdynqi0rOD/9yc4uSzvAH8JMg2FV3UI
         BEotjtk6w2C0QChwFrk0dioWchAH3GEfO9pbDbIklDRADKMuj97rcHSq5Xeo55V8cezZ
         8GfJsolkOinAXHYS3R2OC47aIu2Vh/OKysvOXLyrAa7ucx9vd/9/s3iwyr/498jP43Vc
         Q4uZlMcesB2XdeS8yM8LwWH9m/TAEMRzWuRC19+XJVhpbGsle4qtcSI09SBIpLWErNtC
         wonQ==
X-Gm-Message-State: AOJu0Yz7hhaX9f/DJGgSIizyPKczZ0hoXtSvgNNnf1XboGrmxe8DGhlQ
        B5n4Rt7cwUASOBnNwtZcnjAKQ7GKUgO7nDfL+J/rX2QKX5ZA
X-Google-Smtp-Source: AGHT+IGuNxVRuaq+belOvOMacb7r6weHQ2XTP98+kC65hCyBehfm0ikwbP9p/q9XwVUkSpf7m6R+rmsSwidCfxFEirOLj0YRZKqi
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:986:b0:688:7ce7:f29c with SMTP id
 u6-20020a056a00098600b006887ce7f29cmr4448979pfg.3.1692636481434; Mon, 21 Aug
 2023 09:48:01 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:48:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035beba060371a468@google.com>
Subject: [syzbot] [input?] KASAN: slab-use-after-free Read in input_dev_uevent
From:   syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>
To:     davidgow@google.com, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mripard@kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11edc0d3a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=3a0ebe8a52b89c63739d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17998f03a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b81223a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/disk-7271b2a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinux-7271b2a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/bzImage-7271b2a5.xz

The issue was bisected to:

commit 699fb50d99039a50e7494de644f96c889279aca3
Author: David Gow <davidgow@google.com>
Date:   Thu Jul 20 12:45:09 2023 +0000

    drivers: base: Free devm resources when unregistering a device

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13140083a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10940083a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17140083a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com
Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")

usb 1-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:645 [inline]
BUG: KASAN: slab-use-after-free in string+0x394/0x3d0 lib/vsprintf.c:727
Read of size 1 at addr ffff88801c8c6ca8 by task kworker/1:3/4508

CPU: 1 PID: 4508 Comm: kworker/1:3 Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 string_nocheck lib/vsprintf.c:645 [inline]
 string+0x394/0x3d0 lib/vsprintf.c:727
 vsnprintf+0xc5f/0x1870 lib/vsprintf.c:2818
 add_uevent_var+0x17c/0x390 lib/kobject_uevent.c:665
 input_dev_uevent+0x162/0x8f0 drivers/input/input.c:1691
 dev_uevent+0x305/0x760 drivers/base/core.c:2599
 kobject_uevent_env+0x623/0x1800 lib/kobject_uevent.c:557
 device_del+0x642/0xa50 drivers/base/core.c:3830
 input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
 hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2386
 hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2273
 hid_hw_stop+0x16/0x70 drivers/hid/hid-core.c:2322
 uclogic_remove+0x47/0x90 drivers/hid/hid-uclogic-core.c:485
 hid_device_remove+0xce/0x250 drivers/hid/hid-core.c:2682
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3812
 hid_remove_device drivers/hid/hid-core.c:2859 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2879
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3812
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1db7/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 782:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1004 [inline]
 __kmalloc_node_track_caller+0x61/0x100 mm/slab_common.c:1024
 alloc_dr drivers/base/devres.c:119 [inline]
 devm_kmalloc+0xa5/0x230 drivers/base/devres.c:829
 devm_kzalloc include/linux/device.h:314 [inline]
 uclogic_input_configured+0x251/0x610 drivers/hid/hid-uclogic-core.c:151
 hidinput_connect+0x1bf4/0x2b60 drivers/hid/hid-input.c:2344
 hid_connect+0x139e/0x18a0 drivers/hid/hid-core.c:2187
 hid_hw_start drivers/hid/hid-core.c:2302 [inline]
 hid_hw_start+0xa0/0x130 drivers/hid/hid-core.c:2293
 uclogic_probe+0x235/0x380 drivers/hid/hid-uclogic-core.c:221
 __hid_device_probe drivers/hid/hid-core.c:2626 [inline]
 hid_device_probe+0x2e4/0x480 drivers/hid/hid-core.c:2663
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 hid_add_device+0x371/0xa60 drivers/hid/hid-core.c:2809
 usbhid_probe+0xd0a/0x1360 drivers/hid/usbhid/hid-core.c:1429
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

Freed by task 4508:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 release_nodes drivers/base/devres.c:506 [inline]
 devres_release_all+0x192/0x240 drivers/base/devres.c:535
 device_del+0x628/0xa50 drivers/base/core.c:3827
 input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
 hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2386
 hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2273
 hid_hw_stop+0x16/0x70 drivers/hid/hid-core.c:2322
 uclogic_remove+0x47/0x90 drivers/hid/hid-uclogic-core.c:485
 hid_device_remove+0xce/0x250 drivers/hid/hid-core.c:2682
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3812
 hid_remove_device drivers/hid/hid-core.c:2859 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2879
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3812
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x890 drivers/usb/core/hub.c:2252
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x1db7/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff88801c8c6c80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 40 bytes inside of
 freed 64-byte region [ffff88801c8c6c80, ffff88801c8c6cc0)

The buggy address belongs to the physical page:
page:ffffea0000723180 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c8c6
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41640 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 49, tgid 49 (kworker/u4:4), ts 8866051578, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3219
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4475
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
 __kmalloc+0x4f/0x100 mm/slab_common.c:1017
 kmalloc include/linux/slab.h:604 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 lsm_task_alloc security/security.c:654 [inline]
 security_task_alloc+0x1d4/0x270 security/security.c:2869
 copy_process+0x24d7/0x7400 kernel/fork.c:2490
 kernel_clone+0xfd/0x930 kernel/fork.c:2916
 user_mode_thread+0xb4/0xf0 kernel/fork.c:2994
 call_usermodehelper_exec_work kernel/umh.c:172 [inline]
 call_usermodehelper_exec_work+0xcb/0x170 kernel/umh.c:158
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801c8c6b80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88801c8c6c00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88801c8c6c80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                  ^
 ffff88801c8c6d00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88801c8c6d80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
