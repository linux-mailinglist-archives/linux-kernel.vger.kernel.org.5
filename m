Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8C7EFDA0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 05:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjKREON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 23:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKREOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 23:14:11 -0500
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F878D72
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 20:14:07 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc56a9ece7so34590865ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 20:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700280846; x=1700885646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYvaKIPuh+7T1qLxGsI1FMZsggqrAPTABrNZZahI9aM=;
        b=ljjcdBK4qEPRRJZHqf3RuOrGEwmbOJMk/nh9xGf6EQY12ZUzSf7ZR/1QBOHTz7tvjh
         C4yeTr7v5lEPB+CUWppybboxC8i+E8U+Eqxaeha6vg/htl30qaHQMd9A15I77rPsGHVs
         CAbMDhWeybRa+vmVZucoBUs5lb1xj5Mk1RYzuKubvIMrR0PiszWKpGHb6d1df/FXM4Aa
         0iC63cpJwDTPvFtBcmiCfghfMEo0PA4ZTw3Map+i/QEUPsLTNS5qX1mc3DLm3JVNzxpe
         sU/6Th9eV2okvpC+bJLd6qvhTHH+3jERIl/td7rkXgIxKuRw/f48P5KQyR8jJsH58CBV
         CmUQ==
X-Gm-Message-State: AOJu0Yyq+gqt7dzzUhjHpWBQ/fzPYkBvwbnCl9nKOqg7svXWb5hc8cTd
        MbEAhSBPIEAMQ1C3pu8l3pKXbgQYfqVpVNBNuoWEr7OBe9W+
X-Google-Smtp-Source: AGHT+IFb5BSCSN18OhRJ7JJ4yMs3o8/RU2rUI+JyI0ZhzLS265dmZDqqx4IjbxpqXFtppFTH2KHReTND0TJwFZ/aO9Mtgh+2mzYf
MIME-Version: 1.0
X-Received: by 2002:a17:902:d2cf:b0:1cc:bb7f:bd60 with SMTP id
 n15-20020a170902d2cf00b001ccbb7fbd60mr435614plc.6.1700280845977; Fri, 17 Nov
 2023 20:14:05 -0800 (PST)
Date:   Fri, 17 Nov 2023 20:14:05 -0800
In-Reply-To: <tencent_85865BC99E2ECEEEDC4CA2A7CC46E912F006@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7d0c2060a657b2f@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_sock_timeout

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:777 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x64/0x25c net/bluetooth/sco.c:88
Write of size 4 at addr ffff0000db795080 by task kworker/0:3/6101

CPU: 0 PID: 6101 Comm: kworker/0:3 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events sco_sock_timeout
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
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sock_hold include/net/sock.h:777 [inline]
 sco_sock_timeout+0x64/0x25c net/bluetooth/sco.c:88
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

Allocated by task 6617:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0xcc/0x1b8 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 sk_prot_alloc+0xc4/0x1f0 net/core/sock.c:2090
 sk_alloc+0x44/0x3f4 net/core/sock.c:2143
 bt_sock_alloc+0x4c/0x32c net/bluetooth/af_bluetooth.c:148
 sco_sock_alloc net/bluetooth/sco.c:496 [inline]
 sco_sock_create+0xbc/0x31c net/bluetooth/sco.c:527
 bt_sock_create+0x14c/0x248 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x43c/0x884 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x134/0x340 net/socket.c:1708
 __do_sys_socket net/socket.c:1722 [inline]
 __se_sys_socket net/socket.c:1720 [inline]
 __arm64_sys_socket+0x7c/0x94 net/socket.c:1720
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Freed by task 6617:
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
 sk_prot_free net/core/sock.c:2126 [inline]
 __sk_destruct+0x4c0/0x770 net/core/sock.c:2218
 sk_destruct net/core/sock.c:2233 [inline]
 __sk_free+0x37c/0x4e8 net/core/sock.c:2244
 sk_free+0x60/0xc8 net/core/sock.c:2255
 sock_put include/net/sock.h:1989 [inline]
 sco_sock_kill+0xfc/0x1b4 net/bluetooth/sco.c:427
 sco_sock_release+0x1fc/0x2c0 net/bluetooth/sco.c:1257
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

