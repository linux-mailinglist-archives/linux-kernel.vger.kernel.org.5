Return-Path: <linux-kernel+bounces-56605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F087584CC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3711C23B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C26B7C093;
	Wed,  7 Feb 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdkGZZ6H"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430777F2A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315459; cv=none; b=r7eDbvtJJ2PrpyE9VI6FRY5LN90MsOUIIwltiLSF/SAY+pPXC1Gb9ZiT6aePYmnLF6aM/V6A69NThESQF+IT3fSPSy2NaLE1V4xJz0ML0qfzkKeG20FHf+5pVWCa6UjD8+mGURMdX7dzSnR94B1AT+xbVqdugfzHyIdr9j6tdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315459; c=relaxed/simple;
	bh=1FoXys9DjqAW9tBcBEYCUR2iy5mCIoqQk2Y8S3+GmpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rklJqX0SzdlpnPZKaruCeSldggG+VSR+UqRWkqpdQSzPdseicjeLMxx0cwy1Bug9iMg5roujJZhmCQAIvyEPbX7nSZeDBx4CyF6vZO2jq6lMU5FHpAoLJrckC/4jp3SJNA6btHcQbfVehFqYuU973Ab4vuARyx0LLJep2VmwswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cdkGZZ6H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6nXIcLmaWrCikPStJ3sC7+E3lnqfPQhTFLM5Qd6/v+g=; b=cdkGZZ6Hx+vVpgO8vYvlPMpbTQ
	K/alL+Cx5LLR6Ap1iO9ffjd5Zemo3g7Yxeb+FVj0ctQakDgQOQmp/0dejt+dxj2jLyp4yuy3JsQSl
	SWiQnhSIOO2KsCP0NzIQXMSuEDLhc6pNebUYzIpudZECGPlJ3SceMr2VSHPYwtJ46sjub2r/tqNF4
	kKUBc3VzfT3CfuU20g2Pv1nkSocvbqOg+93mDqfoNVrSMFrUn1qltiUiiojz4RTO5nha4YNl/qpvk
	O5E1WZOrF1yaNXlVVP3qW6qg/J3DYr2vx8qLnzEzHPWkFOMOSXNAgyA4kg3QqHRKbeqa952oZ5/SU
	qJtjatFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXijz-0000000FJjg-2Fbc;
	Wed, 07 Feb 2024 14:17:31 +0000
Date: Wed, 7 Feb 2024 14:17:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Will Deacon <will@kernel.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZcOQ-0pzA16AEbct@casper.infradead.org>
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

Yes, this absolutely can happen (with this patch), and this patch should
be dropped for now.

While this array of ~512 pages have been allocated to hugetlbfs, and one
would think that there would be no way that there could still be
references to them, another CPU can have a pointer to this struct page
(eg attempting a speculative page cache reference or
get_user_pages_fast()).  That means it will try to call
atomic_add_unless(&page->_refcount, 1, 0);

Actually, I wonder if this isn't a problem on x86 too?  Do we need to
explicitly go through an RCU grace period before freeing the pages
for use by somebody else?


