Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB07812C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443554AbjLNJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443561AbjLNJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:49:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDAA118;
        Thu, 14 Dec 2023 01:49:04 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8k2hR017630;
        Thu, 14 Dec 2023 09:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=g1/PSi7VGkjdeLX+7/20eelyP/TKgqeOerVb/AB4m5E=; b=Q+
        6Kucqe6Hyr1jN9o+GdfITFsebJQfe4JJcWN/rbWE930l+NT+nsBWplPb6pljGKHW
        bS1Aw3AZKsfxkg6y1yFucFRLNMDOLlfXENFeN7mAa8FTt1ZlTN30lYKVofCYAMVc
        O8Yb+4czgyFpEk9/KptwgLOuA19NM8W5ndqTjnFCEQj2Qg/BP5+B4pYmqwd0ky12
        z/xxplvMLZr+0Fli5lPXC3HMwwNPtmmzkVArdnxmNdR+ku1rptOYhz8dQ2iKlVSL
        t2vUzhMjadeCajCwlUJQed+E9pUc6f3oSOtjuhCQhii+WZTID1Vf3fHbqa+Vxr9O
        W1Q6XiEmixoNxhzoOWGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uytn68jwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9mn8e016536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:49 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:48:45 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 05/14] net: phy: at803x: Add qca8084_config_init function
Date:   Thu, 14 Dec 2023 17:48:04 +0800
Message-ID: <20231214094813.24690-6-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214094813.24690-1-quic_luoj@quicinc.com>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QRAe3tA68AcDDTlUQBoC24ioP5h0tAK_
X-Proofpoint-ORIG-GUID: QRAe3tA68AcDDTlUQBoC24ioP5h0tAK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure MSE detect threshold and ADC clock edge invert.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 143f0d2e36a6..ba5d069ad351 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -280,6 +280,15 @@
 #define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
 #define QCA8081_PHY_FIFO_RSTN			BIT(11)
 
+/* QCA8084 ADC clock edge */
+#define QCA8084_ADC_CLK_SEL			0x8b80
+#define QCA8084_ADC_CLK_SEL_ACLK		GENMASK(7, 4)
+#define QCA8084_ADC_CLK_SEL_ACLK_FALL		0xf
+#define QCA8084_ADC_CLK_SEL_ACLK_RISE		0x0
+
+#define QCA8084_MSE_THRESHOLD			0x800a
+#define QCA8084_MSE_THRESHOLD_2P5G_VAL		0x51c6
+
 MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
@@ -2085,6 +2094,26 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
+static int qca8084_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Invert ADC clock edge */
+	ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
+				    QCA8084_ADC_CLK_SEL_ACLK,
+				    FIELD_PREP(QCA8084_ADC_CLK_SEL_ACLK,
+					       QCA8084_ADC_CLK_SEL_ACLK_FALL));
+	if (ret < 0)
+		return ret;
+
+	/* Adjust MSE threshold value to avoid link issue with
+	 * some link partner.
+	 */
+	return phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+			     QCA8084_MSE_THRESHOLD,
+			     QCA8084_MSE_THRESHOLD_2P5G_VAL);
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2281,6 +2310,7 @@ static struct phy_driver at803x_driver[] = {
 	.soft_reset		= qca808x_soft_reset,
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.config_init		= qca8084_config_init,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.42.0

