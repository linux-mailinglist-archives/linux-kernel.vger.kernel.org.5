Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A38780816
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358981AbjHRJPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359035AbjHRJPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:15:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5D8E30E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:15:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17525D75;
        Fri, 18 Aug 2023 02:16:31 -0700 (PDT)
Received: from [10.57.4.78] (unknown [10.57.4.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220003F762;
        Fri, 18 Aug 2023 02:15:49 -0700 (PDT)
Message-ID: <8d2641a4-8237-9977-fd73-01a3cea42179@arm.com>
Date:   Fri, 18 Aug 2023 10:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] coresight: core: fix memory leak in dict->fwnode_list
To:     James Clark <james.clark@arm.com>,
        Junhao He <hejunhao3@huawei.com>, mike.leach@linaro.org,
        leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230817085937.55590-1-hejunhao3@huawei.com>
 <20230817085937.55590-3-hejunhao3@huawei.com>
 <16d7c933-ef2f-682e-742e-641c6a076ac0@arm.com>
 <f04cb594-bd3e-9d8d-e694-dbe059a3744b@arm.com>
 <87107f44-b760-5df4-6bcf-8482069a603a@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <87107f44-b760-5df4-6bcf-8482069a603a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 16:01, James Clark wrote:
> 
> 
> On 17/08/2023 15:47, Suzuki K Poulose wrote:
>> On 17/08/2023 15:39, Suzuki K Poulose wrote:
>>> On 17/08/2023 09:59, Junhao He wrote:
>>>> There are memory leaks reported by kmemleak:
>>>> ...
>>>> unreferenced object 0xffff2020103c3200 (size 256):
>>>>     comm "insmod", pid 4476, jiffies 4294978252 (age 50072.536s)
>>>>     hex dump (first 32 bytes):
>>>>       10 60 40 06 28 20 ff ff 10 c0 59 06 20 20 ff ff  .`@.( ....Y.  ..
>>>>       10 e0 47 06 28 20 ff ff 10 00 49 06 28 20 ff ff  ..G.( ....I.( ..
>>>>     backtrace:
>>>>       [<0000000034ec4724>] __kmem_cache_alloc_node+0x2f8/0x348
>>>>       [<0000000057fbc15d>] __kmalloc_node_track_caller+0x5c/0x110
>>>>       [<00000055d5e34b>] krealloc+0x8c/0x178
>>>>       [<00000000a4635beb>] coresight_alloc_device_name+0x128/0x188
>>>> [coresight]
>>>>       [<00000000a92ddfee>] funnel_cs_ops+0x10/0xfffffffffffedaa0
>>>> [coresight_funnel]
>>>>       [<00000000449e20f8>] dynamic_funnel_ids+0x80/0xfffffffffffed840
>>>> [coresight_funnel]
>>>> ...
>>>>
>>>> when remove driver, the golab variables defined by the macro
>>>> DEFINE_CORESIGHT_DEVLIST will be released, dict->nr_idx and
>>>> dict->fwnode_list are cleared to 0. The lifetime of the golab
>>>> variable has ended. So the buffer pointer is lost.
>>>>
>>>> Use the callback of devm_add_action_or_reset() to free memory.
>>>
>>> Thanks for the report. But please see below:
>>>
>>>>
>>>> Fixes: 0f5f9b6ba9e1 ("coresight: Use platform agnostic names")
>>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>>> ---
>>>>    drivers/hwtracing/coresight/coresight-core.c | 20 +++++++++++++++++++-
>>>>    1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>> index 9fabe00a40d6..6849faad697d 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>> @@ -1756,6 +1756,20 @@ bool coresight_loses_context_with_cpu(struct
>>>> device *dev)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
>>>> +void coresight_release_dev_list(void *data)
>>>> +{
>>>> +    struct coresight_dev_list *dict = data;
>>>> +
>>>> +    mutex_lock(&coresight_mutex);
>>>> +
>>>> +    if (dict->nr_idx) {
>>>> +        kfree(dict->fwnode_list);
>>>> +        dict->nr_idx = 0;
>>>> +    }
>>>> +
>>>> +    mutex_unlock(&coresight_mutex);
>>>> +}
>>>> +
>>>>    /*
>>>>     * coresight_alloc_device_name - Get an index for a given device in
>>>> the
>>>>     * device index list specific to a driver. An index is allocated for a
>>>> @@ -1766,12 +1780,16 @@
>>>> EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
>>>>    char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>>>>                      struct device *dev)
>>>>    {
>>>> -    int idx;
>>>> +    int idx, ret;
>>>>        char *name = NULL;
>>>>        struct fwnode_handle **list;
>>>>        mutex_lock(&coresight_mutex);
>>>> +    ret = devm_add_action_or_reset(dev, coresight_release_dev_list,
>>>> dict);
>>>> +    if (ret)
>>>> +        goto done;
>>>
>>> This looks wrong. The devlist should be only released on the "driver"
>>> unload, not on every device release. The list retains the fwnode to
>>> assign the same name for a device, if it is re-probed (e.g., due to
>>> -EPROBE_DEFER error).
>>
>> The best way is to free it on module_unload and unfortunately we would
>> need to do it from all modules using the DEVLIST.
>>
>> Suzuki
>>
> 
> Seems like we might also be able to move the separate lists to be one
> big list owned by the main 'coresight' module. If all the other modules
> are dependent on that one then it's always loaded first and the list is
> available. Then it persists as long as the main module is loaded and can
> be freed with the normal devm stuff.

That may not work, right ? For the devm stuff to work, you need a 
device. Moving this to the coresight main module, doesn't give us
*a device* where all these lists can be allocated from. Also, we
need a list per device type (e.g., tmc-etf<>, tmc-etb<>, tmc-etr<>
for tmc etc.). So then the individual drivers need to then refer
to the particular (exported!) list for allocations.

> 
> That would avoid the awkward combo of the static variables in each
> module plus the non devm kalloced list.

I think it is not too bad to add a cleanup call to the callers, who use
a devlist.

Suzuki




> 
>>
>>>
>>> Suzuki
>>>
>>

