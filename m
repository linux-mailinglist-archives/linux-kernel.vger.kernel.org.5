Return-Path: <linux-kernel+bounces-52910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A07849E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE03284600
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D12D608;
	Mon,  5 Feb 2024 15:31:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0F2E62D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147089; cv=none; b=rfRkeIjW3cZhTX+FDzs/zlnlM4ds90FjrikPHfEDhldsqeL1BxUUsjbXifa6l6OJFoMVLYVQBURJhOIrXbzIQ5Q8pvnkMVUfzM4Sfv2f5xgVhNVlY40JY4eoxFmggPQiii0fTWN+iX3AIazUg/IV/OcBCBTRNTJf3p+AmgnCw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147089; c=relaxed/simple;
	bh=PAaLfq1+tFXNrEbkJPjr9G9Uf3/OArH2xI/HNdPVMkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HjQZRBg9os84gpTgRMLnn8JLENJEGftB8Y04cL+Eb5KTQo7QOCrI9DpvFa+aCVMXSWaZdFre7qChw5ykK5TtevCim2hfNHE6UJsp10P8ORbe+/5K5wPZ0MRy0CLA8OghaBNG4FdWivIr+mVtIIlEZ7aPib+2hR63hgrnfd7ZvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 365A01FB;
	Mon,  5 Feb 2024 07:32:08 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065C03F5A1;
	Mon,  5 Feb 2024 07:31:23 -0800 (PST)
Message-ID: <ab3407c0-da7c-4e80-892d-87b1b31d0b75@arm.com>
Date: Mon, 5 Feb 2024 15:31:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/iova: use named kmem_cache for iova magazines
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>, joro@8bytes.org,
 will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rientjes@google.com, yosryahmed@google.com
References: <20240202192820.536408-1-pasha.tatashin@soleen.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240202192820.536408-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-02 7:28 pm, Pasha Tatashin wrote:
> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability purpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
> 
> With this change:
> 
>> slabtop -o | head
>   Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>   Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>   Active / Total Caches (% used)     : 135 / 211 (64.0%)
>   Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>   Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> 
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>   91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>   75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> 
> On this machine it is now clear that magazine use 242M of kmem memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   drivers/iommu/iova.c | 70 ++++++++++++++++++++++++++------------------
>   1 file changed, 42 insertions(+), 28 deletions(-)
> 
> Changelog:
> v2: - Use iova_cache_get/iova_cache_put to allocate/free
>        "iova_magazine_cache" as suggested by Robin Murphy
>      - Minor fix in the commit log.
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d30e453d0fb4..88255f9443b5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -237,6 +237,35 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	return -ENOMEM;
>   }
>   
> +/*
> + * Magazine caches for IOVA ranges.  For an introduction to magazines,
> + * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
> + * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
> + * For simplicity, we use a static magazine size and don't implement the
> + * dynamic size tuning described in the paper.
> + */
> +
> +/*
> + * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> + * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
> + * will be wasted. Since only full magazines are inserted into the depot,
> + * we don't need to waste PFN capacity on a separate list head either.
> + */
> +#define IOVA_MAG_SIZE 127
> +
> +#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> +
> +struct iova_magazine {
> +	union {
> +		unsigned long size;
> +		struct iova_magazine *next;
> +	};
> +	unsigned long pfns[IOVA_MAG_SIZE];
> +};
> +
> +static_assert(!(sizeof(struct iova_magazine) & (sizeof(struct iova_magazine) - 1)));

Hmm, moving all this lot is a bit nasty, but I can see the current code 
layout forces you to need sizeof(struct iova_magazine) earlier... :(

> +
> +static struct kmem_cache *iova_magazine_cache;
>   static struct kmem_cache *iova_cache;
>   static unsigned int iova_cache_users;
>   static DEFINE_MUTEX(iova_cache_mutex);
> @@ -275,6 +304,16 @@ int iova_cache_get(void)
>   			pr_err("Couldn't create iova cache\n");
>   			return -ENOMEM;
>   		}
> +
> +		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
> +							sizeof(struct iova_magazine),
> +							0, SLAB_HWCACHE_ALIGN, NULL);
> +		if (!iova_magazine_cache) {
> +			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
> +			mutex_unlock(&iova_cache_mutex);
> +			pr_err("Couldn't create iova magazine cache\n");
> +			return -ENOMEM;

And you're also strictly missing cleanup of iova_cache here. However 
again I think that's more the fault of the existing code for being 
clunky. Rather than drag out this review any more, though, I figured I'd 
just sort it all out - patches incoming :)

Cheers,
Robin.

> +		}
>   	}
>   
>   	iova_cache_users++;
> @@ -295,6 +334,7 @@ void iova_cache_put(void)
>   	if (!iova_cache_users) {
>   		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>   		kmem_cache_destroy(iova_cache);
> +		kmem_cache_destroy(iova_magazine_cache);
>   	}
>   	mutex_unlock(&iova_cache_mutex);
>   }
> @@ -612,32 +652,6 @@ reserve_iova(struct iova_domain *iovad,
>   }
>   EXPORT_SYMBOL_GPL(reserve_iova);
>   
> -/*
> - * Magazine caches for IOVA ranges.  For an introduction to magazines,
> - * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
> - * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
> - * For simplicity, we use a static magazine size and don't implement the
> - * dynamic size tuning described in the paper.
> - */
> -
> -/*
> - * As kmalloc's buffer size is fixed to power of 2, 127 is chosen to
> - * assure size of 'iova_magazine' to be 1024 bytes, so that no memory
> - * will be wasted. Since only full magazines are inserted into the depot,
> - * we don't need to waste PFN capacity on a separate list head either.
> - */
> -#define IOVA_MAG_SIZE 127
> -
> -#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> -
> -struct iova_magazine {
> -	union {
> -		unsigned long size;
> -		struct iova_magazine *next;
> -	};
> -	unsigned long pfns[IOVA_MAG_SIZE];
> -};
> -static_assert(!(sizeof(struct iova_magazine) & (sizeof(struct iova_magazine) - 1)));
>   
>   struct iova_cpu_rcache {
>   	spinlock_t lock;
> @@ -658,7 +672,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   {
>   	struct iova_magazine *mag;
>   
> -	mag = kmalloc(sizeof(*mag), flags);
> +	mag = kmem_cache_alloc(iova_magazine_cache, flags);
>   	if (mag)
>   		mag->size = 0;
>   
> @@ -667,7 +681,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   
>   static void iova_magazine_free(struct iova_magazine *mag)
>   {
> -	kfree(mag);
> +	kmem_cache_free(iova_magazine_cache, mag);
>   }
>   
>   static void

