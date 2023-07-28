Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F39766D55
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbjG1Mgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjG1Mgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:36:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E2C2688;
        Fri, 28 Jul 2023 05:36:41 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC66R6LsbzVjgR;
        Fri, 28 Jul 2023 20:15:43 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 20:17:20 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <simon.horman@corigine.com>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH v2] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Date:   Fri, 28 Jul 2023 20:17:03 +0800
Message-ID: <20230728121703.29572-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
 head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6reg
 ------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:192!
 invalid opcode: 0000 [#1] PREEMPT SMP KASAN
 CPU: 2 PID: 22968 Comm: kworker/2:11 Not tainted 6.5.0-rc3-00044-g0a8db05b571a #236
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 Workqueue: ipv6_addrconf addrconf_dad_work
 RIP: 0010:skb_panic+0x152/0x1d0
 Call Trace:
  <TASK>
  skb_push+0xc4/0xe0
  ip6mr_cache_report+0xd69/0x19b0
  reg_vif_xmit+0x406/0x690
  dev_hard_start_xmit+0x17e/0x6e0
  __dev_queue_xmit+0x2d6a/0x3d20
  vlan_dev_hard_start_xmit+0x3ab/0x5c0
  dev_hard_start_xmit+0x17e/0x6e0
  __dev_queue_xmit+0x2d6a/0x3d20
  neigh_connected_output+0x3ed/0x570
  ip6_finish_output2+0x5b5/0x1950
  ip6_finish_output+0x693/0x11c0
  ip6_output+0x24b/0x880
  NF_HOOK.constprop.0+0xfd/0x530
  ndisc_send_skb+0x9db/0x1400
  ndisc_send_rs+0x12a/0x6c0
  addrconf_dad_completed+0x3c9/0xea0
  addrconf_dad_work+0x849/0x1420
  process_one_work+0xa22/0x16e0
  worker_thread+0x679/0x10c0
  ret_from_fork+0x28/0x60
  ret_from_fork_asm+0x11/0x20

When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vif_xmit().
reg_vif_xmit()
    ip6mr_cache_report()
        skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt) is 4
And skb_push declared as:
	void *skb_push(struct sk_buff *skb, unsigned int len);
		skb->data -= len;
		//0xffff88805f86a84c - 0xfffffffc = 0xffff887f5f86a850
skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead to skb_push() fails.

Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: Use __skb_pull() and fix commit log.
---
 net/ipv6/ip6mr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cc3d5ad17257..1a55d41feaa6 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1051,9 +1051,9 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 	int ret;
 
 #ifdef CONFIG_IPV6_PIMSM_V2
+	int nhoff = skb_network_offset(pkt);
 	if (assert == MRT6MSG_WHOLEPKT || assert == MRT6MSG_WRMIFWHOLE)
-		skb = skb_realloc_headroom(pkt, -skb_network_offset(pkt)
-						+sizeof(*msg));
+		skb = skb_realloc_headroom(pkt, -nhoff + sizeof(*msg));
 	else
 #endif
 		skb = alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), GFP_ATOMIC);
@@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 		   And all this only to mangle msg->im6_msgtype and
 		   to set msg->im6_mbz to "mbz" :-)
 		 */
-		skb_push(skb, -skb_network_offset(pkt));
+		__skb_pull(skb, nhoff);
 
 		skb_push(skb, sizeof(*msg));
 		skb_reset_transport_header(skb);
-- 
2.34.1

