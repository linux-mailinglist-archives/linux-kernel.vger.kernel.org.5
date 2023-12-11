Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3280CE97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjLKOk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjLKOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:40:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8167C3;
        Mon, 11 Dec 2023 06:40:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28865456abbso3185132a91.1;
        Mon, 11 Dec 2023 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702305647; x=1702910447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj4Nuclk1gPFaIGNaP/cUb9kJh+hwj0PcnpfH7mDqTM=;
        b=hkhZg+Ds6aaJbNMZ68i2xDlk0CLpiGJVIf3UcNQGLC/2SAUryFRFAVZW98noVPylAE
         seW4ve+8KbE7obCrKZ9AwGvsY+IeEANXtJKNbHn5W2WQnKsbIvHesqh7BSAzcnnql5/M
         GgPTbZs4YXNwH6lCDL+OBc8dXGyOIVmZPm1I0b0m/77Z+009fnAhaMIDD9bOQFy8pPX5
         OsZGrC3jtUnN5stWzamm9JT7mgwHLB4niv30PdsKxmIM452BNDO+Z0luDVmaw7RrUyQA
         A6lDeEANk6+sQfll8ccrmMpAIqCZajov9+CXitJxFjAZkdE07hzL1+bBDY0T2lc1b6/S
         bQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702305647; x=1702910447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj4Nuclk1gPFaIGNaP/cUb9kJh+hwj0PcnpfH7mDqTM=;
        b=aO3MZBGuwLU1SMgemXm9bhtZ/aE0uyhaxxUHM/tTKMFFOuHq/zoIyR5bAL26HGz1MY
         Jz+Cu7+lMEu7pHedvN7vqdjhN5HGPG6FZnF5pNz5tSPhyOmrgHssl0jQ6HBlVcCboj5f
         26sW+Whr06sZSIv4B802bR98uf7/t5viAa4LuiJySLM5l/4Oxo4jDscHf8eNqEMeCxEc
         ljCToO55jvVX9u0fTjjqqJKQhH2J3AJ6BE5eRe182f5XiWBkfLd9TcwKAOFvwE3olkgU
         Z8xyHNfhwfiq52Csfrms0daAlD6/WTglLFk2IYl9VmUIMss+HAHjxqf5RjHkotlu7/CI
         RQtw==
X-Gm-Message-State: AOJu0YzdrPhMo2071Qr0Ik8E1H3wqS014XQAOL3lZjMq5kVdKIw05EOx
        DK0aeYOb5yQMMgoK+T6W7BbXYwVNIW6jHWtdawotxw==
X-Google-Smtp-Source: AGHT+IFyKgcl+OBxJE5PQlML7tCiiGAyuQSNQUbj2xjhS+RxrxJCTf7P1Kjg0r1QUzjiRJEjmz+XOQ==
X-Received: by 2002:a17:90b:1916:b0:288:7113:bf with SMTP id mp22-20020a17090b191600b00288711300bfmr1854327pjb.30.1702305647183;
        Mon, 11 Dec 2023 06:40:47 -0800 (PST)
Received: from workstation.. ([183.159.169.26])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a018600b00285621515e9sm7770007pjc.15.2023.12.11.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:40:46 -0800 (PST)
From:   Chaoyuan Peng <hedonistsmith@gmail.com>
Cc:     hedonistsmith@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: Fix UAF in __sco_sock_close
Date:   Mon, 11 Dec 2023 22:40:37 +0800
Message-Id: <20231211144037.2039209-1-hedonistsmith@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __sco_sock_close(), the sco_conn_lock doesn't properly guard the access
to 'conn'. This leads to the UAF where __sco_sock_close() access the freed
'sco_pi(sk)->conn' which is destroyed by hci_abort_conn_sync() on another
thread.

Such is the case in the following call trace:

