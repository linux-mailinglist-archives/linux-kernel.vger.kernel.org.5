Return-Path: <linux-kernel+bounces-90664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86CD87032C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8679285502
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5D3F9D9;
	Mon,  4 Mar 2024 13:38:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44DA3E497
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559482; cv=none; b=WfsUO0L1UMEuKZhAndJ8uhEDb4ferjzEzr9tIC5JDXnGovlFdGi0e6phIlAh7AlW9MAVxWkKegSAjnQVy8PzcysYfG3cRrbOELWIkTGTUAoBEaCY3UvROX1A/2BboKaPxD7hf+LtccAzI40ysTsnfhDzK1DFUhd2MqzCgy+KbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559482; c=relaxed/simple;
	bh=38TJYvdNVrM0MO1RETMbWp4toUBh2E4mWcOxm3EsUJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNrtF4GYcIOBU/A4ljhl/dkgixdyLuwzI02dgltEfulMDFefAOWXuDY2+QURmFaiA8CfHaRrkE7mow6mBG8T2XUJ58H1aWfz/Iq0lBDe4JGsVJnYFaKAv74qoIX98IjhlRW9cjsIplbufC1QijdOnaMtAdNWFJ55aSeFqeHVYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976AF1FB;
	Mon,  4 Mar 2024 05:38:36 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72FC33F738;
	Mon,  4 Mar 2024 05:37:58 -0800 (PST)
Message-ID: <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
Date: Mon, 4 Mar 2024 13:37:56 +0000
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
 Michael Kelley <mhklinux@outlook.com>
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240304120055.56035c21@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2024 11:00 am, Petr Tesařík wrote:
[...]
>> Here's my take on tying all the threads together. There are
>> four alignment combinations:
>>
>> 1. alloc_align_mask: zero; min_align_mask: zero
>> 2. alloc_align_mask: zero; min_align_mask: non-zero
>> 3. alloc_align_mask: non-zero; min_align_mask: zero/ignored
>> 4. alloc_align_mask: non-zero; min_align_mask: non-zero
> 
> What does "min_align_mask: zero/ignored" mean? Under which
> circumstances should be a non-zero min_align_mask ignored?
> 
>> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
>> via swiotlb_map() and swiotlb_tbl_map_single()
>>
>> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
>>
>> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
>>
>> For #1, the returned physical address has no constraints if
>> the requested size is less than a page. For page size or
>> greater, the discussed historical requirement for page
>> alignment applies.
>>
>> For #2, min_align_mask governs the bits of the returned
>> physical address that must match the original address. When
>> needed, swiotlb must also allocate pre-padding aligned to
>> IO_TLB_SIZE that precedes the returned physical address.  A
>> request size <= swiotlb_max_mapping_size() will not exceed
>> IO_TLB_SEGSIZE even with the padding. The historical
>> requirement for page alignment does not apply because the
>> driver has explicitly used the newer min_align_mask feature.
> 
> What is the idea here? Is it the assumption that only old drivers rely
> on page alignment, so if they use min_align_mask, it proves that they
> are new and must not rely on page alignment?

Yes, if a driver goes out of its way to set a min_align_mask which is 
smaller than its actual alignment constraint, that is clearly the 
driver's own bug. Strictly we only need to be sympathetic to drivers 
which predate min_align_mask, when implicitly relying on page alignment 
was all they had.

>> For #3, alloc_align_mask specifies the required alignment. No
>> pre-padding is needed. Per earlier comments from Robin[1],
>> it's reasonable to assume alloc_align_mask (i.e., the granule)
>> is >= IO_TLB_SIZE. The original address is not relevant in
>> determining the alignment, and the historical page alignment
>> requirement does not apply since alloc_align_mask explicitly
>> states the alignment.

FWIW I'm also starting to wonder about getting rid of the alloc_size 
argument and just have SWIOTLB round the end address up to 
alloc_align_mask itself as part of all these calculations. Seems like it 
could potentially end up a little simpler, maybe?

>> For #4, the returned physical address must match the bits
>> in the original address specified by min_align_mask.  swiotlb
>> swiotlb must also allocate pre-padding aligned to
>> alloc_align_mask that precedes the returned physical address.
>> Also per Robin[1], assume alloc_align_mask is >=
>> min_align_mask, which solves the conflicting alignment
>> problem pointed out by Petr[2]. Perhaps we should add a
>> "WARN_ON(alloc_align_mask < min_align_mask)" rather than
>> failing depending on which bits of the original address are
>> set. Again, the historical requirement for page alignment does
>> not apply.
> 
> AFAICS the only reason this works in practice is that there are only
> two in-tree users of min_align_mask: NVMe and Hyper-V. Both use a mask
> of 12 bits, and the IOVA granule size is never smaller than 4K.

If we assume a nonzero alloc_align_mask exclusively signifies iommu-dma, 
then for this situation SWIOTLB should only need to worry about the 
intersection of alloc_align_mask & min_align_mask, since any 
min_align_mask bits larger than the IOVA granule would need to be 
accounted for in the IOVA allocation regardless of SWIOTLB.
> If we want to rely on this, then I propose to make a BUG_ON() rather
> than WARN_ON().

I've just proposed a patch to make it not matter for now - the nature of 
iommu-dma makes it slightly more awkward to prevent SWIOTLB from ever 
seeing this condition at all, so I chose not to do that, but as long as 
swiotlb_tbl_map_single() does *something* for conflicting constraints 
without completely falling over, which swiotlb_tbl_unmap_single can then 
undo again, then it should be fine.

Thanks,
Robin.

