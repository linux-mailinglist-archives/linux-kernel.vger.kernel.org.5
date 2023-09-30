Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3B7B3DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 05:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjI3Dsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 23:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjI3Dsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:48:32 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4238F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 20:48:29 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c61ada4178so10012035a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 20:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696045709; x=1696650509;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heB+LOr9lTLVsEmNYhKSuirJy6vgj8eJ6KJThUAsCww=;
        b=E1nl3rjP1EBoj/uTuQ6q0BOSl/Y66joSAcnRuctG2TXBsog+aq4rzzLInZ/Ak7D+Hp
         PfNa1ONncZLOKBtF8D+RfhFOVEhBiFm2M85Q+/j0Sp2JrZ3xcHzO4SSugLXMwYBTdUJS
         lZ5Ohj2b+pf8YQIoguu0SCd55oXjGBrwydoyRGUijq3zhgNMAx9qIerGtaI3uNxaAb3Q
         LBgOzo8BFysYRBa1d09BvyTBOLakdihBQg5oJmuCKtywKYdWTROGFtOuEM3SGnrpdoq5
         NQluO0vnkVbygjCy4KHhYqLuuEFEOBdtHjhOisFvflO4wPzfXtkh9SdyCptVwQt6+wfi
         t2Tg==
X-Gm-Message-State: AOJu0YyfW4xCHIJunv0h9MasXTpu7ZT1RjzMhpCR0DUM/TnOzkGwNadj
        gyQN2VXdIyMwlW4etmouD4L+2GDWCcZ8ARCis4aEufo7a8PF
X-Google-Smtp-Source: AGHT+IFj9xeU+eZTwEUXRy227rH2g68C4yX/7x8ZGMmVB0Uo3X5QpNjJDgT1IZpPPPBVxa9cBxalo7F+eYAf5GQurv5fnChPN1yC
MIME-Version: 1.0
X-Received: by 2002:a9d:74d9:0:b0:6c4:e41c:6e6a with SMTP id
 a25-20020a9d74d9000000b006c4e41c6e6amr1717943otl.4.1696045709248; Fri, 29 Sep
 2023 20:48:29 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:48:29 -0700
In-Reply-To: <20230930033224.1393-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005d75d06068b6a4c@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tls_encrypt_done
From:   syzbot <syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in tls_encrypt_done

==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff888021a7253c by task kworker/1:1/46

CPU: 1 PID: 46 Comm: kworker/1:1 Not tainted 6.6.0-rc3-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: pencrypt_serial padata_serial_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
 do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 tls_encrypt_done+0x281/0x560 net/tls/tls_sw.c:488
 padata_serial_worker+0x246/0x490 kernel/padata.c:378
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5717:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tls_set_sw_offload+0x12e0/0x1700 net/tls/tls_sw.c:2606
 do_tls_setsockopt_conf net/tls/tls_main.c:667 [inline]
 do_tls_setsockopt net/tls/tls_main.c:772 [inline]
 tls_setsockopt+0x108c/0x1340 net/tls/tls_main.c:800
 __sys_setsockopt+0x2cd/0x5b0 net/socket.c:2308
 __do_sys_setsockopt net/socket.c:2319 [inline]
 __se_sys_setsockopt net/socket.c:2316 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2316
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5716:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 __kmem_cache_free+0xcc/0x2d0 mm/slab.c:3564
 tls_sk_proto_close+0x4c3/0xb00 net/tls/tls_main.c:390
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3372
 mld_clear_delrec+0x134/0x660 net/ipv6/mcast.c:824
 ipv6_mc_destroy_dev+0x49/0x680 net/ipv6/mcast.c:2788
 addrconf_ifdown.isra.0+0x1597/0x1c50 net/ipv6/addrconf.c:3935
 addrconf_notify+0x22d/0x1920 net/ipv6/addrconf.c:3715
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 unregister_netdevice_many_notify+0x85f/0x1a20 net/core/dev.c:10938
 unregister_netdevice_many net/core/dev.c:10994 [inline]
 default_device_exit_batch+0x584/0x740 net/core/dev.c:11453
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 fib6_info_release include/net/ip6_fib.h:332 [inline]
 fib6_info_release include/net/ip6_fib.h:329 [inline]
 fixup_permanent_addr net/ipv6/addrconf.c:3533 [inline]
 addrconf_permanent_addr net/ipv6/addrconf.c:3561 [inline]
 addrconf_notify+0x149e/0x1920 net/ipv6/addrconf.c:3633
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8636
 dev_change_flags+0x122/0x170 net/core/dev.c:8674
 do_setlink+0x1a2a/0x3fa0 net/core/rtnetlink.c:2880
 __rtnl_newlink+0xc1d/0x1940 net/core/rtnetlink.c:3671
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
 rtnetlink_rcv_msg+0x3c4/0xdf0 net/core/rtnetlink.c:6444
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 __sys_sendto+0x255/0x340 net/socket.c:2177
 __do_sys_sendto net/socket.c:2189 [inline]
 __se_sys_sendto net/socket.c:2185 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2185
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888021a72400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 316 bytes inside of
 freed 512-byte region [ffff888021a72400, ffff888021a72600)

The buggy address belongs to the physical page:
page:ffffea0000869c80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21a72
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x4()
raw: 00fff00000000800 ffff888012c40600 ffffea00006c3ed0 ffffea0000f39050
raw: 0000000000000000 ffff888021a72000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (swapper/0), ts 18600299140, free_ts 18486327960
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 __kmem_cache_alloc_node+0x3c5/0x470 mm/slab.c:3521
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 dev_pm_qos_constraints_allocate+0x87/0x4b0 drivers/base/power/qos.c:204
 __dev_pm_qos_add_request+0x47b/0x570 drivers/base/power/qos.c:344
 dev_pm_qos_add_request+0x3a/0x60 drivers/base/power/qos.c:394
 usb_hub_create_port_device+0x474/0xe30 drivers/usb/core/port.c:727
 hub_configure drivers/usb/core/hub.c:1685 [inline]
 hub_probe+0x1e62/0x3070 drivers/usb/core/hub.c:1922
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 vfree+0x181/0x7a0 mm/vmalloc.c:2842
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:2763
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888021a72400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021a72480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021a72500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888021a72580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021a72600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10436bda680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1004ea06680000

