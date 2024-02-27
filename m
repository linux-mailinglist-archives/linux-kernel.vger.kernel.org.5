Return-Path: <linux-kernel+bounces-83308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC18691A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53EFFB28FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E413B2A7;
	Tue, 27 Feb 2024 13:22:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7091332A7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040174; cv=none; b=A5u7e8godFVDTDqKl/r9RghQwNWiDHl3tN7SUmm6xnbHIi8v/1yflx/GbgrT5hTiP2O1lMMxkOEwr6QAldHHCdOMvfFG/A9drrDvJAh7PYCEOY33Fj8h0xhYRTl0orUJtVsOMljWI7jkJBdi+1zMVI19qAWo/bI0e0UU882VFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040174; c=relaxed/simple;
	bh=lFl7whs//Mq1ga5t4xx9WBQo46JRkdrWTfODsqllbKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJkvjHhh39zIYcn5GuzZrRpRagH8tjJ0w8nzGcOiuv0gVo+uMMZ7s++Q6YgZpw/FAu0uMnya2wDwVdrFaQy2nuGA7OjrNUx5SDvL0GqhynIiXDzQ8hy51N9TviakNVvlN7Fdx6AYFuFQqmaTtKohfHjTX9We3BaI8zEzKgXQKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EA8ADA7;
	Tue, 27 Feb 2024 05:23:29 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03BA3F73F;
	Tue, 27 Feb 2024 05:22:49 -0800 (PST)
Message-ID: <5a94049b-5527-4c05-bce5-e15edebd1b81@arm.com>
Date: Tue, 27 Feb 2024 13:22:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Content-Language: en-GB
To: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <6be819d8-f1f9-4833-81c3-32220617f0c5@arm.com>
 <SN6PR02MB4157CD26C1D9BAC64208D9D8D45A2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR02MB4157CD26C1D9BAC64208D9D8D45A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 9:11 pm, Michael Kelley wrote:
> From: Robin Murphy <robin.murphy@arm.com> Sent: Monday, February 26, 2024 11:36 AM
>>
>> On 21/02/2024 11:35 am, Will Deacon wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> The swiotlb does not support a mapping size > swiotlb_max_mapping_size().
>>> On the other hand, with a 64KB PAGE_SIZE configuration, it's observed that
>>> an NVME device can map a size between 300KB~512KB, which certainly failed
>>> the swiotlb mappings, though the default pool of swiotlb has many slots:
>>>       systemd[1]: Started Journal Service.
>>>    => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
>>>       note: journal-offline[392] exited with irqs disabled
>>>       note: journal-offline[392] exited with preempt_count 1
>>>
>>> Call trace:
>>> [    3.099918]  swiotlb_tbl_map_single+0x214/0x240
>>> [    3.099921]  iommu_dma_map_page+0x218/0x328
>>> [    3.099928]  dma_map_page_attrs+0x2e8/0x3a0
>>> [    3.101985]  nvme_prep_rq.part.0+0x408/0x878 [nvme]
>>> [    3.102308]  nvme_queue_rqs+0xc0/0x300 [nvme]
>>> [    3.102313]  blk_mq_flush_plug_list.part.0+0x57c/0x600
>>> [    3.102321]  blk_add_rq_to_plug+0x180/0x2a0
>>> [    3.102323]  blk_mq_submit_bio+0x4c8/0x6b8
>>> [    3.103463]  __submit_bio+0x44/0x220
>>> [    3.103468]  submit_bio_noacct_nocheck+0x2b8/0x360
>>> [    3.103470]  submit_bio_noacct+0x180/0x6c8
>>> [    3.103471]  submit_bio+0x34/0x130
>>> [    3.103473]  ext4_bio_write_folio+0x5a4/0x8c8
>>> [    3.104766]  mpage_submit_folio+0xa0/0x100
>>> [    3.104769]  mpage_map_and_submit_buffers+0x1a4/0x400
>>> [    3.104771]  ext4_do_writepages+0x6a0/0xd78
>>> [    3.105615]  ext4_writepages+0x80/0x118
>>> [    3.105616]  do_writepages+0x90/0x1e8
>>> [    3.105619]  filemap_fdatawrite_wbc+0x94/0xe0
>>> [    3.105622]  __filemap_fdatawrite_range+0x68/0xb8
>>> [    3.106656]  file_write_and_wait_range+0x84/0x120
>>> [    3.106658]  ext4_sync_file+0x7c/0x4c0
>>> [    3.106660]  vfs_fsync_range+0x3c/0xa8
>>> [    3.106663]  do_fsync+0x44/0xc0
>>>
>>> Since untrusted devices might go down the swiotlb pathway with dma-iommu,
>>> these devices should not map a size larger than swiotlb_max_mapping_size.
>>>
>>> To fix this bug, add iommu_dma_max_mapping_size() for untrusted devices to
>>> take into account swiotlb_max_mapping_size() v.s. iova_rcache_range() from
>>> the iommu_dma_opt_mapping_size().
>>
>> On the basis that this is at least far closer to correct than doing nothing,
>>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>>
>> TBH I'm scared to think about theoretical correctness for all the
>> interactions between the IOVA granule and min_align_mask, since just the
>> SWIOTLB stuff is bad enough, even before you realise the ways that the
>> IOVA allocation isn't necessarily right either. However I reckon as long
>> as we don't ever see a granule smaller than IO_TLB_SIZE, and/or a
>> min_align_mask larger than a granule, then this should probably work
>> well enough as-is.
>>
> 
> I'm not convinced.  The conditions you describe are reasonable
> and reflect upstream code today. But there can still be a failure
> due to attempting to allocate a "too large" swiotlb buffer. It
> happens with a granule of 64K and min_align_mask of 4K - 1 (the
> NVMe case) when the offset passed to iommu_dma_map_page()
> is non-zero modulo 4K.  With this patch, the size passed into
> iommu_dma_map_page() is limited to 252K, but it gets rounded
> up to 256K.  Then swiotlb_tbl_map_single() adds the offset
> modulo 4K.  The result exceeds the 256K limit in swiotlb and
> the mapping fails.
> 
> The case I describe is a reasonable case that happens in the real
> world.  As is, this patch will work most of the time because for
> large xfers the offset is typically at least 4K aligned. But not always.

Indeed that's what my "probably [...] well enough" meant to imply.

I think there's proving to be sufficient complexity here that if it 
turns out we do manage to still hit real-world issues with the coarse 
approximation, that will be the point when any further effort would be 
better spent on finally tackling the thing that's always been on the 
to-do list, where we'd only bounce the unaligned start and/or end 
granules while mapping the rest of the buffer in place.

Cheers,
Robin.

