Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46C784081
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjHVMPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHVMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:15:37 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A993193
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:15:35 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-565e5961ddbso6151716a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692706535; x=1693311335;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A11YOkupM8IJbU9SaQPhsmn7gkacmQLBZxZUZfpi3gQ=;
        b=CoqVadH+ShaVRmcbn3SCR3q7H2quwSveigpTAwBd9Qq2qR1TBdDuwqQk7YL2QmTRMB
         NsWE6obx8Sl8udrHngKqV3nHt3IuLifp+HGbAaF2VaI5aR1LWKBg/Vn8n5vSbteSB4ul
         FCEI2l9F2LoCIs8NwfhnXdWStYnF0tre5/GUq9+0fKP1mLWXnZqmwC16mUhTmp45dgaq
         q+PJuun1zz+Lt4bRm8PKFYNJun3cv143yO+lROxCaIKP83EIJkHcWJevIQ+q35Fa4tva
         hhLZuODIblpQ+cLeJeJ0/+RCvlA+mahxOstq6mTg0u1JuKMAsJ/hsU8++rBiZQBMjpcd
         XkAw==
X-Gm-Message-State: AOJu0YzzMkSy2g0Ak6P73pl16R3KLl1ILaaf5TTSboaPtel7rXQ7O4EJ
        1PkN9cSquVAuvy9aaQfuxpPSi+X6vC3/M/fRqf1XVDx9jZz4
X-Google-Smtp-Source: AGHT+IHgyt+3sNFDSzaR7NZ1fM9jyBzLm2GLj7lI3wYliFfJ80D0LHL2L32EmvgkKocGYT1KdBso5TXNm88I2+38oSVptLCCZu6t
MIME-Version: 1.0
X-Received: by 2002:a63:7b15:0:b0:563:962e:e912 with SMTP id
 w21-20020a637b15000000b00563962ee912mr1627152pgc.0.1692706534808; Tue, 22 Aug
 2023 05:15:34 -0700 (PDT)
Date:   Tue, 22 Aug 2023 05:15:34 -0700
In-Reply-To: <20230822112701.2655-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7617e060381f3ab@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_send_acl

==================================================================
BUG: KASAN: slab-use-after-free in hci_send_acl+0xdf4/0xf30 net/bluetooth/hci_core.c:3228
Read of size 8 at addr ffff888069713618 by task kworker/0:4/5435

CPU: 0 PID: 5435 Comm: kworker/0:4 Not tainted 6.5.0-rc6-next-20230818-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 hci_send_acl+0xdf4/0xf30 net/bluetooth/hci_core.c:3228
 l2cap_send_cmd+0x6dd/0x920 net/bluetooth/l2cap_core.c:977
 l2cap_send_conn_req+0x1e5/0x260 net/bluetooth/l2cap_core.c:1286
 l2cap_start_connection+0x11e/0x420 net/bluetooth/l2cap_core.c:1514
 l2cap_conn_start+0x7ae/0xa40 net/bluetooth/l2cap_core.c:1661
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5466:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 hci_chan_create+0xa6/0x3a0 net/bluetooth/hci_conn.c:2691
 l2cap_conn_add.part.0+0x1a/0xdf0 net/bluetooth/l2cap_core.c:7839
 l2cap_conn_add include/net/bluetooth/l2cap.h:866 [inline]
 l2cap_chan_connect+0x15b9/0x2140 net/bluetooth/l2cap_core.c:8051
 bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
 lowpan_control_write+0x3d6/0x730 net/bluetooth/6lowpan.c:1129
 full_proxy_write+0x124/0x190 fs/debugfs/file.c:236
 vfs_write+0x2a4/0xe40 fs/read_write.c:582
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5045:
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
 hci_chan_list_flush+0x81/0xf0 net/bluetooth/hci_conn.c:2731
 hci_conn_cleanup net/bluetooth/hci_conn.c:152 [inline]
 hci_conn_del+0x1fc/0xd10 net/bluetooth/hci_conn.c:1140
 hci_abort_conn_sync+0xacb/0xe20 net/bluetooth/hci_sync.c:5432
 abort_conn_sync+0x18e/0x3a0 net/bluetooth/hci_conn.c:2878
 hci_cmd_sync_work+0x1a4/0x3c0 net/bluetooth/hci_sync.c:306
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888069713600
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff888069713600, ffff888069713680)

The buggy address belongs to the physical page:
page:ffffea0001a5c4c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x69713
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c418c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5400, tgid 5400 (syz-executor.0), ts 92397723620, free_ts 92397302327
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3219
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4475
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1872 [inline]
 allocate_slab+0xa1/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1003 [inline]
 __kmalloc_node+0x52/0x110 mm/slab_common.c:1011
 kmalloc_array_node include/linux/slab.h:698 [inline]
 kcalloc_node include/linux/slab.h:703 [inline]
 memcg_alloc_slab_cgroups+0xa9/0x170 mm/memcontrol.c:2895
 memcg_slab_post_alloc_hook+0xaa/0x390 mm/slab.h:530
 slab_post_alloc_hook mm/slab.h:770 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x1a7/0x3b0 mm/slub.c:3502
 prepare_creds+0x43/0x7b0 kernel/cred.c:263
 copy_creds+0xa7/0xe50 kernel/cred.c:368
 copy_process+0xeb6/0x7400 kernel/fork.c:2368
 kernel_clone+0xfd/0x930 kernel/fork.c:2916
 __do_sys_clone+0xba/0x100 kernel/fork.c:3059
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 vfree+0x181/0x7a0 mm/vmalloc.c:2842
 __do_replace+0x7bf/0x9c0 net/ipv4/netfilter/arp_tables.c:937
 do_replace net/ipv6/netfilter/ip6_tables.c:1154 [inline]
 do_ip6t_set_ctl+0x93a/0xbd0 net/ipv6/netfilter/ip6_tables.c:1636
 nf_setsockopt+0x87/0xe0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x12b/0x190 net/ipv6/ipv6_sockglue.c:1017
 tcp_setsockopt+0x9d/0x100 net/ipv4/tcp.c:3677
 __sys_setsockopt+0x2cd/0x5b0 net/socket.c:2307
 __do_sys_setsockopt net/socket.c:2318 [inline]
 __se_sys_setsockopt net/socket.c:2315 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2315
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888069713500: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff888069713580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888069713600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888069713680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888069713700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1555b1bba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1766e9bba80000

