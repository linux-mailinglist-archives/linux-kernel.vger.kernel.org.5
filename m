Return-Path: <linux-kernel+bounces-149045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0228A8AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAC91F23DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B93173347;
	Wed, 17 Apr 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmsjqYMA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97D12F398
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378195; cv=none; b=tdvQR+wDXHm2XPtUvDoGHKck+h8yVMEFatqfCP6+aKyvr8I9U7vyENVkbMNjC2sZaffNk1prSuWpNRVi42mvZRTFpcRxUPWaKqXYUroLGI7UYSFyweo6Jj3X3Oj/n8R3jH+YkZSce+k2ViKEs5gNwq15aWZtDdODZbZqV4WOVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378195; c=relaxed/simple;
	bh=R2l1ZeH0OnlAnrLzHllHETe2H+SRG6Gp8kS6kvYsz94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7sPHvMIrtVs+C/gmrkByjcPnckMwecU1PyTa2Cah/fH0n1aGKKOFxdAIPt/FPo8UVNhLLmfQ72P7Lu1+27P3nQV2e7II/oBrHj5wMiXn89p1TiAY57fJC9cqdpKXD/0hTInyVDTsYQd0x93P0awJV7r6msxpAin7tAnAFvSO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmsjqYMA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713378194; x=1744914194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2l1ZeH0OnlAnrLzHllHETe2H+SRG6Gp8kS6kvYsz94=;
  b=VmsjqYMAbRlC/MkPquqh7R9JbnoWtzD2ThqrOo26XBMdkMw5PXgaGXt3
   GaKCD1IuGLYTrAHtFeROymQtYQdf2pvzEeixhnuDgCU+MpP5zENyjtT1z
   IyBqW+c3I24Lzq/5xvI2AZuyVmvYXXdZ5GPhVSjBZ1EzYshEjkKYemxWV
   USFHwrv+EKYtY/l44TFV6CBDrWcAgr0L7KPtjFgFG0xjno7uG9jHg5ggR
   k2NaqUjWVqZvlG6ryQl0ClDclibvDCnvf7TE1nt2OB4nxk+j56g6xoVuQ
   ENlaHCEF3HVzoQwv7HjbgyhAW22ekpk3dFV382eVGzdlACDBRzdJ886yF
   w==;
X-CSE-ConnectionGUID: V5i9ho+eQ6S25KKoAG6F6w==
X-CSE-MsgGUID: gfiBuVB8SE+9YkdjIRpIAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20280303"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20280303"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 11:23:13 -0700
X-CSE-ConnectionGUID: PP5V9A0jS5CTwoa2Tf0YkA==
X-CSE-MsgGUID: 7HFXRc2qRcibeTCnUNnFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22785138"
Received: from kglossop-mobl.amr.corp.intel.com (HELO [10.209.94.180]) ([10.209.94.180])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 11:23:12 -0700
Message-ID: <4e7023aa-64df-454b-8fb3-cd02fc600865@linux.intel.com>
Date: Wed, 17 Apr 2024 11:23:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Preserve shared bit on mprotect()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com
Cc: hpa@zytor.com, seanjc@google.com, elena.reshetova@intel.com,
 rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Chris Oo <cho@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240412191247.369841-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240412191247.369841-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/12/24 12:12 PM, Kirill A. Shutemov wrote:
> The TDX guest platform takes one bit from the physical address to
> indicate if the page is shared (accessible by VMM). This bit is not part
> of the physical_mask and is not preserved during mprotect(). As a
> result, the 'shared' bit is lost during mprotect() on shared mappings.
>
> _COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
> during modification. AMD includes 'sme_me_mask' in the define to
> preserve the 'encrypt' bit.
>
> To cover both Intel and AMD cases, include 'cc_mask' in
> _COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to support TDX guests")
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Chris Oo <cho@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/include/asm/pgtable_types.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 3f648ffdfbe5..7dd2fdfacff3 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -148,7 +148,7 @@
>  #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
>  				 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
>  				 _PAGE_DIRTY_BITS | _PAGE_SOFT_DIRTY |	\
> -				 _PAGE_DEVMAP | _PAGE_ENC | _PAGE_UFFD_WP)
> +				 _PAGE_DEVMAP | _PAGE_CC | _PAGE_UFFD_WP)
>  #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
>  #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
>  
> @@ -173,6 +173,7 @@ enum page_cache_mode {
>  };
>  #endif
>  
> +#define _PAGE_CC		(_AT(pteval_t, cc_mask))
>  #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
>  
>  #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


