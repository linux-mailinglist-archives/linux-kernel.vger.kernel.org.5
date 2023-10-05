Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA37BA619
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbjJEQYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbjJEQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F411708
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:15:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AE3C433C9;
        Thu,  5 Oct 2023 16:15:39 +0000 (UTC)
Date:   Thu, 5 Oct 2023 17:15:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        will@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Message-ID: <ZR7hKYU1Wj+VTqpO@arm.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907181459.18145-2-ankita@nvidia.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:14:58AM -0700, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Currently KVM determines if a VMA is pointing at IO memory by checking
> pfn_is_map_memory(). However, the MM already gives us a way to tell what
> kind of memory it is by inspecting the VMA.

Well, it doesn't. It tells us what attributes the user mapped that
memory with, not whether it's I/O memory or standard RAM.

> Replace pfn_is_map_memory() with a check on the VMA pgprot to determine if
> the memory is IO and thus needs stage-2 device mapping.
> 
> The VMA's pgprot is tested to determine the memory type with the
> following mapping:
> 
>  pgprot_noncached    MT_DEVICE_nGnRnE   device
>  pgprot_writecombine MT_NORMAL_NC       device
>  pgprot_device       MT_DEVICE_nGnRE    device
>  pgprot_tagged       MT_NORMAL_TAGGED   RAM

I would move the second patch to be the first, we could even merge that
independently as it is about relaxing the stage 2 mapping to Normal NC.
It would make it simpler I think to reason about the second patch which
further relaxes the stage 2 mapping to Normal Cacheable under certain
conditions.

> This patch solves a problems where it is possible for the kernel to
> have VMAs pointing at cachable memory without causing
> pfn_is_map_memory() to be true, eg DAX memremap cases and CXL/pre-CXL
> devices. This memory is now properly marked as cachable in KVM.
> 
> Unfortunately when FWB is not enabled, the kernel expects to naively do
> cache management by flushing the memory using an address in the
> kernel's map. This does not work in several of the newly allowed
> cases such as dcache_clean_inval_poc(). Check whether the targeted pfn
> and its mapping KVA is valid in case the FWB is absent before continuing.

I would only allow cacheable stage 2 mappings if FWB is enabled.
Otherwise we end up with a mismatch between the VMM mapping and whatever
the guest may do.

> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  8 ++++++
>  arch/arm64/kvm/hyp/pgtable.c         |  2 +-
>  arch/arm64/kvm/mmu.c                 | 40 +++++++++++++++++++++++++---
>  3 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index d3e354bb8351..0579dbe958b9 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -430,6 +430,14 @@ u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
>   */
>  u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
>  
> +/**
> + * stage2_has_fwb() - Determine whether FWB is supported
> + * @pgt:    Page-table structure initialised by kvm_pgtable_stage2_init*()
> + *
> + * Return: True if FWB is supported.
> + */
> +bool stage2_has_fwb(struct kvm_pgtable *pgt);
> +
>  /**
>   * kvm_pgtable_stage2_pgd_size() - Helper to compute size of a stage-2 PGD
>   * @vtcr:	Content of the VTCR register.
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index f155b8c9e98c..ccd291b6893d 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -662,7 +662,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
>  	return vtcr;
>  }
>  
> -static bool stage2_has_fwb(struct kvm_pgtable *pgt)
> +bool stage2_has_fwb(struct kvm_pgtable *pgt)
>  {
>  	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>  		return false;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 482280fe22d7..79f1caaa08a0 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1391,6 +1391,15 @@ static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_MTE_ALLOWED;
>  }
>  
> +/*
> + * Determine the memory region cacheability from VMA's pgprot. This
> + * is used to set the stage 2 PTEs.
> + */
> +static unsigned long mapping_type(pgprot_t page_prot)
> +{
> +	return FIELD_GET(PTE_ATTRINDX_MASK, pgprot_val(page_prot));
> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  struct kvm_memory_slot *memslot, unsigned long hva,
>  			  unsigned long fault_status)
> @@ -1490,6 +1499,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	gfn = fault_ipa >> PAGE_SHIFT;
>  	mte_allowed = kvm_vma_mte_allowed(vma);
>  
> +	/*
> +	 * Figure out the memory type based on the user va mapping properties
> +	 * Only MT_DEVICE_nGnRE and MT_DEVICE_nGnRnE will be set using
> +	 * pgprot_device() and pgprot_noncached() respectively.
> +	 */
> +	if ((mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRE) ||
> +	    (mapping_type(vma->vm_page_prot) == MT_DEVICE_nGnRnE) ||
> +	    (mapping_type(vma->vm_page_prot) == MT_NORMAL_NC))
> +		prot |= KVM_PGTABLE_PROT_DEVICE;
> +	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> +		prot |= KVM_PGTABLE_PROT_X;

Does this mean that we can end up with some I/O memory also mapped as
executable? Is there a use-case (e.g. using CXL memory as standard guest
RAM, executable)?

> +
>  	/* Don't use the VMA after the unlock -- it may have vanished */
>  	vma = NULL;
>  
> @@ -1576,10 +1597,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (exec_fault)
>  		prot |= KVM_PGTABLE_PROT_X;
>  
> -	if (device)
> -		prot |= KVM_PGTABLE_PROT_DEVICE;
> -	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
> -		prot |= KVM_PGTABLE_PROT_X;
> +	/*
> +	 *  When FWB is unsupported KVM needs to do cache flushes
> +	 *  (via dcache_clean_inval_poc()) of the underlying memory. This is
> +	 *  only possible if the memory is already mapped into the kernel map
> +	 *  at the usual spot.
> +	 *
> +	 *  Validate that there is a struct page for the PFN which maps
> +	 *  to the KVA that the flushing code expects.
> +	 */
> +	if (!stage2_has_fwb(pgt) &&
> +	    !(pfn_valid(pfn) &&
> +	      page_to_virt(pfn_to_page(pfn)) == kvm_host_va(PFN_PHYS(pfn)))) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

My preference would be to keep most of the current logic (including
pfn_is_map_memory()) but force stage 2 cacheable for this page if the
user vma_page_prot is MT_NORMAL or MT_NORMAL_TAGGED and we have FWB. It
might be seen as an ABI change but I don't think it matters, it mostly
brings cacheable I/O mem mappings in line with standard RAM (bar the
exec permission unless there is a use-case for it).

-- 
Catalin
