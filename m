Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECED37EDB43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbjKPFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjKPFgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:36:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55AA1B5;
        Wed, 15 Nov 2023 21:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700112980; x=1731648980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fuC6+pvZgDKviHFm6ej6qRlimEBkhOaIoues8kO0H4I=;
  b=jN+SNyhHAmaCS5SJn+jAe/m8WLIC9CmOq06ljchovTjBO8VFtMMibuS4
   uuYiBBjyTtaTRTH9ss3NVUch8Y+A3VWpc1UQ5bG5nTjzKCXYA+LnE9soc
   uiFbyk7XOHJ1YqksJ7+QgZp+cyppuxwbIdWoBCUgcVu6r1rGlDBmkzqM+
   1hPCm338po3E8OQFeI2UW3vKZnAgyfNmEVPPWzR03Pwv2G6hjVDsSFRr/
   Jju9Fw4GESK67sSwAUPYbexOBNx4anJQwT7ItY5JTWQEzLS9jZ4hReJ8h
   thkbjH4RIAFVn6f/WTQi0JGeWDFsEEz2q+o2MTnKu4nlejoKI1OFZWV2M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457513009"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="457513009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="715093707"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="715093707"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.10.126]) ([10.238.10.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:36:16 -0800
Message-ID: <2b61cda6-4d8f-42d2-8a5e-25c90365602e@linux.intel.com>
Date:   Thu, 16 Nov 2023 13:36:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/16] KVM: TDX: Pass page level to cache flush before
 TDX SEAMCALL
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
 <c73b5d5f902bb6d21a784bed2904fc1860aaf571.1699368363.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <c73b5d5f902bb6d21a784bed2904fc1860aaf571.1699368363.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> tdh_mem_page_aug() will support 2MB large page in the near future.  Cache
> flush also needs to be 2MB instead of 4KB in such cases.  Introduce a
> helper function to flush cache with page size info in preparation for large
> pages.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>

Nit: About the shortlog, is it clearer to say "Flush cache for a page 
based on page size before TDX SEAMCALL"?

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>   arch/x86/kvm/vmx/tdx_ops.h | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/tdx_ops.h b/arch/x86/kvm/vmx/tdx_ops.h
> index fd73a1731bf8..e726102d3523 100644
> --- a/arch/x86/kvm/vmx/tdx_ops.h
> +++ b/arch/x86/kvm/vmx/tdx_ops.h
> @@ -6,6 +6,7 @@
>   
>   #include <linux/compiler.h>
>   
> +#include <asm/pgtable_types.h>
>   #include <asm/archrandom.h>
>   #include <asm/cacheflush.h>
>   #include <asm/asm.h>
> @@ -62,6 +63,11 @@ static inline u64 tdx_seamcall(u64 op, u64 rcx, u64 rdx, u64 r8, u64 r9,
>   void pr_tdx_error(u64 op, u64 error_code, const struct tdx_module_args *out);
>   #endif
>   
> +static inline void tdx_clflush_page(hpa_t addr, enum pg_level level)
> +{
> +	clflush_cache_range(__va(addr), KVM_HPAGE_SIZE(level));
> +}
> +
>   /*
>    * TDX module acquires its internal lock for resources.  It doesn't spin to get
>    * locks because of its restrictions of allowed execution time.  Instead, it
> @@ -94,21 +100,21 @@ static inline u64 tdx_seamcall_sept(u64 op, u64 rcx, u64 rdx, u64 r8, u64 r9,
>   
>   static inline u64 tdh_mng_addcx(hpa_t tdr, hpa_t addr)
>   {
> -	clflush_cache_range(__va(addr), PAGE_SIZE);
> +	tdx_clflush_page(addr, PG_LEVEL_4K);
>   	return tdx_seamcall(TDH_MNG_ADDCX, addr, tdr, 0, 0, NULL);
>   }
>   
>   static inline u64 tdh_mem_page_add(hpa_t tdr, gpa_t gpa, hpa_t hpa, hpa_t source,
>   				   struct tdx_module_args *out)
>   {
> -	clflush_cache_range(__va(hpa), PAGE_SIZE);
> +	tdx_clflush_page(hpa, PG_LEVEL_4K);
>   	return tdx_seamcall_sept(TDH_MEM_PAGE_ADD, gpa, tdr, hpa, source, out);
>   }
>   
>   static inline u64 tdh_mem_sept_add(hpa_t tdr, gpa_t gpa, int level, hpa_t page,
>   				   struct tdx_module_args *out)
>   {
> -	clflush_cache_range(__va(page), PAGE_SIZE);
> +	tdx_clflush_page(page, PG_LEVEL_4K);
>   	return tdx_seamcall_sept(TDH_MEM_SEPT_ADD, gpa | level, tdr, page, 0, out);
>   }
>   
> @@ -126,21 +132,21 @@ static inline u64 tdh_mem_sept_remove(hpa_t tdr, gpa_t gpa, int level,
>   
>   static inline u64 tdh_vp_addcx(hpa_t tdvpr, hpa_t addr)
>   {
> -	clflush_cache_range(__va(addr), PAGE_SIZE);
> +	tdx_clflush_page(addr, PG_LEVEL_4K);
>   	return tdx_seamcall(TDH_VP_ADDCX, addr, tdvpr, 0, 0, NULL);
>   }
>   
>   static inline u64 tdh_mem_page_relocate(hpa_t tdr, gpa_t gpa, hpa_t hpa,
>   					struct tdx_module_args *out)
>   {
> -	clflush_cache_range(__va(hpa), PAGE_SIZE);
> +	tdx_clflush_page(hpa, PG_LEVEL_4K);
>   	return tdx_seamcall_sept(TDH_MEM_PAGE_RELOCATE, gpa, tdr, hpa, 0, out);
>   }
>   
>   static inline u64 tdh_mem_page_aug(hpa_t tdr, gpa_t gpa, hpa_t hpa,
>   				   struct tdx_module_args *out)
>   {
> -	clflush_cache_range(__va(hpa), PAGE_SIZE);
> +	tdx_clflush_page(hpa, PG_LEVEL_4K);
>   	return tdx_seamcall_sept(TDH_MEM_PAGE_AUG, gpa, tdr, hpa, 0, out);
>   }
>   
> @@ -157,13 +163,13 @@ static inline u64 tdh_mng_key_config(hpa_t tdr)
>   
>   static inline u64 tdh_mng_create(hpa_t tdr, int hkid)
>   {
> -	clflush_cache_range(__va(tdr), PAGE_SIZE);
> +	tdx_clflush_page(tdr, PG_LEVEL_4K);
>   	return tdx_seamcall(TDH_MNG_CREATE, tdr, hkid, 0, 0, NULL);
>   }
>   
>   static inline u64 tdh_vp_create(hpa_t tdr, hpa_t tdvpr)
>   {
> -	clflush_cache_range(__va(tdvpr), PAGE_SIZE);
> +	tdx_clflush_page(tdvpr, PG_LEVEL_4K);
>   	return tdx_seamcall(TDH_VP_CREATE, tdvpr, tdr, 0, 0, NULL);
>   }
>   

