Return-Path: <linux-kernel+bounces-88725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD486E5D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C2A1F220DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B53A292;
	Fri,  1 Mar 2024 16:38:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D31FDB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311119; cv=none; b=N5E8j6LkSS9u23/KXOPZ88T6EUJOhTU7WsGBceftB5d46QIeCfCPPOKUdkpwU2xXAC6K0bOjkwDixU6SWBdWVm7e8wiJ1QIEa2qu+bEIiMUhe+osawdb1f3ImSN00wqxAoaLLY+UJ8iz8njtH1fsFQY6cDqVGtUHlmxgNvB8Bcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311119; c=relaxed/simple;
	bh=qrrimEnDkMs4q4acxDFMqu61Fpou7nGw9xqMBx1dwyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKVPd2VcprvGcz/86pLrFofBtq2VT+ShFlP2Q9MiKaTJJb786zT/aZ7dNOixi8Q/fxsHftt54h0+8ghRmSsV+x0FDZBPVxRyou1MehG50zrMGHnHCFwKWSBYvZAA5tJuUnqvFKQcXKRFFnYudd56bTCpWLOp/0gwg9taw1Qbps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 228791FB;
	Fri,  1 Mar 2024 08:39:15 -0800 (PST)
Received: from [10.57.67.78] (unknown [10.57.67.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 316713F73F;
	Fri,  1 Mar 2024 08:38:35 -0800 (PST)
Message-ID: <4fbcdd49-cd93-4af8-83e2-f1cef0ea2eeb@arm.com>
Date: Fri, 1 Mar 2024 16:38:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Content-Language: en-GB
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Christoph Hellwig <hch@lst.de>
Cc: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229133346.GA7177@lst.de>
 <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240301163927.18358ee2@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-01 3:39 pm, Petr Tesařík wrote:
> On Thu, 29 Feb 2024 16:47:56 +0100
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote:
>>> Any thoughts on how that historical behavior should apply if
>>> the DMA min_align_mask is non-zero, or the alloc_align_mask
>>> parameter to swiotbl_tbl_map_single() is non-zero? As currently
>>> used, alloc_align_mask is page aligned if the IOMMU granule is
>>>> = PAGE_SIZE. But a non-zero min_align_mask could mandate
>>> returning a buffer that is not page aligned. Perhaps do the
>>> historical behavior only if alloc_align_mask and min_align_mask
>>> are both zero?
>>
>> I think the driver setting min_align_mask is a clear indicator
>> that the driver requested a specific alignment and the defaults
>> don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
>> I'd have to tak a closer look at how it is used.
> 
> I'm not sure it helps in this discussion, but let me dive into a bit
> of ancient history to understand how we ended up here.
> 
> IIRC this behaviour was originally motivated by limitations of PC AT
> hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
> usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
> added a page register, but it was on a separate chip and it did not
> increment when the 8237 address rolled over back to zero. Effectively,
> the page register selected a 64K-aligned window of 64K buffers.
> Consequently, DMA buffers could not cross a 64K physical boundary.
> 
> Thanks to how the buddy allocator works, the 64K-boundary constraint
> was satisfied by allocation size, and drivers took advantage of it when
> allocating device buffers. IMO software bounce buffers simply followed
> the same logic that worked for buffers allocated by the buddy allocator.
> 
> OTOH min_align_mask was motivated by NVME which prescribes the value of
> a certain number of low bits in the DMA address (for simplicity assumed
> to be identical with the same bits in the physical address).
> 
> The only pre-existing user of alloc_align_mask is x86 IOMMU code, and
> IIUC it is used to guarantee that unaligned transactions do not share
> the IOMMU granule with another device. This whole thing is weird,
> because swiotlb_tbl_map_single() is called like this:
> 
>                  aligned_size = iova_align(iovad, size);
>                  phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
>                                                iova_mask(iovad), dir, attrs);
> 
> Here:
> 
> * alloc_size = iova_align(iovad, size)
> * alloc_align_mask = iova_mask(iovad)
> 
> Now, iova_align() rounds up its argument to a multiple of iova granule
> and iova_mask() is simply "granule - 1". This works, because granule
> size must be a power of 2, and I assume it must also be >= PAGE_SIZE.

Not quite, the granule must *not* be larger than PAGE_SIZE (but can be 
smaller).
> In that case, the alloc_align_mask argument is not even needed if you
> adjust the code to match documentation---the resulting buffer will be
> aligned to a granule boundary by virtue of having a size that is a
> multiple of the granule size.

I think we've conflated two different notions of "allocation" here. The 
page-alignment which Christoph quoted applies for dma_alloc_coherent(), 
which nowadays *should* only be relevant to SWIOTLB code in the 
swiotlb_alloc() path for stealing coherent pages out of restricted DMA 
pools. Historically there was never any official alignment requirement 
for the DMA addresses returned by dma_map_{page,sg}(), until 
min_align_mask was introduced.

> To sum it up:
> 
> 1. min_align_mask is by far the most important constraint. Devices will
>     simply stop working if it is not met.
> 2. Alignment to the smallest PAGE_SIZE order which is greater than or
>     equal to the requested size has been documented, and some drivers
>     may rely on it.

Strictly it stopped being necessary since fafadcd16595 when the 
historical swiotlb_alloc() was removed, but 602d9858f07c implies that 
indeed the assumption of it for streaming mappings had already set in. 
Of course NVMe is now using min_align_mask, but I'm not sure if it's 
worth taking the risk to find out who else should also be.

> 3. alloc_align_mask is a misguided fix for a bug in the above.

No, alloc_align_mask is about describing the explicit requirement rather 
than relying on any implicit behaviour, and thus being able to do the 
optimal thing for, say, a 9KB mapping given a 4KB IOVA granule and 64KB 
PAGE_SIZE.

Thanks,
Robin.

> 
> Correct me if anything of the above is wrong.
> 
> HTH
> Petr T

