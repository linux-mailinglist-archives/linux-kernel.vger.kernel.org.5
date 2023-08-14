Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7077B5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjHNJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjHNJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:45:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 820A3CC;
        Mon, 14 Aug 2023 02:45:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EEB92F4;
        Mon, 14 Aug 2023 02:45:53 -0700 (PDT)
Received: from [10.57.90.230] (unknown [10.57.90.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C27E3F6C4;
        Mon, 14 Aug 2023 02:45:08 -0700 (PDT)
Message-ID: <ee3e8fc1-708c-d7b8-d827-c2f1adbc5c66@arm.com>
Date:   Mon, 14 Aug 2023 10:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 06/13] coresight-tpdm: Add reset node to TPDM node
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-7-git-send-email-quic_taozha@quicinc.com>
 <fc995a4a-81c5-648c-663a-4cee2cf15197@arm.com>
 <fb061c33-9f39-831a-76da-2fa86aaa6df6@quicinc.com>
 <1dba2258-e447-d019-da38-067bf776922a@quicinc.com>
 <ce14e453-50da-02c2-9147-f094ed8aa10f@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ce14e453-50da-02c2-9147-f094ed8aa10f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 08:08, Tao Zhang wrote:
> 
> On 8/13/2023 11:38 PM, Tao Zhang wrote:
>>
>> On 8/9/2023 2:35 PM, Tao Zhang wrote:
>>>
>>> On 8/7/2023 5:36 PM, Suzuki K Poulose wrote:
>>>> On 25/07/2023 08:15, Tao Zhang wrote:
>>>>> TPDM device need a node to reset the configurations and status of
>>>>> it. This change provides a node to reset the configurations and
>>>>> disable the TPDM if it has been enabled.
>>>>>
>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>> ---
>>>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++++++++
>>>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 22 
>>>>> ++++++++++++++++++++++
>>>>>   2 files changed, 32 insertions(+)
>>>>>
>>>>> diff --git 
>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>> index 4a58e64..dbc2fbd0 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>> @@ -11,3 +11,13 @@ Description:
>>>>>           Accepts only one of the 2 values -  1 or 2.
>>>>>           1 : Generate 64 bits data
>>>>>           2 : Generate 32 bits data
>>>>> +
>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/reset
>>>>> +Date:        March 2023
>>>>> +KernelVersion    6.5
>>>>
>>>>
>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>> +Description:
>>>>> +        (Write) Reset the dataset of the tpdm, and disable the tpdm.
>>>>
>>>> Please fix this, we don't disable TPDM. If it only ever resets the 
>>>> datasets, please could we rename this as such ?
>>>>
>>>>  i.e., reset_dataset or reset_dsb_data ?
>>> Sure, I will update this in the next patch series.
>>>>
>>>>> +
>>>>> +        Accepts only one value -  1.
>>>>> +        1 : Reset the dataset of the tpdm
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>> index 52aa48a6..acc3eea 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>> @@ -159,6 +159,27 @@ static int tpdm_datasets_setup(struct 
>>>>> tpdm_drvdata *drvdata)
>>>>>       return 0;
>>>>>   }
>>>>>   +static ssize_t reset_store(struct device *dev,
>>>>> +                      struct device_attribute *attr,
>>>>> +                      const char *buf,
>>>>> +                      size_t size)
>>>>
>>>> Minor nit: alignment ? Could we have something like :
>>>>
>>>> static ssize_t reset_store(struct device *dev,
>>>>                struct device_attribute *attr,
>>>>                const char *buf,
>>>>                size_t size)
>>>>
>>> I will update this in the next patch series.
>>>
>>>
>>> Best,
>>>
>>> Tao
>>
>> Hi Suzuki,
>>
>>
>> With regards to the parameters alignment for the function, could you
>>
>> kindly remind me the rule of alignment?  I'm using the thunderbird
>>
>> mail client and I'm not sure if the alignment I see is what you expect.

It is not about the mail client, I am looking at the code with this 
series applied to the code.

>>
>> If the rule can be specified, I can align all the function parameters in
>>
>> this patch series according to this rule.
>>
>>
>> Best,
>>
>> Tao
> 
> Hi Suzuki,
> 
> 
> Can I follow the following rules to handle the similar case?
> 
> "Descendants are always substantially shorter than the parent and are 
> placed substantially to the right.
> 


> A very commonly used style is to align descendants to a function open 
> parenthesis."

Yes, this is what I expect.

Suzuki


> 
> 
> Best,
> 
> Tao
> 
>>
>>>
>>>>
>>>>> +{
>>>>> +    int ret = 0;
>>>>> +    unsigned long val;
>>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>> +
>>>>> +    ret = kstrtoul(buf, 10, &val);
>>>>> +    if (ret || val != 1)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    spin_lock(&drvdata->spinlock);
>>>>> +    tpdm_reset_datasets(drvdata);
>>>>> +    spin_unlock(&drvdata->spinlock);
>>>>> +
>>>>> +    return size;
>>>>> +}
>>>>> +static DEVICE_ATTR_WO(reset);
>>>>> +
>>>>>   /*
>>>>>    * value 1: 64 bits test data
>>>>>    * value 2: 32 bits test data
>>>>> @@ -199,6 +220,7 @@ static ssize_t integration_test_store(struct 
>>>>> device *dev,
>>>>>   static DEVICE_ATTR_WO(integration_test);
>>>>>     static struct attribute *tpdm_attrs[] = {
>>>>> +    &dev_attr_reset.attr,
>>>>>       &dev_attr_integration_test.attr,
>>>>>       NULL,
>>>>>   };
>>>>
>>>> Suzuki
>>>>
>>> _______________________________________________
>>> CoreSight mailing list -- coresight@lists.linaro.org
>>> To unsubscribe send an email to coresight-leave@lists.linaro.org
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org

