Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F87CEE02
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjJSCUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjJSCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:20:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E212A;
        Wed, 18 Oct 2023 19:20:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0aJuj006011;
        Thu, 19 Oct 2023 02:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=E7QaDYoQ1dy57FUxkvOyRsuqq11ruI/NizQa9HUhKqA=;
 b=lrB1cOUVlFIDRHUMmMm7/7Cf2jWQbPEX/QudiA8S2gIaaAUN6TVS4iMbD4yu2YjxgwOe
 RrVKCvmnxew0PBqr/6O6iDljB6/rNi1gUZBX3TSZLCAixQd5G/M5oOwjMRQ7yey7HoHa
 2p3tzHi+EhUdvXhCS7vIjTh+H+6P8iKQ/aFtSFwwOruianClbuqjfn44DQz+mfNv32ub
 1itD1Py6/O/SIvYnMSa+bLcT3CqDmDXpCyfJDDzYz8m4PWGtu4vGdbQ4q5Y632Bo1x0X
 wQn27GshmrntWh3DwUZd9GmX1+H0kqbf3T4lystthL29ijcL7zL/oOGuQC7iPIVtT46k hA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttg82shh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 02:19:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J2Jg4F004197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 02:19:42 GMT
Received: from hu-c-gdjako-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 19:19:41 -0700
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
Subject: [PATCH 3/6] iommu/arm-smmu-qcom: Add Qualcomm TBU driver
Date:   Wed, 18 Oct 2023 19:19:20 -0700
Message-ID: <20231019021923.13939-4-quic_c_gdjako@quicinc.com>
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
X-Proofpoint-GUID: fX_v0Jtsj2YEHX99-CbeAZGGrGqEmJSX
X-Proofpoint-ORIG-GUID: fX_v0Jtsj2YEHX99-CbeAZGGrGqEmJSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=914 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Qualcomm implementation of the ARM MMU-500 TBU.
The driver will enable the resources needed by the TBU and will
configure the registers for some debug features like checking if
there are any pending transactions, capturing transactions and
running ATOS (Address Translation Operations). ATOS/eCATS are used
to manually trigger an address translation of IOVA to physical
address by the SMMU hardware.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 drivers/iommu/Kconfig                      |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 384 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |   2 +
 3 files changed, 394 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 2b12b583ef4b..2b024d65b921 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -377,6 +377,14 @@ config ARM_SMMU_QCOM
 	  When running on a Qualcomm platform that has the custom variant
 	  of the ARM SMMU, this needs to be built into the SMMU driver.
 
+config ARM_SMMU_QCOM_TBU
+	bool "Qualcomm TBU driver"
+	depends on ARM_SMMU_QCOM
+	help
+	  The SMMU on Qualcomm platform may include a Translation Buffer
+	  Units (TBUs) for each master. Enabling support for these will
+	  allow operating the TBUs to help debugging context faults.
+
 config ARM_SMMU_QCOM_DEBUG
 	bool "ARM SMMU QCOM implementation defined debug support"
 	depends on ARM_SMMU_QCOM
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 655c7f50ca84..d20263a1cd2c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -10,17 +10,324 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/interconnect.h>
+#include <linux/iopoll.h>
 
 #include "arm-smmu.h"
 #include "arm-smmu-qcom.h"
 
 #define QCOM_DUMMY_VAL	-1
 
+#define TBU_DBG_TIMEOUT_US		100
+#define DEBUG_AXUSER_REG		0x30
+#define DEBUG_AXUSER_CDMID		GENMASK_ULL(43, 36)
+#define DEBUG_AXUSER_CDMID_VAL		0xff
+#define DEBUG_PAR_REG			0x28
+#define DEBUG_PAR_FAULT_VAL		BIT(0)
+#define DEBUG_PAR_PA			GENMASK_ULL(47, 12)
+#define DEBUG_SID_HALT_REG		0x0
+#define DEBUG_SID_HALT_VAL		BIT(16)
+#define DEBUG_SID_HALT_SID		GENMASK(9, 0)
+#define DEBUG_SR_HALT_ACK_REG		0x20
+#define DEBUG_SR_HALT_ACK_VAL		BIT(1)
+#define DEBUG_SR_ECATS_RUNNING_VAL	BIT(0)
+#define DEBUG_TXN_AXCACHE		GENMASK(5, 2)
+#define DEBUG_TXN_AXPROT		GENMASK(8, 6)
+#define DEBUG_TXN_AXPROT_PRIV		0x1
+#define DEBUG_TXN_AXPROT_NSEC		0x2
+#define DEBUG_TXN_TRIGG_REG		0x18
+#define DEBUG_TXN_TRIGGER		BIT(0)
+#define DEBUG_VA_ADDR_REG		0x8
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
 }
 
