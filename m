Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783B75BEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjGUGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGUGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:36:18 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D7E1BFC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:36:15 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2PbF8010479;
        Thu, 20 Jul 2023 23:35:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=GqhQaI3ci/2Z58j5lRNg+6rR77RLGp456Nv7btgRFiA=;
 b=Wi4aCN1qb2plLVz79WJcR/gq5LmvarufBb5ISWQDPTVH1FwnTnamrrOSWWXEkMwfsW+H
 qDn/Eyf7XVWhk1Ec5+M0uq+PU+1mcuK4b0FL/kVuwQHASeTbdLv/1RLpK2FE2l940s2j
 MhfqBwppxEqIRk+VzvpkWJcRDhNx9N3ifg8wh1CYtJq6oCj3MPGVC8oY02y1cqWN2Tjr
 tr1Af0RBiHYpzwGK1mtQ/PxepKZ5ZrwwIOyRHbx8KSjyBlitQpz0N2gnI3TyFZiIhOJV
 g+Rnql24DPAaxs79GKZpLXPib3uXVNgCRVy1hLY8a0+tpL2bblgT5X7lFN9FvESup7p+ 6A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh7g8nkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 23:35:49 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jul
 2023 23:35:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 20 Jul 2023 23:35:47 -0700
Received: from odyssey-031.marvell.com (unknown [10.75.48.92])
        by maili.marvell.com (Postfix) with ESMTP id C6A193F7068;
        Thu, 20 Jul 2023 23:35:46 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [RESEND PATCH 1/4] iommu/arm-smmu-v3: Add support for ECMDQ register mode
Date:   Fri, 21 Jul 2023 02:35:10 -0400
Message-ID: <20230721063513.33431-2-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
References: <20230721063513.33431-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5KSR_5cuM44LwNz2vtgtOEtQ4wy13NLR
X-Proofpoint-GUID: 5KSR_5cuM44LwNz2vtgtOEtQ4wy13NLR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_03,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Ensure that each core exclusively occupies an ECMDQ and all of them are
enabled during initialization. During this initialization process, any
errors will result in a fallback to using normal CMDQ.

When GERROR is triggered by ECMDQ, all ECMDQs need to be traversed: the
ECMDQs with errors will be processed and the ECMDQs without errors will
be skipped directly.

Compared with register SMMU_CMDQ_PROD, register SMMU_ECMDQ_PROD has one
more 'EN' bit and one more 'ERRACK' bit. Therefore, an extra member
'ecmdq_prod' is added to record the values of these two bits. Each time
register SMMU_ECMDQ_PROD is updated, the value of 'ecmdq_prod' is ORed.
After the error indicated by SMMU_GERROR.CMDQP_ERR is fixed, the 'ERRACK'
bit needs to be toggled to resume the corresponding ECMDQ. Therefore, a
rwlock is used to protect the write operation to bit 'ERRACK' during error
handling and the read operation to bit 'ERRACK' during command insertion.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 210 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  36 ++++
 2 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..dfb5bf8cbcf9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -347,6 +347,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
+	if (smmu->ecmdq_enabled) {
+		struct arm_smmu_ecmdq *ecmdq;
+
+		ecmdq = *this_cpu_ptr(smmu->ecmdq);
+
+		return &ecmdq->cmdq;
+	}
+
 	return &smmu->cmdq;
 }
 
@@ -429,6 +437,38 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
 }
 
+static void arm_smmu_ecmdq_skip_err(struct arm_smmu_device *smmu)
+{
+	int i;
+	u32 prod, cons;
+	struct arm_smmu_queue *q;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		unsigned long flags;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdq, i);
+		q = &ecmdq->cmdq.q;
+
+		prod = readl_relaxed(q->prod_reg);
+		cons = readl_relaxed(q->cons_reg);
+		if (((prod ^ cons) & ECMDQ_CONS_ERR) == 0)
+			continue;
+
+		__arm_smmu_cmdq_skip_err(smmu, q);
+
+		write_lock_irqsave(&q->ecmdq_lock, flags);
+		q->ecmdq_prod &= ~ECMDQ_PROD_ERRACK;
+		q->ecmdq_prod |= cons & ECMDQ_CONS_ERR;
+
+		prod = readl_relaxed(q->prod_reg);
+		prod &= ~ECMDQ_PROD_ERRACK;
+		prod |= cons & ECMDQ_CONS_ERR;
+		writel(prod, q->prod_reg);
+		write_unlock_irqrestore(&q->ecmdq_lock, flags);
+	}
+}
+
 /*
  * Command queue locking.
  * This is a form of bastardised rwlock with the following major changes:
@@ -825,7 +865,13 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
 		 */
