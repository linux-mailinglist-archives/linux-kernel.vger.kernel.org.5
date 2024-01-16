Return-Path: <linux-kernel+bounces-27497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1282F108
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB93D284753
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6258D1BF46;
	Tue, 16 Jan 2024 15:06:21 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD81BF3E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fe8c398a2so74606885ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705417578; x=1706022378;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ueR/mGXNbIRPUdbTUaYi0awLe7KrdLQ2QxAD8xcXjQc=;
        b=FUPFMohWx0+2hFN/r3NkHhpVFylJxWKeeUBnKaqAITB1q3/Ikdsa5IwImAbq/lmhP7
         b11gHntsVRiLh+7ejh/50zrRAMNhJnJ6Bfxgcy1qk/eV/9Rk8Jag11B8zw7RYIK9YQcI
         gxtVZPVpqSa2scfBu7a6gH91q/zpMZb/ytbHeNAW7NiKE0r9y+JCM9nm740o6aBdCo2g
         vJ3oTtjCqvaC9XgFIH/ctZMCh3h3G5SNWyXrxKKxLv5UQ1jhjonjcJgjgXvXoUPfu91T
         HJI6ZvG6SdaFbapbxT95D8KiBWOB5ZWiOwY2155IudA6P/3scz/7o1MMo6kxdbiHAMhI
         ncRQ==
X-Gm-Message-State: AOJu0YwI7FfFKGYEpgHrPDHwfwQTcAyur4FxmT8XVJAwc7oSFDwNl+mo
	XlZ8NF1qSbXO+vrvKddi27SGHlc00v0LfPrCJR7mkcMwYE5n
X-Google-Smtp-Source: AGHT+IG7cdz1kASGwxKYoA2iw+j1acNSX9bfcw4bEDrtHA3JhZ/hxCrkF6xvP5ZeHpYxO9AGoatSKSDHlrxGh5IlKBHnKFv601S9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:35f:f65e:c33 with SMTP id
 q2-20020a056e0220e200b0035ff65e0c33mr1243689ilv.4.1705417578361; Tue, 16 Jan
 2024 07:06:18 -0800 (PST)
Date: Tue, 16 Jan 2024 07:06:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3b90a060f1178f1@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in tty_write_room (2)
From: syzbot <syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0802e17d9aca Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=122e60b3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9616b7e180577ba
dashboard link: https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84e45f27a78/disk-0802e17d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b16d2fc3b1/vmlinux-0802e17d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c7ac36b3de1/Image-0802e17d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: slab-use-after-free in tty_write_room+0x3c/0x8c drivers/tty/tty_ioctl.c:68
Read of size 8 at addr ffff00011c808020 by task aoe_tx0/2217

CPU: 1 PID: 2217 Comm: aoe_tx0 Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 tty_write_room+0x3c/0x8c drivers/tty/tty_ioctl.c:68
 handle_tx+0x120/0x604 drivers/net/caif/caif_serial.c:226
 caif_xmit+0x108/0x150 drivers/net/caif/caif_serial.c:282
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x240/0x8ac net/core/dev.c:3564
 __dev_queue_xmit+0x1570/0x31d8 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 tx+0x90/0x134 drivers/block/aoe/aoenet.c:62
 kthread+0x1ac/0x374 drivers/block/aoe/aoecmd.c:1229
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

Allocated by task 12667:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 kmalloc_trace+0x70/0x88 mm/slab_common.c:1103
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_tty_struct+0xb8/0x684 drivers/tty/tty_io.c:3093
 tty_init_dev+0x60/0x3ec drivers/tty/tty_io.c:1411
 ptmx_open+0xfc/0x2d0 drivers/tty/pty.c:824
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:948
 vfs_open+0x7c/0x90 fs/open.c:1082
 do_open fs/namei.c:3622 [inline]
 path_openat+0x1f6c/0x2888 fs/namei.c:3779
 do_filp_open+0x1bc/0x3cc fs/namei.c:3809
 do_sys_openat2+0x124/0x1b8 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1463
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Freed by task 6202:
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
 kfree+0xb8/0x19c mm/slab_common.c:1056
 free_tty_struct drivers/tty/tty_io.c:174 [inline]
 release_one_tty+0x22c/0x24c drivers/tty/tty_io.c:1544
 process_one_work+0x694/0x1204 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2781
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 insert_work+0x54/0x2d4 kernel/workqueue.c:1647
 __queue_work+0xcb0/0x12bc kernel/workqueue.c:1796
 queue_work_on+0x9c/0x128 kernel/workqueue.c:1831
 queue_work include/linux/workqueue.h:562 [inline]
 schedule_work include/linux/workqueue.h:623 [inline]
 queue_release_one_tty drivers/tty/tty_io.c:1555 [inline]
 kref_put include/linux/kref.h:65 [inline]
 tty_kref_put+0x14c/0x1c0 drivers/tty/tty_io.c:1568
 release_tty+0x3f0/0x4ac drivers/tty/tty_io.c:1604
 tty_release_struct+0xb4/0xd4 drivers/tty/tty_io.c:1703
 tty_release+0xb64/0x1014 drivers/tty/tty_io.c:1863
 __fput+0x308/0x8e4 fs/file_table.c:394
 __fput_sync+0x60/0x9c fs/file_table.c:475
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __arm64_sys_close+0x150/0x1e0 fs/open.c:1572
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Second to last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 __call_rcu_common kernel/rcu/tree.c:2681 [inline]
 call_rcu+0x104/0xaf4 kernel/rcu/tree.c:2795
 in6_dev_finish_destroy+0x158/0x1d8 net/ipv6/addrconf_core.c:271
 in6_dev_put include/net/addrconf.h:388 [inline]
 addrconf_ifdown+0x152c/0x17c8 net/ipv6/addrconf.c:3960
 addrconf_notify+0x340/0xcf0
 notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
 raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
 call_netdevice_notifiers_info net/core/dev.c:1967 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2005 [inline]
 call_netdevice_notifiers net/core/dev.c:2019 [inline]
 unregister_netdevice_many_notify+0xd48/0x17b4 net/core/dev.c:11043
 unregister_netdevice_many net/core/dev.c:11099 [inline]
 unregister_netdevice_queue+0x2d8/0x324 net/core/dev.c:10979
 unregister_netdevice include/linux/netdevice.h:3158 [inline]
 ser_release+0x1a4/0x238 drivers/net/caif/caif_serial.c:310
 process_one_work+0x694/0x1204 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x970/0xef4 kernel/workqueue.c:2781
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

The buggy address belongs to the object at ffff00011c808000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 32 bytes inside of
 freed 2048-byte region [ffff00011c808000, ffff00011c808800)

The buggy address belongs to the physical page:
page:00000000a8975ac1 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15c808
head:00000000a8975ac1 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff0000c23ef981
anon flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c000f3c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff ffff0000c23ef981
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00011c807f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff00011c807f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff00011c808000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff00011c808080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00011c808100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