+#ifdef CONFIG_ARM_SMMU_QCOM_TBU
+
+struct qsmmuv500_tbu {
+	struct device *dev;
+	struct arm_smmu_device *smmu;
+	u32 sid_range[2];
+	struct list_head list;
+	struct clk *clk;
+	struct icc_path	*path;
+	void __iomem *base;
+	spinlock_t halt_lock; /* protects halt count */
+	int halt_count;
+};
+
+static DEFINE_SPINLOCK(ecats_lock);
+
+static struct qsmmuv500_tbu *qsmmuv500_find_tbu(struct qcom_smmu *qsmmu, u32 sid)
+{
+	struct qsmmuv500_tbu *tbu = NULL;
+	u32 start, end;
+
+	mutex_lock(&qsmmu->tbu_list_lock);
+
+	list_for_each_entry(tbu, &qsmmu->tbu_list, list) {
+		start = tbu->sid_range[0];
+		end = start + tbu->sid_range[1];
+
+		if (start <= sid && sid < end)
+			break;
+	}
+
+	mutex_unlock(&qsmmu->tbu_list_lock);
+
+	return tbu;
+}
+
+static int qsmmuv500_tbu_halt(struct qsmmuv500_tbu *tbu, struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int ret = 0, idx = smmu_domain->cfg.cbndx;
+	unsigned long flags;
+	u32 val, fsr, status;
+
+	spin_lock_irqsave(&tbu->halt_lock, flags);
+	if (tbu->halt_count) {
+		tbu->halt_count++;
+		goto out;
+	}
+
+	val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val |= DEBUG_SID_HALT_VAL;
+	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+	if ((fsr & ARM_SMMU_FSR_FAULT) && (fsr & ARM_SMMU_FSR_SS)) {
+		u32 sctlr_orig, sctlr;
+
+		/*
+		 * We are in a fault. Our request to halt the bus will not
+		 * complete until transactions in front of us (such as the fault
+		 * itself) have completed. Disable iommu faults and terminate
+		 * any existing transactions.
+		 */
+		sctlr_orig = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR);
+		sctlr = sctlr_orig & ~(ARM_SMMU_SCTLR_CFCFG | ARM_SMMU_SCTLR_CFIE);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+
+		/* Ensure that the FSR is cleared */
+		wmb();
+
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME, ARM_SMMU_RESUME_TERMINATE);
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr_orig);
+	}
+
+	if (readl_poll_timeout_atomic(tbu->base + DEBUG_SR_HALT_ACK_REG, status,
+				      (status & DEBUG_SR_HALT_ACK_VAL),
+				      0, TBU_DBG_TIMEOUT_US)) {
+		dev_err(tbu->dev, "Timeout while trying to halt TBU!\n");
+		ret = -ETIMEDOUT;
+
+		val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+		val &= ~DEBUG_SID_HALT_VAL;
+		writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+		goto out;
+	}
+
+	tbu->halt_count = 1;
+
+out:
+	spin_unlock_irqrestore(&tbu->halt_lock, flags);
+	return ret;
+}
+
+static void qsmmuv500_tbu_resume(struct qsmmuv500_tbu *tbu)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&tbu->halt_lock, flags);
+	if (!tbu->halt_count) {
+		WARN(1, "%s: halt_count is 0", dev_name(tbu->dev));
+		goto out;
+	}
+
+	if (tbu->halt_count > 1) {
+		tbu->halt_count--;
+		goto out;
+	}
+
+	val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val &= ~DEBUG_SID_HALT_VAL;
+	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+	tbu->halt_count = 0;
+out:
+	spin_unlock_irqrestore(&tbu->halt_lock, flags);
+}
+
+static phys_addr_t qsmmuv500_tbu_trigger_atos(struct arm_smmu_domain *smmu_domain,
+					      struct qsmmuv500_tbu *tbu, dma_addr_t iova, u32 sid)
+{
+	bool ecats_timedout = false;
+	phys_addr_t phys = 0;
+	ktime_t timeout;
+	u64 val;
+
+	/* Set address and stream-id */
+	val = readq_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val &= ~DEBUG_SID_HALT_SID;
+	val |= FIELD_PREP(DEBUG_SID_HALT_SID, sid);
+	writeq_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+	writeq_relaxed(iova, tbu->base + DEBUG_VA_ADDR_REG);
+	val = FIELD_PREP(DEBUG_AXUSER_CDMID, DEBUG_AXUSER_CDMID_VAL);
+	writeq_relaxed(val, tbu->base + DEBUG_AXUSER_REG);
+
+	/* Write-back read and write-allocate */
+	val = FIELD_PREP(DEBUG_TXN_AXCACHE, 0xF);
+
+	/* Non-secure access */
+	val |= FIELD_PREP(DEBUG_TXN_AXPROT, DEBUG_TXN_AXPROT_NSEC);
+
+	/* Priviledged access */
+	val |= FIELD_PREP(DEBUG_TXN_AXPROT, DEBUG_TXN_AXPROT_PRIV);
+
+	val |= DEBUG_TXN_TRIGGER;
+	writeq_relaxed(val, tbu->base + DEBUG_TXN_TRIGG_REG);
+
+	timeout = ktime_add_us(ktime_get(), TBU_DBG_TIMEOUT_US);
+	for (;;) {
+		val = readl_relaxed(tbu->base + DEBUG_SR_HALT_ACK_REG);
+		if (!(val & DEBUG_SR_ECATS_RUNNING_VAL))
+			break;
+		val = readl_relaxed(tbu->base + DEBUG_PAR_REG);
+		if (val & DEBUG_PAR_FAULT_VAL)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			ecats_timedout = true;
+			break;
+		}
+	}
+
+	val = readq_relaxed(tbu->base + DEBUG_PAR_REG);
+	if (val & DEBUG_PAR_FAULT_VAL)
+		dev_err(tbu->dev, "ECATS generated a fault interrupt! PAR = %llx, SID=0x%x\n",
+			val, sid);
+	else if (ecats_timedout)
+		dev_err_ratelimited(tbu->dev, "ECATS translation timed out!\n");
+	else
+		phys = FIELD_GET(DEBUG_PAR_PA, val);
+
+	/* Reset hardware */
+	writeq_relaxed(0, tbu->base + DEBUG_TXN_TRIGG_REG);
+	writeq_relaxed(0, tbu->base + DEBUG_VA_ADDR_REG);
+	val = readl_relaxed(tbu->base + DEBUG_SID_HALT_REG);
+	val &= ~DEBUG_SID_HALT_SID;
+	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
+
+	return phys;
+}
+
+static phys_addr_t qsmmuv500_iova_to_phys(struct arm_smmu_domain *smmu_domain,
+					  dma_addr_t iova, u32 sid)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	int idx = smmu_domain->cfg.cbndx;
+	struct qsmmuv500_tbu *tbu;
+	u32 sctlr_orig, sctlr;
+	phys_addr_t phys = 0;
+	unsigned long flags;
+	int needs_redo = 0;
+	int ret;
+	u64 fsr;
+
+	tbu = qsmmuv500_find_tbu(qsmmu, sid);
+	if (!tbu)
+		return 0;
+
+	ret = icc_set_bw(tbu->path, 0, UINT_MAX);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(tbu->clk);
+	if (ret)
+		goto disable_icc;
+
+	ret = qsmmuv500_tbu_halt(tbu, smmu_domain);
+	if (ret)
+		goto disable_clk;
+
+	/*
+	 * ECATS can trigger the fault interrupt, so disable it temporarily
+	 * and check for an interrupt manually.
+	 */
+	sctlr_orig = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_SCTLR);
+	sctlr = sctlr_orig & ~(ARM_SMMU_SCTLR_CFCFG | ARM_SMMU_SCTLR_CFIE);
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr);
+
+	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+	if (fsr & ARM_SMMU_FSR_FAULT) {
+		/* Clear pending interrupts */
+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+		/*
+		 * Barrier required to ensure that the FSR is cleared
+		 * before resuming SMMU operation.
+		 */
+		wmb();
+
+		/*
+		 * TBU halt takes care of resuming any stalled transcation.
+		 * Kept it here for completeness sake.
+		 */
+		if (fsr & ARM_SMMU_FSR_SS)
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+					  ARM_SMMU_RESUME_TERMINATE);
+	}
+
+	/* Only one concurrent atos operation */
+	spin_lock_irqsave(&ecats_lock, flags);
+
+	/*
+	 * After a failed translation, the next successful translation will
+	 * incorrectly be reported as a failure.
+	 */
+	do {
+		phys = qsmmuv500_tbu_trigger_atos(smmu_domain, tbu, iova, sid);
+
+		fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
+		if (fsr & ARM_SMMU_FSR_FAULT) {
+			/* Clear pending interrupts */
+			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
+			/*
+			 * Barrier required to ensure that the FSR is cleared
+			 * before resuming SMMU operation.
+			 */
+			wmb();
+
+			if (fsr & ARM_SMMU_FSR_SS)
+				arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
+						  ARM_SMMU_RESUME_TERMINATE);
+		}
+	} while (!phys && needs_redo++ < 2);
+
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr_orig);
+	spin_unlock_irqrestore(&ecats_lock, flags);
+	qsmmuv500_tbu_resume(tbu);
+
+	/* Read to complete prior write transcations */
+	readl_relaxed(tbu->base + DEBUG_SR_HALT_ACK_REG);
+
+	/* Wait for read to complete */
+	rmb();
+
+disable_clk:
+	clk_disable_unprepare(tbu->clk);
+disable_icc:
+	icc_set_bw(tbu->path, 0, 0);
+
+	return phys;
+}
+#endif
+
 static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
 				int sync, int status)
 {
@@ -588,3 +895,80 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	return smmu;
 }
