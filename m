Return-Path: <linux-kernel+bounces-20952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB18287BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53323283E92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FF39877;
	Tue,  9 Jan 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="aAyidV3w"
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4339848;
	Tue,  9 Jan 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id A125F4403F1;
	Tue,  9 Jan 2024 16:04:42 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1704809082;
	bh=nWkMWvzxZARucV9BKvxgMiKFVZFgW9ZAI35CPkgiN1w=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=aAyidV3wDfegVJgn3hj2aDw+IJDBsWlDNykw4JwSxDMX60QxAwvxku7WYwfhglKQX
	 2r0YYJ4vBr+Je8oNZDOdl03Cx6gpEWss69lfGvbPCQRUa+su3KRCQ2L5JP5uk8NSsT
	 gKR3SjuvtHwmVr93lXLKe85z8EGw5nJYRq2LITFBorKEpSQoWSM5eydLbl6TM5LuMc
	 qXaOIwyps6aHgGJmM3j3vuH3oGosFp6h+DNn1Bl79twF0pH0Ke49ZYDFe/6A7k52C/
	 2zLQhUqhtvbGT9bWpW1uWcR/oxlGh2ALKR9AqV8kfKCO+UVdQa2VwrxbqNbvbyDtKL
	 AZGd+7diylz+Q==
References: <cover.1703683642.git.baruch@tkos.co.il>
 <fae5b1180161a7d8cd626a96f5df80b0a0796b8b.1703683642.git.baruch@tkos.co.il>
 <ZZw3FDy8800NScEk@arm.com> <87msterf7b.fsf@tarshish>
 <ZZ0mAxGupZKRPzWR@arm.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Baruch Siach <baruch@tkos.co.il>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>, Ramon Fried
 <ramon@neureality.ai>, Elad
 Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC 3/4] dma-direct: add offset to zone_dma_bits
Date: Tue, 09 Jan 2024 15:54:13 +0200
In-reply-to: <ZZ0mAxGupZKRPzWR@arm.com>
Message-ID: <871qaqr477.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Catalin,

On Tue, Jan 09 2024, Catalin Marinas wrote:
> On Tue, Jan 09, 2024 at 12:03:43PM +0200, Baruch Siach wrote:
>> On Mon, Jan 08 2024, Catalin Marinas wrote:
>> > On Wed, Dec 27, 2023 at 05:04:27PM +0200, Baruch Siach wrote:
>> >> Current code using zone_dma_bits assume that all addresses range in the
>> >> bits mask are suitable for DMA. For some existing platforms this
>> >> assumption is not correct. DMA range might have non zero lower limit.
>> >> 
>> >> Add 'zone_dma_off' for platform code to set base address for DMA zone.
>> >> 
>> >> Rename the dma_direct_supported() local 'min_mask' variable to better
>> >> describe its use as limit.
>> >> 
>> >> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> >
>> > When I suggested taking the DMA offsets into account, that's not exactly
>> > what I meant. Based on patch 4, it looks like zone_dma_off is equivalent
>> > to the lower CPU address. Let's say a system has DRAM starting at 2GB
>> > and all 32-bit DMA-capable devices has a DMA offset of 0. We want
>> > ZONE_DMA32 to end at 4GB rather than 6GB.
>> 
>> Patch 4 sets zone_dma_off to the lower limit from 'dma-ranges' property
>> that determines zone_dma_bits. This is not necessarily equivalent to
>> start of DRAM, though it happens to be that way on my platform.
>
> A bit better but it still assumes that all devices have the same DMA
> offset which may not be the case.

Current code calculates zone_dma_bits based on the lowest high limit of
all 'dma-ranges' properties. The assumption appears to be that this
limit fits all devices. This series does not change this assumption. It
only extends the logic to the lower limit of the "winning" 'dma-ranges'
to set the base address for DMA zone.

Moving to dma_zone_limit would not change that logic. Unless I'm missing
something.

Breaking the "one DMA zone fits all devices" assumption as Petr
suggested is a much larger change.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

