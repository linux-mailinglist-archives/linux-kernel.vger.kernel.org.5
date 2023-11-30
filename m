Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076BC7FE73D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjK3CmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjK3Clj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:41:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4261E10F0;
        Wed, 29 Nov 2023 18:41:30 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU2U8Dc028445;
        Thu, 30 Nov 2023 02:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=j238Yxooc4qTG9PLIHMfDLq47mg7/fDUNDBTLUxSb3g=;
 b=aX+sBUsoWs0X67I/fROjha3iT95FSaQb2p4LWrmKE6lgwUlqNKstlDcZHrXoxbmt/Pow
 z4tBy0BvXfR1fsXb3yhJ2N5jFhIYZy4XOgaR1OHn82oS3a80sTe/czblNByRNmFSDMzO
 nlTPkOdmyXVYJ34kc7SP67rKzW4Ew/sqWjrhO2onh+OKfkskyc8BJzb0hbogTMfobQ2s
 WaMaxwvZ63ZSyRzyby8XmEGtJzmuNsnD95tklT8wY/e8iNQ/J5HKMSwjhjfeZ2J1S7LO
 Vo5HJPg1fbibzkpAq2WzSwxssiSC31FxkpOUyE07s25Vol0QR5GUm+ktkLVvF9DL8xca 2Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upbu58pu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 02:41:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU2fQTp028779
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 02:41:26 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 18:41:21 -0800
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v5 4/4] pinctrl: qcom: sm4450: correct incorrect address offset
Date:   Thu, 30 Nov 2023 10:40:46 +0800
Message-ID: <20231130024046.25938-5-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130024046.25938-1-quic_tengfan@quicinc.com>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3u7teUg1RMyEZPP3yz-L_OuC5EpW8tA9
X-Proofpoint-GUID: 3u7teUg1RMyEZPP3yz-L_OuC5EpW8tA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=889
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300018
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

Suggested-by: Can Guo <quic_cang@quicinc.com>
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

