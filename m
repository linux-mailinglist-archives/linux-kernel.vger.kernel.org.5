Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400C978DF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbjH3TKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbjH3LSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:18:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B65107;
        Wed, 30 Aug 2023 04:18:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U7xKhP014991;
        Wed, 30 Aug 2023 11:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=k6QLoHlj8WinEN6FqEZMCt5GHhCWBgjz+opIPw8+8Uo=;
 b=UxaCSFpmpJ8lsXHkLWSGZkqcEAdBOUIUqEphbPb4L3iYo9lUmoJWAMX8/xm1xtPEFeq6
 AgSyE20AJIC4qDf5Cnudxgphm6T7/LBwWjbPvaL6mAjFD43LPXHGNUKw0SoCPGxZzB6R
 Ejr0yQqoBIF0/rXXOO3wO39BYGsbMSdEejtkmi6070i4VSXtfehG073LN6f7EovfBTk2
 BSVyHhz15xDzF9wVDHeiAgbTV7F7kQ4cPu4rwvsBaleGlRneo4TGea95XfUH6MnMAhKe
 r38nFGRrE1Lt/DIOLD/+88IngBMJ9vQsKtc04BkfYlWHJFhAqRYa7IBpGrMFks81aRMr ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssmcv9nk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 11:17:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UBHw9f026574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 11:17:58 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 04:17:53 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Subject: [PATCH V2 2/4] phy: qcom-m31: Add compatible, phy init sequence for IPQ5018
Date:   Wed, 30 Aug 2023 16:47:20 +0530
Message-ID: <20230830111722.19380-3-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230830111722.19380-1-quic_nsekar@quicinc.com>
References: <20230830111722.19380-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WP8-f6kHTwWo8zsZBI7wV17gMv4pHl7V
X-Proofpoint-GUID: WP8-f6kHTwWo8zsZBI7wV17gMv4pHl7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=902 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add phy init sequence and compatible string for IPQ5018
chipset.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
V2:
	Updated the commit message.
---
 drivers/phy/qualcomm/phy-qcom-m31.c | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
index ed08072ca032..81b72ebde305 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -82,6 +82,59 @@ struct m31_priv_data {
 	unsigned int			nregs;
 };
 
+struct m31_phy_regs m31_ipq5018_regs[] = {
+	{
+		USB_PHY_CFG0,
+		UTMI_PHY_OVERRIDE_EN,
+		0
+	},
+	{
+		USB_PHY_UTMI_CTRL5,
+		POR_EN,
+		15
+	},
+	{
+		USB_PHY_FSEL_SEL,
+		FREQ_SEL,
+		0
+	},
+	{
+		USB_PHY_HS_PHY_CTRL_COMMON0,
+		COMMONONN | FSEL | RETENABLEN,
+		0
+	},
+	{
+		USB_PHY_REFCLK_CTRL,
+		CLKCORE,
+		0
+	},
+	{
+		USB_PHY_UTMI_CTRL5,
+		POR_EN,
+		0
+	},
+	{
+		USB_PHY_HS_PHY_CTRL2,
+		USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
+		0
+	},
+	{
+		USB_PHY_UTMI_CTRL5,
+		0x0,
+		0
+	},
+	{
+		USB_PHY_HS_PHY_CTRL2,
+		USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
+		0
+	},
+	{
+		USB_PHY_CFG0,
+		0x0,
+		0
+	},
+};
+
 struct m31_phy_regs m31_ipq5332_regs[] = {
 	{
 		USB_PHY_CFG0,
@@ -268,6 +321,12 @@ static int m31usb_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct m31_priv_data m31_ipq5018_data = {
+	.ulpi_mode = false,
+	.regs = m31_ipq5018_regs,
+	.nregs = ARRAY_SIZE(m31_ipq5018_regs),
+};
+
 static const struct m31_priv_data m31_ipq5332_data = {
 	.ulpi_mode = false,
 	.regs = m31_ipq5332_regs,
@@ -275,6 +334,7 @@ static const struct m31_priv_data m31_ipq5332_data = {
 };
 
 static const struct of_device_id m31usb_phy_id_table[] = {
+	{ .compatible = "qcom,ipq5018-usb-hsphy", .data = &m31_ipq5018_data },
 	{ .compatible = "qcom,ipq5332-usb-hsphy", .data = &m31_ipq5332_data },
 	{ },
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

