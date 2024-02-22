Return-Path: <linux-kernel+bounces-77487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38D86063E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9104F1C21FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAA224D5;
	Thu, 22 Feb 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T6ULa8Rw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390417C79;
	Thu, 22 Feb 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643298; cv=none; b=MWbWQp4g20RfIILArVCkasjdnAK/O2FVq8mwycgrWn7hOn6If3u+of9eSIHhhOFpVq8cIvwstgTOVbV6yeNDL4cBzyUkfjYZKwrkUa/FQ4gQMQSMpfDYHhOytJdIKBc5c68BH4zhrXN2z06btvRLVFSvNaEZBbdOkHT4kYxvwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643298; c=relaxed/simple;
	bh=zUwam+Fy+Dq3Icjjusgow6695EbLOWLFTtEUIjObkQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpFXuE3goEnww5emKimsiMKEeryg/WdxMoo1T3RvgufOJnjEloWgiWS9wlgT5FDOeFQzBCYvpNxR2Wir/ANC/QI/rZFxHek4XElPiDL1Yt3uXYHvQdeZzUJnEwrFxXbQAHXj2q2978BopHrzwTyl6QjrQ/YSCKjTC6S0LUjtTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T6ULa8Rw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLuptg020226;
	Thu, 22 Feb 2024 23:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GJJMvIHTxAYgd6BG6Ir5CbyxXAyAbxB7KzXDLi8Ch3A=; b=T6
	ULa8Rw+4hz+KrVtMmfmFOHNckBdAquw8Rp5QKdcnZDElH+bX9qrAct1loCO6o8WL
	anphVcBs0bIDNnlMRVNJJAU7IsavGYTCFHZM5YjNjWoq852OMPN5T0dTrAZFy3/A
	PHTtYcamAQbwtdhCOdt41RI7oZwjDpfN7qS7pRefqvxECkM6a8SpNniQqdDUOEz+
	7pQgRdksBX+UmE3XIvUjk9sZ/XHZuhAD8nR+QQKUoDGsrUw3NbMpdj+cWnw8ZSLn
	JbiSofYKiHNmQN7Dj43ykQap1aPQolEdKpV+h2WfcUYQ/tUcGrTcuBvBhnkCBUbd
	LMTWPD9EgihjkSbHxbJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24aju5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MN8A80029081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:10 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:08:07 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH v3 2/5] soc: qcom: llcc: Add regmap for Broadcast_AND region
Date: Thu, 22 Feb 2024 15:07:54 -0800
Message-ID: <c3456b3d182f5139339400e49b228fa4840ae0e2.1708551850.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1708551850.git.quic_uchalich@quicinc.com>
References: <cover.1708551850.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gQTHeQpOGpa9mu9fPwrifpWvXXYhK0Gy
X-Proofpoint-ORIG-GUID: gQTHeQpOGpa9mu9fPwrifpWvXXYhK0Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220178

Define new regmap structure for Broadcast_AND region and initialize
this regmap when HW block version is greater than 4.1, otherwise
initialize as a NULL pointer for backwards compatibility.

Switch from broadcast_OR to broadcast_AND region (when defined in DT)
for checking status bit 1 as Broadcast_OR region checks only for bit 0.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 15 ++++++++++++++-
 include/linux/soc/qcom/llcc-qcom.h |  4 +++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4ca88eaebf06..cfdc7d9d7773 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -826,6 +826,7 @@ static int llcc_update_act_ctrl(u32 sid,
 	u32 status_reg;
 	u32 slice_status;
 	int ret;
+	struct regmap *regmap;
 
 	if (IS_ERR(drv_data))
 		return PTR_ERR(drv_data);
@@ -849,7 +850,9 @@ static int llcc_update_act_ctrl(u32 sid,
 		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
-		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
+		regmap = (!drv_data->bcast_and_regmap) ? drv_data->bcast_regmap
+			: drv_data->bcast_and_regmap;
+		ret = regmap_read_poll_timeout(regmap, status_reg,
 				      slice_status, (slice_status & ACT_COMPLETE),
 				      0, LLCC_STATUS_READ_DELAY);
 		if (ret)
@@ -1282,6 +1285,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
+	/* Applicable only when drv_data->version >= 4.1 */
+	drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
+	if (IS_ERR(drv_data->bcast_and_regmap)) {
+		ret = PTR_ERR(drv_data->bcast_and_regmap);
+		if (ret == -EINVAL)
+			drv_data->bcast_and_regmap = NULL;
+		else
+			goto err;
+	}
+
 	llcc_cfg = cfg->sct_data;
 	sz = cfg->size;
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 1a886666bbb6..9e9f528b1370 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -115,7 +115,8 @@ struct llcc_edac_reg_offset {
 /**
  * struct llcc_drv_data - Data associated with the llcc driver
  * @regmaps: regmaps associated with the llcc device
- * @bcast_regmap: regmap associated with llcc broadcast offset
+ * @bcast_regmap: regmap associated with llcc broadcast OR offset
+ * @bcast_and_regmap: regmap associated with llcc broadcast AND offset
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
  * @lock: mutex associated with each slice
@@ -129,6 +130,7 @@ struct llcc_edac_reg_offset {
 struct llcc_drv_data {
 	struct regmap **regmaps;
 	struct regmap *bcast_regmap;
+	struct regmap *bcast_and_regmap;
 	const struct llcc_slice_config *cfg;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
 	struct mutex lock;
-- 
2.25.1


