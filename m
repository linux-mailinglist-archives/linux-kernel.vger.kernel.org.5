Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4E776A970
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHAGpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjHAGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:45:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC698;
        Mon, 31 Jul 2023 23:45:42 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFQYn3Z8vzVjw6;
        Tue,  1 Aug 2023 14:43:57 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 14:45:40 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <simon.horman@corigine.com>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Date:   Tue, 1 Aug 2023 14:43:18 +0800
Message-ID: <20230801064318.34408-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v3: drop unnecessary nhoff change
v2: Use __skb_pull() and fix commit log.
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cc3d5ad17257..67a3b8f6e72b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 		   And all this only to mangle msg->im6_msgtype and
 		   to set msg->im6_mbz to "mbz" :-)
 		 */
-		skb_push(skb, -skb_network_offset(pkt));
+		__skb_pull(skb, skb_network_offset(pkt));
 
 		skb_push(skb, sizeof(*msg));
 		skb_reset_transport_header(skb);
-- 
2.34.1

