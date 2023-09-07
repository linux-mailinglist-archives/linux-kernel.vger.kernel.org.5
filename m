Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81C79735A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjIGPXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjIGPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:30 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465B10FF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:01 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-68a4175e8c3so1480671b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100121; x=1694704921;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETTpdSI14BQREpOUwYzQRF8PwciHKTs4Os9GJbbc4Qw=;
        b=LeB7Plg4CK3XVdz4Va75G69CupfX1Ml/wQQ1pMOkpAOOUx+xQktpEC3GZl4tYqNWnD
         YSfoXtUTc1pW+2PG4KLlJU2Y/EXfDMkYuLDPaRs5/5qikJ81RuALXAZO9Wrt0gzNz6Mc
         HLf8ZWsYSqiR+puFu533EtIuPIJMr+marf4+T78AvLmzo5VQGODcG1KRRyTCcUA85U0f
         9ACMgnLiQhZ7C1rrronlrfKt4f3VYgjWvMlJGfIaRGjl2Lu1ID/HUDX5myjX2cLPuyKt
         91Lo03Lg4o5pG+A2AFzbRGMGtkmAvupMXXeNvKFyHdGcm9UkUhbU1pi68QshJ8zYFhxE
         mdCg==
X-Gm-Message-State: AOJu0YxDZ7wJwXwQ8o+1ZHAYTuToENxMh2jvdtC43uO1ZSKK2LqsEyUo
        uxF0V5lvovHRA1MHct61oMasG1TTAGGxt4yFnUHgFQ9COlS4
X-Google-Smtp-Source: AGHT+IFu/VO3anqAQpp7eGZjr3Is/xRa1yxLsb0E3ZwUVpoXMXbTWTWMHX1ZtuWoRmZfaWIDgkA8U4Zqp4MVIL5z1axTqed+HI6E
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1d0f:b0:68e:351c:bf00 with SMTP id
 a15-20020a056a001d0f00b0068e351cbf00mr1161578pfx.4.1694100120421; Thu, 07 Sep
 2023 08:22:00 -0700 (PDT)
Date:   Thu, 07 Sep 2023 08:22:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e44e4a0604c66b67@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in team_device_event
From:   syzbot <syzbot+44ae022028805f4600fc@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, davem@davemloft.net, edumazet@google.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8fdd54ee6a1 Merge branch 'sja1105-fixes'
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15476748680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=44ae022028805f4600fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12838914680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e54dc680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e90dbfb0a87/disk-f8fdd54e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca3cbcaceef2/vmlinux-f8fdd54e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a57b5f1bd614/bzImage-f8fdd54e.xz

The issue was bisected to:

commit 39285e124edbc752331e98ace37cc141a6a3747a
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Tue Sep 5 08:46:10 2023 +0000

    net: team: do not use dynamic lockdep key

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f177f4680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f177f4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f177f4680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44ae022028805f4600fc@syzkaller.appspotmail.com
Fixes: 39285e124edb ("net: team: do not use dynamic lockdep key")

8021q: adding VLAN 0 to HW filter on device bond1
==================================================================
BUG: KASAN: slab-out-of-bounds in team_device_event+0xa3b/0xad0 drivers/net/team/team.c:3021
Read of size 8 at addr ffff888143fdc1a8 by task syz-executor133/5151

CPU: 0 PID: 5151 Comm: syz-executor133 Not tainted 6.5.0-syzkaller-04043-gf8fdd54ee6a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 team_device_event+0xa3b/0xad0 drivers/net/team/team.c:3021
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 netdev_features_change net/core/dev.c:1333 [inline]
 netdev_update_features net/core/dev.c:9874 [inline]
 netdev_update_features net/core/dev.c:9871 [inline]
 dev_disable_lro+0x224/0x3e0 net/core/dev.c:1606
 team_port_add drivers/net/team/team.c:1248 [inline]
 team_add_slave+0x1a4d/0x2310 drivers/net/team/team.c:1977
 do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2674
 do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2873
 __rtnl_newlink+0xc1d/0x1940 net/core/rtnetlink.c:3671
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6444
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2539
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2593
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2622
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff3deaf85d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3e202a18 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff3deaf85d9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5151:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc_node_track_caller+0x5e/0x100 mm/slab_common.c:1005
 kstrdup+0x3c/0x70 mm/util.c:62
 kstrdup_const+0x5f/0x70 mm/util.c:85
 __kernfs_new_node+0x9c/0x8a0 fs/kernfs/dir.c:607
 kernfs_new_node+0x94/0x110 fs/kernfs/dir.c:675
 kernfs_create_link+0xcc/0x230 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x90/0x140 fs/sysfs/symlink.c:44
 sysfs_do_create_link fs/sysfs/symlink.c:80 [inline]
 sysfs_create_link+0x61/0xc0 fs/sysfs/symlink.c:92
 netdev_adjacent_sysfs_add net/core/dev.c:7481 [inline]
 __netdev_adjacent_dev_insert+0x751/0xb40 net/core/dev.c:7537
 __netdev_adjacent_dev_link_lists net/core/dev.c:7619 [inline]
 __netdev_adjacent_dev_link_neighbour net/core/dev.c:7643 [inline]
 __netdev_upper_dev_link+0x410/0x840 net/core/dev.c:7703
 netdev_upper_dev_link+0x92/0xc0 net/core/dev.c:7749
 macsec_newlink+0x800/0x1a30 drivers/net/macsec.c:4087
 rtnl_newlink_create net/core/rtnetlink.c:3485 [inline]
 __rtnl_newlink+0x1177/0x1940 net/core/rtnetlink.c:3705
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6444
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2539
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2593
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2622
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888143fdc1a0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 8 bytes inside of
 allocated 12-byte region [ffff888143fdc1a0, ffff888143fdc1ac)

The buggy address belongs to the physical page:
page:ffffea00050ff700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x143fdc
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000200 ffff8880128413c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 10509138456, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
 alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2131
 alloc_pages+0x22a/0x270 mm/mempolicy.c:2293
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node_track_caller+0x4d/0x100 mm/slab_common.c:1005
 kstrdup+0x3c/0x70 mm/util.c:62
 kstrdup_const+0x5f/0x70 mm/util.c:85
 __kernfs_new_node+0x9c/0x8a0 fs/kernfs/dir.c:607
 kernfs_new_node fs/kernfs/dir.c:675 [inline]
 kernfs_create_dir_ns+0x9a/0x210 fs/kernfs/dir.c:1036
 sysfs_create_dir_ns+0x13b/0x2a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:65 [inline]
 kobject_add_internal+0x2c8/0x990 lib/kobject.c:233
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888143fdc080: 00 04 fc fc fb fb fc fc fb fb fc fc fb fb fc fc
 ffff888143fdc100: 00 04 fc fc 00 04 fc fc 00 00 fc fc 00 00 fc fc
>ffff888143fdc180: 00 00 fc fc 00 04 fc fc 00 07 fc fc 00 04 fc fc
                                  ^
 ffff888143fdc200: 00 04 fc fc 00 04 fc fc 00 00 fc fc 00 00 fc fc
 ffff888143fdc280: fa fb fc fc fa fb fc fc 00 00 fc fc 00 07 fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
