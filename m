Return-Path: <linux-kernel+bounces-8972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D9581BEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB51C216F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B9673192;
	Thu, 21 Dec 2023 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fc9rJilt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796C76DBC;
	Thu, 21 Dec 2023 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLDROhK014686;
	Thu, 21 Dec 2023 18:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vI4fOUwFK0VcXmgY7qzLx++zI2cGUEqjilCQmaxzv+M=; b=fc
	9rJiltheFyDySJSL3STt65DjWXI4NA3rt/CeSHuhCrSnDLQ8aBzt+y+qIsDbglxC
	tydq+EeZp64nt1BjKJBabdjpdLUgsJ95ZYbWXvXYLzCiD7mbJ+dDQGcTltv4TG3b
	6i1vl58xPjUuoqq5VBJH4og2XJ1H3jo1u6FF4zXYNTw/qkSNH1+up/tzHSjwz4rV
	+P6fJkBZ6aGQyuH3IpG1Ry8dudPAHfCSo47LB2rU2m2BsYqHm6WvCnUZ4KqoNDDT
	+ec2r9UVsayTlcmaSeW1S+jNx/sSiRk95kve86cQ36G3nkT50IWjhl17ni5qHoDs
	VWlzvyHpJOf11LZNbTXA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4g8ej9y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLIx5IZ006465
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:05 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 10:59:05 -0800
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v8 7/7] leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
Date: Thu, 21 Dec 2023 10:58:37 -0800
Message-ID: <20231221185838.28440-8-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231221185838.28440-1-quic_amelende@quicinc.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m1WRqX9o65bP2RfPKYT0YyxFOAaEsp36
X-Proofpoint-ORIG-GUID: m1WRqX9o65bP2RfPKYT0YyxFOAaEsp36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210144

Update the pm8350c lpg_data struct so that pm8350c devices are treated as
PWM devices that support two-nvmem PPG scheme.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index eec49027ccf1..b11412af860e 100644
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


