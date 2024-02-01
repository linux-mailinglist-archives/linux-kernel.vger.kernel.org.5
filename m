Return-Path: <linux-kernel+bounces-48832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BB84622D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39621F26592
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D63CF48;
	Thu,  1 Feb 2024 20:56:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756B3B19E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820970; cv=none; b=gDp3RRv+prhg50KBhSJjhj/PhOL1Qj719Ad6sMqeZo0z869E4g/Vc9AstbdTKJdGJi6Z9Q8gvZDEeG+s2Js5w+MGW30O6ImzP/4pgn+JJiDTH/8Hd/HGDQMmxXwoeNF5eUnxaRuo/4wMX6i+CC/mZIpsYa/y+jvlyhwPaUveFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820970; c=relaxed/simple;
	bh=hV2Pa9TpTnqHiwHmL171NsgT80DhhsKgfd2bCkMYvCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BiFofCKxTXzpGYVX4z491AnKQrGitxX7uGCQowRGfYH30VRA0rx5bfKlpT0lw1mQBy5uHR7yxf7iF68Rhc9sPqwzJwHG8rzl5nMp7ieIfhEZifjyK1CKjUP6v1pfn9XPYpO5hX8rYLWZJYjpQyrwdHGiissriNAc8fjCjur7Zek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4886DA7;
	Thu,  1 Feb 2024 12:56:49 -0800 (PST)
Received: from [10.57.47.101] (unknown [10.57.47.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF6AB3F762;
	Thu,  1 Feb 2024 12:56:05 -0800 (PST)
Message-ID: <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
Date: Thu, 1 Feb 2024 20:56:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>, joro@8bytes.org,
 will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rientjes@google.com
References: <20240201193014.2785570-1-tatashin@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240201193014.2785570-1-tatashin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-01 7:30 pm, Pasha Tatashin wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability prurpose create named slab cache so
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

Hmm, something smells there...

In the "worst" case there should be a maximum of 6 * 2 * 
num_online_cpus() empty magazines in the iova_cpu_rcache structures, 
i.e., 12KB per CPU. Under normal use those will contain at least some 
PFNs, but mainly every additional magazine stored in a depot is full 
with 127 PFNs, and each one of those PFNs is backed by a 40-byte struct 
iova, i.e. ~5KB per 1KB magazine. Unless that machine has many thousands 
of CPUs, if iova_magazine allocations are the top consumer of memory 
then something's gone wrong.

Thanks,
Robin.

> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d30e453d0fb4..617bbc2b79f5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>   
>   #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
>   
> +static struct kmem_cache *iova_magazine_cache;
> +static unsigned int iova_magazine_cache_users;
> +static DEFINE_MUTEX(iova_magazine_cache_mutex);
> +
>   struct iova_magazine {
>   	union {
>   		unsigned long size;
> @@ -654,11 +658,51 @@ struct iova_rcache {
>   	struct delayed_work work;
>   };
>   
> +static int iova_magazine_cache_init(void)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&iova_magazine_cache_mutex);
> +
> +	iova_magazine_cache_users++;
> +	if (iova_magazine_cache_users > 1)
> +		goto out_unlock;
> +
> +	iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
> +						sizeof(struct iova_magazine),
> +						0, SLAB_HWCACHE_ALIGN, NULL);
> +
> +	if (!iova_magazine_cache) {
> +		pr_err("Couldn't create iova magazine cache\n");
> +		ret = -ENOMEM;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&iova_magazine_cache_mutex);
> +
> +	return ret;
> +}
> +
> +static void iova_magazine_cache_fini(void)
> +{
> +	mutex_lock(&iova_magazine_cache_mutex);
> +
> +	if (WARN_ON(!iova_magazine_cache_users))
> +		goto out_unlock;
> +
> +	iova_magazine_cache_users--;
> +	if (!iova_magazine_cache_users)
> +		kmem_cache_destroy(iova_magazine_cache);
> +
> +out_unlock:
> +	mutex_unlock(&iova_magazine_cache_mutex);
> +}
> +
>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   {
>   	struct iova_magazine *mag;
>   
> -	mag = kmalloc(sizeof(*mag), flags);
> +	mag = kmem_cache_alloc(iova_magazine_cache, flags);
>   	if (mag)
>   		mag->size = 0;
>   
> @@ -667,7 +711,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   
>   static void iova_magazine_free(struct iova_magazine *mag)
>   {
> -	kfree(mag);
> +	kmem_cache_free(iova_magazine_cache, mag);
>   }
>   
>   static void
> @@ -766,11 +810,17 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   	unsigned int cpu;
>   	int i, ret;
>   
> +	ret = iova_magazine_cache_init();
> +	if (ret)
> +		return -ENOMEM;
> +
>   	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
>   				 sizeof(struct iova_rcache),
>   				 GFP_KERNEL);
> -	if (!iovad->rcaches)
> +	if (!iovad->rcaches) {
> +		iova_magazine_cache_fini();
>   		return -ENOMEM;
> +	}
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>   		struct iova_cpu_rcache *cpu_rcache;
> @@ -948,6 +998,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   
>   	kfree(iovad->rcaches);
>   	iovad->rcaches = NULL;
> +	iova_magazine_cache_fini();
>   }
>   
>   /*

