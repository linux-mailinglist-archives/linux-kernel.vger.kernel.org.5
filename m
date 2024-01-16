Return-Path: <linux-kernel+bounces-27496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0982F106
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043B91F2461F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA841CA91;
	Tue, 16 Jan 2024 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HYL2NKlT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1771CA88;
	Tue, 16 Jan 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GE094g027663;
	Tue, 16 Jan 2024 15:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Zgkx62l4rcyEtBTq+CoX
	3k8529VHNxyha1vXQuEWPjg=; b=HYL2NKlTOCoKy8WpNo6UOtkfyLjUErKazk8u
	Gy4e9vfgX2S6Qtcme5GI8P0j1mVVkRI8fYBE7NoeRWEScIqztl1C6C8qcdpfCHrx
	hfoGAUaZFck0QJHmfFboKp2T49TVYDjYrUc+wSsgKDLCGCC+PhiXquL9UNC98ix7
	KTVeQmAse/iXUq1LqS5071uvOpIR8B3Jc1daQ/aTv8si0tnZTd7ucXie2re//QRc
	yq8k/gCdkfzzNlzkOOOc5OjDxme0k+TFOO+i+JmQ8bkwPHNwIksW54JMBr79zqN5
	PwXfnHlap1KC5yuGSB/qgwXSuRqEb5opumEHiGl6BTnG43ACTA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrnd8jjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 15:05:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GF54FE015128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 15:05:04 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 07:04:58 -0800
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bibek Kumar Patro
	<quic_bibekkum@quicinc.com>
Subject: [PATCH v8 5/5] iommu/arm-smmu: add ACTLR data and support for SC7280
Date: Tue, 16 Jan 2024 20:34:11 +0530
Message-ID: <20240116150411.23876-6-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116150411.23876-1-quic_bibekkum@quicinc.com>
References: <20240116150411.23876-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e5NiOR4LKf5dTI5jVxNGOc6hni5EtNfZ
X-Proofpoint-ORIG-GUID: e5NiOR4LKf5dTI5jVxNGOc6hni5EtNfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160118

Add ACTLR data table for SC7280 along with support for
same including SC7280 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 26acfbdafd0f..8e52176b4108 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -36,6 +36,27 @@ struct actlr_config {
 	u32 actlr;
 };

+static const struct actlr_config sc7280_apps_actlr_cfg[] = {
+	{ 0x0800, 0x24e1, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2000, 0x0163, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2080, 0x0461, PREFETCH_DEFAULT | CMTLB },
+	{ 0x2100, 0x0161, PREFETCH_DEFAULT | CMTLB },
+	{ 0x0900, 0x0407, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x2180, 0x0027, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_config sc7280_gfx_actlr_cfg[] = {
+	{ 0x0000, 0x07ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
+};
+
+static const struct actlr_variant sc7280_actlr[] = {
+	{ .io_start = 0x15000000, .actlrcfg = sc7280_apps_actlr_cfg,
+			.num_actlrcfg = ARRAY_SIZE(sc7280_apps_actlr_cfg) },
+	{ .io_start = 0x03da0000, .actlrcfg = sc7280_gfx_actlr_cfg,
+			.num_actlrcfg = ARRAY_SIZE(sc7280_gfx_actlr_cfg) },
+};
+
 static const struct actlr_config sm8550_apps_actlr_cfg[] = {
 	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
 	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
@@ -676,6 +697,13 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+static const struct qcom_smmu_match_data sc7280_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrvar = sc7280_actlr,
+	.num_smmu = ARRAY_SIZE(sc7280_actlr),
+};

 static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
@@ -702,7 +730,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
 	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
-	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sc7280-smmu-500", .data = &sc7280_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
--
2.17.1


