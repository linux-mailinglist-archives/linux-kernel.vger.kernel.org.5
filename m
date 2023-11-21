Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACD7F306E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjKUONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjKUOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:13:03 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FC10DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:12:59 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50906f941so75467471fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700575977; x=1701180777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHZlJnR2F0+kbBXUJA/BBV3JLpteKy8OuOSHxj5KI5E=;
        b=uuOW7d4QxeS60afcG6OI2fTYiasNGyJ7e6uhH+Ek50uW2RoOCchqtVivFuks2T1Lbf
         kZebdt9O2sAiwnzVI7HKi05aUGDvFLYvQugPjQmxygyT/r0G1UXGEZ/E9Jm2UrXzmGf8
         DLOQ0nXHE5YeTkv2jBc5dc3h5uiiA/fO2fgZoTy5hfMXtneaeZX9GVfi32WFSGZpqGiP
         7DZxBxEOB/641XJkS7EKN+OOVPwPIz9ZjgjdQ8s8qWhdzy56Aid1FWNjbMJ7nY2y+TCH
         /ofAD1nWGOB/PFWR/AeRSz2qFC8cKL5+Nl5fKFyJQWKVBmKLugP0Q4gPwqWJeUaXm+4S
         Alog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575977; x=1701180777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHZlJnR2F0+kbBXUJA/BBV3JLpteKy8OuOSHxj5KI5E=;
        b=UySGol6bFOwmCP6iK0AVNJZyKhM6RWbn5SCmOYvlnn3FRfL92L35a0PtRyBnmjTASQ
         qaVD+H1rc7MlwS5hMWx+wNMv4twPKCQ0hJfoeaa+2NKBfQPqeT3bRkO58VtAe3etImSd
         bkQiKQy0Ed/Ni6hU7XtEAlWarRdhZxxEDnvNK912YVm/AJzeNj/a7a3EvC3URxynq2Bz
         FYrFq9aOXKl/tzQgLLdfbobI5SdmkNM6SWjit0d+iaLL2ZC905KmI0MMrFRyhZ+yo2/E
         98uJXLxIx+9osugsOMeSvTUv87c+BNnyXRxV7HWy3+om+rnnAaGd5yLjhcDQsWAG6/ob
         a9vg==
X-Gm-Message-State: AOJu0YzyW6dcUjqrwufxyvOrenDtJgHJNDqw5u+qtRdymDJyeHcQ49Ef
        3mgKvXN/nQueU/tG4YAhXEkpZA==
X-Google-Smtp-Source: AGHT+IGL75TNKNlK3xK8N0MVZKH6ry+2ulpJqeCInxN3WKW1NEHFlC5VZx3WcKTitRzIRAsDLXvxHA==
X-Received: by 2002:a2e:9296:0:b0:2c5:31de:6c02 with SMTP id d22-20020a2e9296000000b002c531de6c02mr7305774ljh.15.1700575976818;
        Tue, 21 Nov 2023 06:12:56 -0800 (PST)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b004090ca6d785sm17472366wmb.2.2023.11.21.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:12:56 -0800 (PST)
Date:   Tue, 21 Nov 2023 14:12:50 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v3 01/10] KVM: arm64: Add snap shooting the host stage-2
 pagetables
Message-ID: <ZVy64ha-IaX_c0pl@google.com>
References: <20231115171639.2852644-2-sebastianene@google.com>
 <20231115171639.2852644-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115171639.2852644-3-sebastianene@google.com>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 05:16:31PM +0000, Sebastian Ene wrote:
> Introduce a new HVC that allows the caller to snap shoot the stage-2

"snapshot" same in the title of this patch.

