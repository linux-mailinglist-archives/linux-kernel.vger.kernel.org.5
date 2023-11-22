Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180877F4B75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjKVPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjKVPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:37 -0500
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0202130
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:43:25 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cc1397321fso86175145ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667805; x=1701272605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=waG/5+O/zx2kA6SEedS1bMAXL1Zr5koVLUlbk6mlw4I=;
        b=FK4xHMARIDefgINwoDbqCuiKYpGGdee+/S+npmdzLajlMmQB41xSSvVYh2Jvw8b46K
         P+LxgsDyLBvugIoJ92f82F792Fligh9/ZuoBfjUFSyUWqGpuQerE44H3cp2x+7P+rPWP
         G5ln+OY47c7N75nPy1fyiMc22XnUC7Fid+EX9vfXo2Xzh6W872V90QqWfvwhFg+su2Eq
         v0O3a1qeecHVeGqLT0zoRy9nB0FtAE0nYuqdNBLjnYii1ySX5Ip3AvZLgfMUU73qR78e
         xODW+AqTItCbkqASoA+hmQ346Kd3HAlIHzQip6qmjRsACqU6GwOIiBOusB93WIPeZVSS
         tctA==
X-Gm-Message-State: AOJu0Yyou5Oss1t9CgBiT+a60MaNV70TCTVmPRiPJpAFevpMJ8XFQDhF
        hV4Vkp488qGAwCQKmyL86k1wFFt0kpuA0sfd36KDvOiDK1Xl
X-Google-Smtp-Source: AGHT+IGl3Mc/G+M0NqtbGbw+dWGYiGHdoaTt5r/HDLcJnlfqHEeWM5f7BxAHMapCrg5PR6tijog2B4fMKdE6qCc8S29DPKepfiw7
MIME-Version: 1.0
X-Received: by 2002:a17:903:2352:b0:1cf:6910:3ba4 with SMTP id
 c18-20020a170903235200b001cf69103ba4mr667867plh.0.1700667804792; Wed, 22 Nov
 2023 07:43:24 -0800 (PST)
Date:   Wed, 22 Nov 2023 07:43:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062c5dc060abf9415@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1774144f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143ee4a0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c28ca0e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x114/0x75e8 kernel/locking/lockdep.c:5004
Read of size 8 at addr ffff0000d553e0b0 by task kworker/u5:3/6271

CPU: 1 PID: 6271 Comm: kworker/u5:3 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
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
 __lock_acquire+0x114/0x75e8 kernel/locking/lockdep.c:5004
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x48/0x60 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __lock_sock+0x170/0x2d4 net/core/sock.c:2960
 lock_sock_nested+0xa4/0x11c net/core/sock.c:3510
 lock_sock include/net/sock.h:1720 [inline]
 sco_conn_ready net/bluetooth/sco.c:1268 [inline]
 sco_connect_cfm+0x140/0x948 net/bluetooth/sco.c:1359
 hci_connect_cfm include/net/bluetooth/hci_core.h:1935 [inline]
 hci_conn_failed+0x17c/0x2c0 net/bluetooth/hci_conn.c:1251
 hci_abort_conn_sync+0x688/0xe38 net/bluetooth/hci_sync.c:5428
 abort_conn_sync+0x5c/0x8c net/bluetooth/hci_conn.c:2910
 hci_cmd_sync_work+0x1cc/0x34c net/bluetooth/hci_sync.c:306
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

Allocated by task 8151:
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

Freed by task 8151:
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

The buggy address belongs to the object at ffff0000d553e000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 176 bytes inside of
 freed 2048-byte region [ffff0000d553e000, ffff0000d553e800)

The buggy address belongs to the physical page:
page:0000000014f21d98 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x115538
head:0000000014f21d98 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d553df80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000d553e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000d553e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff0000d553e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d553e180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
