Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D145676D78B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjHBTOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHBTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:13:55 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECB426A6;
        Wed,  2 Aug 2023 12:13:53 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 670111A105F;
        Wed,  2 Aug 2023 21:13:52 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F17BE1A105C;
        Wed,  2 Aug 2023 21:13:51 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B8DCA4058C;
        Wed,  2 Aug 2023 12:13:50 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Bauer <mail@david-bauer.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Wei Fang <wei.fang@nxp.com>
Subject: [PATCH v4 1/2] net: phy: at803x: fix the wol setting functions
Date:   Wed,  2 Aug 2023 14:13:46 -0500
Message-Id: <20230802191347.6886-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20230802191347.6886-1-leoyang.li@nxp.com>
References: <20230802191347.6886-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"), it
seems not correct to use a wol_en bit in a 1588 Control Register which is
only available on AR8031/AR8033(share the same phy_id) to determine if WoL
is enabled.  Change it back to use AT803X_INTR_ENABLE_WOL for determining
the WoL status which is applicable on all chips supporting wol. Also update
the at803x_set_wol() function to only update the 1588 register on chips
having it.  After this change, disabling wol at probe from commit
d7cd5e06c9dd ("net: phy: at803x: disable WOL at probe") is no longer
needed.  Change it to just disable the WoL bit in 1588 register for
AR8031/AR8033 to be aligned with AT803X_INTR_ENABLE_WOL in probe.

Fixes: 7beecaf7d507 ("net: phy: at803x: improve the WOL feature")
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/at803x.c | 45 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c1f307d90518..9c2c2e2ee94b 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -459,21 +459,27 @@ static int at803x_set_wol(struct phy_device *phydev,
 			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
 				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
 
-		/* Enable WOL function */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL,
-				0, AT803X_WOL_EN);
-		if (ret)
-			return ret;
+		/* Enable WOL function for 1588 */
+		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
+			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+					     AT803X_PHY_MMD3_WOL_CTRL,
+					     0, AT803X_WOL_EN);
+			if (ret)
+				return ret;
+		}
 		/* Enable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
 		if (ret)
 			return ret;
 	} else {
-		/* Disable WoL function */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL,
-				AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
+		/* Disable WoL function for 1588 */
+		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
+			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+					     AT803X_PHY_MMD3_WOL_CTRL,
+					     AT803X_WOL_EN, 0);
+			if (ret)
+				return ret;
+		}
 		/* Disable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
 		if (ret)
@@ -508,11 +514,11 @@ static void at803x_get_wol(struct phy_device *phydev,
 	wol->supported = WAKE_MAGIC;
 	wol->wolopts = 0;
 
-	value = phy_read_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL);
+	value = phy_read(phydev, AT803X_INTR_ENABLE);
 	if (value < 0)
 		return;
 
-	if (value & AT803X_WOL_EN)
+	if (value & AT803X_INTR_ENABLE_WOL)
 		wol->wolopts |= WAKE_MAGIC;
 }
 
@@ -858,9 +864,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
 		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
 		int mode_cfg;
-		struct ethtool_wolinfo wol = {
-			.wolopts = 0,
-		};
 
 		if (ccr < 0)
 			return ccr;
@@ -877,12 +880,14 @@ static int at803x_probe(struct phy_device *phydev)
 			break;
 		}
 
-		/* Disable WOL by default */
-		ret = at803x_set_wol(phydev, &wol);
-		if (ret < 0) {
-			phydev_err(phydev, "failed to disable WOL on probe: %d\n", ret);
+		/* Disable WoL in 1588 register which is enabled
+		 * by default
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.25.1.377.g2d2118b

