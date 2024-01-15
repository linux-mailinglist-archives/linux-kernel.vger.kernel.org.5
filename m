Return-Path: <linux-kernel+bounces-25833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E333782D682
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19AB1C21657
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86BEAF8;
	Mon, 15 Jan 2024 09:57:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B690F4E3;
	Mon, 15 Jan 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F37B2F4;
	Mon, 15 Jan 2024 01:58:05 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85C7D3F6C4;
	Mon, 15 Jan 2024 01:57:16 -0800 (PST)
Message-ID: <dc3c1f99-7bf7-fcc5-00d5-d0e5269057c6@arm.com>
Date: Mon, 15 Jan 2024 09:57:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 8/8] coresight-tpdm: Add msr register support for CMB
Content-Language: en-US
From: James Clark <james.clark@arm.com>
To: Tao Zhang <quic_taozha@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-9-git-send-email-quic_taozha@quicinc.com>
 <185b23e7-a42f-4a12-85ba-8a093bc5ea58@arm.com>
 <4409f3cf-7ca9-407f-92c0-5aa7ba6f7b61@quicinc.com>
 <d8262a32-cc3c-4889-a5f0-a6b128b7e9d6@arm.com>
 <3e27b0e2-afb2-4706-9996-f567e33e35ba@quicinc.com>
 <94f504c4-76dd-4139-a8e0-c2858b7937bb@quicinc.com>
 <de1af807-2298-a0f9-0122-2333741ab934@arm.com>
