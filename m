Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39113776055
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjHINNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHINNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:13:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D11128
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:13:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RLVqW46RGz4f3jXT
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:13:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6n1kNNkTII5AQ--.15907S5;
        Wed, 09 Aug 2023 21:13:29 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Add support for ECMDQ register mode
Date:   Wed,  9 Aug 2023 21:13:02 +0800
Message-Id: <20230809131303.1355-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
References: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6n1kNNkTII5AQ--.15907S5
X-Coremail-Antispam: 1UD129KBjvJXoW3KF4xXr1UGFWkGFy8WF4kWFg_yoWkKw4fpa
        1DCas0yrn8tF1Sk348ZrsYvrnxK34Y9a40yrWUWa9xXw1jy34fXF1rKwn5tr97urW8KF1f
        Jr1jqFWUCrZrJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU88-BtUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
be skipped directly. Compared with register SMMU_CMDQ_PROD, register
SMMU_ECMDQ_PROD has one more 'EN' bit and one more 'ERRACK' bit. After
the error indicated by SMMU_GERROR.CMDQP_ERR is fixed, the 'ERRACK'
bit needs to be toggled to resume the corresponding ECMDQ. In order to
lockless protection against the write operation to bit 'ERRACK' during
error handling and the read operation to bit 'ERRACK' during command
insertion. Send IPI to the faulty CPU and perform the toggle operation
on the faulty CPU. Because the command insertion is protected by
local_irq_save(), so no race.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 219 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  33 +++
 2 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc35056019e0..c64b34be8eb9181 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -347,6 +347,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
+	if (smmu->ecmdq_enabled) {
+		struct arm_smmu_ecmdq *ecmdq;
+
+		ecmdq = *this_cpu_ptr(smmu->ecmdqs);
+
+		return &ecmdq->cmdq;
+	}
+
 	return &smmu->cmdq;
 }
 
@@ -429,6 +437,43 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
 }
 
+static void arm_smmu_ecmdq_err_ack(void *info)
+{
+	u32 prod, cons;
+	struct arm_smmu_queue *q = info;
+
+	prod = readl_relaxed(q->prod_reg);
+	cons = readl_relaxed(q->cons_reg);
+	prod &= ~ECMDQ_PROD_ERRACK;
+	prod |= cons & ECMDQ_CONS_ERR;
+	writel(prod, q->prod_reg);
+}
+
+static void arm_smmu_ecmdq_skip_err(struct arm_smmu_device *smmu)
+{
+	int i;
+	u32 prod, cons;
+	struct arm_smmu_queue *q;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	if (!smmu->ecmdq_enabled)
+		return;
+
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		ecmdq = *per_cpu_ptr(smmu->ecmdqs, i);
+		q = &ecmdq->cmdq.q;
+
+		prod = readl_relaxed(q->prod_reg);
+		cons = readl_relaxed(q->cons_reg);
+		if (((prod ^ cons) & ECMDQ_CONS_ERR) == 0)
+			continue;
+
+		__arm_smmu_cmdq_skip_err(smmu, q);
+
+		smp_call_function_single(i, arm_smmu_ecmdq_err_ack, q, true);
+	}
+}
+
 /*
  * Command queue locking.
  * This is a form of bastardised rwlock with the following major changes:
@@ -825,7 +870,10 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
 		 */
