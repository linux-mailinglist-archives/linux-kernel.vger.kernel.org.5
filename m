Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1967078FBE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjIAKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244894AbjIAKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:48:29 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF810CC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:48:26 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-570096f51acso1858869a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 03:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693565305; x=1694170105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHYLdruGmrZzAHV9UXtZPvW0MG9RYRUjj2cq17Sroho=;
        b=M2cmS8oetuKtuCUfEEefpRcwkyvj5bVkWaYtnEYhq6qMi3VcbN3UopgBnht2nb0FeA
         pQLBvd2KiuU25YdO79fqfwvFehyy5jvc9Z+NzlglLTTTgcaNi0rtJ9UMFOGP94zF2SGB
         ctQr4iy0w0ZIKR7+zXs34dKcoZrbY6wMuTQNEwNealeycGhpQO7KHf09bnfSbH1U5lFO
         Er2IF/wlc4KnZQiY6dUJeSt/RlBCnPXTLrwHQwR8m/XjLxC1Y6d0o3M9eTB5p8iFXTuo
         T3GyAgUctZU6bBDW6jV9DFp4+6FzZTwJSOtehSGW6Myndafyz6lRXZNb0DPw0vp/IsAh
         h/Jg==
X-Gm-Message-State: AOJu0YwMek7UDfJobaq7yQ096kseWkYZbEVCHalXRbrgRRfuaBiddEzK
        qO5J0pRR06oJwq5rwCRr6YyIpmWAXfE+5XhF2vs/U9sw7pL+
X-Google-Smtp-Source: AGHT+IFw5MEJ5/kkcFIAQTU4b/bjQOooVbAxqK8C/v+qjJu+nRnZP8Cm84qcEi96Uguxt+oj58g90cQzirEF1f7EKF+PWO42vqP7
MIME-Version: 1.0
X-Received: by 2002:a17:90b:153:b0:269:32cb:3321 with SMTP id
 em19-20020a17090b015300b0026932cb3321mr593381pjb.0.1693565305335; Fri, 01 Sep
 2023 03:48:25 -0700 (PDT)
Date:   Fri, 01 Sep 2023 03:48:25 -0700
In-Reply-To: <20230901092459.4893-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006db59d060449e626@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in dev_uevent
From:   syzbot <syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in dev_uevent

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:645 [inline]
BUG: KASAN: slab-use-after-free in string+0x218/0x2b0 lib/vsprintf.c:727
Read of size 1 at addr ffff8880156b6b80 by task udevd/4483

CPU: 0 PID: 4483 Comm: udevd Not tainted 6.5.0-syzkaller-09276-g99d99825fc07-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 string_nocheck lib/vsprintf.c:645 [inline]
 string+0x218/0x2b0 lib/vsprintf.c:727
 vsnprintf+0x10fc/0x1d80 lib/vsprintf.c:2818
 add_uevent_var+0x1c4/0x440 lib/kobject_uevent.c:665
 dev_uevent+0x3ec/0x8f0 drivers/base/core.c:2575
 uevent_show+0x19a/0x310 drivers/base/core.c:2646
 dev_attr_show+0x54/0xc0 drivers/base/core.c:2349
 sysfs_kf_seq_show+0x331/0x4b0 fs/sysfs/file.c:59
 seq_read_iter+0x43e/0xd10 fs/seq_file.c:230
 call_read_iter include/linux/fs.h:1979 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x795/0xb00 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd11cb16b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffea04bfe78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000556f408ae0f0 RCX: 00007fd11cb16b6a
RDX: 0000000000001000 RSI: 0000556f408d6790 RDI: 000000000000000c
RBP: 0000556f408ae0f0 R08: 000000000000000c R09: 0000000000000200
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffea04c0358 R15: 000000000000000a
 </TASK>

Allocated by task 14097:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 raw_ioctl_init drivers/usb/gadget/legacy/raw_gadget.c:458 [inline]
 raw_ioctl+0x1aad/0x3cd0 drivers/usb/gadget/legacy/raw_gadget.c:1248
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 14097:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 dev_free drivers/usb/gadget/legacy/raw_gadget.c:210 [inline]
 kref_put+0xb5/0x7c0 include/linux/kref.h:65
 raw_release+0xfb/0x1a0 drivers/usb/gadget/legacy/raw_gadget.c:422
 __fput+0x3f8/0x910 fs/file_table.c:384
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880156b6b80
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff8880156b6b80, ffff8880156b6ba0)

The buggy address belongs to the physical page:
page:ffffea000055ad80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x156b6
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012841500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5402, tgid 5402 (syz-executor.5), ts 82260246009, free_ts 82239822109
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31ec/0x3370 mm/page_alloc.c:3183
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4439
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xade/0x1100 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ref_tracker_alloc+0x14b/0x480 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4056 [inline]
 netdev_tracker_alloc include/linux/netdevice.h:4068 [inline]
 netdev_get_by_index+0x7a/0xb0 net/core/dev.c:888
 fib6_nh_init+0x1da/0x2140 net/ipv6/route.c:3528
 ip6_route_info_create+0x95e/0x1220 net/ipv6/route.c:3796
 addrconf_f6i_alloc+0x3c2/0x7f0 net/ipv6/route.c:4569
 ipv6_add_addr+0x5a5/0x10c0 net/ipv6/addrconf.c:1114
 inet6_addr_add+0x55c/0xaf0 net/ipv6/addrconf.c:2997
 inet6_rtm_newaddr+0x89e/0xc80 net/ipv6/addrconf.c:4972
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 __slab_free+0x2f6/0x390 mm/slub.c:3715
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x6c/0x3b0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x141/0x270 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:643 [inline]
 netdevice_event+0x37d/0x950 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0x18c/0x3a0 kernel/notifier.c:93
 __dev_notify_flags+0x359/0x650
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:8674
 do_setlink+0xfb2/0x4340 net/core/rtnetlink.c:2880
 __rtnl_newlink net/core/rtnetlink.c:3671 [inline]
 rtnl_newlink+0x17f6/0x2070 net/core/rtnetlink.c:3718
 rtnetlink_rcv_msg+0x82b/0xf50 net/core/rtnetlink.c:6444

Memory state around the buggy address:
 ffff8880156b6a80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880156b6b00: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
>ffff8880156b6b80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff8880156b6c00: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880156b6c80: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         99d99825 Merge tag 'nfs-for-6.6-1' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=150c6d87a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8954a0dbb2cea01
dashboard link: https://syzkaller.appspot.com/bug?extid=5ee79919ffe91d629b96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177a8fffa80000

