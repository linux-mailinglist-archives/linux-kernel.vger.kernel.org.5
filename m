Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFED797F36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbjIGX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjIGX2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:28:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F86C1BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:28:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B32CFEC;
        Thu,  7 Sep 2023 16:29:12 -0700 (PDT)
Received: from [10.57.4.58] (unknown [10.57.4.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC9E3F64C;
        Thu,  7 Sep 2023 16:28:32 -0700 (PDT)
Message-ID: <e576c6c2-e352-8f75-3b47-042307f02c60@arm.com>
Date:   Fri, 8 Sep 2023 00:28:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] iommu/iova: Manage the depot list size
Content-Language: en-GB
To:     "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>,
        joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
        john.g.garry@oracle.com, jsnitsel@redhat.com, wyes.karny@amd.com,
        vasant.hegde@amd.com
References: <cover.1692641204.git.robin.murphy@arm.com>
 <4eb00390132b93bbc113bef2205e9df54f888710.1692641204.git.robin.murphy@arm.com>
 <da25bef4-7e6e-8e4b-ad9e-96d1c8729095@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <da25bef4-7e6e-8e4b-ad9e-96d1c8729095@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-07 18:54, Srivastava, Dheeraj Kumar wrote:
> Hi Robin,
> 
> On 8/21/2023 11:52 PM, Robin Murphy wrote:
>> Automatically scaling the depot up to suit the peak capacity of a
>> workload is all well and good, but it would be nice to have a way to
>> scale it back down again if the workload changes. To that end, add
>> backround reclaim that will gradually free surplus magazines if the

[ bah, I'll have to fix that typo too - thanks for the squiggle, 
Thunderbird ]

[...]
> Looking into the trace and your patch figured out that in 
> iova_depot_work_func workqueue function rcache->lock is taken via 
> spin_lock. But the same lock will be taken from IRQ context also.
> So, to prevent IRQ when the rcache->lock is taken we should disable IRQ.
> Therefore use spin_lock_irqsave in place of normal spin_lock.

Oof, indeed it seems I totally failed to consider IRQs... this tweak 
looks right to me, thanks for the catch! I'll get a v3 ready for -rc1...

Cheers,
Robin.

> Below changes fixes the issue
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 436f42855c29..d30e453d0fb4 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -747,11 +747,12 @@ static void iova_depot_work_func(struct 
> work_struct *work)
>   {
>      struct iova_rcache *rcache = container_of(work, typeof(*rcache), 
> work.work);
>      struct iova_magazine *mag = NULL;
> +    unsigned long flags;
> 
> -    spin_lock(&rcache->lock);
> +    spin_lock_irqsave(&rcache->lock, flags);
>      if (rcache->depot_size > num_online_cpus())
>          mag = iova_depot_pop(rcache);
> -    spin_unlock(&rcache->lock);
> +    spin_unlock_irqrestore(&rcache->lock, flags);
> 
>      if (mag) {
>          iova_magazine_free_pfns(mag, rcache->iovad);
> 
> 
>> +    if (mag) {
>> +        iova_magazine_free_pfns(mag, rcache->iovad);
>> +        iova_magazine_free(mag);
>> +        schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
>> +    }
>>   }
>>   int iova_domain_init_rcaches(struct iova_domain *iovad)
>> @@ -752,6 +777,8 @@ int iova_domain_init_rcaches(struct iova_domain 
>> *iovad)
>>           rcache = &iovad->rcaches[i];
>>           spin_lock_init(&rcache->lock);
>> +        rcache->iovad = iovad;
>> +        INIT_DELAYED_WORK(&rcache->work, iova_depot_work_func);
>>           rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
>>                                cache_line_size());
>>           if (!rcache->cpu_rcaches) {
>> @@ -812,6 +839,7 @@ static bool __iova_rcache_insert(struct 
>> iova_domain *iovad,
>>               spin_lock(&rcache->lock);
>>               iova_depot_push(rcache, cpu_rcache->loaded);
>>               spin_unlock(&rcache->lock);
>> +            schedule_delayed_work(&rcache->work, IOVA_DEPOT_DELAY);
>>               cpu_rcache->loaded = new_mag;
>>               can_insert = true;
>> @@ -912,6 +940,7 @@ static void free_iova_rcaches(struct iova_domain 
>> *iovad)
>>               iova_magazine_free(cpu_rcache->prev);
>>           }
>>           free_percpu(rcache->cpu_rcaches);
>> +        cancel_delayed_work_sync(&rcache->work);
>>           while (rcache->depot)
>>               iova_magazine_free(iova_depot_pop(rcache));
>>       }
