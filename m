Return-Path: <linux-kernel+bounces-43416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01B5841393
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4CA28212C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C134657A8;
	Mon, 29 Jan 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsW6O62a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F73C46E;
	Mon, 29 Jan 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556921; cv=none; b=ZaaJTyTTyCn2VF42prvBEoV5ggGXxhZAnFXpdQAEYZwRyHU+ncM54teZwlGzm0FSjefGXMfOG+lifX74y0NX2xwaCLNT6uKs4jUa4awKGQL+bgyT4rYXCrPYldMIHcq+estVaQiPtdFF9wpBgUoIzbCaMfnof/gZrxytzg4G1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556921; c=relaxed/simple;
	bh=MdzYGcX3JTNLyple3VXL3xNSfVq5OEDEM9mcczJO+r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZx3NY8pPjLgR971K7VEVY3KFAWC+GW52ksE04mHQJUlRAjTTyjaMovuFmKbZfu42SzQ9YjKa2GP+F9zQT5QyMXW69P42UOjmYGJivLu7DPViGEghdERFUtunImP+bGPHdwL7ZVVYH9zslBFxjzUompIz70bR9pcQvDavvxMbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsW6O62a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D41C433C7;
	Mon, 29 Jan 2024 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706556920;
	bh=MdzYGcX3JTNLyple3VXL3xNSfVq5OEDEM9mcczJO+r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsW6O62afkjRG2OMXoLdYMKwrTpGZ01ulLhkBzWhMf8Hys+ftVylfElq3lftgNZuE
	 uKZi58B/gTENvWbe/veK22qJNNPEXeE5asPcBBl3nDLqdqfY4QqoyGhKusrfWkHscx
	 ROKM5/pyhiCyhXpWSJhOAUrVf/YVaE7Dnp+VNSmOj8RSGJQWJLSWBPiCeSd8gnndZ3
	 iFNt3qKQXdPyuLN7kl8Pb2DxVHli5eYlBZ1o4wff0DrwJgYYhpndYheYbMAN3HcvKe
	 Q/Zqg3TC4YD47JtyslbL+IMgqNo547kLgUAhTMcmUv4ZfO3O7gCSMZ1sIZu4P4txqJ
	 xh2xpO3cyvLQg==
Date: Mon, 29 Jan 2024 19:35:15 +0000
From: Will Deacon <will@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240129193515.GD12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
 <20240126151956.10014-3-will@kernel.org>
 <20240126172355.22a03d13@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126172355.22a03d13@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 26, 2024 at 05:23:55PM +0100, Petr Tesařík wrote:
> On Fri, 26 Jan 2024 15:19:56 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > When allocating pages from a restricted DMA pool in swiotlb_alloc(),
> > the buffer address is blindly converted to a 'struct page *' that is
> > returned to the caller. In the unlikely event of an allocation bug,
> > page-unaligned addresses are not detected and slots can silently be
> > double-allocated.
> > 
> > Add a simple check of the buffer alignment in swiotlb_alloc() to make
> > debugging a little easier if something has gone wonky.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/dma/swiotlb.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
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
> 
> Is there a reason not to use BUG_ON()? If yes, I would at least go for:
> 
> +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
> 
> Other than that, yes, such cheap sanity checking looks like a good idea.

BUG_ON() is generally frowned upon unless there's really no way to proceed.
Since we can fail the allocation here, I think that's the best bet (and hope
that whoever wanted the buffer isn't all that important).

I'll add the unlikely() in v2, although it sounds like Christoph wants
this moving anyway.

Will

