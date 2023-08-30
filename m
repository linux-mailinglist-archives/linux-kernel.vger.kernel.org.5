Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C478DECB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbjH3TY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjH3SHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:07:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3681A2;
        Wed, 30 Aug 2023 11:07:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UHQN1H032622;
        Wed, 30 Aug 2023 18:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=d6XkxGnXGdhYD+yZ9yuGftHdbixcTwTNHVcT8grv4eQ=;
 b=FQLIwJ6h3YcPelLr4s99w/vdkN9PqBEt09sWh4TuwpUqapx/DH2UeNe7n6stYpitumQ9
 VmC7B+zgtuH5V/UIbL+m0BC2Xmsl6Kp/0u+Y1/rBMs0YxiVbDPsjzgqAS2qT8QVKVwyB
 +cdd01R3WenPf3NmYIykEq6AuGQRguyFu70ltBlTUt4Rj/GzjKukqKzjHUZ0JNq5cOCc
 HIv2uai0cQSd23c7E1mTM2o9uarFSsS76LtbVXHbkTliikvTqLDAk8w71vlcWw9zM66u
 4plDdVj7psp2peTyCS42vHvk6o39ZYLBZ17ucvpYuxXE76LGAsn7y/z1DnITtAs9sEXt FQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssmcvag5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:07:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UI71SB007366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 18:07:01 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 30 Aug 2023 11:06:58 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v4 7/7] leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
Date:   Wed, 30 Aug 2023 11:06:02 -0700
Message-ID: <20230830180600.1865-10-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830180600.1865-2-quic_amelende@quicinc.com>
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xA-um-k7Qhjoxl9CkRd91v8ccKXYCJTh
X-Proofpoint-GUID: xA-um-k7Qhjoxl9CkRd91v8ccKXYCJTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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
 drivers/leds/rgb/leds-qcom-lpg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 9f1580e81ab0..b2435693b50e 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1808,11 +1808,14 @@ static const struct lpg_data pm8150l_lpg_data = {
 static const struct lpg_data pm8350c_pwm_data = {
 	.triled_base = 0xef00,
 
+	.lut_size = 122,
+	.lut_sdam_base = 0x45,
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

