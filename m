Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125C762281
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGYThE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjGYTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:36:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45A271B;
        Tue, 25 Jul 2023 12:36:32 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PH8x8j009975;
        Tue, 25 Jul 2023 19:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tRtCAqvU57hpM6qzhnUi/RA39R44nWQijBPjThBPfZQ=;
 b=ZVmiaqnVkAo8mFxo9XUr/MfuH/ieR6F1lgxxuJuwwqrDV/YMc3w2Pdxr2JThgWYxicxb
 euSF0I27y2jgq4jgCDPZAVVcUPbLXIpCiAOxZlLljgaF7zoOK3CN3qE3h2znRp4x4own
 XFko4ATVWcgFsenPl7Zg5upuOEpPoURlgGk1Y7azOa/FuaIC+v3d36qkEzmn+VzjJtwC
 y3cRSUEyuu8HpvdN+ArCr93+AWGrRZhSJGxxK00E9nLEKABOMS/X7lWPU9Y6Uw5WLFay
 2oI14peMdE4uEjWQO+HrkZE6NICuYpshOqYfik3U8f4xqmL5eCZay6QsWmXRgXyQ6/++ EA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dqah529-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:36:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PJaBEZ013286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:36:11 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 12:36:11 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 7/7] leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
Date:   Tue, 25 Jul 2023 12:34:23 -0700
Message-ID: <20230725193423.25047-8-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725193423.25047-1-quic_amelende@quicinc.com>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W920sjGfeVEw6QyYtiLrvUqqlg3Jh7XR
X-Proofpoint-ORIG-GUID: W920sjGfeVEw6QyYtiLrvUqqlg3Jh7XR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pm8350c lpg_data struct so that pm8350c devices are treated as
PWM devices that support two-nvmem PPG scheme.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index f3f83925ab41..bd54b023d509 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1826,11 +1826,15 @@ static const struct lpg_data pm8150l_lpg_data = {
 static const struct lpg_data pm8350c_pwm_data = {
 	.triled_base = 0xef00,
 
+	.lut_size = 122,
+	.lut_sdam_base = 0x45,
+	.nvmem_count = 2,
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

