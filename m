Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640167F56B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbjKWDGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:05:59 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A6CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:06:05 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc2786a8ebso5567835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700708765; x=1701313565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=200c6290dZp+30BqwPrDPhDmzVg8rqeRi5BvQYSeqH4=;
        b=jLdfOmDbvpK1+LO/GmmUScDhboWXwC2soMhb2CTvtJQt5Pg616h0YHgsx8y8ibo+YX
         EcDzs0Nb7Eve6t+zZa2i5p3PIrHjwGopS2A+UCKv2zyHWyVLgVxEOcZvnA2HFDUYP8/9
         2IRpJ4Hh9r77fg8q5HQhakXt/InvChYogQu7OicRUQyxDZ9DnyxnwbHB43JH44gNqEVv
         w5pafB1tMfY3gAT4C4SHNPv4rEcH3kU+8UsDtL9Uq+EJ+SssUjVpxoIpKSveU4clithU
         Maje8QjbeAQKJBg2v1/1kQQYQYdnxZbBx5vsQ74WZHczc2zvMCZMyZyS53RaeF8r0YQF
         98TQ==
X-Gm-Message-State: AOJu0YyvXFaKZ4R12xB1A6ciiotWxUgszfQkMB+aDI7v6FAGc7dHAUCk
        0FtdlyU337I0wb7uTcA+M8tfTaDQ3QmU4cisnREyggaZl/Io
X-Google-Smtp-Source: AGHT+IGOAw5qKRLiXKXZZMahIoemK6w9MZWc1Pkdv9xgGHhhlsKFZ7Zb8rPPQKCi3LBssFmhrm4Nv1Ja30JzegMmsOjPbamXjaMO
MIME-Version: 1.0
X-Received: by 2002:a17:902:f7c6:b0:1cf:6935:1f43 with SMTP id
 h6-20020a170902f7c600b001cf69351f43mr936254plw.13.1700708765479; Wed, 22 Nov
 2023 19:06:05 -0800 (PST)
Date:   Wed, 22 Nov 2023 19:06:05 -0800
In-Reply-To: <tencent_D3FF464CC98C2ED92ED18C9367E746E65206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d53b43060ac91d56@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in __sco_sock_close

==================================================================
BUG: KASAN: slab-use-after-free in sco_chan_del net/bluetooth/sco.c:170 [inline]
BUG: KASAN: slab-use-after-free in __sco_sock_close+0x274/0x788 net/bluetooth/sco.c:456
Read of size 8 at addr ffff0000c7299400 by task syz-executor661/9434

CPU: 1 PID: 9434 Comm: syz-executor661 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 sco_chan_del net/bluetooth/sco.c:170 [inline]
 __sco_sock_close+0x274/0x788 net/bluetooth/sco.c:456
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

Allocated by task 9431:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 kmalloc_trace+0x70/0x88 mm/slab_common.c:1122
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 sco_conn_add+0xc4/0x2cc net/bluetooth/sco.c:134
 sco_connect net/bluetooth/sco.c:274 [inline]
 sco_sock_connect+0x2a0/0x848 net/bluetooth/sco.c:593
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

Freed by task 6094:
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
 sco_conn_del+0x3b4/0x498 net/bluetooth/sco.c:210
 sco_connect_cfm+0xf0/0x948 net/bluetooth/sco.c:1363
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

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 kvfree_call_rcu+0xac/0x674 kernel/rcu/tree.c:3372
 drop_sysctl_table+0x2c8/0x410 fs/proc/proc_sysctl.c:1508
 drop_sysctl_table+0x2d8/0x410 fs/proc/proc_sysctl.c:1511
 unregister_sysctl_table+0x48/0x68 fs/proc/proc_sysctl.c:1529
 unregister_net_sysctl_table+0x20/0x30 net/sysctl_net.c:185
 mpls_dev_sysctl_unregister+0x88/0xc0 net/mpls/af_mpls.c:1447
 mpls_dev_notify+0x448/0x654 net/mpls/af_mpls.c:1659
 notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
 raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
 call_netdevice_notifiers_info net/core/dev.c:1995 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2033 [inline]
 call_netdevice_notifiers net/core/dev.c:2047 [inline]
 unregister_netdevice_many_notify+0xd44/0x17a8 net/core/dev.c:10967
 unregister_netdevice_many net/core/dev.c:11023 [inline]
 default_device_exit_batch+0x6c8/0x744 net/core/dev.c:11492
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x5dc/0x8d0 net/core/net_namespace.c:614
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

The buggy address belongs to the object at ffff0000c7299400
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes inside of
 freed 256-byte region [ffff0000c7299400, ffff0000c7299500)

The buggy address belongs to the physical page:
page:0000000073a3d90c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107298
head:0000000073a3d90c order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0001b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c7299300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c7299380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000c7299400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff0000c7299480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c7299500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10e32aa4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=60bfed6b415fbd1fbb87
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d17aa4e80000

