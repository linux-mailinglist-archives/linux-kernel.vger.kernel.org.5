Return-Path: <linux-kernel+bounces-20734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44E82845E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59DD1F24A99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1D364C7;
	Tue,  9 Jan 2024 10:55:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D036B02;
	Tue,  9 Jan 2024 10:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E5C43394;
	Tue,  9 Jan 2024 10:55:02 +0000 (UTC)
Date: Tue, 9 Jan 2024 10:54:59 +0000
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
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC 3/4] dma-direct: add offset to zone_dma_bits
Message-ID: <ZZ0mAxGupZKRPzWR@arm.com>
References: <cover.1703683642.git.baruch@tkos.co.il>
 <fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il>
 <ZZw3FDy8800NScEk@arm.com>
 <87msterf7b.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msterf7b.fsf@tarshish>

On Tue, Jan 09, 2024 at 12:03:43PM +0200, Baruch Siach wrote:
> On Mon, Jan 08 2024, Catalin Marinas wrote:
> > On Wed, Dec 27, 2023 at 05:04:27PM +0200, Baruch Siach wrote:
> >> Current code using zone_dma_bits assume that all addresses range in the
> >> bits mask are suitable for DMA. For some existing platforms this
> >> assumption is not correct. DMA range might have non zero lower limit.
> >> 
> >> Add 'zone_dma_off' for platform code to set base address for DMA zone.
> >> 
> >> Rename the dma_direct_supported() local 'min_mask' variable to better
> >> describe its use as limit.
> >> 
> >> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > When I suggested taking the DMA offsets into account, that's not exactly
> > what I meant. Based on patch 4, it looks like zone_dma_off is equivalent
> > to the lower CPU address. Let's say a system has DRAM starting at 2GB
> > and all 32-bit DMA-capable devices has a DMA offset of 0. We want
> > ZONE_DMA32 to end at 4GB rather than 6GB.
> 
> Patch 4 sets zone_dma_off to the lower limit from 'dma-ranges' property
> that determines zone_dma_bits. This is not necessarily equivalent to
> start of DRAM, though it happens to be that way on my platform.

A bit better but it still assumes that all devices have the same DMA
offset which may not be the case.

-- 
Catalin

