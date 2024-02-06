Return-Path: <linux-kernel+bounces-54766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DE84B36B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04661F23D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C712FB3C;
	Tue,  6 Feb 2024 11:25:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E912EBEB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218709; cv=none; b=a37uW8eTybJAguu5POKA6nhmgRlpZ5ghbjv+ysocmeqX+ETG2wdUAStZyA3rBOEhB9444EGhLzZpw1AVLkY5ZPfNviZXObrdcQwzWLZYs4SG6ZiW8v9Q3rzi9/5txmxk4F7Mue5ZfIGVK1SC0ykNxjX8z0EnGwAuoO/hufSRi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218709; c=relaxed/simple;
	bh=UqecmSij6jUkv/J1hyJQV+i6fQZsP3djMdtLCY2IesY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI4jhnQ15MESoXqZIOtPQLhI01BcCa4L9G+61Eo28dMxP0f2oittr9jF2VgdJGXkCjPvqyGerNLLhePW+3wqy9SKRGk9rBH88sUSID4oIyb1ap3JmBzY7hCOM6/QM9KNLZ7Z2kUeT74bzSCShr6FXywHI1f4GKdVfy88cC2RAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB9CD1FB;
	Tue,  6 Feb 2024 03:25:48 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02F873F762;
	Tue,  6 Feb 2024 03:25:04 -0800 (PST)
Message-ID: <879751d4-486c-4d5e-b9b3-60e8822ff3fb@arm.com>
Date: Tue, 6 Feb 2024 11:25:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] iommu/iova: Tidy up iova_cache_get() failure
Content-Language: en-GB
To: John Garry <john.g.garry@oracle.com>, joro@8bytes.org
Cc: will@kernel.org, pasha.tatashin@soleen.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
 yosryahmed@google.com
References: <cover.1707144953.git.robin.murphy@arm.com>
 <ae4a3bda2d6a9b738221553c838d30473bd624e7.1707144953.git.robin.murphy@arm.com>
 <6041982e-3c65-497f-b7bf-3ac444fa3623@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6041982e-3c65-497f-b7bf-3ac444fa3623@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/02/2024 11:01 am, John Garry wrote:
> On 05/02/2024 15:32, Robin Murphy wrote:
>> Failure handling in iova_cache_get() is a little messy, and we'd like
>> to add some more to it, so let's tidy up a bit first. By leaving the
>> hotplug handler until last we can take advantage of kmem_cache_destroy()
>> being NULL-safe to have a single cleanup label. We can also improve the
>> error reporting, noting that kmem_cache_create() already screams if it
>> fails, so that one is redundant.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Regardless of a couple of minor comments, below, FWIW:
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks!

>> ---
>>   drivers/iommu/iova.c | 33 ++++++++++++++++-----------------
>>   1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index d30e453d0fb4..cf95001d85c0 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -254,26 +254,20 @@ static void free_iova_mem(struct iova *iova)
>>   int iova_cache_get(void)
>>   {
>> +    int err = -ENOMEM;
>> +
>>       mutex_lock(&iova_cache_mutex);
>>       if (!iova_cache_users) {
>> -        int ret;
>> +        iova_cache = kmem_cache_create("iommu_iova", sizeof(struct 
>> iova), 0,
>> +                           SLAB_HWCACHE_ALIGN, NULL);
> 
> Maybe can use KMEM_CACHE(), but it would mean that the name would change.

Oh, I never came across that before. On reflection, I am inclined to 
think that the "iommu_" names are usefully informative to userspace, and 
it's not worth churning the structure names themselves just to save a 
couple of lines here.

>> +        if (!iova_cache)
>> +            goto out_err;
>> -        ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, 
>> "iommu/iova:dead", NULL,
>> -                    iova_cpuhp_dead);
>> -        if (ret) {
>> -            mutex_unlock(&iova_cache_mutex);
>> -            pr_err("Couldn't register cpuhp handler\n");
>> -            return ret;
>> -        }
>> -
>> -        iova_cache = kmem_cache_create(
>> -            "iommu_iova", sizeof(struct iova), 0,
>> -            SLAB_HWCACHE_ALIGN, NULL);
>> -        if (!iova_cache) {
>> -            cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>> -            mutex_unlock(&iova_cache_mutex);
>> -            pr_err("Couldn't create iova cache\n");
>> -            return -ENOMEM;
>> +        err = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, 
>> "iommu/iova:dead",
>> +                          NULL, iova_cpuhp_dead);
>> +        if (err) {
>> +            pr_err("IOVA: Couldn't register cpuhp handler: %pe\n", 
>> ERR_PTR(err));
> 
> Maybe can use pr_fmt with "iova".

That one I did consider, but since we now have just this one print and 
no imminent reason to add more, I figured I'd just stick it inline, and 
we can factor out a pr_fmt in future if we ever have cause to.

Cheers,
Robin.

> 
>> +            goto out_err;
>>           }
>>       }
>> @@ -281,6 +275,11 @@ int iova_cache_get(void)
>>       mutex_unlock(&iova_cache_mutex);
>>       return 0;
>> +
>> +out_err:
>> +    kmem_cache_destroy(iova_cache);
>> +    mutex_unlock(&iova_cache_mutex);
>> +    return err;
>>   }
>>   EXPORT_SYMBOL_GPL(iova_cache_get);
> 

