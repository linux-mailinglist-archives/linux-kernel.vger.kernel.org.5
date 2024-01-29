Return-Path: <linux-kernel+bounces-43427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 899FF8413BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4608B286D04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0A6F081;
	Mon, 29 Jan 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdoABHmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D394C619;
	Mon, 29 Jan 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557785; cv=none; b=fmxmwQfoaSHcei2/lptMUXC+7VVMlEOZ35eCkcK3/CzoQA4ZevOf+hsatyH/OGqCSfv/MN50iyhigAiv1xYlpjUj9JNH9qnZoab+RAc0LwCxEOTQHShf9Vf4ii2p2xB1NdrOoZTB/ZcuzsxHfV/zO/VvLYAHURKP5oQhatndE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557785; c=relaxed/simple;
	bh=AFzIbjcOWSZos8y3SLuij19ce0bzY428EYdt2/6+Cpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr2tuD0PxyqqFZsueDqmsoF4tKwX3yfwZIHLLpC/cdTB7Q/nP3LsdJAsQk9n/GSi35ZU8RGm/r8fO5My3eImdthRrXfs7AH879ns5Lo97mviH2W6SoIjfCuhoicwWToGQMU9TpLx7miVB18tz0Cy/SM5O1NbwqhBoiX4avoNUf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdoABHmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB93C43390;
	Mon, 29 Jan 2024 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706557785;
	bh=AFzIbjcOWSZos8y3SLuij19ce0bzY428EYdt2/6+Cpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdoABHmGOXwnshWW4D5hELpR9s7yY69FTCmInEgq8suc3c2l3EGmjnVZhTLznkrFx
	 DEvb8GBmww1NXRcZN7+xt/O0ajuY7Rwe4BxhBGrR9CP2+zOhOQ7lZ2bSldtEj/nH0O
	 9orUw5tnHHJ3cL1UaPLATYfmH61xKusG207ogj3PmR7mMhYyavCqTr41oA0pHT9LiT
	 SsDkQs9YGBEbooHTLRlaLjOpjKvQlzqejAhx8Om4NCXo2oJ7FUf4dUg/TJ9MMRCCTe
	 RXorT9zg3rtejrUbaKWZvqgS4vzb0VjkKpfD1/2FN/G7XAN2b/5Vmzg/9inW7o5H3H
	 YOh3i2Z5ic7gA==
Date: Mon, 29 Jan 2024 19:49:40 +0000
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240129194939.GE12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
 <20240126151956.10014-3-will@kernel.org>
 <20240129060853.GB19258@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129060853.GB19258@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 29, 2024 at 07:08:53AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 26, 2024 at 03:19:56PM +0000, Will Deacon wrote:
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 25febb9e670c..92433ea9f2d2 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -1647,6 +1647,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
> >  		return NULL;
> >  
> >  	tlb_addr = slot_addr(pool->start, index);
> > +	if (!PAGE_ALIGNED(tlb_addr)) {
> > +		dev_WARN_ONCE(dev, 1, "Cannot return 'struct page *' for non page-aligned swiotlb addr 0x%pa.\n",
> > +			      &tlb_addr);
> > +		swiotlb_release_slots(dev, tlb_addr);
> > +		return NULL;
> > +	}
> >  
> >  	return pfn_to_page(PFN_DOWN(tlb_addr));
> 
> So PFN_DOWN aligns the address and thus per se converting the unaligned
> address isn't a problem.

Hmm, I'm not sure I follow why it isn't a problem. If the first 2KiB slot
of the 4KiB page has already been allocated to somebody else, isn't it a
big problem to align down like that? Maybe I should word the warning
message a bit better -- how about:

  "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n"

?

> That being said swiotlb obviously should never
> allocate unaligned addresses, but the placement of this check feels
> odd to me.  Also because it only catches swiotlb_alloc and not the
> map side.
> 
> Maybe just throw a WARN_ON_ONCE into slot_addr() ?

Everything is slot-aligned, so I don't think slot_addr() can detect
this. I put the check in swiotlb_alloc() because I think that's the only
place where we assume that a slot address is page-aligned. I don't think
the map path particularly cares, but if you prefer to have the warning
there too then I think we'd have to stick it at the end of
swiotlb_search_pool_area() (effectively just checking that the returned
slot is consistent with the 'alloc_align_mask' parameter).

Will

