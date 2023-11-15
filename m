Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D47EBBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjKOD0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjKOD0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:26:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACDFB;
        Tue, 14 Nov 2023 19:25:56 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF3L5sX014969;
        Wed, 15 Nov 2023 03:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=cu5mYA5gW8y3sRa2MF+nXeNHnKrrLIUUFeVbpaiUyy0=;
 b=X7tSIR1I1IwnlQdwVhLd6wgBGIhRVhJEsmkeCiqTsVEPSjXlbiG6ie69ON6TmJQG+ARe
 1RNVeJstzUB+lvNTIOOEFjue2e/XEMpohk7VgUPhzpNd8l74GxcuGsi0VdTacDkEWfeT
 6VYGnABa1odpAjXCSyjDJLaKmbplw7pW9GJAzNgYKBlITsCZAt8ANhVdkmcEch92yxkV
 waQ3oUAVjdhCK9jr1zpz0NmNpCEN6o2ItDqxnSjveOl7xzVUqNzKbVU0DDV7V/WwSPOC
 0c2leb5U+RbyZafvvZcThS3JTeHc0J5hSDDALfakzSiiUMXAcx4YgZ3QURZExjvHJoRc rg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucg2u8sh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:44 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3PhHa016232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:43 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:25:39 -0800
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
Subject: [PATCH 3/9] net: mdio: ipq4019: Enable GPIO reset for ipq5332 platform
Date:   Wed, 15 Nov 2023 11:25:09 +0800
Message-ID: <20231115032515.4249-4-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dMWqGeS7OtRSWS9hgAccMs904vHfMNvj
X-Proofpoint-GUID: dMWqGeS7OtRSWS9hgAccMs904vHfMNvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311150027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before doing GPIO reset on the MDIO slave devices, the common clock
output to MDIO slave device should be enabled, and the related GCC
clocks also need to be configured.

Because of these extra configurations, the MDIO bus level GPIO and
PHY device level GPIO can't be leveraged. Need to add the device
tree property "phy-reset-gpio" of MDIO node to enable this special
GPIO reset.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index a77982a1a1e1..93ae4684de31 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 
 #define MDIO_MODE_REG				0x40
 #define MDIO_ADDR_REG				0x44
@@ -55,6 +56,7 @@ struct ipq4019_mdio_data {
 	void __iomem *membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *clk[MDIO_CLK_CNT];
+	struct gpio_descs *reset_gpios;
 };
 
 const char *const mdio_clk_name[] = {
@@ -275,6 +277,24 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 		}
 	}
 
+	/* Do the optional reset on the devices connected with MDIO bus */
+	if (priv->reset_gpios) {
+		unsigned long *values = bitmap_zalloc(priv->reset_gpios->ndescs, GFP_KERNEL);
+
+		if (!values)
+			return -ENOMEM;
+
+		bitmap_fill(values, priv->reset_gpios->ndescs);
+		gpiod_set_array_value_cansleep(priv->reset_gpios->ndescs, priv->reset_gpios->desc,
+					       priv->reset_gpios->info, values);
+
+		fsleep(IPQ_PHY_SET_DELAY_US);
+		bitmap_zero(values, priv->reset_gpios->ndescs);
+		gpiod_set_array_value_cansleep(priv->reset_gpios->ndescs, priv->reset_gpios->desc,
+					       priv->reset_gpios->info, values);
+		bitmap_free(values);
+	}
+
 	/* Configure MDIO clock source frequency if clock is specified in the device tree */
 	ret = clk_set_rate(priv->clk[MDIO_CLK_MDIO_AHB], IPQ_MDIO_CLK_RATE);
 	if (ret)
@@ -319,6 +339,19 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->clk[ret]);
 	}
 
+	/* This GPIO reset is for qca8084 PHY, which is only probeable by MDIO bus
+	 * after the following steps completed.
+	 *
+	 * 1. Enable LDO to provide clock for qca8084 and enable SoC GCC uniphy related clocks.
+	 * 2. Do GPIO reset on the qca8084 PHY.
+	 * 3. Configure the PHY address that is customized according to device treee.
+	 * 4. Configure the related qca8084 GCC clock & reset.
+	 */
+	priv->reset_gpios = devm_gpiod_get_array_optional(&pdev->dev, "phy-reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset_gpios))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset_gpios),
+				     "mii_bus %s couldn't get reset GPIO\n", bus->id);
+
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
 	bus->write = ipq4019_mdio_write_c22;
-- 
2.42.0

