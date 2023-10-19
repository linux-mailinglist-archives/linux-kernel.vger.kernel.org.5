Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA27CFD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbjJSOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346167AbjJSOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:40:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E489185
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7e4745acdso125801737b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726447; x=1698331247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVLIzP3Q0iWxIWjFJBGtp/ww3MnoFI3IyjnW9dmr0o8=;
        b=wYi8TgPzGS+ykQ2VjcxHmbhsYANuNo51EhY0oZcuNNaWaemrbpOtW/GRjiGnKx1FlP
         J6sl9WKJd/vRUSQVje6RibgekjwV+VLGZEK91+5j7hwxtofwOYXLAhhOtGZ6bsmayAug
         nIVjHGhD9esmMY+KIauUctBNs9sAgsuOhaVz6NFt3MH4WqsGDk2qrbl1wkyw4nmBdnDN
         8RQyd4nFv0jBp2pd7ckclDaEz3QNMJz/H6fRljs1276JcfyxiHkN/EkY7hVWKm+4PIzP
         cKS39WwFY4uG8q7tZb43IOZ9XAkSuWHGuz27VmNzk6PmxZq2y5QLWNb3UPPJlavbbJYq
         tnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726447; x=1698331247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVLIzP3Q0iWxIWjFJBGtp/ww3MnoFI3IyjnW9dmr0o8=;
        b=sUsP00VkVzzzuKmy14IYX86LOCtKkOjOdhuwO1UF7wn861vMl3VOeILzwi3QcjOaIh
         YYm01xJXS74vetQQUZQqXdrlz5I5EUpradZgJNwoMnipS+9oPpAa5u9FjKOpKitqfBtQ
         hh0/FjA/0M6A4nDr10+AB0DQbK9wHjS9KCIndQHCw2CV+h6n0+QfSLetg863Ql6OZodS
         J4AfSEMx6MG6TgETKym/Q0JIiQcnHqeM/ntme+TZ2C7wOFd44YsUkTsMBwAQguGXX4sU
         ZzXSEZLaKF0REh9pMyvKschFUbADzP3f+JkXaRjYYDa80dJKmfbLIVafV3fF/5ymeuDQ
         WcZg==
X-Gm-Message-State: AOJu0YxFv2AqvJnsFiEhbFdbIkLqeYBfT2sLB98IGYQ3aTGjfl0JdpOq
        789I/YQ2dmHDmLkvEWt8Ifk3FXyCU0n+qcbz/YM=
X-Google-Smtp-Source: AGHT+IGCYPRE1jNH+2vvf7v2riRv59w2v81fJIKA0BGhxk5Qar8fMygMdb1/wGRDf1EAVTz4fZCbesH/7ziGSjNjoQg=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a81:4944:0:b0:58c:b45f:3e94 with SMTP
 id w65-20020a814944000000b0058cb45f3e94mr51348ywa.8.1697726447137; Thu, 19
 Oct 2023 07:40:47 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:23 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-3-sebastianene@google.com>
Subject: [PATCH v2 01/11] KVM: arm64: Add snap shooting the host stage-2 pagetables
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new HVC that allows the caller to snap shoot the stage-2
pagetables under NVHE debug configuration. The caller specifies the
location where the pagetables are copied and must ensure that the memory
is accessible by the hypervisor. The memory where the pagetables are
copied has to be allocated by the caller and shared with the hypervisor.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_pgtable.h          |  36 ++++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  18 +++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 103 ++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c                  |  56 ++++++++++
 6 files changed, 215 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 24b5e6b23417..99145a24c0f6 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -81,6 +81,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_init_vm,
 	__KVM_HOST_SMCCC_FUNC___pkvm_init_vcpu,
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
+	__KVM_HOST_SMCCC_FUNC___pkvm_copy_host_stage2,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index d3e354bb8351..be615700f8ac 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -10,6 +10,7 @@
 #include <linux/bits.h>
 #include <linux/kvm_host.h>
 #include <linux/types.h>
+#include <asm/kvm_host.h>
 
 #define KVM_PGTABLE_MAX_LEVELS		4U
 
@@ -351,6 +352,21 @@ struct kvm_pgtable {
 	kvm_pgtable_force_pte_cb_t		force_pte_cb;
 };
 
