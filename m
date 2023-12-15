Return-Path: <linux-kernel+bounces-737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958481455C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD8B22B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9831A706;
	Fri, 15 Dec 2023 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eMWf53hr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135319BD2;
	Fri, 15 Dec 2023 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF9MqcC032355;
	Fri, 15 Dec 2023 10:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=VC0P7zbrDUIm07/0kjwJ
	O2lkbKlLXXBDvp1miWVWiCA=; b=eMWf53hrRxedEzkfD+41RFsXC3MvGQkKiUhc
	IM+pWmISaVBKvKgcc1esp1oRZVCynVjdtdjvYs0a9Cw04v5oqzMkuN7T9NyfRKMp
	bwCTbGOJlrzAuZSNqJT1h/lydxMnSBManBd4bGYJFoKnhXP1lzpJfeeZuH4jG48W
	h6DxVlLYYL+UoSE+CBcENmjQSWnniFL6ZrSpuWdtUFS4bXj7X8waT46DutQ+9TeQ
	dK81uSIlDvz00I5wde05hdVBopqvDhz5DaMhEDmoADDjBThshXnopeKygBXyON41
	uiWCZeIuqjN+WaXxLeABdroJi92bad3Y0CUxmh8vMnKOix/BNA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0m46g4n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:19:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFAJD8m006724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:19:13 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 02:19:06 -0800
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
Subject: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for SM8550
Date: Fri, 15 Dec 2023 15:48:25 +0530
Message-ID: <20231215101827.30549-4-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
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
X-Proofpoint-GUID: sXJctNwoF5OIU58EIB8jfJefTOdu67Ak
X-Proofpoint-ORIG-GUID: sXJctNwoF5OIU58EIB8jfJefTOdu67Ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150069

Add ACTLR data table for SM8550 along with support for
same including SM8550 specific implementation operations.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index cb49291f5233..d2006f610243 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -20,6 +20,85 @@ struct actlr_config {
 	u32 actlr;
 };

+/*
+ * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
+ * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
+ * buffer). The remaining bits are implementation defined and vary across
+ * SoCs.
+ */
+
+#define PREFETCH_DEFAULT	0
+#define PREFETCH_SHALLOW	BIT(8)
+#define PREFETCH_MODERATE	BIT(9)
+#define PREFETCH_DEEP		(BIT(9) | BIT(8))
+#define PREFETCH_SWITCH_GFX	(BIT(5) | BIT(3))
+#define CPRE			BIT(1)
+#define CMTLB			BIT(0)
+
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
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -549,6 +628,15 @@ static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
 	/* Also no debug configuration. */
 };

+
+static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
+	.impl = &qcom_smmu_500_impl,
+	.adreno_impl = &qcom_adreno_smmu_500_impl,
+	.cfg = &qcom_smmu_impl0_cfg,
+	.actlrcfg = sm8550_apps_actlr_cfg,
+	.actlrcfg_gfx = sm8550_gfx_actlr_cfg,
+};
+
 static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
 	.impl = &qcom_smmu_500_impl,
 	.adreno_impl = &qcom_adreno_smmu_500_impl,
@@ -583,6 +671,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm8550-smmu-500", .data = &sm8550_smmu_500_impl0_data },
 	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ }
 };
--
2.17.1


