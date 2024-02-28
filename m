Return-Path: <linux-kernel+bounces-84403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A156686A659
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1C7287583
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600BD568A;
	Wed, 28 Feb 2024 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7ZyXrxq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386994400
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086274; cv=none; b=LgoAXZrDKSCkxumWYp+vRl5KQMvqQbWxnSKs8NCw3ffe0dj/hRqUYgDKJejJKH7wn2QLksGt3bhumVQYHa/FX+4q5DnP9iwbcahUQ91x4teOl1CrS9wsZfBtx1Tk39lQeK/wCZNKN0tJEIEQDly4oT0As2L5WAQ29+Gk5uEhKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086274; c=relaxed/simple;
	bh=lxtnVTYhgvnuXxdfAeBxqeSrBQ6kSOBUUnb7tY+vQto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu68igc59rlutFSGoQQNCYt7E39BreWNPhOiilfCGxdgQ4y2/YHvBgRfZCCVaO84hZXFLKraATECBE1oot5JGLiIFj/bTWsTTQ6EnYtQK356hMkSkKAUgc9XRYspFc6QXVUtWAzCPQC9PI7DRyO+Q1s993jScZTYwyUQx2wyE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h7ZyXrxq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SXJbCm+VxWCOy8utsVzLxhtFAwCalPFzLbzPxM8Jrn4=; b=h7ZyXrxqUYwMBGEli9ZNIQoaIi
	HRt8poIxMUBJPl3LSMr0+xLkjXLzKLiAtxCgeeDpKMXvIkn3ICLO1dRwXC28aFym3nYX/sPq5DwML
	OinIwMFxs8SDtYUlL/kq6jTQpj4iIPJry3VeSrrCa1y9pVeu0dELJMdZDrrEf7oaz+rjcZMfQRAfd
	VtlR0UKWwUwInjJwgkMo1v8LWKw9EQ002dhRTezVcgg7AVGvVw/vX6aTRWxsqxoAfEZXfslpAS+/a
	fDFLSfTKIl/xZf7jL5b2ZwOxDJjhuzoKptcqvcTWop/oFAXFMDjtOwkyA3nQXJ9Bpxvn3H/S2ErkH
	IVj8C0jg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9PB-00000003zeD-0Sof;
	Wed, 28 Feb 2024 02:10:45 +0000
Date: Wed, 28 Feb 2024 02:10:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: david@redhat.com, akpm@linux-foundation.org, khlebnikov@openvz.org,
	jaredeh@gmail.com, linmiaohe@huawei.com, hpa@zytor.com,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
	peterz@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	mingo@redhat.com, rdunlap@infradead.org, bhelgaas@google.com,
	linux-mm@kvack.org
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Message-ID: <Zd6WJe9xrRwkphfm@casper.infradead.org>
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
 <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
 <de0cc6e0-dd15-40b6-89c2-c8e83fd6f587@redhat.com>
 <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>

On Wed, Feb 28, 2024 at 09:55:24AM +0800, mawupeng wrote:
> On 2024/2/27 21:15, David Hildenbrand wrote:
> > On 27.02.24 14:00, David Hildenbrand wrote:
> >> On 27.02.24 13:28, Wupeng Ma wrote:
> >>> We find that a warn will be produced during our test, the detail log is
> >>> shown in the end.
> >>>
> >>> The core problem of this warn is that the first pfn of this pfnmap vma is
> >>> cleared during memory-failure. Digging into the source we find that this
> >>> problem can be triggered as following:
> >>>
> >>> // mmap with MAP_PRIVATE and specific fd which hook mmap
> >>> mmap(MAP_PRIVATE, fd)
> >>>     __mmap_region
> >>>       remap_pfn_range
> >>>       // set vma with pfnmap and the prot of pte is read only
> >>>     
> >>
> >> Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.
> >>
> >> What fd is that exactly? Often, we disallow private mappings in the
> >> mmap() callback (for a good reason).
> 
> just a device fd with device-specify mmap which use remap_pfn_range to assign memory.

But what meaning do you want MAP_PRIVATE of this fd to have?  Does it
make sense to permit this, or should you rather just return -EINVAL if
somebody tries to mmap() with MAP_PRIVATE set?


