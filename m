Return-Path: <linux-kernel+bounces-117402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5C88AAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043381F3E4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C7F13D887;
	Mon, 25 Mar 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjbATJsz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8B80607
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381440; cv=none; b=QdY637e3mcUBTWYd9fsIqqUHkcHQ3WaA/UkZWHGxqr28d4Si4zoq0FKUvwPwO1hEFmfdDx5pxVpxsrlfxabvGlEiuNMzLTPJyZStbKAYNE5QVKR4P4Ddk/eadO6zMC0wChwDZyE64tERDiwvQBd84/BmVJieWZ3WSR4OXwTSetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381440; c=relaxed/simple;
	bh=kHE0zX1DU3TTa6UNYPRNZ7cQSTALakcksyGuk61DVw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFF03C1B/t0s1W/EKAFnk+CJ852pBBSucbojYnNCFOoGPODoKghVPd+bXBAA5C5kQN/RPed7PctWarIgC8JqqYVmV+IMQ1t4hIPEebFomxAASPARokeR+rkwYdWkZ3mzgmUBeo9KBGMWCIdGPRq2SQAZKFqByvktG90B6Yd76Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjbATJsz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381439; x=1742917439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kHE0zX1DU3TTa6UNYPRNZ7cQSTALakcksyGuk61DVw0=;
  b=gjbATJszyTrKpOy683b2dzwyrrHkeEqQLM/qa63zRcM0GgJMcufk1lwJ
   +5QVsAKJ2KY7ahUKIqaIIesJ6yDrpfFYZtDJSZYrAU9PMW39c04XVf4aM
   bdobzUQxdR90ZEDKNbn7k3HlQcIjk697wrzXPgNZ/dpAKiuIKokc8sgFL
   yacDtU3l4lQVnD+k6j9av3uW51W/1gn77ugZeR0c9tkUuxuR0IjOwK8IZ
   Vq7XRloEpMJHDPQjO+HRHreKp5UVya5uQrLi2MW1ekZC6gaga6IQKSZPl
   KX+TaRxPj56kQzVh7bqYzEvcGNrwXPr48B15dv1wu466fVuL7JpssVKMN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23877008"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23877008"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15526038"
Received: from dvidmant-mobl.amr.corp.intel.com (HELO [10.209.80.233]) ([10.209.80.233])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:43:58 -0700
Message-ID: <f71223cb-2de9-4872-8a68-09eb43215789@linux.intel.com>
Date: Mon, 25 Mar 2024 08:43:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 08/17] x86/tdx: Account shared memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/25/24 3:39 AM, Kirill A. Shutemov wrote:
> The kernel will convert all shared memory back to private during kexec.
> The direct mapping page tables will provide information on which memory
> is shared.
>
> It is extremely important to convert all shared memory. If a page is
> missed, it will cause the second kernel to crash when it accesses it.
>
> Keep track of the number of shared pages. This will allow for
> cross-checking against the shared information in the direct mapping and
> reporting if the shared bit is lost.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 26fa47db5782..979891e97d83 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -38,6 +38,8 @@
>  
>  #define TDREPORT_SUBTYPE_0	0
>  
> +static atomic_long_t nr_shared;
> +
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  noinstr void __noreturn __tdx_hypercall_failed(void)
>  {
> @@ -821,6 +823,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
>  		return -EIO;
>  
> +	if (enc)
> +		atomic_long_sub(numpages, &nr_shared);
> +	else
> +		atomic_long_add(numpages, &nr_shared);
> +
>  	return 0;
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


