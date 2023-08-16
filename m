Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACE677DBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbjHPIGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbjHPIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:06:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB7E9AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:06:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3280F1063;
        Wed, 16 Aug 2023 01:07:15 -0700 (PDT)
Received: from [10.162.40.18] (a077893.blr.arm.com [10.162.40.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE5EA3F64C;
        Wed, 16 Aug 2023 01:06:31 -0700 (PDT)
Message-ID: <435813e1-3e26-d125-d706-a2e3d8fd4e45@arm.com>
Date:   Wed, 16 Aug 2023 13:36:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] coresight: etm4x: Ensure valid drvdata and clock before
 clk_put()
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20230811062738.1066787-1-anshuman.khandual@arm.com>
 <07b0dabb-5409-9ba8-543f-aeecafe083e9@arm.com>
 <72960b11-9e35-a259-3ea6-bae91ff94838@arm.com>
 <32017de8-7b92-a88f-0bf6-da1dfe3a7f7d@arm.com>
 <b253e26f-f39d-52be-0aec-0fa72c6947f9@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b253e26f-f39d-52be-0aec-0fa72c6947f9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 15:44, James Clark wrote:
> 
> 
> On 11/08/2023 10:22, Anshuman Khandual wrote:
>>
>>
>> On 8/11/23 14:39, Suzuki K Poulose wrote:
>>> On 11/08/2023 09:39, James Clark wrote:
>>>>
>>>>
>>>> On 11/08/2023 07:27, Anshuman Khandual wrote:
>>>>> This validates 'drvdata' and 'drvdata->pclk' clock before calling clk_put()
>>>>> in etm4_remove_platform_dev(). The problem was detected using Smatch static
>>>>> checker as reported.
>>>>>
>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>> Cc: James Clark <james.clark@arm.com>
>>>>> Cc: coresight@lists.linaro.org
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>>> Closes: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/G4N6P4OXELPLLQSNU3GU2MR4LOLRXRMJ/
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>>> This applies on coresight-next
>>>>>
>>>>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> index 703b6fcbb6a5..eb412ce302cc 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> @@ -2269,7 +2269,7 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
>>>>>           etm4_remove_dev(drvdata);
>>>>>       pm_runtime_disable(&pdev->dev);
>>>>>   -    if (drvdata->pclk)
>>>>> +    if (drvdata && drvdata->pclk && !IS_ERR(drvdata->pclk))
>>>>>           clk_put(drvdata->pclk);
>>>>>         return 0;
>>>>
>>>> It could be !IS_ERR_OR_NULL(drvdata->pclk), but I wouldn't bother
>>>> changing it at this point.
>>>
>>> +1, please could we have that. Someone else will run a code scanner and
>>> send a patch later. Given this is straight and easy change, lets do it
>>> in the first place.
>>
>> But we already have a drvdata->pclk validation check before IS_ERR().
>> Would not _OR_NULL be redundant ?
> 
> I meant that it could be replaced with the single check:
> 
>   if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
>       clk_put(drvdata->pclk);
> 
> As Dan mentions it can't be an error pointer anyway, but leaving it like
> this could just be considered defensive coding.

Let's just go with the above change as you had suggested unless there is any
particular objection.

if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
	clk_put(drvdata->pclk);
