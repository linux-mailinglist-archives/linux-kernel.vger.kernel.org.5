Return-Path: <linux-kernel+bounces-45985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF32B8438AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421CAB261B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B125731A;
	Wed, 31 Jan 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRxQFIrn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874E57895
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689238; cv=none; b=STkLzH3poqAM+ycM1uRtCEza5W4bhJID9M7Mr/XpJMwgOghAuf4mDwjV1h7n6JlYlS3+SWT22G6sSAbpBwWRRLKGmArmGlVQPMzwoWuKuwYUWiog8xFN2GhFTnnoxuAiaMUpEJw3BwFVUTlUfuLAd/PZgV5nHB/CQTi3ofSw7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689238; c=relaxed/simple;
	bh=SGzk9JA5A4WdBx6j64XS/jDdmN0WOY6psDzBiqQDpNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz45pmBBeRIXaGZmhDk1vNhefd+tzcxnYe4AYBHApzx4wwEn5NSpFf49cSwbAdub+NznC5ZaEI1cBimtp/Y6PQCfdaPj3cRepTpbZIOoSMOostqvsO45+MDJXUOwOjBfKuBVwpPejdP0BVn13swUSbEuv8k/zauiGUjnCz9XmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRxQFIrn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689238; x=1738225238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGzk9JA5A4WdBx6j64XS/jDdmN0WOY6psDzBiqQDpNc=;
  b=iRxQFIrnH4IFoaWsM9BdI1qOQ2RvYKorE0hGBsYDw97EnJe9tTJuDoDF
   yldgXjW08t7JXK/trzvnWqfy9dyOm984wHmVKRZ95jVuSdGH+bPgjSJ43
   2d7CEWzIgHOQiNDzQwVxbco/NlyXhy2pf7Agf4QMfgxrtqHIGJw+Gf6+U
   QtPlflGrTeWOVoB82azGDykvqBKBQdI9p0HS3uIdhLwwuBTNnzglmne7w
   TzOpkxOs8HvYQZNP07TN4EGvc9A4xMPnAukPIOao/ojQ/6gCxpgp02cxq
   a163HC+WsbMq7rO09i2+Zpmtaz9XQ2AIq79rbGLhMYuWSg3sSyMQvMfAA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22041371"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="22041371"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:20:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738021278"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="738021278"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2024 00:20:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 146D22D5; Wed, 31 Jan 2024 10:20:29 +0200 (EET)
Date: Wed, 31 Jan 2024 10:20:28 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>, 
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>, 
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [PATCH v3 1/2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <4ljfvg7c23g2wx4hcqz6x6tx7uvp6fffayqvu4ptsmfqajlujr@zngokbd2awma>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-2-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130220845.1978329-2-kevinloughlin@google.com>

On Tue, Jan 30, 2024 at 10:08:44PM +0000, Kevin Loughlin wrote:
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 359ada486fa9..b65e66ee79c4 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -17,6 +17,20 @@
>  
>  #include <asm/bootparam.h>
>  
> +/*
> + * Like the address operator "&", evaluates to the address of a LHS variable
> + * "var", but also enforces the use of RIP-relative logic. This macro can be
> + * used to safely access global data variables prior to kernel relocation.
> + */
> +#define RIP_RELATIVE_ADDR(var)		\
> +({					\
> +	void *rip_rel_ptr;		\
> +	asm ("lea "#var"(%%rip), %0"	\
> +		: "=r" (rip_rel_ptr)	\
> +		: "p" (&var));		\
> +	rip_rel_ptr;			\
> +})
> +

I don't think it is the right place for the macro. The next patch uses for
things unrelated to memory encryption.

> @@ -239,14 +244,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	 */
>  
>  	next_pgt_ptr = fixup_pointer(&next_early_pgt, physaddr);
> -	pud = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
> -	pmd = fixup_pointer(early_dynamic_pgts[(*next_pgt_ptr)++], physaddr);
> +	early_dynamic_pgts_ptr = fixup_pointer(early_dynamic_pgts, physaddr);
> +	pud = (pudval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
> +	pmd = (pmdval_t *) early_dynamic_pgts_ptr[(*next_pgt_ptr)++];
>  

This change doesn't belong to this patch. Maybe move it into the next
patch and combine with removing fixup_pointer().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

