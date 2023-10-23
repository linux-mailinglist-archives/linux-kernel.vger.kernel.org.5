Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740307D37C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjJWNWH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjJWNVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:21:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955851737
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:20:48 -0700 (PDT)
Received: from kwepemm000018.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SDbLx3RYYzVlNJ;
        Mon, 23 Oct 2023 21:16:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 kwepemm000018.china.huawei.com (7.193.23.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 21:20:44 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.031;
 Mon, 23 Oct 2023 14:20:42 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "ankita@nvidia.com" <ankita@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "aniketa@nvidia.com" <aniketa@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "targupta@nvidia.com" <targupta@nvidia.com>,
        "vsethi@nvidia.com" <vsethi@nvidia.com>,
        "acurrid@nvidia.com" <acurrid@nvidia.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "danw@nvidia.com" <danw@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "linyufeng (A)" <linyufeng3@huawei.com>
Subject: RE: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Thread-Topic: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
Thread-Index: AQHZ4bdLehyCbll0tE+E3EeoI9km/7BXohtA
Date:   Mon, 23 Oct 2023 13:20:42 +0000
Message-ID: <af13ed63dc9a4f26a6c958ebfa77d78a@huawei.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-2-ankita@nvidia.com>
In-Reply-To: <20230907181459.18145-2-ankita@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.228]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: ankita@nvidia.com [mailto:ankita@nvidia.com]
> Sent: 07 September 2023 19:15
> To: ankita@nvidia.com; jgg@nvidia.com; maz@kernel.org;
> oliver.upton@linux.dev; catalin.marinas@arm.com; will@kernel.org
> Cc: aniketa@nvidia.com; cjia@nvidia.com; kwankhede@nvidia.com;
> targupta@nvidia.com; vsethi@nvidia.com; acurrid@nvidia.com;
> apopple@nvidia.com; jhubbard@nvidia.com; danw@nvidia.com;
> linux-arm-kernel@lists.infradead.org; kvmarm@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v1 1/2] KVM: arm64: determine memory type from VMA
> 
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Currently KVM determines if a VMA is pointing at IO memory by checking
> pfn_is_map_memory(). However, the MM already gives us a way to tell what
> kind of memory it is by inspecting the VMA.
> 
> Replace pfn_is_map_memory() with a check on the VMA pgprot to
> determine if
> the memory is IO and thus needs stage-2 device mapping.
> 
> The VMA's pgprot is tested to determine the memory type with the
> following mapping:
> 
>  pgprot_noncached    MT_DEVICE_nGnRnE   device
>  pgprot_writecombine MT_NORMAL_NC       device
>  pgprot_device       MT_DEVICE_nGnRE    device
>  pgprot_tagged       MT_NORMAL_TAGGED   RAM
> 
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
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  8 ++++++
>  arch/arm64/kvm/hyp/pgtable.c         |  2 +-
>  arch/arm64/kvm/mmu.c                 | 40
> +++++++++++++++++++++++++---
>  3 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h
> b/arch/arm64/include/asm/kvm_pgtable.h
> index d3e354bb8351..0579dbe958b9 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -430,6 +430,14 @@ u64 kvm_pgtable_hyp_unmap(struct kvm_pgtable
> *pgt, u64 addr, u64 size);
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
>   * kvm_pgtable_stage2_pgd_size() - Helper to compute size of a stage-2
> PGD
>   * @vtcr:	Content of the VTCR register.
> diff --git a/arch/arm64/kvm/hyp/pgtable.c
> b/arch/arm64/kvm/hyp/pgtable.c
> index f155b8c9e98c..ccd291b6893d 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -662,7 +662,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32
> phys_shift)
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
> @@ -1391,6 +1391,15 @@ static bool kvm_vma_mte_allowed(struct
> vm_area_struct *vma)
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
> @@ -1490,6 +1499,18 @@ static int user_mem_abort(struct kvm_vcpu
> *vcpu, phys_addr_t fault_ipa,
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
> +
>  	/* Don't use the VMA after the unlock -- it may have vanished */
>  	vma = NULL;
> 
> @@ -1576,10 +1597,21 @@ static int user_mem_abort(struct kvm_vcpu
> *vcpu, phys_addr_t fault_ipa,
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
> +	      page_to_virt(pfn_to_page(pfn)) ==
> kvm_host_va(PFN_PHYS(pfn)))) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I don't quite follow the above check. Does no FWB matters for
Non-cacheable/device memory as well?

From a quick check, it breaks a n/w dev assignment on a platform that doesn't 
have FWB.

Qemu reports,

error: kvm run failed Invalid argument
 PC=ffff800080a95ed0 X00=ffff0000c7ff8090 X01=ffff0000c7ff80a0
X02=00000000fe180000 X03=ffff800085327000 X04=0000000000000001
X05=0000000000000040 X06=000000000000003f X07=0000000000000000
X08=ffff0000be190000 X09=0000000000000000 X10=0000000000000040

Please let me know.

Thanks,
Shameer

> 
>  	/*
>  	 * Under the premise of getting a FSC_PERM fault, we just need to relax
> --
> 2.17.1
> 

