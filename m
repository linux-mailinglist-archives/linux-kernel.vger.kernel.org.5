Return-Path: <linux-kernel+bounces-56479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB4484CAAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB463B20F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155AA59B78;
	Wed,  7 Feb 2024 12:24:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621259B5F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308673; cv=none; b=K3QIbnom1mGJ3Br3W+eyjBZKbV+LcTjDPIKHn00ErfZkKiE/3ARrrr5J/1IKH7YROHVaY3AUCgRl51cu3z7SO+WAd7QQXek8fcJkzzISF+VIeBB5xSyqfzkiIM3LRvG40VafdLmoRJ6FLBXQL3ZVzOAOMsbP0hE4HppACCPxoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308673; c=relaxed/simple;
	bh=iSMeIQtleGcAcnf7YL8TMly6GDq3B/vPhWx07pFdICM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhY3nNFc0DM7OXuJ2nuJ+ByQ126LxPnrOC0rbBtyIZlNol3Z5xcsxjjthPL0IR2DKpzQ7B+9JsbpAgjTkK8apD8r9Uo0i6RWc6WS9xKNvMIRpM2ijs4PJPPIClPL2jotGboIC2l5O0Iox7uySk+QoLDmJue+hhDFAmAN9OfUeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 754951FB;
	Wed,  7 Feb 2024 04:25:13 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750803F5A1;
	Wed,  7 Feb 2024 04:24:29 -0800 (PST)
Date: Wed, 7 Feb 2024 12:24:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Nanyong Sun <sunnanyong@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, mike.kravetz@oracle.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZcN2emKK8jrJ6Gyt@FVFF77S0Q05N.cambridge.arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207121125.GA22234@willie-the-truck>

On Wed, Feb 07, 2024 at 12:11:25PM +0000, Will Deacon wrote:
> On Wed, Feb 07, 2024 at 11:21:17AM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 07, 2024 at 11:12:52AM +0000, Will Deacon wrote:
> > > On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > > > 
> > > > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > > > > BBM(break-before-make) logic when changing page tables.
> > > > > > This set of patches fix this by adding necessary BBM sequence when
> > > > > > changing page table, and supporting vmemmap page fault handling to
> > > > > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > > > > I'm not keen on this approach. I'm not even sure it's safe. In the
> > > > > second patch, you take the init_mm.page_table_lock on the fault path but
> > > > > are we sure this is unlocked when the fault was taken?
> > > > I think this situation is impossible. In the implementation of the second
> > > > patch, when the page table is being corrupted
> > > > (the time window when a page fault may occur), vmemmap_update_pte() already
> > > > holds the init_mm.page_table_lock,
> > > > and unlock it until page table update is done.Another thread could not hold
> > > > the init_mm.page_table_lock and
> > > > also trigger a page fault at the same time.
> > > > If I have missed any points in my thinking, please correct me. Thank you.
> > > 
> > > It still strikes me as incredibly fragile to handle the fault and trying
> > > to reason about all the users of 'struct page' is impossible. For example,
> > > can the fault happen from irq context?
> > 
> > The pte lock cannot be taken in irq context (which I think is what
> > you're asking?)  While it is not possible to reason about all users of
> > struct page, we are somewhat relieved of that work by noting that this is
> > only for hugetlbfs, so we don't need to reason about slab, page tables,
> > netmem or zsmalloc.
> 
> My concern is that an interrupt handler tries to access a 'struct page'
> which faults due to another core splitting a pmd mapping for the vmemmap.
> In this case, I think we'll end up trying to resolve the fault from irq
> context, which will try to take the spinlock.

I think that (as per my comments on patch 2), a similar deadlock can happen on
RT even if the vmemmap is only accessed in regular process context, and at
minimum this needs better comentary and/or lockdep assertions.

I'd also prefer that we dropped this for now.

> Avoiding the fault would make this considerably more robust and the
> architecture has introduced features to avoid break-before-make in some
> circumstances (see FEAT_BBM and its levels), so having this optimisation
> conditional on that would seem to be a better approach in my opinion.

FWIW, that's my position too.

Mark.

