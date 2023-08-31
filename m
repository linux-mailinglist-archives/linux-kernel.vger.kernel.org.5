Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354278EAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjHaKr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbjHaKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:47:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5479E42;
        Thu, 31 Aug 2023 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693478825; x=1725014825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mz+ggDjixAgQiP4EnpcwAI44RJg14B3t7D7rYiXKWdc=;
  b=AgZhBuguWDxqDydOAu8I2huzT1ofJt39cU9gntyrF52kZtb/n53+7U0j
   GtW8u+/OMw7abfvdxdFwobRo1FrK400T8LDJo/7hMQALKKS3Crj5aLFO7
   GNB77jSDaAOd9Xr2pAjJVk3xNIlMQnuDhA/HoQP/9X0+NCf/iQuDbyb+L
   8z+wFS07qoj9/Euf44Cz6fOLQ5R0qCptBu1pwVNJ8XPZEBjwOxRWGs/zF
   w4SM2UGgKEwZT0KR/eu3EfcDf93WdGYo0uz7TMojTznXGAmD41j5diFSo
   XuCH0l1dU3YDJGn12TQFMBzaffF3FF0d1sMYxdl1Uhg1fryxTQ+PDylwE
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="2169354"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2023 03:46:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 31 Aug 2023 03:45:43 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 31 Aug 2023 03:45:38 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <piergiorgio.beruto@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.co>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        "Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next] ethtool: plca: fix plca enable data type while parsing the value
Date:   Thu, 31 Aug 2023 16:15:23 +0530
Message-ID: <20230831104523.7178-1-Parthiban.Veerasooran@microchip.com>
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
fixed by implementing plca_update_sint_from_u8() function which uses
nla_get_u8() function to extract the plca_cfg.enabled value and the
function plca_update_sint_from_u32() is used for extracting the other
values using nla_get_u32() function.

Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 net/ethtool/plca.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index b238a1afe9ae..b4e80dd33590 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -21,8 +21,8 @@ struct plca_reply_data {
 #define PLCA_REPDATA(__reply_base) \
 	container_of(__reply_base, struct plca_reply_data, base)
 
-static void plca_update_sint(int *dst, const struct nlattr *attr,
-			     bool *mod)
+static void plca_update_sint_from_u32(int *dst, const struct nlattr *attr,
+				      bool *mod)
 {
 	if (!attr)
 		return;
@@ -31,6 +31,16 @@ static void plca_update_sint(int *dst, const struct nlattr *attr,
 	*mod = true;
 }
 
+static void plca_update_sint_from_u8(int *dst, const struct nlattr *attr,
+				     bool *mod)
+{
+	if (!attr)
+		return;
+
+	*dst = nla_get_u8(attr);
+	*mod = true;
+}
+
 // PLCA get configuration message ------------------------------------------- //
 
 const struct nla_policy ethnl_plca_get_cfg_policy[] = {
@@ -144,14 +154,18 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	memset(&plca_cfg, 0xff, sizeof(plca_cfg));
-	plca_update_sint(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED], &mod);
-	plca_update_sint(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID], &mod);
-	plca_update_sint(&plca_cfg.node_cnt, tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
-	plca_update_sint(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR], &mod);
-	plca_update_sint(&plca_cfg.burst_cnt, tb[ETHTOOL_A_PLCA_BURST_CNT],
-			 &mod);
-	plca_update_sint(&plca_cfg.burst_tmr, tb[ETHTOOL_A_PLCA_BURST_TMR],
-			 &mod);
+	plca_update_sint_from_u8(&plca_cfg.enabled, tb[ETHTOOL_A_PLCA_ENABLED],
+				 &mod);
+	plca_update_sint_from_u32(&plca_cfg.node_id, tb[ETHTOOL_A_PLCA_NODE_ID],
+				  &mod);
+	plca_update_sint_from_u32(&plca_cfg.node_cnt,
+				  tb[ETHTOOL_A_PLCA_NODE_CNT], &mod);
+	plca_update_sint_from_u32(&plca_cfg.to_tmr, tb[ETHTOOL_A_PLCA_TO_TMR],
+				  &mod);
+	plca_update_sint_from_u32(&plca_cfg.burst_cnt,
+				  tb[ETHTOOL_A_PLCA_BURST_CNT], &mod);
+	plca_update_sint_from_u32(&plca_cfg.burst_tmr,
+				  tb[ETHTOOL_A_PLCA_BURST_TMR], &mod);
 	if (!mod)
 		return 0;
 
-- 
2.34.1

