Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A97894FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHZJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjHZJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:02:37 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C82683
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:02:34 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-573271f9cb1so1821964eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693040553; x=1693645353;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE4f8Rvv3+vmtQRhVaCr0eNUNgXe/6FEv0J/Vrd1Mtk=;
        b=bAqs0fF4pMTZ1wude9kyN+QYEZ1AZRnA5ALnQ2vhfNwAUEI+47HzC4tnIj312OJ/u1
         PiTSSj6vAH2ykflu9fxr0XQro/oKn8cE4YOX3m/cOFXFUcmf2cJuTGTwcf9CaRXf+E09
         p0dTglwv8JRXH7A1vnk+M7saPHOeAir3Mn+cSTaNW5pqNPoJ3n3bheiUroWAZGKB2cfw
         PKEUDw29VtI7ip9tOiVkKKRo13gFZnCBiXVjo6pw1WyMlogKSPrlvaZRgZpzSEZqRfZt
         KfLh8Ltq92+/sPCIKEGp+S1ddgyj8ulfRmp/8BCCNHoSK+UZgLSM4sB9iMpWYiUa8Z1N
         IrGA==
X-Gm-Message-State: AOJu0YwBoCFT1MQx0TLatlcd6g5ief2yegHOo5504PVrfV/KIf2Z33ve
        Na79aEtva9Z/PkWKCQze7Vhw1xbFaOFYL3fqsvXwlPRIHdyV
X-Google-Smtp-Source: AGHT+IHJTEVn7HmJt2JjgYFhRdDigyaZnI+sPDdsIwuzrBs1DS2RvFC7TL0IXPK90H+z7XwxUX1FvAwps1SetpXyJSGugy5xj0JH
MIME-Version: 1.0
X-Received: by 2002:a05:6870:9575:b0:1c0:ffa6:4c60 with SMTP id
 v53-20020a056870957500b001c0ffa64c60mr467633oal.9.1693040553139; Sat, 26 Aug
 2023 02:02:33 -0700 (PDT)
Date:   Sat, 26 Aug 2023 02:02:33 -0700
In-Reply-To: <20230826080830.3403-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2a6cd0603cfb86c@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
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
KASAN: slab-use-after-free Read in l2cap_chan_del

==================================================================
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
BUG: KASAN: slab-use-after-free in l2cap_chan_del+0xa0b/0xa70 net/bluetooth/l2cap_core.c:668
Read of size 8 at addr ffff888073cb0718 by task kworker/1:0/23

CPU: 1 PID: 23 Comm: kworker/1:0 Not tainted 6.5.0-rc6-next-20230818-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
 l2cap_chan_del+0xa0b/0xa70 net/bluetooth/l2cap_core.c:668
 l2cap_chan_close+0xff/0xa20 net/bluetooth/l2cap_core.c:851
 l2cap_chan_timeout+0x17d/0x2f0 net/bluetooth/l2cap_core.c:452
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 78:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x185/0x3f0 mm/slub.c:3523
 kmalloc_reserve+0x167/0x270 net/core/skbuff.c:559
 pskb_expand_head+0x236/0x1170 net/core/skbuff.c:2087
 netlink_trim+0x1eb/0x240 net/netlink/af_netlink.c:1324
 netlink_broadcast_filtered+0xc5/0xf00 net/netlink/af_netlink.c:1531
 netlink_broadcast+0x39/0x50 net/netlink/af_netlink.c:1576
 nlmsg_multicast include/net/netlink.h:1079 [inline]
 genlmsg_multicast_netns include/net/genetlink.h:454 [inline]
 devlink_trap_notify net/devlink/leftover.c:8813 [inline]
 devlink_trap_notify+0x1a9/0x240 net/devlink/leftover.c:8791
 devlink_trap_unregister+0x127/0x3a0 net/devlink/leftover.c:8871
 devl_traps_unregister+0x233/0x2f0 net/devlink/leftover.c:8978
 nsim_dev_traps_exit+0x53/0x170 drivers/net/netdevsim/dev.c:936
 nsim_dev_reload_destroy+0x1e0/0x560 drivers/net/netdevsim/dev.c:1663
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:965
 devlink_reload+0x11c/0x450 net/devlink/dev.c:363
 devlink_pernet_pre_exit+0x1ce/0x2a0 net/devlink/core.c:282
 ops_pre_exit_list net/core/net_namespace.c:160 [inline]
 cleanup_net+0x46c/0xb20 net/core/net_namespace.c:602
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Freed by task 78:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xf0/0x480 mm/slub.c:3831
 skb_kfree_head net/core/skbuff.c:937 [inline]
 skb_kfree_head net/core/skbuff.c:934 [inline]
 skb_free_head+0x17f/0x1b0 net/core/skbuff.c:951
 skb_release_data+0x5ba/0x870 net/core/skbuff.c:981
 skb_release_all net/core/skbuff.c:1047 [inline]
 __kfree_skb net/core/skbuff.c:1061 [inline]
 consume_skb net/core/skbuff.c:1277 [inline]
 consume_skb+0xd2/0x170 net/core/skbuff.c:1271
 netlink_broadcast_filtered+0x3d4/0xf00 net/netlink/af_netlink.c:1554
 netlink_broadcast+0x39/0x50 net/netlink/af_netlink.c:1576
 nlmsg_multicast include/net/netlink.h:1079 [inline]
 genlmsg_multicast_netns include/net/genetlink.h:454 [inline]
 devlink_trap_notify net/devlink/leftover.c:8813 [inline]
 devlink_trap_notify+0x1a9/0x240 net/devlink/leftover.c:8791
 devlink_trap_unregister+0x127/0x3a0 net/devlink/leftover.c:8871
 devl_traps_unregister+0x233/0x2f0 net/devlink/leftover.c:8978
 nsim_dev_traps_exit+0x53/0x170 drivers/net/netdevsim/dev.c:936
 nsim_dev_reload_destroy+0x1e0/0x560 drivers/net/netdevsim/dev.c:1663
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:965
 devlink_reload+0x11c/0x450 net/devlink/dev.c:363
 devlink_pernet_pre_exit+0x1ce/0x2a0 net/devlink/core.c:282
 ops_pre_exit_list net/core/net_namespace.c:160 [inline]
 cleanup_net+0x46c/0xb20 net/core/net_namespace.c:602
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888073cb0600
 which belongs to the cache skbuff_small_head of size 640
