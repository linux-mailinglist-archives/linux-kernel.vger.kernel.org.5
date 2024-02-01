Return-Path: <linux-kernel+bounces-47986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653B8455B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F711C241D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4415B973;
	Thu,  1 Feb 2024 10:45:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525FB1552F9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784353; cv=none; b=eb32I7i6rM8+5Vv9mpJ8jt+3FhNjjAmSNLVUGbBCLcuzQvyJXa+llHfCz46rWS3WqIpvSUNzxZ5sYFGXNFobLuCwUpgrOFwNrU8yHJpOye+o9it+pkLZDOSK5QAfSrMIeAtFORDhqwAI7LiYBiKXEEYTkylA8u4kAYMCYM2m8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784353; c=relaxed/simple;
	bh=HBm42zRx/RDMK6dmj0sv5Tu8TXRYdczQqGZHuJFKTlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHl5HSJsI5JabF+nKZXETPlyrpRLVl+gvHN/tU63/uNsGRk9gba6CzhL2YC4r29vSPjgkLi2rOncLe8S8hQ7FBlwE2/qiegK3VXDUar4huK7rqAR4bqCvdLDu2+9onkWpZbILPR1wjjDZzwXfjjivKKzt/8GwU45OfVAEIytU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891DD175D;
	Thu,  1 Feb 2024 02:46:32 -0800 (PST)
Received: from [10.57.46.192] (unknown [10.57.46.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABCC3F738;
	Thu,  1 Feb 2024 02:45:47 -0800 (PST)
Message-ID: <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
Date: Thu, 1 Feb 2024 10:45:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per
 dev
Content-Language: en-GB
To: Howard Yen <howardyen@google.com>, hch@lst.de, m.szyprowski@samsung.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 petr.tesarik.ext@huawei.com, rafael@kernel.org, broonie@kernel.org,
 james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20240201093515.849873-1-howardyen@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240201093515.849873-1-howardyen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-01 9:35 am, Howard Yen wrote:
> Add support for multiple coherent rmems per device. This patch addes
> dma_mem_list to device structure to store multiple rmems.
> 
> These multiple rmems can be assigned to the device one by one by
> of_reserved_mem_device_init_by_idx() with the memory-region
> declaration in device tree as below and store the rmem to the dma_mem_list.
> 
> 	device1@0 {
> 		...
> 		memory-region = <&reserved_mem0>, <&reserved_mem1>;
> 		...
> 	};
> 
> When driver tries to allocate memory from the rmems, looks for the first
> available rmem and allocates the memory from this rmem.
> 
> Then if driver removed, of_reserved_mem_device_release() needs to be
> invoked to release all the rmems assigned to the device.
> 
> Signed-off-by: Howard Yen <howardyen@google.com>
> ---
>   include/linux/device.h |  1 +
>   kernel/dma/coherent.c  | 66 +++++++++++++++++++++++++++++++++++-------
>   2 files changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 97c4b046c09d..c8682ee507cf 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -751,6 +751,7 @@ struct device {
>   #ifdef CONFIG_DMA_DECLARE_COHERENT
>   	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
>   					     override */
> +	struct list_head	dma_mem_list;

I'm not necessarily against the idea, but only if it's implemented 
sensibly. If we're going to have a list of these it should *replace* the 
existing pointer, not do this weird thing with both.

Thanks,
Robin.

>   #endif
>   #ifdef CONFIG_DMA_CMA
>   	struct cma *cma_area;		/* contiguous memory area for dma
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index ff5683a57f77..f31befd2e6f8 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -18,6 +18,7 @@ struct dma_coherent_mem {
>   	unsigned long	*bitmap;
>   	spinlock_t	spinlock;
>   	bool		use_dev_dma_pfn_offset;
> +	struct list_head	node;
>   };
>   
>   static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
> @@ -61,6 +62,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
>   	dma_mem->pfn_base = PFN_DOWN(phys_addr);
>   	dma_mem->size = pages;
>   	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
> +	INIT_LIST_HEAD(&dma_mem->node);
>   	spin_lock_init(&dma_mem->spinlock);
>   
>   	return dma_mem;
> @@ -90,10 +92,13 @@ static int dma_assign_coherent_memory(struct device *dev,
>   	if (!dev)
>   		return -ENODEV;
>   
> -	if (dev->dma_mem)
> -		return -EBUSY;
> +	if (!dev->dma_mem) {
> +		dev->dma_mem = mem;
> +		INIT_LIST_HEAD(&dev->dma_mem_list);
> +	}
> +
> +	list_add_tail(&mem->node, &dev->dma_mem_list);
>   
> -	dev->dma_mem = mem;
>   	return 0;
>   }
>   
> @@ -187,12 +192,17 @@ static void *__dma_alloc_from_coherent(struct device *dev,
>   int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>   		dma_addr_t *dma_handle, void **ret)
>   {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
>   
>   	if (!mem)
>   		return 0;
>   
> -	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
> +	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
> +		*ret = __dma_alloc_from_coherent(dev, mem_tmp, size, dma_handle);
> +		if (*ret)
> +			break;
> +	}
> +
>   	return 1;
>   }
>   
> @@ -226,9 +236,19 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
>    */
>   int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
>   {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
> +	int ret = 0;
>   
> -	return __dma_release_from_coherent(mem, order, vaddr);
> +	if (!mem)
> +		return ret;
> +
> +	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
> +		ret = __dma_release_from_coherent(mem_tmp, order, vaddr);
> +		if (ret == 1)
> +			break;
> +	}
> +
> +	return ret;
>   }
>   
>   static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
> @@ -271,9 +291,19 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
>   int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>   			   void *vaddr, size_t size, int *ret)
>   {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
> +	int retval = 0;
>   
> -	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
> +	if (!mem)
> +		return retval;
> +
> +	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
> +		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
> +		if (retval == 1)
> +			break;
> +	}
> +
> +	return retval;
>   }
>   
>   #ifdef CONFIG_DMA_GLOBAL_POOL
> @@ -351,8 +381,22 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
>   static void rmem_dma_device_release(struct reserved_mem *rmem,
>   				    struct device *dev)
>   {
> -	if (dev)
> -		dev->dma_mem = NULL;
> +	struct dma_coherent_mem *mem, *mem_tmp, *q;
> +
> +	if (dev) {
> +		mem = dev_get_coherent_memory(dev);
> +		if (rmem->priv != mem) {
> +			list_for_each_entry_safe(mem_tmp, q, &dev->dma_mem_list, node) {
> +				if (mem_tmp == rmem->priv) {
> +					list_del_init(&mem_tmp->node);
> +					break;
> +				}
> +			}
> +		} else {
> +			list_del_init(&mem->node);
> +			dev->dma_mem = NULL;
> +		}
> +	}
>   }
>   
>   static const struct reserved_mem_ops rmem_dma_ops = {

