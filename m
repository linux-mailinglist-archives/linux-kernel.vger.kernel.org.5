Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42844791229
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbjIDH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbjIDH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92855139
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:28:58 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-Xm6JU2DSMD-NIYWwlG_p3A-1; Mon, 04 Sep 2023 03:28:52 -0400
X-MC-Unique: Xm6JU2DSMD-NIYWwlG_p3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 547561817903;
        Mon,  4 Sep 2023 07:28:51 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B071121318;
        Mon,  4 Sep 2023 07:28:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, qperret@google.com,
        gshan@redhat.com, ricarkol@google.com, tabba@google.com,
        bgardon@google.com, zhenyzha@redhat.com, yihyu@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH] KVM: arm64: Fix soft-lockup on relaxing PTE permission
Date:   Mon,  4 Sep 2023 17:28:26 +1000
Message-ID: <20230904072826.1468907-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed soft-lockup on the host in a specific scenario where
the host on Ampere's Altra Max CPU has 64KB base page size and the
guest has 4KB base page size, 64 vCPUs and 13GB memory. The guest's
memory is backed by 512MB huge pages via hugetlbfs. All the 64 vCPUs
are simultaneously trapped into the host due to permission page faults,
to request adding the execution permission to the corresponding PMD
entry, before the soft-lockup is raised on the host. On handling the
parallel requests, the instruction cache for the 512MB huge page is
invalidated by mm_ops->icache_inval_pou() in stage2_attr_walker() on
64 hardware CPUs. Unfortunately, the instruction cache invalidation
on one CPU interfere with that on another CPU in the hardware level.
It takes 37 seconds for mm_ops->icache_inval_pou() to finish in the
worst case.

So we can't scale out to handle the permission faults at will. They
need to be serialized to some extent with the help of a interval tree,
to track IPA ranges, currently under service. For the incoming permission
faults, the vCPU is asked to bail for a retry if its IPA range is being
served since the vCPU can't proceed its execution.

Fixes: 1577cb5823ce ("KVM: arm64: Handle stage-2 faults in parallel")
Cc: stable@vger.kernel.org # v6.2+
Reported-by: Yihuang Yu <yihyu@redhat.com>
Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h     |  4 ++
 arch/arm64/include/asm/kvm_pgtable.h  |  3 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  4 +-
 arch/arm64/kvm/hyp/pgtable.c          | 25 +++++++++---
 arch/arm64/kvm/mmu.c                  | 55 ++++++++++++++++++++++++++-
 5 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d3dd05bbfe23..a457720b5caf 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -175,6 +175,10 @@ struct kvm_s2_mmu {
 	struct kvm_mmu_memory_cache split_page_cache;
 	uint64_t split_page_chunk_size;
 
+	/* Page fault ranges */
+	struct mutex		fault_ranges_mutex;
+	struct rb_root_cached	fault_ranges;
+
 	struct kvm_arch *arch;
 };
 
diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 929d355eae0a..dca0bf81616f 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -149,7 +149,8 @@ struct kvm_pgtable_mm_ops {
 	void*		(*phys_to_virt)(phys_addr_t phys);
 	phys_addr_t	(*virt_to_phys)(void *addr);
 	void		(*dcache_clean_inval_poc)(void *addr, size_t size);
-	void		(*icache_inval_pou)(void *addr, size_t size);
+	int		(*icache_inval_pou)(struct kvm_s2_mmu *mmu,
+					    void *addr, u64 ipa, size_t size);
 };
 
 /**
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 9d703441278b..9bbe7c641770 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -223,10 +223,12 @@ static void clean_dcache_guest_page(void *va, size_t size)
 	hyp_fixmap_unmap();
 }
 
-static void invalidate_icache_guest_page(void *va, size_t size)
+static int invalidate_icache_guest_page(struct kvm_s2_mmu *mmu,
+					void *va, u64 ipa, size_t size)
 {
 	__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
 	hyp_fixmap_unmap();
+	return 0;
 }
 
 int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f7a93ef29250..fabfdb4d1e00 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -875,6 +875,7 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	u64 granule = kvm_granule_size(ctx->level);
 	struct kvm_pgtable *pgt = data->mmu->pgt;
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
+	int ret;
 
 	if (!stage2_leaf_mapping_allowed(ctx, data))
 		return -E2BIG;
@@ -903,8 +904,14 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 					       granule);
 
 	if (!kvm_pgtable_walk_skip_cmo(ctx) && mm_ops->icache_inval_pou &&
-	    stage2_pte_executable(new))
-		mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops), granule);
+	    stage2_pte_executable(new)) {
+		ret = mm_ops->icache_inval_pou(data->mmu,
+					       kvm_pte_follow(new, mm_ops),
+					       ALIGN_DOWN(ctx->addr, granule),
+					       granule);
+		if (ret)
+			return ret;
+	}
 
 	stage2_make_pte(ctx, new);
 
@@ -1101,6 +1108,7 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 }
 
 struct stage2_attr_data {
+	struct kvm_s2_mmu		*mmu;
 	kvm_pte_t			attr_set;
 	kvm_pte_t			attr_clr;
 	kvm_pte_t			pte;
@@ -1113,6 +1121,8 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	kvm_pte_t pte = ctx->old;
 	struct stage2_attr_data *data = ctx->arg;
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
+	u64 granule = kvm_granule_size(ctx->level);
+	int ret;
 
 	if (!kvm_pte_valid(ctx->old))
 		return -EAGAIN;
@@ -1133,9 +1143,13 @@ static int stage2_attr_walker(const struct kvm_pgtable_visit_ctx *ctx,
 		 * stage-2 PTE if we are going to add executable permission.
 		 */
 		if (mm_ops->icache_inval_pou &&
-		    stage2_pte_executable(pte) && !stage2_pte_executable(ctx->old))
-			mm_ops->icache_inval_pou(kvm_pte_follow(pte, mm_ops),
-						  kvm_granule_size(ctx->level));
+		    stage2_pte_executable(pte) && !stage2_pte_executable(ctx->old)) {
+			ret = mm_ops->icache_inval_pou(data->mmu,
+					kvm_pte_follow(pte, mm_ops),
+					ALIGN_DOWN(ctx->addr, granule), granule);
+			if (ret)
+				return ret;
+		}
 
 		if (!stage2_try_set_pte(ctx, pte))
 			return -EAGAIN;
@@ -1152,6 +1166,7 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 	int ret;
 	kvm_pte_t attr_mask = KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI;
 	struct stage2_attr_data data = {
+		.mmu		= pgt->mmu,
 		.attr_set	= attr_set & attr_mask,
 		.attr_clr	= attr_clr & attr_mask,
 	};
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d3b4feed460c..a778f48beb56 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -267,9 +267,58 @@ static void clean_dcache_guest_page(void *va, size_t size)
 	__clean_dcache_guest_page(va, size);
 }
 
-static void invalidate_icache_guest_page(void *va, size_t size)
+static struct interval_tree_node *add_fault_range(struct kvm_s2_mmu *mmu,
+						  u64 ipa, size_t size)
 {
+	struct interval_tree_node *node;
+	unsigned long start = ipa, end = start + size - 1; /* inclusive */
+
+	mutex_lock(&mmu->fault_ranges_mutex);
+
+	node = interval_tree_iter_first(&mmu->fault_ranges, start, end);
+	if (node) {
+		node = NULL;
+		goto unlock;
+	}
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL_ACCOUNT);
+	if (!node)
+		goto unlock;
+
+	node->start = start;
+	node->last = end;
+	interval_tree_insert(node, &mmu->fault_ranges);
+
+unlock:
+	mutex_unlock(&mmu->fault_ranges_mutex);
+	return node;
+}
+
+static void remove_fault_range(struct kvm_s2_mmu *mmu,
+			       struct interval_tree_node *node)
+{
+	mutex_lock(&mmu->fault_ranges_mutex);
+
+	interval_tree_remove(node, &mmu->fault_ranges);
+	kfree(node);
+
+	mutex_unlock(&mmu->fault_ranges_mutex);
+}
+
+
+static int invalidate_icache_guest_page(struct kvm_s2_mmu *mmu,
+					void *va, u64 ipa, size_t size)
+{
+	struct interval_tree_node *node;
+
+	node = add_fault_range(mmu, ipa, size);
+	if (!node)
+		return -EAGAIN;
+
 	__invalidate_icache_guest_page(va, size);
+	remove_fault_range(mmu, node);
+
+	return 0;
 }
 
 /*
@@ -859,6 +908,10 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
 	mmu->split_page_chunk_size = KVM_ARM_EAGER_SPLIT_CHUNK_SIZE_DEFAULT;
 	mmu->split_page_cache.gfp_zero = __GFP_ZERO;
 
+	/* Initialize the page fault ranges */
+	mutex_init(&mmu->fault_ranges_mutex);
+	mmu->fault_ranges = RB_ROOT_CACHED;
+
 	mmu->pgt = pgt;
 	mmu->pgd_phys = __pa(pgt->pgd);
 	return 0;
-- 
2.41.0