> pagetables under NVHE debug configuration. The caller specifies the
> location where the pagetables are copied and must ensure that the memory
> is accessible by the hypervisor. The memory where the pagetables are
> copied has to be allocated by the caller and shared with the hypervisor.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |   1 +
>  arch/arm64/include/asm/kvm_pgtable.h          |  36 +++++++
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  20 ++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 102 ++++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c                  |  56 ++++++++++
>  6 files changed, 216 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 24b5e6b23417..99145a24c0f6 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -81,6 +81,7 @@ enum __kvm_host_smccc_func {
>  	__KVM_HOST_SMCCC_FUNC___pkvm_init_vm,
>  	__KVM_HOST_SMCCC_FUNC___pkvm_init_vcpu,
>  	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
> +	__KVM_HOST_SMCCC_FUNC___pkvm_copy_host_stage2,
>  };
>  
>  #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index d3e354bb8351..be615700f8ac 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -10,6 +10,7 @@
>  #include <linux/bits.h>
>  #include <linux/kvm_host.h>
>  #include <linux/types.h>
> +#include <asm/kvm_host.h>
>  
>  #define KVM_PGTABLE_MAX_LEVELS		4U
>  
> @@ -351,6 +352,21 @@ struct kvm_pgtable {
>  	kvm_pgtable_force_pte_cb_t		force_pte_cb;
>  };
>  
> +/**
> + * struct kvm_pgtable_snapshot - Snapshot page-table wrapper.
> + * @pgtable:		The page-table configuration.
> + * @mc:			Memcache used for pagetable pages allocation.
> + * @pgd_hva:		Host virtual address of a physically contiguous buffer
> + *			used for storing the PGD.
> + * @pgd_len:		The size of the phyisically contiguous buffer in bytes.
> + */
> +struct kvm_pgtable_snapshot {
> +	struct kvm_pgtable			pgtable;
> +	struct kvm_hyp_memcache			mc;
> +	void					*pgd_hva;
> +	size_t					pgd_len;
> +};
> +
>  /**
>   * kvm_pgtable_hyp_init() - Initialise a hypervisor stage-1 page-table.
>   * @pgt:	Uninitialised page-table structure to initialise.
> @@ -756,4 +772,24 @@ enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
>   */
>  void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
>  				phys_addr_t addr, size_t size);
> +
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +/**
> + * kvm_pgtable_stage2_copy() - Snapshot the pagetable
> + *
> + * @to_pgt:	Destination pagetable
> + * @from_pgt:	Source pagetable. The caller must lock the pagetables first
> + * @mc:		The memcache where we allocate the destination pagetables from
> + */
> +int kvm_pgtable_stage2_copy(struct kvm_pgtable *to_pgt,
> +			    const struct kvm_pgtable *from_pgt,
> +			    void *mc);
> +#else
> +static inline int kvm_pgtable_stage2_copy(struct kvm_pgtable *to_pgt,
> +					  const struct kvm_pgtable *from_pgt,
> +					  void *mc)
> +{
> +	return -EPERM;
> +}
> +#endif	/* CONFIG_NVHE_EL2_DEBUG */
>  #endif	/* __ARM64_KVM_PGTABLE_H__ */
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 0972faccc2af..9cfb35d68850 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -69,6 +69,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
>  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> +int __pkvm_host_stage2_prepare_copy(struct kvm_pgtable_snapshot *snapshot);

nit: the struct being a snapshot and that function doing the actual snapshot,
maybe __pkvm_host_stage2_snapshot() would be a better name?

