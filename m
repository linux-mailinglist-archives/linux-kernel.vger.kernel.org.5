Return-Path: <linux-kernel+bounces-21232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13A828C56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98238289FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE23D0BD;
	Tue,  9 Jan 2024 18:17:38 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787E3C070
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35ff5a2fb06so31147445ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824255; x=1705429055;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e//zebCdP1aM3VgfN4zB3VLlfO5wvvl+ARsfab1Q5tg=;
        b=VEBXlaG6ZZBbbrIYJ+5lXALkNN5RaL3NCapbLPN8vsu7wCcyxiv0ZWM7qCl5KMSRJx
         3rwble1VleqEXO4/M67Nf2MFg1lpzuOG3Dbvy7hXJFsuFwa2qv6BKMG4hIY6yCkZ2Hrs
         xPqm8Jh+1VlY/VNtnya8K2STKBbYc7t1YhF6J0DwI9aSiZH5rwG/iyOX0Q5dFWcLDrbd
         /zZDEoyFPiw6sQ+Vwk5/t6rETgzkhSqvoZ+EXAIEsZKC8dFn5bS8+P4CHdlrkUiM51zZ
         c0Nz+dLSxyX3zsMXAz6tJ+kqmtqMJwXh45ZmTpUSnJ8MGSH3eFmEbZQj46qCnSJKmbqr
         EgPw==
X-Gm-Message-State: AOJu0YwCX7K6AZcWUFdCbs9hzn8X9391R6Xhv/WCicqT4XJ5NUla46UI
	K4PcwgqS67NXlkNHGMRdArvrnTeC7DuifC7EWWvDzMfB2cWo
X-Google-Smtp-Source: AGHT+IFh57uvnCIoNa9lSgi848SBeP5GuHiYoTjGQTVlyCNAeuXRyXYcMe8feyUFtPSdh8lRgyBpHdXv4GGnzL/o3I/IVrQybraR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:360:620a:24eb with SMTP id
 i11-20020a056e02152b00b00360620a24ebmr803448ilu.4.1704824254839; Tue, 09 Jan
 2024 10:17:34 -0800 (PST)
Date: Tue, 09 Jan 2024 10:17:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d4255060e87545c@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_changeupper
From: syzbot <syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lixiaoyan@google.com, netdev@vger.kernel.org, 
	olteanv@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9fb3dc1e9af2 Merge branch 'phy-listing-link_topology-track..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11269ba5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=d81bcd883824180500c8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1267ba7ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151ed731e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08a6d58357f2/disk-9fb3dc1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/390509d5ee5f/vmlinux-9fb3dc1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7efcbce1f12/bzImage-9fb3dc1e.xz

The issue was bisected to:

commit 43a71cd66b9c0a4af3d15d8644359fde35bdbed0
Author: Coco Li <lixiaoyan@google.com>
Date:   Mon Dec 4 20:12:30 2023 +0000

    net-device: reorganize net_device fast path variables

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17832409e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14432409e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10432409e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com
Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")

==================================================================
BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
BUG: KASAN: slab-out-of-bounds in dsa_user_changeupper+0x61a/0x6e0 net/dsa/user.c:2809
Read of size 8 at addr ffff888015ebecf0 by task syz-executor278/5066

CPU: 1 PID: 5066 Comm: syz-executor278 Not tainted 6.7.0-rc6-syzkaller-01740-g9fb3dc1e9af2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 dsa_user_to_port net/dsa/user.h:58 [inline]
 dsa_user_changeupper+0x61a/0x6e0 net/dsa/user.c:2809
 dsa_user_netdevice_event+0xd04/0x3480 net/dsa/user.c:3345
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1967
 __netdev_upper_dev_link+0x439/0x850 net/core/dev.c:7760
 netdev_upper_dev_link+0x92/0xc0 net/core/dev.c:7801
 register_vlan_dev+0x396/0x940 net/8021q/vlan.c:183
 register_vlan_device net/8021q/vlan.c:277 [inline]
 vlan_ioctl_handler+0x8dd/0xa70 net/8021q/vlan.c:621
 sock_ioctl+0x4bd/0x6b0 net/socket.c:1303
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0a94e172e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeda224968 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffeda224b38 RCX: 00007f0a94e172e9
RDX: 0000000020000380 RSI: 0000000000008982 RDI: 0000000000000003
RBP: 00007f0a94e8a610 R08: 0000000000000000 R09: 00007ffeda224b38
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeda224b28 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node+0x5c/0x90 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:738 [inline]
 kvzalloc include/linux/slab.h:746 [inline]
 alloc_netdev_mqs+0xb3/0x1360 net/core/dev.c:10827
 dummy_init_one drivers/net/dummy.c:158 [inline]
 dummy_init_module+0xcf/0x1b0 drivers/net/dummy.c:184
 do_one_initcall+0x11c/0x650 init/main.c:1236
 do_initcall_level init/main.c:1298 [inline]
 do_initcalls init/main.c:1314 [inline]
 do_basic_setup init/main.c:1333 [inline]
 kernel_init_freeable+0x687/0xc10 init/main.c:1551
 kernel_init+0x1c/0x2a0 init/main.c:1441
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888015ebe000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3312 bytes inside of
 allocated 3319-byte region [ffff888015ebe000, ffff888015ebecf7)

The buggy address belongs to the physical page:
page:ffffea000057ae00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15eb8
head:ffffea000057ae00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff88801304f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 4608693968, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1544
 prep_new_page mm/page_alloc.c:1551 [inline]
 get_page_from_freelist+0xa28/0x3730 mm/page_alloc.c:3319
 __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4575
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2070
 ___slab_alloc+0x979/0x1500 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node+0x4c/0x90 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:738 [inline]
 kvzalloc include/linux/slab.h:746 [inline]
 alloc_netdev_mqs+0xb3/0x1360 net/core/dev.c:10827
 loopback_net_init+0x38/0x170 drivers/net/loopback.c:214
 ops_init+0xb9/0x650 net/core/net_namespace.c:136
 __register_pernet_operations net/core/net_namespace.c:1214 [inline]
 register_pernet_operations+0x34b/0x820 net/core/net_namespace.c:1283
 register_pernet_device+0x29/0x70 net/core/net_namespace.c:1370
 net_dev_init+0x7b1/0xaa0 net/core/dev.c:11747
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888015ebeb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888015ebec00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888015ebec80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07 fc
                                                             ^
 ffff888015ebed00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888015ebed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

