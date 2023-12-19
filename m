Return-Path: <linux-kernel+bounces-5300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE9818928
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528341C23A06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C231B26F;
	Tue, 19 Dec 2023 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HyM+PZg7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED91A58F;
	Tue, 19 Dec 2023 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJDDWFu011413;
	Tue, 19 Dec 2023 14:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=KlwMwH130/M9nuxFEcqp
	8sT353sklVGa8baRUn19EkY=; b=HyM+PZg7UsgAiRXyHN7sRjXeFpOrn0psu6me
	do9AImocg8OdeXCT3KT37Y3YBy1lFoeixMGw1zgH8r1HLNlQN5XHdfIN9ARetqlY
	HeU4HmJPzLEixNje6BY8BYRc2D/SwuWs4iYQ3sobeud0QWW4Z0pg50JvrDv41Cs5
	LHcZ90cR1HMKiUDpE1hetGSS5SchD4VvBqOo0pGds1AXEwX2OUT4YCJNTdc0s65Z
	HMQ5yE1DnuoN9pp03kBjWENrB9gEQ8IUFS7j02fZYCZRTpdMQeQE+DgQKE+3IBkH
	kuDTjnEnMplgPZMB3ZmykcjnbhSeEk8ZEEomcD66tMntfZFpRQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v39n8rfr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:00:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJE0GLm023223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 14:00:16 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 06:00:09 -0800
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
Subject: [PATCH v5 1/5] iommu/arm-smmu: re-enable context caching in smmu reset operation
Date: Tue, 19 Dec 2023 19:29:43 +0530
Message-ID: <20231219135947.1623-2-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219135947.1623-1-quic_bibekkum@quicinc.com>
References: <20231219135947.1623-1-quic_bibekkum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zVITVtA76FhOAItEI7hNU6PZx2heURWU
X-Proofpoint-GUID: zVITVtA76FhOAItEI7hNU6PZx2heURWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190104

Default MMU-500 reset operation disables context caching in
prefetch buffer. It is however expected for context banks using
the ACTLR register to retain their prefetch value during reset
and runtime suspend.

Replace default MMU-500 reset operation with Qualcomm specific reset
operation which envelope the default reset operation and re-enables
context caching in prefetch buffer for Qualcomm SoCs.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..225a53486307 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -14,6 +14,16 @@

 #define QCOM_DUMMY_VAL	-1

+/*
+ * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
+ * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
+ * buffer). The remaining bits are implementation defined and vary across
+ * SoCs.
+ */
+
+#define CPRE			(1 << 1)
+#define CMTLB			(1 << 0)
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -376,11 +386,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
 	return match ? IOMMU_DOMAIN_IDENTITY : 0;
 }

+static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
+{
+	u32 val;
+	int i;
+
+	arm_mmu500_reset(smmu);
+
+	/* arm_mmu500_reset() disables CPRE which is re-enabled here */
+	for (i = 0; i < smmu->num_context_banks; ++i) {
+		val = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+		val |= CPRE;
+		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
+	}
+
+	return 0;
+}
+
 static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 {
 	int ret;

-	arm_mmu500_reset(smmu);
+	qcom_smmu500_reset(smmu);

 	/*
 	 * To address performance degradation in non-real time clients,
@@ -407,7 +434,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = arm_mmu500_reset,
+	.reset = qcom_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
 };
@@ -432,7 +459,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = arm_mmu500_reset,
+	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
--
2.17.1


