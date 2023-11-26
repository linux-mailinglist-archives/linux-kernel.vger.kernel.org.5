Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957077F9199
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 07:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjKZGJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 01:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjKZGIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 01:08:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269211D;
        Sat, 25 Nov 2023 22:08:43 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQ60BtW023312;
        Sun, 26 Nov 2023 06:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=lS/O/ANo9EsSWeo3/3mKUSbDHP/ElCBmzowwBa2lrmI=;
 b=Cf3GnrnNArki201mPuFsvC8Io8AGojVDA6zAdg0B5jM5hg5quzqxi3+MCQjFh9slOb1B
 NMysZckhanZd2AOu2rIVP96c7Sdufm9IGu2y56nsgqLzjW9S/vUExYWdP0kEw+KqY3mb
 TLOyVckYg/LHx09G7r1CSk5CTI5IAHhjzC80qQ396z29WiedTtTuuwDWDas67gtyDZwp
 b1rGOVKChCaNHXDOiX1Vxf+HaQxXHZCHLfdbzQXRICptGu9ZLON3Gemo44UO3oYeJwxn
 x+DvokT8IgiZ5l0lKNTDwuFZmpjG8HD4hmPcHuKk/CJ4htaM/l8fE29qDbMCsCAlI60p oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk6mnt0mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 06:08:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AQ68P3i006673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Nov 2023 06:08:25 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 25 Nov 2023 22:08:22 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v6 5/6] net: phy: at803x: Add qca8084_config_init function
Date:   Sun, 26 Nov 2023 14:07:31 +0800
Message-ID: <20231126060732.31764-6-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126060732.31764-1-quic_luoj@quicinc.com>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 36l3uaf0DfD1sQ6GdQ6w98TdezKqhG1r
X-Proofpoint-GUID: 36l3uaf0DfD1sQ6GdQ6w98TdezKqhG1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311260042
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
index 430547f304f7..c0d5d4410e89 100644
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
@@ -2282,6 +2311,7 @@ static struct phy_driver at803x_driver[] = {
 	.soft_reset		= qca808x_soft_reset,
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.config_init		= qca8084_config_init,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.42.0

