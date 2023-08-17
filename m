Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FDC77F9D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352415AbjHQO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352414AbjHQO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:56:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9239F30E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:56:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65776139F;
        Thu, 17 Aug 2023 07:47:37 -0700 (PDT)
Received: from [10.57.3.165] (unknown [10.57.3.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01543F6C4;
        Thu, 17 Aug 2023 07:46:54 -0700 (PDT)
Message-ID: <c9bef0cd-18a0-ffc0-15c5-3db388275c46@arm.com>
Date:   Thu, 17 Aug 2023 15:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] coresight: core: fix memory leak in dict->fwnode_list
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Junhao He <hejunhao3@huawei.com>, mike.leach@linaro.org,
        leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230817085937.55590-1-hejunhao3@huawei.com>
 <20230817085937.55590-3-hejunhao3@huawei.com>
 <16d7c933-ef2f-682e-742e-641c6a076ac0@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <16d7c933-ef2f-682e-742e-641c6a076ac0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 15:39, Suzuki K Poulose wrote:
> On 17/08/2023 09:59, Junhao He wrote:
>> There are memory leaks reported by kmemleak:
>> ...
>> unreferenced object 0xffff2020103c3200 (size 256):
>>    comm "insmod", pid 4476, jiffies 4294978252 (age 50072.536s)
>>    hex dump (first 32 bytes):
>>      10 60 40 06 28 20 ff ff 10 c0 59 06 20 20 ff ff  .`@.( ....Y.  ..
>>      10 e0 47 06 28 20 ff ff 10 00 49 06 28 20 ff ff  ..G.( ....I.( ..
>>    backtrace:
>>      [<0000000034ec4724>] __kmem_cache_alloc_node+0x2f8/0x348
>>      [<0000000057fbc15d>] __kmalloc_node_track_caller+0x5c/0x110
>>      [<00000055d5e34b>] krealloc+0x8c/0x178
>>      [<00000000a4635beb>] coresight_alloc_device_name+0x128/0x188
>> [coresight]
>>      [<00000000a92ddfee>] funnel_cs_ops+0x10/0xfffffffffffedaa0
>> [coresight_funnel]
>>      [<00000000449e20f8>] dynamic_funnel_ids+0x80/0xfffffffffffed840
>> [coresight_funnel]
>> ...
>>
>> when remove driver, the golab variables defined by the macro
>> DEFINE_CORESIGHT_DEVLIST will be released, dict->nr_idx and
>> dict->fwnode_list are cleared to 0. The lifetime of the golab
>> variable has ended. So the buffer pointer is lost.
>>
>> Use the callback of devm_add_action_or_reset() to free memory.
> 
> Thanks for the report. But please see below:
> 
>>
>> Fixes: 0f5f9b6ba9e1 ("coresight: Use platform agnostic names")
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 9fabe00a40d6..6849faad697d 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1756,6 +1756,20 @@ bool coresight_loses_context_with_cpu(struct
>> device *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
>>   +void coresight_release_dev_list(void *data)
>> +{
>> +    struct coresight_dev_list *dict = data;
>> +
>> +    mutex_lock(&coresight_mutex);
>> +
>> +    if (dict->nr_idx) {
>> +        kfree(dict->fwnode_list);
>> +        dict->nr_idx = 0;
>> +    }
>> +
>> +    mutex_unlock(&coresight_mutex);
>> +}
>> +
>>   /*
>>    * coresight_alloc_device_name - Get an index for a given device in the
>>    * device index list specific to a driver. An index is allocated for a
>> @@ -1766,12 +1780,16 @@
>> EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
>>   char *coresight_alloc_device_name(struct coresight_dev_list *dict,
>>                     struct device *dev)
>>   {
>> -    int idx;
>> +    int idx, ret;
>>       char *name = NULL;
>>       struct fwnode_handle **list;
>>         mutex_lock(&coresight_mutex);
>>   +    ret = devm_add_action_or_reset(dev, coresight_release_dev_list,
>> dict);
>> +    if (ret)
>> +        goto done;
> 
> This looks wrong. The devlist should be only released on the "driver"
> unload, not on every device release. The list retains the fwnode to
> assign the same name for a device, if it is re-probed (e.g., due to
> -EPROBE_DEFER error).
> 
> Suzuki
> 

I think in that case my suggestion to change it to devm_krealloc_array
might be wrong then. Probably worth putting an explicit comment there in
case someone tries to tidy up all the non devm allocators to devm ones.

But how do you release a single device without releasing the whole driver?

James
