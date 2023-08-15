Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3D77CDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbjHOOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjHOOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:18:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2256A10FF;
        Tue, 15 Aug 2023 07:18:41 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQCvp2cK0ztS7Z;
        Tue, 15 Aug 2023 22:15:02 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 22:18:37 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <fw@strlen.de>, <leon@kernel.org>
CC:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <timo.teras@iki.fi>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dong Chenchen <dongchenchen2@huawei.com>
Subject: [Patch net v3] net: xfrm: skip policies marked as dead while reinserting policies
Date:   Tue, 15 Aug 2023 22:18:34 +0800
Message-ID: <20230815141834.1040646-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
Read of size 1 at addr ffff8881051f3bf8 by task ip/668

CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x72/0xa0
 print_report+0xd0/0x620
 kasan_report+0xb6/0xf0
 xfrm_policy_inexact_list_reinsert+0xb6/0x430
 xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
 xfrm_policy_inexact_alloc_chain+0x23f/0x320
 xfrm_policy_inexact_insert+0x6b/0x590
 xfrm_policy_insert+0x3b1/0x480
 xfrm_add_policy+0x23c/0x3c0
 xfrm_user_rcv_msg+0x2d0/0x510
 netlink_rcv_skb+0x10d/0x2d0
 xfrm_netlink_rcv+0x49/0x60
 netlink_unicast+0x3fe/0x540
 netlink_sendmsg+0x528/0x970
 sock_sendmsg+0x14a/0x160
 ____sys_sendmsg+0x4fc/0x580
 ___sys_sendmsg+0xef/0x160
 __sys_sendmsg+0xf7/0x1b0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x73/0xdd

The root cause is:

cpu 0			cpu1
xfrm_dump_policy
xfrm_policy_walk
list_move_tail
			xfrm_add_policy
			... ...
			xfrm_policy_inexact_list_reinsert
			list_for_each_entry_reverse
				if (!policy->bydst_reinsert)
				//read non-existent policy
xfrm_dump_policy_done
xfrm_policy_walk_done
list_del(&walk->walk.all);

If dump_one_policy() returns err (triggered by netlink socket),
xfrm_policy_walk() will move walk initialized by socket to list
net->xfrm.policy_all. so this socket becomes visible in the global
policy list. The head *walk can be traversed when users add policies
with different prefixlen and trigger xfrm_policy node merge.

The issue can also be triggered by policy list traversal while rehashing
and flushing policies.

It can be fixed by skip such "policies" with walk.dead set to 1.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
v2: fix similiar similar while rehashing and flushing policies
v3: check walk.dead after declaration of new variables
---
 net/xfrm/xfrm_policy.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d6b405782b63..113fb7e9cdaf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -851,7 +851,7 @@ static void xfrm_policy_inexact_list_reinsert(struct net *net,
 		struct hlist_node *newpos = NULL;
 		bool matches_s, matches_d;
 
-		if (!policy->bydst_reinsert)
+		if (policy->walk.dead || !policy->bydst_reinsert)
 			continue;
 
 		WARN_ON_ONCE(policy->family != family);
@@ -1256,8 +1256,11 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		struct xfrm_pol_inexact_bin *bin;
 		u8 dbits, sbits;
 
+		if (policy->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(policy->index);
-		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
+		if (dir >= XFRM_POLICY_MAX)
 			continue;
 
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
@@ -1823,9 +1826,11 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
+		if (pol->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(pol->index);
-		if (pol->walk.dead ||
-		    dir >= XFRM_POLICY_MAX ||
+		if (dir >= XFRM_POLICY_MAX ||
 		    pol->type != type)
 			continue;
 
@@ -1862,9 +1867,11 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
+		if (pol->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(pol->index);
-		if (pol->walk.dead ||
-		    dir >= XFRM_POLICY_MAX ||
+		if (dir >= XFRM_POLICY_MAX ||
 		    pol->xdo.dev != dev)
 			continue;
 
-- 
2.25.1