>  
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 2385fd03ed87..98646cc67497 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -314,6 +314,25 @@ static void handle___pkvm_teardown_vm(struct kvm_cpu_context *host_ctxt)
>  	cpu_reg(host_ctxt, 1) = __pkvm_teardown_vm(handle);
>  }
>  
> +static void handle___pkvm_copy_host_stage2(struct kvm_cpu_context *host_ctxt)
> +{
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +	int ret = -EPERM;
> +	DECLARE_REG(struct kvm_pgtable_snapshot *, snapshot, host_ctxt, 1);
> +	kvm_pteref_t pgd;
> +
> +	snapshot = kern_hyp_va(snapshot);
> +	ret = __pkvm_host_stage2_prepare_copy(snapshot);
> +	if (!ret) {
> +		pgd = snapshot->pgtable.pgd;
> +		snapshot->pgtable.pgd = (kvm_pteref_t)__hyp_pa(pgd);
> +	}
> +	cpu_reg(host_ctxt, 1) = ret;
> +#else
> +	cpu_reg(host_ctxt, 0) = SMCCC_RET_NOT_SUPPORTED;
> +#endif
> +}
> +
>  typedef void (*hcall_t)(struct kvm_cpu_context *);
>  
>  #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
> @@ -348,6 +367,7 @@ static const hcall_t host_hcall[] = {
>  	HANDLE_FUNC(__pkvm_init_vm),
>  	HANDLE_FUNC(__pkvm_init_vcpu),
>  	HANDLE_FUNC(__pkvm_teardown_vm),
> +	HANDLE_FUNC(__pkvm_copy_host_stage2),
>  };
>  
>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 8d0a5834e883..1c3ab5ac9110 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -266,6 +266,108 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +static struct hyp_pool snapshot_pool = {0};
> +static DEFINE_HYP_SPINLOCK(snapshot_pool_lock);
> +
> +static void *snapshot_zalloc_pages_exact(size_t size)
> +{
> +	void *addr = hyp_alloc_pages(&snapshot_pool, get_order(size));
> +
> +	hyp_split_page(hyp_virt_to_page(addr));
> +
> +	/*
> +	 * The size of concatenated PGDs is always a power of two of PAGE_SIZE,
> +	 * so there should be no need to free any of the tail pages to make the
> +	 * allocation exact.
> +	 */
> +	WARN_ON(size != (PAGE_SIZE << get_order(size)));
> +
> +	return addr;
> +}
> +
> +static void snapshot_get_page(void *addr)
> +{
> +	hyp_get_page(&snapshot_pool, addr);
> +}
> +
> +static void *snapshot_zalloc_page(void *mc)
> +{
> +	struct hyp_page *p;
> +	void *addr;
> +
> +	addr = hyp_alloc_pages(&snapshot_pool, 0);
> +	if (addr)
> +		return addr;
> +
> +	addr = pop_hyp_memcache(mc, hyp_phys_to_virt);
> +	if (!addr)
> +		return addr;
> +
> +	memset(addr, 0, PAGE_SIZE);
> +	p = hyp_virt_to_page(addr);
> +	memset(p, 0, sizeof(*p));

Why do you need to rease this entry of the vmemmap? That sounds odd.

> +	p->refcount = 1;
> +
> +	return addr;
> +}
> +
> +static void snapshot_s2_free_pages_exact(void *addr, unsigned long size)
> +{
> +	u8 order = get_order(size);
> +	unsigned int i;
> +	struct hyp_page *p;
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		p = hyp_virt_to_page(addr + (i * PAGE_SIZE));
> +		hyp_page_ref_dec_and_test(p);

hyp_page_ref_dec() would be enough here.

> +	}
> +}
> +
> +int __pkvm_host_stage2_prepare_copy(struct kvm_pgtable_snapshot *snapshot)
> +{
> +	size_t required_pgd_len;
> +	struct kvm_pgtable_mm_ops mm_ops = {0};
> +	struct kvm_s2_mmu *mmu = &host_mmu.arch.mmu;
> +	struct kvm_pgtable *to_pgt, *from_pgt = &host_mmu.pgt;
> +	struct kvm_hyp_memcache *memcache = &snapshot->mc;
> +	int ret;
> +	void *pgd;

The shared memory between host and hyp should probably be pinned here even if it
is behind a DEBUG option. That would also ensure that the memory has actually
been shared beforehand and we'll not crash while running that. 

Pinning that memory would also make sure that the right amount has been shared
for the pgd and we'll not overflow.

> +
> +	required_pgd_len = kvm_pgtable_stage2_pgd_size(mmu->vtcr);
> +	if (snapshot->pgd_len < required_pgd_len)
> +		return -ENOMEM;
> +
> +	to_pgt = &snapshot->pgtable;
> +	pgd = kern_hyp_va(snapshot->pgd_hva);
> +
> +	hyp_spin_lock(&snapshot_pool_lock);
> +	hyp_pool_init(&snapshot_pool, hyp_virt_to_pfn(pgd),
> +		      required_pgd_len / PAGE_SIZE, 0);
> +
> +	mm_ops.zalloc_pages_exact	= snapshot_zalloc_pages_exact;
> +	mm_ops.zalloc_page		= snapshot_zalloc_page;
> +	mm_ops.free_pages_exact		= snapshot_s2_free_pages_exact;
> +	mm_ops.get_page			= snapshot_get_page;
> +	mm_ops.phys_to_virt		= hyp_phys_to_virt;
> +	mm_ops.virt_to_phys		= hyp_virt_to_phys;
> +	mm_ops.page_count		= hyp_page_count;

It looks a bit odd to me to have to handle refcount while the lifespan of that
newly create page-table only the lifespace of that function, where everything is
behind a lock.

Is the need for the pool to handle the physically contiguous mem for the PGD? If
that is the case, maybe you could avoid the pool by just passing as a separated
argument the memory for the PGD and in another one the memcache for the other
levels?

Especially IIUC, the pool would be used here only for the PGD allocation, as you
add only the size of the PGD to the pool?

>+
> +	to_pgt->ia_bits		= from_pgt->ia_bits;
> +	to_pgt->start_level	= from_pgt->start_level;
> +	to_pgt->flags		= from_pgt->flags;
> +	to_pgt->mm_ops		= &mm_ops;
> +
> +	host_lock_component();
> +	ret = kvm_pgtable_stage2_copy(to_pgt, from_pgt, memcache);
> +	host_unlock_component();
> +
> +	hyp_spin_unlock(&snapshot_pool_lock);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_NVHE_EL2_DEBUG */
> +
>  void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
>  {
>  	void *addr;
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 1966fdee740e..46b15d74118f 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1598,3 +1598,59 @@ void kvm_pgtable_stage2_free_unlinked(struct kvm_pgtable_mm_ops *mm_ops, void *p
>  	WARN_ON(mm_ops->page_count(pgtable) != 1);
>  	mm_ops->put_page(pgtable);
>  }
> +
> +#ifdef CONFIG_NVHE_EL2_DEBUG
> +static int stage2_copy_walker(const struct kvm_pgtable_visit_ctx *ctx,
> +			      enum kvm_pgtable_walk_flags visit)
> +{
> +	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
> +	void *copy_table, *original_addr;
> +	kvm_pte_t new = ctx->old;
> +
> +	if (!stage2_pte_is_counted(ctx->old))
> +		return 0;
> +
> +	if (kvm_pte_table(ctx->old, ctx->level)) {
> +		copy_table = mm_ops->zalloc_page(ctx->arg);
> +		if (!copy_table)
> +			return -ENOMEM;
> +
> +		original_addr = kvm_pte_follow(ctx->old, mm_ops);
> +
> +		memcpy(copy_table, original_addr, PAGE_SIZE);
> +		new = kvm_init_table_pte(copy_table, mm_ops);
> +	}
> +
> +	*ctx->ptep = new;
> +
> +	return 0;
> +}
> +
> +int kvm_pgtable_stage2_copy(struct kvm_pgtable *to_pgt,
> +			    const struct kvm_pgtable *from_pgt,
> +			    void *mc)
> +{
> +	int ret;
> +	size_t pgd_sz;
> +	struct kvm_pgtable_mm_ops *mm_ops = to_pgt->mm_ops;
> +	struct kvm_pgtable_walker walker = {
> +		.cb	= stage2_copy_walker,
> +		.flags	= KVM_PGTABLE_WALK_LEAF |
> +			  KVM_PGTABLE_WALK_TABLE_PRE,

Do you need the WALK_LEAF? Entire tables are copied and you don't need to change
anything at the leaf level. Actually, stage2_copy_walker() writes new =
ctx->old in that case, doesn't it?

> +		.arg = mc
> +	};
> +
> +	pgd_sz = kvm_pgd_pages(to_pgt->ia_bits, to_pgt->start_level) *
> +		PAGE_SIZE;
> +	to_pgt->pgd = (kvm_pteref_t)mm_ops->zalloc_pages_exact(pgd_sz);
> +	if (!to_pgt->pgd)
> +		return -ENOMEM;
> +
> +	memcpy(to_pgt->pgd, from_pgt->pgd, pgd_sz);
> +
> +	ret = kvm_pgtable_walk(to_pgt, 0, BIT(to_pgt->ia_bits), &walker);
> +	mm_ops->free_pages_exact(to_pgt->pgd, pgd_sz);

> +
> +	return ret;
> +}
> +#endif /* CONFIG_NVHE_EL2_DEBUG */
> -- 
> 2.43.0.rc0.421.g78406f8d94-goog
> 
