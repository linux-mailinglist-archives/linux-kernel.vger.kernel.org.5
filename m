Return-Path: <linux-kernel+bounces-92256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5ED871D94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614BBB22F6D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A459B54;
	Tue,  5 Mar 2024 11:20:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372F454918
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637619; cv=none; b=Q8WG800cMFDiYUkbOPNeaW4xoXwvDUyc79hDXz4TSLAWJZh8L4RH62zKA8jVV48DYSIJOuLjbmsHCq1ZjssozvVMC4Y3QTg2xtDFzTc7HG0nT4Ycw3qRPRjn8rKlURFCvBPrWKHrZH6CjaWQvwxMRRe+UtJlftk0CRdflRYdpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637619; c=relaxed/simple;
	bh=/ZfpEY76n3lIZzpkENlmf3Rerv3oBoFvdkikaHqkrtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIPn4FwXngkkXUG0dM+LgtiD+/V2omaOIXhpoo+HnXAaT0Ux4AmoiE+4hGLG6Ztg8CVixQ7YwKe5K5J/BtxGEosW/h14l1ZqBuWB2sd8+6un+k7QiPs61w12rS+KyWqueZor6cWz4Zh/sBb5n0eLeecSAX47L4LoVAt03Ii2E2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 204351FB;
	Tue,  5 Mar 2024 03:20:53 -0800 (PST)
Received: from [10.57.67.228] (unknown [10.57.67.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A47D23F762;
	Tue,  5 Mar 2024 03:20:14 -0800 (PST)
Message-ID: <555d0e55-a8f8-446d-ab1a-f05e50b33477@arm.com>
Date: Tue, 5 Mar 2024 11:20:13 +0000
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
To: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
 <20240304160210.GB21077@willie-the-truck>
 <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b63d4332-b659-4897-83c7-04e5ad397a69@arm.com>
 <SN6PR02MB41574A920D7511D4E5DCE813D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR02MB41574A920D7511D4E5DCE813D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-04 6:22 pm, Michael Kelley wrote:
> From: Robin Murphy <robin.murphy@arm.com> Sent: Monday, March 4, 2024 8:54 AM
>>
>> On 04/03/2024 4:10 pm, Michael Kelley wrote:
>>> From: Will Deacon <will@kernel.org> Sent: Monday, March 4, 2024 8:02 AM
>>>>
>>>> Hi folks,
>>>>
>>>> On Mon, Mar 04, 2024 at 04:55:06PM +0100, Petr Tesařík wrote:
>>>>> On Mon, 4 Mar 2024 13:37:56 +0000
>>>>> Robin Murphy <robin.murphy@arm.com> wrote:
>>>>>> On 04/03/2024 11:00 am, Petr Tesařík wrote:
>>>>>> [...]
>>>>>>>> Here's my take on tying all the threads together. There are
>>>>>>>> four alignment combinations:
>>>>>>>>
>>>>>>>> 1. alloc_align_mask: zero; min_align_mask: zero
>>>>
>>>> Based on this ^^^ ...
>>>>
>>>>>>>> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
>>>>>>>> via swiotlb_map() and swiotlb_tbl_map_single()
>>>>>>>>
>>>>>>>> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
>>>>>>>>
>>>>>>>> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
>>>>>>>>
>>>>>>>> For #1, the returned physical address has no constraints if
>>>>>>>> the requested size is less than a page. For page size or
>>>>>>>> greater, the discussed historical requirement for page
>>>>>>>> alignment applies.
>>>>
>>>> ... and this ^^^ ...
>>>>
>>>>
>>>>> I believe this patch series is now good as is, except the commit
>>>>> message should make it clear that alloc_align_mask and min_align_mask
>>>>> can both be zero, but that simply means no alignment constraints.
>>>>
>>>> ... my (possibly incorrect!) reading of the thread so far is that we
>>>> should preserve page-aligned allocation in this case if the allocation
>>>> size is >= PAGE_SIZE.
>>>>
>>>> Something like the diff below, to replace this final patch?
>>>>
>>>> Will
>>>>
>>>> --->8
>>>>
>>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>>> index c381a7ed718f..67eac05728c0 100644
>>>> --- a/kernel/dma/swiotlb.c
>>>> +++ b/kernel/dma/swiotlb.c
>>>> @@ -992,6 +992,14 @@ static int swiotlb_search_pool_area(struct device
>>>> *dev, struct io_tlb_pool *pool
>>>>           BUG_ON(!nslots);
>>>>           BUG_ON(area_index >= pool->nareas);
>>>>
>>>> +       /*
>>>> +        * Historically, allocations >= PAGE_SIZE were guaranteed to be
>>>> +        * page-aligned in the absence of any other alignment requirements.
>>>> +        * Since drivers may be relying on this, preserve the old behaviour.
>>>> +        */
>>>> +       if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
>>>> +               alloc_align_mask = PAGE_SIZE - 1;
>>>> +
>>>
>>> Yes, I think that should do it.
>>
>> In principle it might be more logical to fudge this into
>> iotlb_align_mask rather than alloc_align_mask
> 
> I'm not understanding what you are getting at, but maybe we are
> interpreting the historical page alignment requirement differently.
> I think of the page alignment requirement as independent of the
> orig_addr -- the returned physical address should always be exactly
> page aligned, and not offset to match bits in orig_addr.  If that's
> the case, then implementing the page alignment via
> alloc_align_mask is logically the right place. Fudging into
> iotlb_align_mask would do matching of bits in orig_addr.
> 
> Or is there something else I'm not considering?

In short, it's that alloc_align_mask is concerned with how slots are 
allocated, while min_align_mask is concerned with where the data itself 
is bounced (which may also place certain constraints on allocation).

The reason this page-alignment was here in the first place was seemingly 
to serve the original swiotlb_alloc() path, and thus it could be 
considered functionally equivalent to what is now alloc_align_mask. 
However the side-effect it happened to also have for streaming mappings 
was to prevent sufficiently large page-aligned buffers being bounced to 
a non-page-aligned address, which apparently managed to work well enough 
for NVMe until 64K pages became more common and ruined things by being 
too big, and we formalised *that* desired effect into min_align_mask.

I get that forcing io_tlb_align mask here would introduce a stronger 
constraint which affects non-page-aligned buffers as well, and wanting 
to avoid that is perhaps a reasonable concern, so once again I'm really 
just arguing semantics. Given the head-scratching we've been through 
over this already, I think it would be valuable to at least be clearer 
that a significant part of the "old behaviour" is to do the right thing 
for swiotlb_alloc(), which is very much still current and necessary, but 
the reason we're not setting alloc_align_mask there is because doing it 
here also preserves this legacy side-effect which acts as a limited 
version of min_align_mask to preserve page alignment when bouncing.

Cheers,
Robin.

