Return-Path: <linux-kernel+bounces-48165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E153845827
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE95286104
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A48665D;
	Thu,  1 Feb 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcjptXF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81786641;
	Thu,  1 Feb 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791946; cv=none; b=VKPU3Vx3XZDY2/7dzzSMz365eAXLTghneBlvz78i/mUzd/HWLjx1v8H1H8kbMiBh0K8hUXz/cCa3LqYg0KjE9N0qoi7TZzxnO75B9TUsM3TAyYbI6XNZLJpllC60e2DTJYxVjnVGvdJQpeRs3jMvityp3y3gtuXlc2weTeVbwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791946; c=relaxed/simple;
	bh=PCBo8l5F3VLXTikLYeqFp207iISLAQXi1tVpHtgpl4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR7RW7lXUAediqcDkQBzT7syS7UTC84zoQq4CDiLrOSeJYrEbp5jbYyupo3pk78hMt8AotwlgVzxgEiupu8saqvb0mgxMZajiguEzjsRSnVxTnbX4o0z1QHueKb1JHSzuhwaRuYWsUjWIGfUXogbvLYtNL0yJ/jiZUeXkjcv6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcjptXF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8E0C433F1;
	Thu,  1 Feb 2024 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706791945;
	bh=PCBo8l5F3VLXTikLYeqFp207iISLAQXi1tVpHtgpl4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcjptXF1UAnvERTZWUHBsEOtU0j6iy7F+XE6eC/vzvN4GnSUAFa8VIxbbJsZ4A4Lb
	 1eoNUYKKPJSgnW/NNZuATH0U1oLjfQFy2CIbwhSrMXCxt5szXZVWG+v9Uhp2zNDBfI
	 BTyka3w7JFP/oKGObj+wiOyMbxgx1UiGi9Mn3KtvGfvbxRqrQWYAOGFdwIpJ1b3oFm
	 67LTnN2zLrFMUzVSoktmR95JnHgnQMKjr5sHfHN9MvurigL9FT5hfDDp36sRAaShxW
	 GB3LxVA3KwkyKWt5Of18/iGugfmoAdrzniozTZxUD20nTEBfVsH2XmGOVn5f6P8IRU
	 SuFbpAVq7DuGw==
Date: Thu, 1 Feb 2024 12:52:20 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 3/3] swiotlb: Honour dma_alloc_coherent() alignment in
 swiotlb_alloc()
Message-ID: <20240201125219.GC15707@willie-the-truck>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-4-will@kernel.org>
 <82f03af0-6505-4c1a-8002-272fa5a7a7d5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f03af0-6505-4c1a-8002-272fa5a7a7d5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 04:03:38PM +0000, Robin Murphy wrote:
> On 31/01/2024 12:25 pm, Will Deacon wrote:
> > core-api/dma-api-howto.rst states the following properties of
> > dma_alloc_coherent():
> > 
> >    | The CPU virtual address and the DMA address are both guaranteed to
> >    | be aligned to the smallest PAGE_SIZE order which is greater than or
> >    | equal to the requested size.
> > 
> > However, swiotlb_alloc() passes zero for the 'alloc_align_mask'
> > parameter of swiotlb_find_slots() and so this property is not upheld.
> > Instead, allocations larger than a page are aligned to PAGE_SIZE,
> > 
> > Calculate the mask corresponding to the page order suitable for holding
> > the allocation and pass that to swiotlb_find_slots().
> 
> I guess this goes back to at least e81e99bacc9f ("swiotlb: Support aligned
> swiotlb buffers") when the explicit argument was added - not sure what we do
> about 5.15 LTS though (unless the answer is to not care...)

Thanks. I'll add the Fixes: tag but, to be honest, if we backport the first
patch then I'm not hugely fussed about this one in -stable kernels simply
because I spotted it my inspection rather than an real failure.

> As before, though, how much of patch #1 is needed if this comes first?

See my reply over there, but I think we need all of this.

Will

