Return-Path: <linux-kernel+bounces-25950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FF82D8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09E4282A48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE22C698;
	Mon, 15 Jan 2024 12:05:22 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4D1E867
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TD9Lz0VXbzNlC3;
	Mon, 15 Jan 2024 19:45:47 +0800 (CST)
Received: from kwepemd100006.china.huawei.com (unknown [7.221.188.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 40844180071;
	Mon, 15 Jan 2024 19:46:30 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemd100006.china.huawei.com
 (7.221.188.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 15 Jan
 2024 19:46:29 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>, <mshavit@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: Add a threshold to avoid potential soft lockup
Date: Mon, 15 Jan 2024 19:40:40 +0800
Message-ID: <20240115114040.6279-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100006.china.huawei.com (7.221.188.47)

The commit d5afb4b47e13 ("iommu/arm-smmu-v3: Fix soft lockup triggered
by arm_smmu_mm_invalidate_range") has fix a soft lockup problem when
running SVA case, but code paths from iommu_unmap and dma APIs still
remain unfixed which could also cause potential soft lockup.

When cmdq is quite busy and don't have much space for batch submitting
cmds, and size passed to __arm_smmu_tlb_inv_range() is large (1G in this
case), the following softlockup is triggered.

WARN: soft lockup - CPU#71 stuck for 12s! [qemu-kvm:1303]
..
Call trace:
 dump_backtrace+0x0/0x200
 show_stack+0x20/0x30
 dump_stack+0xf0/0x138
 watchdog_print_info+0x48/0x54
 watchdog_process_before_softlockup+0x9c/0xa0
 watchdog_timer_fn+0x1ac/0x2f0
 __run_hrtimer+0x98/0x2b4
 __hrtimer_run_queues+0xc0/0x13c
 hrtimer_interrupt+0x150/0x3e4
 arch_timer_handler_phys+0x3c/0x50
 handle_percpu_devid_irq+0x90/0x1f4
 __handle_domain_irq+0x84/0xfc
 gic_handle_irq+0x88/0x2b0
 el1_irq+0xb8/0x140
 arm_smmu_cmdq_issue_cmdlist+0x184/0x5f4
 __arm_smmu_tlb_inv_range+0x114/0x22c
 arm_smmu_tlb_inv_walk+0x88/0x120
 __arm_lpae_unmap+0x188/0x2c0
 __arm_lpae_unmap+0x104/0x2c0
 arm_lpae_unmap+0x68/0x80
 arm_smmu_unmap+0x24/0x40
 __iommu_unmap+0xd8/0x210
 iommu_unmap+0x44/0x9c
..

The basic idea is use the actual granual size instead of PAGE_SIZE used
in SVA scenarios to calculate a threshold. When smmu without
ARM_SMMU_FEAT_RANGE_INV need to invalid a TLB range larger than the
threshold, we use the granularity of asid or vmid to invalid the TLB. The
calculation logic is similar to calculate 'bits_per_level' when allocating
io-pgtable, which could also been applyed to calculate the existing
threshold in SVA scenarios. Besides, change the comment "MAX_TLBI_OPS" to
"MAX_DVM_OPS", because it is has been renamed in commit ec1c3b9ff160
("arm64: tlbflush: Rename MAX_TLBI_OPS")

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 +--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 23 +++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 ++++++++
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 05722121f00e..164a218a4d41 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -203,15 +203,6 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	}
 }
 
-/*
- * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
- * is used as a threshold to replace per-page TLBI commands to issue in the
- * command queue with an address-space TLBI command, when SMMU w/o a range
- * invalidation feature handles too many per-page TLBI commands, which will
- * otherwise result in a soft lockup.
- */
-#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
-
 static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						struct mm_struct *mm,
 						unsigned long start,
@@ -228,7 +219,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 	 */
 	size = end - start;
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
-		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
+		if (size >= CMDQ_MAX_TLBI_OPS(PAGE_SIZE) * PAGE_SIZE)
 			size = 0;
 	} else {
 		if (size == ULONG_MAX)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0ffb1cf17e0b..cecccba17511 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1997,6 +1997,14 @@ static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+	    size >= CMDQ_MAX_TLBI_OPS(granule) * granule) {
+		arm_smmu_tlb_inv_context(cookie);
+		return;
+	}
 	arm_smmu_tlb_inv_range_domain(iova, size, granule, false, cookie);
 }
 
@@ -2502,13 +2510,20 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 				struct iommu_iotlb_gather *gather)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	size_t size = gather->end - gather->start + 1;
+	size_t granule = gather->pgsize;
 
-	if (!gather->pgsize)
+	if (!granule)
 		return;
 
-	arm_smmu_tlb_inv_range_domain(gather->start,
-				      gather->end - gather->start + 1,
-				      gather->pgsize, true, smmu_domain);
+	if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV) &&
+	    size >= CMDQ_MAX_TLBI_OPS(granule) * granule) {
+		arm_smmu_tlb_inv_context(smmu_domain);
+		return;
+	}
+	arm_smmu_tlb_inv_range_domain(gather->start, size,
+				      granule, true, smmu_domain);
 }
 
 static phys_addr_t
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 65fb388d5173..a9a7376c0437 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -431,6 +431,16 @@ struct arm_smmu_ste {
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+/*
+ * Similar to MAX_DVM_OPS in arch/arm64/include/asm/tlbflush.h, this is used
+ * as a threshold to replace per-page TLBI commands to issue in the command
+ * queue with an address-space TLBI command, when SMMU w/o a range invalidation
+ * feature handles too many per-page TLBI commands, which will otherwise result
+ * in a soft lockup.
+ */
+
+#define CMDQ_MAX_TLBI_OPS(granule)    (1 << (ilog2(granule) - 3))
+
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
-- 
2.17.1


