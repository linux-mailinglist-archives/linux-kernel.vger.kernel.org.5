Return-Path: <linux-kernel+bounces-6404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC37819875
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859732829D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07F1CF91;
	Wed, 20 Dec 2023 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bgAFIdiZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3A1401F;
	Wed, 20 Dec 2023 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK5Krov031499;
	Wed, 20 Dec 2023 06:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=WmpbZhkGX40PqZHGp/Y9
	ztSsgDlIPG1j1tH+4dlsAuI=; b=bgAFIdiZRZ7EAdLwM3N4PPDOj5Ef749Lvl88
	w0RJDGIqRGDGzav0aEEDS1R/WwtSuRQ/pv7UeXWD1rqwLqaIZxtLilg31BwgymEh
	tsz3qTVOzUb5volYAahHz3m+WANqa9U42uIaARxJ3vaky8WigueqrNzNPUVxnWjl
	gEM+kp7iz31qkXMxCcxvalureGrf/EHtTt7aXPXmJLgdeGPDUhtaDl2ugJRn0a+s
	h3Uwe2f3UPFwrbZoNtx8KuWlUy2R8aewsQ1p8AhQtNuUgohQ2kjVF/RDJr6K0J78
	dscgIdWJYGO1ZoUc718+HqS0/GmFR/oKZ1XzZ9ocEAwM7dOiEw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fed9b28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK62msU019947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 06:02:48 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 22:02:47 -0800
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC: <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH v3 5/9] iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
Date: Tue, 19 Dec 2023 22:02:32 -0800
Message-ID: <20231220060236.18600-6-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
References: <20231220060236.18600-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mAYKLm1VkJ2VCv788vmO33Y7jPCIKSt8
X-Proofpoint-ORIG-GUID: mAYKLm1VkJ2VCv788vmO33Y7jPCIKSt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200038

The sdm845 platform now supports TBUs, so let's get additional debug
info from the TBUs when a context fault occurs. Implement a custom
context fault handler that does both software + hardware page table
walks and TLB Invalidate All.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 138 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |   4 +
 2 files changed, 142 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
index 2ff00e06d3bf..cd70bb67a79a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
@@ -52,6 +52,11 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 	return container_of(smmu, struct qcom_smmu, smmu);
 }
 
