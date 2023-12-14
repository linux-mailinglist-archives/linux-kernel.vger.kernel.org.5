Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53F812B06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjLNJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjLNJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:03:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC8128;
        Thu, 14 Dec 2023 01:03:57 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE7r0nH024631;
        Thu, 14 Dec 2023 09:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=j8LX1gNGh/L2Ah0w1SWGnU/T78GWoj4IZeRevHwP//Q=; b=V/
        jx01ArYPm/BheCpPCw3NAJmI29QJKbk/GETHO+MLaXT3PTjY/dAej7Sn3vbE4YQB
        dPlc+Cyln/fx2X8GdbP2hYddTwQLfnafxS52kWWY81UNgQWiWgGHEgKhUb3bsQCl
        DT1yvpOoOYGVJSR7Vz1fVKq2jksABhTOSIWcXJLz1XJILH8XWepEUvSmXOWE3Abm
        usFobsD+8rkMX4YUmHKKWqlOFm/XR1o3Fyy9gbJsErnVCock9lbqT0O8sisUVK9o
        fl/7q6iAy8bip13lrllyog+PxO4Bs0jfnhofOXZoW9AJ1QzocEOUONV6Yzol4tCd
        QqJvx1fgQs9J0ZRSfsgg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyq66gv9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE93iVu013308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:44 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:03:39 -0800
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
Subject: [PATCH v3 4/5] net: mdio: ipq4019: support MDIO clock frequency divider
Date:   Thu, 14 Dec 2023 17:03:03 +0800
Message-ID: <20231214090304.16884-5-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214090304.16884-1-quic_luoj@quicinc.com>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iGX63dsK2YnaN6aYFSlvkZLH69MK3yT7
X-Proofpoint-ORIG-GUID: iGX63dsK2YnaN6aYFSlvkZLH69MK3yT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312140058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDIO clock frequency can be divided according to the
MDIO control register value.

The MDIO system clock is fixed to 100MHZ, the working
frequency is 100MHZ/(divider + 1), the divider value
is from the bit[7:0] of control register 0x40.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 3568ce7f48c6..330963026475 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -29,6 +29,9 @@
 /* 0 = Clause 22, 1 = Clause 45 */
 #define MDIO_MODE_C45				BIT(8)
 
+/* MDC frequency is SYS_CLK/(MDIO_CLK_DIV + 1), SYS_CLK is 100MHz */
+#define MDIO_CLK_DIV_MASK			GENMASK(7, 0)
+
 #define IPQ4019_MDIO_TIMEOUT	10000
 #define IPQ4019_MDIO_SLEEP		10
 
@@ -77,6 +80,7 @@ struct ipq4019_mdio_data {
 	void __iomem *cmn_membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *clk[MDIO_CLK_CNT];
+	int clk_div;
 };
 
 static const char *const mdio_clk_name[] = {
@@ -110,6 +114,7 @@ static int ipq4019_mdio_read_c45(struct mii_bus *bus, int mii_id, int mmd,
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data |= MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -151,6 +156,7 @@ static int ipq4019_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data &= ~MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -183,6 +189,7 @@ static int ipq4019_mdio_write_c45(struct mii_bus *bus, int mii_id, int mmd,
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data |= MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -226,6 +233,7 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data &= ~MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -397,6 +405,39 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 	return ret;
 }
 
+static int ipq_mdio_clk_set(struct platform_device *pdev, int *clk_div)
+{
+	int freq;
+
+	/* Keep the MDIO clock divider as the hardware default value 0xff if
+	 * the MDIO property "clock-frequency" is not specified.
+	 */
+	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency", &freq)) {
+		*clk_div = 0xff;
+		return 0;
+	}
+
+	/* MDC frequency is SYS_CLK/(MDIO_CLK_DIV + 1), SYS_CLK is fixed
+	 * to 100MHz, the MDIO_CLK_DIV can be only configured the valid
+	 * values, other values cause malfunction.
+	 */
+	switch (freq) {
+	case 12500000:
+	case 6250000:
+	case 3125000:
+	case 1562500:
+	case 781250:
+	case 390625:
+		*clk_div = DIV_ROUND_UP(IPQ_MDIO_CLK_RATE, freq) - 1;
+		break;
+	default:
+		dev_err(&pdev->dev, "Invalid clock frequency %dHZ\n", freq);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ipq4019_mdio_probe(struct platform_device *pdev)
 {
 	struct ipq4019_mdio_data *priv;
@@ -459,6 +500,10 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->clk[index]);
 	}
 
+	ret = ipq_mdio_clk_set(pdev, &priv->clk_div);
+	if (ret)
+		return ret;
+
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
 	bus->write = ipq4019_mdio_write_c22;
-- 
2.42.0

