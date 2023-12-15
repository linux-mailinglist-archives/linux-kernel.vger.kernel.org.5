Return-Path: <linux-kernel+bounces-554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE618142DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700C21C223F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8E2DB90;
	Fri, 15 Dec 2023 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXbJe/p4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7C2DB6A;
	Fri, 15 Dec 2023 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4l7vh001949;
	Fri, 15 Dec 2023 07:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=0tzAijJ2T6jjsc1+KfY3s2c76n6zIbSFI1AZ27K6OBk=; b=DX
	bJe/p4+bqziCDouNg9vbGBUb+BNJpTOy9n01tK04586nrjLieyVj++gJqtzQ9c4n
	inO4o+jF5C32e8/eUoyIYvEPiEAQFAW1vGK0hIQH0T67b5PzbvfshQMCSYr6uS4z
	xbGa1LTvhf9dl6mEtwWTkaZrApyZ3I7mqa+Mhk1J32q4lCYA3gGGUV71YUIiBvTw
	5SukO/sBX5Ja8FGL8E228CvAbQPBVdkFO1aZuSFeg58ayWxlZtG0tLPYtamvHhZT
	vVt9YoyS6pwvX/bPSa2oaN12csUdWvR56THc9dp/l0xnTG0gs3DdaZ5lfCZfWDsO
	EZswhtEyoBsPcp/8xGDA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v05jqhhds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7fA7T023137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:10 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:41:06 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 10/14] net: phy: at803x: parse qca8084 clocks and resets
Date: Fri, 15 Dec 2023 15:40:00 +0800
Message-ID: <20231215074005.26976-11-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215074005.26976-1-quic_luoj@quicinc.com>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OLesixKOsNH-XVeCyfJ7bjwkc9o125RD
X-Proofpoint-GUID: OLesixKOsNH-XVeCyfJ7bjwkc9o125RD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150047

These clock and reset IDs are needed to bring up qca8084,
after the initializations with these clocks and resets,
the PHY function can be accessed correctly such as reading
the capabilities of PHY.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 87 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index c8830898ce2e..4c884d6b60bc 100644
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
@@ -337,6 +339,52 @@ static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
 };
 
+enum {
+	SRDS0_SYS_CLK,
+	SRDS1_SYS_CLK,
+	GEPHY0_SYS_CLK,
+	GEPHY1_SYS_CLK,
+	GEPHY2_SYS_CLK,
+	GEPHY3_SYS_CLK,
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
+};
+
+static const char *const qca8084_clock_name[] = {
+	"srds0_sys",
+	"srds1_sys",
+	"gephy0_sys",
+	"gephy1_sys",
+	"gephy2_sys",
+	"gephy3_sys",
+};
+
+static const char *const qca8084_reset_name[] = {
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
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
@@ -348,6 +396,8 @@ struct at803x_priv {
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
 	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
+	struct clk *clk[ARRAY_SIZE(qca8084_clock_name)];
+	struct reset_control *reset[ARRAY_SIZE(qca8084_reset_name)];
 };
 
 struct at803x_context {
@@ -816,8 +866,45 @@ static int qca8084_parse_and_set_phyaddr(struct phy_device *phydev)
 				  FIELD_PREP(QCA8084_PCS_ADDR2_MASK, addr[6]));
 }
 
+static int qca8084_parse_dt(struct phy_device *phydev)
+{
+	struct at803x_priv *priv;
+	int i;
+
+	priv = phydev->priv;
+	for (i = 0; i < ARRAY_SIZE(qca8084_clock_name); i++) {
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
+	for (i = 0; i < ARRAY_SIZE(qca8084_reset_name); i++) {
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


