Return-Path: <linux-kernel+bounces-21740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A784E82939E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8451F26D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0232C7E;
	Wed, 10 Jan 2024 06:14:35 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D477320E;
	Wed, 10 Jan 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [125.119.244.129])
	by mail-app2 (Coremail) with SMTP id by_KCgBn31avNZ5lTRsgAA--.8423S4;
	Wed, 10 Jan 2024 14:14:09 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: quic_subashab@quicinc.com,
	quic_stranche@quicinc.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net v1] net: qualcomm: rmnet: fix global oob in rmnet_policy
Date: Wed, 10 Jan 2024 14:14:00 +0800
Message-Id: <20240110061400.3356108-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBn31avNZ5lTRsgAA--.8423S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy3XF45Xr45tr1UGF1xKrg_yoWruw1DpF
	yDXryxGr48try8XFsrJw1rJr15X3WDAa1UGr4xJr1rAFyDKw17JryUtFy5Ar1DCrZ0yFy2
	qwnrAr4Fyr15JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The variable rmnet_link_ops assign a *bigger* maxtype which leads to a
global out-of-bounds read when parsing the netlink attributes. See bug
trace below:

==================================================================
BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
Read of size 1 at addr ffffffff92c438d0 by task syz-executor.6/84207

CPU: 0 PID: 84207 Comm: syz-executor.6 Tainted: G                 N 6.1.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x172/0x475 mm/kasan/report.c:395
 kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
 validate_nla lib/nlattr.c:386 [inline]
 __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
 __nla_parse+0x3e/0x50 lib/nlattr.c:697
 nla_parse_nested_deprecated include/net/netlink.h:1248 [inline]
 __rtnl_newlink+0x50a/0x1880 net/core/rtnetlink.c:3485
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x43c/0xd70 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0x154/0x190 net/socket.c:734
 ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdcf2072359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdcf13e3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdcf219ff80 RCX: 00007fdcf2072359
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
RBP: 00007fdcf20bd493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffbb8d7bdf R14: 00007fdcf13e3300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the variable:
 rmnet_policy+0x30/0xe0

The buggy address belongs to the physical page:
page:0000000065bdeb3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x155243
flags: 0x200000000001000(reserved|node=0|zone=2)
raw: 0200000000001000 ffffea00055490c8 ffffea00055490c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffffff92c43780: f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9 00 00 00 07
 ffffffff92c43800: f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9 06 f9 f9 f9
>ffffffff92c43880: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
                                                 ^
 ffffffff92c43900: 00 00 00 00 00 00 00 00 07 f9 f9 f9 f9 f9 f9 f9
 ffffffff92c43980: 00 00 00 07 f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9

According to the comment of `nla_parse_nested_deprecated`, the maxtype
should be len(destination array) - 1. Hence use `IFLA_RMNET_MAX` here.

Fixes: 14452ca3b5ce ("net: qualcomm: rmnet: Export mux_id and flags to netlink")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 39d24e07f306..5b69b9268c75 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -396,7 +396,7 @@ static int rmnet_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 struct rtnl_link_ops rmnet_link_ops __read_mostly = {
 	.kind		= "rmnet",
-	.maxtype	= __IFLA_RMNET_MAX,
+	.maxtype	= IFLA_RMNET_MAX,
 	.priv_size	= sizeof(struct rmnet_priv),
 	.setup		= rmnet_vnd_setup,
 	.validate	= rmnet_rtnl_validate,
-- 
2.17.1