+/**
+ * struct kvm_pgtable_snapshot - Snapshot page-table wrapper.
+ * @pgtable:		The page-table configuration.
+ * @mc:			Memcache used for pagetable pages allocation.
+ * @pgd_hva:		Host virtual address of a physically contiguous buffer
+ *			used for storing the PGD.
+ * @pgd_len:		The size of the phyisically contiguous buffer in bytes.
+ */
+struct kvm_pgtable_snapshot {
+	struct kvm_pgtable			pgtable;
+	struct kvm_hyp_memcache			mc;
+	void					*pgd_hva;
+	size_t					pgd_len;
+};
+
 /**
  * kvm_pgtable_hyp_init() - Initialise a hypervisor stage-1 page-table.
  * @pgt:	Uninitialised page-table structure to initialise.
@@ -756,4 +772,24 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
  */
 void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
 				phys_addr_t addr, size_t size);
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+/**
+ * kvm_pgtable_stage2_copy() - Snapshot the pagetable
+ *
+ * @to_pgt:	Destination pagetable
+ * @from_pgt:	Source pagetable. The caller must lock the pagetables first
+ * @mc:		The memcache where we allocate the destination pagetables from
+ */
+int kvm_pgtable_stage2_copy(struct kvm_pgtable *to_pgt,
+			    const struct kvm_pgtable *from_pgt,
+			    void *mc);
+#else
+static inline int kvm_pgtable_stage2_copy(struct kvm_pgtable *to_pgt,
+					  const struct kvm_pgtable *from_pgt,
+					  void *mc)
+{
+	return -EPERM;
+}
+#endif	/* CONFIG_NVHE_EL2_DEBUG */
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 0972faccc2af..9cfb35d68850 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -69,6 +69,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
+int __pkvm_host_stage2_prepare_copy(struct kvm_pgtable_snapshot *snapshot);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2385fd03ed87..0d9b56c31cf2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -314,6 +314,23 @@ static void handle___pkvm_teardown_vm(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_teardown_vm(handle);
 }
 
+static void handle___pkvm_copy_host_stage2(struct kvm_cpu_context *host_ctxt)
+{
+	int ret = -EPERM;
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	DECLARE_REG(struct kvm_pgtable_snapshot *, snapshot, host_ctxt, 1);
+	kvm_pteref_t pgd;
+
+	snapshot = kern_hyp_va(snapshot);
+	ret = __pkvm_host_stage2_prepare_copy(snapshot);
+	if (!ret) {
+		pgd = snapshot->pgtable.pgd;
+		snapshot->pgtable.pgd = (kvm_pteref_t)__hyp_pa(pgd);
+	}
+#endif
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -348,6 +365,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_init_vm),
 	HANDLE_FUNC(__pkvm_init_vcpu),
 	HANDLE_FUNC(__pkvm_teardown_vm),