+
+#ifdef CONFIG_ARM_SMMU_QCOM_TBU
+
+static const struct of_device_id qsmmuv500_tbu_of_match[] = {
+	{ .compatible = "qcom,qsmmuv500-tbu" },
+	{ }
+};
+
+static int qsmmuv500_tbu_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct arm_smmu_device *smmu;
+	struct qsmmuv500_tbu *tbu;
+	struct qcom_smmu *qsmmu;
+	int ret;
+
+	smmu = dev_get_drvdata(dev->parent);
+	if (!smmu)
+		return -EPROBE_DEFER;
+
+	qsmmu = to_qcom_smmu(smmu);
+
+	tbu = devm_kzalloc(dev, sizeof(*tbu), GFP_KERNEL);
+	if (!tbu)
+		return -ENOMEM;
+
+	tbu->dev = dev;
+	INIT_LIST_HEAD(&tbu->list);
+	spin_lock_init(&tbu->halt_lock);
+
+	tbu->base = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(tbu->base))
+		return PTR_ERR(tbu->base);
+
+	ret = of_property_read_u32_array(np, "qcom,stream-id-range", tbu->sid_range, 2);
+	if (ret) {
+		dev_err(dev, "The DT property 'qcom,stream-id-range' is mandatory\n");
+		return ret;
+	}
+
+	tbu->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(tbu->clk))
+		return PTR_ERR(tbu->clk);
+
+	tbu->path = devm_of_icc_get(dev, NULL);
+	if (IS_ERR(tbu->path))
+		return PTR_ERR(tbu->path);
+
+	mutex_lock(&qsmmu->tbu_list_lock);
+	list_add_tail(&tbu->list, &qsmmu->tbu_list);
+	mutex_unlock(&qsmmu->tbu_list_lock);
+
+	dev_set_drvdata(dev, tbu);
+
+	return 0;
+}
+
+static void qsmmuv500_tbu_remove(struct platform_device *pdev)
+{
+	struct qsmmuv500_tbu *tbu = dev_get_drvdata(&pdev->dev);
+
+	clk_disable_unprepare(tbu->clk);
+	clk_put(tbu->clk);
+	icc_put(tbu->path);
+}
+
+static struct platform_driver qsmmuv500_tbu_driver = {
+	.driver = {
+		.name           = "qsmmuv500-tbu",
+		.of_match_table = of_match_ptr(qsmmuv500_tbu_of_match),
+	},
+	.probe  = qsmmuv500_tbu_probe,
+	.remove_new = qsmmuv500_tbu_remove,
+};
+module_platform_driver(qsmmuv500_tbu_driver);
+#endif
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 703fd5817ec1..e5df65c0f81a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -136,6 +136,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CBAR_VMID		GENMASK(7, 0)
 
 #define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
+#define ARM_SMMU_CBFRSYNRA_SID		GENMASK(15, 0)
 
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
 #define ARM_SMMU_CBA2R_VMID16		GENMASK(31, 16)
@@ -238,6 +239,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_ATSR		0x8f0
 #define ARM_SMMU_ATSR_ACTIVE		BIT(0)
 
+#define ARM_SMMU_RESUME_TERMINATE	BIT(0)
 
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
