Return-Path: <linux-kernel+bounces-162432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386BC8B5B17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E652B23C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2F78B4E;
	Mon, 29 Apr 2024 14:18:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DE70CAA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400331; cv=none; b=N4Zd7D/p3AOC1O49qNVZG2DxXsMb1KvwaxsIhqijMK89Z2B7hBMXygTdQx+IMze8Hs7+OwVOJ38p7G5wNpeO+G+wqaJ8I9q8bwWB53k7lxbsUoHHd0WmHvrtH1XaSSg7vygfrDTI3nOY7VBJUpF2RVRiqvOS5nOLmDE0URp4ogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400331; c=relaxed/simple;
	bh=v+Pku9/2LJi/1kiMRZLKUDEXBo3uhWlC0VJJEBcfB4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJhjCORinZUY25YfQr7AkVU2EuqGU97UzKiPkB7ZEZjAc05XU5H8ay1Fl/f9Q5CtyRYWLYNjLLBD/NEZ8S6tt3VZF3eWfh4xZVFNICpZi39J01CFkx3Fm55oBFDxsLD+KGuBNelya4q5u9uAd/Bqya74RKosUluO3TuphKyb59s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119BEC113CD;
	Mon, 29 Apr 2024 14:18:47 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:18:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64/mm: Move PTE_PROT_NONE and
 PMD_PRESENT_INVALID
Message-ID: <Zi-sReFGhSKmHWNh@arm.com>
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com>
 <b55558a5-a9d4-4aea-956a-1babad01b6cd@redhat.com>
 <df0475e1-9078-4629-b23d-0919ab1e37c2@arm.com>
 <eed172b5-c71a-469f-a790-76126760ca7c@arm.com>
 <Ziu-r2nkssCQ_uCS@arm.com>
 <f5de5685-d955-4aa0-a307-a4da927f36f0@arm.com>
 <Zi-UyS5IC_truh8M@arm.com>
 <e946c510-9ba3-4d7b-9561-5ded86086df0@arm.com>
 <3ee07020-74d9-4f13-a3d0-4924a1aa69c6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee07020-74d9-4f13-a3d0-4924a1aa69c6@arm.com>

On Mon, Apr 29, 2024 at 02:23:35PM +0100, Ryan Roberts wrote:
> On 29/04/2024 14:01, Ryan Roberts wrote:
> > On 29/04/2024 13:38, Catalin Marinas wrote:
> >> On Mon, Apr 29, 2024 at 11:04:53AM +0100, Ryan Roberts wrote:
> >>> On 26/04/2024 15:48, Catalin Marinas wrote:
> >>>> On Thu, Apr 25, 2024 at 11:37:42AM +0100, Ryan Roberts wrote:
> >>>>> Also, IMHO we shouldn't really need to reserve PMD_PRESENT_INVALID for swap
> >>>>> ptes; it would be cleaner to have one bit that defines "present" when valid is
> >>>>> clear (similar to PTE_PROT_NONE today) then another bit which is only defined
> >>>>> when "present && !valid" which tells us if this is PTE_PROT_NONE or
> >>>>> PMD_PRESENT_INVALID (I don't think you can ever have both at the same time?).
> >>>>
> >>>> I think this make sense, maybe rename the above to PTE_PRESENT_INVALID
> >>>> and use it for both ptes and pmds.
> >>>
> >>> Yep, sounds good. I've already got a patch to do this, but it's exposed a bug in
> >>> core-mm so will now fix that before I can validate my change. see
> >>> https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/
> >>>
> >>> With this in place, I'm proposing to remove PTE_PROT_NONE entirely and instead
> >>> represent PROT_NONE as a present but invalid pte (PTE_VALID=0, PTE_INVALID=1)
> >>> with both PTE_WRITE=0 and PTE_RDONLY=0.
> >>>
> >>> While the HW would interpret PTE_WRITE=0/PTE_RDONLY=0 as "RW without dirty bit
> >>> modification", this is not a problem as the pte is invalid, so the HW doesn't
> >>> interpret it. And SW always uses the PTE_WRITE bit to interpret the writability
> >>> of the pte. So PTE_WRITE=0/PTE_RDONLY=0 was previously an unused combination
> >>> that we now repurpose for PROT_NONE.
> >>
> >> Why not just keep the bits currently in PAGE_NONE (PTE_RDONLY would be
> >> set) and check PTE_USER|PTE_UXN == 0b01 which is a unique combination
> >> for PAGE_NONE (bar the kernel mappings).
> > 
> > Yes I guess that works. I personally prefer my proposal because it is more
> > intuitive; you have an R bit and a W bit, and you encode RO, WR, and NONE. But
> > if you think reusing the kernel mapping check (PTE_USER|PTE_UXN == 0b01) is
> > preferable, then I'll go with that.
> 
> Ignore this - I looked at your proposed approach and agree it's better. I'll use
> `PTE_USER|PTE_UXN==0b01`. Posting shortly...

You nearly convinced me until I read your second reply ;). The
PTE_WRITE|PTE_RDONLY == 0b00 still has the mkwrite problem if we care
about (I don't think it can happen though).

-- 
Catalin

