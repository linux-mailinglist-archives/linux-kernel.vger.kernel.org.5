Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84D7EDF88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjKPLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbjKPLUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:20:38 -0500
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71AA8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:20:34 -0800 (PST)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-27ff9e2ffdfso870599a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133634; x=1700738434;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STJBfb6y8nAQxIFtKPRb+3ytrs70YYgpQWXZM8NzfFY=;
        b=SXVPyQ83b7UOHlxfVxYtzq63bUviTaR4AueQUbzN54qQjjrbrqaAC5gd/6/+AIABwn
         cmb+bUKTdKv9TqjgpD8KqWsDCnPmb/uLuSpUKwF5dXYrRYNtOuXIUUlW5JyRYI+PNGTY
         5Yrz7z8/s4FvPhYyi81YMJ66ywxRrjLyxn1e2WM6sn/+d8dJM64XOAWzsN1oc76zbmwE
         v/S/UmoLwF1s/yvhdzzKb+d+VXIRuQ0CSrajQjl+eOTzNDex8PRHVgga7Y24uyNuq4vC
         h/HVz1evVGydiLFIVO3NRaWzuokomJFV37eax49uONv2tXPQExJadbGjqCt9P/IjxGYK
         mDEw==
X-Gm-Message-State: AOJu0YwVrWyxX1AMFzADmid8R08Gv2KTpp+FYK+5PzKrfmU2Q/NkWYmO
        tjHi/dDIHV/IQqAfE4xwFxQDZ3XzGlyGWWB8zsgh8NlsIS2o
X-Google-Smtp-Source: AGHT+IEMuFYDUcBxa10y514IqIUL2hY0Of6Qb8PSu4cHfa4LUsUYxDTKWa10ZxrueJk8+sHyW+OgTktoytEKEj5U4YxsaP0Zywf2
MIME-Version: 1.0
X-Received: by 2002:a17:90a:8995:b0:27d:c90:1718 with SMTP id
 v21-20020a17090a899500b0027d0c901718mr4513778pjn.7.1700133633851; Thu, 16 Nov
 2023 03:20:33 -0800 (PST)
Date:   Thu, 16 Nov 2023 03:20:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051098c060a4335da@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1126f190e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122a2560e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e08df680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:777 [inline]
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x64/0x25c net/bluetooth/sco.c:88
Write of size 4 at addr ffff0000dba59080 by task kworker/0:1/10

CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
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

Allocated by task 6180:
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
 sco_sock_alloc net/bluetooth/sco.c:495 [inline]
 sco_sock_create+0xbc/0x31c net/bluetooth/sco.c:526
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

Freed by task 6179:
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
 sco_sock_kill+0xfc/0x1b4 net/bluetooth/sco.c:426
 sco_sock_release+0x1fc/0x2c0 net/bluetooth/sco.c:1256
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

The buggy address belongs to the object at ffff0000dba59000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
 freed 2048-byte region [ffff0000dba59000, ffff0000dba59800)

The buggy address belongs to the physical page:
page:00000000f24a79df refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11ba58
head:00000000f24a79df order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000dba58f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000dba59000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000dba59080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff0000dba59100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000dba59180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 10 at lib/refcount.c:25 refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/0:1 Tainted: G    B              6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: events sco_sock_timeout
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
lr : refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
sp : ffff800092d57af0
x29: ffff800092d57af0 x28: 1fffe0001a9b5a4a x27: dfff800000000000
x26: ffff0000c1084008 x25: ffff0000d4dad250 x24: ffff0001b418b500
x23: dfff800000000000 x22: 0000000000000000 x21: 0000000000000002
x20: ffff0000dba59080 x19: ffff8000910a2000 x18: ffff800092d57800
x17: 0000000000000000 x16: ffff80008a71b23c x15: 0000000000000001
x14: 1ffff000125aaeb0 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000000000 x9 : c0b0806111008b00
x8 : c0b0806111008b00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800092d573d8 x4 : ffff80008e4210a0 x3 : ffff800082b180c4
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
irq event stamp: 29659
hardirqs last  enabled at (29659): [<ffff80008a719090>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (29659): [<ffff80008a719090>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (29658): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (19646): [<ffff800080021894>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (19646): [<ffff800080021894>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (19597): [<ffff80008002aadc>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 10 at lib/refcount.c:28 refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/0:1 Tainted: G    B   W          6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: events sco_sock_timeout
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
lr : refcount_warn_saturate+0x1c8/0x20c lib/refcount.c:28
sp : ffff800092d57af0
x29: ffff800092d57af0 x28: 1fffe0001a9b5a4a x27: dfff800000000000
x26: ffff0000c1084008 x25: ffff0000d4dad250 x24: ffff0001b418b500
x23: dfff800000000000 x22: 0000000000000000 x21: 0000000000000003
x20: ffff0000dba59080 x19: ffff8000910a2000 x18: ffff800092d57800
x17: 0000000000000000 x16: ffff80008a71b23c x15: 0000000000000001
x14: 1fffe0003682f032 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : c0b0806111008b00
x8 : c0b0806111008b00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800092d573d8 x4 : ffff80008e4210a0 x3 : ffff8000805a359c
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
irq event stamp: 29659
hardirqs last  enabled at (29659): [<ffff80008a719090>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (29659): [<ffff80008a719090>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (29658): [<ffff800080021724>] __do_softirq+0x950/0xd54 kernel/softirq.c:569
softirqs last  enabled at (19646): [<ffff800080021894>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (19646): [<ffff800080021894>] __do_softirq+0xac0/0xd54 kernel/softirq.c:582
softirqs last disabled at (19597): [<ffff80008002aadc>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
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
