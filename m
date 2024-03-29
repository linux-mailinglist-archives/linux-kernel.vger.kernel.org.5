Return-Path: <linux-kernel+bounces-125433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A08925E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DC7282CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F06D13E416;
	Fri, 29 Mar 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tj4MiHyp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E413E022;
	Fri, 29 Mar 2024 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746448; cv=none; b=SfXdH5ECZfANHl9L0LUgD07fyo1K6rifAEPftCk0cUt5HSWqVfEeLh0YhQ6VVsrEVTqRnVSKGMk2emgJ7LOsE9IUvpEZ26Oc4q1T51ko+7tT2R4z8DffCULlRccyCpPp+sTEz3gtilXYLJswTIZPIhNqQC//ZObJQlfTOsXmXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746448; c=relaxed/simple;
	bh=433s858Ofhq5QpJwmBw+pFYMu3RV2E0h9F/0wjaadU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfs0m/Af2dyFVTelEqWnH4/WMq+YC33HpKZhh5uehBCp05+SAi0IuuHnPzF1sFQNDqnxAcX0TiM5ELoacsjFS/10s6Z13v6tzTzaOkJUQWfDAMzWsbIr341of7lcDk1EMUouweHt4TtNqZhMVRE6Lgk6yZksr0/hzcY0aMEtH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tj4MiHyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TJeOZX000759;
	Fri, 29 Mar 2024 21:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NYo5bTbP9SVkLOmtSkvA5WYl0Q0ujSV7BQbMNNZl+QQ=; b=Tj
	4MiHypKEXPAfBR9Nq8QrYL13NgftohqUTexV+aAW3gIlB1CyfJXwcNIKgbmWpjD4
	698b14fIn2rW6t/gjvR7aTa7GTyqmktB8dV2dMokV58qU9dMIIpcwnng64Ee83oY
	F4+H9PczYuCd8FFjo2jIkrLXzvkIeIpCCGmG6Ve6Vgddnlti1u/sxshjJLbh+sh1
	K9LCV5q7GOEZx7yZ89cFEuPrPXJ0UXSKe6qx0UbSoOe3/0AyXrwgW+c5cBRoo91n
	j+jCckW/AoRwX0qHZsJzjQNXBoj732l0IjG528+ah/Myel+t6cdVl1054oZqNUYM
	SUYA8oNrUFB+SC5SyfYA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g1614-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:07:08 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TL77fQ023836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:07:07 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 14:07:07 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <iommu@lists.linux.dev>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robdclark@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_sukadev@quicinc.com>,
        <quic_pdaly@quicinc.com>, <quic_sudaraja@quicinc.com>,
        <djakov@kernel.org>
Subject: [PATCH v7 3/7] iommu/arm-smmu: Allow using a threaded handler for context interrupts
Date: Fri, 29 Mar 2024 14:06:34 -0700
Message-ID: <20240329210638.3647523-4-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7eU9XJ5asAOAo7nh0Ooq2VTC9UqSlmhm
X-Proofpoint-ORIG-GUID: 7eU9XJ5asAOAo7nh0Ooq2VTC9UqSlmhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290188

Threaded IRQ handlers run in a less critical context compared to normal
IRQs, so they can perform more complex and time-consuming operations
without causing significant delays in other parts of the kernel.
During a context fault, it might be needed to do more processing and
gather debug information from TBUs in the handler. These operations may
sleep, so add an option to use a threaded IRQ handler in these cases.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index c572d877b0e1..dcf0479363c3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -806,8 +806,16 @@ static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 	else
 		context_fault = arm_smmu_context_fault;
 
-	ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
-			       "arm-smmu-context-fault", smmu_domain);
+	if (smmu->impl && smmu->impl->context_fault_needs_threaded_irq)
+		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
+						context_fault,
+						IRQF_ONESHOT | IRQF_SHARED,
+						"arm-smmu-context-fault",
+						smmu_domain);
+	else
+		ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
+				       "arm-smmu-context-fault", smmu_domain);
+
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			cfg->irptndx, irq);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 1670e95c4637..4765c6945c34 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -438,6 +438,7 @@ struct arm_smmu_impl {
 	int (*def_domain_type)(struct device *dev);
 	irqreturn_t (*global_fault)(int irq, void *dev);
 	irqreturn_t (*context_fault)(int irq, void *dev);
+	bool context_fault_needs_threaded_irq;
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_device *smmu,
 				  struct device *dev, int start);

