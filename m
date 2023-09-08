Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE260798158
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjIHEqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjIHEqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:46:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC001997;
        Thu,  7 Sep 2023 21:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694148379; x=1725684379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0TnSY7Dj57kDvwS7MSema5/mPzlAoA5MTHNSNEab8U8=;
  b=PeEVGfxd0l3Kcu0/oo3HJt/T8H19Ut/KMtBpLFtz03Y8G6mRuMFd6WQk
   CyMitAu6cpXHy2PyOWTDegLgf8wEacJEyT9lATq/gZpXvb5cjIKpYjvNV
   E5W0eu+LUFJzV4j3oq0oxu9rCLzV3J100yKutQ853KxEo2xVULVe/C/MD
   WdKi/hR6RFSkQ+de9B3B4aG25ujklHaZpSs2A43nGyEKoIRxu0JgUNzLV
   PMtOJIdlFR3MZP5ST29AMMb1YxO3oUTYx7NtJ9N0QqPrR2SevFuGDiSYv
   AUSQnVSue27z1seNjQV9rjWBVAzrAg48QS2+kb9VVpf+m3eTBt3Pd+eHK
   g==;
X-CSE-ConnectionGUID: QZKXUBTPSTK9vpT5kOAAKw==
X-CSE-MsgGUID: 9upBYIUySMec21KwjkF9iw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="3566524"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2023 21:46:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 7 Sep 2023 21:45:34 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 7 Sep 2023 21:45:29 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <kuba@kernel.org>, <piergiorgio.beruto@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net v2] ethtool: plca: fix plca enable data type while parsing the value
Date:   Fri, 8 Sep 2023 10:15:48 +0530
Message-ID: <20230908044548.5878-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
value from the attribute, nla_get_u32() is used in the plca_update_sint()
function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
with some garbage value instead of 0 or 1 and always enables plca even
though plca is disabled through ethtool application. This bug has been
fixed by parsing the values based on the attributes type in the policy.

Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 net/ethtool/plca.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b238a1afe9ae..b1e2e3b5027f 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -21,16 +21,6 @@ struct plca_reply_data {
 #define PLCA_REPDATA(__reply_base) \
 	container_of(__reply_base, struct plca_reply_data, base)
 
-static void plca_update_sint(int *dst, const struct nlattr *attr,
-			     bool *mod)
-{
-	if (!attr)
-		return;
-
-	*dst = nla_get_u32(attr);
-	*mod = true;
-}
-
 // PLCA get configuration message ------------------------------------------- //
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
@@ -38,6 +28,29 @@ const struct nla_policy ethnl_plca_get_cfg_policy[] = {
 		NLA_POLICY_NESTED(ethnl_header_policy),
 };
 
+static void plca_update_sint(int *dst, struct nlattr **tb, u32 attrid,
+			     bool *mod)
+{
+	const struct nlattr *attr = tb[attrid];
+
+	if (!attr ||
+	    WARN_ON_ONCE(attrid >= ARRAY_SIZE(ethnl_plca_set_cfg_policy)))
+		return;
+
+	switch (ethnl_plca_set_cfg_policy[attrid].type) {
+	case NLA_U8:
+		*dst = nla_get_u8(attr);
+		break;
+	case NLA_U32:
+		*dst = nla_get_u32(attr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	*mod = true;
+}
+
 static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 				     struct ethnl_reply_data *reply_base,
 				     const struct genl_info *info)
@@ -144,13 +157,13 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
-	plca_update_sint(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED], &mod);
-	plca_update_sint(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID], &mod);
-	plca_update_sint(&plca_cfg.node_cnt, tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
-	plca_update_sint(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR], &mod);
-	plca_update_sint(&plca_cfg.burst_cnt, tb[ETHTOOL_A_PLCA_BURST_CNT],
+	plca_update_sint(&plca_cfg.enabled, tb, ETHTOOL_A_PLCA_ENABLED, &mod);
+	plca_update_sint(&plca_cfg.node_id, tb, ETHTOOL_A_PLCA_NODE_ID, &mod);
+	plca_update_sint(&plca_cfg.node_cnt, tb, ETHTOOL_A_PLCA_NODE_CNT, &mod);
+	plca_update_sint(&plca_cfg.to_tmr, tb, ETHTOOL_A_PLCA_TO_TMR, &mod);
+	plca_update_sint(&plca_cfg.burst_cnt, tb, ETHTOOL_A_PLCA_BURST_CNT,
 			 &mod);
-	plca_update_sint(&plca_cfg.burst_tmr, tb[ETHTOOL_A_PLCA_BURST_TMR],
+	plca_update_sint(&plca_cfg.burst_tmr, tb, ETHTOOL_A_PLCA_BURST_TMR,
 			 &mod);
 	if (!mod)
 		return 0;
-- 
2.34.1

