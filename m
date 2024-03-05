Return-Path: <linux-kernel+bounces-92821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F94C87267C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A60287399
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556218AF4;
	Tue,  5 Mar 2024 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bZDlQX2A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA911863C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663099; cv=none; b=LYlHSIKZssGyQdg+8vZgdusHn/SL/bFTQzRVHfiKx8aPunADZSfIm9vQSVF9UzyX+juAyvJZJBfPauvxaoMRyh0+Q7f2WNI+O2+DG6EuJhzRuQOwigsJK38gil1JPaaAGSllpo7ZeegR5bGrN43+oTBIiTEVIQcdC0Bm1eZ4QUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663099; c=relaxed/simple;
	bh=o9CJwYV786v6dPmGV9qZCaWyrfhHpxl39VvWKwVU68Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjlWIGBiJdj4g/Fa2568wVTOOylNROtFyTNjJgH7RfXFwy6724uc6qQTofEeDBYvSSG3EYekr2TcGrdRmr3gqx9Rq6jmPiFPYX3iH+LpgmWn4/7QcXqM8ln3qU4Ea2Em6yuxUcOjBheKMFuKmTr2eeqeAD9Gh2MBX6ZirzFLfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bZDlQX2A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425Bjwps004111;
	Tue, 5 Mar 2024 18:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=eb5A4JDbuchBBafxqmTtCwKQlj+2d0meUpzdl7x3pG4=; b=bZ
	DlQX2AZVmQ2Ysn5AiHZCP74B2xDpTEHzUkolr4+zzp4LjQfeW2GUiy4cvi0Yquoc
	IIT732TBwE+ufyWAo2eaxdPqU49OjgFBu+6U/Ct00zvG1oUSsXYqK3Ca394TncDJ
	3G2saNNEJWWYdNPVTDDKFFidpoDabuLu28ckfI0tlV99fBDjY5Osrk7+48kgmgNi
	Z85YQg5vC1xNj/cFIyrf3wbBNu1Wkw2YrpfdCvYLwBNrXc8Bv3vMJ3oX/vlXwdIS
	amt5f+dhHLBq76pu91FRKUu5F25ybgW9CWDlyrpo14/k1FVI5Br/htvGuxKx77uU
	it1npCt9tMSjusqsRLaA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wp00x18tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 18:24:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425IOnRW028679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 18:24:50 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 10:24:48 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] nvmem: qfprom: Add constraint read for some SoCs
Date: Tue, 5 Mar 2024 23:54:40 +0530
Message-ID: <1709663080-10957-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j0gtkOSewRoDh9tHxhjrOlpFdf9gXyro
X-Proofpoint-GUID: j0gtkOSewRoDh9tHxhjrOlpFdf9gXyro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050147

Few SoCs starting from sm8450 where fuse region is
accessed using secure bus where it is not possible
to do incremental bytewise reading, while it is
possible to read 4 byte at a time.

Add required support in qfprom driver to support
reading fuse information on these SoCs.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/nvmem/qfprom.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 116a39e804c7..8fce445f0320 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -68,6 +68,7 @@ struct qfprom_soc_data {
  * @secclk:       Clock supply.
  * @vcc:          Regulator supply.
  * @soc_data:     Data that for things that varies from SoC to SoC.
+ * @soc_cdata:    Data that are relevant to convey SoC constraints.
  */
 struct qfprom_priv {
 	void __iomem *qfpraw;
@@ -78,6 +79,7 @@ struct qfprom_priv {
 	struct clk *secclk;
 	struct regulator *vcc;
 	const struct qfprom_soc_data *soc_data;
+	const struct qfprom_soc_compatible_data *soc_cdata;
 };
 
 /**
@@ -99,10 +101,14 @@ struct qfprom_touched_values {
  *
  * @keepout: Array of keepout regions for this SoC.
  * @nkeepout: Number of elements in the keepout array.
+ * @word_size: Should be given for SoC where it is not possible
+ *	       to do incremental reading or bytewise and while
+ *	       it is possible read 4 byte at a time.
  */
 struct qfprom_soc_compatible_data {
 	const struct nvmem_keepout *keepout;
 	unsigned int nkeepout;
+	unsigned int word_size;
 };
 
 static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
@@ -125,6 +131,10 @@ static const struct qfprom_soc_compatible_data sc7280_qfprom = {
 	.nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
 };
 
+static const struct qfprom_soc_compatible_data sm8450_qfprom = {
+	.word_size = 4,
+};
+
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -317,21 +327,55 @@ static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
 	return ret;
 }
 
+static int __qfprom_reg_constraint_read(void __iomem *base, unsigned int reg,
+					void *_val, size_t bytes,
+					unsigned int word_size)
+{
+	unsigned int i;
+	u8 *val = _val;
+	u32 read_val;
+	u8 *tmp;
+
+	for (i = 0; i < bytes; i++, reg++) {
+		if (i == 0 || reg % word_size == 0) {
+			read_val = readl(base + (reg & ~(word_size - 1)));
+			tmp = (u8 *)&read_val;
+		}
+
+		val[i] = tmp[reg & (word_size - 1)];
+	}
+
+	return 0;
+}
+
+static int __qfprom_reg_read(void __iomem *base, unsigned int reg, void *_val,
+			     size_t bytes)
+{
+	u8 *val = _val;
+	int words = bytes;
+	int i = 0;
+
+	while (words--)
+		*val++ = readb(base + reg + i++);
+
+	return 0;
+}
+
 static int qfprom_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
 	struct qfprom_priv *priv = context;
-	u8 *val = _val;
-	int i = 0, words = bytes;
 	void __iomem *base = priv->qfpcorrected;
 
 	if (read_raw_data && priv->qfpraw)
 		base = priv->qfpraw;
 
-	while (words--)
-		*val++ = readb(base + reg + i++);
+	if (priv->soc_cdata && priv->soc_cdata->word_size == 4)
+		return __qfprom_reg_constraint_read(base, reg,
+						    _val, bytes,
+						    priv->soc_cdata->word_size);
 
-	return 0;
+	return __qfprom_reg_read(base, reg, _val, bytes);
 }
 
 static void qfprom_runtime_disable(void *data)
@@ -390,6 +434,7 @@ static int qfprom_probe(struct platform_device *pdev)
 		econfig.nkeepout = soc_data->nkeepout;
 	}
 
+	priv->soc_cdata = soc_data;
 	/*
 	 * If more than one region is provided then the OS has the ability
 	 * to write.
@@ -447,6 +492,7 @@ static const struct of_device_id qfprom_of_match[] = {
 	{ .compatible = "qcom,qfprom",},
 	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
 	{ .compatible = "qcom,sc7280-qfprom", .data = &sc7280_qfprom},
+	{ .compatible = "qcom,sm8450-qfprom", .data = &sm8450_qfprom},
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, qfprom_of_match);
-- 
2.7.4


