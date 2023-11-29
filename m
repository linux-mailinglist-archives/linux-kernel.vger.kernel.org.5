Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4217FD386
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjK2KFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjK2KEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:04:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78121AD;
        Wed, 29 Nov 2023 02:04:57 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4CdUp017517;
        Wed, 29 Nov 2023 10:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eYdCxmqgHx/RQcgUZFoIKVQQsz5ARTpF8wqnMoRA7Rs=;
 b=VLYhP2crpfm/aMrXXT/lHtfGwIu6qZO11HqqhtlOic1SpxbdrjPaTlfZgoKRKhAKlUp5
 2DUkPW49eWpzHJz7aGk2s0yPTt142aSkQMuHCADKTUATaEtonh/dXXBXfwMpq9mJ6n2u
 5ChRyc9EZzI5I86v28SAyj7bTtwTK11mf8j6b2m1034WRwCIRebW2WkEVFJbIUBwPd6o
 xQbRFUBdAisqQex0F4CwZXdZGcQNVbvPFYKzNsTupeFaJqELEwRVUV4baAHgejbn+/w0
 dQr/uoDjQ2gp3AsJQkN8P1sQp9ZhVC22c5yh41Y8SssO5tYMmZfpzcWbPtXEgIxj/sN7 DQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unmraa11u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:04:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATA4sBo013506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:04:54 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 02:04:49 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH 2/2] pinctrl: qcom: correct incorrect address offset
Date:   Wed, 29 Nov 2023 18:04:22 +0800
Message-ID: <20231129100422.16659-3-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231129100422.16659-1-quic_tengfan@quicinc.com>
References: <20231129100422.16659-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t0H1JSDNZlAlyyojrphUunplbkQJeS83
X-Proofpoint-ORIG-GUID: t0H1JSDNZlAlyyojrphUunplbkQJeS83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=878 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address offset of 0x100000 is already provided in SM4450 DTSI, so
subtract 0x100000 from the offset which used by ufs and sdc.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-sm4450.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm4450.c b/drivers/pinctrl/qcom/pinctrl-sm4450.c
index 49e2e3a7a9cb..5496f955ed2a 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm4450.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm4450.c
@@ -936,14 +936,14 @@ static const struct msm_pingroup sm4450_groups[] = {
 	[133] = PINGROUP(133, _, phase_flag, _, _, _, _, _, _, _),
 	[134] = PINGROUP(134, tsense_pwm1_out, tsense_pwm2_out, _, _, _, _, _, _, _),
 	[135] = PINGROUP(135, _, phase_flag, _, _, _, _, _, _, _),
-	[136] = UFS_RESET(ufs_reset, 0x197000),
-	[137] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x18c004, 0, 0),
-	[138] = SDC_QDSD_PINGROUP(sdc1_clk, 0x18c000, 13, 6),
-	[139] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x18c000, 11, 3),
-	[140] = SDC_QDSD_PINGROUP(sdc1_data, 0x18c000, 9, 0),
-	[141] = SDC_QDSD_PINGROUP(sdc2_clk, 0x18f000, 14, 6),
-	[142] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x18f000, 11, 3),
-	[143] = SDC_QDSD_PINGROUP(sdc2_data, 0x18f000, 9, 0),
+	[136] = UFS_RESET(ufs_reset, 0x97000),
+	[137] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x8c004, 0, 0),
+	[138] = SDC_QDSD_PINGROUP(sdc1_clk, 0x8c000, 13, 6),
+	[139] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x8c000, 11, 3),
+	[140] = SDC_QDSD_PINGROUP(sdc1_data, 0x8c000, 9, 0),
+	[141] = SDC_QDSD_PINGROUP(sdc2_clk, 0x8f000, 14, 6),
+	[142] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x8f000, 11, 3),
+	[143] = SDC_QDSD_PINGROUP(sdc2_data, 0x8f000, 9, 0),
 };
 
 static const struct msm_gpio_wakeirq_map sm4450_pdc_map[] = {
-- 
2.17.1