The buggy address belongs to the object at ffff0000db795000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff0000db795000, ffff0000db795800)

The buggy address belongs to the physical page:
page:0000000058a39b68 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0000db797000 pfn:0x11b790
head:0000000058a39b68 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002000 ffff0000c0000948 fffffc0003359410
raw: ffff0000db797000 0000000000080006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000db794f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000db795000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000db795080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff0000db795100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000db795180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 6101 at lib/refcount.c:25 refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 6101 Comm: kworker/0:3 Tainted: G    B              6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events sco_sock_timeout
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
lr : refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
sp : ffff800096c47af0
x29: ffff800096c47af0 x28: 1fffe0001abfc00a x27: dfff800000000000
x26: ffff0000c1084008 x25: ffff0000d5fe0050 x24: ffff0001b418b500
x23: dfff800000000000 x22: 0000000000000000 x21: 0000000000000002
x20: ffff0000db795080 x19: ffff8000910a2000 x18: ffff800096c47800
x17: 0000000000000000 x16: ffff80008a6688c0 x15: 0000000000000001
x14: 1ffff00012d88e78 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : 345179c02a25c000
x8 : 345179c02a25c000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096c473d8 x4 : ffff80008e4210a0 x3 : ffff8000803639bc
x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sock_hold include/net/sock.h:777 [inline]
 sco_sock_timeout+0x19c/0x25c net/bluetooth/sco.c:88
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
irq event stamp: 5571
hardirqs last  enabled at (5571): [<ffff80008a719050>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (5571): [<ffff80008a719050>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (5570): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (5414): [<ffff800085cd6e40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (5414): [<ffff800085cd6e40>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
softirqs last  enabled at (5414): [<ffff800085cd6e40>] nsim_dev_trap_report_work+0x620/0x924 drivers/net/netdevsim/dev.c:850
softirqs last disabled at (5412): [<ffff800085cd6dbc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (5412): [<ffff800085cd6dbc>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:816 [inline]
softirqs last disabled at (5412): [<ffff800085cd6dbc>] nsim_dev_trap_report_work+0x59c/0x924 drivers/net/netdevsim/dev.c:850
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 6101 at lib/refcount.c:28 refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 6101 Comm: kworker/0:3 Tainted: G    B   W          6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events sco_sock_timeout
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
lr : refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
sp : ffff800096c47af0
x29: ffff800096c47af0 x28: 1fffe0001abfc00a x27: dfff800000000000
x26: ffff0000c1084008 x25: ffff0000d5fe0050 x24: ffff0001b418b500
x23: dfff800000000000 x22: 0000000000000000 x21: 0000000000000003
x20: ffff0000db795080 x19: ffff8000910a2000 x18: 1fffe0003682efce
x17: 0000000000000000 x16: ffff80008a71b1fc x15: 0000000000000001
x14: 1ffff00012d88eb0 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 345179c02a25c000
x8 : 345179c02a25c000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800096c473d8 x4 : ffff80008e4210a0 x3 : ffff800082b180c4
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 sock_put include/net/sock.h:1988 [inline]
 sco_sock_timeout+0x1b0/0x25c net/bluetooth/sco.c:100
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
irq event stamp: 5571
hardirqs last  enabled at (5571): [<ffff80008a719050>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (5571): [<ffff80008a719050>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (5570): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (5414): [<ffff800085cd6e40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (5414): [<ffff800085cd6e40>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
softirqs last  enabled at (5414): [<ffff800085cd6e40>] nsim_dev_trap_report_work+0x620/0x924 drivers/net/netdevsim/dev.c:850
softirqs last disabled at (5412): [<ffff800085cd6dbc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (5412): [<ffff800085cd6dbc>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:816 [inline]
softirqs last disabled at (5412): [<ffff800085cd6dbc>] nsim_dev_trap_report_work+0x59c/0x924 drivers/net/netdevsim/dev.c:850
---[ end trace 0000000000000000 ]---


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14336477680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139b4e48e80000

