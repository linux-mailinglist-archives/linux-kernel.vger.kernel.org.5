Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B497EBBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjKOD0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjKOD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:26:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BB19B;
        Tue, 14 Nov 2023 19:26:06 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF3Lo3Z008375;
        Wed, 15 Nov 2023 03:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=O+r/QUVB8p8TWgjozl8j1jVqBSLMm3BZZWtNsTb3ONc=;
 b=HxYpcMF9E9sBP8C5s8R0HFpLzBOX4io9g+WgSpNK71dfEA53EWNmhNAd6fUawktPQNiX
 NM5ynQz50Jg2REnThGL63GwcNDMtWu0OcJ8ogLSaVk2Qh4/cWQgC0e8tL1+k5T7k1eFn
 jknaOm2ingx+6vpxvSdvMHrm1kxaeqV6QxQTLI4yixz9CT657EKBQv2sSBnyaIGfk+5S
 LDLp0m/2RzfAL4+Xim9k/lgZlG17hLSHvCKCdYDK0uFCVua6ORZ0ClGLUD5fzs9h7TIO
 FYsRB3Bi461qCPK4w2OqCYHXKjGrr0bq9DpSZdpTQAGBRgFL/dQLc/MYGYclus7SRSNh ug== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucanq1p5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3PlS1029422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:47 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:25:43 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH 4/9] net: mdio: ipq4019: configure CMN PLL clock for ipq5332
Date:   Wed, 15 Nov 2023 11:25:10 +0800
Message-ID: <20231115032515.4249-5-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115032515.4249-1-quic_luoj@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wyYnLN_03bhCuy1ekVAYsS-deXv0rofL
X-Proofpoint-ORIG-GUID: wyYnLN_03bhCuy1ekVAYsS-deXv0rofL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference clock of CMN PLL block is selectable, the internal
48MHZ is used by default.

The output clock of CMN PLL block is for providing the clock
source of ethernet device(such as qca8084), there are 1 X 25MHZ
and 3 x 50MHZ output clocks available.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 81 ++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 93ae4684de31..ca9cda98d1f8 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -43,6 +43,13 @@
 /* Maximum SOC PCS(uniphy) number on IPQ platform */
 #define ETH_LDO_RDY_CNT				3
 
+#define CMN_PLL_REFERENCE_CLOCK			0x784
+#define CMN_PLL_REFCLK_INDEX			GENMASK(3, 0)
+#define CMN_PLL_REFCLK_EXTERNAL			BIT(9)
+
+#define CMN_PLL_POWER_ON_AND_RESET		0x780
+#define CMN_ANA_EN_SW_RSTN			BIT(6)
+
 enum mdio_clk_id {
 	MDIO_CLK_MDIO_AHB,
 	MDIO_CLK_UNIPHY0_AHB,
@@ -54,6 +61,7 @@ enum mdio_clk_id {
 
 struct ipq4019_mdio_data {
 	void __iomem *membase;
+	void __iomem *cmn_membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *clk[MDIO_CLK_CNT];
 	struct gpio_descs *reset_gpios;
@@ -227,12 +235,73 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+/* For the CMN PLL block, the reference clock can be configured according to
+ * the device tree property "cmn_ref_clk", the internal 48MHZ is used by default
+ * on the ipq533 platform.
+ *
+ * The output clock of CMN PLL block is provided to the MDIO slave devices,
+ * threre are 4 CMN PLL output clocks (1x25MHZ + 3x50MHZ) enabled by default.
+ *
+ * such as the output 50M clock for the qca8084 PHY.
+ */
+static void ipq_cmn_clock_config(struct mii_bus *bus)
+{
+	u32 reg_val;
+	const char *cmn_ref_clk;
+	struct ipq4019_mdio_data *priv = bus->priv;
+
+	if (priv && priv->cmn_membase) {
+		reg_val = readl(priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
+		reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_INDEX);
+
+		/* Select reference clock source */
+		cmn_ref_clk = of_get_property(bus->parent->of_node, "cmn_ref_clk", NULL);
+		if (!cmn_ref_clk) {
+			/* Internal 48MHZ selected by default */
+			reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
+		} else {
+			if (!strcmp(cmn_ref_clk, "external_25MHz"))
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 3));
+			else if (!strcmp(cmn_ref_clk, "external_31250KHz"))
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 4));
+			else if (!strcmp(cmn_ref_clk, "external_40MHz"))
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 6));
+			else if (!strcmp(cmn_ref_clk, "external_48MHz"))
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7));
+			else if (!strcmp(cmn_ref_clk, "external_50MHz"))
+				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
+					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 8));
+			else
+				reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
+		}
+
+		writel(reg_val, priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
+
+		/* assert CMN PLL */
+		reg_val = readl(priv->cmn_membase + CMN_PLL_POWER_ON_AND_RESET);
+		reg_val &= ~CMN_ANA_EN_SW_RSTN;
+		writel(reg_val, priv->cmn_membase);
+		fsleep(IPQ_PHY_SET_DELAY_US);
+
+		/* deassert CMN PLL */
+		reg_val |= CMN_ANA_EN_SW_RSTN;
+		writel(reg_val, priv->cmn_membase + CMN_PLL_POWER_ON_AND_RESET);
+		fsleep(IPQ_PHY_SET_DELAY_US);
+	}
+}
+
 static int ipq_mdio_reset(struct mii_bus *bus)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
 	u32 val;
 	int ret;
 
+	ipq_cmn_clock_config(bus);
+
 	/* For the platform ipq5332, there are two uniphy available to connect the
 	 * ethernet devices, the uniphy gcc clock should be enabled for resetting
 	 * the connected device such as qca8386 switch or qca8081 PHY effectively.
@@ -328,11 +397,21 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	/* This resource is optional */
 	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, ret + 1);
-		if (res)
+		if (res && strcmp(res->name, "cmn_blk"))
 			priv->eth_ldo_rdy[ret] = devm_ioremap(&pdev->dev,
 							      res->start, resource_size(res));
 	}
 
+	/* The CMN block resource is for providing clock source of ethernet, which can
+	 * be optionally configured on the platform ipq9574 and ipq5332.
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cmn_blk");
+	if (res) {
+		priv->cmn_membase = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->cmn_membase))
+			return PTR_ERR(priv->cmn_membase);
+	}
+
 	for (ret = 0; ret < MDIO_CLK_CNT; ret++) {
 		priv->clk[ret] = devm_clk_get_optional(&pdev->dev, mdio_clk_name[ret]);
 		if (IS_ERR(priv->clk[ret]))
-- 
2.42.0

