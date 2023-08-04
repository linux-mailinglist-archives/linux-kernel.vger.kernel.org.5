Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A382876FD22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjHDJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjHDJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:21:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B45F949C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:18:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02A12F4;
        Fri,  4 Aug 2023 02:19:06 -0700 (PDT)
Received: from [10.163.54.21] (unknown [10.163.54.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24203F6C4;
        Fri,  4 Aug 2023 02:18:19 -0700 (PDT)
Message-ID: <3676cc3a-91f1-ec50-5d89-2a3901d0fda7@arm.com>
Date:   Fri, 4 Aug 2023 14:48:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/4] coresight: trbe: Add a representative
 coresight_platform_data for TRBE
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-4-anshuman.khandual@arm.com>
 <3a9b34c0-f5cc-8d55-d5b7-813e400d7715@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3a9b34c0-f5cc-8d55-d5b7-813e400d7715@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 19:25, Suzuki K Poulose wrote:
> On 03/08/2023 06:56, Anshuman Khandual wrote:
>> TRBE coresight devices do not need regular connections information, as the
>> paths get built between all percpu source and their respective percpu sink
>> devices. Please refer 'commit 2cd87a7b293d ("coresight: core: Add support
>> for dedicated percpu sinks")' which added support for percpu sink devices.
>>
>> coresight_register() expect device connections via the platform_data. TRBE
>> devices do not have any graph connections and thus is empty. With upcoming
>> ACPI support for TRBE, we do not get a real acpi_device and thus
>> coresight_get_platform_dat() will end up in failures. Hence this allocates
>> a zeroed coresight_platform_data structure and assigns that back into the
>> device.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 7720619909d6..e1d9d06e7725 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -1494,9 +1494,9 @@ static int arm_trbe_device_probe(struct platform_device *pdev)
>>       if (!drvdata)
>>           return -ENOMEM;
>>   -    pdata = coresight_get_platform_data(dev);
>> -    if (IS_ERR(pdata))
>> -        return PTR_ERR(pdata);
>> +    pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +    if (!pdata)
>> +        return -ENOMEM;
> 
> Please could you add a comment in here, on why we use a dummy platform
> data ? It is good to have documented it in the code too.

Sure, will add the following in-code documentation.

+       /*
+        * TRBE coresight devices do not need regular connections
+        * information, as the paths get built between all percpu
+        * source and their respective percpu sink devices. Though
+        * coresight_register() expect device connections via the
+        * platform_data, which TRBE devices do not have. As they
+        * are not real ACPI devices, coresight_get_platform_dat()
+        * ends up failing. Instead let's allocate a dummy zeroed
+        * coresight_platform_data structure and assign that back
+        * into the device for that purpose.
+        */
