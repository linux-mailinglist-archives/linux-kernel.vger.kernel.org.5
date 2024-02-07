Return-Path: <linux-kernel+bounces-56469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34784CA8B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A33A1F262F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092659B7F;
	Wed,  7 Feb 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYCZmSdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E359B66
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307892; cv=none; b=NKXBtOa8y76G8luUZUwnG8thxkfqdAWMDSn+Rv3DB3jszFobx0gC4Bvulh54ofje/t0fknyddk/k/IG4SGTG2TRaIMKIw1D7eP1x/6M2pWNbjTYv6x3yrmXQ5fOUX1PHuiI+VSXPy84Epq8OY7PgQjeVZFLdwblD7y8C02YJORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307892; c=relaxed/simple;
	bh=+eWY02fFCjdYE59uuyivWbW4kftlv5vlA77S17iwxcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGu51WLH66VYsQP6nKxBKRs3lw/FXFa96aLsVubU8cLb/LFdCWiwD+91hrMWh9GyfxAbEdkvRshwoTzPf7J9n6A5r3bvVltgj2mPuP/OQs8EYWIXf+91GdIEYvAlV3vxAgzgt1xPMG99/o75aFZ8/Edh0k2axE/HemYYF2jmXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYCZmSdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470F1C43390;
	Wed,  7 Feb 2024 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707307891;
	bh=+eWY02fFCjdYE59uuyivWbW4kftlv5vlA77S17iwxcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYCZmSdgDd7Ka4HkpDKPCOWDml3yR/9iyJOsWJqfoo0xZfG0Ba1bG6M/iB+vgF/Ek
	 XlLLMDXXQyJyEXMCIrIWWy1LOaHDyxHMNIDH0xiwzZsN7J+Xxi12u20fRNlXOMNLxm
	 1HNQhaJ1v6yit9zALbj44UNRRCI2oP+uJdjhnhDJNh8SlDO75McLcDTCTaISZ8VWLL
	 r/xknjs+QVIEOuI+O0QH8zre4TFjDT4dJUgs1dQB/L5hqomcWda890zTdMcs5dVDFJ
	 QbdXpra5hKOnIhL/UqB/uZK2HjCTiFO6PoTGymYNhttmkZcTOkXf4ZMjqY70+eiarE
	 eeRjS2YbwYi7A==
Date: Wed, 7 Feb 2024 12:11:25 +0000
From: Will Deacon <will@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, mike.kravetz@oracle.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <20240207121125.GA22234@willie-the-truck>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcNnrdlb3fe0kGHK@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 07, 2024 at 11:21:17AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 07, 2024 at 11:12:52AM +0000, Will Deacon wrote:
> > On Sat, Jan 27, 2024 at 01:04:15PM +0800, Nanyong Sun wrote:
> > > 
> > > On 2024/1/26 2:06, Catalin Marinas wrote:
> > > > On Sat, Jan 13, 2024 at 05:44:33PM +0800, Nanyong Sun wrote:
> > > > > HVO was previously disabled on arm64 [1] due to the lack of necessary
> > > > > BBM(break-before-make) logic when changing page tables.
> > > > > This set of patches fix this by adding necessary BBM sequence when
> > > > > changing page table, and supporting vmemmap page fault handling to
> > > > > fixup kernel address translation fault if vmemmap is concurrently accessed.
> > > > I'm not keen on this approach. I'm not even sure it's safe. In the
> > > > second patch, you take the init_mm.page_table_lock on the fault path but
> > > > are we sure this is unlocked when the fault was taken?
> > > I think this situation is impossible. In the implementation of the second
> > > patch, when the page table is being corrupted
> > > (the time window when a page fault may occur), vmemmap_update_pte() already
> > > holds the init_mm.page_table_lock,
> > > and unlock it until page table update is done.Another thread could not hold
> > > the init_mm.page_table_lock and
> > > also trigger a page fault at the same time.
> > > If I have missed any points in my thinking, please correct me. Thank you.
> > 
> > It still strikes me as incredibly fragile to handle the fault and trying
> > to reason about all the users of 'struct page' is impossible. For example,
> > can the fault happen from irq context?
> 
> The pte lock cannot be taken in irq context (which I think is what
> you're asking?)  While it is not possible to reason about all users of
> struct page, we are somewhat relieved of that work by noting that this is
> only for hugetlbfs, so we don't need to reason about slab, page tables,
> netmem or zsmalloc.

My concern is that an interrupt handler tries to access a 'struct page'
which faults due to another core splitting a pmd mapping for the vmemmap.
In this case, I think we'll end up trying to resolve the fault from irq
context, which will try to take the spinlock.

Avoiding the fault would make this considerably more robust and the
architecture has introduced features to avoid break-before-make in some
circumstances (see FEAT_BBM and its levels), so having this optimisation
conditional on that would seem to be a better approach in my opinion.

Will

