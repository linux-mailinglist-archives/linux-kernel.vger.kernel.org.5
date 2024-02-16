Return-Path: <linux-kernel+bounces-68565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC880857C80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895E91F245F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A978B47;
	Fri, 16 Feb 2024 12:25:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4C7867D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086347; cv=none; b=Uv890ExD0oxQsVt0qnUWcNIYfaqcLD5lnd5ZhkHJWcmrdEIru4XgXTwOcu5sfTWJJr0ajUB/mdRV8G5kigcH/EzWtTjPy4XlRTxjyhI/TTn2Hve1Wyr80vF0uvX8SKcukoItWmrTxt/3fsdg8o31ewTfQNKEUpxNITr6b+vteic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086347; c=relaxed/simple;
	bh=a80o+y9k9+JZ2PbTxRTtyyupdJ2wSlHG1q/Azlo/+3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQSWBCGryhwSJ4ATV2i57ieySAQdkA9fA2bYVtzJYwAhjpk7uOUcidxYp9hxmtIViKGSAiuRBmBkyYimtSZ7MmAhUZufS7sFgSc+26LM3ekrzHAl0PAc2NwFXb72k+u4o1/SFD2Htr7YUn2Sh5hfaO7oyC+pmUEM4n0UV1eBvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0177C433C7;
	Fri, 16 Feb 2024 12:25:41 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:25:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/18] arm64/mm: Wire up PTE_CONT for user mappings
Message-ID: <Zc9UQy-mtYAzNWm2@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-13-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-13-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:31:59AM +0000, Ryan Roberts wrote:
>  arch/arm64/mm/contpte.c          | 285 +++++++++++++++++++++++++++++++

Nitpick: I think most symbols in contpte.c can be EXPORT_SYMBOL_GPL().
We don't expect them to be used by random out of tree modules. In fact,
do we expect them to end up in modules at all? Most seem to be called
from the core mm code.

> +#define ptep_get_lockless ptep_get_lockless
> +static inline pte_t ptep_get_lockless(pte_t *ptep)
> +{
> +	pte_t pte = __ptep_get(ptep);
> +
> +	if (likely(!pte_valid_cont(pte)))
> +		return pte;
> +
> +	return contpte_ptep_get_lockless(ptep);
> +}
[...]
> +pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
> +{
> +	/*
> +	 * Gather access/dirty bits, which may be populated in any of the ptes
> +	 * of the contig range. We may not be holding the PTL, so any contiguous
> +	 * range may be unfolded/modified/refolded under our feet. Therefore we
> +	 * ensure we read a _consistent_ contpte range by checking that all ptes
> +	 * in the range are valid and have CONT_PTE set, that all pfns are
> +	 * contiguous and that all pgprots are the same (ignoring access/dirty).
> +	 * If we find a pte that is not consistent, then we must be racing with
> +	 * an update so start again. If the target pte does not have CONT_PTE
> +	 * set then that is considered consistent on its own because it is not
> +	 * part of a contpte range.
> +*/

I can't get my head around this lockless API. Maybe it works fine (and
may have been discussed already) but we should document what the races
are, why it works, what the memory ordering requirements are. For
example, the generic (well, x86 PAE) ptep_get_lockless() only needs to
ensure that the low/high 32 bits of a pte are consistent and there are
some ordering rules on how these are updated.

Does the arm64 implementation only need to be correct w.r.t. the
access/dirty bits? Since we can read orig_ptep atomically, I assume the
only other updates from unfolding would set the dirty/access bits.

> +
> +	pgprot_t orig_prot;
> +	unsigned long pfn;
> +	pte_t orig_pte;
> +	pgprot_t prot;
> +	pte_t *ptep;
> +	pte_t pte;
> +	int i;
> +
> +retry:
> +	orig_pte = __ptep_get(orig_ptep);
> +
> +	if (!pte_valid_cont(orig_pte))
> +		return orig_pte;
> +
> +	orig_prot = pte_pgprot(pte_mkold(pte_mkclean(orig_pte)));
> +	ptep = contpte_align_down(orig_ptep);
> +	pfn = pte_pfn(orig_pte) - (orig_ptep - ptep);
> +
> +	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
> +		pte = __ptep_get(ptep);
> +		prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));

We don't have any ordering guarantees in how the ptes in this range are
read or written in the contpte_set_ptes() and the fold/unfold functions.
We might not need them given all the other checks below but it's worth
adding a comment.

> +
> +		if (!pte_valid_cont(pte) ||
> +		   pte_pfn(pte) != pfn ||
> +		   pgprot_val(prot) != pgprot_val(orig_prot))
> +			goto retry;

I think this also needs some comment. I get the !pte_valid_cont() check
to attempt retrying when racing with unfolding. Are the other checks
needed to detect re-folding with different protection or pfn?

> +
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +
> +		if (pte_young(pte))
> +			orig_pte = pte_mkyoung(orig_pte);
> +	}

After writing the comments above, I think I figured out that the whole
point of this loop is to check that the ptes in the contig range are
still consistent and the only variation allowed is the dirty/young
state to be passed to the orig_pte returned. The original pte may have
been updated by the time this loop finishes but I don't think it
matters, it wouldn't be any different than reading a single pte and
returning it while it is being updated.

If you can make this easier to parse (in a few years time) with an
additional patch adding some more comments, that would be great. For
this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

