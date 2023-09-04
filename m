Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA37912CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351419AbjIDH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343962AbjIDH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:58:44 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF504E72
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:58:11 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-26ecc4795a4so1249726a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693814270; x=1694419070;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5O71tinBmwucEUXKQtXSx22Y4gCIOZyqiEzsS9F8mk=;
        b=XhThdD5/5fImnRSaiQlawyqSvNj/SgTCyaD7Lr2O9+oy7GH/Gw4hTUYbt1tDm0BfiD
         nqosMCRdy4vqwd64ZoPrkteLSgvYFBWcVG/UCjIqr3G0O9HPzrITkPNJQPxEaq8v/nnx
         PEGhxCJQIY5cFzPhA2tmYyhySU46C/tZgD3g4ioZB0zLFGv/Ryr3xbvNynGwlfQGg0k4
         KEdde96A+aQzPE+nfsdgK0J/L6FEvexvqU57A0nMpaRnHAqV68/cWrOTO6IFlJoKYYOX
         o/DL5gnUAKVBmVcFoVoMEPSqXeAZNpEQQtqR2Vah+JBqhvYDWxJY6vvVM8Zzasno2g5E
         qt/g==
X-Gm-Message-State: AOJu0YxkU/Pl+B1G38vk+v6VJsh81jlTiZp5WhdrjIVdG0C4ahYhHNoG
        142pnMD99jiBpMPjjwIp7z7fZJoOwYRyuoNWKvlsbLrGcwI8
X-Google-Smtp-Source: AGHT+IGvA562NLMBa+3yEYaI6WEIwRFL6Wu3UAwQ18MIAM7dG+Q5cQaVOuemuGoc/6Oy2lGAbwF5bSLk74X1fAZuIzJRHqmTVCTc
MIME-Version: 1.0
X-Received: by 2002:a17:90b:e94:b0:26b:5c14:cedc with SMTP id
 fv20-20020a17090b0e9400b0026b5c14cedcmr2296289pjb.1.1693814270569; Mon, 04
 Sep 2023 00:57:50 -0700 (PDT)
Date:   Mon, 04 Sep 2023 00:57:50 -0700
In-Reply-To: <000000000000140b1405fce42c66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9b428060483dd86@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
From:   syzbot <syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=109d2577a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f06d04680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fdcd0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/218c4f124314/disk-bd6c11bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cedb31a3cb2e/vmlinux-bd6c11bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4aad3c744f9d/bzImage-bd6c11bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:777 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_del+0xb9/0x2d0 net/bluetooth/sco.c:195
Write of size 4 at addr ffff88802153c080 by task kworker/u5:1/4439

CPU: 0 PID: 4439 Comm: kworker/u5:1 Not tainted 6.5.0-syzkaller-03967-gbd6c11bc43c4 #0
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
 sco_connect_cfm+0x205/0xb70 net/bluetooth/sco.c:1361
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

Allocated by task 7402:
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
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xe3/0x3b0 net/bluetooth/sco.c:526
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

Freed by task 7403:
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
 sco_sock_kill net/bluetooth/sco.c:426 [inline]
 sco_sock_kill+0x19d/0x1c0 net/bluetooth/sco.c:416
 sco_sock_release+0x154/0x2c0 net/bluetooth/sco.c:1256
 __sock_release+0xae/0x260 net/socket.c:657
 sock_close+0x1c/0x20 net/socket.c:1399
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 ptrace_notify+0x10c/0x130 kernel/signal.c:2376
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x120/0x220 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xd/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 netlink_release+0xec0/0x20b0 net/netlink/af_netlink.c:831
 __sock_release+0xae/0x260 net/socket.c:657
 sock_close+0x1c/0x20 net/socket.c:1399
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802153c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff88802153c000, ffff88802153c800)

The buggy address belongs to the physical page:
page:ffffea0000854e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21538
head:ffffea0000854e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012842000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 41, tgid 41 (kworker/u4:2), ts 12651061992, free_ts 0
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
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1076
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 bsg_register_queue+0x52/0x410 block/bsg.c:195
 scsi_sysfs_add_sdev+0x295/0x540 drivers/scsi/scsi_sysfs.c:1436
 scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1815 [inline]
 scsi_finish_async_scan drivers/scsi/scsi_scan.c:1900 [inline]
 do_scan_async+0x21d/0x540 drivers/scsi/scsi_scan.c:1943
 async_run_entry_fn+0x9c/0x530 kernel/async.c:127
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802153bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802153c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802153c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802153c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802153c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
