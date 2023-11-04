Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F547E0D08
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjKDBXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:23:07 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E29D5F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:23:04 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2e7a8fbbdso3551589b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 18:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699060983; x=1699665783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7qtiuDax89TJTi70i5r63SkkHu3i5+DWST7z9Os/as=;
        b=l2RLl37KIk68n6OdDFidoPiPWYiYSMhW8tZBUWwM9yx/Oa3S0sTofa7jbtFPAPYEVV
         1EA46nb09TCe3SKatkgfxiUGdCyD0wI9rxkpuox9Wb9u3EXbDKoQPCOeU2uoKNyqjYAQ
         prIjeY4NXncCtJkG76UyU6Uy44fmiKeDS00LVN5B2zVw4mbhQIyUcImgmNCBL7VAJEx5
         u1ZLUQO9EDes2lkTfwlHzn5BY92kxkjbEtF688DwjakPmdDn3hQrOTKBKU9vT6GHH3Li
         gZ3cytNE6VP8HzrFlQQ42bvZ6CK/3l6eupdofbKdW/06eClyo0JgpJO47hqlAeHdV0HW
         HlOg==
X-Gm-Message-State: AOJu0YytUdrPFcHOV9UKa0vRf2cVLaBFviGPYnxO8xiB0iAZ8c+qaia4
        +1Edrahr2S81nI+ZMAQuZ+fRBVat+kTI6n3DEXeImeSxY0tc
X-Google-Smtp-Source: AGHT+IEKkJCwiu5Zq2mdv5a59IxO7mhmK80VZ8kuU+chXbrAwR2A4TucJUJuTkjsHO2Xin0Mu4xZtI0LtCz7H8B3R2usUbZQG4r6
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1523:b0:3b2:e46e:448c with SMTP id
 u35-20020a056808152300b003b2e46e448cmr8480416oiw.3.1699060983417; Fri, 03 Nov
 2023 18:23:03 -0700 (PDT)
Date:   Fri, 03 Nov 2023 18:23:03 -0700
In-Reply-To: <20231104010547.1505-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e519f060949763f@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
From:   syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in usb_hcd_flush_endpoint

vhci_hcd: vhci_device speed not set
usb 9-1: device descriptor read/64, error -110
==================================================================
BUG: KASAN: slab-use-after-free in usb_hcd_flush_endpoint+0x1ab/0x3e0 drivers/usb/core/hcd.c:1779
Read of size 4 at addr ffff888019ecd204 by task kworker/1:0/23

CPU: 1 PID: 23 Comm: kworker/1:0 Not tainted 6.6.0-syzkaller-12893-ge392ea4d4d00-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 usb_hcd_flush_endpoint+0x1ab/0x3e0 drivers/usb/core/hcd.c:1779
 usb_disable_endpoint+0x123/0x180 drivers/usb/core/message.c:1300
 usb_ep0_reinit drivers/usb/core/hub.c:4636 [inline]
 hub_port_connect drivers/usb/core/hub.c:5485 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5599 [inline]
 port_event drivers/usb/core/hub.c:5759 [inline]
 hub_event+0x2ee5/0x50a0 drivers/usb/core/hub.c:5841
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 23:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 usb_alloc_urb+0x3a/0x130 drivers/usb/core/urb.c:75
 usb_internal_control_msg drivers/usb/core/message.c:96 [inline]
 usb_control_msg+0x189/0x4c0 drivers/usb/core/message.c:154
 get_bMaxPacketSize0 drivers/usb/core/hub.c:4744 [inline]
 hub_port_init+0xaa6/0x23a0 drivers/usb/core/hub.c:4940
 hub_port_connect drivers/usb/core/hub.c:5388 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5599 [inline]
 port_event drivers/usb/core/hub.c:5759 [inline]
 hub_event+0x2a3c/0x50a0 drivers/usb/core/hub.c:5841
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 usb_start_wait_urb+0x24b/0x520 drivers/usb/core/message.c:81
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
 get_bMaxPacketSize0 drivers/usb/core/hub.c:4744 [inline]
 hub_port_init+0xaa6/0x23a0 drivers/usb/core/hub.c:4940
 hub_port_connect drivers/usb/core/hub.c:5388 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5599 [inline]
 port_event drivers/usb/core/hub.c:5759 [inline]
 hub_event+0x2a3c/0x50a0 drivers/usb/core/hub.c:5841
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2667 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
 addrconf_ifdown+0x18f1/0x1bb0 net/ipv6/addrconf.c:3958
 addrconf_notify+0x3ce/0x1020
 notifier_call_chain+0x18c/0x3a0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2003 [inline]
 call_netdevice_notifiers net/core/dev.c:2017 [inline]
 unregister_netdevice_many_notify+0xd87/0x1710 net/core/dev.c:10983
 ip6_tnl_exit_batch_net+0x5c8/0x610 net/ipv6/ip6_tunnel.c:2278
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x767/0xb80 net/core/net_namespace.c:614
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 insert_work+0x3e/0x320 kernel/workqueue.c:1647
 __queue_work+0xc06/0x1010 kernel/workqueue.c:1799
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1834
 queue_work include/linux/workqueue.h:562 [inline]
 call_usermodehelper_exec+0x276/0x480 kernel/umh.c:434
 kobject_uevent_env+0x6a9/0x8e0 lib/kobject_uevent.c:618
 kset_register+0x1ab/0x200 lib/kobject.c:873
 class_register+0x1c3/0x2a0 drivers/base/class.c:205
 cpuid_init+0x49/0x100 arch/x86/kernel/cpuid.c:161
 do_one_initcall+0x234/0x800 init/main.c:1236
 do_initcall_level+0x157/0x210 init/main.c:1298
 do_initcalls+0x3f/0x80 init/main.c:1314
 kernel_init_freeable+0x429/0x5c0 init/main.c:1551
 kernel_init+0x1d/0x2a0 init/main.c:1441
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888019ecd200
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 4 bytes inside of
 freed 192-byte region [ffff888019ecd200, ffff888019ecd2c0)

The buggy address belongs to the physical page:
page:ffffea000067b340 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19ecd
ksm flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41a00 ffffea00007faa00 dead000000000003
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 3961051695, free_ts 3958343321
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
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 call_usermodehelper_setup+0x8e/0x260 kernel/umh.c:363
 kobject_uevent_env+0x68c/0x8e0 lib/kobject_uevent.c:614
 kset_register+0x1ab/0x200 lib/kobject.c:873
 class_register+0x1c3/0x2a0 drivers/base/class.c:205
 msr_init+0x49/0x100 arch/x86/kernel/msr.c:270
 do_one_initcall+0x234/0x800 init/main.c:1236
 do_initcall_level+0x157/0x210 init/main.c:1298
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x92a/0xa50 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 mm_free_pgd kernel/fork.c:803 [inline]
 __mmdrop+0xb8/0x3d0 kernel/fork.c:919
 free_bprm+0x144/0x330 fs/exec.c:1490
 kernel_execve+0x8f5/0xa10 fs/exec.c:2024
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888019ecd100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888019ecd180: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888019ecd200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888019ecd280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888019ecd300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e392ea4d Merge tag 's390-6.7-1' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15c491ef680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94632a8e2ffd08bb
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17af6aeb680000