-		writel_relaxed(prod, cmdq->q.prod_reg);
+		if (smmu->ecmdq_enabled) {
+			read_lock(&cmdq->q.ecmdq_lock);
+			writel_relaxed(prod | cmdq->q.ecmdq_prod, cmdq->q.prod_reg);
+			read_unlock(&cmdq->q.ecmdq_lock);
+		} else {
+			writel_relaxed(prod, cmdq->q.prod_reg);
+		}
 
 		/*
 		 * e. Tell the next owner we're done
@@ -1701,6 +1747,9 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_CMDQ_ERR)
 		arm_smmu_cmdq_skip_err(smmu);
 
+	if (active & GERROR_CMDQP_ERR)
+		arm_smmu_ecmdq_skip_err(smmu);
+
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 	return IRQ_HANDLED;
 }
@@ -2957,6 +3006,20 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_ecmdq_init(struct arm_smmu_cmdq *cmdq)
+{
+	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
+
+	atomic_set(&cmdq->owner_prod, 0);
+	atomic_set(&cmdq->lock, 0);
+
+	cmdq->valid_map = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
+	if (!cmdq->valid_map)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -3307,6 +3370,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 {
+	int i;
 	int ret;
 	u32 reg, enables;
 	struct arm_smmu_cmdq_ent cmd;
@@ -3351,6 +3415,28 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		struct arm_smmu_ecmdq *ecmdq;
+		struct arm_smmu_queue *q;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdq, i);
+		q = &ecmdq->cmdq.q;
+
+		writeq_relaxed(q->q_base, ecmdq->base + ARM_SMMU_ECMDQ_BASE);
+		writel_relaxed(q->llq.prod, ecmdq->base + ARM_SMMU_ECMDQ_PROD);
+		writel_relaxed(q->llq.cons, ecmdq->base + ARM_SMMU_ECMDQ_CONS);
+
+		/* enable ecmdq */
+		writel(ECMDQ_PROD_EN, q->prod_reg);
+		ret = readl_relaxed_poll_timeout(q->cons_reg, reg, reg & ECMDQ_CONS_ENACK,
+					  1, ARM_SMMU_POLL_TIMEOUT_US);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] enable failed\n", i);
+			smmu->ecmdq_enabled = 0;
+			break;
+		}
+	}
+
 	enables = CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
@@ -3476,6 +3562,115 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 		}
 		break;
 	}
