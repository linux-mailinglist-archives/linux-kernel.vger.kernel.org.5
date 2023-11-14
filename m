Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC77EAFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjKNMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjKNMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:31:09 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257E18A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:31:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc56cc8139so60086915ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699965065; x=1700569865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUYmSZlm1nMJXO2R3wB4sPoO3pBO58EZIFznfnETt7o=;
        b=kCAqWOxxZ/yIUXt2VRCm9UXlJuJRYjgan8Yj/r5rMBeBXh9xs1pjdIl1nGZoQcH/zP
         M/JS4Lj+dLdzkbFfh56/2zFC/L9e73sreZHLZaP8/ciurneLZmxO7rddq8OQULQ2iHXx
         d4ZxzznZBDECWGBDdyVcBQnSuUrXOMvVcl1jxuKyRSSyFgriQPA53Or0eTH4K8xqoxjJ
         PuQ24J7hp1NE3EnA1y9U+XfdtmUg+ied8SyLSpJ4GOirZ67w3AMtjszPhR9s/6jfHeC3
         1TOMdvW5oV2DKwW0hK9vXshslXdB+wEYZXzuqwquH+ky2XssAfuso1BEm8BWym1ahRIe
         64fA==
X-Gm-Message-State: AOJu0YwqjIkYlYiv2jxuJiH7VkEO6XK21zxVpn87r5b1JARJrSmJCJLG
        nf9tIE8H63hdd5nFnbTaglU94Qs6EQg53DL9Eltc9/nlR8Na
X-Google-Smtp-Source: AGHT+IFV26oXynQEjTtKVvs4a/fPAHD+JQDpX39jbhF+0Xkg0sKXIDDUtfW6jsxpRzOfe9zsppS4A5Yat7W/KIZihpGmhdHpbT2r
MIME-Version: 1.0
X-Received: by 2002:a17:902:6b82:b0:1cc:2c44:58f4 with SMTP id
 p2-20020a1709026b8200b001cc2c4458f4mr585532plk.1.1699965065443; Tue, 14 Nov
 2023 04:31:05 -0800 (PST)
Date:   Tue, 14 Nov 2023 04:31:05 -0800
In-Reply-To: <3df56245-d104-4ce2-ab88-0fb1d29cd629@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db456b060a1bf5d2@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in nfc_alloc_send_skb

==================================================================
BUG: KASAN: slab-use-after-free in nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
Read of size 4 at addr ffff888028ecd548 by task syz-executor.0/5548

CPU: 0 PID: 5548 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00012-g9bacdd8996c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
 nfc_llcp_send_ui_frame+0x2ac/0x670 net/nfc/llcp_commands.c:766
 llcp_sock_sendmsg+0x24d/0x380 net/nfc/llcp_sock.c:812
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmmsg+0x3b2/0x730 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f47e707cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47e63fe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f47e719bf80 RCX: 00007f47e707cae9
RDX: 0000000000000001 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 00007f47e70c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f47e719bf80 R15: 00007ffc0cfc6608
 </TASK>

Allocated by task 5548:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 nfc_allocate_device+0x12f/0x520 net/nfc/core.c:1065
 nci_allocate_device+0x1e2/0x360 net/nfc/nci/core.c:1179
 virtual_ncidev_open+0x75/0x1b0 drivers/nfc/virtual_ncidev.c:136
 misc_open+0x30b/0x380 drivers/char/misc.c:165
 chrdev_open+0x5ab/0x630 fs/char_dev.c:414
 do_dentry_open+0x8fd/0x1590 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2845/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 5547:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 device_release+0x95/0x1c0
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1ee/0x430 lib/kobject.c:733
 nfc_free_device include/net/nfc/nfc.h:213 [inline]
 nci_free_device+0x38/0x50 net/nfc/nci/core.c:1209
 virtual_ncidev_close+0x70/0x90 drivers/nfc/virtual_ncidev.c:164
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff888028ecd000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1352 bytes inside of
 freed 2048-byte region [ffff888028ecd000, ffff888028ecd800)

The buggy address belongs to the physical page:
page:ffffea0000a3b200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28ec8
head:ffffea0000a3b200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 11, tgid 11 (kworker/u4:0), ts 67750501743, free_ts 67716621887
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x339a/0x3530 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:1027
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 rtmsg_ifinfo_build_skb+0x89/0x280 net/core/rtnetlink.c:4067
 unregister_netdevice_many_notify+0xe2a/0x1710 net/core/dev.c:10987
 unregister_netdevice_many net/core/dev.c:11039 [inline]
 default_device_exit_batch+0x5c4/0x630 net/core/dev.c:11508
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x767/0xb80 net/core/net_namespace.c:614
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x92a/0xa50 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __slab_free+0x2f6/0x390 mm/slub.c:3715
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3c0 mm/slab.h:763
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x1d0/0x300 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:643 [inline]
 netdevice_event+0x37d/0x950 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0x18c/0x3a0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2003 [inline]
 call_netdevice_notifiers net/core/dev.c:2017 [inline]
 unregister_netdevice_many_notify+0xd87/0x1710 net/core/dev.c:10983
 unregister_netdevice_many net/core/dev.c:11039 [inline]
 default_device_exit_batch+0x5c4/0x630 net/core/dev.c:11508
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x767/0xb80 net/core/net_namespace.c:614
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784

Memory state around the buggy address:
 ffff888028ecd400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028ecd480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028ecd500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888028ecd580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028ecd600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         9bacdd89 Merge tag 'for-6.7-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17b024fb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bf1661f609e7f0
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bb8f5b680000

