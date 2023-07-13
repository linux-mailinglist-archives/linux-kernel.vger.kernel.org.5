Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14B0751632
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjGMCTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjGMCTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:19:13 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89D2120;
        Wed, 12 Jul 2023 19:19:06 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJlv6-0005XJ-1Y;
        Thu, 13 Jul 2023 02:19:05 +0000
Date:   Thu, 13 Jul 2023 03:18:52 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH v2 net-next 4/9] net: ethernet: mtk_eth_soc: increase
 MAX_DEVS to 3
Message-ID: <2cc8012ec538106c6bcf22a40b647ec342e687a8.1689012506.git.daniel@makrotopia.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689012506.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to add MT7988 SoC support since it runs 3
macs instead of 2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 +++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 7014e0d108b27..7f191e4337dd8 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4030,8 +4030,12 @@ static void mtk_sgmii_destroy(struct mtk_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < MTK_MAX_DEVS; i++)
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
+		if (!eth->sgmii_pcs[i])
+			continue;
+
 		mtk_pcs_lynxi_destroy(eth->sgmii_pcs[i]);
+	}
 }
 
 static int mtk_cleanup(struct mtk_eth *eth)
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index c74c3918113a5..b18ce4430d437 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1049,8 +1049,8 @@ struct mtk_soc_data {
 
 #define MTK_DMA_MONITOR_TIMEOUT		msecs_to_jiffies(1000)
 
-/* currently no SoC has more than 2 macs */
-#define MTK_MAX_DEVS			2
+/* currently no SoC has more than 3 macs */
+#define MTK_MAX_DEVS	3
 
 /* struct mtk_eth -	This is the main datasructure for holding the state
  *			of the driver
-- 
2.41.0