-		writel_relaxed(prod, cmdq->q.prod_reg);
+		if (smmu->ecmdq_enabled)
+			writel_relaxed(prod | ECMDQ_PROD_EN, cmdq->q.prod_reg);
+		else
+			writel_relaxed(prod, cmdq->q.prod_reg);
 
 		/*
 		 * e. Tell the next owner we're done
@@ -1701,6 +1749,9 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_CMDQ_ERR)
 		arm_smmu_cmdq_skip_err(smmu);
 
+	if (active & GERROR_CMDQP_ERR)
+		arm_smmu_ecmdq_skip_err(smmu);
+
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 	return IRQ_HANDLED;
 }
@@ -2957,6 +3008,20 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
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
@@ -3305,6 +3370,36 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+static void arm_smmu_ecmdq_reset(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	int i, ret;
+	struct arm_smmu_queue *q;
+	struct arm_smmu_ecmdq *ecmdq;
+
+	if (!smmu->ecmdq_enabled)
+		return;
+
+	for (i = 0; i < smmu->nr_ecmdq; i++) {
+		ecmdq = *per_cpu_ptr(smmu->ecmdqs, i);
+
+		q = &ecmdq->cmdq.q;
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
+			smmu->ecmdq_enabled = false;
+			break;
+		}
+	}
+}
+
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 {
 	int ret;
@@ -3359,6 +3454,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	arm_smmu_ecmdq_reset(smmu);
+
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
@@ -3476,6 +3573,112 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 		}
 		break;
 	}
+};
+
+static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
+{
+	int cpu;
+	struct arm_smmu_ecmdq __percpu *ecmdq;
+
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
+		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+		if (!ecmdq)
+			return -ENOMEM;
+
+		for_each_possible_cpu(cpu)
+			*per_cpu_ptr(smmu->ecmdqs, cpu) = per_cpu_ptr(ecmdq, cpu);
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
+	u64 offset;
+	void __iomem *cp_regs, *cp_base;
+
+	/* IDR6 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR6);
+	nump = 1 << FIELD_GET(IDR6_LOG2NUMP, reg);
+	numq = 1 << FIELD_GET(IDR6_LOG2NUMQ, reg);
+	smmu->nr_ecmdq = nump * numq;
+	gap = ECMDQ_CP_RRESET_SIZE >> FIELD_GET(IDR6_LOG2NUMQ, reg);
+
+	cp_regs = ioremap(smmu->iobase + ARM_SMMU_ECMDQ_CP_BASE, PAGE_SIZE);
+	if (!cp_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < nump; i++) {
+		u64 val, pre_addr = 0;
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
+	offset = readl_relaxed(cp_regs) & ECMDQ_CP_ADDR;
+	iounmap(cp_regs);
+
+	cp_base = devm_ioremap(smmu->dev, smmu->iobase + offset, ECMDQ_CP_RRESET_SIZE * nump);
+	if (!cp_base)
+		return -ENOMEM;
+
+	smmu->ecmdqs = devm_alloc_percpu(smmu->dev, struct arm_smmu_ecmdq *);
+	if (!smmu->ecmdqs)
+		return -ENOMEM;
+
+	ret = arm_smmu_ecmdq_layout(smmu);
+	if (ret)
+		return ret;
+
+	shift_increment = order_base_2(num_possible_cpus() / smmu->nr_ecmdq);
+
+	offset = 0;
+	for_each_possible_cpu(cpu) {
+		struct arm_smmu_ecmdq *ecmdq;
+		struct arm_smmu_queue *q;
+
+		ecmdq = *per_cpu_ptr(smmu->ecmdqs, cpu);
+		ecmdq->base = cp_base + offset;
+
+		q = &ecmdq->cmdq.q;
+
+		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
+		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
+				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
+		if (ret)
+			return ret;
+
+		ret = arm_smmu_ecmdq_init(&ecmdq->cmdq);
+		if (ret) {
+			dev_err(smmu->dev, "ecmdq[%d] init failed\n", i);
+			return ret;
+		}
+
+		offset += gap;
+	}
+	smmu->ecmdq_enabled = true;
+
+	return 0;
 }
 
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
@@ -3588,6 +3791,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
+	if (reg & IDR1_ECMDQ)
+		smmu->features |= ARM_SMMU_FEAT_ECMDQ;
+
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
@@ -3695,6 +3901,16 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
 		 smmu->ias, smmu->oas, smmu->features);
+
+	if (smmu->features & ARM_SMMU_FEAT_ECMDQ) {
+		int err;
+
+		err = arm_smmu_ecmdq_probe(smmu);
+		if (err) {
+			dev_err(smmu->dev, "suppress ecmdq feature, errno=%d\n", err);
+			smmu->ecmdq_enabled = false;
+		}
+	}
 	return 0;
 }
 
@@ -3850,6 +4066,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
+	smmu->iobase = ioaddr;
 
 	if (arm_smmu_resource_size(smmu) > SZ_64K) {
 		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e257..0f01798f7c4e30d 100644
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
@@ -552,6 +574,11 @@ struct arm_smmu_cmdq {
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
@@ -625,6 +652,7 @@ struct arm_smmu_device {
 	struct device			*dev;
 	void __iomem			*base;
 	void __iomem			*page1;
+	phys_addr_t			iobase;
 
 #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
 #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
@@ -646,6 +674,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_NESTING		(1 << 19)
+#define ARM_SMMU_FEAT_ECMDQ		(1 << 20)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -654,6 +683,10 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
+	struct arm_smmu_ecmdq *__percpu	*ecmdqs;
+	u32				nr_ecmdq;
+	bool				ecmdq_enabled;
+
 	struct arm_smmu_cmdq		cmdq;
 	struct arm_smmu_evtq		evtq;
 	struct arm_smmu_priq		priq;
-- 
2.34.1

