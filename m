Return-Path: <linux-kernel+bounces-98104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA50A877531
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C7A1C2095B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D781097B;
	Sun, 10 Mar 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaS+EMht"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E08480
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710038989; cv=none; b=Mp6ntNFNEk5FEaZvZMEMw3Tcx9zHyFhu4v5gXfhoIXW7QRAr6oekssxMXn5gQiMyIaIOKMoRnIDQLsMftOzw5yQuZ8Dy6d30owfKBJkBC7quw2BkB0Lo0l5O8NpQ857MBHK0wzslkTgoMqzvi2dqFfihAd97rP83C5MKFQfpmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710038989; c=relaxed/simple;
	bh=WgLB+opCEDzMviIFJRketQCowWRnc73bSza5E3/T0ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4x0JJ380RfIOpfkemYLw3Z9eaWpakHT6kG0Y+0JDi1TXALQKmjkypvFHtxL7TPsKWKdwBbYG7NSq/nN7Y8s2qXZc4LKGv44F2OkRxPjRruSJuQkOjr5pE5ek6EAoJq/XWb8H5XPhFlOchUtHGxnKXbB90sJCt/Ws2V3UCcr6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaS+EMht; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710038987; x=1741574987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WgLB+opCEDzMviIFJRketQCowWRnc73bSza5E3/T0ec=;
  b=gaS+EMhtqdffzGngvDG5J5KPZqz0x3MERCE3xtnYWEb1SLd33sYBFcxl
   G1tRZelxVHjd4XR2ZQx2EvK+ArDLpvhr5nMe+rKHGxImt/HY1B/nfwR2T
   /joJjfEvKxzt0ptNohVMbV1jyY86hHfaN5fWEPuzlzOW68g0TXe6reH54
   6IKWT+9+zXWCvhUlXQBjmTjanoq8cZ6o0nP2pqbWRuLrOPycrYspuuC0a
   Zu859/ifntFSm3QR67IdIiis01iR5HlAv/36K05+Fo83q+K4tvLY0pE38
   Ffp5iD91MB9Y0phmF54ZfMN8L6UqccPm+iHaDoENkx4DLy0RP4wkcI6bc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="8549010"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="8549010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 18:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="15432216"
Received: from chengyin-mobl.amr.corp.intel.com (HELO [10.209.27.224]) ([10.209.27.224])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 18:49:46 -0800
Message-ID: <7c8e8216-cb49-4b5a-a547-5e807fa96214@linux.intel.com>
Date: Sat, 9 Mar 2024 18:49:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com
Cc: hpa@zytor.com, seanjc@google.com, ele.reshetova@intel.com,
 rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
 <20240309210230.239045-3-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240309210230.239045-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/9/24 1:02 PM, Kirill A. Shutemov wrote:
> Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
> there.
>
> The function will be extended to adjust TD configuration.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 5ffe5ef99536..afdaf46cabb9 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -181,7 +181,7 @@ static void __noreturn tdx_panic(const char *msg)
>  		__tdx_hypercall(&args);
>  }
>  
> -static void tdx_parse_tdinfo(u64 *cc_mask)
> +static void tdx_setup(u64 *cc_mask)
>  {
>  	struct tdx_module_args args = {};
>  	unsigned int gpa_width;
> @@ -206,6 +206,9 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
>  	gpa_width = args.rcx & GENMASK(5, 0);
>  	*cc_mask = BIT_ULL(gpa_width - 1);
>  
> +	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
> +	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
> +
>  	/*
>  	 * The kernel can not handle #VE's when accessing normal kernel
>  	 * memory.  Ensure that no #VE will be delivered for accesses to
> @@ -930,11 +933,11 @@ void __init tdx_early_init(void)
>  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  
>  	cc_vendor = CC_VENDOR_INTEL;
> -	tdx_parse_tdinfo(&cc_mask);
> -	cc_set_mask(cc_mask);
>  
> -	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
> -	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
> +	/* Configure the TD */
> +	tdx_setup(&cc_mask);
> +
> +	cc_set_mask(cc_mask);
>  
>  	/*
>  	 * All bits above GPA width are reserved and kernel treats shared bit

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


