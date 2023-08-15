Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7277CBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjHOLk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbjHOLkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:40:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850A19AD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:40:03 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ8Nn48VsztRwL;
        Tue, 15 Aug 2023 19:36:25 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 19:40:01 +0800
Subject: Re: [PATCH 1/2] coresight: trbe: Fix TRBE potential sleep in atomic
 context
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <anshuman.khandual@arm.com>,
        <jonathan.cameron@huawei.com>
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230814093813.19152-2-hejunhao3@huawei.com>
 <37e36bde-fc70-6d2d-8dec-28e572f618cc@arm.com>
 <4049aee1-7f4d-5a54-ce27-7d802ae9616d@huawei.com>
 <b91d36b4-4dcc-7f1e-6125-1641fdc41d4f@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <426cd32b-4f11-e720-7463-86e34d7ec817@huawei.com>
Date:   Tue, 15 Aug 2023 19:40:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <b91d36b4-4dcc-7f1e-6125-1641fdc41d4f@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki


On 2023/8/15 6:57, Suzuki K Poulose wrote:
> On 14/08/2023 14:32, hejunhao wrote:
>> Hi Suzuki
>>
>>
>> On 2023/8/14 18:34, Suzuki K Poulose wrote:
>>> Hi Junhao
>>>
>>> On 14/08/2023 10:38, Junhao He wrote:
>>>> smp_call_function_single() will allocate an IPI interrupt vector to
>>>> the target processor and send a function call request to the interrupt
>>>> vector. After the target processor receives the IPI interrupt, it will
>>>> execute arm_trbe_remove_coresight_cpu() call request in the interrupt
>>>> handler.
>>>>
>>>> According to the device_unregister() stack information, if other 
>>>> process
>>>> is useing the device, the down_write() may sleep, and trigger 
>>>> deadlocks
>>>> or unexpected errors.
>>>>
>>>>    arm_trbe_remove_coresight_cpu
>>>>      coresight_unregister
>>>>        device_unregister
>>>>          device_del
>>>>            kobject_del
>>>>              __kobject_del
>>>>                sysfs_remove_dir
>>>>                  kernfs_remove
>>>>                    down_write ---------> it may sleep
>>>>
>>>> Add a helper arm_trbe_disable_cpu() to disable TRBE precpu irq and 
>>>> reset
>>>> per TRBE.
>>>> Simply call arm_trbe_remove_coresight_cpu() directly without useing 
>>>> the
>>>> smp_call_function_single(), which is the same as registering the TRBE
>>>> coresight device.
>>>>
>>>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
>>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-trbe.c | 35 
>>>> +++++++++++---------
>>>>   1 file changed, 20 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c 
>>>> b/drivers/hwtracing/coresight/coresight-trbe.c
>>>> index 7720619909d6..ce1e6f537b8d 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>>> @@ -1225,6 +1225,17 @@ static void arm_trbe_enable_cpu(void *info)
>>>>       enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>>>>   }
>>>>   +static void arm_trbe_disable_cpu(void *info)
>>>> +{
>>>> +    struct trbe_drvdata *drvdata = info;
>>>> +    struct trbe_cpudata *cpudata = this_cpu_ptr(drvdata->cpudata);
>>>> +
>>>> +    disable_percpu_irq(drvdata->irq);
>>>> +    trbe_reset_local(cpudata);
>>>> +    cpudata->drvdata = NULL;
>>>> +}
>>>> +
>>>> +
>>>>   static void arm_trbe_register_coresight_cpu(struct trbe_drvdata 
>>>> *drvdata, int cpu)
>>>>   {
>>>>       struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, 
>>>> cpu);
>>>> @@ -1326,18 +1337,12 @@ static void arm_trbe_probe_cpu(void *info)
>>>>       cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
>>>>   }
>>>>   -static void arm_trbe_remove_coresight_cpu(void *info)
>>>> +static void arm_trbe_remove_coresight_cpu(struct trbe_drvdata 
>>>> *drvdata, int cpu)
>>>>   {
>>>> -    int cpu = smp_processor_id();
>>>> -    struct trbe_drvdata *drvdata = info;
>>>> -    struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, 
>>>> cpu);
>>>>       struct coresight_device *trbe_csdev = 
>>>> coresight_get_percpu_sink(cpu);
>>>>   -    disable_percpu_irq(drvdata->irq);
>>>> -    trbe_reset_local(cpudata);
>>>>       if (trbe_csdev) {
>>>>           coresight_unregister(trbe_csdev);
>>>> -        cpudata->drvdata = NULL;
>>>>           coresight_set_percpu_sink(cpu, NULL);
>>>
>>> I am a bit concerned about "resetting" the sink from a different CPU.
>>> Could we instead, schedule a delayed work to unregister the trbe_csdev?
>>
>> Yes, I will try to do that.
>> Sorry for my following questions.
>> As you mean, do we need to take the same care when setting the percpu 
>> sink
>> in the register trbe_csdev ?
>
> Apologies, having taken another look, we set the percpu_sink for
> a cpu outside smp_call_function(). So, I think your patch is fine.
>
>
>>
>> Best regards,
>> Junhao.
>>
>>>
>>>
>>>>       }
>>>>   }
>>>> @@ -1366,8 +1371,12 @@ static int arm_trbe_remove_coresight(struct 
>>>> trbe_drvdata *drvdata)
>>>>   {
>>>>       int cpu;
>>>>   -    for_each_cpu(cpu, &drvdata->supported_cpus)
>>>> -        smp_call_function_single(cpu, 
>>>> arm_trbe_remove_coresight_cpu, drvdata, 1);
>>>> +    for_each_cpu(cpu, &drvdata->supported_cpus) {
>>>> +        if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
>>>> +            smp_call_function_single(cpu, arm_trbe_disable_cpu, 
>>>> drvdata, 1);
>>>> +        if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
>>>> +            arm_trbe_remove_coresight_cpu(drvdata, cpu);
>
> Do we need to test the cpu here in both places ? We already check that
> in the loop entry. The reason why we repeat the check during the probe,
> is to skip any CPUs that may have a TRBE not accessible.
>
> Suzuki
>

Ok, Will fix in next version.

Best regards,
Junhao.

>
>>>> +    }
>>>>       free_percpu(drvdata->cpudata);
>>>>       return 0;
>>>>   }
>>>> @@ -1406,12 +1415,8 @@ static int arm_trbe_cpu_teardown(unsigned 
>>>> int cpu, struct hlist_node *node)
>>>>   {
>>>>       struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct 
>>>> trbe_drvdata, hotplug_node);
>>>>   -    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
>>>> -        struct trbe_cpudata *cpudata = 
>>>> per_cpu_ptr(drvdata->cpudata, cpu);
>>>> -
>>>> -        disable_percpu_irq(drvdata->irq);
>>>> -        trbe_reset_local(cpudata);
>>>> -    }
>>>> +    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
>>>> +        arm_trbe_disable_cpu(drvdata);
>>>>       return 0;
>>>>   }
>>>
>>>
>>> .
>>>
>>
>
>
> .
>

