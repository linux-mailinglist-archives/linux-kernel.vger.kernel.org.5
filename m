Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2977F329
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349521AbjHQJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349512AbjHQJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:24:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A54C271B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:24:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D102DD75;
        Thu, 17 Aug 2023 02:25:03 -0700 (PDT)
Received: from [10.57.3.248] (unknown [10.57.3.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6354B3F64C;
        Thu, 17 Aug 2023 02:24:21 -0700 (PDT)
Message-ID: <3f681660-a0f0-20cb-b79b-7b2e2f6a1b5c@arm.com>
Date:   Thu, 17 Aug 2023 10:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] coresight: trbe: Allocate platform data per device
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        hejunhao3@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
        leo.yan@linaro.org, mike.leach@linaro.org, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
 <20230816141008.535450-2-suzuki.poulose@arm.com>
 <9cd9f83c-7778-2d87-a175-a4cb7ceb8723@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <9cd9f83c-7778-2d87-a175-a4cb7ceb8723@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 07:37, Anshuman Khandual wrote:
> Hi Suzuki,
> 
> Seems like this patch is going to conflict with the below proposed change
> 
> https://lore.kernel.org/all/20230817055405.249630-4-anshuman.khandual@arm.com/
> 
> Please let me know how should we resolve this conflict.

We could merge them both, with the fixes: one first, just to acknowledge
that there was a problem. But I suppose your one will have to be rebased
on top.

> 
> On 8/16/23 19:40, Suzuki K Poulose wrote:
>> Coresight TRBE driver shares a single platform data (which is empty btw).
>> However, with the commit 4e8fe7e5c3a5
>> ("coresight: Store pointers to connections rather than an array of them")
>> the coresight core would free up the pdata, resulting in multiple attempts
>> to free the same pdata for TRBE instances. Fix this by allocating a pdata per
>> coresight_device.
>>
>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> 
> The above mentioned commit i.e 4e8fe7e5c3a5 seems to be a more recent one which
> has triggered this problem. But would the problem be still there without that ?
> Else 'Fixes:' tag would need changing.
> 

Yes I think the fixes tag should point to 4e8fe7e5c3a5.

>> Link: https://lore.kernel.org/r/20230814093813.19152-3-hejunhao3@huawei.com
>> Reported-by: Junhao He <hejunhao3@huawei.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-trbe.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 025f70adee47..d3d34a833f01 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -1255,10 +1255,13 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>>  	if (!desc.name)
>>  		goto cpu_clear;
>>  
>> +	desc.pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(desc.pdata))
>> +		goto cpu_clear;
>> +
>>  	desc.type = CORESIGHT_DEV_TYPE_SINK;
>>  	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
>>  	desc.ops = &arm_trbe_cs_ops;
>> -	desc.pdata = dev_get_platdata(dev);
>>  	desc.groups = arm_trbe_groups;
>>  	desc.dev = dev;
>>  	trbe_csdev = coresight_register(&desc);
>> @@ -1482,7 +1485,6 @@ static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
>>  
>>  static int arm_trbe_device_probe(struct platform_device *pdev)
>>  {
>> -	struct coresight_platform_data *pdata;
>>  	struct trbe_drvdata *drvdata;
>>  	struct device *dev = &pdev->dev;
>>  	int ret;
>> @@ -1497,12 +1499,7 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
>>  	if (!drvdata)
>>  		return -ENOMEM;
>>  
>> -	pdata = coresight_get_platform_data(dev);
>> -	if (IS_ERR(pdata))
>> -		return PTR_ERR(pdata);
>> -
>>  	dev_set_drvdata(dev, drvdata);
>> -	dev->platform_data = pdata;
>>  	drvdata->pdev = pdev;
>>  	ret = arm_trbe_probe_irq(pdev, drvdata);
>>  	if (ret)
