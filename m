Return-Path: <linux-kernel+bounces-125460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4E89266E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD371C2115D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25213E416;
	Fri, 29 Mar 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oSbp8YXl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22279DF;
	Fri, 29 Mar 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749268; cv=none; b=E1kTb3O1ObpF4ofYR3NSK/VNelTwTcHsdeE/v005QGBKCF9vuc2TDlgcjUA4uaFI0q/zx0LzRk+Rx+4yyLGsqv2PyJVcwePgZ9BMOwFjVAfW7OGkhy4+9QRWYvRBwbKH+qI5QI1SfHb97Cv+629u5Prdxs8Vf0b1/dyuWafjnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749268; c=relaxed/simple;
	bh=ZzhPYKeso27bmveGBa0hhOsC2JsybKzAElLAwye66BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IMu1Ln8MCtfnXxGEt7py/U0DhV6xmKS7+eZ8tjPXWUjG2tlQLckiVCDCBrUxeHvzzPH5vLt/iFA/vDGiAbfjx1S327V5kK6gtogdbqT3kGAOkmF/9sq0UjzVyafNu33Wxxt2NFsLbzo7ON4lxzS45GLmMelsWPSivnVgjahUJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oSbp8YXl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TLUU68026715;
	Fri, 29 Mar 2024 21:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=+bd0p8wZ946dzDtJnkM1g8zAvJ0EnKW+xUBI80TUAm4
	=; b=oSbp8YXlgxZ7cBUyE9PakifZY0YNGB6iKKitZ5mnPyfuxJ6vEYg3UEMGNjQ
	8PwG/mPLu2IS6eirsr+fWmFWbBF2n30CI/3UXnJN1H7gxUTMKt31F8EYiSyyfUkc
	jHrz/fyhmjKPz0BW6UufVwBpCyRhN+84SHNx9EJ7c7cSzpPIySlsSsQPPjv4RBM4
	jxrbkenoYJmTvXpxhWjBloeN+mK+Mhl7IxUe2wI1gzNaIMLmpVg2c2yI/q1cFSgY
	c7d+GXYpENhowLb7om6Y2s7rhkGNpzpZi3hul5w1W2Jh5A3K71/wmfQm5GTOA5bA
	FiagKjBsNblIjQFkuLhOVdNHYWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g18ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TLs3ln022255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:54:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 14:54:00 -0700
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Fri, 29 Mar 2024 14:53:41 -0700
Subject: [PATCH v4 2/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-llcc-broadcast-and-v4-2-107c76fd8ceb@quicinc.com>
References: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
In-Reply-To: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Unnathi Chalicheemala
	<quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711749240; l=2997;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=ZzhPYKeso27bmveGBa0hhOsC2JsybKzAElLAwye66BE=;
 b=bJ/sdVUC6uTHBFFWKL0jMoOCUbWVpQaRsrVwgBC7rRPkYNvYjudtzMaCUwWQp3aXPhtpFoS+W
 mRlPQ0jqbMHCPVG6xFlvkRJwBk5pVyv3TXT8ZMRxLnc7YxhNMO8/cGE
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bc2BnW1Hs3ISyKMHGMNa6NVFWXmoGuMz
X-Proofpoint-ORIG-GUID: Bc2BnW1Hs3ISyKMHGMNa6NVFWXmoGuMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=943
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290195

Define new regmap structure for Broadcast_AND region and initialize
this regmap when HW block version is greater than 4.1, otherwise
initialize as a NULL pointer for backwards compatibility.

Switch from broadcast_OR to broadcast_AND region (when defined in DT)
for checking status bit 1 as Broadcast_OR region checks only for bit 0.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 14 +++++++++++++-
 include/linux/soc/qcom/llcc-qcom.h |  4 +++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index cbef0dea1d5d..727d00c527f1 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -821,6 +821,7 @@ EXPORT_SYMBOL_GPL(llcc_slice_putd);
 static int llcc_update_act_ctrl(u32 sid,
 				u32 act_ctrl_reg_val, u32 status)
 {
+	struct regmap *regmap;
 	u32 act_ctrl_reg;
 	u32 act_clear_reg;
 	u32 status_reg;
@@ -849,7 +850,8 @@ static int llcc_update_act_ctrl(u32 sid,
 		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
-		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
+		regmap = drv_data->bcast_and_regmap ?: drv_data->bcast_regmap;
+		ret = regmap_read_poll_timeout(regmap, status_reg,
 				      slice_status, (slice_status & ACT_COMPLETE),
 				      0, LLCC_STATUS_READ_DELAY);
 		if (ret)
@@ -1284,6 +1286,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
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


