Return-Path: <linux-kernel+bounces-122053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82988F13D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4112C1F2EA85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAE153821;
	Wed, 27 Mar 2024 21:46:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751AF1534FA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575990; cv=none; b=KK19K5+AFds2PlBVqTuDSUD8lgtj6apE+kUsMnFiVThyZwk5Xq8aePg7Em3ibKHp98nh3Yq2pK3egARpMo27EiNq7DDFYt74sEL6MOZ2VSZScoYZaEHJr2L98y5H5PKrvi9unIFVWDdZYGYmP0Kwd9FZ0A5yogtbZ0ibXW/TyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575990; c=relaxed/simple;
	bh=M/9L1KyTs/npx1S4/HkyL0CDUFo1C0HBdSQodhTP4N8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LNAKZpA5+1nkljYlakJa637Fv7WnxvMam9oe/YUFwF5HeZroo4sgAlXIc26k8zmat+gho98FWgcd4U2/KnAo1LYQ5WTE/uP/bavKBchaqDF88uU/hnAxCaCrpd29WPDZGwv7bg+sxiatDcnOhWaYyZZxYION8Z3dmgqWdC3uz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso30187939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575987; x=1712180787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzi9zS6MHKsIeVXb9Xws83R+6MjQ5wF3Qk1/fvh0VZg=;
        b=r91+6WkCVfC/LEroa/uzK4ubLwrp2FIOcFyoj7S79IInYWDMSfSu+pcUUKJ7jX5WJL
         1YbEHgUhs9JHRGyRbAK3G5zyTL4jgFRgDaDb6qzFic7eoXYa02BqRZA/bo7+liJHAbzF
         WXFtLhIerbhTBV6LgaFUdMsi9r9cc7XOXibgAwUU2yYim+fhZqVnVf2LKXkGRUgAIdd4
         BWmqQ2gMS/x220rlXnKNbMe/6wXhcHXTRVUTa7Q6hz7wKiylL8ceZ07Oz3tKshznaUAV
         vLrjqR59IzlnGfc+GTC2Gr5kGg3ZFOqNq9kCSBj/erzh+69H7pL5dfzem/+XQAoryK5m
         hNng==
X-Forwarded-Encrypted: i=1; AJvYcCW30HPdwsthuQBWiOsAAwSkoQUewN6F3pLyATKx/SXiiYmTCS0c17vWVtIR8oDnqDK3wMO3ZpnEkbE8wTKHGJV5yZ2sIu6QutAeNrBD
X-Gm-Message-State: AOJu0Yz8muL6T/8P92V8Vi/B9CPn1ZWMVs8NU8As1XCI2S0ouyXf1vF0
	leRY2qVhJvx0d3rmrCnbuTzgKwjobRgSKTAry4NfBYOCgyFtTOaDHlqtNIocEpLrBsTnCdaubZn
	Rxeo5GZdPXv+E+weSc13/L7PdmMmE22meBEY36CGaWueAw7p4OOoyb7g=
X-Google-Smtp-Source: AGHT+IFKtBUTJRyd+4AwJNKYgyidA75De4UkktFZO/j9EpAbUf/dEHTfNhTxH1n5RbkUS5p8VJe04G1khoiR6fEn51TxfJ0133cN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2720:b0:47b:f666:f7e5 with SMTP id
 m32-20020a056638272000b0047bf666f7e5mr26990jav.6.1711575987742; Wed, 27 Mar
 2024 14:46:27 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:46:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1783b0614ab5634@google.com>
Subject: [syzbot] [openvswitch?] KASAN: slab-use-after-free Read in ovs_ct_exit
From: syzbot <syzbot+25f4f05818dda7aabaea@syzkaller.appspotmail.com>
To: davem@davemloft.net, dev@openvswitch.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, pshelar@ovn.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117d023a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=25f4f05818dda7aabaea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25f4f05818dda7aabaea@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ovs_ct_exit+0x102/0x200 net/openvswitch/conntrack.c:1994
Read of size 8 at addr ffff888023f74080 by task kworker/u8:3/50

CPU: 1 PID: 50 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ovs_ct_exit+0x102/0x200 net/openvswitch/conntrack.c:1994
 ovs_exit_net+0xee/0x7d0 net/openvswitch/datapath.c:2680
 ops_exit_list net/core/net_namespace.c:170 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:637
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 5482:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 ovs_ct_limit_set_zone_limit net/openvswitch/conntrack.c:1659 [inline]
 ovs_ct_limit_cmd_set+0x2f7/0xaf0 net/openvswitch/conntrack.c:1836
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5138:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free_freelist_hook mm/slub.c:2135 [inline]
 slab_free_bulk mm/slub.c:4293 [inline]
 kmem_cache_free_bulk+0x1f8/0x360 mm/slub.c:4507
 kfree_bulk include/linux/slab.h:545 [inline]
 kvfree_rcu_bulk+0x24b/0x4e0 kernel/rcu/tree.c:3033
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3207 [inline]
 kfree_rcu_monitor+0x8a4/0x1020 kernel/rcu/tree.c:3225
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 kvfree_call_rcu+0xfc/0x790 kernel/rcu/tree.c:3443
 ovs_ct_limit_exit net/openvswitch/conntrack.c:1598 [inline]
 ovs_ct_exit+0xed/0x200 net/openvswitch/conntrack.c:1994
 ovs_exit_net+0xee/0x7d0 net/openvswitch/datapath.c:2680
 ops_exit_list net/core/net_namespace.c:170 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:637
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff888023f74080
 which belongs to the cache kmalloc-cg-64 of size 64
The buggy address is located 0 bytes inside of
 freed 64-byte region [ffff888023f74080, ffff888023f740c0)

The buggy address belongs to the physical page:
page:ffffea00008fdd00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23f74
memcg:ffff88801e41d201
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c4da00 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001ffffffff ffff88801e41d201
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5482, tgid 5481 (syz-executor.3), ts 212870377595, free_ts 212211960458
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 ovs_ct_limit_set_zone_limit net/openvswitch/conntrack.c:1659 [inline]
 ovs_ct_limit_cmd_set+0x2f7/0xaf0 net/openvswitch/conntrack.c:1836
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
page last free pid 81 tgid 81 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x95d/0xa80 mm/page_alloc.c:2346
 free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
 shrink_folio_list+0x7f72/0x89e0 mm/vmscan.c:1488
 shrink_inactive_list mm/vmscan.c:1914 [inline]
 shrink_list mm/vmscan.c:2155 [inline]
 shrink_lruvec+0x16e3/0x2d40 mm/vmscan.c:5681
 shrink_node_memcgs mm/vmscan.c:5867 [inline]
 shrink_node+0x11a8/0x2960 mm/vmscan.c:5902
 kswapd_shrink_node mm/vmscan.c:6696 [inline]
 balance_pgdat mm/vmscan.c:6886 [inline]
 kswapd+0x1aac/0x2f50 mm/vmscan.c:7146
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Memory state around the buggy address:
 ffff888023f73f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023f74000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888023f74080: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff888023f74100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888023f74180: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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

