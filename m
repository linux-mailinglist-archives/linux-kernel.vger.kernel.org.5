Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068627F7661
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKXOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:36:01 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34006199B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:36:06 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bcefd3b248so2874321b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836565; x=1701441365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZJVgW6RX4qPN1uCxUZPu4huGP2oCUi/YdlbjPjHRsM=;
        b=aFsuz+1Wru6fXmn0Yamofcbxloz8rrsW09j+PVsAba/ExgrYGCNtVXikEBNe6C9Mx7
         6RXJxb/GU6xSK6zqJ8EwR352klQhSxm6UoLFEEV70V/Mvv/v146Vh7FvxUsRvTo6JqlV
         ktfkUna7jjshxnFy0RNUGHfL8R8yd807RyI6MSGIYlIXa+aYp0VIh8GsCdywNeEYPfLz
         KPynt5d+rMrZJSqNjDjZengZ1nd6A5310CqcmjDXOIXn4/PMFltcep6uoTrpfrGl2WOE
         Oy14jBwAIqOhTTQ3i2ROORpx6UCwuK80Bh0Gk+63Upos03udRHEsMlFVGKJjUoPmSlH0
         xURg==
X-Gm-Message-State: AOJu0YyeMSFwGUPaBbqH3a/HyTJkVooudh9TRcYCk/4r5gB6gbFiWX+u
        kRRPBrF/VCedinMIyQ/057+KRVt11CbygcK5MF8AFGtiz019
X-Google-Smtp-Source: AGHT+IGvkvLuE40AjnLPu8zd1tspDB+ucgkl/RmLnoO56WVjXIRF+CGOJP65KLXX5wQmyuznSoAHtSTvndi11FI+pcXV6FzAjqGH
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d83:b0:6c3:33c6:a4d3 with SMTP id
 fb3-20020a056a002d8300b006c333c6a4d3mr786429pfb.1.1700836565734; Fri, 24 Nov
 2023 06:36:05 -0800 (PST)
Date:   Fri, 24 Nov 2023 06:36:05 -0800
In-Reply-To: <tencent_8E3BCF900DCF25FA0DA212145DC45DDF1907@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000525c1c060ae6df15@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
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
KASAN: slab-use-after-free Read in hci_conn_unlink

Bluetooth: hci0: command 0x0409 tx timeout
==================================================================
BUG: KASAN: slab-use-after-free in hci_conn_unlink+0x3b0/0x490 net/bluetooth/hci_conn.c:1104
Read of size 8 at addr ffff0000c7cf4aa8 by task kworker/u5:1/5666

CPU: 1 PID: 5666 Comm: kworker/u5:1 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci0 hci_cmd_sync_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 hci_conn_unlink+0x3b0/0x490 net/bluetooth/hci_conn.c:1104
 hci_conn_del+0x5c/0xabc net/bluetooth/hci_conn.c:1118
 hci_conn_failed+0x204/0x2c0 net/bluetooth/hci_conn.c:1252
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

Allocated by task 6565:
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
 sco_sock_connect+0x264/0x808 net/bluetooth/sco.c:593
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

Freed by task 6565:
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
 __sco_sock_close+0x3b8/0x788 net/bluetooth/sco.c:448
 sco_sock_close net/bluetooth/sco.c:471 [inline]
 sco_sock_release+0xb4/0x2c0 net/bluetooth/sco.c:1248
 __sock_release net/socket.c:659 [inline]
 sock_close+0xa4/0x1e8 net/socket.c:1419
 __fput+0x324/0x7f8 fs/file_table.c:384
 ____fput+0x20/0x30 fs/file_table.c:412
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 get_signal+0x13f4/0x15ec kernel/signal.c:2668
 do_signal arch/arm64/kernel/signal.c:1249 [inline]
 do_notify_resume+0x3bc/0x393c arch/arm64/kernel/signal.c:1302
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:144 [inline]
 el0_svc+0x9c/0x158 arch/arm64/kernel/entry-common.c:679
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

The buggy address belongs to the object at ffff0000c7cf4000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2728 bytes inside of
 freed 4096-byte region [ffff0000c7cf4000, ffff0000c7cf5000)

