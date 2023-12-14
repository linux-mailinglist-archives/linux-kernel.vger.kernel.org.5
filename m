Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABF812C27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443577AbjLNJuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443561AbjLNJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:49:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84CB171D;
        Thu, 14 Dec 2023 01:49:27 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8SjSS011003;
        Thu, 14 Dec 2023 09:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=s+ow7T+OuUMlBNecjU0aO/QVMPc5Mr6UNh605j+9AnI=; b=gX
        zbEMq0+xr6UQdvcCfF+ylpw3PCRuDMXNdPWeA4AuWQclAzduepNc8oqPcRtsTmIc
        ohHCMvN8dKg6KuMMMvz+x3T2CCyZFIc0tAYfwHNoW/Y6qGsR6I2MNgze97PJ2M0z
        +bmZc//4V8e+ahazTfpgJibrBQQi7brWPk3n9x/yL0arnuJTty3tyYXIoPO7pidD
        5xDGWlYEQCg7aGG8DQDzRpmTjzHChtmkJZxlsIaZgdGqvk4Pl0BoEVoIo/IxX3PP
        0/CWRp+1KsMXYB0yL98fWh1nuPM5UY1q2HhzBhNZs9tMRsaqmGa3QWVMBU1Nlgw+
        X346Bs6botVzTRXCZArA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyp0p92w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9nCep008859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:12 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:49:08 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 10/14] net: phy: at803x: parse qca8084 clocks and resets
Date:   Thu, 14 Dec 2023 17:48:09 +0800
Message-ID: <20231214094813.24690-11-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: p5TAOuoHTDqpWvnniRSjaspXoQ2u5gLa
X-Proofpoint-GUID: p5TAOuoHTDqpWvnniRSjaspXoQ2u5gLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
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

These clock and reset IDs are needed to bring up qca8084,
after the initializations with these clocks and resets,
the PHY function can be accessed correctly such as reading
the capabilities of PHY.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index a00c5950683c..6a7a7111ff68 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -21,6 +21,8 @@
 #include <linux/phylink.h>
 #include <linux/sfp.h>
 #include <dt-bindings/net/qca-ar803x.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
 
 #define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
 #define AT803X_SFC_ASSERT_CRS			BIT(11)
@@ -337,6 +339,31 @@ static struct at803x_hw_stat at803x_hw_stats[] = {
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
 };
 
+enum {
+	SRDS0_SYS_CLK,
+	SRDS1_SYS_CLK,
+	GEPHY0_SYS_CLK,
+	GEPHY1_SYS_CLK,
+	GEPHY2_SYS_CLK,
+	GEPHY3_SYS_CLK,
+	QCA8084_CLK_CNT
+};
+
+enum {
+	SRDS0_SYS_RESET,
+	SRDS1_SYS_RESET,
+	GEPHY0_SYS_RESET,
+	GEPHY1_SYS_RESET,
+	GEPHY2_SYS_RESET,
+	GEPHY3_SYS_RESET,
+	GEPHY0_RESET,
+	GEPHY1_RESET,
+	GEPHY2_RESET,
+	GEPHY3_RESET,
+	GEPHY_DSP_RESET,
+	QCA8084_RESET_CNT,
+};
+
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
@@ -348,6 +375,8 @@ struct at803x_priv {
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
 	u64 stats[ARRAY_SIZE(at803x_hw_stats)];
+	struct clk *clk[QCA8084_CLK_CNT];
+	struct reset_control *reset[QCA8084_RESET_CNT];
 };
 
 struct at803x_context {
@@ -359,6 +388,29 @@ struct at803x_context {
 	u16 led_control;
 };
 
+static const char *const qca8084_clock_name[QCA8084_CLK_CNT] = {
+	"srds0_sys",
+	"srds1_sys",
+	"gephy0_sys",
+	"gephy1_sys",
+	"gephy2_sys",
+	"gephy3_sys",
+};
+
+static const char *const qca8084_reset_name[QCA8084_RESET_CNT] = {
+	"srds0_sys",
+	"srds1_sys",
+	"gephy0_sys",
+	"gephy1_sys",
+	"gephy2_sys",
+	"gephy3_sys",
+	"gephy0_soft",
+	"gephy1_soft",
+	"gephy2_soft",
+	"gephy3_soft",
+	"gephy_dsp",
+};
+
 static int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
 {
 	int ret;
@@ -1007,8 +1059,45 @@ static int qca8084_parse_and_set_phyaddr(struct phy_device *phydev)
 				  FIELD_PREP(QCA8084_PCS_ADDR2_MASK, addr[6]));
 }
 
+static int qca8084_parse_dt(struct phy_device *phydev)
+{
+	struct at803x_priv *priv;
+	int i;
+
+	priv = phydev->priv;
+	for (i = 0; i < QCA8084_CLK_CNT; i++) {
+		priv->clk[i] = devm_clk_get_optional(&phydev->mdio.dev,
+						     qca8084_clock_name[i]);
+		if (IS_ERR(priv->clk[i])) {
+			phydev_err(phydev, "failed to get the clock ID %s!\n",
+				   qca8084_clock_name[i]);
+
+			return PTR_ERR(priv->clk[i]);
+		}
+	}
+
+	for (i = 0; i < QCA8084_RESET_CNT; i++) {
+		priv->reset[i] = devm_reset_control_get_optional_exclusive(&phydev->mdio.dev,
+									   qca8084_reset_name[i]);
+		if (IS_ERR(priv->reset[i])) {
+			phydev_err(phydev, "failed to get the reset ID %s!\n",
+				   qca8084_reset_name[i]);
+
+			return PTR_ERR(priv->reset[i]);
+		}
+	}
+
+	return 0;
+}
+
 static int qca8084_probe(struct phy_device *phydev)
 {
+	int ret;
+
+	ret = qca8084_parse_dt(phydev);
+	if (ret)
+		return ret;
+
 	return qca8084_parse_and_set_phyaddr(phydev);
 }
 
-- 
2.42.0

