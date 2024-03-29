Return-Path: <linux-kernel+bounces-126213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766118933CB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C452281AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777714533C;
	Sun, 31 Mar 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oSbp8YXl"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02F15359D;
	Sun, 31 Mar 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903203; cv=pass; b=GdIXlynGrHmogHdq5coD0KGSEVgUqfE4hdmYtz3GuOXliB2Uo0LBiMiBdU+q0VXUA+4cfhKTzy4O1r4UdK41DhRSq/whARthlhJb0K269WiMi1i6lyh2xdYwmUPVvjrEGH1GFF2g8T/kzFmAo57kxFLkUxrSoEr6nZ5I/cJnIbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903203; c=relaxed/simple;
	bh=ZzhPYKeso27bmveGBa0hhOsC2JsybKzAElLAwye66BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QO4Gn7n7f5pn6jSRCYHVz2r8A/QEBXqdM/VRASjZVL5OfvpTkae9lZy8S3+eckfwT+CuJkz0479Rqz35a5E68QgdBqalYwnTeVtftK4i4Ql2ubuI0vxDdJfF1lLPHh52Zc6Y1WzLjsdg109yAqxPX2F8TrghtmHQH8RE6EPJfqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oSbp8YXl; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 18B7F20892;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNmwGse4vKLa; Sun, 31 Mar 2024 18:39:59 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8340F207C6;
	Sun, 31 Mar 2024 18:39:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8340F207C6
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 76A7580004A;
	Sun, 31 Mar 2024 18:39:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:42 +0000
X-sender: <linux-kernel+bounces-125460-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoALkimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 12407
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125460-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DFD8220883
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749268; cv=none; b=E1kTb3O1ObpF4ofYR3NSK/VNelTwTcHsdeE/v005QGBKCF9vuc2TDlgcjUA4uaFI0q/zx0LzRk+Rx+4yyLGsqv2PyJVcwePgZ9BMOwFjVAfW7OGkhy4+9QRWYvRBwbKH+qI5QI1SfHb97Cv+629u5Prdxs8Vf0b1/dyuWafjnU0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749268; c=relaxed/simple;
	bh=ZzhPYKeso27bmveGBa0hhOsC2JsybKzAElLAwye66BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IMu1Ln8MCtfnXxGEt7py/U0DhV6xmKS7+eZ8tjPXWUjG2tlQLckiVCDCBrUxeHvzzPH5vLt/iFA/vDGiAbfjx1S327V5kK6gtogdbqT3kGAOkmF/9sq0UjzVyafNu33Wxxt2NFsLbzo7ON4lxzS45GLmMelsWPSivnVgjahUJu0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oSbp8YXl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
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
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Fri, 29 Mar 2024 14:53:41 -0700
Subject: [PATCH v4 2/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
Precedence: bulk
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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



