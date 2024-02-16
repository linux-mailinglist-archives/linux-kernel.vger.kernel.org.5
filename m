Return-Path: <linux-kernel+bounces-68995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CA85831E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A05281422
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BB130AF6;
	Fri, 16 Feb 2024 16:56:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4F5465D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102577; cv=none; b=kTZMTwsw/O2/hu2YpKyoUV0SXg8Q5bWubLJaF5Dwf5xzASjnrDVn0g+5VETFNgcHWCPV2PFvEF7TYJliLtbDcE0u/e+FaW3jIDeRq+iB4nU99lGcxQAWr7XnRalEeai+iRbG4/UhgYKgTC5Lpb0b4mFc0scr71nDLO5zkePHaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102577; c=relaxed/simple;
	bh=YuAECvUSSs6CSyQUuMZzsqnAo9jtikzllwciZ2R7g1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyKAUD/XkM44moOLT9FNs8XJH0nxFT+UfrglcerSrr16clTwmx5B7wOTw1nt+964ABkrzrh6dVhxF1qgIkWAVxKRkS8UVHL5EdyvAk25miGE850NwU+4wfEOVTTIG+Njr7LHdEKZKty8f/x55aHIld9/g4TccUEaJhlGI8BRwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7B0C433F1;
	Fri, 16 Feb 2024 16:56:12 +0000 (UTC)
Date: Fri, 16 Feb 2024 16:56:10 +0000
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
Message-ID: <Zc-Tqqfksho3BHmU@arm.com>
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
> >>  arch/arm64/mm/contpte.c          | 285 +++++++++++++++++++++++++++++++
> > 
> > Nitpick: I think most symbols in contpte.c can be EXPORT_SYMBOL_GPL().
> > We don't expect them to be used by random out of tree modules. In fact,
> > do we expect them to end up in modules at all? Most seem to be called
> > from the core mm code.
> 
> The problem is that the contpte_* symbols are called from the ptep_* inline
> functions. So where those inlines are called from modules, we need to make sure
> the contpte_* symbols are available.
> 
> John Hubbard originally reported this problem against v1 and I enumerated all
> the drivers that call into the ptep_* inlines here:
> https://lore.kernel.org/linux-arm-kernel/b994ff89-1a1f-26ca-9479-b08c77f94be8@arm.com/#t
> 
> So they definitely need to be exported. Perhaps we can tighten it to
> EXPORT_SYMBOL_GPL(), but I was being cautious as I didn't want to break anything
> out-of-tree. I'm not sure what the normal policy is? arm64 seems to use ~equal
> amounts of both.

I don't think we are consistent here. For example set_pte_at() can't be
called from non-GPL modules because of __sync_icache_dcache. OTOH, such
driver is probably doing something dodgy. Same with
apply_to_page_range(), it's GPL-only (called from i915).

Let's see if others have any view over the next week or so, otherwise
I'd go for _GPL and relax it later if someone has a good use-case (can
be a patch on top adding _GPL).

> > If you can make this easier to parse (in a few years time) with an
> > additional patch adding some more comments, that would be great. For
> > this patch:
> 
> I already have a big block comment at the top, which was trying to explain it.
> Clearly not well enough though. I'll add more comments as a follow up patch when
> I get back from holiday.

I read that comment but it wasn't immediately obvious what the atomicity
requirements are - basically we require a single PTE to be atomically
read (which it is), the rest is the dirty/young state being added on
top. I guess a sentence along these lines would do.

Enjoy your holiday!

-- 
Catalin

