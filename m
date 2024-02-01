Return-Path: <linux-kernel+bounces-48235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9A8458E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC7F1C25AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA35339F;
	Thu,  1 Feb 2024 13:30:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2D5337D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794220; cv=none; b=PLL5qeF9KjSPAXySrPD0xZ68ZqoV/Okf8zkcdgolfK7zO7uaUpd7IpbwsLno9FhPeOOJnOhZnZJdxdfJlojs03wDDtR+s1OSKINWvZKfkIkV40JmOZg3vQKB6zZiBlYGeUUGU4xGj4ZzbZ59PB9cE0AR7bMXjWqBJVkiwPBlg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794220; c=relaxed/simple;
	bh=DFw6Y6AV74nxmXZ6bTlW+4jAaGysDzHyhcexGl8zs4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhwJDf8tbosiYewNpfNFhJU+pBWVR/1RHcXFasHGpSqG10Dz1SkZ98vso0+pKRrEPzIFC0qNnB6m8r0YBG5VxxLcMaQCo1rbgRaFlvhDlkqxfDoiK6jjOtzqOWnfAwQ5DXWHgx0A8UZmdeXlaxSp37+HZq8prNK8MWVMOHc6B6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9013FDA7;
	Thu,  1 Feb 2024 05:31:00 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25553F762;
	Thu,  1 Feb 2024 05:30:16 -0800 (PST)
Message-ID: <c235493f-c28d-43cf-969f-0fb148cb5dda@arm.com>
Date: Thu, 1 Feb 2024 13:30:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] swiotlb: Fix allocation alignment requirement when
 searching slots
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-2-will@kernel.org>
 <4c9f50d2-05f9-4a37-ac50-dcd98e40e87f@arm.com>
 <20240201124634.GA15707@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240201124634.GA15707@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/02/2024 12:46 pm, Will Deacon wrote:
> Hey Robin,
> 
> Cheers for having a look.
> 
> On Wed, Jan 31, 2024 at 03:54:03PM +0000, Robin Murphy wrote:
>> On 31/01/2024 12:25 pm, Will Deacon wrote:
>>> Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
>>> which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
>>> checks"), causes a functional regression with vsock in a virtual machine
>>> using bouncing via a restricted DMA SWIOTLB pool.
>>>
>>> When virtio allocates the virtqueues for the vsock device using
>>> dma_alloc_coherent(), the SWIOTLB search fails to take into account the
>>> 8KiB buffer size and returns page-unaligned allocations if 'area->index'
>>> was left unaligned by a previous allocation from the buffer:
>>
>> Hmm, but isn't this fundamentally swiotlb_alloc()'s fault for assuming it's
>> going to get a page-aligned address back despite asking for 0 alignment in
>> the first place? I'm not sure SWIOTLB has ever promised implicit
>> size-alignment, so it feels somewhat misplaced to be messing with the
>> algorithm before fixing the obvious issue in the caller :/
> 
> It's hard to tell which guarantees are intentional here given that this
> interface is all internal to swiotlb.c, but the 'alloc_align_mask'
> parameter didn't even exist prior to e81e99bacc9f ("swiotlb: Support
> aligned swiotlb buffers") and practically the implementation has ensured
> page-aligned allocations for buffers >= PAGE_SIZE prior to 0eee5ae10256
> ("swiotlb: fix slot alignment checks") by virtue of aligning the search
> index to the stride.
> 
> In any case, this patch is required because the current state of
> swiotlb_search_pool_area() conflates the DMA alignment mask, the
> allocation alignment mask and the stride so that even if a non-zero
> 'alloc_align_mask' is passed in, it won't necessarily be honoured.

Sure, I didn't mean to suggest there wasn't anything to fix here - if 
the existing code was intending to align to PAGE_SIZE even for a 
alloc_align_mask=0 and failing then that's clearly its own bug - I'm 
mostly being confused by the example of returning an unsuitably-aligned 
address for an 8KB dma_alloc_coherent() 75% of the time, if the end 
result of this fix is that we'll *still* return an incorrectly-aligned 
buffer for that same request 50% of the time (which just happens to be 
less fatal), since there are two separate bugs in that path.

Cheers,
Robin.

> 
> For example, I just gave it a spin with only patch #3 and then this log:
> 
>>>    # Final address in brackets is the SWIOTLB address returned to the caller
>>>    | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
> 
> Becomes:
> 
>    | virtio-pci 0000:00:07.0: alloc_size 0x2000, iotlb_align_mask 0x1800 stride 0x4: got slot 1645-1649/7168 (0x98326800)
> 
> So even though the stride is correct, we still end up with a 2KiB aligned
> allocation.
> 
> Cheers,
> 
> Will