BUG: KASAN: slab-use-after-free in __sco_sock_close+0x2d7/0x6b0 net/bluetooth/sco.c:444
Write of size 4 at addr ffff88801c47a010 by task syz-executor402/10616

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xbe/0xf0 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xf0/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write ./include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test ./include/linux/atomic/atomic-instrumented.h:1375 [inline]
 hci_conn_drop ./include/net/bluetooth/hci_core.h:1523 [inline]
 __sco_sock_close+0x2d7/0x6b0 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0x7b/0x2d0 net/bluetooth/sco.c:1246
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x406/0xa70 fs/file_table.c:384
 __fput_sync+0x45/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x8b/0x110 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f338be5659b
Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 d3 eb 02 00 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 21 ec 02 00 8b 44
RSP: 002b:00007ffd1c844f50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f338be5659b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 0000000000000032 R08: 0000000000000000 R09: 000000000487598e
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f338bef32fc
R13: 00007ffd1c844fa0 R14: 00007ffd1c844fc0 R15: 00007f338be0a5f0
 </TASK>

Allocated by task 10619:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc ./include/linux/slab.h:599 [inline]
 kzalloc ./include/linux/slab.h:720 [inline]
 hci_conn_add+0xc2/0x1850 net/bluetooth/hci_conn.c:957
 hci_connect_sco+0x3bb/0x1050 net/bluetooth/hci_conn.c:1701
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2df/0xa90 net/bluetooth/sco.c:591
 __sys_connect_file+0x15f/0x1a0 net/socket.c:2050
 __sys_connect+0x165/0x1a0 net/socket.c:2067
 __do_sys_connect net/socket.c:2077 [inline]
 __se_sys_connect net/socket.c:2074 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 8146:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1c0 mm/kasan/common.c:200
 kasan_slab_free ./include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x95/0x1d0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2e0 mm/slub.c:3822
 device_release+0xa3/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put ./include/linux/kref.h:65 [inline]
 kobject_put+0x1a2/0x3e0 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3732
 hci_abort_conn_sync+0x566/0xde0 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x188/0x3a0 net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1c5/0x430 net/bluetooth/hci_sync.c:306
 process_one_work+0x876/0x15a0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x855/0x11f0 kernel/workqueue.c:2784
 kthread+0x346/0x450 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff88801c47a000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff88801c47a000, ffff88801c47b000)

The buggy address belongs to the physical page:
page:ffffea0000711e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c478
head:ffffea0000711e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012843040 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 6803836749, free_ts 0
 set_page_owner ./include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d8/0x350 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xf09/0x2c50 mm/page_alloc.c:3170
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4426
 alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2130
 alloc_pages+0x233/0x270 mm/mempolicy.c:2292
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x261/0x390 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0xbda/0x15e0 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x13a/0x350 mm/slub.c:3517
 kmalloc_node_trace+0x21/0xd0 mm/slab_common.c:1130
 kmalloc_node ./include/linux/slab.h:615 [inline]
 kzalloc_node ./include/linux/slab.h:731 [inline]
 bdi_alloc+0x47/0x180 mm/backing-dev.c:932
 __alloc_disk_node+0xa2/0x650 block/genhd.c:1337
 __blk_alloc_disk+0x37/0x90 block/genhd.c:1393
 brd_alloc.part.0+0x256/0x770 drivers/block/brd.c:338
 brd_alloc drivers/block/brd.c:458 [inline]
 brd_init+0x1b5/0x2a0 drivers/block/brd.c:425
 do_one_initcall+0x105/0x620 init/main.c:1232
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801c479f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801c479f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801c47a000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88801c47a080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801c47a100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Signed-off-by: Chaoyuan Peng <hedonistsmith@gmail.com>
---
 net/bluetooth/sco.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186ab..46e158bdd 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -296,6 +296,7 @@ static int sco_connect(struct sock *sk)
 		sco_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
+	hci_conn_get(hcon);
 	release_sock(sk);
 
 unlock:
@@ -438,12 +439,13 @@ static void __sco_sock_close(struct sock *sk)
 	case BT_CONNECTED:
 	case BT_CONFIG:
 		if (sco_pi(sk)->conn->hcon) {
+			struct hci_conn *hcon = sco_pi(sk)->conn->hcon;
 			sk->sk_state = BT_DISCONN;
 			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
 			sco_conn_lock(sco_pi(sk)->conn);
-			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
 			sco_conn_unlock(sco_pi(sk)->conn);
+			hci_conn_put(hcon);
 		} else
 			sco_chan_del(sk, ECONNRESET);
 		break;
-- 
2.34.1