+};
+
+static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
+{
+	int cpu;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
+		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+		if (!ecmdq)
+			return -ENOMEM;
+
+		for_each_possible_cpu(cpu)
+			*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
+
+		/* A core requires at most one ECMDQ */
+		smmu->nr_ecmdq = num_possible_cpus();
+
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+
+static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
+{
+	int ret, cpu;
+	u32 i, nump, numq, gap;
+	u32 reg, shift_increment;
+	u64 addr, smmu_dma_base;
+	void __iomem *cp_regs, *cp_base;
+
+	/* IDR6 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
+	nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
+	numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
+	smmu->nr_ecmdq = nump * numq;
+	gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
+
+	smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);
+	cp_regs = ioremap(smmu_dma_base + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
+	if (!cp_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < nump; i++) {
+		u64 val, pre_addr;
+
+		val = readq_relaxed(cp_regs + 32 * i);
+		if (!(val & ECMDQ_CP_PRESET)) {
+			iounmap(cp_regs);
+			dev_err(smmu->dev, "ecmdq control page %u is memory mode\n", i);
+			return -EFAULT;
+		}
+
+		if (i && ((val & ECMDQ_CP_ADDR) != (pre_addr + ECMDQ_CP_RRESET_SIZE))) {
+			iounmap(cp_regs);
+			dev_err(smmu->dev, "ecmdq_cp memory region is not contiguous\n");
+			return -EFAULT;
+		}
+
+		pre_addr = val & ECMDQ_CP_ADDR;
+	}
+
+	addr = readl_relaxed(cp_regs) & ECMDQ_CP_ADDR;
+	iounmap(cp_regs);
+
+	cp_base = devm_ioremap(smmu->dev, smmu_dma_base + addr, ECMDQ_CP_RRESET_SIZE * nump);
+	if (!cp_base)
+		return -ENOMEM;
+
+	smmu->ecmdq = devm_alloc_percpu(smmu->dev, struct arm_smmu_ecmdq *);
+	if (!smmu->ecmdq)
+		return -ENOMEM;
+
+	ret = arm_smmu_ecmdq_layout(smmu);
+	if (ret)
+		return ret;
+
+	shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
+
+	addr = 0;
+	for_each_possible_cpu(cpu) {
+		struct arm_smmu_ecmdq *ecmdq;
+		struct arm_smmu_queue *q;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
+		ecmdq->base = cp_base + addr;
+
+		q = &ecmdq->cmdq.q;
+
+		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
+		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
+				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
+		if (ret)
+			return ret;
+
+		q->ecmdq_prod = ECMDQ_PROD_EN;
+		rwlock_init(&q->ecmdq_lock);
+
+		ret = arm_smmu_ecmdq_init(&ecmdq->cmdq);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] init failed\n", i);
+			return ret;
+		}
+
+		addr += gap;
+	}
+
+	return 0;
 }
 
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
@@ -3588,6 +3783,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
+	if (reg & IDR1_ECMDQ)
+		smmu->features |= ARM_SMMU_FEAT_ECMDQ;
+
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
@@ -3695,6 +3893,16 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
+
+	if (smmu->features & ARM_SMMU_FEAT_ECMDQ) {
+		int err;
+
+		err = arm_smmu_ecmdq_probe(smmu);
+		if (err) {
+			dev_err(smmu->dev, "suppress ecmdq feature, errno=%d\n", err);
+			smmu->ecmdq_enabled = 0;
+		}
+	}
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e..1f8777817e31 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -41,6 +41,7 @@
 #define IDR0_S2P			(1 << 0)
 
 #define ARM_SMMU_IDR1			0x4
+#define IDR1_ECMDQ			(1 << 31)
 #define IDR1_TABLES_PRESET		(1 << 30)
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
@@ -113,6 +114,7 @@
 #define ARM_SMMU_IRQ_CTRLACK		0x54
 
 #define ARM_SMMU_GERROR			0x60
+#define GERROR_CMDQP_ERR		(1 << 9)
 #define GERROR_SFM_ERR			(1 << 8)
 #define GERROR_MSI_GERROR_ABT_ERR	(1 << 7)
 #define GERROR_MSI_PRIQ_ABT_ERR		(1 << 6)
@@ -158,6 +160,26 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
+#define ARM_SMMU_IDR6			0x190
+#define IDR6_LOG2NUMP			GENMASK(27, 24)
+#define IDR6_LOG2NUMQ			GENMASK(19, 16)
+#define IDR6_BA_DOORBELLS		GENMASK(9, 0)
+
+#define ARM_SMMU_ECMDQ_BASE		0x00
+#define ARM_SMMU_ECMDQ_PROD		0x08
+#define ARM_SMMU_ECMDQ_CONS		0x0c
+#define ECMDQ_MAX_SZ_SHIFT		8
+#define ECMDQ_PROD_EN			(1 << 31)
+#define ECMDQ_CONS_ENACK		(1 << 31)
+#define ECMDQ_CONS_ERR			(1 << 23)
+#define ECMDQ_PROD_ERRACK		(1 << 23)
+
+#define ARM_SMMU_ECMDQ_CP_BASE		0x4000
+#define ECMDQ_CP_ADDR			GENMASK_ULL(51, 12)
+#define ECMDQ_CP_CMDQGS			GENMASK_ULL(2, 1)
+#define ECMDQ_CP_PRESET			(1UL << 0)
+#define ECMDQ_CP_RRESET_SIZE		0x10000
+
 #define ARM_SMMU_REG_SZ			0xe00
 
 /* Common MSI config fields */
@@ -527,6 +549,8 @@ struct arm_smmu_ll_queue {
 struct arm_smmu_queue {
 	struct arm_smmu_ll_queue	llq;
 	int				irq; /* Wired interrupt */
+	u32				ecmdq_prod;
+	rwlock_t			ecmdq_lock;
 
 	__le64				*base;
 	dma_addr_t			base_dma;
@@ -552,6 +576,11 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 };
 
+struct arm_smmu_ecmdq {
+	struct arm_smmu_cmdq		cmdq;
+	void __iomem			*base;
+};
+
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	int				num;
@@ -646,6 +675,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_NESTING		(1 << 19)
+#define ARM_SMMU_FEAT_ECMDQ		(1 << 20)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -654,6 +684,12 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
+	union {
+		u32			nr_ecmdq;
+		u32			ecmdq_enabled;
+	};
+	struct arm_smmu_ecmdq *__percpu	*ecmdq;
+
 	struct arm_smmu_cmdq		cmdq;
 	struct arm_smmu_evtq		evtq;
 	struct arm_smmu_priq		priq;
-- 
2.34.1

