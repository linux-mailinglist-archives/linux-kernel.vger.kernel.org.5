Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EA7EF2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjKQMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKQMjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:39:11 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72DE127
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:39:07 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1b9860846so2584991a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700224744; x=1700829544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4JAYv5XdZSYOsIenpfwcyzDihy/GNEmM87+RJI2yAA=;
        b=TmESeDTTYr256wlj+5CxH2VHEH1wU3GdonZbpw3F770UEgI/GNAI29muYwy2i7bE/Z
         f3Sk3E91G0G+XbO2xEDX+Ins3KjIx8pDKCILCGDZ78FY+pBqoYlvg/eC7SbREgALkl9M
         jdurM991fuwtg+BrHOaqsFfHWjtGL+wKnxg11KY0Q0S6OCHpuSnCFeXhsT9FDJtChMDn
         sG1JNWyPWdMz77sGsdEqsfjmImS7QCZcFrevk2AiICCrwYd3OM/V+4/jViDmdizav2sN
         ddbNuOllLYUalFCCfYi5inrKhARf62XQ9nzsSmsyit38bWydyrK0/M9Nrz8KpWR/9oxO
         UX6Q==
X-Gm-Message-State: AOJu0YwCRb+feJxw3jcSwnqMCpq0vu4fLtn0YYDEKGfCccxKg/74kdER
        7x5yXl/WI7XCqSa4FfEF4zrcElimLS8Hp3i7rcNt2ZJ9pXGd
X-Google-Smtp-Source: AGHT+IFlnqqKNyrq9FXy3R0xekaKvYU8JEzthTcXrzWnL5M3APhBbrONFnHvhMCJWn/O38MxmtxYi1D7tqTYUpuYt/m1whCIWPDj
MIME-Version: 1.0
X-Received: by 2002:a17:903:26d2:b0:1cc:4078:b036 with SMTP id
 jg18-20020a17090326d200b001cc4078b036mr2901795plb.6.1700224744244; Fri, 17
 Nov 2023 04:39:04 -0800 (PST)
Date:   Fri, 17 Nov 2023 04:39:04 -0800
In-Reply-To: <20231117121920.1599-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb4a9f060a586b64@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in hci_conn_drop

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop+0x34/0x2bc include/net/bluetooth/hci_core.h:1523
Write of size 4 at addr ffff0000c892c010 by task syz-executor.0/6752

CPU: 0 PID: 6752 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
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
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:443
 sco_sock_close net/bluetooth/sco.c:468 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1245
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

Allocated by task 6753:
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
 sco_connect net/bluetooth/sco.c:265 [inline]
 sco_sock_connect+0x270/0x8bc net/bluetooth/sco.c:590
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

Freed by task 5665:
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

The buggy address belongs to the object at ffff0000c892c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff0000c892c000, ffff0000c892d000)

