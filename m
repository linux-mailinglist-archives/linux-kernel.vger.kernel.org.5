Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131807DFC23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbjKBWBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBWBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:01:41 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1240192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:01:33 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6d31334793bso1778458a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698962493; x=1699567293;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx3a7ZTym/iC6XuG6alzOfzd8BG6bZuH2jZqKF7QRAQ=;
        b=IOTmN1G8AWrK3W29Cc7Ox4WxOg+ju5xV/VhtdwMLXi5SEUuHxLp27EJQT33dKDlTHW
         RVSb5EvhFPRo/JY3d3QW5ZpdpjyRW7/w84khwBP5BWuGMWOMBEG2mGCOlMvRAOZDDdMW
         KjQqUJBF7hz5ZPInfqLFxIKFbkViyET2qe4AlBhUolO8Xd02l5/c/cQ7eP12+2gjXUMN
         TFiR/pEdVeoEZgHkPmRR22gyyDjRMsWcp1bDAG4grgsomYYIpAtx1FFubqJraC8iEKFI
         QJ8VomHVAKnB4mQidcX5noWujaGrFznn9B7c+cNVD1xsxif8KMLe8NX2WzHTLEAUIQyW
         9sMg==
X-Gm-Message-State: AOJu0Yxx/1C3LqkFZOlXVHBMv+kFHCkShaOU1mCAcFqkHUOJeTIrqu1c
        B6Aks1CVm/MbBAI2QZZiVY3ZpLMNTtoxMY9MDNJA2l91reSu
X-Google-Smtp-Source: AGHT+IGLxq6SMPpSRq81yd78LZ9YdZMzH7io0NF2yqIFt1ydh6fUJUy712/aGDFeWePQdlWMTPoVC8ker7d4tnj7YfLgg0oC/Uh7
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b14:b0:3ae:21ca:9b7e with SMTP id
 bx20-20020a0568081b1400b003ae21ca9b7emr7774617oib.2.1698962493313; Thu, 02
 Nov 2023 15:01:33 -0700 (PDT)
Date:   Thu, 02 Nov 2023 15:01:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e69b5a06093287ec@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1091d76b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176a435f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop+0x34/0x2bc include/net/bluetooth/hci_core.h:1523
Write of size 4 at addr ffff0000d9518010 by task syz-executor.0/6125

CPU: 1 PID: 6125 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 kasan_check_range+0x254/0x294 mm/kasan/generic.c:187
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 hci_conn_drop+0x34/0x2bc include/net/bluetooth/hci_core.h:1523
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1246
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Allocated by task 6126:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 kmalloc_trace+0x70/0x88 mm/slab_common.c:1122
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hci_conn_add+0xcc/0x1210 net/bluetooth/hci_conn.c:957
 hci_connect_sco+0x94/0x2bc net/bluetooth/hci_conn.c:1701
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x278/0x840 net/bluetooth/sco.c:591
 __sys_connect_file net/socket.c:2050 [inline]
 __sys_connect+0x268/0x290 net/socket.c:2067
 __do_sys_connect net/socket.c:2077 [inline]
 __se_sys_connect net/socket.c:2074 [inline]
 __arm64_sys_connect+0x7c/0x94 net/socket.c:2074
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Freed by task 50:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_free_info+0x38/0x5c mm/kasan/generic.c:522
 ____kasan_slab_free+0x144/0x1c0 mm/kasan/common.c:236
 __kasan_slab_free+0x18/0x28 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x2ac/0x480 mm/slub.c:3822
 kfree+0xb8/0x19c mm/slab_common.c:1075
 bt_link_release+0x20/0x30 net/bluetooth/hci_sysfs.c:16
 device_release+0x8c/0x1ac
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c4/0x3c4 lib/kobject.c:733
 put_device+0x28/0x40 drivers/base/core.c:3732
 hci_conn_put include/net/bluetooth/hci_core.h:1506 [inline]
 hci_conn_cleanup net/bluetooth/hci_conn.c:178 [inline]
 hci_conn_del+0x78c/0xabc net/bluetooth/hci_conn.c:1156
 hci_conn_failed+0x204/0x2c0 net/bluetooth/hci_conn.c:1252
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

The buggy address belongs to the object at ffff0000d9518000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff0000d9518000, ffff0000d9519000)

