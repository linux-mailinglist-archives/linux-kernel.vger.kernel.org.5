Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A1756341
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGQMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGQMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:52:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56B10EB;
        Mon, 17 Jul 2023 05:52:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5To5W020411;
        Mon, 17 Jul 2023 05:52:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=B0B2UkwrlR8/ITllxIICBikh3e+ZFBoBhtiHMBEoz5w=;
 b=XBYFciOwwYwVH3Wljb6uNE1I1e57LhewhHAqmBM6vLZbvQmo1wHpC+CA8t/VLSGsyD/p
 UUM5F6vVl5SEo4Gp8LFmKAYWumgonN5+u/KIXuEFbnqNV1qi4txQYS2TqpJAK4HDwhMe
 X1Oq/bG8wju/HvH9hP+SHTi1ju0a2+WtFPSuwQjdo0QPR7zvHHcexO05VIsdcinG9a+T
 IgT1z+jU7TByKfMW8jq6xegkictXYIlXqOqK3Xe5JnRqgYFDfoTgpwBqlqe+kRuRIv+Y
 zFpgA+ZAeq2OtW32MQ73Y+rBkvtwosxvphUToPQDsJILC8zM9lPMVR+lvCAJw+8gXMCS Uw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx18m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:52:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 05:52:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 05:52:32 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 063983F70A4;
        Mon, 17 Jul 2023 05:52:32 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Dhananjay Kangude <dkangude@cadence.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v4 2/6] mmc: sdhci-cadence: Restructure the code
Date:   Mon, 17 Jul 2023 05:51:42 -0700
Message-ID: <20230717125146.16791-3-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717125146.16791-1-pmalgujar@marvell.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1PVt1DBObmhf4uSzEEYF63fg_obyPcr5
X-Proofpoint-ORIG-GUID: 1PVt1DBObmhf4uSzEEYF63fg_obyPcr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_10,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhananjay Kangude <dkangude@cadence.com>

Restructured the code, added controller version specific init for
SD4 operations with no change to existing functionality.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 76 ++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 9bb38281bcb244b0be91ef579046c40de7a06e1f..98fe752bcf27a71607623f3cb1c36f1a16d688a4 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -60,11 +60,17 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
+struct sdhci_cdns_priv;
+
 struct sdhci_cdns_sd4_phy_param {
 	u8 addr;
 	u8 data;
 };
 
+struct sdhci_cdns_sd4_phy {
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_sd4_phy_param phy_params[];
+};
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	void __iomem *ctl_addr;	/* write control */
@@ -72,8 +78,8 @@ struct sdhci_cdns_priv {
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	struct reset_control *rst_hw;
-	unsigned int nr_phy_params;
-	struct sdhci_cdns_sd4_phy_param phy_params[];
+	const struct sdhci_cdns_drv_data *cdns_data;
+	void *phy;
 };
 
 struct sdhci_cdns_sd4_phy_cfg {
@@ -83,6 +89,8 @@ struct sdhci_cdns_sd4_phy_cfg {
 
 struct sdhci_cdns_drv_data {
 	int (*init)(struct platform_device *pdev);
+	int (*phy_init)(struct sdhci_cdns_priv *priv);
+	int (*phy_probe)(struct platform_device *pdev, struct sdhci_cdns_priv *priv);
 	const struct sdhci_pltfm_data pltfm_data;
 };
 
@@ -151,9 +159,9 @@ static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
 }
 
 static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
-					   struct sdhci_cdns_priv *priv)
+					   struct sdhci_cdns_sd4_phy *phy)
 {
-	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
+	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
 	u32 val;
 	int ret, i;
 
@@ -172,10 +180,11 @@ static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
 static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
+	struct sdhci_cdns_sd4_phy *phy = priv->phy;
 
-	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
-						   priv->phy_params[i].data);
+	for (i = 0; i < phy->nr_phy_params; i++) {
+		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
+						   phy->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -218,6 +227,27 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
 }
 
+static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
+				    struct sdhci_cdns_priv *priv)
+{
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_sd4_phy *phy;
+	struct device *dev = &pdev->dev;
+
+	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
+	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
+			   GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->nr_phy_params = nr_phy_params;
+
+	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
+	priv->phy = phy;
+
+	return 0;
+}
+
 static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
@@ -420,6 +450,8 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
 };
 
 static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
+	.phy_init = sdhci_cdns_sd4_phy_init,
+	.phy_probe = sdhci_cdns_sd4_phy_probe,
 	.pltfm_data = {
 	.ops = &sdhci_cdns_sd4_ops,
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
@@ -428,12 +460,16 @@ static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
 
 static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
 	.init = elba_drv_init,
+	.phy_init = sdhci_cdns_sd4_phy_init,
+	.phy_probe = sdhci_cdns_sd4_phy_probe,
 	.pltfm_data = {
 		.ops = &sdhci_elba_ops,
 	},
 };
 
 static const struct sdhci_cdns_drv_data sdhci_cdns_sd4_drv_data = {
+	.phy_init = sdhci_cdns_sd4_phy_init,
+	.phy_probe = sdhci_cdns_sd4_phy_probe,
 	.pltfm_data = {
 		.ops = &sdhci_cdns_sd4_ops,
 	},
@@ -482,7 +518,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -496,12 +531,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 		return ret;
 
 	data = of_device_get_match_data(dev);
-	if (!data)
-		data = &sdhci_cdns_sd4_drv_data;
+	if (!data) {
+		ret = -EINVAL;
+		goto disable_clk;
+	}
 
-	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
-				struct_size(priv, phy_params, nr_phy_params));
+	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto disable_clk;
@@ -511,10 +546,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
 	priv->priv_writel = cdns_writel;
+	priv->cdns_data = data;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
@@ -532,9 +567,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
+	ret = data->phy_probe(pdev, priv);
+	if (ret)
+		goto free;
 
-	ret = sdhci_cdns_sd4_phy_init(priv);
+	ret = priv->cdns_data->phy_init(priv);
 	if (ret)
 		goto free;
 
@@ -574,7 +611,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_sd4_phy_init(priv);
+	ret = priv->cdns_data->phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
@@ -604,7 +641,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "amd,pensando-elba-sd4hc",
 		.data = &sdhci_elba_drv_data,
 	},
-	{ .compatible = "cdns,sd4hc" },
+	{
+		.compatible = "cdns,sd4hc",
+		.data = &sdhci_cdns_sd4_drv_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
-- 
2.17.1

