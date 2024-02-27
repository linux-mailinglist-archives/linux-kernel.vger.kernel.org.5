Return-Path: <linux-kernel+bounces-83516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34B869A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FEC1C240EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81A145B19;
	Tue, 27 Feb 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4emScMR"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E96145333;
	Tue, 27 Feb 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048327; cv=none; b=j4jLuYXnGpVUZYnUAHDDzIHXVipN1BVkYaZ+a65C5XhYrbWrAmYCm8JEbD2+dXZfL3adhi4eDHKtg/91dWvdLc/cmNyU594fQ0eiBycXzQRdp9lTJdB5voWSh49EXB/ioi20Fg8HtdY+jcQRvtS/KAAwsl43QM0mtZtuM+mOVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048327; c=relaxed/simple;
	bh=QBsMYy9pwrh5P4TfAHnB2k/9xmLO73IG0uXxRrYpT14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY7v9HYjnAOBPINQGsa5tQKZENsrwI8ZSwG4c3340sP4NeICX4iAPjK0/TrWmH2dhcWXHAnPfUrLfqNXtoIutwnckDDzZqaZNapPhpV5J3+q8we4Xm4mjFvfe9Dtf8j1M3Ao/F9qjCuxE1VkZmtTPYfmyHDHkMq6w7xcHazXnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A4emScMR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vnd2pbpFP2291J6ZbnrPd0ojsH0sCTz1YbhiBOPu5Zo=; b=A4emScMRSC9y0pQJS/PHvQNV+e
	t3rpzBrMLITiRYpDmspI2QrSdqHU6Qa/xhaKvKYYZmh0v2/K50PGu54X1BqkIAMfkhGd8IZ9Z6l73
	uiwSElPtoENwTuI3G7Am/HYaFMl/UQ8yUIoaBIkqQe3p2Sc7Czzh0NwoI6sLztwvVgzXBd5Uba92s
	mra4/CyL9fdzrq4Ajcu7KtitaMSr/thNeTxuDwIH3GFS0pMswb2ytiZC+c2L32ZbvNowz5xLcCPGT
	b2dlHNB5uvEysEfgOYOP+0uMQz38vyXwDJn85eLyJhhCTBEaGy8+zQEAK46hzGx9Q1cuhQg3eKrqd
	LcE2o54g==;
Received: from [12.229.247.3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rezXW-00000005oEH-0TMV;
	Tue, 27 Feb 2024 15:38:42 +0000
Date: Tue, 27 Feb 2024 07:38:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Will Deacon <will@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Message-ID: <Zd4CANmJdW_t69S2@infradead.org>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-2-will@kernel.org>
 <SN6PR02MB4157089980E6FC58D5557BCED4572@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240223124742.GB10641@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223124742.GB10641@willie-the-truck>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 23, 2024 at 12:47:43PM +0000, Will Deacon wrote:
> > >  	/*
> > >  	 * For allocations of PAGE_SIZE or larger only look for page aligned
> > >  	 * allocations.
> > >  	 */
> > >  	if (alloc_size >= PAGE_SIZE)
> > > -		iotlb_align_mask |= ~PAGE_MASK;
> > > -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> > > -
> > > -	/*
> > > -	 * For mappings with an alignment requirement don't bother looping to
> > > -	 * unaligned slots once we found an aligned one.
> > > -	 */
> > > -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > > +		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> > 
> > Is this special handling of alloc_size >= PAGE_SIZE really needed?
> 
> I've been wondering that as well, but please note that this code (and the
> comment) are in the upstream code, so I was erring in favour of keeping
> that while fixing the bugs. We could have an extra patch dropping it if
> we can convince ourselves that it's not adding anything, though.

This special casing goes back to before git history.  It obviously is not
needed, but it might have made sense back then.  If people come up with
a good argument I'm totally fine with removing it, but I also think we
need to get the fixes here in ASAP, so things that are just cleanups
probably aren't priority right now.

> > While the iommu_dma_map_page() case can already fail due to
> > "too large" requests because of not setting a max mapping size,
> > this patch can cause smaller requests to fail as well until Patch 4
> > gets applied.  That might be problem to avoid, perhaps by
> > merging the Patch 4 changes into this patch.
> 
> I'll leave this up to Christoph. Personally, I'm keen to avoid having
> a giant patch trying to fix all the SWIOTLB allocation issues in one go,
> as it will inevitably get reverted due to a corner case that we weren't
> able to test properly, breaking the common cases at the same time.

Let's keep it split.


