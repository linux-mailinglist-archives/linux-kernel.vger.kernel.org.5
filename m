Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410DB7FE637
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbjK3Bg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbjK3Bgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:36:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B34410D1;
        Wed, 29 Nov 2023 17:36:54 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU1EGr1002437;
        Thu, 30 Nov 2023 01:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=SevpiuSF70TWO4X4hMl+0/RD6Mh8GGRRC2tdgazz2Rg=;
 b=msLkyLrgWpjpSPhih4IPfdwxdtTPqigH3ZfNi/LgVewW7mIsm5nf84KPv6qobVHaChE/
 3+jyBfDWQpzW8Wi6jWevlenVO7A0R2HtbTFklC+S0GfNkN28QoU0zhgrq0TsVKa3rsOi
 /IDADPDxVKL8bZlnYsRWSFMQf8JAUQmGTPbfQq5TGw7Lo7kQhTR2MinnSe0YyLlGUtUE
 VS4pKAaW+ecOUvQQ6aYmkbd8RrfnkMWhRAvd5WDXWC4amj2qlCaPRO9RXHaxwZMDSEKJ
 sGWeAY4JGiqTYnm4AEkUA2BaKz5rImCTzhngq+zBuu6MM0gtDY1pqdJ4nlcobZ+G+3jg uA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up02xtqk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:36:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU1aj9O024516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:36:45 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 17:36:45 -0800
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v7 7/7] leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
Date:   Wed, 29 Nov 2023 17:36:15 -0800
Message-ID: <20231130013615.14287-8-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130013615.14287-1-quic_amelende@quicinc.com>
References: <20231130013615.14287-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ElR_iT1N9NMhah9v9NfABHqfkX-gGcPr
X-Proofpoint-GUID: ElR_iT1N9NMhah9v9NfABHqfkX-gGcPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=976 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pm8350c lpg_data struct so that pm8350c devices are treated as
PWM devices that support two-nvmem PPG scheme.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 471b5b3e22ea..0cb079e6e2e6 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1780,11 +1780,13 @@ static const struct lpg_data pm8150l_lpg_data = {
 static const struct lpg_data pm8350c_pwm_data = {
 	.triled_base = 0xef00,
 
+	.lut_size = 122,
+
 	.num_channels = 4,
 	.channels = (const struct lpg_channel_data[]) {
-		{ .base = 0xe800, .triled_mask = BIT(7) },
-		{ .base = 0xe900, .triled_mask = BIT(6) },
-		{ .base = 0xea00, .triled_mask = BIT(5) },
+		{ .base = 0xe800, .triled_mask = BIT(7), .sdam_offset = 0x48 },
+		{ .base = 0xe900, .triled_mask = BIT(6), .sdam_offset = 0x56 },
+		{ .base = 0xea00, .triled_mask = BIT(5), .sdam_offset = 0x64 },
 		{ .base = 0xeb00 },
 	},
 };
-- 
2.41.0

