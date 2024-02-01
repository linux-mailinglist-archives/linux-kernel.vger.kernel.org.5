Return-Path: <linux-kernel+bounces-48157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9E84580D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F221F27BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75E8664B;
	Thu,  1 Feb 2024 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuiDy2ze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3B86634;
	Thu,  1 Feb 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791702; cv=none; b=S4HAkvReEZ9UmD+H3SWAj22wWbUkHcRk7FjDVOHEUcv39Ohbbf9WhU+0ATYFzR2vSFKQ/YXGkT9IqY5PwAE8GH8KMDr9UxAd6tc7wqyroBm3mt6NV4u/cH7gKfz4KqbsPqwtUAGBxJlAQ++dN5H3MZeJJ+QgeLiFUgfDMnT6WOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791702; c=relaxed/simple;
	bh=YnRtTpNpTQxt2XnhcsroxzL3b51GCvpDICjR9ygSGDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7XR2kdwnwmUbiEvZ1/MagJjfHTgaMua+LCTVAxBiAYRjv2UIzBN8zxiCO0RQY7S2gwN91O0eAy8c++o7zSLQ9gM/4bd4AR0wK3dvOiOwQbFCIY+hT1DSRIGAWztXKwc/jFVEqtIlradjkBc6uOb0WDdqvItCTkhq29J9xGnRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuiDy2ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DDEC433C7;
	Thu,  1 Feb 2024 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706791701;
	bh=YnRtTpNpTQxt2XnhcsroxzL3b51GCvpDICjR9ygSGDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuiDy2zeBXNfjRlxYry3vuawC6QPm/Q4DOnhZlxds7dCy6sdBMmAXpUCjozdP0saL
	 8799dhAH34b0sm+UZa6o0MkyDfzvcdrHeMzt8b8KPsIkaaLf43RLIYuxIklQO2rAAs
	 m4TGC6TZDULElSexskS7+8OacGitdvteEn7OGnf0tQn1vZ9tHfvB8P97m0NXjOipAy
	 qKlWEblPDCJTEXo9QSKI7ZhfdicfFCmgQ4gkbWZYgt0FdTrS8nx53pFqcm4LAiL0Dw
	 2QD0Od3ytN8iNcY9Qllh/jVUQIsnzJ3WKUNj6vrjzsZI4C/sR6VJOFVKchGQ3I/zUX
	 dTMLBOvinM90g==
Date: Thu, 1 Feb 2024 12:48:16 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 2/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240201124816.GB15707@willie-the-truck>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-3-will@kernel.org>
 <b4045104-7ea4-47b2-ad74-a44bab76c796@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4045104-7ea4-47b2-ad74-a44bab76c796@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 03:14:18PM +0000, Robin Murphy wrote:
> On 31/01/2024 12:25 pm, Will Deacon wrote:
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
> >   kernel/dma/swiotlb.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 56cc08b1fbd6..4485f216e620 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -1642,6 +1642,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
> >   		return NULL;
> >   	tlb_addr = slot_addr(pool->start, index);
> > +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
> > +		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
> > +			      &tlb_addr);
> 
> Nit: if there's cause for another respin, I'd be inclined to use a
> straightforward "if (WARN_ON(...))" here - this condition should represent
> SWIOTLB itself going badly wrong, which isn't really attributable to
> whatever device happened to be involved in the call.

Well, there'll definitely be a v3 thanks to my idiotic dropping of the
'continue' statement when I reworked the searching loop for v2.

However, given that we're returning NULL, I think printing the device is
helpful as we're likely to cause some horrible error (e.g. probe failure)
in the caller and then it will be obvious why that happened from looking
at the logs. So I'd prefer to keep it unless you insist.

Cheers,

Will

