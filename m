Return-Path: <linux-kernel+bounces-88369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73886E08D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E06828D59E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29796CDB5;
	Fri,  1 Mar 2024 11:38:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA66A8AD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293124; cv=none; b=a0yfrXwryrPn6sjSACOTo9mjuQ47ikgpSEHaSskO0yZvLAdo9jUm1nzQEyHCJtJWOuezVOf3O0kGUahNuUStQHT3JprYAfs9c6jeeb+nNAkssQZl1vjtMM3yLS8js0gnyIgFrDO90eGVi5g0zMpB+muId+eK4xaLvUxvPy7rruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293124; c=relaxed/simple;
	bh=Bho0V3L6EalNqI/VaFRZI239nh8uqJQHHjMpb9j/96I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1mSJHmZx0oGOyzdEdUpjPc46LTx2C2qk4yFFDO4TsmnMS1fBiWLZVZJrEE2kknm/t+R/GuNcAt7E6dRHcjwpmoq9FUcF9ga/ES82B0CvtQ2DWdeR4zuh/L5SvA8q1pvC7FI+eZJMojwqZnkuwTwYnODicS7oOa1xjHvyKFFLbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714EB1FB;
	Fri,  1 Mar 2024 03:39:19 -0800 (PST)
Received: from [10.57.67.78] (unknown [10.57.67.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9F1E3F6C4;
	Fri,  1 Mar 2024 03:38:39 -0800 (PST)
Message-ID: <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
Date: Fri, 1 Mar 2024 11:38:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Zelin Deng <zelin.deng@linux.alibaba.com>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 7:19 am, Xuan Zhuo wrote:
> In a typical workflow, we first perform a dma map on an address to
> obtain a dma address, followed by a dma unmap on that address. Generally,
> this process works without issues. However, under certain circumstances,
> we require additional resources to manage these dma addresses. For
> instance, in layered architectures, we pass the dma address to another
> module, but retrieving it back from that module can present some
> challenges. In such cases, we must allocate extra resources to manage
> these dma addresses.
> 
> However, considering that many times the dma unmap operation is actually
> a no-op, if we know in advance that unmap is not necessary, we can save
> on these extra management overheads. Moreover, we can directly skip the
> dma unmap operation. This would be advantageous.
> 
> This tries to resolve the problem of patchset:
> 
>   http://lore.kernel.org/all/20240225032330-mutt-send-email-mst@kernel.org
> 
> For a single packet, virtio-net may submit 1-19 dma addresses to virtio
> core. If the virtio-net maintains the dma addresses will waste too much
> memory when the unmap is not necessary. If the virtio-net retrieves the
> dma addresses of the packet from the virtio core, we need to hold the 19
> dma addresses by one call. And the net drivers maintain the dma is the
> future. So we hope to check the unmap is necessary or not.
> 
> Co-developed-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/iommu/dma-iommu.c   | 11 +++++++++++
>   include/linux/dma-map-ops.h |  1 +
>   include/linux/dma-mapping.h |  5 +++++
>   kernel/dma/mapping.c        | 23 +++++++++++++++++++++++
>   4 files changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..8c661a0e1111 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1706,6 +1706,16 @@ static size_t iommu_dma_opt_mapping_size(void)
>   	return iova_rcache_range();
>   }
>   
> +static bool iommu_dma_opt_can_skip_unmap(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY)

This is nonsense; iommu-dma does not operate on identity domains in the 
first place.

> +		return true;
> +	else
> +		return false;
> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
>   	.alloc			= iommu_dma_alloc,
> @@ -1728,6 +1738,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.unmap_resource		= iommu_dma_unmap_resource,
>   	.get_merge_boundary	= iommu_dma_get_merge_boundary,
>   	.opt_mapping_size	= iommu_dma_opt_mapping_size,
> +	.dma_can_skip_unmap	= iommu_dma_opt_can_skip_unmap,
>   };
>   
>   /*
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4abc60f04209..d508fa90bc06 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -83,6 +83,7 @@ struct dma_map_ops {
>   	size_t (*max_mapping_size)(struct device *dev);
>   	size_t (*opt_mapping_size)(void);
>   	unsigned long (*get_merge_boundary)(struct device *dev);
> +	bool (*dma_can_skip_unmap)(struct device *dev);
>   };
>   
>   #ifdef CONFIG_DMA_OPS
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a658de44ee9..af5d9275f8cc 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -140,6 +140,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs);
>   bool dma_can_mmap(struct device *dev);
> +bool dma_can_skip_unmap(struct device *dev);
>   bool dma_pci_p2pdma_supported(struct device *dev);
>   int dma_set_mask(struct device *dev, u64 mask);
>   int dma_set_coherent_mask(struct device *dev, u64 mask);
> @@ -249,6 +250,10 @@ static inline bool dma_can_mmap(struct device *dev)
>   {
>   	return false;
>   }
> +static inline bool dma_can_skip_unmap(struct device *dev)
> +{
> +	return false;
> +}
>   static inline bool dma_pci_p2pdma_supported(struct device *dev)
>   {
>   	return false;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58db8fd70471..99a81932820b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -445,6 +445,29 @@ bool dma_can_mmap(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(dma_can_mmap);
>   
> +/**
> + * dma_can_skip_unmap - check if unmap can be skipped
> + * @dev: device to check
> + *
> + * Returns %true if @dev supports direct map or dma_can_skip_unmap() return true.
> + */
> +bool dma_can_skip_unmap(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (is_swiotlb_force_bounce(dev))
> +		return false;
> +
> +	if (dma_map_direct(dev, ops))
> +		return true;

And this is also broken and nonsensical. What about non-coherent cache 
maintenance, or regular non-forced SWIOTLB bouncing due to per-mapping 
address limitations or buffer alignment, or dma-debug?

Not only is this idea not viable, the entire premise seems flawed - the 
reasons for virtio needing to use the DMA API at all are highly likely 
to be the same reasons for it needing to use the DMA API *properly* anyway.

Thanks,
Robin.

> +
> +	if (ops->dma_can_skip_unmap)
> +		return ops->dma_can_skip_unmap(dev);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(dma_can_skip_unmap);
> +
>   /**
>    * dma_mmap_attrs - map a coherent DMA allocation into user space
>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices

