Return-Path: <linux-kernel+bounces-20793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839382854C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A0C1F24A05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD2381A1;
	Tue,  9 Jan 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ewZkh6aA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A837168;
	Tue,  9 Jan 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409BBje4003573;
	Tue, 9 Jan 2024 11:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=ylBxdKkdnS2ewPyzDCWT
	+mz78jMSCInYoOebLl+z6R0=; b=ewZkh6aAyE+ed410DOm744sZ0qz2jZML9Ej4
	2jAzdHPur2plfyypKOPAJe/dW/Hh0iKmFXjs3aHwlZ42x2wIr0tkwhOesJ2nh+ln
	SlJSf2v5jnq5/1ZbHUH6UFU1e39F23wEMlGa+3Iefq6OwEY3xlB/uLUafI0livdK
	SqRWvHgw2UYTXRv3P6mLZuM+zao/ZVVG7uVIpZDdW1oNFwwt0y+JtE6qBBiVYNkw
	kyMxZq1S99yLYvLYRgYj+Ckf/ENipGHLFBr1XOLGCsgDMQu1Dt1kp7G0AFAGKjxt
	qAoW5bwI8WfZSSWNzUY/sqgQU/DkQajJG18lHKdg/S36/wt0Mg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgq2ysm4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:43:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Bh6om020285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 11:43:06 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 03:43:00 -0800
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
        <qipl.kernel.upstream@quicinc.com>,
        Bibek Kumar Patro
	<quic_bibekkum@quicinc.com>
Subject: [PATCH v7 4/5] iommu/arm-smmu: add ACTLR data and support for SM8550
Date: Tue, 9 Jan 2024 17:12:19 +0530
Message-ID: <20240109114220.30243-5-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EhWDGZ_sXi4rAMbOb8m4Te6z0Qlty7An
X-Proofpoint-ORIG-GUID: EhWDGZ_sXi4rAMbOb8m4Te6z0Qlty7An
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090095

Add ACTLR data table for SM8550 along with support for
same including SM8550 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 48586952fae4..24a289149cd3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -23,6 +23,12 @@

 #define CPRE			(1 << 1)
 #define CMTLB			(1 << 0)
+#define PREFETCH_SHIFT		8
+#define PREFETCH_DEFAULT	0
+#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
+#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
+#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
+#define PREFETCH_SWITCH_GFX	(5 << 3)

 struct actlr_config {
 	u16 sid;
@@ -30,6 +36,76 @@ struct actlr_config {
 	u32 actlr;
 };

+static const struct actlr_config sm8550_apps_actlr_cfg[] = {
+	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
+	{ 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1c01, 0x0000, PREFETCH_DEFAULT | CMTLB },
+	{ 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{ 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
+	{},
+};
+
+static const struct actlr_config sm8550_gfx_actlr_cfg[] = {
+	{ 0x0000, 0x03ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
+	{},
+};
+
+static const struct actlr_variant sm8550_actlr[] = {
+	{ sm8550_apps_actlr_cfg, 0x15000000 },
+	{ sm8550_gfx_actlr_cfg, 0x03da0000 },
+	{},
+};
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -597,6 +673,14 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+
+static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrvar = sm8550_actlr,
+};
+
 static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
 	.adreno_impl = &qcom_adreno_smmu_500_impl,
@@ -631,6 +715,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
 	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
--
2.17.1


