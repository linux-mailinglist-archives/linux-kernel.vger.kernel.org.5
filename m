Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5F7847A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbjHVQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbjHVQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:31:43 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E2193;
        Tue, 22 Aug 2023 09:31:41 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qYUI0-0000GQ-18;
        Tue, 22 Aug 2023 16:31:32 +0000
Date:   Tue, 22 Aug 2023 17:31:24 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 1/4] net: ethernet: mtk_eth_soc: fix register
 definitions for MT7988
Message-ID: <1c8da012e2ca80939906d85f314138c552139f0f.1692721443.git.daniel@makrotopia.org>
References: <cover.1692721443.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692721443.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More register macros need to be adjusted for the 3rd GMAC on MT7988.
Account for added bit in SYSCFG0_SGMII_MASK.

Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 4a2470fbad2cf..8d2d35b322351 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -133,10 +133,12 @@
 #define MTK_GDMA_XGDM_SEL	BIT(31)
 
 /* Unicast Filter MAC Address Register - Low */
-#define MTK_GDMA_MAC_ADRL(x)	(0x508 + (x * 0x1000))
+#define MTK_GDMA_MAC_ADRL(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
+				   0x548 : 0x508 + (_x * 0x1000); })
 
 /* Unicast Filter MAC Address Register - High */
-#define MTK_GDMA_MAC_ADRH(x)	(0x50C + (x * 0x1000))
+#define MTK_GDMA_MAC_ADRH(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
+				   0x54C : 0x50C + (_x * 0x1000); })
 
 /* FE global misc reg*/
 #define MTK_FE_GLO_MISC         0x124
@@ -503,7 +505,7 @@
 #define ETHSYS_SYSCFG0		0x14
 #define SYSCFG0_GE_MASK		0x3
 #define SYSCFG0_GE_MODE(x, y)	(x << (12 + (y * 2)))
-#define SYSCFG0_SGMII_MASK     GENMASK(9, 8)
+#define SYSCFG0_SGMII_MASK     GENMASK(9, 7)
 #define SYSCFG0_SGMII_GMAC1    ((2 << 8) & SYSCFG0_SGMII_MASK)
 #define SYSCFG0_SGMII_GMAC2    ((3 << 8) & SYSCFG0_SGMII_MASK)
 #define SYSCFG0_SGMII_GMAC1_V2 BIT(9)
-- 
2.41.0
