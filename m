Return-Path: <linux-kernel+bounces-26507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E982E240
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38990B2209C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792341B580;
	Mon, 15 Jan 2024 21:43:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBA1B278
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-360c3346ecbso30647985ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355000; x=1705959800;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyWsy1liIDlshYEloKpGWSlNMfciIJ+pYgbmO/cdfCA=;
        b=F0oUInFHUp0405HgAV4aufkzIupz8z8tF/SoZmzwqNRI7g1WAFB0To3GU4Z5d1xnrp
         JdMEEXn/cAyfwJVlNDA29YfDkSnPA67jpmgWkbaNg7SZdEDS24Wym9DVIbInQuRWdnSV
         XndHE6I66KoqXn5xC5pLEn6yYstlQKrrXKLciYQjXJBudv7vsOjS/jnuKcq8DuDvsJbh
         gh619PziiS/1j7wW4UZQ174XIoYgGxovdmCVe5S05FyHQi9/d1C8ParWRPL2Hwr5TuAy
         /+mpTencGENt1eIZni6MITwSnRbD7YJ9HKDIkH4D15HY6kzChN0gSc22pampXiZa0yAv
         +Bpg==
X-Gm-Message-State: AOJu0YyOfjT5gon0/vYUXf5HvnDxMMVRogqp8zqSKaF/DR8JUnKZJIOP
	Ugb71Rvcg9b26tYqgHuz4LnxRSwqPRfDYLllqZNKHQC+3Sk+
X-Google-Smtp-Source: AGHT+IGieW3s1InTZOiRsy5DtyOrQsy6mFeNQ5y1Je/soDXpON8WLCfPjWFucNQRijwnesTrhcufMahCp+UEbtwH0XFOIj02U6HO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:360:968d:bfb9 with SMTP id
 h14-20020a92c26e000000b00360968dbfb9mr654110ild.5.1705355000344; Mon, 15 Jan
 2024 13:43:20 -0800 (PST)
Date: Mon, 15 Jan 2024 13:43:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002faa2060f02e766@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
From: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
To: andrew@lunn.ch, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, f.fainelli@gmail.com, hkallweit1@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, olteanv@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, syzkaller-bugs@googlegroups.com, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e7aeb78ab01 Merge tag 'net-next-6.8' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10959983e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec955e36bb239bd720f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a0cf5be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12995b33e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b783a4458502/disk-3e7aeb78.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc895babf000/vmlinux-3e7aeb78.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66d9e78e7b97/bzImage-3e7aeb78.xz

The issue was bisected to:

commit 02018c544ef113e980a2349eba89003d6f399d22
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Thu Dec 21 18:00:34 2023 +0000

    net: phy: Introduce ethernet link topology representation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13695313e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e95313e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17695313e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
Fixes: 02018c544ef1 ("net: phy: Introduce ethernet link topology representation")

==================================================================
BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
BUG: KASAN: slab-out-of-bounds in dsa_user_prechangeupper+0x3a/0x240 net/dsa/user.c:2868
Read of size 8 at addr ffff8880220c6c90 by task syz-executor394/5050

CPU: 0 PID: 5050 Comm: syz-executor394 Not tainted 6.7.0-syzkaller-04629-g3e7aeb78ab01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 dsa_user_to_port net/dsa/user.h:58 [inline]
 dsa_user_prechangeupper+0x3a/0x240 net/dsa/user.c:2868
 dsa_user_netdevice_event+0x1a37/0x2ab0 net/dsa/user.c:3332
 notifier_call_chain+0x18c/0x3b0 kernel/notifier.c:93
 __netdev_upper_dev_link+0x39d/0x670 net/core/dev.c:7748
 netdev_upper_dev_link+0x9e/0xe0 net/core/dev.c:7800
 macvlan_common_newlink+0x11c9/0x1930 drivers/net/macvlan.c:1539
 macvtap_newlink+0x154/0x1d0 drivers/net/macvtap.c:108
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f45cd265d09
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6d34da28 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f45cd2b33d3 RCX: 00007f45cd265d09
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 00007ffe6d34da50 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe6d34da60
R13: 00007f45cd2b3004 R14: 00007ffe6d34da4c R15: 0000000000000003
 </TASK>

Allocated by task 5050:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc_node+0x24e/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 kvzalloc include/linux/slab.h:736 [inline]
 alloc_netdev_mqs+0x9d/0xf80 net/core/dev.c:10826
 rtnl_create_link+0x2ea/0xc10 net/core/rtnetlink.c:3379
 rtnl_newlink_create net/core/rtnetlink.c:3505 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x141e/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x440/0x600 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0xf0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff8880220c6000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3216 bytes inside of
 allocated 3223-byte region [ffff8880220c6000, ffff8880220c6c97)

The buggy address belongs to the physical page:
page:ffffea0000883000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x220c0
head:ffffea0000883000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c4f500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4514, tgid 4514 (udevd), ts 18242520144, free_ts 18231141724
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13d0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node+0x2d2/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x202/0xd10 fs/seq_file.c:210
 call_read_iter include/linux/fs.h:2079 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x662/0x900 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free pid 4518 tgid 4518 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x959/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2453 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2922
 put_cpu_partial+0x17b/0x250 mm/slub.c:2997
 __slab_free+0x2fe/0x410 mm/slub.c:4166
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x6d/0xd0 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x1dd/0x490 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kernfs_fop_write_iter+0x15b/0x510 fs/kernfs/file.c:311
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x783/0xaf0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff8880220c6b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880220c6c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880220c6c80: 00 00 07 fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff8880220c6d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880220c6d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

