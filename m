Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6317F0497
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 07:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKSGme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 01:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 01:42:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F25C6;
        Sat, 18 Nov 2023 22:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700376150; x=1731912150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y7x+P5+iP73mokjfVEHxVxgOTCxGtz9A6vm2FQBaeM0=;
  b=aC47tExSKKFrypYGWTtQibJ5RyTYDFphgCMriHY11x5gSrRIKWTY33jS
   NfG3T34QRWZvzFWn3NlrriDxGlDraviHMJfTHx4ffukR3AjtS42sdJ+Eg
   JjqHAS2uUxesNFj+AUQjUfe8ObEXhzzWpFAK5LGV+8FV+6eyr9aCosFli
   6gUo1Wt5DaCCjGc8pzKjT/vywPeb6jqDZm4XDEPl67I9Mz9ksM7vAx9B+
   7Xu6Idpqck8HUVYNMsQMtbzwcCyjXmFguEs1FjfFqAFeTp/4GuoBmEtwy
   CjSgFqDTZ5Yl8nVGRdVSHZrXjPjm8pe+kb297Xid4Ca4Of+Xf+SnAxX97
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="13026318"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="13026318"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 22:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="909785704"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="909785704"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.8.180]) ([10.93.8.180])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 22:42:26 -0800
Message-ID: <13937cd6-8dfa-493c-932c-71f878f447ef@linux.intel.com>
Date:   Sun, 19 Nov 2023 14:42:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/16] KVM: TDX: Pass size to reclaim_page()
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <31552f714f2fd8178f9467e9afaaf28ba3de3c7b.1699368363.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <31552f714f2fd8178f9467e9afaaf28ba3de3c7b.1699368363.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> A 2MB large page can be tdh_mem_page_aug()'ed to TD directly. In this case,
> it needs to reclaim and clear the page as 2MB size.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/kvm/vmx/tdx.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index a728175c4a6d..0fca863faeee 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -200,12 +200,13 @@ static void tdx_disassociate_vp_on_cpu(struct kvm_vcpu *vcpu)
>   	smp_call_function_single(cpu, tdx_disassociate_vp_arg, vcpu, 1);
>   }
>   
> -static void tdx_clear_page(unsigned long page_pa)
> +static void tdx_clear_page(unsigned long page_pa, int size)
Should use "unsigned long" instead of "int" for size to avoid implicit 
type conversion.

>   {
>   	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
>   	void *page = __va(page_pa);
>   	unsigned long i;
>   
> +	WARN_ON_ONCE(size % PAGE_SIZE);
>   	/*
>   	 * When re-assign one page from old keyid to a new keyid, MOVDIR64B is
>   	 * required to clear/write the page with new keyid to prevent integrity
> @@ -214,7 +215,7 @@ static void tdx_clear_page(unsigned long page_pa)
>   	 * clflush doesn't flush cache with HKID set.  The cache line could be
>   	 * poisoned (even without MKTME-i), clear the poison bit.
>   	 */
> -	for (i = 0; i < PAGE_SIZE; i += 64)
> +	for (i = 0; i < size; i += 64)
>   		movdir64b(page + i, zero_page);
>   	/*
>   	 * MOVDIR64B store uses WC buffer.  Prevent following memory reads
> @@ -223,7 +224,7 @@ static void tdx_clear_page(unsigned long page_pa)
>   	__mb();
>   }
>   
> -static int __tdx_reclaim_page(hpa_t pa)
> +static int __tdx_reclaim_page(hpa_t pa, enum pg_level level)
>   {
>   	struct tdx_module_args out;
>   	u64 err;
> @@ -241,17 +242,19 @@ static int __tdx_reclaim_page(hpa_t pa)
>   		pr_tdx_error(TDH_PHYMEM_PAGE_RECLAIM, err, &out);
>   		return -EIO;
>   	}
> +	/* out.r8 == tdx sept page level */
> +	WARN_ON_ONCE(out.r8 != pg_level_to_tdx_sept_level(level));
>   
>   	return 0;
>   }
>   
> -static int tdx_reclaim_page(hpa_t pa)
> +static int tdx_reclaim_page(hpa_t pa, enum pg_level level)
>   {
>   	int r;
>   
> -	r = __tdx_reclaim_page(pa);
> +	r = __tdx_reclaim_page(pa, level);
>   	if (!r)
> -		tdx_clear_page(pa);
> +		tdx_clear_page(pa, KVM_HPAGE_SIZE(level));
>   	return r;
>   }
>   
> @@ -265,7 +268,7 @@ static void tdx_reclaim_td_page(unsigned long td_page_pa)
>   	 * was already flushed by TDH.PHYMEM.CACHE.WB before here, So
>   	 * cache doesn't need to be flushed again.
>   	 */
> -	if (tdx_reclaim_page(td_page_pa))
> +	if (tdx_reclaim_page(td_page_pa, PG_LEVEL_4K))
>   		/*
>   		 * Leak the page on failure:
>   		 * tdx_reclaim_page() returns an error if and only if there's an
> @@ -497,7 +500,7 @@ void tdx_vm_free(struct kvm *kvm)
>   
>   	if (!kvm_tdx->tdr_pa)
>   		return;
> -	if (__tdx_reclaim_page(kvm_tdx->tdr_pa))
> +	if (__tdx_reclaim_page(kvm_tdx->tdr_pa, PG_LEVEL_4K))
>   		return;
>   	/*
>   	 * TDX module maps TDR with TDX global HKID.  TDX module may access TDR
> @@ -510,7 +513,7 @@ void tdx_vm_free(struct kvm *kvm)
>   		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err, NULL);
>   		return;
>   	}
> -	tdx_clear_page(kvm_tdx->tdr_pa);
> +	tdx_clear_page(kvm_tdx->tdr_pa, PAGE_SIZE);
>   
>   	free_page((unsigned long)__va(kvm_tdx->tdr_pa));
>   	kvm_tdx->tdr_pa = 0;
> @@ -1597,7 +1600,7 @@ static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
>   		 * The HKID assigned to this TD was already freed and cache
>   		 * was already flushed. We don't have to flush again.
>   		 */
> -		err = tdx_reclaim_page(hpa);
> +		err = tdx_reclaim_page(hpa, level);
>   		if (KVM_BUG_ON(err, kvm))
>   			return -EIO;
>   		tdx_unpin(kvm, pfn);
> @@ -1630,7 +1633,7 @@ static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
>   		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err, NULL);
>   		return -EIO;
>   	}
> -	tdx_clear_page(hpa);
> +	tdx_clear_page(hpa, PAGE_SIZE);
Should here be KVM_HPAGE_SIZE(level) instead of  PAGE_SIZE?

>   	tdx_unpin(kvm, pfn);
>   	return 0;
>   }
> @@ -1742,7 +1745,7 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
>   	 * already flushed. We don't have to flush again.
>   	 */
>   	if (!is_hkid_assigned(kvm_tdx))
> -		return tdx_reclaim_page(__pa(private_spt));
> +		return tdx_reclaim_page(__pa(private_spt), PG_LEVEL_4K);
>   
>   	/*
>   	 * free_private_spt() is (obviously) called when a shadow page is being