The buggy address is located 280 bytes inside of
 freed 640-byte region [ffff888073cb0600, ffff888073cb0880)

The buggy address belongs to the physical page:
page:ffffea0001cf2c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x73cb0
head:ffffea0001cf2c00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888019a6a8c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 78, tgid 78 (kworker/u4:5), ts 454224323940, free_ts 453753622092
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
 kmem_cache_alloc_node+0x137/0x3f0 mm/slub.c:3523
 kmalloc_reserve+0x167/0x270 net/core/skbuff.c:559
 pskb_expand_head+0x236/0x1170 net/core/skbuff.c:2087
 netlink_trim+0x1eb/0x240 net/netlink/af_netlink.c:1324
 netlink_broadcast_filtered+0xc5/0xf00 net/netlink/af_netlink.c:1531
 netlink_broadcast+0x39/0x50 net/netlink/af_netlink.c:1576
 nlmsg_multicast include/net/netlink.h:1079 [inline]
 genlmsg_multicast_netns include/net/genetlink.h:454 [inline]
 devlink_trap_notify net/devlink/leftover.c:8813 [inline]
 devlink_trap_notify+0x1a9/0x240 net/devlink/leftover.c:8791
 devlink_trap_unregister+0x127/0x3a0 net/devlink/leftover.c:8871
 devl_traps_unregister+0x233/0x2f0 net/devlink/leftover.c:8978
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 __stack_depot_save+0x193/0x510 lib/stackdepot.c:443
 kasan_save_stack+0x43/0x50 mm/kasan/common.c:46
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 nf_nat_masq_schedule.part.0+0x290/0x610 net/netfilter/nf_nat_masquerade.c:118
 nf_nat_masq_schedule net/netfilter/nf_nat_masquerade.c:108 [inline]
 masq_device_event+0xee/0x120 net/netfilter/nf_nat_masquerade.c:162
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 dev_close_many+0x305/0x640 net/core/dev.c:1563
 unregister_netdevice_many_notify+0x41b/0x1a20 net/core/dev.c:10908
 unregister_netdevice_many net/core/dev.c:10991 [inline]
 unregister_netdevice_queue+0x2e5/0x3c0 net/core/dev.c:10871
 unregister_netdevice include/linux/netdevice.h:3106 [inline]
 __tun_detach+0x116f/0x1470 drivers/net/tun.c:684
 tun_detach drivers/net/tun.c:700 [inline]
 tun_chr_close+0xc8/0x240 drivers/net/tun.c:3496
 __fput+0x3f7/0xa70 fs/file_table.c:384

Memory state around the buggy address:
 ffff888073cb0600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888073cb0680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888073cb0700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888073cb0780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888073cb0800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1372b89fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e1e55ba80000

