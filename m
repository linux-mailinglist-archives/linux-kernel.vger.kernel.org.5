Return-Path: <linux-kernel+bounces-160621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B6E8B4030
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABABA1F22D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8918EA5;
	Fri, 26 Apr 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAxVX7qP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE0111A8;
	Fri, 26 Apr 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160364; cv=none; b=NVYtz/SDTryuEGSrnzg3HW77pEI2LEOZygIqCBpZkAtpW+3TkdTBnI+0fvFBDhvAeycrrKxJ9KUQQh5yxnajW0O0RKhCjByXa71HnKGrcQE8DzU9gbYbeolroX56MJ4R14ekYU2FCm9Cxb1BosMo+fRZ4D2CXa0HQW/DWbYVI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160364; c=relaxed/simple;
	bh=8v8Bl/JNo7K0IhpqbY1MkBPByJZjD4Tjwu3fmu599ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDI+GNE+kI8jws00LOo1evUDDRYS7klKdGX6W160BrWCQe0HFnEyVCq3MFoBaQT3rIiC6FyimFT+ime1ufQpYB2XC8T4qyIXMLq7AVOQDdPi2CF+OXVTkpev5abtZ69z51Ou3PFYpqj5sWisPvbricUGFD/c6GausIzlzEpXloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAxVX7qP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IcQFIAb+DjA34CSrIEaXkKwHCowFIDtU+a9kTz/JhdA=; b=PAxVX7qP8zBfvEtcd5DsTqeqRP
	6KqPequrKiNcq9tfftLFb063iJbBXxVR5lPQWwRjQUqQ0cPF+0O1gGfEt6QVKqwBXte8V2Mb5LiSI
	Aqz9wlILClntTHheFeze1bmbmDh/Q0boBakxM+htzJ2ILu+Az4tSbt419IgWW2s29N1To/R0r0MLZ
	ZOi3qd3Ub8X6qgZEOGCygkc5sDrV5V8ERQh5d9zFmqSJlYNfR+4r0pC7C2XFNGw6ge1WJikuTd/Jf
	qRDpbYk3zI6H67HQZsvxKtcS7TJ/ZfdK/gRE6G/gS/OzBx4xDYyw4Au8GYI62QPeyCqJlDT954a+Z
	5c04liCA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0RPe-00000005snl-3bzF;
	Fri, 26 Apr 2024 19:39:15 +0000
Date: Fri, 26 Apr 2024 20:39:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rientjes@google.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
Message-ID: <ZiwC4snk03ptUQij@casper.infradead.org>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
 <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
 <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
 <9bf62e97-dfdd-4537-8fb0-b5f293856f59@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bf62e97-dfdd-4537-8fb0-b5f293856f59@redhat.com>

On Fri, Apr 26, 2024 at 04:39:05PM +0200, David Hildenbrand wrote:
> On 26.04.24 15:49, Pasha Tatashin wrote:
> > On Fri, Apr 26, 2024 at 2:42 AM David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 26.04.24 05:43, Pasha Tatashin wrote:
> > > > Changelog
> > > > ================================================================
> > > > v2: Use mapcount instead of refcount
> > > >       Synchronized with IOMMU Observability changes.
> > > > ================================================================
> > > > 
> > > > This series frees empty page tables on unmaps. It intends to be a
> > > > low overhead feature.
> > > > 
> > > > The read-writer lock is used to synchronize page table, but most of
> > > > time the lock is held is reader. It is held as a writer for short
> > > > period of time when unmapping a page that is bigger than the current
> > > > iova request. For all other cases this lock is read-only.
> > > > 
> > > > page->mapcount is used in order to track number of entries at each page
> > > > table.
> > > 
> > > I'm wondering if this will conflict with page_type at some point? We're
> > > already converting other page table users to ptdesc. CCing Willy.
> > 
> > Hi David,
> 
> Hi!
> 
> > 
> > This contradicts with the following comment in mm_types.h:
> >   * If your page will not be mapped to userspace, you can also use the four
> >   * bytes in the mapcount union, but you must call
> > page_mapcount_reset()
> >   * before freeing it.
> 
> I think the documentation is a bit outdated, because we now have page types
> that are: "For pages that are never mapped to userspace"
> 
> which includes
> 
> #define PG_table
> 
> (we should update that comment, because we're now also using it for hugetlb
> that can be mapped to user space, which is fine.)
> 
> Right now, using page->_mapcount would likely still be fine, as long as you
> cannot end up creating a value that would resemble a type (e.g., PG_offline
> could be bad).
> 
> But staring at users of _mapcount and page_mapcount_reset() ... you'd be
> pretty much the only user of that.
> 
> mm/zsmalloc.c calls page_mapcount_reset(), and I am not completely sure why
> ... I can see it touch page->index but not page->_mapcount.
> 
> 
> Hopefully Willy can comment.

I feel like I have to say "no" to Pasha far too often ;-(

Agreed the documentation is out of date.

I think there's a lot of space in the struct page that can be used.
These are iommu page tables, not cpu page tables, so things are a bit
different for them.  But should they be converted to use ptdesc?  Maybe!

I'd suggest putting this into the union with pt_mm and pt_frag_refcount.
I think it could even go in the union with pt_list, but I think I'd
rather see it in the pt_mm union.

