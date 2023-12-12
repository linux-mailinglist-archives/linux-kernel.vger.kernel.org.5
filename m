Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6380EB52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjLLMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346413AbjLLMRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:17:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E21C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:17:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F7AC433C8;
        Tue, 12 Dec 2023 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702383471;
        bh=PSsletKarNFcUm/hB4a9Sb8O26Kgrcut7nfxUAiV0G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKEqXSYrh9aAc4uI9mhEFQNclPqu4W8YM1VERL6UvetYXIzQ1IXiNblhjc1CC5QVj
         YLNWemmKoqQyMBVNlirwrMDfW6bgeybH6ppIEef/bqR6ilbNBPVXF5DpkeOkWMI9zk
         NfxfciR7kvIckAhNRDssDu1BjCUh2HdEBlyzz8RwQYkbW8I2EBVDyeN1HMxxmoRRXq
         ZC/dfV7hCUbi02ScIlADNOnJfsgTbTlVDZh5JdyXURRqSJISGzqBXlYCXJ2Wgum+pK
         peFPOPzAVtnJNOliurIg/B5MTrXOINv+ds72CjhIc9bDa4X1uG52VVsego3Om41jm0
         fLGMd5Y1TuBSQ==
Date:   Tue, 12 Dec 2023 12:17:42 +0000
From:   Will Deacon <will@kernel.org>
To:     ankita@nvidia.com
Cc:     jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, ardb@kernel.org,
        akpm@linux-foundation.org, gshan@redhat.com, linux-mm@kvack.org,
        lpieralisi@kernel.org, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, mochs@nvidia.com, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] kvm: arm64: introduce new flag for non-cacheable
 IO memory
Message-ID: <20231212121742.GA29205@willie-the-truck>
References: <20231208164709.23101-1-ankita@nvidia.com>
 <20231208164709.23101-2-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208164709.23101-2-ankita@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:17:08PM +0530, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> For various reasons described in the cover letter, and primarily to
> allow VM get IO memory with NORMALNC properties, it is desired
> to relax the KVM stage 2 device memory attributes from DEVICE_nGnRE
> to NormalNC. So set S2 PTE for IO memory as NORMAL_NC.
> 
> A Normal-NC flag is not present today. So add a new kvm_pgtable_prot
> (KVM_PGTABLE_PROT_NORMAL_NC) flag for it, along with its
> corresponding PTE value 0x5 (0b101) determined from [1].
> 
> Lastly, adapt the stage2 PTE property setter function
> (stage2_set_prot_attr) to handle the NormalNC attribute.
> 
> [1] section D8.5.5 of DDI0487J_a_a-profile_architecture_reference_manual.pdf
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  2 ++
>  arch/arm64/include/asm/memory.h      |  2 ++
>  arch/arm64/kvm/hyp/pgtable.c         | 11 +++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index cfdf40f734b1..19278dfe7978 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -197,6 +197,7 @@ enum kvm_pgtable_stage2_flags {
>   * @KVM_PGTABLE_PROT_W:		Write permission.
>   * @KVM_PGTABLE_PROT_R:		Read permission.
>   * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
> + * @KVM_PGTABLE_PROT_NORMAL_NC:	Normal noncacheable attributes.
>   * @KVM_PGTABLE_PROT_SW0:	Software bit 0.
>   * @KVM_PGTABLE_PROT_SW1:	Software bit 1.
>   * @KVM_PGTABLE_PROT_SW2:	Software bit 2.
> @@ -208,6 +209,7 @@ enum kvm_pgtable_prot {
>  	KVM_PGTABLE_PROT_R			= BIT(2),
>  
>  	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
> +	KVM_PGTABLE_PROT_NORMAL_NC		= BIT(4),
>  
>  	KVM_PGTABLE_PROT_SW0			= BIT(55),
>  	KVM_PGTABLE_PROT_SW1			= BIT(56),
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index fde4186cc387..c247e5f29d5a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -147,6 +147,7 @@
>   * Memory types for Stage-2 translation
>   */
>  #define MT_S2_NORMAL		0xf
> +#define MT_S2_NORMAL_NC		0x5
>  #define MT_S2_DEVICE_nGnRE	0x1
>  
>  /*
> @@ -154,6 +155,7 @@
>   * Stage-2 enforces Normal-WB and Device-nGnRE
>   */
>  #define MT_S2_FWB_NORMAL	6
> +#define MT_S2_FWB_NORMAL_NC	5
>  #define MT_S2_FWB_DEVICE_nGnRE	1
>  
>  #ifdef CONFIG_ARM64_4K_PAGES
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index c651df904fe3..d4835d553c61 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -718,10 +718,17 @@ static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot p
>  				kvm_pte_t *ptep)
>  {
>  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
> -	kvm_pte_t attr = device ? KVM_S2_MEMATTR(pgt, DEVICE_nGnRE) :
> -			    KVM_S2_MEMATTR(pgt, NORMAL);
> +	bool normal_nc = prot & KVM_PGTABLE_PROT_NORMAL_NC;
> +	kvm_pte_t attr;
>  	u32 sh = KVM_PTE_LEAF_ATTR_LO_S2_SH_IS;
>  
> +	if (device)
> +		attr = KVM_S2_MEMATTR(pgt, DEVICE_nGnRE);
> +	else if (normal_nc)
> +		attr = KVM_S2_MEMATTR(pgt, NORMAL_NC);
> +	else
> +		attr = KVM_S2_MEMATTR(pgt, NORMAL);

I think it would be worth rejecting the case where both
KVM_PGTABLE_PROT_DEVICE and KVM_PGTABLE_PROT_NORMAL_NC are passed, since
that's clearly a bug in the caller and silently going with device is
arbitrary and confusing.

Will
