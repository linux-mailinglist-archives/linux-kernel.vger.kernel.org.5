Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6917CEE00
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjJSCUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjJSCUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:20:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3EA193;
        Wed, 18 Oct 2023 19:20:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1CpC3011988;
        Thu, 19 Oct 2023 02:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=G6HjipX02YTkiexFoCq3YyzdsmobOpc7iYF17nT05VY=;
 b=R/SZ78/YuiUZRQk5EK9xYgKGs4tO7yq54V8iocnbzDs7O7Ouy6LF8H2RSR6SttwI9VW5
 DMgeh2i7vLHcUvJAaUd96z3Xfey2q/lou4HuK2EjnbXp/uTE12Zcs3Gi129b789Kqiw9
 PzrzqIlR9H8XcyPzIZDSE5euFlYd9V8Sk9/n4EgIP6cd0Dv4JVVdA2g2APEgkUm0EmL1
 FySRXTSeqMGBIQ0FYXVNdadDBrkebAo0d67sjne1ws9R6jIOfc5GYAlzp6XyPfm70kV9
 bZBqBUAkSw2q3OkkYwLpQxuLU0M9/3Uxs+FpDytnHrzhOEEMwCxENaHpU1IBPpUWLSaw Zw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9kjtd7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 02:19:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J2Jh1A004205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 02:19:43 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 19:19:42 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>
CC:     <devicetree@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_cgoldswo@quicinc.com>,
        <quic_sukadev@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <djakov@kernel.org>
Subject: [PATCH 5/6] iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
Date:   Wed, 18 Oct 2023 19:19:22 -0700
Message-ID: <20231019021923.13939-6-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fGhWxmN2A7Sq9fLWCvfBgf_UgrYexHcz
X-Proofpoint-GUID: fGhWxmN2A7Sq9fLWCvfBgf_UgrYexHcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdm845 platform now supports TBUs, so let's get additional debug
info from the TBUs when a context fault occurs. Implement a custom
context fault handler that does both software + hardware page table
walks and TLB Invalidate All.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 148 +++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d20263a1cd2c..bcb1e2edec4e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -60,6 +60,11 @@ struct qsmmuv500_tbu {
 
 static DEFINE_SPINLOCK(ecats_lock);
 
+static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
 static struct qsmmuv500_tbu *qsmmuv500_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
 {
 	struct qsmmuv500_tbu *tbu = NULL;
@@ -326,6 +331,145 @@ static phys_addr_t qsmmuv500_iova_to_phys(struct arm_smmu_domain *smmu_domain,
 
 	return phys;
 }
+
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
+static irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
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
+		/*
+		 * Barrier required to ensure that the FSR is cleared
+		 * before resuming SMMU operation
+		 */
+		wmb();
+
+		/* Retry or terminate any stalled transactions */
+		if (fsr & ARM_SMMU_FSR_SS)
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME, resume);
+	}
+
+	return ret;
+}
 #endif
 
 static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
@@ -727,6 +871,10 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 	.reset = qcom_sdm845_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+#ifdef CONFIG_ARM_SMMU_QCOM_TBU
+	.context_fault = qcom_smmu_context_fault,
+	.context_fault_needs_threaded_irq = true,
+#endif
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
