Return-Path: <linux-kernel+bounces-75234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A485E4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433341F23967
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5D84FC5;
	Wed, 21 Feb 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UovlAaKW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F283CC7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538123; cv=none; b=H3VcDJfS++W/uGuGVsGZJyW2ag/oI+OfXdBHK2QclDY8oq8ls7zmxKwMtEsi9ixXABnFwboT42Vct7/IihnfrdKdtAawkBMZPcv8fV8JlXkHMGow3e4TnNfXYDDT0tf3K7nDc8swn1+v8Jpk4XHkAL5CI66eOszkayOaJZ0Ebqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538123; c=relaxed/simple;
	bh=WnozabPfgyLgQuSJlmU9bbQ6aXri5w7SUQ2o65f0ySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgV027EFzhGWqKnndzFd2mgHiMCzK+t3ExjZZ+MMatij2dRMN/0nWpI9H4FD3Qy49W+I+tErsnuuGGvAottvwy7ohcob9VSeitT2upY1z3SyN2qvEDmvkc5AkCZYgdts0klLdXYWUwQgptrNIBV72bIzjpij9caQwPzyo9HvawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UovlAaKW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wRp1w5Zyb5jyGjRVjFlb00/lPh/g4wKdCacDA3p0w8g=; b=UovlAaKW6CTiINlkME0xjm1y/g
	016q0sdMdEI9eGIVOzP13bTWo4rtMN3kwiwfvKS1b3JAacPz8zTuAioBslASuR3clZVqXVYYVImfP
	lPvHgEot5y1d0w2kiUe2SZtzCAhYAVQDHbGHztUaQBbUGFsaHYkfftJSVqvvInmFtV+qHqj0+fCiK
	dNw9dgVwOp3Wgc4K247DECSAhadEBSJ1HsFuxlbFkZEkQFmZRe1pqBmxumbMnkNvPXth416tI+Kno
	KZ+yz+geZhDXPZ6PYfhomxGQyqBhQLXIdpnEuue5dGy1o+Y6hAeWZFuX6lCLAkUUZb5IWcXL1fISe
	kgtXThPg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcqoP-00000001KuE-3Xc7;
	Wed, 21 Feb 2024 17:55:17 +0000
Date: Wed, 21 Feb 2024 17:55:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH 2/3] hugetlb: Use vmf_anon_prepare() instead of
 anon_vma_prepare()
Message-ID: <ZdY5BfO3EdcnJM99@casper.infradead.org>
References: <20240220231424.126600-1-vishal.moola@gmail.com>
 <20240220231424.126600-3-vishal.moola@gmail.com>
 <ZdVx_Jr9tm2lV0Ku@casper.infradead.org>
 <CAOzc2pzLbiEpMuBpX7xXhZqPc0S6ZMnziT2uUFsa0tZe6yJQ0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzc2pzLbiEpMuBpX7xXhZqPc0S6ZMnziT2uUFsa0tZe6yJQ0g@mail.gmail.com>

On Wed, Feb 21, 2024 at 09:15:51AM -0800, Vishal Moola wrote:
> > >       unsigned long haddr = address & huge_page_mask(h);
> > >       struct mmu_notifier_range range;
> > > +     struct vm_fault vmf = {
> > > +                             .vma = vma,
> > > +                             .address = haddr,
> > > +                             .real_address = address,
> > > +                             .flags = flags,
> > > +     };
> >
> > We don't usually indent quite so far.  One extra tab would be enough.
> >
> > Also, I thought we talked about creating the vmf in hugetlb_fault(),
> > then passing it to hugetlb_wp() hugetlb_no_page() and handle_userfault()?
> > Was there a reason to abandon that idea?
> 
> No I haven't abandoned that idea, I intend to have a separate patchset to go
> on top of this one - just keeping them separate since they are conceptually
> different. I'm converting each function to use struct vm_fault first, then
> shifting it to be passed throughout as an arguement while cleaning up the
> excess variables laying around. In a sense working bottom-up instead
> of top-down.

I think you'll find it less work to create it in hugetlb_fault()
first.  ie patch 2 could be to hoist its creation from half-way down
hugetlb_fault to the top of hugetlb_fault.  Patch 3 could pass it
through hugetlb_no_page() to hugetlb_handle_userfault() and remove its
creation there.  Now you've alreedy got it, and can make use of it in
this patch which would be the new patch 4.

If you want to do a cleanup patch afterwards, you could hoist the vmf
creation all the way to handle_mm_fault() ;-)

