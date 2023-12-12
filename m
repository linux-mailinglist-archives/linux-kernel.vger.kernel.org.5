Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4DC80F4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376831AbjLLRqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:46:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909F494
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:46:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BECC433C8;
        Tue, 12 Dec 2023 17:46:36 +0000 (UTC)
Date:   Tue, 12 Dec 2023 17:46:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, ardb@kernel.org, akpm@linux-foundation.org,
        gshan@redhat.com, linux-mm@kvack.org, lpieralisi@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] kvm: arm64: set io memory s2 pte as normalnc for
 vfio pci devices
Message-ID: <ZXicemDzXm8NShs1@arm.com>
References: <20231208164709.23101-1-ankita@nvidia.com>
 <20231208164709.23101-3-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208164709.23101-3-ankita@nvidia.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:17:09PM +0530, ankita@nvidia.com wrote:
>  arch/arm64/kvm/hyp/pgtable.c     |  3 +++
>  arch/arm64/kvm/mmu.c             | 16 +++++++++++++---
>  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>  include/linux/mm.h               |  7 +++++++
>  4 files changed, 25 insertions(+), 4 deletions(-)

It might be worth factoring out the vfio bits into a separate patch
together with a bit of documentation around this new vma flag (up to
Alex really).

> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index d4835d553c61..c8696c9e7a60 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -722,6 +722,9 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>  	kvm_pte_t attr;
>  	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
>  
> +	if (device && normal_nc)
> +		return -EINVAL;

Ah, the comment Will and I made on patch 1 is handled here. Add a
WARN_ON_ONCE() and please move this hunk to the first patch, it makes
more sense there.

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index d14504821b79..1ce1b6d89bf9 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1381,7 +1381,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	int ret = 0;
>  	bool write_fault, writable, force_pte = false;
>  	bool exec_fault, mte_allowed;
> -	bool device = false;
> +	bool device = false, vfio_pci_device = false;

I don't think the variable here should be named vfio_pci_device, the
VM_* flag doesn't mention PCI. So just something like "vfio_allow_wc".

>  	unsigned long mmu_seq;
>  	struct kvm *kvm = vcpu->kvm;
>  	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> @@ -1472,6 +1472,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	gfn = fault_ipa >> PAGE_SHIFT;
>  	mte_allowed = kvm_vma_mte_allowed(vma);
>  
> +	vfio_pci_device = !!(vma->vm_flags & VM_VFIO_ALLOW_WC);

Nitpick: no need for !!, you are assigning to a bool variable already.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1cbc990d42e0..c3f95ec7fc3a 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1863,7 +1863,8 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
>  	 * change vm_flags within the fault handler.  Set them now.
>  	 */
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +	vm_flags_set(vma, VM_VFIO_ALLOW_WC | VM_IO | VM_PFNMAP |
> +			VM_DONTEXPAND | VM_DONTDUMP);

Please add a comment here that write-combining is allowed to be enabled
by the arch (KVM) code but the default user mmap() will still use
pgprot_noncached().

>  	vma->vm_ops = &vfio_pci_mmap_ops;
>  
>  	return 0;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a422cc123a2d..8d3c4820c492 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -391,6 +391,13 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_UFFD_MINOR		VM_NONE
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  
> +#ifdef CONFIG_64BIT
> +#define VM_VFIO_ALLOW_WC_BIT	39	/* Convey KVM to map S2 NORMAL_NC */

This comment shouldn't be in the core header file. It knows nothing
about S2 and Normal-NC, that's arm64 terminology. You can mention
something like VFIO can use this flag hint that write-combining is
allowed.

> +#define VM_VFIO_ALLOW_WC	BIT(VM_VFIO_ALLOW_WC_BIT)
> +#else
> +#define VM_VFIO_ALLOW_WC	VM_NONE
> +#endif

And I think we need to add some documentation (is there any
VFIO-specific doc) that describes what this flag actually means, what is
permitted. For example, arm64 doesn't have write-combining without
speculative fetches. So if one adds this flag to a new driver, they
should know the implications. There's also an expectation that the
actual driver (KVM guests) or maybe later DPDK can choose the safe
non-cacheable or write-combine (Linux terminology) attributes for the
BAR.

-- 
Catalin
