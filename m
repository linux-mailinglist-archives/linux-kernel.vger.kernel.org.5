Return-Path: <linux-kernel+bounces-82247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46FA86811B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6DB1C225CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95312FB3A;
	Mon, 26 Feb 2024 19:36:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EFA22069
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976165; cv=none; b=K4GhvRxdvk0nn1mhRaxqWNQUniqBTNeGJrjJxd1vanmhH8igwo9+wducSQTMX3NqLhudd/ugzcuepe5NFqy/kD3DacGFxwL4WulvXMd/EAZQ9QKG8YxzIsjTR4H4mwLBMGpLtpZVnDXkjvmLhUt3gEgLdRB37L8zUM9caiwhbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976165; c=relaxed/simple;
	bh=UaVvJo8VEL45JixxaiG9F8e+o68JzaMmzhDzuncz1fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xnbcr4D/T3/+ALKIs4z6YcZo75e3T2NkHRWXIbLNEo19AUbv5f6jfXvpoDCIEWPFwQOetxwAnTO2abWzh3GSYqfR2HoUdtUQU5YADZlao7zVCOPvQMzkRQBQM+uGWYw0S06gwhdxmRifql2XQfIgdvXl+5ph7K1/pmDBhUqEsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09272DA7;
	Mon, 26 Feb 2024 11:36:41 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B306A3F762;
	Mon, 26 Feb 2024 11:36:00 -0800 (PST)
Message-ID: <6be819d8-f1f9-4833-81c3-32220617f0c5@arm.com>
Date: Mon, 26 Feb 2024 19:35:59 +0000
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
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240221113504.7161-6-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2024 11:35 am, Will Deacon wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> The swiotlb does not support a mapping size > swiotlb_max_mapping_size().
> On the other hand, with a 64KB PAGE_SIZE configuration, it's observed that
> an NVME device can map a size between 300KB~512KB, which certainly failed
> the swiotlb mappings, though the default pool of swiotlb has many slots:
>      systemd[1]: Started Journal Service.
>   => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
>      note: journal-offline[392] exited with irqs disabled
>      note: journal-offline[392] exited with preempt_count 1
> 
> Call trace:
> [    3.099918]  swiotlb_tbl_map_single+0x214/0x240
> [    3.099921]  iommu_dma_map_page+0x218/0x328
> [    3.099928]  dma_map_page_attrs+0x2e8/0x3a0
> [    3.101985]  nvme_prep_rq.part.0+0x408/0x878 [nvme]
> [    3.102308]  nvme_queue_rqs+0xc0/0x300 [nvme]
> [    3.102313]  blk_mq_flush_plug_list.part.0+0x57c/0x600
> [    3.102321]  blk_add_rq_to_plug+0x180/0x2a0
> [    3.102323]  blk_mq_submit_bio+0x4c8/0x6b8
> [    3.103463]  __submit_bio+0x44/0x220
> [    3.103468]  submit_bio_noacct_nocheck+0x2b8/0x360
> [    3.103470]  submit_bio_noacct+0x180/0x6c8
> [    3.103471]  submit_bio+0x34/0x130
> [    3.103473]  ext4_bio_write_folio+0x5a4/0x8c8
> [    3.104766]  mpage_submit_folio+0xa0/0x100
> [    3.104769]  mpage_map_and_submit_buffers+0x1a4/0x400
> [    3.104771]  ext4_do_writepages+0x6a0/0xd78
> [    3.105615]  ext4_writepages+0x80/0x118
> [    3.105616]  do_writepages+0x90/0x1e8
> [    3.105619]  filemap_fdatawrite_wbc+0x94/0xe0
> [    3.105622]  __filemap_fdatawrite_range+0x68/0xb8
> [    3.106656]  file_write_and_wait_range+0x84/0x120
> [    3.106658]  ext4_sync_file+0x7c/0x4c0
> [    3.106660]  vfs_fsync_range+0x3c/0xa8
> [    3.106663]  do_fsync+0x44/0xc0
> 
> Since untrusted devices might go down the swiotlb pathway with dma-iommu,
> these devices should not map a size larger than swiotlb_max_mapping_size.
> 
> To fix this bug, add iommu_dma_max_mapping_size() for untrusted devices to
> take into account swiotlb_max_mapping_size() v.s. iova_rcache_range() from
> the iommu_dma_opt_mapping_size().

On the basis that this is at least far closer to correct than doing nothing,

Acked-by: Robin Murphy <robin.murphy@arm.com>

TBH I'm scared to think about theoretical correctness for all the 
interactions between the IOVA granule and min_align_mask, since just the 
SWIOTLB stuff is bad enough, even before you realise the ways that the 
IOVA allocation isn't necessarily right either. However I reckon as long 
as we don't ever see a granule smaller than IO_TLB_SIZE, and/or a 
min_align_mask larger than a granule, then this should probably work 
well enough as-is.

Cheers,
Robin.

> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/r/ee51a3a5c32cf885b18f6416171802669f4a718a.1707851466.git.nicolinc@nvidia.com
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/dma-iommu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..7d1a20da6d94 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1706,6 +1706,13 @@ static size_t iommu_dma_opt_mapping_size(void)
>   	return iova_rcache_range();
>   }
>   
> +static size_t iommu_dma_max_mapping_size(struct device *dev)
> +{
> +	if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> +		return swiotlb_max_mapping_size(dev);
> +	return SIZE_MAX;
> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
>   	.alloc			= iommu_dma_alloc,
> @@ -1728,6 +1735,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.unmap_resource		= iommu_dma_unmap_resource,
>   	.get_merge_boundary	= iommu_dma_get_merge_boundary,
>   	.opt_mapping_size	= iommu_dma_opt_mapping_size,
> +	.max_mapping_size       = iommu_dma_max_mapping_size,
>   };
>   
>   /*

