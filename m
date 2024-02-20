Return-Path: <linux-kernel+bounces-73288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5B285C081
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216AD284FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B32763F5;
	Tue, 20 Feb 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCRkMcV9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD4763E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444897; cv=none; b=pBqTjX59g8eJ3AZiC81F9nC+UJG9ju9CEP4C/wr3TKOjfpDsuruuK9VGUl5GcfB3ozcIgz23utXqA6lziDVmkMxkQUJne1hLdxcM+ppM1E+e9OTlGmA0eK9K247iAfiBgsVgBmFJgi05doEUUj84ufgnUbemXGWiLT22rFwUOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444897; c=relaxed/simple;
	bh=5HAmL0Nulrsb9wBTZFbYw4JzagI9shqZIbv7xHhDomk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYpJrdECexf4NmnXjThxzX05EG72HayUkiam1zPpQW/oe2acTun1IXYk9cJw7/c9VTt3Oyk+QarYCO/ydcWrmZWby3J42BVZhiIe+oAdfI28O+y3bUZmr3kBIFFzOZ3TwGMlwFsadrjjApwjxEKhKVcWci0i/SMcXELo2Qw2yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCRkMcV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADA5C43390;
	Tue, 20 Feb 2024 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444896;
	bh=5HAmL0Nulrsb9wBTZFbYw4JzagI9shqZIbv7xHhDomk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCRkMcV94TF6ZiOGgI/KcdPAyvDQ5aUFUVYNEZnixqpM+SRTmYgRszRTldpgsZir5
	 v13m5hQ0ti5S8HKY9xh1APzEKVnGJmOBFGvjl0oB2apH7EuHs0JSmSuqaVDHui+Kee
	 G3CXk0IDaoc633XivhzYcm1XmJ1NO+yMr8sFKG4vYAOmmIvJ/88uPmrhqtcVnvQ0fU
	 L5J89Kfnuh+tqc6sIiH7C/+sUIcHGs++u8J/hIA/u2B1RnXdWC7GGBjq8j2rK+Ymq3
	 usR4IqDhn0LN32jyZFYuHSOT1GB3RRXhDIIr+7HdP8SY/BBfMNRsYlFlznUkO9pkMx
	 JKMVxUa/tmLaQ==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 02/13] accel/habanalabs: remove hop size from asic properties
Date: Tue, 20 Feb 2024 18:01:18 +0200
Message-Id: <20240220160129.909714-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farah Kassabri <fkassabri@habana.ai>

