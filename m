Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A853476D94C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjHBVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHBVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:15:22 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C612708;
        Wed,  2 Aug 2023 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691010922; x=1722546922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UGL2vJ6MLNe12v+8D3skuK9/dM3RwPLrOS4RD+wo23g=;
  b=hmZCZGQEs8ejNPDN4BHJ31HO/3P2bsaI1lk+Yp4u9PgJMiqUtL3LXpUr
   74mNoNdPNKfp0s4Ia58dKLvWxTcix/lcpKLkAvFEdG9pgpxUrUGfbFQpk
   Oi648UdH8O6pzl06wI4KzaYIAagAS29lz84idQNUrdb5uCycw/WQ0OVbu
   c=;
X-IronPort-AV: E=Sophos;i="6.01,250,1684800000"; 
   d="scan'208";a="348263066"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:15:20 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 8799310B9AD;
        Wed,  2 Aug 2023 21:15:18 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 21:15:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 21:15:17 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.30 via Frontend Transport; Wed, 2 Aug 2023 21:15:17 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id AE701E4C; Wed,  2 Aug 2023 21:15:17 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>, <lee@kernel.org>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <"stable@vger.kernel.orgstable"@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH 4.19] net/sched: cls_u32: Fix reference counter leak leading to overflow
Date:   Wed, 2 Aug 2023 21:15:15 +0000
Message-ID: <20230802211515.23078-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Jones <lee@kernel.org>

Upstream commit 04c55383fa5689357bcdd2c8036725a55ed632bc.

In the event of a failure in tcf_change_indev(), u32_set_parms() will
immediately return without decrementing the recently incremented
reference counter.  If this happens enough times, the counter will
rollover and the reference freed, leading to a double free which can be
used to do 'bad things'.

In order to prevent this, move the point of possible failure above the
point where the reference counter is incremented.  Also save any
meaningful return values to be applied to the return data at the
appropriate point in time.

This issue was caught with KASAN.

Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 net/sched/cls_u32.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d30256ac3537..ee8ef606a8e9 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -778,11 +778,22 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct netlink_ext_ack *extack)
 {
 	int err;
+#ifdef CONFIG_NET_CLS_IND
+	int ifindex = -1;
+#endif
 
 	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr, extack);
 	if (err < 0)
 		return err;
 
+#ifdef CONFIG_NET_CLS_IND
+	if (tb[TCA_U32_INDEV]) {
+		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
+		if (ifindex < 0)
+			return -EINVAL;
+	}
+#endif
+
 	if (tb[TCA_U32_LINK]) {
 		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
 		struct tc_u_hnode *ht_down = NULL, *ht_old;
@@ -814,13 +825,8 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 	}
 
 #ifdef CONFIG_NET_CLS_IND
-	if (tb[TCA_U32_INDEV]) {
-		int ret;
-		ret = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-		if (ret < 0)
-			return -EINVAL;
-		n->ifindex = ret;
-	}
+	if (ifindex >= 0)
+		n->ifindex = ifindex;
 #endif
 	return 0;
 }
-- 
2.40.1

