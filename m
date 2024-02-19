Return-Path: <linux-kernel+bounces-71574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AEF85A738
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE851C22827
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71643383A1;
	Mon, 19 Feb 2024 15:18:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43038389
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355921; cv=none; b=YZ82zDMQJtdlVtN15zw4pRg2kN0GwXrevef9Exdu5GPR/T0Bjkck+z9C3TRd68WW+DG5GFM8xWvgz5xHJCplcsQkaTUs2V1tf0qgmE/jPc0LDFhdXrJ2WYzFuK4MoGCtlnE5yzvuDpqdhSjxDC/JKUkiFGtfprVak1su5gJATS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355921; c=relaxed/simple;
	bh=e+73T9SMCi27PyDmGbKHMRdyG/AztmAZjvgCjhDl5fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrMaLBwHp2OpE3EHTJOV1Gne3xvb8497n0FTtfuwkKosVmb4LY0CAOyoXzCWuAODU6gAmwsjVB/aVCcRfCdNkweMAjk4q6/m2KRES3u43lE1yLODRXUwQPTiDnJjPLoi27qLaRKLQWWRR0T3AIpaczLjcdCshj5obiruA2UPmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F3C433F1;
	Mon, 19 Feb 2024 15:18:35 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:18:33 +0000
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
Message-ID: <ZdNxSRR9MgvtMVao@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-13-ryan.roberts@arm.com>
 <Zc9UQy-mtYAzNWm2@arm.com>
 <892caa6a-e4fe-4009-aa33-0570526961c5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892caa6a-e4fe-4009-aa33-0570526961c5@arm.com>

On Fri, Feb 16, 2024 at 12:53:43PM +0000, Ryan Roberts wrote:
> On 16/02/2024 12:25, Catalin Marinas wrote:
> > On Thu, Feb 15, 2024 at 10:31:59AM +0000, Ryan Roberts wrote:
> >> +pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
> >> +{
> >> +	/*
> >> +	 * Gather access/dirty bits, which may be populated in any of the ptes
> >> +	 * of the contig range. We may not be holding the PTL, so any contiguous
> >> +	 * range may be unfolded/modified/refolded under our feet. Therefore we
> >> +	 * ensure we read a _consistent_ contpte range by checking that all ptes
> >> +	 * in the range are valid and have CONT_PTE set, that all pfns are
> >> +	 * contiguous and that all pgprots are the same (ignoring access/dirty).
> >> +	 * If we find a pte that is not consistent, then we must be racing with
> >> +	 * an update so start again. If the target pte does not have CONT_PTE
> >> +	 * set then that is considered consistent on its own because it is not
> >> +	 * part of a contpte range.
> >> +*/
[...]
> > After writing the comments above, I think I figured out that the whole
> > point of this loop is to check that the ptes in the contig range are
> > still consistent and the only variation allowed is the dirty/young
> > state to be passed to the orig_pte returned. The original pte may have
> > been updated by the time this loop finishes but I don't think it
> > matters, it wouldn't be any different than reading a single pte and
> > returning it while it is being updated.
> 
> Correct. The pte can be updated at any time, before after or during the reads.
> That was always the case. But now we have to cope with a whole contpte block
> being repainted while we are reading it. So we are just checking to make sure
> that all the ptes that we read from the contpte block are consistent with
> eachother and therefore we can trust that the access/dirty bits we gathered are
> consistent.

I've been thinking a bit more about this - do any of the callers of
ptep_get_lockless() check the dirty/access bits? The only one that seems
to care is ptdump but in that case I'd rather see the raw bits for
debugging rather than propagating the dirty/access bits to the rest in
the contig range.

So with some clearer documentation on the requirements, I think we don't
need an arm64-specific ptep_get_lockless() (unless I missed something).

-- 
Catalin

