Return-Path: <linux-kernel+bounces-457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40A814165
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7DF1C223BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86342DDAD;
	Fri, 15 Dec 2023 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iDtPBfMM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE1D2EE;
	Fri, 15 Dec 2023 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3apkq027794;
	Fri, 15 Dec 2023 05:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SF9RMlNr6ngF0VXm79b8bKtENoFDwR1sn7Swa2KeSoY=; b=iD
	tPBfMMu8RtpXoN6cEgDt+ZLSfs3/d/IB1/NKSdnXGqFlxo1t7Tz4HSFsUdfZiMnA
	6FDKdB7Zkmo2Xp8ymChNB/piENk2grAr2rcQBRfTSPGpj9Y6xuddpJ8uP6oPhoYu
	LEsQ9WOJ11tKCu7GL8PwBvtBGMNn8U28OtBN1i/5tkYkgZVHh80XPWtTReH9CVcm
	cTAsdxkyxrrdemD/f4URh++eeXocB3kKa/tl3dkE9Qc0UqL6dFyWAwWd+ihahsrc
	/wxFzP+AHcM9ImxF+4ViSPUX8585QweGbXxTBwyUfKuLnUM0kC9wGN0wWfEyTGIX
	bJneNuYtvLLlAfTYEzaA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0741j1fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:38:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF5cFpH015628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 05:38:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 21:38:11 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v1 2/2] regulator: qcom_smd: Add LDO5 MP5496 regulator
Date: Fri, 15 Dec 2023 11:07:04 +0530
Message-ID: <5affdcba10ab0f0b7535741b612cb0197cd6c28c.1702618483.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702618483.git.quic_varada@quicinc.com>
References: <cover.1702618483.git.quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bbLeMmWxyuBl7TMccWX7VEj_p-dADM6s
X-Proofpoint-GUID: bbLeMmWxyuBl7TMccWX7VEj_p-dADM6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=880 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150033

Add support for LDO5 regulator. This is used by IPQ9574 USB.

Cc: stable@vger.kernel.org
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/regulator/qcom_smd-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 09c471a0ba2e..d1be9568025e 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -796,6 +796,7 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &mp5496_smps, "s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &mp5496_smps, "s2" },
 	{ "l2", QCOM_SMD_RPM_LDOA, 2, &mp5496_ldoa2, "l2" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &mp5496_ldoa2, "l5" },
 	{}
 };
 
-- 
2.34.1


