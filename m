Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911717F13ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjKTNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKTNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:06:43 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1D137;
        Mon, 20 Nov 2023 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1700485599; x=1732021599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wOA5ZKCk3xkKMsTsFBYk9CrteET1+KAb4Z9HePf96X0=;
  b=TQnohzqH4xhOmIQxXv49fTu6p8jqVkbuF2lz75mWfgIK27h9RiTsJFGA
   iJzArd7Zz3zG2rdn3lZQQqq2n6dvAvDzF4aNcA9ysw99OteSiq7x/ABUx
   aXyUisRYzcuTqLqX95rIRK8R4FBcrCwsKN4fbOGoZfavu/SxP8X3sSL37
   w=;
X-IronPort-AV: E=Sophos;i="6.04,213,1695686400"; 
   d="scan'208";a="254156176"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 13:06:37 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id A7B4DA0E1F;
        Mon, 20 Nov 2023 13:06:35 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:26056]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.81:2525] with esmtp (Farcaster)
 id e1adcf6a-90d0-46c7-a5b9-62cc05cfe7ab; Mon, 20 Nov 2023 13:06:34 +0000 (UTC)
X-Farcaster-Flow-ID: e1adcf6a-90d0-46c7-a5b9-62cc05cfe7ab
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 13:06:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 13:06:33 +0000
Received: from dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (10.15.57.183)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 20 Nov 2023 13:06:33 +0000
Received: by dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com (Postfix, from userid 5466572)
        id 9FACB3368; Mon, 20 Nov 2023 13:06:32 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     <stable@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Jamal Hadi Salim" <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4.14] net: sched: fix race condition in qdisc_graft()
Date:   Mon, 20 Nov 2023 13:06:13 +0000
Message-ID: <20231120130613.4659-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit ebda44da44f6f309d302522b049f43d6f829f7aa upstream.

We had one syzbot report [1] in syzbot queue for a while.
I was waiting for more occurrences and/or a repro but
Dmitry Vyukov spotted the issue right away.

<quoting Dmitry>
qdisc_graft() drops reference to qdisc in notify_and_destroy
while it's still assigned to dev->qdisc
</quoting>

Indeed, RCU rules are clear when replacing a data structure.
The visible pointer (dev->qdisc in this case) must be updated
to the new object _before_ RCU grace period is started
(qdisc_put(old) in this case).

[1]
BUG: KASAN: use-after-free in __tcf_qdisc_find.part.0+0xa3a/0xac0 net/sched/cls_api.c:1066
Read of size 4 at addr ffff88802065e038 by task syz-executor.4/21027

CPU: 0 PID: 21027 Comm: syz-executor.4 Not tainted 6.0.0-rc3-syzkaller-00363-g7726d4c3e60b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
__tcf_qdisc_find.part.0+0xa3a/0xac0 net/sched/cls_api.c:1066
__tcf_qdisc_find net/sched/cls_api.c:1051 [inline]
tc_new_tfilter+0x34f/0x2200 net/sched/cls_api.c:2018
rtnetlink_rcv_msg+0x955/0xca0 net/core/rtnetlink.c:6081
netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
sock_sendmsg_nosec net/socket.c:714 [inline]
sock_sendmsg+0xcf/0x120 net/socket.c:734
____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
__sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5efaa89279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5efbc31168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5efab9bf80 RCX: 00007f5efaa89279
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f5efaae32e9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5efb0cfb1f R14: 00007f5efbc31300 R15: 0000000000022000
</TASK>

Allocated by task 21027:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:437 [inline]
____kasan_kmalloc mm/kasan/common.c:516 [inline]
____kasan_kmalloc mm/kasan/common.c:475 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
kmalloc_node include/linux/slab.h:623 [inline]
kzalloc_node include/linux/slab.h:744 [inline]
qdisc_alloc+0xb0/0xc50 net/sched/sch_generic.c:938
qdisc_create_dflt+0x71/0x4a0 net/sched/sch_generic.c:997
attach_one_default_qdisc net/sched/sch_generic.c:1152 [inline]
netdev_for_each_tx_queue include/linux/netdevice.h:2437 [inline]
attach_default_qdiscs net/sched/sch_generic.c:1170 [inline]
dev_activate+0x760/0xcd0 net/sched/sch_generic.c:1229
__dev_open+0x393/0x4d0 net/core/dev.c:1441
__dev_change_flags+0x583/0x750 net/core/dev.c:8556
rtnl_configure_link+0xee/0x240 net/core/rtnetlink.c:3189
rtnl_newlink_create net/core/rtnetlink.c:3371 [inline]
__rtnl_newlink+0x10b8/0x17e0 net/core/rtnetlink.c:3580
rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
sock_sendmsg_nosec net/socket.c:714 [inline]
sock_sendmsg+0xcf/0x120 net/socket.c:734
____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
__sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 21020:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:367 [inline]
____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
kasan_slab_free include/linux/kasan.h:200 [inline]
slab_free_hook mm/slub.c:1754 [inline]
slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
slab_free mm/slub.c:3534 [inline]
kfree+0xe2/0x580 mm/slub.c:4562
rcu_do_batch kernel/rcu/tree.c:2245 [inline]
rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2505
__do_softirq+0x1d3/0x9c6 kernel/softirq.c:571

