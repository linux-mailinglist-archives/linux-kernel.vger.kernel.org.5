Return-Path: <linux-kernel+bounces-157422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDE8B117A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597D61F2509B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10A16D4F1;
	Wed, 24 Apr 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edZxMeG2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D016C856
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981197; cv=none; b=m0QY8jeXnSaIoD60K6snnqfK0+MD1ZRhc3xEB7nU6ovXeqRbEI/pkAcliHoiCto+ho5z/BXC4RHDgZF6BmhKsWbtIzFjXZH1nnPOAYnXofspNUSOt6aVAX7iWQiVx/xJmAYv77lQD5T26AEKOvVo9ORyZEfOeNbmM6GjoZKYz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981197; c=relaxed/simple;
	bh=sniIh5L94+ZQ6TcyV6ml8f5Z+5dW6TFxPy2KpwdNpsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dedCXaH3DKNxQmi/GFZTxj41yDcuGfekfi3BqA0pCp05mC3NvXsN4fTfOCA6f/gIx0m878XhYHvn/Ad94UJRRD3GTRNZigK+jj1JhXHVRK2R2NNj/sOM+nJQybme2QyNsVbXLuUCFKZI6LmS63yR1Gb2cifuRa+YuOfuIDNN1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edZxMeG2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713981196; x=1745517196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sniIh5L94+ZQ6TcyV6ml8f5Z+5dW6TFxPy2KpwdNpsA=;
  b=edZxMeG2hB3jspKw6QcLPsqmXe/hv026CWOJ/rt2cpZl+NqTGwhDmVyi
   lAsCyDDiv6zIYg0QZo1FUCnrYF37TP3NKKfs9p2bF+Vc/o31kkirrvfD5
   RR/DbSriAIcDwKoM1+0BAUvYtxGn+3xc5QqF49GHr5Vy+XPt8HvDEElkb
   BCvBodfmzg7mgaqnRXwySsaQdlNmf86/KtR/cN2EB2Kj5ca7gtVRbfiwC
   G8mvQ1Xcbr/TM848Hm/DWnS1plCLeCv/s1/5GtfLWwj9o7ldHo0EWXqHb
   AwTTpXx2lL7QyjCIVWG55XgfKz3tuDuAYLLN4QQrksEccZR0Pil0M0nZA
   Q==;
X-CSE-ConnectionGUID: 9Y2E3HttQNyONS8GUWR+jQ==
X-CSE-MsgGUID: kkYvtgVWR9Wr17b3Pskseg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="35027493"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="35027493"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:53:01 -0700
X-CSE-ConnectionGUID: ojXDk/nSR3ycIlAo713KQw==
X-CSE-MsgGUID: IixcANJGQ7uhmzE7kRuSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29273147"
Received: from ttiasha-mobl1.amr.corp.intel.com (HELO [10.209.122.5]) ([10.209.122.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 10:53:01 -0700
Message-ID: <6ca837b8-f6eb-464c-9284-1c70f3a616a5@intel.com>
Date: Wed, 24 Apr 2024 10:53:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] x86/tdx: Introduce tdg_vm_wr()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, hpa@zytor.com,
 seanjc@google.com, elena.reshetova@intel.com, rick.p.edgecombe@intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
 <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

So, the text here should help me understand what is going on.  What it
tries to tell me should not be a literal rephrasing of the contents of
the diff.

This patch literally introduces a function called tdg_vm_wr().  The
subject adds precisely zero to what I can get from reading the diff.

How about:

	x86/tdx: Factor out TD metadata write tdcall

On 3/25/24 03:46, Kirill A. Shutemov wrote:
> Add a helper function to write to a TD-scope metadata field and use it
> to set NOTIFY_ENABLES.
> 
> The helper function will be paired with tdg_vm_rd() and will be used to
> manipulate other metadata fields, not just NOTIFY_ENABLES.

Ideally this would at least tell me what problem this is solving:

	The TDG_VM_WR seamcall is used to ask the TDX module to change
	some TD-specific VM configuration.  There is currently only one
	user in the kernel of this seamcall.  More will be added
	shortly.

.. and then the solution:

	Refactor to make way for more users of TDG_VM_WR who will need
	to modify other TD configuration values.

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


