Return-Path: <linux-kernel+bounces-130221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A240D89759E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C7028D470
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B131514DB;
	Wed,  3 Apr 2024 16:51:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60E135A75
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163112; cv=none; b=GfYX3BoBTGU0RBFZL/SI9nGG850P52wL8tOmoEDqOHmoMExWWiZpaCve91h7IkDHuhv929+PRHQWip4W6aSZSb67lpuNqOm6NDtaTkJ8dopq123tiC45CPaaWCuBTqmtpFP6dkLVU15C7WeGIlRfLxkzo4k56xhh3nYRb1yhNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163112; c=relaxed/simple;
	bh=TGTpo9irm2EBdH+a4jyLepfc/WLlfopDjIp/3xE4rbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2Nskxqn2csRs5LHZF5qUMCOUWgeSBXlYJyqcazOad5Xq7qWEPY4OKkLKxSRAjGpTkTZfWywlYS8aF1hVBjNvOzZRC8ddzirJSlK1excgF3rYNujtvylIU3aMDZWIkVU565nS2M7S8YLaoWG8VyXashWDJp1DKP+bjC4vFRY7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F23F1007;
	Wed,  3 Apr 2024 09:52:21 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 263C83F64C;
	Wed,  3 Apr 2024 09:51:48 -0700 (PDT)
Date: Wed, 3 Apr 2024 17:51:44 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, anil.s.keshavamurthy@intel.com,
	aou@eecs.berkeley.edu, davem@davemloft.net,
	linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
	naveen.n.rao@linux.ibm.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH v2 1/4] arm64: patching: always use fixmap
Message-ID: <Zg2JIFNy8IgwIyUV@FVFF77S0Q05N>
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-2-mark.rutland@arm.com>
 <D0AMI3962WW0.3JKFCSUXVSSVL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0AMI3962WW0.3JKFCSUXVSSVL@kernel.org>

On Wed, Apr 03, 2024 at 07:20:31PM +0300, Jarkko Sakkinen wrote:
> On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> > For historical reasons, patch_map() won't bother to fixmap non-image
> > addresses when CONFIG_STRICT_MODULE_RWX=n, matching the behaviour prior
> > to the introduction of CONFIG_STRICT_MODULE_RWX. However, as arm64
> > doesn't select CONFIG_ARCH_OPTIONAL_KERNEL_RWX, CONFIG_MODULES implies
> > CONFIG_STRICT_MODULE_RWX, so any kernel built with module support will
> > use the fixmap for any non-image address.
> 
> Not familiar with the config flag but I'd guess it is essentially
> w^x enforcement right for the sections?

Essentially, yes.

> > Historically we only used patch_map() for the kernel image and modules,
> > but these days its also used by BPF and KPROBES to write to read-only
> > pages of executable text. Currently these both depend on CONFIG_MODULES,
> > but we'd like to change that in subsequent patches, which will require
> > using the fixmap regardless of CONFIG_STRICT_MODULE_RWX.
> >
> > This patch changes patch_map() to always use the fixmap, and simplifies
> > the logic:
> >
> > * Use is_image_text() directly in the if-else, rather than using a
> >   temporary boolean variable.
> >
> > * Use offset_in_page() to get the offset within the mapping.
> >
> > * Remove uintaddr and cast the address directly when using
> >   is_image_text().
> >
> > For kernels built with CONFIG_MODULES=y, there should be no functional
> > change as a result of this patch.
> >
> > For kernels built with CONFIG_MODULES=n, patch_map() will use the fixmap
> > for non-image addresses, but there are no extant users with non-image
> > addresses when CONFIG_MODULES=n, and hence there should be no functional
> > change as a result of this patch alone.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/patching.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > Catalin, Will, this is a prerequisite for the final two patches in the
> > series. Are you happy for this go via the tracing tree?
> >
> > Mark.
> >
> > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> > index 2555349303684..f0f3a2a82ca5a 100644
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
> > @@ -30,20 +30,16 @@ static bool is_image_text(unsigned long addr)
> >  
> >  static void __kprobes *patch_map(void *addr, int fixmap)
> >  {
> > -	unsigned long uintaddr = (uintptr_t) addr;
> > -	bool image = is_image_text(uintaddr);
> >  	struct page *page;
> >  
> > -	if (image)
> > +	if (is_image_text((unsigned long)addr))
> >  		page = phys_to_page(__pa_symbol(addr));
> > -	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> > -		page = vmalloc_to_page(addr);
> >  	else
> > -		return addr;
> > +		page = vmalloc_to_page(addr);
> >  
> >  	BUG_ON(!page);
> >  	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> > -			(uintaddr & ~PAGE_MASK));
> > +					 offset_in_page(addr));
> 
> nit: could be a single line but i guess it is up to the taste (and
> subsystem maintainer). I.e. checkpatch will allow it at least.
> 
> I don't mind it too much just mentioning for completeness.

At that point it goes to 93 chars long, and I stuck with the existing line
wrapping at 80 chars. I'd rather have a temporary 'phys_addr_t phys' variable
and do:

	phys = page_to_phys(page) + offset_in_page(addr);
	return (void *)set_fixmap(fixmap, phys);

.. but I'll leave this as-is for now.

> >  }
> >  
> >  static void __kprobes patch_unmap(int fixmap)
> 
> If my assumption about the config flag holds this makes sense:
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.rg>

Thanks! I assume that should be "kernel.org", with an 'o' ;)

Mark.