The hop size related properties is a MMU properties and not
asic properties.
As for PMMU and HMMU we could have different sizes.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h  |  4 ----
 drivers/accel/habanalabs/common/mmu/mmu.c     | 22 ++++++++---------
 .../accel/habanalabs/common/mmu/mmu_v2_hr.c   | 24 +++++++++----------
 drivers/accel/habanalabs/gaudi/gaudi.c        |  8 +++----
 drivers/accel/habanalabs/gaudi2/gaudi2.c      | 12 ++++------
 drivers/accel/habanalabs/goya/goya.c          | 12 ++++------
 6 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 634a470efe27..c85849aefba6 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -594,8 +594,6 @@ struct hl_hints_range {
  *                 we display to the user
  * @mmu_pgt_size: MMU page tables total size.
  * @mmu_pte_size: PTE size in MMU page tables.
- * @mmu_hop_table_size: MMU hop table size.
- * @mmu_hop0_tables_total_size: total size of MMU hop0 tables.
  * @dram_page_size: The DRAM physical page size.
  * @cfg_size: configuration space size on SRAM.
  * @sram_size: total size of SRAM.
@@ -747,8 +745,6 @@ struct asic_fixed_properties {
 	u32				clk_pll_index;
 	u32				mmu_pgt_size;
 	u32				mmu_pte_size;
-	u32				mmu_hop_table_size;
-	u32				mmu_hop0_tables_total_size;
 	u32				dram_page_size;
 	u32				cfg_size;
 	u32				sram_size;
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index fa7919dba783..d3eaab908457 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -1236,7 +1236,7 @@ void hl_mmu_dr_free_pgt_node(struct hl_ctx *ctx, struct pgt_info *pgt_info)
 	struct hl_device *hdev = ctx->hdev;
 
 	gen_pool_free(hdev->mmu_priv.dr.mmu_pgt_pool, pgt_info->phys_addr,
-			hdev->asic_prop.mmu_hop_table_size);
+			hdev->asic_prop.dmmu.hop_table_size);
 	hash_del(&pgt_info->node);
 	kfree((u64 *) (uintptr_t) pgt_info->shadow_addr);
 	kfree(pgt_info);
@@ -1245,18 +1245,18 @@ void hl_mmu_dr_free_pgt_node(struct hl_ctx *ctx, struct pgt_info *pgt_info)
 u64 hl_mmu_dr_get_phys_hop0_addr(struct hl_ctx *ctx)
 {
 	return ctx->hdev->asic_prop.mmu_pgt_addr +
-			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
+			(ctx->asid * ctx->hdev->asic_prop.dmmu.hop_table_size);
 }
 
 u64 hl_mmu_dr_get_hop0_addr(struct hl_ctx *ctx)
 {
 	return (u64) (uintptr_t) ctx->hdev->mmu_priv.dr.mmu_shadow_hop0 +
-			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
+			(ctx->asid * ctx->hdev->asic_prop.dmmu.hop_table_size);
 }
 
 u64 hl_mmu_dr_get_phys_addr(struct hl_ctx *ctx, u64 shadow_addr)
 {
-	u64 page_mask = ctx->hdev->asic_prop.mmu_hop_table_size - 1;
+	u64 page_mask = ctx->hdev->asic_prop.dmmu.hop_table_size - 1;
 	u64 shadow_hop_addr = shadow_addr & (~page_mask);
 	u64 pte_offset = shadow_addr & page_mask;
 	u64 phys_hop_addr;
@@ -1326,13 +1326,13 @@ u64 hl_mmu_dr_alloc_hop(struct hl_ctx *ctx)
 		return ULLONG_MAX;
 
 	phys_addr = (u64) gen_pool_alloc(hdev->mmu_priv.dr.mmu_pgt_pool,
-					prop->mmu_hop_table_size);
+					prop->dmmu.hop_table_size);
 	if (!phys_addr) {
 		dev_err(hdev->dev, "failed to allocate page\n");
 		goto pool_add_err;
 	}
 
-	shadow_addr = (u64) (uintptr_t) kzalloc(prop->mmu_hop_table_size,
+	shadow_addr = (u64) (uintptr_t) kzalloc(prop->dmmu.hop_table_size,
 						GFP_KERNEL);
 	if (!shadow_addr)
 		goto shadow_err;
@@ -1347,7 +1347,7 @@ u64 hl_mmu_dr_alloc_hop(struct hl_ctx *ctx)
 
 shadow_err:
 	gen_pool_free(hdev->mmu_priv.dr.mmu_pgt_pool,
-			phys_addr, prop->mmu_hop_table_size);
+			phys_addr, prop->dmmu.hop_table_size);
 pool_add_err:
 	kfree(pgt_info);
 
@@ -1379,7 +1379,7 @@ int hl_mmu_dr_init(struct hl_device *hdev)
 	int rc;
 
 	hdev->mmu_priv.dr.mmu_pgt_pool =
-			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
+			gen_pool_create(__ffs(prop->dmmu.hop_table_size), -1);
 
 	if (!hdev->mmu_priv.dr.mmu_pgt_pool) {
 		dev_err(hdev->dev, "Failed to create page gen pool\n");
@@ -1387,8 +1387,8 @@ int hl_mmu_dr_init(struct hl_device *hdev)
 	}
 
 	rc = gen_pool_add(hdev->mmu_priv.dr.mmu_pgt_pool, prop->mmu_pgt_addr +
-			prop->mmu_hop0_tables_total_size,
-			prop->dmmu.pgt_size - prop->mmu_hop0_tables_total_size,
+			prop->dmmu.hop0_tables_total_size,
+			prop->dmmu.pgt_size - prop->dmmu.hop0_tables_total_size,
 			-1);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to add memory to page gen pool\n");
@@ -1396,7 +1396,7 @@ int hl_mmu_dr_init(struct hl_device *hdev)
 	}
 
 	hdev->mmu_priv.dr.mmu_shadow_hop0 = kvcalloc(prop->max_asid,
-						prop->mmu_hop_table_size, GFP_KERNEL);
+						prop->dmmu.hop_table_size, GFP_KERNEL);
 	if (ZERO_OR_NULL_PTR(hdev->mmu_priv.dr.mmu_shadow_hop0)) {
 		rc = -ENOMEM;
 		goto err_pool_add;
diff --git a/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c b/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c
index afe7ef964f82..31507b2a431b 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c
@@ -47,7 +47,7 @@ static inline int hl_mmu_v2_hr_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
-	return hl_mmu_hr_init(hdev, &hdev->mmu_priv.hr, prop->mmu_hop_table_size,
+	return hl_mmu_hr_init(hdev, &hdev->mmu_priv.hr, prop->pmmu.hop_table_size,
 				prop->mmu_pgt_size);
 }
 
@@ -65,7 +65,7 @@ static inline void hl_mmu_v2_hr_fini(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
-	hl_mmu_hr_fini(hdev, &hdev->mmu_priv.hr, prop->mmu_hop_table_size);
+	hl_mmu_hr_fini(hdev, &hdev->mmu_priv.hr, prop->pmmu.hop_table_size);
 }
 
 /**
@@ -108,7 +108,7 @@ static void hl_mmu_v2_hr_ctx_fini(struct hl_ctx *ctx)
 			"pgt_info of addr 0x%llx of asid %d was not destroyed, num_ptes: %d\n",
 			pgt_info->phys_addr, ctx->asid, pgt_info->num_of_ptes);
 		hl_mmu_hr_free_hop_remove_pgt(pgt_info, &ctx->hdev->mmu_priv.hr,
-							ctx->hdev->asic_prop.mmu_hop_table_size);
+							ctx->hdev->asic_prop.pmmu.hop_table_size);
 	}
 }
 
@@ -150,7 +150,7 @@ static int _hl_mmu_v2_hr_unmap(struct hl_ctx *ctx,
 
 		curr_pte = *(u64 *) (uintptr_t) hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
 							hop_pte_phys_addr[i],
-							ctx->hdev->asic_prop.mmu_hop_table_size);
+							ctx->hdev->asic_prop.pmmu.hop_table_size);
 
 		if ((i < hop_last) && (curr_pte & mmu_prop->last_mask)) {
 			hop_last = i;
@@ -169,14 +169,14 @@ static int _hl_mmu_v2_hr_unmap(struct hl_ctx *ctx,
 
 	for (i = hop_last ; i > 0 ; i--) {
 		hl_mmu_hr_clear_pte(ctx, hops_pgt_info[i], hop_pte_phys_addr[i],
-						ctx->hdev->asic_prop.mmu_hop_table_size);
+						ctx->hdev->asic_prop.pmmu.hop_table_size);
 
 		if (hl_mmu_hr_put_pte(ctx, hops_pgt_info[i], &ctx->hdev->mmu_priv.hr,
-						ctx->hdev->asic_prop.mmu_hop_table_size))
+						ctx->hdev->asic_prop.pmmu.hop_table_size))
 			goto mapped;
 	}
 	hl_mmu_hr_clear_pte(ctx, hops_pgt_info[0], hop_pte_phys_addr[0],
-						ctx->hdev->asic_prop.mmu_hop_table_size);
+						ctx->hdev->asic_prop.pmmu.hop_table_size);
 
 mapped:
 	return 0;
@@ -255,7 +255,7 @@ static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
 									scrambled_virt_addr);
 		curr_pte = *(u64 *) (uintptr_t) hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
 							hop_pte_phys_addr[i],
-							ctx->hdev->asic_prop.mmu_hop_table_size);
+							ctx->hdev->asic_prop.pmmu.hop_table_size);
 	}
 
 	if (curr_pte & PAGE_PRESENT_MASK) {
@@ -268,7 +268,7 @@ static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
 					*(u64 *) (uintptr_t)
 					hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
 							hop_pte_phys_addr[i],
-							ctx->hdev->asic_prop.mmu_hop_table_size),
+							ctx->hdev->asic_prop.pmmu.hop_table_size),
 					hop_pte_phys_addr[i]);
 		rc = -EINVAL;
 		goto err;
@@ -279,7 +279,7 @@ static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
 
 	/* Write the PTEs */
 	hl_mmu_hr_write_pte(ctx, hops_pgt_info[hop_last], hop_pte_phys_addr[hop_last], curr_pte,
-							ctx->hdev->asic_prop.mmu_hop_table_size);
+							ctx->hdev->asic_prop.pmmu.hop_table_size);
 
 	/* for each new hop, add its address to the table of previous-hop */
 	for (i = 1 ; i <= hop_last ; i++) {
@@ -287,7 +287,7 @@ static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
 			curr_pte = (hops_pgt_info[i]->phys_addr & HOP_PHYS_ADDR_MASK) |
 							PAGE_PRESENT_MASK;
 			hl_mmu_hr_write_pte(ctx, hops_pgt_info[i - 1], hop_pte_phys_addr[i - 1],
-						curr_pte, ctx->hdev->asic_prop.mmu_hop_table_size);
+						curr_pte, ctx->hdev->asic_prop.pmmu.hop_table_size);
 			if (i - 1)
 				hl_mmu_hr_get_pte(ctx, &ctx->hdev->mmu_func[MMU_HR_PGT].hr_funcs,
 								hops_pgt_info[i - 1]->phys_addr);