Last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
call_rcu+0x99/0x790 kernel/rcu/tree.c:2793
qdisc_put+0xcd/0xe0 net/sched/sch_generic.c:1083
notify_and_destroy net/sched/sch_api.c:1012 [inline]
qdisc_graft+0xeb1/0x1270 net/sched/sch_api.c:1084
tc_modify_qdisc+0xbb7/0x1a00 net/sched/sch_api.c:1671
rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
sock_sendmsg_nosec net/socket.c:714 [inline]
sock_sendmsg+0xcf/0x120 net/socket.c:734
____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
__sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
kvfree_call_rcu+0x74/0x940 kernel/rcu/tree.c:3322
neigh_destroy+0x431/0x630 net/core/neighbour.c:912
neigh_release include/net/neighbour.h:454 [inline]
neigh_cleanup_and_release+0x1f8/0x330 net/core/neighbour.c:103
neigh_del net/core/neighbour.c:225 [inline]
neigh_remove_one+0x37d/0x460 net/core/neighbour.c:246
neigh_forced_gc net/core/neighbour.c:276 [inline]
neigh_alloc net/core/neighbour.c:447 [inline]
___neigh_create+0x18b5/0x29a0 net/core/neighbour.c:642
ip6_finish_output2+0xfb8/0x1520 net/ipv6/ip6_output.c:125
__ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
ip6_finish_output+0x690/0x1160 net/ipv6/ip6_output.c:206
NF_HOOK_COND include/linux/netfilter.h:296 [inline]
ip6_output+0x1ed/0x540 net/ipv6/ip6_output.c:227
dst_output include/net/dst.h:451 [inline]
NF_HOOK include/linux/netfilter.h:307 [inline]
NF_HOOK include/linux/netfilter.h:301 [inline]
mld_sendpack+0xa09/0xe70 net/ipv6/mcast.c:1820
mld_send_cr net/ipv6/mcast.c:2121 [inline]
mld_ifc_work+0x71c/0xdc0 net/ipv6/mcast.c:2653
process_one_work+0x991/0x1610 kernel/workqueue.c:2289
worker_thread+0x665/0x1080 kernel/workqueue.c:2436
kthread+0x2e4/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88802065e000
which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 56 bytes inside of
1024-byte region [ffff88802065e000, ffff88802065e400)

The buggy address belongs to the physical page:
page:ffffea0000819600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20658
head:ffffea0000819600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888011841dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3523, tgid 3523 (sshd), ts 41495190986, free_ts 41417713212
prep_new_page mm/page_alloc.c:2532 [inline]
get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
__alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
alloc_slab_page mm/slub.c:1824 [inline]
allocate_slab+0x27e/0x3d0 mm/slub.c:1969
new_slab mm/slub.c:2029 [inline]
___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
__slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
slab_alloc_node mm/slub.c:3209 [inline]
__kmalloc_node_track_caller+0x2f2/0x380 mm/slub.c:4955
kmalloc_reserve net/core/skbuff.c:358 [inline]
__alloc_skb+0xd9/0x2f0 net/core/skbuff.c:430
alloc_skb_fclone include/linux/skbuff.h:1307 [inline]
tcp_stream_alloc_skb+0x38/0x580 net/ipv4/tcp.c:861
tcp_sendmsg_locked+0xc36/0x2f80 net/ipv4/tcp.c:1325
tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1483
inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
sock_sendmsg_nosec net/socket.c:714 [inline]
sock_sendmsg+0xcf/0x120 net/socket.c:734
sock_write_iter+0x291/0x3d0 net/socket.c:1108
call_write_iter include/linux/fs.h:2187 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x9e9/0xdd0 fs/read_write.c:578
ksys_write+0x1e8/0x250 fs/read_write.c:631
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1449 [inline]
free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
free_unref_page_prepare mm/page_alloc.c:3380 [inline]
free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
__unfreeze_partials+0x17c/0x1a0 mm/slub.c:2548
qlink_free mm/kasan/quarantine.c:168 [inline]
qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
__kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
kasan_slab_alloc include/linux/kasan.h:224 [inline]
slab_post_alloc_hook mm/slab.h:727 [inline]
slab_alloc_node mm/slub.c:3243 [inline]
slab_alloc mm/slub.c:3251 [inline]
__kmem_cache_alloc_lru mm/slub.c:3258 [inline]
kmem_cache_alloc+0x267/0x3b0 mm/slub.c:3268
kmem_cache_zalloc include/linux/slab.h:723 [inline]
alloc_buffer_head+0x20/0x140 fs/buffer.c:2974
alloc_page_buffers+0x280/0x790 fs/buffer.c:829
create_empty_buffers+0x2c/0xee0 fs/buffer.c:1558
ext4_block_write_begin+0x1004/0x1530 fs/ext4/inode.c:1074
ext4_da_write_begin+0x422/0xae0 fs/ext4/inode.c:2996
generic_perform_write+0x246/0x560 mm/filemap.c:3738
ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:270
ext4_file_write_iter+0x44a/0x1660 fs/ext4/file.c:679
call_write_iter include/linux/fs.h:2187 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x9e9/0xdd0 fs/read_write.c:578

Fixes: af356afa010f ("net_sched: reintroduce dev->qdisc for use by sch_api")
Reported-by: syzbot <syzkaller@googlegroups.com>
Diagnosed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20221018203258.2793282-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This is CVE-2023-0590.

[ mheyne: removed rtnl_dereference due to missing commit 5891cd5ec46c
  ("net_sched: add __rcu annotation to netdev->qdisc") ]
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 net/sched/sch_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f305eb44bf36..165823ab13d6 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -938,12 +938,13 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 skip:
 		if (!ingress) {
-			notify_and_destroy(net, skb, n, classid,
-					   dev->qdisc, new);
+			old = dev->qdisc;
 			if (new && !new->ops->attach)
 				qdisc_refcount_inc(new);
 			dev->qdisc = new ? : &noop_qdisc;
 
+			notify_and_destroy(net, skb, n, classid, old, new);
+
 			if (new && new->ops->attach)
 				new->ops->attach(new);
 		} else {
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



