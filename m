Return-Path: <linux-kernel+bounces-90989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF6870812
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF441F2373A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A060258;
	Mon,  4 Mar 2024 17:11:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345755D72B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572289; cv=none; b=dGultzV3W4VsxgpT0sKyZC23bmnbm1yDZtVo8icGOxyiHROLxuG+bKJjBCegzqg8/72n2U4s1KTGXK4Uv1cGImDZJhpARvT1Yehxl9Tqf6c0ICKl2h4bDUsWDgnM4FKJcXRSkdaQGo6mASGu7HYNwoQFfIqdZ1/foWMSGFHOfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572289; c=relaxed/simple;
	bh=F0AhxNrMQYa399m9SObdQwh9VeOeMmvSZ2t1OUpqLuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evVOUhVb1p7tqCBy2Zyl4rAdc+5YxbKSa9tHXCTrH73cBHTrn3z/2f5zNZkvZXwZL+TDWCg9iAf2BXyptiQN20USzobS0fHChx8yilAPVNJ9qo5BHUwKy/hvFAYT1gi9OOixLYew5sGLd9/gocB/xRyRZfzTp5+8wn5xA+9oDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C4C1FB;
	Mon,  4 Mar 2024 09:12:04 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B83A73F73F;
	Mon,  4 Mar 2024 09:11:25 -0800 (PST)
Message-ID: <d7bd7dce-ead2-4c9b-bb47-d4029c3ce6f7@arm.com>
Date: Mon, 4 Mar 2024 17:11:23 +0000
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
To: Michael Kelley <mhklinux@outlook.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
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
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
 <SN6PR02MB41576F53BE9B88EB52BBDC10D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR02MB41576F53BE9B88EB52BBDC10D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2024 4:04 pm, Michael Kelley wrote:
> From: Petr Tesařík <petr@tesarici.cz> Sent: Monday, March 4, 2024 7:55 AM
>>
>> On Mon, 4 Mar 2024 13:37:56 +0000
>> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>>> On 04/03/2024 11:00 am, Petr Tesařík wrote:
>>> [...]
>>>>> Here's my take on tying all the threads together. There are
>>>>> four alignment combinations:
>>>>>
>>>>> 1. alloc_align_mask: zero; min_align_mask: zero
>>>>> 2. alloc_align_mask: zero; min_align_mask: non-zero
>>>>> 3. alloc_align_mask: non-zero; min_align_mask: zero/ignored
>>>>> 4. alloc_align_mask: non-zero; min_align_mask: non-zero
>>>>
>>>> What does "min_align_mask: zero/ignored" mean? Under which
>>>> circumstances should be a non-zero min_align_mask ignored?
> 
> "Ignored" was my short-hand for the swiotlb_alloc() case where
> orig_addr is zero.  Even if min_align_mask is set for the device, it
> doesn't have any effect when orig_addr is zero.
> 
>>>>
>>>>> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
>>>>> via swiotlb_map() and swiotlb_tbl_map_single()
>>>>>
>>>>> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
>>>>>
>>>>> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
>>>>>
>>>>> For #1, the returned physical address has no constraints if
>>>>> the requested size is less than a page. For page size or
>>>>> greater, the discussed historical requirement for page
>>>>> alignment applies.
>>>>>
>>>>> For #2, min_align_mask governs the bits of the returned
>>>>> physical address that must match the original address. When
>>>>> needed, swiotlb must also allocate pre-padding aligned to
>>>>> IO_TLB_SIZE that precedes the returned physical address.  A
>>>>> request size <= swiotlb_max_mapping_size() will not exceed
>>>>> IO_TLB_SEGSIZE even with the padding. The historical
>>>>> requirement for page alignment does not apply because the
>>>>> driver has explicitly used the newer min_align_mask feature.
>>>>
>>>> What is the idea here? Is it the assumption that only old drivers rely
>>>> on page alignment, so if they use min_align_mask, it proves that they
>>>> are new and must not rely on page alignment?
>>>
>>> Yes, if a driver goes out of its way to set a min_align_mask which is
>>> smaller than its actual alignment constraint, that is clearly the
>>> driver's own bug. Strictly we only need to be sympathetic to drivers
>>> which predate min_align_mask, when implicitly relying on page alignment
>>> was all they had.
>>>
>>>>> For #3, alloc_align_mask specifies the required alignment. No
>>>>> pre-padding is needed. Per earlier comments from Robin[1],
>>>>> it's reasonable to assume alloc_align_mask (i.e., the granule)
>>>>> is >= IO_TLB_SIZE. The original address is not relevant in
>>>>> determining the alignment, and the historical page alignment
>>>>> requirement does not apply since alloc_align_mask explicitly
>>>>> states the alignment.
>>>
>>> FWIW I'm also starting to wonder about getting rid of the alloc_size
>>> argument and just have SWIOTLB round the end address up to
>>> alloc_align_mask itself as part of all these calculations. Seems like it
>>> could potentially end up a little simpler, maybe?
> 
> Yes, I was thinking exactly this.  But my reasoning was to solve the
> bug in #4 that I previously pointed out.  If iommu_dma_map_page()
> does *not* do
> 
> 	aligned_size = iova_align(iovad, size);
> 
> but swiotlb_tbl_map_single() rounds up the size based on
> alloc_align_mask *after* adding the offset modulo
> min_align_mask, then the rounded-up size won't exceed IO_TLB_SIZE,
> regardless of which bits are set in orig_addr.

Ah, neat, I had a gut feeling that something like that might also fall 
out, I just didn't feel like working through the details to see if 
"simpler" could lead to "objectively better" :)

I guess at worst we might also need to pass an alloc_align_mask to 
swiotlb_max_mapping_size() as well, but even that's not necessarily a 
bad thing if it keeps the equivalent calculations close together within 
SWIOTLB and makes things more robust overall.

Cheers,
Robin.

