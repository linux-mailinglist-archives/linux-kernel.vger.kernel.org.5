Return-Path: <linux-kernel+bounces-88409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0286E138
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D9E284029
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817F3E485;
	Fri,  1 Mar 2024 12:42:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F733CD0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296964; cv=none; b=Pqw7Oxh4lOzpcmNLep/s/fEpS8waiIN18dofkP3amqvD4keJiCzLH8C1rF7BlR293FlUt5333b6cJeUc9wGGacOCIkIVzQYq7A64geSL76YGNFjeae0xWoveRpurA0IbEdbKCG85q79YW5YYLel4hl8LZKkHdXImnWV5+HwhQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296964; c=relaxed/simple;
	bh=t992hf53Vycc3JIlhL128nsP3WDitkm3C4upBjGdDZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/zRYITYn9iLbPOGoQ8V02MI93Du6fah05lxNjC9JMwUFQ2qbLFRU1n0tVKjMfefDkk6dUkVWLRaT3MFsBmsqtKtFEYvDOLL1oXp24sRiZLVW+NdcMUgbT3Nb+JiqNE5zQ6V/BNDAcBhDfIxzsAoFu3XnJ6LgfjX04olOEosEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 002921FB;
	Fri,  1 Mar 2024 04:43:20 -0800 (PST)
Received: from [10.57.67.78] (unknown [10.57.67.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6A43F6C4;
	Fri,  1 Mar 2024 04:42:40 -0800 (PST)
Message-ID: <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
Date: Fri, 1 Mar 2024 12:42:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Content-Language: en-GB
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev, Zelin Deng <zelin.deng@linux.alibaba.com>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240301064632-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
> On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
>> Not only is this idea not viable, the entire premise seems flawed - the
>> reasons for virtio needing to use the DMA API at all are highly likely to be
>> the same reasons for it needing to use the DMA API *properly* anyway.
> 
> The idea has nothing to do with virtio per se

Sure, I can see that, but if virtio is presented as the justification 
for doing this then it's the justification I'm going to look at first. 
And the fact is that it *does* seem to have particular significance, 
since having up to 19 DMA addresses involved in a single transfer is 
very much an outlier compared to typical hardware drivers. Furthermore 
the fact that DMA API support was retrofitted to the established virtio 
design means I would always expect it to run up against more challenges 
than a hardware driver designed around the expectation that DMA buffers 
have DMA addresses.

> - we are likely not the
> only driver that wastes a lot of memory (hot in cache, too) keeping DMA
> addresses around for the sole purpose of calling DMA unmap.  On a bunch
> of systems unmap is always a nop and we could save some memory if there
> was a way to find out. What is proposed is an API extension allowing
> that for anyone - not just virtio.

And the point I'm making is that that "always" is a big assumption, and 
in fact for the situations where it is robustly true we already have the 
DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism. I'd consider it rare for DMA 
addresses to be stored in isolation, as opposed to being part of some 
kind of buffer descriptor (or indeed struct scatterlist, for an obvious 
example) that a driver or subsystem still has to keep track of anyway, 
so in general I believe the scope for saving decidedly small amounts of 
memory at runtime is also considerably less than you might be imagining.

Thanks,
Robin.