The buggy address belongs to the physical page:
page:0000000058906251 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107cf0
head:0000000058906251 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c7cf4980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c7cf4a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000c7cf4a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff0000c7cf4b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c7cf4b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: 00000000bba7ac7f object type: timer_list hint: hci_conn_timeout+0x0/0x1e8 net/bluetooth/hci_conn.c:928
WARNING: CPU: 1 PID: 5666 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 5666 Comm: kworker/u5:1 Tainted: G    B              6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci0 hci_cmd_sync_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff80009e217430
x29: ffff80009e217430 x28: dfff800000000000 x27: ffff700013c42e94
x26: dfff800000000000 x25: dfff800000000000 x24: ffff0000c7cf4390
x23: ffff80008ad651a0 x22: ffff800089881d98 x21: ffff80008a89c360
x20: 0000000000000000 x19: ffff80008ad64cc0 x18: 1fffe000368333ce
x17: 0000000000000000 x16: ffff80008a668880 x15: 0000000000000001
x14: 1ffff00013c42da0 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 14bd4a4222856a00
x8 : 14bd4a4222856a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009e216d18 x4 : ffff80008e4210a0 x3 : ffff8000803639bc
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
 debug_object_assert_init+0x318/0x3c8 lib/debugobjects.c:941
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 __timer_delete+0xac/0x2f8 kernel/time/timer.c:1321
 timer_delete+0x24/0x34 kernel/time/timer.c:1361
 del_timer include/linux/timer.h:213 [inline]
 try_to_grab_pending+0x8c/0x618 kernel/workqueue.c:1564
 __cancel_work_timer+0x118/0x540 kernel/workqueue.c:3453
 cancel_delayed_work_sync+0x24/0x38 kernel/workqueue.c:3635
 hci_conn_del+0x64/0xabc net/bluetooth/hci_conn.c:1120
 hci_conn_failed+0x204/0x2c0 net/bluetooth/hci_conn.c:1252
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
irq event stamp: 3419
hardirqs last  enabled at (3419): [<ffff80008028e6c8>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1384 [inline]
hardirqs last  enabled at (3419): [<ffff80008028e6c8>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5134
hardirqs last disabled at (3418): [<ffff80008a7f1250>] __schedule+0x2b4/0x23b4 kernel/sched/core.c:6594
softirqs last  enabled at (3156): [<ffff8000888ace70>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (3156): [<ffff8000888ace70>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
softirqs last disabled at (3154): [<ffff8000888acd50>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (3154): [<ffff8000888acd50>] release_sock+0x3c/0x1b0 net/core/sock.c:3518
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: 00000000fd1f42ce object type: timer_list hint: hci_conn_auto_accept+0x0/0x58
WARNING: CPU: 1 PID: 5666 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 5666 Comm: kworker/u5:1 Tainted: G    B   W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci0 hci_cmd_sync_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff80009e217430
x29: ffff80009e217430 x28: dfff800000000000 x27: ffff700013c42e94
x26: ffff0000d6a8ae50 x25: dfff800000000000 x24: ffff0000c7cf4438
x23: ffff80008ad651a0 x22: ffff800089881f80 x21: ffff80008a89c360
x20: 0000000000000000 x19: ffff80008ad64cc0 x18: 1fffe000368333ce
x17: 0000000000000000 x16: ffff80008a71b1bc x15: 0000000000000001
x14: 1fffe00036833432 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 14bd4a4222856a00
x8 : 14bd4a4222856a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009e216d18 x4 : ffff80008e4210a0 x3 : ffff8000805a359c
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
 debug_object_assert_init+0x318/0x3c8 lib/debugobjects.c:941
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 __timer_delete+0xac/0x2f8 kernel/time/timer.c:1321
 timer_delete+0x24/0x34 kernel/time/timer.c:1361
 del_timer include/linux/timer.h:213 [inline]
 try_to_grab_pending+0x8c/0x618 kernel/workqueue.c:1564
 __cancel_work_timer+0x118/0x540 kernel/workqueue.c:3453
 cancel_delayed_work_sync+0x24/0x38 kernel/workqueue.c:3635
 hci_conn_del+0x6c/0xabc net/bluetooth/hci_conn.c:1121
 hci_conn_failed+0x204/0x2c0 net/bluetooth/hci_conn.c:1252
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
irq event stamp: 3419
hardirqs last  enabled at (3419): [<ffff80008028e6c8>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1384 [inline]
hardirqs last  enabled at (3419): [<ffff80008028e6c8>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5134
hardirqs last disabled at (3418): [<ffff80008a7f1250>] __schedule+0x2b4/0x23b4 kernel/sched/core.c:6594
softirqs last  enabled at (3156): [<ffff8000888ace70>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (3156): [<ffff8000888ace70>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
softirqs last disabled at (3154): [<ffff8000888acd50>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (3154): [<ffff8000888acd50>] release_sock+0x3c/0x1b0 net/core/sock.c:3518
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object: 000000000db4e74f object type: timer_list hint: hci_conn_idle+0x0/0x554 net/bluetooth/hci_conn.c:676
WARNING: CPU: 1 PID: 5666 at lib/debugobjects.c:517 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 1 PID: 5666 Comm: kworker/u5:1 Tainted: G    B   W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci0 hci_cmd_sync_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
lr : debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
sp : ffff80009e217430
x29: ffff80009e217430 x28: dfff800000000000 x27: ffff700013c42e94
x26: ffff0000d6a8ae50 x25: dfff800000000000 x24: ffff0000c7cf44e0
x23: ffff80008ad651a0 x22: ffff800089881fd8 x21: ffff80008a89c360
x20: 0000000000000000 x19: ffff80008ad64cc0 x18: 1fffe000368333ce
x17: 0000000000000000 x16: ffff80008a668880 x15: 0000000000000001
x14: 1ffff00013c42da0 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 14bd4a4222856a00
x8 : 14bd4a4222856a00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009e216d18 x4 : ffff80008e4210a0 x3 : ffff8000803639bc
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 debug_print_object+0x168/0x1e0 lib/debugobjects.c:514
 debug_object_assert_init+0x318/0x3c8 lib/debugobjects.c:941
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 __timer_delete+0xac/0x2f8 kernel/time/timer.c:1321
 timer_delete+0x24/0x34 kernel/time/timer.c:1361
 del_timer include/linux/timer.h:213 [inline]
 try_to_grab_pending+0x8c/0x618 kernel/workqueue.c:1564
 __cancel_work_timer+0x118/0x540 kernel/workqueue.c:3453
 cancel_delayed_work_sync+0x24/0x38 kernel/workqueue.c:3635
 hci_conn_del+0x74/0xabc net/bluetooth/hci_conn.c:1122
 hci_conn_failed+0x204/0x2c0 net/bluetooth/hci_conn.c:1252
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
irq event stamp: 3419
hardirqs last  enabled at (3419): [<ffff80008028e6c8>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1384 [inline]
hardirqs last  enabled at (3419): [<ffff80008028e6c8>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5134
hardirqs last disabled at (3418): [<ffff80008a7f1250>] __schedule+0x2b4/0x23b4 kernel/sched/core.c:6594
softirqs last  enabled at (3156): [<ffff8000888ace70>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (3156): [<ffff8000888ace70>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
softirqs last disabled at (3154): [<ffff8000888acd50>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (3154): [<ffff8000888acd50>] release_sock+0x3c/0x1b0 net/core/sock.c:3518
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address e0ec406f80000334
KASAN: maybe wild-memory-access in range [0x0766037c000019a0-0x0766037c000019a7]
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[e0ec406f80000334] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 5666 Comm: kworker/u5:1 Tainted: G    B   W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci0 hci_cmd_sync_work
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid_or_report+0x78/0x158 lib/list_debug.c:62
lr : __list_del_entry_valid_or_report+0x4c/0x158 lib/list_debug.c:50
sp : ffff80009e2178a0
x29: ffff80009e2178a0 x28: 0000000000000f00 x27: ffff0000d4e94000
x26: 1fffe00018f9e94e x25: 1fffe00018f9e807 x24: dfff800000000000
x23: ffff0000c7cf4338 x22: dfff800000000000 x21: 0766037c000019a5
x20: ffff0000dc7a22f0 x19: ffff0000c7cf4000 x18: 1fffe000368333ce
x17: 0000000000000000 x16: ffff800080515ce8 x15: ffff600018f9e857
x14: 1fffe00018f9e857 x13: 00000000000000fb x12: ffffffffffffffff
x11: 0000000000000000 x10: 0000000000000000 x9 : ffff80009285f2d0
x8 : 00ecc06f80000334 x7 : 0000000000000000 x6 : ffff8000888de614
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800082b8ce90
x2 : dead000000000122 x1 : 0000000000000008 x0 : 0000000000000000
Call trace:
 __list_del_entry_valid_or_report+0x78/0x158 lib/list_debug.c:62
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 hci_conn_hash_del include/net/bluetooth/hci_core.h:1029 [inline]
 hci_conn_cleanup net/bluetooth/hci_conn.c:154 [inline]
 hci_conn_del+0x3e0/0xabc net/bluetooth/hci_conn.c:1156
 hci_conn_failed+0x204/0x2c0 net/bluetooth/hci_conn.c:1252
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
Code: 91008902 eb0202bf 54000520 d343fea8 (38766908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	91008902 	add	x2, x8, #0x22
   4:	eb0202bf 	cmp	x21, x2
   8:	54000520 	b.eq	0xac  // b.none
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	38766908 	ldrb	w8, [x8, x22] <-- trapping instruction


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16147daf680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bfb1c8e80000

