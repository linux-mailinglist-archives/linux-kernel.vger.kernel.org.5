Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F9677E6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjHPQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbjHPQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:52:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B09B1BE7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:52:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAB5D75;
        Wed, 16 Aug 2023 09:53:10 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 564723F6C4;
        Wed, 16 Aug 2023 09:52:28 -0700 (PDT)
Message-ID: <24ba4cd6-0a28-3c22-c5b5-dadaa67600cf@arm.com>
Date:   Wed, 16 Aug 2023 17:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] iommu/iova: Manage the depot list size
To:     "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        joro@8bytes.org
References: <cover.1692033783.git.robin.murphy@arm.com>
 <abc5a322584f5c8a44f7a0a7f709899053c5df01.1692033783.git.robin.murphy@arm.com>
 <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
Content-Language: en-GB
In-Reply-To: <70e7dcc8-819f-d957-f43c-75b7818a3a96@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 3:11 pm, zhangzekun (A) wrote:
> 
> 
> 在 2023/8/15 1:53, Robin Murphy 写道:
>> Automatically scaling the depot up to suit the peak capacity of a
>> workload is all well and good, but it would be nice to have a way to
>> scale it back down again if the workload changes. To that end, add
>> automatic reclaim that will gradually free unused magazines if the
>> depot size remains above a reasonable threshold for long enough.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iova.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index d2de6fb0e9f4..76a7d694708e 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/smp.h>
>>   #include <linux/bitops.h>
>>   #include <linux/cpu.h>
>> +#include <linux/workqueue.h>
>>   /* The anchor node sits above the top of the usable address space */
>>   #define IOVA_ANCHOR    ~0UL
>> @@ -626,6 +627,8 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>>    */
>>   #define IOVA_MAG_SIZE 127
>> +#define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
>> +
>>   struct iova_magazine {
>>       /*
>>        * Only full magazines are inserted into the depot, so we can avoid
>> @@ -646,8 +649,11 @@ struct iova_cpu_rcache {
>>   struct iova_rcache {
>>       spinlock_t lock;
>> +    unsigned int depot_size;
>>       struct iova_magazine *depot;
>>       struct iova_cpu_rcache __percpu *cpu_rcaches;
>> +    struct iova_domain *iovad;
>> +    struct delayed_work work;
>>   };
>>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>> @@ -728,6 +734,7 @@ static struct iova_magazine *iova_depot_pop(struct 
>> iova_rcache *rcache)
>>       rcache->depot = mag->next;
>>       mag->size = IOVA_MAG_SIZE;
>> +    rcache->depot_size--;
>>       return mag;
>>   }
>> @@ -735,6 +742,24 @@ static void iova_depot_push(struct iova_rcache 
>> *rcache, struct iova_magazine *ma
>>   {
>>       mag->next = rcache->depot;
>>       rcache->depot = mag;
>> +    rcache->depot_size++;
>> +}
>> +
>> +static void iova_depot_work_func(struct work_struct *work)
>> +{
>> +    struct iova_rcache *rcache = container_of(work, typeof(*rcache), 
>> work.work);
>> +    struct iova_magazine *mag = NULL;
>> +
>> +    spin_lock(&rcache->lock);
>> +    if (rcache->depot_size > num_online_cpus())
>> +        mag = iova_depot_pop(rcache);
>> +    spin_unlock(&rcache->lock);
>> +
>> +    if (mag) {
>> +        iova_magazine_free_pfns(mag, rcache->iovad);
>> +        iova_magazine_free(mag);
>> +        schedule_delayed_work(&rcache->work, 
>> msecs_to_jiffies(IOVA_DEPOT_DELAY));
> Hi, Robin,
> 
> I am a little confused why IOVA_DEPOT_DELAY need to be calculated twice 
> in iova_depot_work_func(), as it already equals to 
> "msecs_to_jiffies(100)".

Oof, not sure how I managed to leave a mere 3-line refactoring 
half-finished... yeah, this msecs_to_jiffies() just shouldn't be here :)

> Besides, do we really need to invoke a 
> delayed_work in iova_depot_work_func()? As each time we put a iova 
> magazine to depot, a delayed_work will be invoked which is reponsible to 
> free a iova magazine in depot if the depot size is greater than 
> num_online_cpus().

The idea is to free excess magazines one at a time at a relatively low 
rate, so as not to interfere too much with "bursty" workloads which 
might release a large number of IOVAs at once, but then want to 
reallocate them again relatively soon. I'm hoping that the overhead of 
scheduling the reclaim work unconditionally whenever the depot grows is 
sufficiently negligible to avoid having to check the threshold in 
multiple places, as that's the part which I anticipate might grow more 
complex in future. As far as I could see it should be pretty minimal if 
the work is already scheduled, which I'd expect to be the case most of 
the time while the depot is busy. The reason the work also reschedules 
itself is to handle the opposite situation, and make sure it can run to 
completion after the depot goes idle.

Thanks,
Robin.
