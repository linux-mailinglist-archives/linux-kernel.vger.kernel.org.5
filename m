Return-Path: <linux-kernel+bounces-10960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057A281DF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A34281A09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E9D11192;
	Mon, 25 Dec 2023 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cyMf34YJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221210A35;
	Mon, 25 Dec 2023 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP8JdrJ021745;
	Mon, 25 Dec 2023 08:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ds+dFd1j8HAKO33AZwKlWd1wIYwsCZ2yGMitqsnFuuk=; b=cy
	Mf34YJhJsDlX7tAjKR1XQisrqbajzzs0HFV5aY9BnDH2nATaYG1oDyiPcIzaRzRs
	IHjZO+Mt8GNghhwdjU17QOc4NWIK1VzLC9EQfCg3aQbO5TZxI7PlvjZ8wMVKAwr1
	fuBUjzW42ZL+nwUPWznA+jMV+vFacvvohK/J404lhhRIp96pJE9CsANgd2lbli5+
	PMMp5NrAyNw+UMjpoBM6rXCuaPMSyAHA+S0U179PXZfdwIHHmWIzsbw+H6+dK0Om
	bt5ULRNsYoD6cknWTaqILGGsRUjJpjWjBmyxYmsamx3lpA7u8eM89y/qzPFKZUqS
	wt/VMYNE7uDufal24VIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5pvnk9nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:45:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP8j169025554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:45:01 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 00:44:55 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v4 4/5] net: mdio: ipq4019: support MDIO clock frequency divider
Date: Mon, 25 Dec 2023 16:44:23 +0800
Message-ID: <20231225084424.30986-5-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231225084424.30986-1-quic_luoj@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6bd7DwKBOwW7_LqaIPgczliB5npCw0vG
X-Proofpoint-ORIG-GUID: 6bd7DwKBOwW7_LqaIPgczliB5npCw0vG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250066

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
index e4862ac02026..fd41dd7ff9cb 100644
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
 
@@ -69,6 +72,7 @@ struct ipq4019_mdio_data {
 	void __iomem *cmn_membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *clk[MDIO_CLK_CNT];
+	int clk_div;
 };
 
 static const char *const mdio_clk_name[] = {
@@ -102,6 +106,7 @@ static int ipq4019_mdio_read_c45(struct mii_bus *bus, int mii_id, int mmd,
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data |= MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -143,6 +148,7 @@ static int ipq4019_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data &= ~MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -175,6 +181,7 @@ static int ipq4019_mdio_write_c45(struct mii_bus *bus, int mii_id, int mmd,
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data |= MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -218,6 +225,7 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	data = readl(priv->membase + MDIO_MODE_REG);
 
 	data &= ~MDIO_MODE_C45;
+	data |= FIELD_PREP(MDIO_CLK_DIV_MASK, priv->clk_div);
 
 	writel(data, priv->membase + MDIO_MODE_REG);
 
@@ -389,6 +397,39 @@ static int ipq_mdio_reset(struct mii_bus *bus)
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
+	case 390625:
+	case 781250:
+	case 1562500:
+	case 3125000:
+	case 6250000:
+	case 12500000:
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
@@ -451,6 +492,10 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
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