The buggy address belongs to the physical page:
page:00000000c7691a02 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x108928
head:00000000c7691a02 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002140 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c892bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c892bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000c892c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff0000c892c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c892c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: 000000000c51268a object type: timer_list hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 0 PID: 6752 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 6752 Comm: syz-executor.0 Tainted: G    B              6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff800096f67790
x29: ffff800096f67790 x28: dfff800000000000 x27: ffff700012decf00
x26: dfff800000000000 x25: dfff800000000000 x24: ffff0000c892c390
x23: ffff80008ad651a0 x22: ffff800089881d98 x21: ffff80008a89c360
x20: 0000000000000000 x19: ffff80008ad64cc0 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a668980 x15: 0000000000000001
x14: 1ffff00012dece0c x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : c73071275ea21a00
x8 : c73071275ea21a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096f67078 x4 : ffff80008e4210a0 x3 : ffff8000803639bc
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
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:443
 sco_sock_close net/bluetooth/sco.c:468 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1245
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
irq event stamp: 15717
hardirqs last  enabled at (15717): [<ffff80008a719110>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (15717): [<ffff80008a719110>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (15716): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (15458): [<ffff8000888c272c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (15458): [<ffff8000888c272c>] lock_sock_nested+0xcc/0x11c net/core/sock.c:3512
softirqs last disabled at (15456): [<ffff8000888c26d4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (15456): [<ffff8000888c26d4>] lock_sock_nested+0x74/0x11c net/core/sock.c:3508
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6752 at kernel/workqueue.c:1939 __queue_delayed_work kernel/workqueue.c:1939 [inline]
WARNING: CPU: 0 PID: 6752 at kernel/workqueue.c:1939 queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
Modules linked in:
CPU: 0 PID: 6752 Comm: syz-executor.0 Tainted: G    B   W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_delayed_work kernel/workqueue.c:1939 [inline]
pc : queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
lr : __queue_delayed_work kernel/workqueue.c:1939 [inline]
lr : queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
sp : ffff800096f67af0
x29: ffff800096f67af0 x28: 1fffe0001a828d80 x27: dfff800000000000
x26: 0000000000000000 x25: ffff0000c892c3a8 x24: ffff0000cb635400
x23: 0000000000000000 x22: ffff0000c892c348 x21: 0000000000000008
x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a71b2bc x15: ffff600019125869
x14: 1fffe00019125869 x13: 00000000000000fb x12: ffffffffffffffff
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000d5f21bc0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080221e68
x2 : 0000000000000000 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 __queue_delayed_work kernel/workqueue.c:1939 [inline]
 queue_delayed_work_on+0x214/0x2e4 kernel/workqueue.c:1986
 queue_delayed_work include/linux/workqueue.h:569 [inline]
 hci_conn_drop+0x198/0x2bc include/net/bluetooth/hci_core.h:1549
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:443
 sco_sock_close net/bluetooth/sco.c:468 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1245
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
irq event stamp: 15717
hardirqs last  enabled at (15717): [<ffff80008a719110>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (15717): [<ffff80008a719110>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (15716): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (15458): [<ffff8000888c272c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (15458): [<ffff8000888c272c>] lock_sock_nested+0xcc/0x11c net/core/sock.c:3512
softirqs last disabled at (15456): [<ffff8000888c26d4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (15456): [<ffff8000888c26d4>] lock_sock_nested+0x74/0x11c net/core/sock.c:3508
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: activate not available (active state 0) object: 000000002ed6b31e object type: work_struct hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 0 PID: 6752 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 6752 Comm: syz-executor.0 Tainted: G    B   W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff800096f67870
x29: ffff800096f67870 x28: dfff800000000000 x27: ffff700012decf1c
x26: ffff0000e2130b78 x25: dfff800000000000 x24: ffff0000c892c348
x23: ffff80008ad651a0 x22: ffff800089881d98 x21: ffff80008a8710a0
x20: 0000000000000000 x19: ffff80008ad64c40 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a71b2bc x15: 0000000000000001
x14: 1fffe0003682f032 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000000000 x9 : c73071275ea21a00
x8 : c73071275ea21a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096f67158 x4 : ffff80008e4210a0 x3 : ffff8000805a359c
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
 __sco_sock_close+0x3a8/0x7b0 net/bluetooth/sco.c:443
 sco_sock_close net/bluetooth/sco.c:468 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1245
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
irq event stamp: 15717
hardirqs last  enabled at (15717): [<ffff80008a719110>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (15717): [<ffff80008a719110>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (15716): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (15458): [<ffff8000888c272c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (15458): [<ffff8000888c272c>] lock_sock_nested+0xcc/0x11c net/core/sock.c:3512
softirqs last disabled at (15456): [<ffff8000888c26d4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (15456): [<ffff8000888c26d4>] lock_sock_nested+0x74/0x11c net/core/sock.c:3508
---[ end trace 0000000000000000 ]---


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13ba3458e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150ac400e80000

