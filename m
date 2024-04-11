Return-Path: <linux-kernel+bounces-140694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CE8A17CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EBCB286E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784715AE0;
	Thu, 11 Apr 2024 14:48:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2C14A98
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846918; cv=none; b=bb7r2zuPeFSUdtTi4CUoX1ThZC6P0YFEkLrajAVfgFxW8U8N78g3Wv2/6BYqrIeuw7OIo+Jy5YzBA1EIb+hPU2fBynd7xGurm06C8AScvHjjCcx5L4yaj+30CInK12BJrEBXngpRee13/w3C4BuoiRaYFCrbMpM00gqBLqELlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846918; c=relaxed/simple;
	bh=HuCr67FKfls9MKIB5l7uhILKDr5jfMpXLnxYODBSiQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPWXxHObv1nBPyjO9hnXnZ4H7wNQmpJXkFhDKw2sBgk6AfC0a8XwHXBjyPafonHN8fR1Sg/3GJ0sbVPkkvVIjCv4A9P3so6dD+zCq13ipJbPhKOTaghcZFqumz8LdxP8YDw9c5DGNx/1lxYy7bf9exoE1OJCcCa9/Fks2hjRZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C6B339;
	Thu, 11 Apr 2024 07:49:05 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D13E93F64C;
	Thu, 11 Apr 2024 07:48:33 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:48:24 +0100
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
Message-ID: <Zhf4LqNhQFN8ezx1@FVFF77S0Q05N>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
 <37d4c278-3780-49ce-bd7e-e8f2ff4501fd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d4c278-3780-49ce-bd7e-e8f2ff4501fd@arm.com>

On Thu, Apr 11, 2024 at 02:37:49PM +0100, Ryan Roberts wrote:
> On 11/04/2024 14:02, Mark Rutland wrote:
> > On Thu, Apr 04, 2024 at 03:33:07PM +0100, Ryan Roberts wrote:
> >> During linear map pgtable creation, each pgtable is fixmapped /
> >> fixunmapped twice; once during allocation to zero the memory, and a
> >> again during population to write the entries. This means each table has
> >> 2 TLB invalidations issued against it. Let's fix this so that each table
> >> is only fixmapped/fixunmapped once, halving the number of TLBIs, and
> >> improving performance.
> >>
> >> Achieve this by abstracting pgtable allocate, map and unmap operations
> >> out of the main pgtable population loop code and into a `struct
> >> pgtable_ops` function pointer structure. This allows us to formalize the
> >> semantics of "alloc" to mean "alloc and map", requiring an "unmap" when
> >> finished. So "map" is only performed (and also matched by "unmap") if
> >> the pgtable has already been allocated.
> >>
> >> As a side effect of this refactoring, we no longer need to use the
> >> fixmap at all once pages have been mapped in the linear map because
> >> their "map" operation can simply do a __va() translation. So with this
> >> change, we are down to 1 TLBI per table when doing early pgtable
> >> manipulations, and 0 TLBIs when doing late pgtable manipulations.
> >>
> >> Execution time of map_mem(), which creates the kernel linear map page
> >> tables, was measured on different machines with different RAM configs:
> >>
> >>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
> >>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> >> ---------------|-------------|-------------|-------------|-------------
> >>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> >> ---------------|-------------|-------------|-------------|-------------
> >> before         |   13   (0%) |  162   (0%) |  655   (0%) |  1656   (0%)
> >> after          |   11 (-15%) |  109 (-33%) |  449 (-31%) |  1257 (-24%)
> > 
> > Do we know how much of that gain is due to the early pgtable creation doing
> > fewer fixmap/fixunmap ops vs the later operations using the linear map?
> > 
> > I suspect that the bulk of that is down to the early pgtable creation, and if
> > so I think that we can get most of the benefit with a simpler change (see
> > below).
> 
> All of this improvement is due to early pgtable creation doing fewer
> fixmap/fixunmaps; I'm only measuring the execution time of map_mem(), which only
> uses the early ops.
> 
> I haven't even looked to see if there are any hot paths where the late ops
> benefit. I just saw it as a happy side-effect.

Ah, of course. I skimmed this and forgot this was just timing map_mem().

[...]

> > There's a lot of boilerplate that results from having the TYPE_Pxx enumeration
> > and needing to handle that in the callbacks, and it's somewhat unfortunate that
> > the callbacks can't use the enum type directly (becuase the KPTI allocator is
> > in another file).
> > 
> > I'm not too keen on all of that.
> 
> Yes, I agree its quite a big change. And all the switches are naff. But I
> couldn't see a way to avoid it and still get all the "benefits".
> 
> > As above, I suspect that most of the benefit comes from minimizing the
> > map/unmap calls in the early table creation, and I think that we can do that
> > without needing all this infrastructure if we keep the fixmapping explciit
> > in the alloc_init_pXX() functions, but factor that out of
> > early_pgtable_alloc().
> > 
> > Does something like the below look ok to you? 
> 
> Yes this is actually quite similar to my first attempt, but then I realised I
> could get rid of the redudancies too.
> 
> > The trade-off performance-wise is
> > that late uses will still use the fixmap, and will redundantly zero the tables,
> 
> I think we can mitigate the redudant zeroing for most kernel configs; tell the
> allocator we don't need it to be zeroed. There are some obscure configs where
> pages are zeroed on free instead of on alloc IIRC, so those would still have a
> redundant clear but they are not widely used AIUI. (see bleow).

That sounds fine to me; minor comment below.

> > but the logic remains fairly simple, and I suspect the overhead for late
> > allocations might not matter since the bulk of late changes are non-allocating.
> 
> Its just the fixmap overhead that remains...

True; my thinking there is that almost all of the later changes are for smaller
ranges than the linear map (~10s of MB vs GBs in your test data), so I'd expect
the overhead of those to be dominated by the cost of mappin the linear map.

The only big exception is arch_add_memory(), but memory hotplug is incredibly
rare, and we're not making it massively slower than it already was...

> I'll benchmark with your below change, and also have a deeper look to check if
> there are real places where fixmap might cause slowness for late ops.

Thanks!

[...]

> > @@ -475,8 +491,6 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
> >  	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
> 
> How about:
> 
> 	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);

Looks good to me, assuming we add a comment to say it'll be zeroed in
init_clear_pgtable().

Mark.

