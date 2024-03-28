Return-Path: <linux-kernel+bounces-102194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A0787AF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED7E1C221FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C619D9C8;
	Wed, 13 Mar 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8wxvAyC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BB60EDB;
	Wed, 13 Mar 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349488; cv=none; b=hqa6CKvAzGFM84a9yO5bGTvxs+IV9UZwQ822gLAOumoi5kNsMR2fA+BM5589/zWf/NejOuFaud/8YcwZpPP7Ski07n6rG2RZFv+ybuq+q2fOFYs7rVN0rUTaJ+ev9ZR2JzcN1BB5pVMLc+PMoe6/Zc4QIGjrdVunGR9D+d7NSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349488; c=relaxed/simple;
	bh=+11ew/xhydcSMp0idrATwrTrCc6oG/fJPmdoTky8UPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnO9/TG6iEieoDBjoGVCY15FOYc/0N4OPSqET/NcQhHV6sABuKMTMsfI3isWca5wbPEw8qa6/aRqGL0nPqRnNLDVobq9MBAV9vB1XWoxPPoIpyuLvZO3Zh8ASHqN0ypdiVjFiEQuj1pgZ2SuW79Za6XVVmknuxSSNM4OLSfy2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8wxvAyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF18DC43399;
	Wed, 13 Mar 2024 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349488;
	bh=+11ew/xhydcSMp0idrATwrTrCc6oG/fJPmdoTky8UPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8wxvAyCRpZIHs8N5c8NrZzs0nOtbdxsqY2nEWRMyMEviycSV+RlBukSsW+bNFR7j
	 wuorJsvbxh5iR6OYV/0mVXASqtBuqSS5yyMsOVfnZe++aiIOY9EPTJLqf+6DHqlfsN
	 LNfejafDExmKBnmWzYhrtmDGjrWSgOz3um3Cv9NsjLRdS17LamVpmW0qEYkNyTQg9s
	 FuzYMMqGiOZ2dHKydeAcu+ZedIFdykaF+iwR3jx1U87Dl6uNX1ziC6B+DDwpzNZV3/
	 +QVjuQ/TPi9ZHiiI9fkPlk0puKg23skIPThekGjUqYfWRmoQzcN3i4vfpSB1jf67u8
	 qLuU+0gA5Iueg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/41] net/ipv6: avoid possible UAF in ip6_route_mpath_notify()
Date: Wed, 13 Mar 2024 13:04:03 -0400
Message-ID: <20240313170435.616724-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 685f7d531264599b3f167f1e94bbd22f120e5fab ]

syzbot found another use-after-free in ip6_route_mpath_notify() [1]

