Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E0791719
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbjIDMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIDMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:31:26 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368C1A7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:31:22 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-56f75e70190so993454a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693830682; x=1694435482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nubPteha6dvdqlhVi85KbiXP4AG8f7w7B6ktAspzwqk=;
        b=Din/h+DyxdOSUNeqNYiikiVmeESHEjgejdvuDWKIEEh+RiiSeQxkHpd3N3rsmI0U3Z
         B8Bgt1EpuPRPn/4tl6GAdgZsu+JbEQEHAL8dJtYHVF4Vb/zFqrhY7joL/YbBotLVfqYu
         rCSXBQbWJvEwCrK4fVJIZM+oUjq+RTE6UFSJO5zkIwNVqs2Y9lXKWrJ4uGJny3rHgB4D
         5C5p1wqnX3aJjRkEmK2uiD9iNBL3i9OkYZSqWkivXrYwofTDMd/ssPzu3GVgXNgUjtno
         Mp+9pQhU6BQDYlPW90PwBaMo8nt0nxi/Y+NtqQma7aYR0Toc1CcV30k0FpPM1aDNJajq
         MSbg==
X-Gm-Message-State: AOJu0YyWeL6Cra51UZXiryQp6l3u/J0Gpit9UV++Uj6usxel7OtLGbcZ
        P4+36rxliFGqsrzMwk6RbxwF+cPPRAvpy34pc+hI1bC6tlHp
X-Google-Smtp-Source: AGHT+IGo2WrYHmJEQ4WGbrjSQ8xjSVkqYB08lu6SD9EkQy2glfwYBQ60+mUriMNvQeP5066xfx0jGkql3cMTG3OICHvH2av1gQjq
MIME-Version: 1.0
X-Received: by 2002:a63:2903:0:b0:564:aeb6:c383 with SMTP id
 bt3-20020a632903000000b00564aeb6c383mr2071601pgb.1.1693830682534; Mon, 04 Sep
 2023 05:31:22 -0700 (PDT)
Date:   Mon, 04 Sep 2023 05:31:22 -0700
In-Reply-To: <20230904111631.5507-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002468ce060487b0b9@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
From:   syzbot <syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_conn_del

Bluetooth: hci0: command 0x0409 tx timeout
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:777 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_del+0xb9/0x2d0 net/bluetooth/sco.c:195
Write of size 4 at addr ffff88807c81d080 by task kworker/u5:0/49

CPU: 1 PID: 49 Comm: kworker/u5:0 Not tainted 6.5.0-syzkaller-03967-gbd6c11bc43c4-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sock_hold include/net/sock.h:777 [inline]
 sco_conn_del+0xb9/0x2d0 net/bluetooth/sco.c:195
 sco_connect_cfm+0x205/0xb70 net/bluetooth/sco.c:1371
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x196/0x320 net/bluetooth/hci_conn.c:1251
 hci_conn_cleanup_child net/bluetooth/hci_conn.c:1065 [inline]
 hci_conn_unlink+0x6f9/0x9b0 net/bluetooth/hci_conn.c:1092
 hci_conn_del+0x59/0xd10 net/bluetooth/hci_conn.c:1118
 hci_abort_conn_sync+0xacb/0xe20 net/bluetooth/hci_sync.c:5435
 abort_conn_sync+0x18e/0x3a0 net/bluetooth/hci_conn.c:2894
 hci_cmd_sync_work+0x1a4/0x3c0 net/bluetooth/hci_sync.c:306
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5692:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc+0x5d/0x100 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 sk_prot_alloc+0x1a4/0x2a0 net/core/sock.c:2089
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2142
 bt_sock_alloc+0x3b/0x3e0 net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:505 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:536
 bt_sock_create+0x180/0x340 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x334/0x810 net/socket.c:1549
 sock_create net/socket.c:1600 [inline]
 __sys_socket_create net/socket.c:1637 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1688
 __do_sys_socket net/socket.c:1702 [inline]
 __se_sys_socket net/socket.c:1700 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1700
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5693:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook+0x10b/0x1e0 mm/slub.c:1818
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3814
 sk_prot_free net/core/sock.c:2125 [inline]
 __sk_destruct+0x5fc/0x770 net/core/sock.c:2217
 sk_destruct+0xc2/0xf0 net/core/sock.c:2232
 __sk_free+0xc4/0x3a0 net/core/sock.c:2243
 sk_free+0x7c/0xa0 net/core/sock.c:2254
 sock_put include/net/sock.h:1983 [inline]
 sco_sock_kill net/bluetooth/sco.c:436 [inline]
 sco_sock_kill+0x23a/0x290 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1266
 __sock_release+0xae/0x260 net/socket.c:657
 sock_close+0x1c/0x20 net/socket.c:1399
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 get_signal+0x1075/0x2770 kernel/signal.c:2657
 arch_do_signal_or_restart+0x89/0x5f0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807c81d000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff88807c81d000, ffff88807c81d800)

The buggy address belongs to the physical page:
page:ffffea0001f20600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c818
head:ffffea0001f20600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012842000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 22, tgid 22 (kworker/1:0), ts 90926873259, free_ts 90560277193
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node_track_caller+0x4d/0x100 mm/slab_common.c:1005
 kmalloc_reserve+0xef/0x270 net/core/skbuff.c:575
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6299
 sock_alloc_send_pskb+0x7c8/0x950 net/core/sock.c:2794
 sock_alloc_send_skb include/net/sock.h:1879 [inline]
 mld_newpack.isra.0+0x1ee/0x790 net/ipv6/mcast.c:1746
 add_grhead+0x295/0x340 net/ipv6/mcast.c:1849
 add_grec+0x10bb/0x1680 net/ipv6/mcast.c:1987
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2647
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3494
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags+0x9c/0xf0 include/linux/audit.h:319
 vfs_fstatat+0x77/0xb0 fs/stat.c:314
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:485
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807c81cf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807c81d000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c81d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807c81d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c81d180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         bd6c11bc Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=128e6447a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e42f38680000

