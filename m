Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B147B20B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjI1PPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjI1PPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:15:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0711A8;
        Thu, 28 Sep 2023 08:15:48 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SECwxs029787;
        Thu, 28 Sep 2023 17:15:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=P3XV1IaVNFLkdLdID+Fpncm54gnI4v+2MxfVHgWirNY=; b=7b
        SpNQ0YXXZ8qL93YzFZkjM/pdeV0SoCRB4tvQ5dEJla6+MrkvyEFw4E45qIPIJ5CR
        L9rZi+XEq67jxIeccif/EQ4tuHc3G5qLWmrfULJaMqETPvkF2L6CBMeRddYSbdZp
        MKiZqscIPx36WCau2MvSgl72H6qeQd+iwuzMcrniMj4x2CyXY8LFAuz+1GTbXUNM
        1wkKib07WDYW2WOksv5CcL7De/0kB+ji1P28DnVtzliOzzg9GyZnOpLHM599bn6P
        TdHGN3bmYHTo5ALYW8Ev315/atdvp4xZ3wFDfgK2wqfODCqvz9TvttGHnu11hrgy
        vaJgsAbt6w9EotJ7GZwQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tcq63cuh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:15:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B3B5B100057;
        Thu, 28 Sep 2023 17:15:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA8A024553D;
        Thu, 28 Sep 2023 17:15:19 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 17:15:18 +0200
From:   Christophe Roullier <christophe.roullier@foss.st.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/12] net: ethernet: stmmac: rework glue to simplify management for next stm32
Date:   Thu, 28 Sep 2023 17:15:04 +0200
Message-ID: <20230928151512.322016-5-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928151512.322016-1-christophe.roullier@foss.st.com>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_14,2023-09-28_02,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change glue to be more generic and manage easily next stm32 products.
The goal of this commit is to have one stm32mp1_set_mode function which
can manage different STM32 SOC. SOC can have different SYSCFG register
bitfields. so in pmcsetr we defined the bitfields corresponding to the SOC.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 70 +++++++++++++------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index ab4324ed46dac..52106e0d7359f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -23,10 +23,6 @@
 
 #define SYSCFG_MCU_ETH_MASK		BIT(23)
 #define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
-#define SYSCFG_PMCCLRR_OFFSET		0x40
-
-#define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
-#define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
 
 /* CLOCK feed to PHY*/
 #define ETH_CK_F_25M	25000000
@@ -46,9 +42,6 @@
  * RMII  |   1	 |   0	  |   0	   |  n/a  |
  *------------------------------------------
  */
-#define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
-#define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
-#define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
 #define SYSCFG_PMCR_ETH_SEL_GMII	0
 #define SYSCFG_MCU_ETH_SEL_MII		0
 #define SYSCFG_MCU_ETH_SEL_RMII		1
@@ -90,12 +83,25 @@ struct stm32_dwmac {
 	int eth_ref_clk_sel_reg;
 	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
+	u32 mode_mask;
 	struct regmap *regmap;
 	u32 speed;
 	const struct stm32_ops *ops;
 	struct device *dev;
 };
 
+struct stm32_syscfg_pmcsetr {
+	u32 eth1_clk_sel;
+	u32 eth1_ref_clk_sel;
+	u32 eth1_selmii;
+	u32 eth1_sel_rgmii;
+	u32 eth1_sel_rmii;
+	u32 eth2_clk_sel;
+	u32 eth2_ref_clk_sel;
+	u32 eth2_sel_rgmii;
+	u32 eth2_sel_rmii;
+};
+
 struct stm32_ops {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
 	int (*clk_prepare)(struct stm32_dwmac *dwmac, bool prepare);
@@ -103,7 +109,8 @@ struct stm32_ops {
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
-	u32 syscfg_eth_mask;
+	u32 syscfg_clr_off;
+	struct stm32_syscfg_pmcsetr pmcsetr;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -175,7 +182,7 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_MII:
 		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
 			dwmac->enable_eth_ck = true;
-		val = SYSCFG_PMCR_ETH_SEL_MII;
+		val = dwmac->ops->pmcsetr.eth1_selmii;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
@@ -183,16 +190,17 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 		if (clk_rate == ETH_CK_F_25M &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		val = SYSCFG_PMCR_ETH_SEL_RMII;
+		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
 		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
 		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
+			val |= dwmac->ops->pmcsetr.eth2_ref_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
@@ -200,11 +208,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		val = SYSCFG_PMCR_ETH_SEL_RGMII;
+		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
 		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
+			val |= dwmac->ops->pmcsetr.eth2_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
@@ -216,12 +225,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	/* Need to update PMCCLRR (clear register) */
-	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
-		     dwmac->ops->syscfg_eth_mask);
+	regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
+		     dwmac->mode_mask);
 
 	/* Update PMCSETR (set register) */
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val);
+				 dwmac->mode_mask, val);
 }
 
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -247,7 +256,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val << 23);
+				 SYSCFG_MCU_ETH_MASK, val << 23);
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
@@ -290,10 +299,17 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 		return PTR_ERR(dwmac->regmap);
 
 	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
+	if (err) {
+		dev_err(dev, "Can't get sysconfig register offset (%d)\n", err);
+		return err;
+	}
+
+	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
+	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
 	if (err)
-		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
+		pr_debug("Warning sysconfig register mask not set\n");
 
-	return err;
+	return 0;
 }
 
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
@@ -499,7 +515,6 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 static struct stm32_ops stm32mcu_dwmac_data = {
 	.set_mode = stm32mcu_set_mode,
 	.suspend = stm32mcu_suspend,
-	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
@@ -508,7 +523,18 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_clr_off = 0x44,
+	.pmcsetr = {
+		.eth1_clk_sel		= BIT(16),
+		.eth1_ref_clk_sel	= BIT(17),
+		.eth1_selmii		= BIT(20),
+		.eth1_sel_rgmii		= BIT(21),
+		.eth1_sel_rmii		= BIT(23),
+		.eth2_clk_sel		= 0,
+		.eth2_ref_clk_sel	= 0,
+		.eth2_sel_rgmii		= 0,
+		.eth2_sel_rmii		= 0
+	}
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
-- 
2.25.1

