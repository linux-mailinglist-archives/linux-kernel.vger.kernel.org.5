Return-Path: <linux-kernel+bounces-119237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BAC88C603
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C123B230A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C713C694;
	Tue, 26 Mar 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXhCVKPG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884B1F168
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464969; cv=none; b=Q07gmWLxzMusJuSdEYieVMooXXQC/M0nlGBnUwrqC1b1eWYhJv+glcJIKporQFFf8jUvJ1qWPXhgz9hb5scTxw97l5UhjP7NYec4jBamNjLzJpOJPS8/r8BL6oR4oF7M+HEhdBTHSanCLjNQGStKBmJXGhilFt7PbzjGayydZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464969; c=relaxed/simple;
	bh=0oZ5uc7P0ieQKv289+T9IsmOebYTJ3njj0ylOmodXn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTo/rkV9ZCYveDkRyxSL8OMtb8dgZchCz5hegA7IMa13zo3LK0HshIpSFsmz+ijczNRXxoUl6CZd4QeFvz6pFJwE2h2K1GYYM17sP5kH3qknLimiF9I9fkSYu69CCh221rYp6GtfR6lkvhogKkS47kVey/ihs00B0P4WmxnnIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXhCVKPG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711464967; x=1743000967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0oZ5uc7P0ieQKv289+T9IsmOebYTJ3njj0ylOmodXn8=;
  b=UXhCVKPGmW1FT4LTNmPCOpWh4CM24qCPQhxwBVNHVdNIdkWr1hboPbdL
   4sxFrKYB7hS3BttUlUgL3eWf2koFg34hoRqQAVQe8zsFhBcLuEcykVyPl
   ymn/uqVeeppIoZBeKyF+KUiiZMC2Ds1uxl93Gtr+Ddrti0lI6Jk3hrFuo
   BMLe6I/SIXnKKuomOo8cLlJiKF3IBLxaQfCVioreu95G3xkCeCmP5nYSV
   D0ukd1fffzRtGBWs0XuhTWKK0Up1oXS78mv41kK5NSfIAjiMc2HvZ/+W4
   3Xvgax/xlIrq2aVSr2y/ZTM7qAkwdJ2woMNy+qRIF+lZe6482ZY83OZNw
   Q==;
X-CSE-ConnectionGUID: Lva2PbXSTlW21h9zxXcpWA==
X-CSE-MsgGUID: 8y+HiBzGT5+5BOenZKr7cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6458569"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6458569"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20531878"
Received: from pwimalas-mobl.amr.corp.intel.com (HELO [10.251.11.118]) ([10.251.11.118])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:56:05 -0700
Message-ID: <55b3f9e3-8bed-4f37-8c1d-cde5e332f1ba@linux.intel.com>
Date: Tue, 26 Mar 2024 07:56:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] x86/tdx: Introduce tdg_vm_wr()
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com
Cc: hpa@zytor.com, seanjc@google.com, elena.reshetova@intel.com,
 rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
 <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/25/24 3:46 AM, Kirill A. Shutemov wrote:
> Add a helper function to write to a TD-scope metadata field and use it
> to set NOTIFY_ENABLES.
>
> The helper function will be paired with tdg_vm_rd() and will be used to
> manipulate other metadata fields, not just NOTIFY_ENABLES.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 59776ce1c1d7..4fb36e5c4e80 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -77,6 +77,20 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
>  
> +static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
> +{
> +	struct tdx_module_args args = {
> +		.rdx = field,
> +		.r8 = value,
> +		.r9 = mask,
> +	};
> +
> +	tdcall(TDG_VM_WR, &args);
> +
> +	/* Old value */
> +	return args.r8;
> +}
> +
>  /**
>   * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
>   *                           subtype 0) using TDG.MR.REPORT TDCALL.
> @@ -902,10 +916,6 @@ static void tdx_kexec_unshare_mem(void)
>  
>  void __init tdx_early_init(void)
>  {
> -	struct tdx_module_args args = {
> -		.rdx = TDCS_NOTIFY_ENABLES,
> -		.r9 = -1ULL,
> -	};
>  	u64 cc_mask;
>  	u32 eax, sig[3];
>  
> @@ -924,7 +934,7 @@ void __init tdx_early_init(void)
>  	cc_set_mask(cc_mask);
>  
>  	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
> -	tdcall(TDG_VM_WR, &args);
> +	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
>  
>  	/*
>  	 * All bits above GPA width are reserved and kernel treats shared bit

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