+static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
 static struct qsmmuv500_tbu *qsmmuv500_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
 {
 	struct qsmmuv500_tbu *tbu = NULL;
@@ -301,6 +306,139 @@ static phys_addr_t qsmmuv500_iova_to_phys(struct arm_smmu_domain *smmu_domain,
 	return phys;
 }
 
+static phys_addr_t qcom_smmu_iova_to_phys_hard(struct iommu_domain *domain, dma_addr_t iova)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int idx = smmu_domain->cfg.cbndx;
+	u32 frsynra;
+	u16 sid;
+
+	frsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
+	sid = FIELD_GET(ARM_SMMU_CBFRSYNRA_SID, frsynra);
+
+	return qsmmuv500_iova_to_phys(smmu_domain, iova, sid);
+}
+
+static phys_addr_t qcom_smmu_verify_fault(struct iommu_domain *domain, dma_addr_t iova, u32 fsr)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	phys_addr_t phys_post_tlbiall;
+	phys_addr_t phys;
+
+	phys = qcom_smmu_iova_to_phys_hard(domain, iova);
+	io_pgtable_tlb_flush_all(iop);
+	phys_post_tlbiall = qcom_smmu_iova_to_phys_hard(domain, iova);
+
+	if (phys != phys_post_tlbiall) {
+		dev_err(smmu->dev,
+			"ATOS results differed across TLBIALL... (before: %pa after: %pa)\n",
+			&phys, &phys_post_tlbiall);
+	}
+
+	return (phys == 0 ? phys_post_tlbiall : phys);
+}
+
+irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
+{
+	struct iommu_domain *domain = dev;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	u32 fsr, fsynr, cbfrsynra, resume = 0;
+	int idx = smmu_domain->cfg.cbndx;
+	phys_addr_t phys_soft;
+	unsigned long iova;
+	int ret, tmp;
+
+	static DEFINE_RATELIMIT_STATE(_rs,
+				      DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+
+	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+	if (!(fsr & ARM_SMMU_FSR_FAULT))
+		return IRQ_NONE;
+
+	fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
+	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
+	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
+
+	phys_soft = ops->iova_to_phys(ops, iova);
+
+	tmp = report_iommu_fault(domain, NULL, iova,
+				 fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+	if (!tmp || tmp == -EBUSY) {
+		dev_dbg(smmu->dev,
+			"Context fault handled by client: iova=0x%08lx, fsr=0x%x, fsynr=0x%x, cb=%d\n",
+			iova, fsr, fsynr, idx);
+		dev_dbg(smmu->dev, "soft iova-to-phys=%pa\n", &phys_soft);
+		ret = IRQ_HANDLED;
+		resume = ARM_SMMU_RESUME_TERMINATE;
+	} else {
+		phys_addr_t phys_atos = qcom_smmu_verify_fault(domain, iova, fsr);
+
+		if (__ratelimit(&_rs)) {
+			dev_err(smmu->dev,
+				"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
+				fsr, iova, fsynr, cbfrsynra, idx);
+			dev_err(smmu->dev,
+				"FSR    = %08x [%s%s%s%s%s%s%s%s%s], SID=0x%x\n",
+				fsr,
+				(fsr & 0x02) ? "TF " : "",
+				(fsr & 0x04) ? "AFF " : "",
+				(fsr & 0x08) ? "PF " : "",
+				(fsr & 0x10) ? "EF " : "",
+				(fsr & 0x20) ? "TLBMCF " : "",
+				(fsr & 0x40) ? "TLBLKF " : "",
+				(fsr & 0x80) ? "MHF " : "",
+				(fsr & 0x40000000) ? "SS " : "",
+				(fsr & 0x80000000) ? "MULTI " : "",
+				cbfrsynra);
+
+			dev_err(smmu->dev,
+				"soft iova-to-phys=%pa\n", &phys_soft);
+			if (!phys_soft)
+				dev_err(smmu->dev,
+					"SOFTWARE TABLE WALK FAILED! Looks like %s accessed an unmapped address!\n",
+					dev_name(smmu->dev));
+			if (phys_atos)
+				dev_err(smmu->dev, "hard iova-to-phys (ATOS)=%pa\n",
+					&phys_atos);
+			else
+				dev_err(smmu->dev, "hard iova-to-phys (ATOS) failed\n");
+		}
+		ret = IRQ_NONE;
+		resume = ARM_SMMU_RESUME_TERMINATE;
+	}
+
+	/*
+	 * If the client returns -EBUSY, do not clear FSR and do not RESUME
+	 * if stalled. This is required to keep the IOMMU client stalled on
+	 * the outstanding fault. This gives the client a chance to take any
+	 * debug action and then terminate the stalled transaction.
+	 * So, the sequence in case of stall on fault should be:
+	 * 1) Do not clear FSR or write to RESUME here
+	 * 2) Client takes any debug action
+	 * 3) Client terminates the stalled transaction and resumes the IOMMU
+	 * 4) Client clears FSR. The FSR should only be cleared after 3) and
+	 *    not before so that the fault remains outstanding. This ensures
+	 *    SCTLR.HUPCF has the desired effect if subsequent transactions also
+	 *    need to be terminated.
+	 */
+	if (tmp != -EBUSY) {
+		/* Clear the faulting FSR */
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+
+		/* Retry or terminate any stalled transactions */
+		if (fsr & ARM_SMMU_FSR_SS)
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME, resume);
+	}
+
+	return ret;
+}
+
 static int qsmmuv500_tbu_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 581401d6c18a..6b41a0214db1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -423,6 +423,10 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 	.reset = qcom_sdm845_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+#ifdef CONFIG_ARM_SMMU_QCOM_TBU
+	.context_fault = qcom_smmu_context_fault,
+	.context_fault_needs_threaded_irq = true,
+#endif
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {

