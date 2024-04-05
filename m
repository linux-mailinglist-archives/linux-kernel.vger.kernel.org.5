Return-Path: <linux-kernel+bounces-133379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94E889A305
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD0528809B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04233171659;
	Fri,  5 Apr 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNqnRYxO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4355A4DC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336556; cv=none; b=efy4gs1sJ8aU3zsV+JwREIu9d5N9qoRwSFsopw9m873tgrzRvqvut1l5jkipBihJCUfUpqgdSzr67ra7Z+vXFriVKKL3nFKkVr5PlTe8bCWMcbU9lzHZedTueJ05WRi7uEVrukj6RKsSXUgZ4ojyKbIhkBI+PdARlf6jwBxwZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336556; c=relaxed/simple;
	bh=MOYV1921efHrJ07Pg46Tj17i+5Tr+D9vo4vTZzq2bUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIMOhTJKaxAvtFJmDdb9sK7J2Dlbv6tCQBvZWHPKxMfYHZXP98bEwyC00lcOM0Eq9EDvEnUowX3Rw1K/dBLtEO/j+V6w0JfD7qsHct5N9cRESLsrPTTXTeZncvneJBF03FLSRPz42X7PGqdWCWP/UDVDdXN66niiJsL1qGcCVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNqnRYxO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712336554; x=1743872554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MOYV1921efHrJ07Pg46Tj17i+5Tr+D9vo4vTZzq2bUc=;
  b=DNqnRYxO2A4Oc6X3AWTisNTEklcqfKIIq81OUn+jdzBLFZKFC2gNqiz5
   s7NKWN9ZQzdPbP6x2gPSA4LC1UPSzOOqsMKePYHdJQj1aIIypdTt7nC8b
   pwmintZZfzdjBxIJOq+OzoGomN2nSXNHPOR7tu7JjQoGyb8lrr7/T0Rju
   eaE95ferQ7RStrDQ46yDNUrMyTVtLwh0XQdZW6wqtTButnSwFfqzoipYb
   2kPMC4SwMU8IkID6ioxBJ29VNtUv4BsNQlc1uZf1l5Y+cQtvQPb7DGu/L
   KUsLNb0kGHsU6JltKiFlhrVdKbiG7tKotGoaKSGYFsFV4q+8AHh7ZmFFw
   g==;
X-CSE-ConnectionGUID: q6+TXZl0Rm6JcqlM3Wb4aw==
X-CSE-MsgGUID: px46xWotSRqdnre3nnxH5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="33075377"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="33075377"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:02:34 -0700
X-CSE-ConnectionGUID: ue9lL3lvQfORewbsYQn0Iw==
X-CSE-MsgGUID: mxkQdWVLS7uJsFH/c2LUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23941152"
Received: from twwright-mobl1.amr.corp.intel.com (HELO [10.209.65.212]) ([10.209.65.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:02:32 -0700
Message-ID: <c6e8a19b-e6a6-4fa0-81dc-d8747ba648c0@linux.intel.com>
Date: Fri, 5 Apr 2024 10:02:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <cover.1712270975.git.ashish.kalra@amd.com>
 <7ca8179d7671a149f2808d8d081b6e736eea4394.1712270976.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <7ca8179d7671a149f2808d8d081b6e736eea4394.1712270976.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/4/24 4:11 PM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> For kexec use case, need to use and stick to the EFI memmap passed
> from the first kernel via boot-params/setup data, hence,
> skip efi_arch_mem_reserve() during kexec.
>
> Additionally during SNP guest kexec testing discovered that EFI memmap
> is corrupted during chained kexec. kexec_enter_virtual_mode() during
> late init will remap the efi_memmap physical pages allocated in
> efi_arch_mem_reserve() via memblock & then subsequently cause random
> EFI memmap corruption once memblock is freed/teared-down.
>
> Suggested-by: Dave Young <dyoung@redhat.com>
> [Dave Young: checking the md attribute instead of checking the efi_setup]
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..2b65b3863912 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -255,15 +255,32 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	struct efi_memory_map_data data = { 0 };
>  	struct efi_mem_range mr;
>  	efi_memory_desc_t md;
> -	int num_entries;
> +	int num_entries, ret;
>  	void *new;
>  
> -	if (efi_mem_desc_lookup(addr, &md) ||
> -	    md.type != EFI_BOOT_SERVICES_DATA) {
> +	/*
> +	 * For kexec use case, we need to use the EFI memmap passed from the first
> +	 * kernel via setup data, so we need to skip this.
> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
> +	 * the efi_memmap physical pages allocated here via memboot & then
> +	 * subsequently cause random EFI memmap corruption once memblock is freed.
> +	 */
> +
> +	ret = efi_mem_desc_lookup(addr, &md);

Since you are not using ret, why not directly use if (efi_mem_desc_lookup(..))?

> +	if (ret) {
>  		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>  		return;
>  	}
>  
> +	if (md.type != EFI_BOOT_SERVICES_DATA) {
> +		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
> +		return;
> +	}
> +
> +	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
> +	if (md.attribute & EFI_MEMORY_RUNTIME)
> +		return;
> +
>  	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
>  		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
>  		return;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


