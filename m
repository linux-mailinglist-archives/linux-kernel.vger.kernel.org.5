Return-Path: <linux-kernel+bounces-163826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D28B72B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0819D28273A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF28801;
	Tue, 30 Apr 2024 11:11:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FB12D1F4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475478; cv=none; b=Vs0Jg55Rmx/gYogj6ZFhxOynCLMQIGh4oQDUHzB18TIMLdxpDjH0xpTD+eL3iEB/gcSxfI1a+TkxiDX0xay1qBYYDPtmyXael/YgcWWIfv9Zu8iM0xCmIMQz4WOJ+w6tJudN7tWRhhmOYGZBVAOQkboWv/tHt7vBybW3hamAXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475478; c=relaxed/simple;
	bh=SPbfDXDeO7xWFDZgyGZmSdn7p88FwpKRkRk7sN+7Wtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMcCq8IEyCRlO6EGeOWXDVtGHCj3MJ1oZYS2ji6tdzvbs7Bh9+q3uPbGPlcT6ulbT1Sn0jEYozrfsV9/EuThJuBAf0jIVcBUf/8UoKJaXJERH4JjZrFrPQaYw196EjNEilrRgx3yTr1M1kX79ehblRY8q0UT/epn1XmrdQouBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8418EC4AF18;
	Tue, 30 Apr 2024 11:11:14 +0000 (UTC)
Date: Tue, 30 Apr 2024 12:11:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Message-ID: <ZjDR0EIjLr9F2dWn@arm.com>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com>
 <Zi_IzrfIcqWxt7cE@arm.com>
 <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com>

On Mon, Apr 29, 2024 at 06:15:45PM +0100, Ryan Roberts wrote:
> On 29/04/2024 17:20, Catalin Marinas wrote:
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
> > Nitpick - I prefer the PTE_PRESENT_INVALID name as it makes it clearer
> > it's a present pte. We already have PTE_VALID, calling it PTE_INVALID
> > looks like a negation only.
> 
> Meh, for me the pte can only be valid or invalid if it is present. So it's
> implicit. And if you have PTE_PRESENT_INVALID you should also have
> PTE_PRESENT_VALID.
> 
> We also have pte_mkinvalid(), which is core-mm-defined. In your scheme, surely
> it should be pte_mkpresent_invalid()?
> 
> But you're the boss, I'll change this to PTE_PRESENT_INVALID. :-(

TBH, I don't have a strong opinion but best to avoid the bikeshedding.
I'll leave the decision to you ;). It would match the pmd_mkinvalid()
core code. But if you drop 'present' make sure you add a comment above
that it's meant for present ptes.

> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index afdd56d26ad7..8dd4637d6b56 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> >>  /*
> >>   * The following only work if pte_present(). Undefined behaviour otherwise.
> >>   */
> >> -#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
> >> +#define pte_present(pte)	(pte_valid(pte) || pte_invalid(pte))
> >>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
> >>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
> >>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
> >> @@ -132,6 +132,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> >>  #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
> >>  
> >>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
> >> +#define pte_invalid(pte)	((pte_val(pte) & (PTE_VALID | PTE_INVALID)) == PTE_INVALID)
[...]
> > I think it's sufficient to check PTE_PRESENT_INVALID only. We'd never
> > have both bits set, so no need for mask and compare.
> 
> My rationale is that the INVALID bit may have some other HW meaning when
> PTE_VALID is set, so its not correct to interpret it as INVALID unless VALID is
> clear. Granted bit 59 is AttrIndex[3] or PBHA[0], neither of which we are using
> currently so it will always be 0 when PTE_VALID=1 (and same argument when its
> moved to NS in next patch). But it feels fragile to me. I'd rather leave it as
> is unless you insist.

You are right. It currently works but it may overlap with some hardware
bit on valid ptes.

> >>  /*
> >>   * Execute-only user mappings do not have the PTE_USER bit set. All valid
> >>   * kernel mappings have the PTE_UXN bit set.
> >> @@ -261,6 +262,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
> >>  	return set_pte_bit(pte, __pgprot(PTE_VALID));
> >>  }
> >>  
> >> +static inline pte_t pte_mkinvalid(pte_t pte)
> >> +{
> >> +	pte = set_pte_bit(pte, __pgprot(PTE_INVALID));
> >> +	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
> >> +	return pte;
> >> +}
> > 
> > I wonder whether we need to define this. I guess it makes sense than
> > having the pmd_mkinvalid() use the PTE_* definitions directly, though it
> > won't be something we need to do on a pte.
> 
> For me its much cleaner to do it as is because it makes it clear that the format
> is the same across pte, pmd and pud. And we need pte_invalid() (or
> pte_present_invalid()) for PROT_NONE so isn't it better to match it with a setter?

I agree. It was just a remark above.

> >>  static inline bool pmd_user_accessible_page(pmd_t pmd)
> >>  {
> >> -	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> >> +	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> >>  }
> > 
> > Maybe our pmd_leaf() should actually check valid && !table instead of
> > present and no need to change these.
> 
> I'm not sure that would be a great approach; pmd_leaf() is core-mm-defined. And
> I can't imagine core-mm would want pmd_leaf() to start returning false after
> calling pmd_mkinvalid(). You probably won't find anywhere where it actually
> matters right now, but it would be subtly broken and could be exposed in future.

True, I think it's fine currently but you never know. So after
pmd_mkinvalid() on a leaf pmd, pmd_leaf() should still return true. It
might be worth adding a test to pmd_thp_tests() in debug_vm_pgtable.c.

> >>  static inline bool pud_user_accessible_page(pud_t pud)
> >>  {
> >> -	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
> >> +	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
> >>  }
> >>  #endif
> > 
> > Same here.
> > 
> > Otherwise I'm happy with the patch. Feel free to add:
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

My reviewed-by tag still stands even if you leave the patch as is.

Thanks.

-- 
Catalin

