Return-Path: <linux-kernel+bounces-48871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A20846290
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AB5B23687
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683043D0AF;
	Thu,  1 Feb 2024 21:23:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173983EA9B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822629; cv=none; b=mXZUgYP/oThDJINYImbLPBJDN30Q+zvtPrCFvUHEchTnWVSioYq0WchwEp0IDDgkKaednpf1UQ7oT4aMM6nmf/JkSKmWK8C26en1DPROf7QXBbQG+JMe80xvkQXjDnPWA5RwE3GVTtDCvkbu6S1el8uSKXqhx8LbI9i2k07ZaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822629; c=relaxed/simple;
	bh=pdLzd5pCn/ZovlNRU+1noSY/9vcQcHI7CqK+Ey3Bb/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5rGBMrQqW6tS6JpFJ3mkAYYF6QC3DW6RUDI2dUatG11EVhDLlZ+7DpECqmqYBQXwuN21k7JtgSw8J8uX8oJmNzkQTqgmI0JmBInioWuCJg0+JK5F2iEuCddrII/PQFTpyYRRVuZu4+7xOjxYQ33xw2sCWZdx7Y0hjIU2gBY1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AE03DA7;
	Thu,  1 Feb 2024 13:24:28 -0800 (PST)
Received: from [10.57.47.101] (unknown [10.57.47.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 311563F762;
	Thu,  1 Feb 2024 13:23:44 -0800 (PST)
Message-ID: <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
Date: Thu, 1 Feb 2024 21:23:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
References: <20240201193014.2785570-1-tatashin@google.com>
 <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-01 9:06 pm, Pasha Tatashin wrote:
> On Thu, Feb 1, 2024 at 3:56 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2024-02-01 7:30 pm, Pasha Tatashin wrote:
>>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>>
>>> The magazine buffers can take gigabytes of kmem memory, dominating all
>>> other allocations. For observability prurpose create named slab cache so
>>> the iova magazine memory overhead can be clearly observed.
>>>
>>> With this change:
>>>
>>>> slabtop -o | head
>>>    Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>>>    Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>>>    Active / Total Caches (% used)     : 135 / 211 (64.0%)
>>>    Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>>>    Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
>>>
>>> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>>> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>>>    91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>>>    75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
>>>
>>> On this machine it is now clear that magazine use 242M of kmem memory.
>>
>> Hmm, something smells there...
>>
>> In the "worst" case there should be a maximum of 6 * 2 *
>> num_online_cpus() empty magazines in the iova_cpu_rcache structures,
>> i.e., 12KB per CPU. Under normal use those will contain at least some
>> PFNs, but mainly every additional magazine stored in a depot is full
>> with 127 PFNs, and each one of those PFNs is backed by a 40-byte struct
>> iova, i.e. ~5KB per 1KB magazine. Unless that machine has many thousands
>> of CPUs, if iova_magazine allocations are the top consumer of memory
>> then something's gone wrong.
> 
> This is an upstream kernel  + few drivers that is booted on AMD EPYC,
> with 128 CPUs.
> 
> It has allocations stacks like these:
> init_iova_domain+0x1ed/0x230 iommu_setup_dma_ops+0xf8/0x4b0
> amd_iommu_probe_finalize.
> And also init_iova_domain() calls for Google's TPU drivers 242M is
> actually not that much, compared to the size of the system.

Hmm, I did misspeak slightly (it's late and I really should have left 
this for tomorrow...) - that's 12KB per CPU *per domain*, but still that 
would seem to imply well over 100 domains if you have 242MB of magazine 
allocations while the iommu_iova cache isn't even on the charts... what 
the heck is that driver doing?

(I don't necessarily disagree with the spirit of the patch BTW, I just 
really want to understand the situation that prompted it, and make sure 
we don't actually have a subtle leak somewhere.)

Thanks,
Robin.

> 
> Pasha
> 
>>
>> Thanks,
>> Robin.
>>
>>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> ---
>>>    drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 54 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index d30e453d0fb4..617bbc2b79f5 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>>>
>>>    #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
>>>
>>> +static struct kmem_cache *iova_magazine_cache;
>>> +static unsigned int iova_magazine_cache_users;
>>> +static DEFINE_MUTEX(iova_magazine_cache_mutex);
>>> +
>>>    struct iova_magazine {
>>>        union {
>>>                unsigned long size;
>>> @@ -654,11 +658,51 @@ struct iova_rcache {
>>>        struct delayed_work work;
>>>    };
>>>
>>> +static int iova_magazine_cache_init(void)
>>> +{
>>> +     int ret = 0;
>>> +
>>> +     mutex_lock(&iova_magazine_cache_mutex);
>>> +
>>> +     iova_magazine_cache_users++;
>>> +     if (iova_magazine_cache_users > 1)
>>> +             goto out_unlock;
>>> +
>>> +     iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
>>> +                                             sizeof(struct iova_magazine),
>>> +                                             0, SLAB_HWCACHE_ALIGN, NULL);
>>> +
>>> +     if (!iova_magazine_cache) {
>>> +             pr_err("Couldn't create iova magazine cache\n");
>>> +             ret = -ENOMEM;
>>> +     }
>>> +
>>> +out_unlock:
>>> +     mutex_unlock(&iova_magazine_cache_mutex);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static void iova_magazine_cache_fini(void)
>>> +{
>>> +     mutex_lock(&iova_magazine_cache_mutex);
>>> +
>>> +     if (WARN_ON(!iova_magazine_cache_users))
>>> +             goto out_unlock;
>>> +
>>> +     iova_magazine_cache_users--;
>>> +     if (!iova_magazine_cache_users)
>>> +             kmem_cache_destroy(iova_magazine_cache);
>>> +
>>> +out_unlock:
>>> +     mutex_unlock(&iova_magazine_cache_mutex);
>>> +}
>>> +
>>>    static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>>>    {
>>>        struct iova_magazine *mag;
>>>
>>> -     mag = kmalloc(sizeof(*mag), flags);
>>> +     mag = kmem_cache_alloc(iova_magazine_cache, flags);
>>>        if (mag)
>>>                mag->size = 0;
>>>
>>> @@ -667,7 +711,7 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>>>
>>>    static void iova_magazine_free(struct iova_magazine *mag)
>>>    {
>>> -     kfree(mag);
>>> +     kmem_cache_free(iova_magazine_cache, mag);
>>>    }
>>>
>>>    static void
>>> @@ -766,11 +810,17 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>>>        unsigned int cpu;
>>>        int i, ret;
>>>
>>> +     ret = iova_magazine_cache_init();
>>> +     if (ret)
>>> +             return -ENOMEM;
>>> +
>>>        iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
>>>                                 sizeof(struct iova_rcache),
>>>                                 GFP_KERNEL);
>>> -     if (!iovad->rcaches)
>>> +     if (!iovad->rcaches) {
>>> +             iova_magazine_cache_fini();
>>>                return -ENOMEM;
>>> +     }
>>>
>>>        for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>>>                struct iova_cpu_rcache *cpu_rcache;
>>> @@ -948,6 +998,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>>>
>>>        kfree(iovad->rcaches);
>>>        iovad->rcaches = NULL;
>>> +     iova_magazine_cache_fini();
>>>    }
>>>
>>>    /*