Commit f7225172f25a ("net/ipv6: prevent use after free in
ip6_route_mpath_notify") was not able to fix the root cause.

We need to defer the fib6_info_release() calls after
ip6_route_mpath_notify(), in the cleanup phase.

[1]
BUG: KASAN: slab-use-after-free in rt6_fill_node+0x1460/0x1ac0
Read of size 4 at addr ffff88809a07fc64 by task syz-executor.2/23037

CPU: 0 PID: 23037 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-01035-gea7f3cfaa588 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x167/0x540 mm/kasan/report.c:488
  kasan_report+0x142/0x180 mm/kasan/report.c:601
 rt6_fill_node+0x1460/0x1ac0
  inet6_rt_notify+0x13b/0x290 net/ipv6/route.c:6184
  ip6_route_mpath_notify net/ipv6/route.c:5198 [inline]
  ip6_route_multipath_add net/ipv6/route.c:5404 [inline]
  inet6_rtm_newroute+0x1d0f/0x2300 net/ipv6/route.c:5517
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6597
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f73dd87dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73de6550c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f73dd9ac050 RCX: 00007f73dd87dda9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f73dd8ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f73dd9ac050 R15: 00007ffdbdeb7858
 </TASK>

Allocated by task 23037:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
  kasan_kmalloc include/linux/kasan.h:211 [inline]
  __do_kmalloc_node mm/slub.c:3981 [inline]
  __kmalloc+0x22e/0x490 mm/slub.c:3994
  kmalloc include/linux/slab.h:594 [inline]
  kzalloc include/linux/slab.h:711 [inline]
  fib6_info_alloc+0x2e/0xf0 net/ipv6/ip6_fib.c:155
  ip6_route_info_create+0x445/0x12b0 net/ipv6/route.c:3758
  ip6_route_multipath_add net/ipv6/route.c:5298 [inline]
  inet6_rtm_newroute+0x744/0x2300 net/ipv6/route.c:5517
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6597
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 16:
  kasan_save_stack mm/kasan/common.c:47 [inline]
  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
  kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
  poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
  __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
  kasan_slab_free include/linux/kasan.h:184 [inline]
  slab_free_hook mm/slub.c:2121 [inline]
  slab_free mm/slub.c:4299 [inline]
  kfree+0x14a/0x380 mm/slub.c:4409
  rcu_do_batch kernel/rcu/tree.c:2190 [inline]
  rcu_core+0xd76/0x1810 kernel/rcu/tree.c:2465
  __do_softirq+0x2bb/0x942 kernel/softirq.c:553

Last potentially related work creation:
  kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
  __kasan_record_aux_stack+0xae/0x100 mm/kasan/generic.c:586
  __call_rcu_common kernel/rcu/tree.c:2715 [inline]
  call_rcu+0x167/0xa80 kernel/rcu/tree.c:2829
  fib6_info_release include/net/ip6_fib.h:341 [inline]
  ip6_route_multipath_add net/ipv6/route.c:5344 [inline]
  inet6_rtm_newroute+0x114d/0x2300 net/ipv6/route.c:5517
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6597
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff88809a07fc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 100 bytes inside of
 freed 512-byte region [ffff88809a07fc00, ffff88809a07fe00)

The buggy address belongs to the physical page:
page:ffffea0002681f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9a07c
head:ffffea0002681f00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c41c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 23028, tgid 23027 (syz-executor.4), ts 2340253595219, free_ts 2339107097036
  set_page_owner include/linux/page_owner.h:31 [inline]
  post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
  prep_new_page mm/page_alloc.c:1540 [inline]
  get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
  __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
  __alloc_pages_node include/linux/gfp.h:238 [inline]
  alloc_pages_node include/linux/gfp.h:261 [inline]
  alloc_slab_page+0x5f/0x160 mm/slub.c:2190
  allocate_slab mm/slub.c:2354 [inline]
  new_slab+0x84/0x2f0 mm/slub.c:2407
  ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
  __slab_alloc mm/slub.c:3625 [inline]
  __slab_alloc_node mm/slub.c:3678 [inline]
  slab_alloc_node mm/slub.c:3850 [inline]
  __do_kmalloc_node mm/slub.c:3980 [inline]
  __kmalloc+0x2e0/0x490 mm/slub.c:3994
  kmalloc include/linux/slab.h:594 [inline]
  kzalloc include/linux/slab.h:711 [inline]
  new_dir fs/proc/proc_sysctl.c:956 [inline]
  get_subdir fs/proc/proc_sysctl.c:1000 [inline]
  sysctl_mkdir_p fs/proc/proc_sysctl.c:1295 [inline]
  __register_sysctl_table+0xb30/0x1440 fs/proc/proc_sysctl.c:1376
  neigh_sysctl_register+0x416/0x500 net/core/neighbour.c:3859
  devinet_sysctl_register+0xaf/0x1f0 net/ipv4/devinet.c:2644
  inetdev_init+0x296/0x4d0 net/ipv4/devinet.c:286
  inetdev_event+0x338/0x15c0 net/ipv4/devinet.c:1555
  notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
  call_netdevice_notifiers_extack net/core/dev.c:1987 [inline]
  call_netdevice_notifiers net/core/dev.c:2001 [inline]
  register_netdevice+0x15b2/0x1a20 net/core/dev.c:10340
  br_dev_newlink+0x27/0x100 net/bridge/br_netlink.c:1563
  rtnl_newlink_create net/core/rtnetlink.c:3497 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
  rtnl_newlink+0x158f/0x20a0 net/core/rtnetlink.c:3730
page last free pid 11583 tgid 11583 stack trace:
  reset_page_owner include/linux/page_owner.h:24 [inline]
  free_pages_prepare mm/page_alloc.c:1140 [inline]
  free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
  free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
  kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:415
  apply_to_pte_range mm/memory.c:2619 [inline]
  apply_to_pmd_range mm/memory.c:2663 [inline]
  apply_to_pud_range mm/memory.c:2699 [inline]
  apply_to_p4d_range mm/memory.c:2735 [inline]
  __apply_to_page_range+0x8ec/0xe40 mm/memory.c:2769
  kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:532
  __purge_vmap_area_lazy+0x163f/0x1a10 mm/vmalloc.c:1770
  drain_vmap_area_work+0x40/0xd0 mm/vmalloc.c:1804
  process_one_work kernel/workqueue.c:2633 [inline]
  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
  kthread+0x2ef/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff88809a07fb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88809a07fb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88809a07fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88809a07fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809a07fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 3b1137fe7482 ("net: ipv6: Change notifications for multipath add to RTA_MULTIPATH")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240303144801.702646-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9dbc9c0cbc5a3..b4d9acb1bc101 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4516,25 +4516,19 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	err_nh = NULL;
 	list_for_each_entry(nh, &rt6_nh_list, next) {
 		err = __ip6_ins_rt(nh->fib6_info, info, extack);
-		fib6_info_release(nh->fib6_info);
-
-		if (!err) {
-			/* save reference to last route successfully inserted */
-			rt_last = nh->fib6_info;
-
-			/* save reference to first route for notification */
-			if (!rt_notif)
-				rt_notif = nh->fib6_info;
-		}
 
-		/* nh->fib6_info is used or freed at this point, reset to NULL*/
-		nh->fib6_info = NULL;
 		if (err) {
 			if (replace && nhn)
 				ip6_print_replace_route_err(&rt6_nh_list);
 			err_nh = nh;
 			goto add_errout;
 		}
+		/* save reference to last route successfully inserted */
+		rt_last = nh->fib6_info;
+
+		/* save reference to first route for notification */
+		if (!rt_notif)
+			rt_notif = nh->fib6_info;
 
 		/* Because each route is added like a single route we remove
 		 * these flags after the first nexthop: if there is a collision,
@@ -4572,8 +4566,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 cleanup:
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
-		if (nh->fib6_info)
-			fib6_info_release(nh->fib6_info);
+		fib6_info_release(nh->fib6_info);
 		list_del(&nh->next);
 		kfree(nh);
 	}
-- 
2.43.0


