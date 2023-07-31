Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E414769542
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjGaLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjGaLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:51:08 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5179FF5;
        Mon, 31 Jul 2023 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690804267; x=1722340267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tb8UcV3JNO0OnfuujH03nYZbaEtctQ46lfuTXXi+SFA=;
  b=Ytr4rZTf1FCzn9k9D2o3YrV8wp1c07YVuW9dW0UmYDKR6zbU0xS/Q3iE
   CThyI1zLgZRA0+d/wZVrbOxMHJXwOTlhLVOTsop86vGQxq1aMRtDmvfYx
   VxbVibuX21GZlk+VIH2r6fE31B4UpFQJ7+tGpWhhSeOmQQP26eV3rxD9K
   stkP3+YekaHbtvP9ZiBkeZTZanzAO+axaWTLMMhs9Gx8qBua18JrBQrzG
   vBcgktZzM9l07/KT5Uwd0Uqy4HHwC56oAU0MamXcE53MRjuEUj1/srs21
   jEHzSDDdnxnNRrT3VauE/RiM6f+/sNAb7r75NgqNMPyYL7vmIdNCVSyDD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="367889846"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="367889846"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 04:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="731571981"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="731571981"
Received: from pglc1085.png.intel.com ([10.221.100.47])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jul 2023 04:51:03 -0700
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next] net: stmmac: XGMAC support for mdio C22 addr > 3
Date:   Mon, 31 Jul 2023 19:50:41 +0800
Message-Id: <20230731115041.13893-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For XGMAC versions < 2.2 number of supported mdio C22 addresses is
restricted to 3. From XGMAC version 2.2 there are no restrictions on
the C22 addresses, it supports all valid mdio addresses(0 to 31).

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 36 ++++++++++++-------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 57f2137bbe9d..c67171975d5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -35,6 +35,7 @@
 #define DWMAC_CORE_5_10		0x51
 #define DWMAC_CORE_5_20		0x52
 #define DWXGMAC_CORE_2_10	0x21
+#define DWXGMAC_CORE_2_20	0x22
 #define DWXLGMAC_CORE_2_00	0x20
 
 /* Device ID */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 3db1cb0fd160..dd9e2fec5328 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -62,11 +62,16 @@ static void stmmac_xgmac2_c45_format(struct stmmac_priv *priv, int phyaddr,
 static void stmmac_xgmac2_c22_format(struct stmmac_priv *priv, int phyaddr,
 				     int phyreg, u32 *hw_addr)
 {
-	u32 tmp;
+	u32 tmp = 0;
 
+	if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
+		/* Until ver 2.20 XGMAC does not support C22 addr >= 4. Those
+		 * bits above bit 3 of XGMAC_MDIO_C22P register are reserved.
+		 */
+		tmp = readl(priv->ioaddr + XGMAC_MDIO_C22P);
+		tmp &= ~MII_XGMAC_C22P_MASK;
+	}
 	/* Set port as Clause 22 */
-	tmp = readl(priv->ioaddr + XGMAC_MDIO_C22P);
-	tmp &= ~MII_XGMAC_C22P_MASK;
 	tmp |= BIT(phyaddr);
 	writel(tmp, priv->ioaddr + XGMAC_MDIO_C22P);
 
@@ -132,8 +137,9 @@ static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
 
 	priv = netdev_priv(ndev);
 
-	/* HW does not support C22 addr >= 4 */
-	if (phyaddr > MII_XGMAC_MAX_C22ADDR)
+	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
+	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
+	    phyaddr > MII_XGMAC_MAX_C22ADDR)
 		return -ENODEV;
 
 	stmmac_xgmac2_c22_format(priv, phyaddr, phyreg, &addr);
@@ -209,8 +215,9 @@ static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
 
 	priv = netdev_priv(ndev);
 
-	/* HW does not support C22 addr >= 4 */
-	if (phyaddr > MII_XGMAC_MAX_C22ADDR)
+	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
+	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
+	    phyaddr > MII_XGMAC_MAX_C22ADDR)
 		return -ENODEV;
 
 	stmmac_xgmac2_c22_format(priv, phyaddr, phyreg, &addr);
@@ -551,13 +558,18 @@ int stmmac_mdio_register(struct net_device *ndev)
 		new_bus->read_c45 = &stmmac_xgmac2_mdio_read_c45;
 		new_bus->write_c45 = &stmmac_xgmac2_mdio_write_c45;
 
-		/* Right now only C22 phys are supported */
-		max_addr = MII_XGMAC_MAX_C22ADDR + 1;
+		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
+			/* Right now only C22 phys are supported */
+			max_addr = MII_XGMAC_MAX_C22ADDR + 1;
 
-		/* Check if DT specified an unsupported phy addr */
-		if (priv->plat->phy_addr > MII_XGMAC_MAX_C22ADDR)
-			dev_err(dev, "Unsupported phy_addr (max=%d)\n",
+			/* Check if DT specified an unsupported phy addr */
+			if (priv->plat->phy_addr > MII_XGMAC_MAX_C22ADDR)
+				dev_err(dev, "Unsupported phy_addr (max=%d)\n",
 					MII_XGMAC_MAX_C22ADDR);
+		} else {
+			/* XGMAC version 2.20 onwards support 32 phy addr */
+			max_addr = PHY_MAX_ADDR;
+		}
 	} else {
 		new_bus->read = &stmmac_mdio_read_c22;
 		new_bus->write = &stmmac_mdio_write_c22;
-- 
2.19.0