In-Reply-To: <de1af807-2298-a0f9-0122-2333741ab934@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/01/2024 09:55, James Clark wrote:
> 
> 
> On 12/01/2024 09:12, Tao Zhang wrote:
>>
>> On 12/20/2023 5:06 PM, Tao Zhang wrote:
>>>
>>> On 12/19/2023 10:09 PM, Suzuki K Poulose wrote:
>>>> On 19/12/2023 06:58, Tao Zhang wrote:
>>>>>
>>>>> On 12/18/2023 7:02 PM, Suzuki K Poulose wrote:
>>>>>> On 21/11/2023 02:24, Tao Zhang wrote:
>>>>>>> Add the nodes for CMB subunit MSR(mux select register) support.
>>>>>>> CMB MSRs(mux select registers) is to separate mux,arbitration,
>>>>>>> ,interleaving,data packing control from stream filtering control.
>>>>>>>
>>>>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>>>>> ---
>>>>>>>   .../testing/sysfs-bus-coresight-devices-tpdm  |  8 ++
>>>>>>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 86
>>>>>>> +++++++++++++++++++
>>>>>>>   drivers/hwtracing/coresight/coresight-tpdm.h  | 16 +++-
>>>>>>>   3 files changed, 109 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> index e0b77107be13..914f3fd81525 100644
>>>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> @@ -249,3 +249,11 @@ Description:
>>>>>>>           Accepts only one of the 2 values -  0 or 1.
>>>>>>>           0 : Disable the timestamp of all trace packets.
>>>>>>>           1 : Enable the timestamp of all trace packets.
>>>>>>> +
>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_msr/msr[0:31]
>>>>>>> +Date:        September 2023
>>>>>>> +KernelVersion    6.7
>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao
>>>>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>> +Description:
>>>>>>> +        (RW) Set/Get the MSR(mux select register) for the CMB
>>>>>>> subunit
>>>>>>> +        TPDM.
>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>> index f6cda5616e84..7e331ea436cc 100644
>>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>> @@ -86,6 +86,11 @@ static ssize_t tpdm_simple_dataset_show(struct
>>>>>>> device *dev,
>>>>>>>               return -EINVAL;
>>>>>>>           return sysfs_emit(buf, "0x%x\n",
>>>>>>> drvdata->cmb->patt_mask[tpdm_attr->idx]);
>>>>>>> +    case CMB_MSR:
>>>>>>> +        if (tpdm_attr->idx >= drvdata->cmb_msr_num)
>>>>>>> +            return -EINVAL;
>>>>>>> +        return sysfs_emit(buf, "0x%x\n",
>>>>>>> + drvdata->cmb->msr[tpdm_attr->idx]);
>>>>>>>       }
>>>>>>>       return -EINVAL;
>>>>>>>   }
>>>>>>> @@ -162,6 +167,12 @@ static ssize_t
>>>>>>> tpdm_simple_dataset_store(struct device *dev,
>>>>>>>           else
>>>>>>>               ret = -EINVAL;
>>>>>>>           break;
>>>>>>> +    case CMB_MSR:
>>>>>>> +        if (tpdm_attr->idx < drvdata->cmb_msr_num)
>>>>>>> +            drvdata->cmb->msr[tpdm_attr->idx] = val;
>>>>>>> +        else
>>>>>>> +            ret = -EINVAL;
>>>>>>
>>>>>>
>>>>>> minor nit: Could we not break from here instead of adding return
>>>>>> -EINVAL
>>>>>> for each case ? (I understand it has been done for the existing cases.
>>>>>> But I think we should clean up all of that, including the ones you
>>>>>> added
>>>>>> in Patch 5. Similarly for the dataset_show()
>>>>>
>>>>> Sure, do I also need to change the DSB corresponding code? If so,
>>>>> how about
>>>>>
>>>>> if I add a new patch to the next patch series to change the previous
>>>>> existing cases?
>>>>
>>>> You could fix the existing cases as a preparatory patch of the next
>>>> version of this series. I can pick it up and push it to next as I see
>>>> fit.
>>>
>>> Got it. I will update this to the next patch series.
>>
>> Hi Suzuki,
>>
>>
>> Since the dataset data is configured with spin lock protection, it needs
>> to be unlock before return.
>>
>> List my modification below. Would you mind help review to see if it is
>> good for you.
>>
>> static ssize_t tpdm_simple_dataset_store(struct device *dev,
>>                      struct device_attribute *attr,
>>                      const char *buf,
>>                      size_t size)
>> {
>>     unsigned long val;
>>
>>     struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>     struct tpdm_dataset_attribute *tpdm_attr =
>>         container_of(attr, struct tpdm_dataset_attribute, attr);
>>
>>     if (kstrtoul(buf, 0, &val))
>>         return -EINVAL;
>>
>>     spin_lock(&drvdata->spinlock);
>>     switch (tpdm_attr->mem) {
>>     case DSB_TRIG_PATT:
>>         if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
>>             drvdata->dsb->trig_patt[tpdm_attr->idx] = val;
>>         else {
>>             spin_unlock(&drvdata->spinlock);
>>             return -EINVAL;
>>         }
>>     case DSB_TRIG_PATT_MASK:
>>         if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
>>             drvdata->dsb->trig_patt_mask[tpdm_attr->idx] = val;
>>         else{
>>             spin_unlock(&drvdata->spinlock);
>>             return -EINVAL;
>>         }
>>     case DSB_PATT:
>>         if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
>>             drvdata->dsb->patt_val[tpdm_attr->idx] = val;
>>         else{
>>             spin_unlock(&drvdata->spinlock);
>>             return -EINVAL;
>>         }
>>     case DSB_PATT_MASK:
>>         if (tpdm_attr->idx < TPDM_DSB_MAX_PATT)
>>             drvdata->dsb->patt_mask[tpdm_attr->idx] = val;
>>         else{
>>             spin_unlock(&drvdata->spinlock);
>>             return -EINVAL;
>>         }
>>     case DSB_MSR:
>>         if (tpdm_attr->idx < drvdata->dsb_msr_num)
>>             drvdata->dsb->msr[tpdm_attr->idx] = val;
>>         else{
>>             spin_unlock(&drvdata->spinlock);
>>             return -EINVAL;
>>         }
>>     default:
>>         spin_unlock(&drvdata->spinlock);
>>         return -EINVAL;
>>     }
>>     return size;
>>
>>
>> Best,
>>
>> Tao
>>
> 
> This looks like a good fit for the new
> guard(spinlock)(&drvdata->spinlock) thing. Then there is no need to do
> all the manual unlocking.
> 

Oh I see Suzuki already suggested it, nevermind.