+	HANDLE_FUNC(__pkvm_copy_host_stage2),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 9d703441278b..fe1a6dbd6d31 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -266,6 +266,109 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
 	return 0;
 }
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+static struct hyp_pool snapshot_pool = {0};
+static DEFINE_HYP_SPINLOCK(snapshot_pool_lock);
+
+static void *snapshot_zalloc_pages_exact(size_t size)
+{
+	void *addr = hyp_alloc_pages(&snapshot_pool, get_order(size));
+
+	hyp_split_page(hyp_virt_to_page(addr));
+
+	/*
+	 * The size of concatenated PGDs is always a power of two of PAGE_SIZE,
+	 * so there should be no need to free any of the tail pages to make the
+	 * allocation exact.
+	 */
+	WARN_ON(size != (PAGE_SIZE << get_order(size)));
+
+	return addr;
+}
+
+static void snapshot_get_page(void *addr)
+{
+	hyp_get_page(&snapshot_pool, addr);
+}
+
+static void *snapshot_zalloc_page(void *mc)
+{
+	struct hyp_page *p;
+	void *addr;
+
+	addr = hyp_alloc_pages(&snapshot_pool, 0);
+	if (addr)
+		return addr;
+
+	addr = pop_hyp_memcache(mc, hyp_phys_to_virt);
+	if (!addr)
+		return addr;
+
+	memset(addr, 0, PAGE_SIZE);
+	p = hyp_virt_to_page(addr);
+	memset(p, 0, sizeof(*p));
+	p->refcount = 1;
+
+	return addr;
+}
+
+static void snapshot_s2_free_pages_exact(void *addr, unsigned long size)
+{
+	u8 order = get_order(size);
+	unsigned int i;
+	struct hyp_page *p;
+
+	for (i = 0; i < (1 << order); i++) {
+		p = hyp_virt_to_page(addr + (i * PAGE_SIZE));
+		hyp_page_ref_dec_and_test(p);
+	}
+}
+
+int __pkvm_host_stage2_prepare_copy(struct kvm_pgtable_snapshot *snapshot)
+{
+	size_t required_pgd_len;
+	struct kvm_pgtable_mm_ops mm_ops = {0};
+	struct kvm_pgtable *to_pgt, *from_pgt = &host_mmu.pgt;
+	struct kvm_hyp_memcache *memcache = &snapshot->mc;
+	int ret;
+	void *pgd;
+	u64 nr_pages;
+
+	required_pgd_len = kvm_pgtable_stage2_pgd_size(host_mmu.arch.vtcr);
+	if (snapshot->pgd_len < required_pgd_len)
+		return -ENOMEM;
+
+	to_pgt = &snapshot->pgtable;
+	nr_pages = snapshot->pgd_len / PAGE_SIZE;
+	pgd = kern_hyp_va(snapshot->pgd_hva);
+
+	hyp_spin_lock(&snapshot_pool_lock);
+	hyp_pool_init(&snapshot_pool, hyp_virt_to_pfn(pgd),
+		      required_pgd_len / PAGE_SIZE, 0);
+
+	mm_ops.zalloc_pages_exact	= snapshot_zalloc_pages_exact;
+	mm_ops.zalloc_page		= snapshot_zalloc_page;
+	mm_ops.free_pages_exact		= snapshot_s2_free_pages_exact;
+	mm_ops.get_page			= snapshot_get_page;
+	mm_ops.phys_to_virt		= hyp_phys_to_virt;
+	mm_ops.virt_to_phys		= hyp_virt_to_phys;
+	mm_ops.page_count		= hyp_page_count;
+
+	to_pgt->ia_bits		= from_pgt->ia_bits;
+	to_pgt->start_level	= from_pgt->start_level;
+	to_pgt->flags		= from_pgt->flags;
+	to_pgt->mm_ops		= &mm_ops;
+
+	host_lock_component();
+	ret = kvm_pgtable_stage2_copy(to_pgt, from_pgt, memcache);
+	host_unlock_component();
+
+	hyp_spin_unlock(&snapshot_pool_lock);
+
+	return ret;
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
 void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
 {
 	void *addr;
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index f155b8c9e98c..256654b89c1e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1598,3 +1598,59 @@ void kvm_pgtable_stage2_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *p
 	WARN_ON(mm_ops->page_count(pgtable) != 1);
 	mm_ops->put_page(pgtable);
 }
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+static int stage2_copy_walker(const struct kvm_pgtable_visit_ctx *ctx,
+			      enum kvm_pgtable_walk_flags visit)
+{
+	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
+	void *copy_table, *original_addr;
+	kvm_pte_t new = ctx->old;
+
+	if (!stage2_pte_is_counted(ctx->old))
+		return 0;
+
+	if (kvm_pte_table(ctx->old, ctx->level)) {
+		copy_table = mm_ops->zalloc_page(ctx->arg);
+		if (!copy_table)
+			return -ENOMEM;
+
+		original_addr = kvm_pte_follow(ctx->old, mm_ops);
+
+		memcpy(copy_table, original_addr, PAGE_SIZE);
+		new = kvm_init_table_pte(copy_table, mm_ops);
+	}
+
+	*ctx->ptep = new;
+
+	return 0;
+}
+
+int kvm_pgtable_stage2_copy(struct kvm_pgtable *to_pgt,
+			    const struct kvm_pgtable *from_pgt,
+			    void *mc)
+{
+	int ret;
+	size_t pgd_sz;
+	struct kvm_pgtable_mm_ops *mm_ops = to_pgt->mm_ops;
+	struct kvm_pgtable_walker walker = {
+		.cb	= stage2_copy_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF |
+			  KVM_PGTABLE_WALK_TABLE_PRE,
+		.arg = mc
+	};
+
+	pgd_sz = kvm_pgd_pages(to_pgt->ia_bits, to_pgt->start_level) *
+		PAGE_SIZE;
+	to_pgt->pgd = (kvm_pteref_t)mm_ops->zalloc_pages_exact(pgd_sz);
+	if (!to_pgt->pgd)
+		return -ENOMEM;
+
+	memcpy(to_pgt->pgd, from_pgt->pgd, pgd_sz);
+
+	ret = kvm_pgtable_walk(to_pgt, 0, BIT(to_pgt->ia_bits), &walker);
+	mm_ops->free_pages_exact(to_pgt->pgd, pgd_sz);
+
+	return ret;
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
-- 
2.42.0.655.g421f12c284-goog

