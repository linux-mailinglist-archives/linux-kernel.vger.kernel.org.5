Return-Path: <linux-kernel+bounces-19921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128008276D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160A5284861
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106D54FB3;
	Mon,  8 Jan 2024 17:55:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031A54BC5;
	Mon,  8 Jan 2024 17:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77A9C433C8;
	Mon,  8 Jan 2024 17:55:34 +0000 (UTC)
Date: Mon, 8 Jan 2024 17:55:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>
Subject: Re: [PATCH RFC 3/4] dma-direct: add offset to zone_dma_bits
Message-ID: <ZZw3FDy8800NScEk@arm.com>
References: <cover.1703683642.git.baruch@tkos.co.il>
 <fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il>

On Wed, Dec 27, 2023 at 05:04:27PM +0200, Baruch Siach wrote:
> Current code using zone_dma_bits assume that all addresses range in the
> bits mask are suitable for DMA. For some existing platforms this
> assumption is not correct. DMA range might have non zero lower limit.
> 
> Add 'zone_dma_off' for platform code to set base address for DMA zone.
> 
> Rename the dma_direct_supported() local 'min_mask' variable to better
> describe its use as limit.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>

When I suggested taking the DMA offsets into account, that's not exactly
what I meant. Based on patch 4, it looks like zone_dma_off is equivalent
to the lower CPU address. Let's say a system has DRAM starting at 2GB
and all 32-bit DMA-capable devices has a DMA offset of 0. We want
ZONE_DMA32 to end at 4GB rather than 6GB.

> @@ -59,7 +60,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  	 * zones.
>  	 */
>  	*phys_limit = dma_to_phys(dev, dma_limit);
> -	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
> +	if (*phys_limit <= zone_dma_off + DMA_BIT_MASK(zone_dma_bits))
>  		return GFP_DMA;
>  	if (*phys_limit <= DMA_BIT_MASK(32))
>  		return GFP_DMA32;

Ah, you ignore the zone_dma_off for 32-bit calculations. But the
argument still stands, the start of DRAM does not necessarily mean that
all non-64-bit devices have such DMA offset.

The current dma_direct_optimal_gfp_mask() confuses me a bit, I think it
gives the wrong flag if we have a zone_dma_bits of 30 and a device with
a coherent_dma_mask of 31, it incorrectly ends up with GFP_DMA32 (I'm
ignoring dma offsets in this example). Luckily I don't think we have any
set up where this would fail. Basically if *phys_limit is strictly
smaller than DMA_BIT_MASK(32), we want GFP_DMA rather than GFP_DMA32
even if it is larger than DMA_BIT_MASK(zone_dma_bits).

Anyway, current mainline assumes that DMA_BIT_MASK(zone_dma_bits) and
DMA_BIT_MASK(32) are CPU addresses. The problem is that we may have the
start of RAM well above 4GB and neither ZONE_DMA nor ZONE_DMA32 upper
limits would be a power-of-two. We could change the DMA_BIT_MASK(...) to
be DMA address limits and we end up with something like:

static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
{
	u64 dma_limit = min_not_zero(
		dev->coherent_dma_mask,
		dev->bus_dma_limit);
	u64 dma32_limit = dma_to_phys(dev, DMA_BIT_MASK(32));

	*phys_limit = dma_to_phys(dev, dma_limit);
	if (*phys_limit > dma_limit)
		return 0;
	if (*phys_limit = dma32_limit)
		return GFP_DMA32;
	return GFP_DMA;
}

The alternative is to get rid of the *_bits variants and go for
zone_dma_limit and zone_dma32_limit in the generic code. For most
architectures they would match the current DMA_BIT_MASK(32) etc. but
arm64 would be able to set some higher values.

My preference would be to go for zone_dma{,32}_limit, it's easier to
change all the places where DMA_BIT_MASK({zone_dma_bits,32}) is used.

-- 
Catalin

