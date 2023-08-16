Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7201377E327
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbjHPOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbjHPOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:00:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A4292D46;
        Wed, 16 Aug 2023 07:00:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F70D75;
        Wed, 16 Aug 2023 07:01:02 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0A3D3F762;
        Wed, 16 Aug 2023 07:00:19 -0700 (PDT)
Message-ID: <ad63e8fa-6437-872b-0bc3-ef87a5150652@arm.com>
Date:   Wed, 16 Aug 2023 15:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit
 writes
Content-Language: en-US
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
 <20230815063526.9022-2-ilkka@os.amperecomputing.com>
 <ab4a51ea-3956-2d2f-5705-a760be69fb59@arm.com>
 <e04669ee-d547-dbbe-e87b-5d7efa6ee8@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <e04669ee-d547-dbbe-e87b-5d7efa6ee8@os.amperecomputing.com>
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

On 15/08/2023 21:46, Ilkka Koskinen wrote:
> 
> Hi Suzuki,
> 
> On Tue, 15 Aug 2023, Suzuki K Poulose wrote:
>> On 15/08/2023 07:35, Ilkka Koskinen wrote:
>>> Split the 64-bit register accesses if 64-bit access is not supported
>>> by the PMU.
>>>
>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>> Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
>>
>> Do we need a Fixes tag ?
> 
> I believe, NVIDIA's PMU supports 64-bit access while Ampere's one 
> doesn't and since this patchset enables support for the latter one, it 
> doesn't seem like we need a Fixes tag here.

Ok, makes sense.

Suzuki


> 
> Cheers, Ilkka
> 
>>
>> With that:
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Suzuki
>>
>>> ---
>>>   drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>>> index 04be94b4aa48..6387cbad7a7d 100644
>>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>>> @@ -715,7 +715,10 @@ static void arm_cspmu_write_counter(struct 
>>> perf_event *event, u64 val)
>>>       if (use_64b_counter_reg(cspmu)) {
>>>           offset = counter_offset(sizeof(u64), event->hw.idx);
>>>   -        writeq(val, cspmu->base1 + offset);
>>> +        if (cspmu->has_atomic_dword)
>>> +            writeq(val, cspmu->base1 + offset);
>>> +        else
>>> +            lo_hi_writeq(val, cspmu->base1 + offset);
>>
>>
>>>       } else {
>>>           offset = counter_offset(sizeof(u32), event->hw.idx);
>>>
>>
>>

