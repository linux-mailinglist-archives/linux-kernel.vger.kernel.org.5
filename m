Return-Path: <linux-kernel+bounces-48268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F5A845960
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE70290623
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677C5CDF0;
	Thu,  1 Feb 2024 13:53:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481795336B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795637; cv=none; b=unwy1btm+Bp0yCV1l6dpqlqxiJEbHwOsCOt4Y5iPmkcztZEHuEMZCnI3ZdbaQ18qYpdX8XcXBCfjZcF93WmTucwy02hYAIxUWe9evTQw+OSr3Ch607gKm+rJsFlrpVU8SNwFOzV2W5RXN7hR2FG1oDujJWC592x8FKjgJc5X7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795637; c=relaxed/simple;
	bh=sZjQRuxLUHl+5AIYqAAouxmR7fxPsq7YLcy2TL46L64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4CJkPyIswmaMQ5VXsZ07qhHsBH3zWl/AqBx/nsVBGUTIkzHh1pd3CRZVsnmjE0MyM+F1NzL650+B9MstlFJQfSdP6ERAdaDtC03VmDMkd8czdso3X51EXEIrsgPgrYCYERxpavcL8mcXkMrzXfmpE/YqEDXJV89BCXnkXTwjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564FDDA7;
	Thu,  1 Feb 2024 05:54:36 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7CB83F762;
	Thu,  1 Feb 2024 05:53:52 -0800 (PST)
Message-ID: <eeb06c3d-8f04-4b6c-9dd7-3cb4f4c1cc31@arm.com>
Date: Thu, 1 Feb 2024 13:53:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-3-will@kernel.org>
 <b4045104-7ea4-47b2-ad74-a44bab76c796@arm.com>
 <20240201124816.GB15707@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240201124816.GB15707@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/02/2024 12:48 pm, Will Deacon wrote:
> On Wed, Jan 31, 2024 at 03:14:18PM +0000, Robin Murphy wrote:
>> On 31/01/2024 12:25 pm, Will Deacon wrote:
>>> When allocating pages from a restricted DMA pool in swiotlb_alloc(),
>>> the buffer address is blindly converted to a 'struct page *' that is
>>> returned to the caller. In the unlikely event of an allocation bug,
>>> page-unaligned addresses are not detected and slots can silently be
>>> double-allocated.
>>>
>>> Add a simple check of the buffer alignment in swiotlb_alloc() to make
>>> debugging a little easier if something has gone wonky.
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>> Cc: Dexuan Cui <decui@microsoft.com>
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>    kernel/dma/swiotlb.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index 56cc08b1fbd6..4485f216e620 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -1642,6 +1642,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>>>    		return NULL;
>>>    	tlb_addr = slot_addr(pool->start, index);
>>> +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
>>> +		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
>>> +			      &tlb_addr);
>>
>> Nit: if there's cause for another respin, I'd be inclined to use a
>> straightforward "if (WARN_ON(...))" here - this condition should represent
>> SWIOTLB itself going badly wrong, which isn't really attributable to
>> whatever device happened to be involved in the call.
> 
> Well, there'll definitely be a v3 thanks to my idiotic dropping of the
> 'continue' statement when I reworked the searching loop for v2.
> 
> However, given that we're returning NULL, I think printing the device is
> helpful as we're likely to cause some horrible error (e.g. probe failure)
> in the caller and then it will be obvious why that happened from looking
> at the logs. So I'd prefer to keep it unless you insist.

No, helping to clarify any knock-on effects sounds like a reasonable 
justification to me - I hadn't really considered that angle. I'd still 
be inclined to condense it down to "if (dev_WARN_ONCE(...))" to minimise 
redundancy, but that's really just a matter of personal preference.

Cheers,
Robin.

