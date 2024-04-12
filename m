Return-Path: <linux-kernel+bounces-142404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5F8A2B25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D235928CCF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB2502AA;
	Fri, 12 Apr 2024 09:25:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1E50299
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913925; cv=none; b=rBHoijx8rrA3wb46nGkbH19RTUeXV2r2EbQoPHqPtDaIcZzeFZcjKNI3hJwBiD+QM9XS48kWam0ku7FNyKNIHxhehIjC1gOacXRjdWKct99kA+GQXbQIFA2fm5p5cCF4sUCWVSgFslV73HaT+aiwreqf/URsLlCA3JIlirqBQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913925; c=relaxed/simple;
	bh=Ms333QPBPkXGEfuU7DWm2MeYtBor2EJJghz3FR3A02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCdb77DFuB03/SMkHP0gABnrkaNnJItU8Uf48JwXfZBXrtPx2mYA+f4rqUkfJjv18kKVTb6XzRvgJqOIwMq3EBR7pL9pKpea0ClRjuLm5tsUNs5pZPzu5sg5LJ9S4V9WTPwKsM8xgZflChF5MjT/y2M5LXQ8wNpHkjZfmIvemrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A520E339;
	Fri, 12 Apr 2024 02:25:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.17.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A61953F64C;
	Fri, 12 Apr 2024 02:25:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:25:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: Re: [PATCH v2 3/4] arm64: mm: Don't remap pgtables for allocate vs
 populate
Message-ID: <Zhj9_HFVVxEZqdnB@FVFF77S0Q05N>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
 <37336367-f876-4429-a8a6-f887fc7f69ee@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37336367-f876-4429-a8a6-f887fc7f69ee@arm.com>

On Fri, Apr 12, 2024 at 08:53:18AM +0100, Ryan Roberts wrote:
> Hi Mark,
> 
> [...]
> 
> > Does something like the below look ok to you? The trade-off performance-wise is
> > that late uses will still use the fixmap, and will redundantly zero the tables,
> > but the logic remains fairly simple, and I suspect the overhead for late
> > allocations might not matter since the bulk of late changes are non-allocating.

> > @@ -303,12 +301,18 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> >  			pudval |= PUD_TABLE_PXN;
> >  		BUG_ON(!pgtable_alloc);
> >  		pmd_phys = pgtable_alloc(PMD_SHIFT);
> > +
> > +		pmdp = pmd_set_fixmap(pmd_phys);
> > +		init_clear_pgtable(pmdp);
> > +
> >  		__pud_populate(pudp, pmd_phys, pudval);
> >  		pud = READ_ONCE(*pudp);
> > +	} else {
> > +		pmdp = pmd_set_fixmap(pud_page_paddr(pud));
> >  	}
> >  	BUG_ON(pud_bad(pud));
> >  
> > -	pmdp = pmd_set_fixmap_offset(pudp, addr);
> > +	pmdp += pmd_index(addr);
> >  	do {
> >  		pgprot_t __prot = prot;
> >  
> > @@ -345,12 +349,18 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
> >  			p4dval |= P4D_TABLE_PXN;
> >  		BUG_ON(!pgtable_alloc);
> >  		pud_phys = pgtable_alloc(PUD_SHIFT);
> > +
> > +		pudp = pud_set_fixmap(pud_phys);
> > +		init_clear_pgtable(pudp);
> > +
> >  		__p4d_populate(p4dp, pud_phys, p4dval);
> >  		p4d = READ_ONCE(*p4dp);
> > +	} else {
> > +		pudp = pud_set_fixmap(p4d_page_paddr(p4d));
> 
> With this change I end up in pgtable folding hell. pXX_set_fixmap() is defined
> as NULL when the level is folded (and pXX_page_paddr() is not defined at all).
> So it all compiles, but doesn't boot.

Sorry about that; I had not thought to check the folding logic when hacking
that up.

> I think the simplest approach is to follow this pattern:
> 
> ----8<----
> @@ -340,12 +338,15 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long
> addr, unsigned long end,
>                         p4dval |= P4D_TABLE_PXN;
>                 BUG_ON(!pgtable_alloc);
>                 pud_phys = pgtable_alloc(PUD_SHIFT);
> +               pudp = pud_set_fixmap(pud_phys);
> +               init_clear_pgtable(pudp);
> +               pudp += pud_index(addr);
>                 __p4d_populate(p4dp, pud_phys, p4dval);
> -               p4d = READ_ONCE(*p4dp);
> +       } else {
> +               BUG_ON(p4d_bad(p4d));
> +               pudp = pud_set_fixmap_offset(p4dp, addr);
>         }
> -       BUG_ON(p4d_bad(p4d));
> 
> -       pudp = pud_set_fixmap_offset(p4dp, addr);
>         do {
>                 pud_t old_pud = READ_ONCE(*pudp);
> ----8<----
> 
> For the map case, we continue to use pud_set_fixmap_offset() which is always
> defined (and always works correctly).
> 
> Note also that the previously unconditional BUG_ON needs to be prior to the
> fixmap call to be useful, and its really only valuable in the map case because
> for the alloc case we are the ones setting the p4d so we already know its not
> bad. This means we don't need the READ_ONCE() in the alloc case.
> 
> Shout if you disagree.

That looks good, and I agree with the reasoning here.

Thanks for working on this!

Mark.