@@ -303,7 +303,7 @@ static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
 	for (i = 1 ; i <= hop_last ; i++)
 		if (hop_new[i] && hops_pgt_info[i])
 			hl_mmu_hr_free_hop_remove_pgt(hops_pgt_info[i], &ctx->hdev->mmu_priv.hr,
-							ctx->hdev->asic_prop.mmu_hop_table_size);
+							ctx->hdev->asic_prop.pmmu.hop_table_size);
 
 	return rc;
 }
diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index dde3839fe0e0..f2b04ffb0ecb 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -614,8 +614,6 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	else
 		prop->mmu_pgt_size = MMU_PAGE_TABLES_SIZE;
 	prop->mmu_pte_size = HL_PTE_SIZE;
-	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
-	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
 	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
 	prop->dram_supports_virtual_memory = false;
@@ -637,8 +635,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
 	prop->pmmu.last_mask = LAST_MASK;
 	/* TODO: will be duplicated until implementing per-MMU props */
-	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
-	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+	prop->pmmu.hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->pmmu.hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
@@ -3653,7 +3651,7 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 
 	for (i = 0 ; i < prop->max_asid ; i++) {
 		hop0_addr = prop->mmu_pgt_addr +
-				(i * prop->mmu_hop_table_size);
+				(i * prop->dmmu.hop_table_size);
 
 		rc = gaudi_mmu_update_asid_hop0_addr(hdev, i, hop0_addr);
 		if (rc) {
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 4a0917aa4dd7..26975179763a 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2467,8 +2467,6 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 
 	prop->dmmu.pgt_size = HMMU_PAGE_TABLES_SIZE;
 	prop->mmu_pte_size = HL_PTE_SIZE;
-	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
-	prop->mmu_hop0_tables_total_size = HOP_TABLE_SIZE_512_PTE * prop->max_asid;
 
 	prop->dmmu.hop_shifts[MMU_HOP0] = DHOP0_SHIFT;
 	prop->dmmu.hop_shifts[MMU_HOP1] = DHOP1_SHIFT;
@@ -2482,8 +2480,8 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 	prop->dmmu.num_hops = MMU_ARCH_4_HOPS;
 	prop->dmmu.last_mask = LAST_MASK;
 	prop->dmmu.host_resident = 0;
-	prop->dmmu.hop_table_size = prop->mmu_hop_table_size;
-	prop->dmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+	prop->dmmu.hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->dmmu.hop0_tables_total_size = HOP_TABLE_SIZE_512_PTE * prop->max_asid;
 
 	/* As we need to set the pgt address in dram for HMMU init so we cannot
 	 * wait to the fw cpucp info to set the dram props as mmu init comes before
@@ -2500,8 +2498,8 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.host_resident = 1;
 	prop->pmmu.num_hops = MMU_ARCH_6_HOPS;
 	prop->pmmu.last_mask = LAST_MASK;
-	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
-	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+	prop->pmmu.hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->pmmu.hop0_tables_total_size = HOP_TABLE_SIZE_512_PTE * prop->max_asid;
 
 	prop->hints_host_reserved_va_range.start_addr = RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START;
 	prop->hints_host_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HOST_END;
@@ -5934,7 +5932,7 @@ static int gaudi2_mmu_update_hop0_addr(struct hl_device *hdev, u32 stlb_base,
 		if (host_resident_pgt)
 			hop0_addr = hdev->mmu_priv.hr.mmu_asid_hop0[asid].phys_addr;
 		else
-			hop0_addr = prop->mmu_pgt_addr + (asid * prop->mmu_hop_table_size);
+			hop0_addr = prop->mmu_pgt_addr + (asid * prop->dmmu.hop_table_size);
 
 		rc = gaudi2_mmu_update_asid_hop0_addr(hdev, stlb_base, asid, hop0_addr);
 		if (rc) {
diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanalabs/goya/goya.c
index 1322cb330c57..5a359c3bdc78 100644
--- a/drivers/accel/habanalabs/goya/goya.c
+++ b/drivers/accel/habanalabs/goya/goya.c
@@ -413,8 +413,6 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	else
 		prop->mmu_pgt_size = MMU_PAGE_TABLES_SIZE;
 	prop->mmu_pte_size = HL_PTE_SIZE;
-	prop->mmu_hop_table_size = HOP_TABLE_SIZE_512_PTE;
-	prop->mmu_hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 	prop->dram_page_size = PAGE_SIZE_2MB;
 	prop->device_mem_alloc_default_page_size = prop->dram_page_size;
 	prop->dram_supports_virtual_memory = true;
@@ -435,8 +433,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->dmmu.num_hops = MMU_ARCH_5_HOPS;
 	prop->dmmu.last_mask = LAST_MASK;
 	/* TODO: will be duplicated until implementing per-MMU props */
-	prop->dmmu.hop_table_size = prop->mmu_hop_table_size;
-	prop->dmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+	prop->dmmu.hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->dmmu.hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 
 	/* shifts and masks are the same in PMMU and DMMU */
 	memcpy(&prop->pmmu, &prop->dmmu, sizeof(prop->dmmu));
@@ -446,8 +444,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
 	prop->pmmu.last_mask = LAST_MASK;
 	/* TODO: will be duplicated until implementing per-MMU props */
-	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
-	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
+	prop->pmmu.hop_table_size = HOP_TABLE_SIZE_512_PTE;
+	prop->pmmu.hop0_tables_total_size = HOP0_512_PTE_TABLES_TOTAL_SIZE;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
@@ -2678,7 +2676,7 @@ int goya_mmu_init(struct hl_device *hdev)
 
 	for (i = 0 ; i < prop->max_asid ; i++) {
 		hop0_addr = prop->mmu_pgt_addr +
-				(i * prop->mmu_hop_table_size);
+				(i * prop->dmmu.hop_table_size);
 
 		rc = goya_mmu_update_asid_hop0_addr(hdev, i, hop0_addr);
 		if (rc) {
-- 
2.34.1


