Return-Path: <linux-kernel+bounces-164230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D68B7AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4EC1F2276E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921EC129E9F;
	Tue, 30 Apr 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvyMEXnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2269152799
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489499; cv=none; b=pvjdnv0VMGzcMI5r2Po6SmZne9iZDmFnnSDHllbCseQ8/SwevoXFbGmZAFwdlNSrAxaBuVu4SI2qPVtUiSRn4nUVL/xCzHnTtXmoY/3SgHPGEt1KkELhOdPrdZqzvltTzm49jJ3C9/VnRL6BGrFbeegoRLKqV0ArHO203HmT1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489499; c=relaxed/simple;
	bh=IXTsCs1+m3zuge8TFFA6Qz3AAaG9om+XGkqrVy5RyR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJBtCEdJsMJ6nhCDFAS2XV3HoO2H6cuQnIImvTpT3fWRy+wQ+7Bnmu7A0OKtiCo9nU0+8+5H9jOteCe9jYQ9mSOGoSUJK9BsBZk8MAModlgxHN6xndCHSceldPBILlr0yuVctvBSL11wH3LICuj0JO7mhe5W0pYZrS3MchZoGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvyMEXnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E17C2BBFC;
	Tue, 30 Apr 2024 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714489499;
	bh=IXTsCs1+m3zuge8TFFA6Qz3AAaG9om+XGkqrVy5RyR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvyMEXnqDqtCtE4JAotOogiNGJOT76uOaNEyO1een2JsRk2efFHrUMD3QzcxXFyd2
	 HNaX+ktCAMWHjQpEKBeKlYc9JG9MVMP8rYUcEv+0gklcJ6pu+kgafdKy8cOVF+PY+g
	 +7idnIowqvJEvF1OymcSimiXU5QTwR3D5ICbRn9l6BgfYtgwDWIXMC39U570Gy63Yt
	 kR7AgE9xFrV7HuY3wddsSlhFNMQcKOofGj9rKVCOH7GypLyPXGuWwWA0N9eAx3eQJC
	 TJAtw/XmG0O2tarWeI+pmkVm41904lS1Bw6wwTmZE8Ouuqm75Qhqm+yldMnJE5onGe
	 pdIHHBepjfASg==
Date: Tue, 30 Apr 2024 16:04:53 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Message-ID: <20240430150453.GA14187@willie-the-truck>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com>
 <20240430133037.GA13848@willie-the-truck>
 <96fc0d1a-0c5f-4ca3-ad99-a64346990536@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fc0d1a-0c5f-4ca3-ad99-a64346990536@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Apr 30, 2024 at 03:02:21PM +0100, Ryan Roberts wrote:
> On 30/04/2024 14:30, Will Deacon wrote:
> > On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
> >> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> >> index dd9ee67d1d87..de62e6881154 100644
> >> --- a/arch/arm64/include/asm/pgtable-prot.h
> >> +++ b/arch/arm64/include/asm/pgtable-prot.h
> >> @@ -18,14 +18,7 @@
> >>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
> >>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
> >>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> >> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> >> -
> >> -/*
> >> - * This bit indicates that the entry is present i.e. pmd_page()
> >> - * still points to a valid huge page in memory even if the pmd
> >> - * has been invalidated.
> >> - */
> >> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
> >> +#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
> > 
> > So this now overlaps with AttrIndx[3] if FEAT_AIE is implemented. Although
> > this shouldn't matter on the face of things because it's only used for
> > invalid entries, we originally moved the PROT_NONE bit from 2 to 57 back
> > in 3676f9ef5481 ("arm64: Move PTE_PROT_NONE higher up") because it was
> > possible to change the memory type for PROT_NONE mappings via some
> > drivers.
> 
> I'm not sure I follow your argument.
> 
>  1. We don't support FEAT_AIE (currently) so AttrIndx[3] is always going to be 0
> for valid ptes. Drivers are only calling our helpers (e.g.
> pgprot_writecombine(), right?) and those only know how to set AttrIndx[2:0].

Sure, but we might want to use it in future and chucking that out for the
sake of uffd doesn't seem like an obviously worthwhile trade-off to me.

>  2. PMD_PRESENT_INVALID was already occupying bit 59. So wouldn't the same shape
> of concern apply there too for PMDs that have been invalidated, where the driver
> then comes along and changes the memory type? (Perhaps because
> PMD_PRESENT_INVALID is only set while the PTL is held this can't happen).

I was mainly thinking of the PROT_NONE case, to be honest with you. I
struggle to envisage how a driver could sensibly mess with the memory
type for anonymous mappings, let alone huge pages! But perhaps I just
lack imagination :)

>  3. I had this same vague concern about confusion due to overlapping bit 59,
> which is why in the next patch, I'm moving it to the NS bit.
> 
> Experience tells me that when I'm arguing confidently with someone who is much
> more expert than me, then I'm using wrong... so what have I missed? :)
> 
> > 
> > Moving the field to the NS bit (as you do later in the series) resolves
> > this, but the architecture currently says that the NS bit is RES0. How
> > can we guarantee that it won't be repurposed by hardware in future?
> 
> Well it remains free for use in valid entries of course.

I think that's what I'm actually questioning! RES0 doesn't mean that
tomorrow's whizz-bang CPU extension isn't allowed to use it, but that's
a guarantee that we need if we're going to use it for our own purposes.

> So I guess you are asking how to guarantee we won't also need to be able
> to modify it on the fly for PROT_NONE entries? I don't have a definite
> answer, but I've been working on the assumption that the architecture
> introducing a feature that is only needed in states where NS is not needed
> is unlikely (so using that bit for the feature is also unlikely). And then
> needing to manipulate that feature dyanically for PROT_NONE mappings is
> even less likely.

The architects are quite good at inventing unlikely features :) SVE
blowing the sigcontext comes to mind. I think we should seek
clarification that the NS bit won't be allocated in the future if we are
going to use it for our own stuff.

> If all else fails we could move it to nG (bit 11) to free up bit 5. But that
> requires a bit more fiddling with the swap pte format.

Oh, cunning, I hadn't thought of that. I think that's probably a better
approach if the NS bit isn't guaranteed to be left alone by the
architecture.

> >> @@ -469,7 +477,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> >>   */
> >>  static inline int pte_protnone(pte_t pte)
> >>  {
> >> -	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
> >> +	return pte_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
> >>  }
> > 
> > Why do we need to check pte_user_*() here? Isn't PROT_NONE the only case
> > in which a pte will have PTE_INVALID set?
> 
> I guess for *ptes* this is technically correct. But I was trying to make the
> format generic and reusable for *pmds* too. (pmd_protnone() wraps
> pte_protnone()). For pmds, PTE_INVALID also represents invalid-but-present PMDs
> (i.e. pmds on which pmd_mkinvalid() has been called).
> 
> The intention is that PTE_INVALID indicates "present but not valid in HW". And
> (!pte_user(pte) && !pte_user_exec(pte)) indicates the PROT_NONE permission.

Ok, but it does mean the compiler can't emit a nice TBNZ instruction for
the pte macro. Can you either seperate out the pmd/pte versions of the
macro or just add a comment along the lines of what you said above, please?

Cheers,

Will

