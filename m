Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05357F87A0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjKYB6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKYB55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:57:57 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8F10CB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:58:04 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc41aed6a5so27579475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700877484; x=1701482284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USxv0c/Bndugu+4KcUqTKT2Cl+GWCo4IQ8I082M7y4Y=;
        b=YzZdu0NtPW0UuJ/FyWwr01HayBhdTp2oivZac7fnVOz71oC7YaP0GVeo8iYJJrsCZE
         pRbChsodblc9Q+hJFZH+PRCAyoZntmOPkxMw0wc/puUyjhGyBlD5+Eq3vv0PSdKI1/zW
         8+4ITOxDxFvsTW2BhPLeQ4F9dUNyHwpZvIwJcKMwiyjgD72IJpd4papxBcTekninfMOP
         MRpmlRKSFouSJk1fw5vd4KPH25M6YGbHScXrhxAbgTM3avQcZ8Q0ufn/V8JUA0zlJyn9
         E1rDjhQFCDCmoVp+C2JUhB9gi0AGYyIWVZimqV5dOw6TsHKw0EVbHYBphRzd1Ibjy9//
         QCfg==
X-Gm-Message-State: AOJu0Yw0w44pzmW4AmWs3wpdTb8wuNURX2JWCpbvdmsHJw+KP0Xp7ps5
        3iT8fUTzLSkacPP7wUK3wG4/HE3vZFumJ03OkKylnMhvGGIr
X-Google-Smtp-Source: AGHT+IEeggf7uoamZIG+nkm6FM6Opwbu/0mZnlUirMDga0nrkI4qIRR6OTm124Uei/sH992AtnN5ZUId5DEzFOP2d1ZgMp+LS5V8
MIME-Version: 1.0
X-Received: by 2002:a17:903:2308:b0:1cf:6910:3ba4 with SMTP id
 d8-20020a170903230800b001cf69103ba4mr1016377plh.0.1700877483810; Fri, 24 Nov
 2023 17:58:03 -0800 (PST)
Date:   Fri, 24 Nov 2023 17:58:03 -0800
In-Reply-To: <tencent_10DE52D4065BC98B6EC92ECCCCB3E7C34606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003aa603060af06631@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in __lock_sock

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x114/0x75e8 kernel/locking/lockdep.c:5004
Read of size 8 at addr ffff0000ce5ce0b0 by task kworker/u5:0/51

CPU: 1 PID: 51 Comm: kworker/u5:0 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: hci1 hci_cmd_sync_work
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
 sco_conn_ready net/bluetooth/sco.c:1272 [inline]
 sco_connect_cfm+0x140/0x948 net/bluetooth/sco.c:1363
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

Allocated by task 8236:
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
 sco_sock_alloc net/bluetooth/sco.c:499 [inline]
 sco_sock_create+0xbc/0x31c net/bluetooth/sco.c:530
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

Freed by task 8236:
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
 sco_sock_kill+0xfc/0x1b4 net/bluetooth/sco.c:429
 sco_sock_release+0x1fc/0x2c0 net/bluetooth/sco.c:1260
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

The buggy address belongs to the object at ffff0000ce5ce000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 176 bytes inside of
 freed 2048-byte region [ffff0000ce5ce000, ffff0000ce5ce800)

The buggy address belongs to the physical page:
page:00000000b6dddcc6 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10e5c8
head:00000000b6dddcc6 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0002000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000ce5cdf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000ce5ce000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000ce5ce080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff0000ce5ce100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000ce5ce180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Bluetooth: hci1: command 0x0409 tx timeout
Bluetooth: hci1: command 0x040f tx timeout


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=113dcbcce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1451e294e80000

