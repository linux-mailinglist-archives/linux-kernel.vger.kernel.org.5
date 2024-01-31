Return-Path: <linux-kernel+bounces-46755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1C8443A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5731F266C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579A12AACC;
	Wed, 31 Jan 2024 16:03:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C9129A9B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717022; cv=none; b=OWSQIioVjjdkivA5MlxnYUltSmbi07iJA8XeaANNFIJZbBr9RgdSYKActGINaGQqrWIAisoWcs3mAw2EwwdbShvt037d9LWWR/DufQqTeNh02yaX049Cjkqfr4mIroF6MaUk0QxT6ghTkmUmoNBGx+oDBQ9s6wZ5mQ/c44AiI04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717022; c=relaxed/simple;
	bh=6hiDNbhb/+VDQF3BwWp275eYEH+NUPFv+MUhFzE56uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GP2NKvR5cG2K1ah0mAf61TXV+7SVrVG86cczSIyedFaSGZvkk35R5luwxRwT/Pe7gc8bnrebx3fO4/vLQ0A0ILTBCzBmp2YYRECiEvkI2xL62ci6OP9U5QJQ/gxt7W5UTaJYsGORgd3Xb6rPhCM+CK95prnRczbkfeZR6RnFR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E52ADA7;
	Wed, 31 Jan 2024 08:04:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB803F762;
	Wed, 31 Jan 2024 08:03:39 -0800 (PST)
Message-ID: <82f03af0-6505-4c1a-8002-272fa5a7a7d5@arm.com>
Date: Wed, 31 Jan 2024 16:03:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] swiotlb: Honour dma_alloc_coherent() alignment in
 swiotlb_alloc()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-4-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240131122543.14791-4-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2024 12:25 pm, Will Deacon wrote:
> core-api/dma-api-howto.rst states the following properties of
> dma_alloc_coherent():
> 
>    | The CPU virtual address and the DMA address are both guaranteed to
>    | be aligned to the smallest PAGE_SIZE order which is greater than or
>    | equal to the requested size.
> 
> However, swiotlb_alloc() passes zero for the 'alloc_align_mask'
> parameter of swiotlb_find_slots() and so this property is not upheld.
> Instead, allocations larger than a page are aligned to PAGE_SIZE,
> 
> Calculate the mask corresponding to the page order suitable for holding
> the allocation and pass that to swiotlb_find_slots().

I guess this goes back to at least e81e99bacc9f ("swiotlb: Support 
aligned swiotlb buffers") when the explicit argument was added - not 
sure what we do about 5.15 LTS though (unless the answer is to not care...)

As before, though, how much of patch #1 is needed if this comes first?

Cheers,
Robin.

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   kernel/dma/swiotlb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4485f216e620..8ec37006ac70 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1632,12 +1632,14 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>   	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   	struct io_tlb_pool *pool;
>   	phys_addr_t tlb_addr;
> +	unsigned int align;
>   	int index;
>   
>   	if (!mem)
>   		return NULL;
>   
> -	index = swiotlb_find_slots(dev, 0, size, 0, &pool);
> +	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
> +	index = swiotlb_find_slots(dev, 0, size, align, &pool);
>   	if (index == -1)
>   		return NULL;
>   

