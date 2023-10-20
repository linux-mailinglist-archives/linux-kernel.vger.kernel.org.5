Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D68E7D15BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjJTSXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJTSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:22:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1141A8;
        Fri, 20 Oct 2023 11:22:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KIM69J020339;
        Fri, 20 Oct 2023 18:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=lTG5OwX/geJhqMjq7JNNm2l4o5n/JulNwtQ1DfgCZnI=;
 b=OMG8D8NKCCoHBNzquK/GdDtTDOTbTOF5MfnLdfFCeefCowyuHj2wtKxNRuzCr5BLwFiR
 5n1w8YscYyh3YK1ZkJN1jCAcSNyI2ZFIi4JkXVRdOGK/s6jwTyNWBN8XiIavkEJbqLne
 Rds1MO9MFrcfg4jhWGvgo6uetJvsnvQk1Gee9EDgeL7IG8OH4mRmKRGOT8heYLz73Bh3
 W5UEzf0ZsEK8XEWybHX+h6v0AD9Lv0dUun4GnDT0/wPa3qUkNotVAed73W7QQUYL+2dG
 0/TPisblAPM4OcJISE2jcsQWwJWLFQTDye0PHDgzQ5kfaL6e/1Zgg49F1OWtqeKU4rih Yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubx7jt6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 18:22:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KIMkfj017612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 18:22:46 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 20 Oct 2023 11:22:45 -0700
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
Subject: [PATCH v6 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
Date:   Fri, 20 Oct 2023 11:22:15 -0700
Message-ID: <20231020182218.22217-6-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020182218.22217-1-quic_amelende@quicinc.com>
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uHtYdWui2qjBk1XWeCRV4NQ8KByXpRc5
X-Proofpoint-GUID: uHtYdWui2qjBk1XWeCRV4NQ8KByXpRc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=934 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the pmi632 lpg_data struct so that pmi632 devices use PPG
for LUT pattern.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 0c6d0e593c06..92fee512d965 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1640,11 +1640,13 @@ static const struct lpg_data pm8994_lpg_data = {
 static const struct lpg_data pmi632_lpg_data = {
 	.triled_base = 0xd000,
 
+	.lut_size = 64,
+
 	.num_channels = 5,
 	.channels = (const struct lpg_channel_data[]) {
-		{ .base = 0xb300, .triled_mask = BIT(7) },
-		{ .base = 0xb400, .triled_mask = BIT(6) },
-		{ .base = 0xb500, .triled_mask = BIT(5) },
+		{ .base = 0xb300, .triled_mask = BIT(7), .sdam_offset = 0x48 },
+		{ .base = 0xb400, .triled_mask = BIT(6), .sdam_offset = 0x56 },
+		{ .base = 0xb500, .triled_mask = BIT(5), .sdam_offset = 0x64 },
 		{ .base = 0xb600 },
 		{ .base = 0xb700 },
 	},
-- 
2.41.0

