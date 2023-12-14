Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12DB812C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443575AbjLNJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443650AbjLNJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:50:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FBF19B1;
        Thu, 14 Dec 2023 01:49:35 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE4qC9p028409;
        Thu, 14 Dec 2023 09:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=UPSQOuBh14dqy+VE2CjEh9qgLnMj8uBsrhetcQjZ3IU=; b=jq
        5c+gON2jdEBM5olU312eYmoqhMK35j6nmuOxZChmejvRbSuvn7FInxLILw+DirSs
        yw4jY/ic+NmvoIU+CHPvXFSPEQxkvl5vyrH+Ai/t+O6Qp254T/y63wSGdrK72Jk7
        66G/WmFaiuCZcZdfiM+zBxXlB5Cu3chInu1TLC3AzQG4MQx7o/WLkUecLUsi4WfZ
        Lk8q02PwuHM5LhBkqHNVhzVP3JMeA8h0T87irlzO2ccBr1YS7GOFl9aJa849nYgg
        wgUj7ARq01gFT63rdQNRN+zuoewo5QMGxCtK5U+D3Hn1mdmaLKN5KkHe03JJQI/w
        GFdmQRc0dPFZF+0D6Ccg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uytn68jy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:22 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9nLw6007213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:49:21 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:49:17 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 12/14] net: phy: at803x: configure qca8084 common clocks
Date:   Thu, 14 Dec 2023 17:48:11 +0800
Message-ID: <20231214094813.24690-13-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: xl1nKYK7jXxhSbPAdIJ-EWH0Wf5GjBxP
X-Proofpoint-ORIG-GUID: xl1nKYK7jXxhSbPAdIJ-EWH0Wf5GjBxP
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

After initial clock sequence, the clock source 312.5MHZ is
available, the common clocks based on clock source 312.5MHZ
needs to be configured, which includes APB bridge clock tree
with rate 312.5MHZ, AHB clock tree with 104.17MHZ.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 69 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 204f5ca6001c..4499d78891d2 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -340,6 +340,14 @@ static struct at803x_hw_stat at803x_hw_stats[] = {
 };
 
 enum {
+	APB_BRIDGE_CLK,
+	AHB_CLK,
+	SEC_CTRL_AHB_CLK,
+	TLMM_CLK,
+	TLMM_AHB_CLK,
+	CNOC_AHB_CLK,
+	MDIO_AHB_CLK,
+	MDIO_MASTER_AHB_CLK,
 	SRDS0_SYS_CLK,
 	SRDS1_SYS_CLK,
 	GEPHY0_SYS_CLK,
@@ -389,6 +397,14 @@ struct at803x_context {
 };
 
 static const char *const qca8084_clock_name[QCA8084_CLK_CNT] = {
+	"apb_bridge",
+	"ahb",
+	"sec_ctrl_ahb",
+	"tlmm",
+	"tlmm_ahb",
+	"cnoc_ahb",
+	"mdio_ahb",
+	"mdio_master_ahb",
 	"srds0_sys",
 	"srds1_sys",
 	"gephy0_sys",
@@ -1168,6 +1184,53 @@ static int qca8084_clock_config(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8084_common_clock_init(struct phy_device *phydev)
+{
+	struct at803x_priv *priv;
+	int ret = 0;
+
+	priv = phydev->priv;
+	/* Enable APB bridge tree clock */
+	ret = clk_set_rate(priv->clk[APB_BRIDGE_CLK], 312500000);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[APB_BRIDGE_CLK]);
+	if (ret)
+		return ret;
+
+	/* Enable AHB tree clocks */
+	ret = clk_set_rate(priv->clk[AHB_CLK], 104170000);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[SEC_CTRL_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[TLMM_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[TLMM_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[CNOC_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk[MDIO_AHB_CLK]);
+	if (ret)
+		return ret;
+
+	return clk_prepare_enable(priv->clk[MDIO_MASTER_AHB_CLK]);
+}
+
 static int qca8084_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -1180,7 +1243,11 @@ static int qca8084_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return qca8084_clock_config(phydev);
+	ret = qca8084_clock_config(phydev);
+	if (ret)
+		return ret;
+
+	return qca8084_common_clock_init(phydev);
 }
 
 static int at803x_probe(struct phy_device *phydev)
-- 
2.42.0