The buggy address belongs to the physical page:
page:00000000c96e5067 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x119518
head:00000000c96e5067 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002140 fffffc0003653800 dead000000000002
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d9517f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d9517f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000d9518000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff0000d9518080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d9518100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: 00000000dac7e963 object type: timer_list hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 1 PID: 6125 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 6125 Comm: syz-executor.0 Tainted: G    B              6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff800096f57790
x29: ffff800096f57790 x28: dfff800000000000 x27: ffff700012deaf00
x26: dfff800000000000 x25: dfff800000000000 x24: ffff0000d9518390
x23: ffff80008ad651a0 x22: ffff800089881d98 x21: ffff80008a89c360
x20: 0000000000000000 x19: ffff80008ad64cc0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a71b23c x15: 0000000000000001
x14: 1ffff00012deae44 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : a121024982282a00
x8 : a121024982282a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096f57078 x4 : ffff80008e4210a0 x3 : ffff800082b180c4
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
 debug_object_assert_init+0x318/0x3c8 lib/debugobjects.c:941
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 __timer_delete+0xac/0x2f8 kernel/time/timer.c:1321
 timer_delete+0x24/0x34 kernel/time/timer.c:1361
 del_timer include/linux/timer.h:213 [inline]
 try_to_grab_pending+0x8c/0x618 kernel/workqueue.c:1564
 __cancel_work+0xb0/0x2a8 kernel/workqueue.c:3582
 cancel_delayed_work+0x24/0x38 kernel/workqueue.c:3620
 hci_conn_drop+0x150/0x2bc include/net/bluetooth/hci_core.h:1548
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1246
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 14297
hardirqs last  enabled at (14297): [<ffff80008a719090>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (14297): [<ffff80008a719090>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (14296): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (14076): [<ffff8000888c272c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (14076): [<ffff8000888c272c>] lock_sock_nested+0xcc/0x11c net/core/sock.c:3512
softirqs last disabled at (14074): [<ffff8000888c26d4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (14074): [<ffff8000888c26d4>] lock_sock_nested+0x74/0x11c net/core/sock.c:3508
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6125 at kernel/workqueue.c:1939 __queue_delayed_work kernel/workqueue.c:1939 [inline]
WARNING: CPU: 1 PID: 6125 at kernel/workqueue.c:1939 queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
Modules linked in:
CPU: 1 PID: 6125 Comm: syz-executor.0 Tainted: G    B   W          6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_delayed_work kernel/workqueue.c:1939 [inline]
pc : queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
lr : __queue_delayed_work kernel/workqueue.c:1939 [inline]
lr : queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
sp : ffff800096f57af0
x29: ffff800096f57af0 x28: 1fffe0001a4c9bc0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff0000d95183a8 x24: ffff0000d2033400
x23: 0000000000000000 x22: ffff0000d9518348 x21: 0000000000000008
x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a71b23c x15: ffff60001b2a3069
x14: 1fffe0001b2a3069 x13: 00000000000000fb x12: ffffffffffffffff
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d9588000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080221e68
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 __queue_delayed_work kernel/workqueue.c:1939 [inline]
 queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
 queue_delayed_work include/linux/workqueue.h:569 [inline]
 hci_conn_drop+0x198/0x2bc include/net/bluetooth/hci_core.h:1549
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1246
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 14297
hardirqs last  enabled at (14297): [<ffff80008a719090>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (14297): [<ffff80008a719090>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (14296): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (14076): [<ffff8000888c272c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (14076): [<ffff8000888c272c>] lock_sock_nested+0xcc/0x11c net/core/sock.c:3512
softirqs last disabled at (14074): [<ffff8000888c26d4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (14074): [<ffff8000888c26d4>] lock_sock_nested+0x74/0x11c net/core/sock.c:3508
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: activate not available (active state 0) object: 00000000d0bb0e1a object type: work_struct hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 1 PID: 6125 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 6125 Comm: syz-executor.0 Tainted: G    B   W          6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff800096f57870
x29: ffff800096f57870 x28: dfff800000000000 x27: ffff700012deaf1c
x26: ffff0000d11d01d8 x25: dfff800000000000 x24: ffff0000d9518348
x23: ffff80008ad651a0 x22: ffff800089881d98 x21: ffff80008a8710a0
x20: 0000000000000000 x19: ffff80008ad64c40 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a71b23c x15: 0000000000000001
x14: 1fffe00036833432 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000000000 x9 : a121024982282a00
x8 : a121024982282a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096f57158 x4 : ffff80008e4210a0 x3 : ffff8000805a359c
x2 : 0000000000000001 x1 : 0000000000000002 x0 : 0000000000000000
Call trace:
 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
 debug_object_activate+0x600/0x7e0 lib/debugobjects.c:760
 debug_work_activate kernel/workqueue.c:572 [inline]
 insert_work+0x4c/0x2d4 kernel/workqueue.c:1644
 __queue_work+0xcf4/0x1338 kernel/workqueue.c:1799
 __queue_delayed_work kernel/workqueue.c:1950 [inline]
 queue_delayed_work_on+0x1f4/0x2e4 kernel/workqueue.c:1986
 queue_delayed_work include/linux/workqueue.h:569 [inline]
 hci_conn_drop+0x198/0x2bc include/net/bluetooth/hci_core.h:1549
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1246
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 __fput_sync+0x60/0x9c fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1557
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 14297
hardirqs last  enabled at (14297): [<ffff80008a719090>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (14297): [<ffff80008a719090>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (14296): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (14076): [<ffff8000888c272c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (14076): [<ffff8000888c272c>] lock_sock_nested+0xcc/0x11c net/core/sock.c:3512
softirqs last disabled at (14074): [<ffff8000888c26d4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (14074): [<ffff8000888c26d4>] lock_sock_nested+0x74/0x11c net/core/sock.c:3508
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
