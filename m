Return-Path: <linux-kernel+bounces-8968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F79681BEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11942893A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EEC745E1;
	Thu, 21 Dec 2023 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bHCY1eWx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D473191;
	Thu, 21 Dec 2023 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLIeVKU010055;
	Thu, 21 Dec 2023 18:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+niwdxZ7uL8bixUBNcHeed17UNFW9YxuNA17dgYRnGw=; b=bH
	CY1eWx3GouHlz+d0NwN9vKYsL8fi44MnrbN0czpyzsR8pqXcJyoAKFIf/hYqsR+H
	KVMxJJbTi9gKtsS+A7fJH1WABWAuZK7MmOoQl2tw/myhz42x8kdJAuBq0IBrJSV7
	enK2Bbgif1vyi6+32/wm6W9CEfbAkHTFCIHZPztGkoSZxOzmQHQYuHWPin0hcnLm
	g6hb4ZP+XQoheAROVZFfCI8lly4nIvXvGjaXssGGpmDVaWyogciyhJrcIszT8rUq
	D3QQE1YyGTzULa4sKCNHpwPGzRf3mT2iCJvffAyomnG8VBz26aVTeTnSHYa60Dy+
	S4svxn5a5n2DnLrpF+Xw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4tue81ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLIx38e023455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:59:03 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 10:59:03 -0800
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
Subject: [PATCH v8 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
Date: Thu, 21 Dec 2023 10:58:35 -0800
Message-ID: <20231221185838.28440-6-quic_amelende@quicinc.com>
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
X-Proofpoint-GUID: izR4-Yz7UgscN1dyE3vAexHA1oD3urgj
X-Proofpoint-ORIG-GUID: izR4-Yz7UgscN1dyE3vAexHA1oD3urgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210144

Update the pmi632 lpg_data struct so that pmi632 devices use PPG
for LUT pattern.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index a76cb1d6b7b5..976eaac97f40 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1637,11 +1637,13 @@ static const struct lpg_data pm8994_lpg_data = {
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


