Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF04812C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443679AbjLNJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443458AbjLNJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:49:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E281994;
        Thu, 14 Dec 2023 01:49:31 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8SPg7014660;
        Thu, 14 Dec 2023 09:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=MRC8Z48TOdwwqp4jcexel6jg2C4JQxWltiNljtKZ+2w=; b=Hw
        UP/3IYfG4iZQhyseKDYkuhKqEEGEqA7i++NIGURiu+96L0Glbp11sMfZy6rA9Heh
        J1+eC1aXSS9uYsf3g6LxebAZjvWq529dP6m0tBxcJwZVCQSWiP68Cvkl+F8gCHat
        RMckNvrKJCNuqxeIMW7t3yh2Z72+8L/9KhLPCoLFg2mnP+5dSVPRkMtA+FYMI3z5
        vzYqzcbhJ4Q7jMCyiLbauQuBCKpA3ONJrGu0Vx93Q8k8h7fb4uOQAUmp51NlK4HG
        XnvjlNcoG8x1mP/hf2/j0DlCE5Bl3WOCc4hiUc/dWs3wQBXh/HK1TPnllOvSNosf
        SieUtNlRcNQIi7B3s6Bw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uytn68jxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9nHTL024433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:17 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:49:12 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 11/14] net: phy: at803x: add qca808x initial config sequence
Date:   Thu, 14 Dec 2023 17:48:10 +0800
Message-ID: <20231214094813.24690-12-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: WwWodg1rUzi9iUBdMCKl9kvLIYZ0l01Q
X-Proofpoint-ORIG-GUID: WwWodg1rUzi9iUBdMCKl9kvLIYZ0l01Q
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

After GPIO reset, these Ethernet clock sequence needs to be
configured before reading the features of PHY, the Ethernet
system clock works on 25MHZ.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 84 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 6a7a7111ff68..204f5ca6001c 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1090,6 +1090,84 @@ static int qca8084_parse_dt(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8084_clock_config(struct phy_device *phydev)
+{
+	struct at803x_priv *priv;
+	int ret = 0;
+
+	/* The ethernet clock IDs are only defined in one PHY device
+	 * tree node, and these ethernet clocks only needs to be configured
+	 * one time, which work on the clock rate 25MHZ.
+	 */
+	priv = phydev->priv;
+	if (!priv->clk[SRDS0_SYS_CLK])
+		return 0;
+
+	ret = clk_set_rate(priv->clk[SRDS0_SYS_CLK], 25000000);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[SRDS0_SYS_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[SRDS1_SYS_CLK]);
+	if (ret)
+		return ret;
+
+	/* Reset PCS system clocks */
+	reset_control_assert(priv->reset[SRDS0_SYS_RESET]);
+	reset_control_assert(priv->reset[SRDS1_SYS_RESET]);
+	fsleep(20000);
+
+	reset_control_deassert(priv->reset[SRDS0_SYS_RESET]);
+	reset_control_deassert(priv->reset[SRDS1_SYS_RESET]);
+
+	ret = clk_prepare_enable(priv->clk[GEPHY0_SYS_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[GEPHY1_SYS_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[GEPHY2_SYS_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[GEPHY3_SYS_CLK]);
+	if (ret)
+		return ret;
+
+	/* Reset ethernet system clocks */
+	reset_control_assert(priv->reset[GEPHY0_SYS_RESET]);
+	reset_control_assert(priv->reset[GEPHY1_SYS_RESET]);
+	reset_control_assert(priv->reset[GEPHY2_SYS_RESET]);
+	reset_control_assert(priv->reset[GEPHY3_SYS_RESET]);
+	fsleep(20000);
+
+	reset_control_deassert(priv->reset[GEPHY0_SYS_RESET]);
+	reset_control_deassert(priv->reset[GEPHY1_SYS_RESET]);
+	reset_control_deassert(priv->reset[GEPHY2_SYS_RESET]);
+	reset_control_deassert(priv->reset[GEPHY3_SYS_RESET]);
+
+	/* Release ethernet DSP reset */
+	reset_control_deassert(priv->reset[GEPHY0_RESET]);
+	reset_control_deassert(priv->reset[GEPHY1_RESET]);
+	reset_control_deassert(priv->reset[GEPHY2_RESET]);
+	reset_control_deassert(priv->reset[GEPHY3_RESET]);
+	reset_control_deassert(priv->reset[GEPHY_DSP_RESET]);
+
+	/* Enable efuse loading into analog circuit */
+	ret = qca8084_mii_modify(phydev, QCA8084_EPHY_CFG,
+				 QCA8084_EPHY_LDO_EN, 0);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+	return 0;
+}
+
 static int qca8084_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -1098,7 +1176,11 @@ static int qca8084_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return qca8084_parse_and_set_phyaddr(phydev);
+	ret = qca8084_parse_and_set_phyaddr(phydev);
+	if (ret)
+		return ret;
+
+	return qca8084_clock_config(phydev);
 }
 
 static int at803x_probe(struct phy_device *phydev)
-- 
2.42.0

