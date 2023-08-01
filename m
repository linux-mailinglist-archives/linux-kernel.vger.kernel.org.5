Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEC76AB5A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjHAIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHAIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:53:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E5881711
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:53:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61688D75;
        Tue,  1 Aug 2023 01:54:26 -0700 (PDT)
Received: from [10.163.53.114] (unknown [10.163.53.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3B43F5A1;
        Tue,  1 Aug 2023 01:53:40 -0700 (PDT)
Message-ID: <3380a12b-605e-394c-c711-e31ce4112e60@arm.com>
Date:   Tue, 1 Aug 2023 14:23:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] arm_pmu: acpi: Add a representative platform device
 for TRBE
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230728112733.359620-1-anshuman.khandual@arm.com>
 <20230728112733.359620-2-anshuman.khandual@arm.com>
 <20230728144056.GE21718@willie-the-truck>
 <3ee165d7-3727-53cc-295d-a2108734952d@arm.com>
 <20230731145922.GB24881@willie-the-truck>
 <dffbb48e-cb7d-4862-af1c-9723cdc5652e@arm.com>
 <20230801073857.GB25854@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230801073857.GB25854@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 13:08, Will Deacon wrote:
> On Tue, Aug 01, 2023 at 09:05:54AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 7/31/23 20:29, Will Deacon wrote:
>>> On Mon, Jul 31, 2023 at 05:38:38PM +0530, Anshuman Khandual wrote:
>>>> On 7/28/23 20:10, Will Deacon wrote:
>>>>> On Fri, Jul 28, 2023 at 04:57:31PM +0530, Anshuman Khandual wrote:
>>>>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>>>>> index 90815ad762eb..dd3df6729808 100644
>>>>>> --- a/drivers/perf/arm_pmu_acpi.c
>>>>>> +++ b/drivers/perf/arm_pmu_acpi.c
>>>
>>> [...]
>>>
>>>>>> +	ret = platform_device_register(&trbe_acpi_dev);
>>>>>> +	if (ret < 0) {
>>>>>> +		pr_warn("ACPI: TRBE: Unable to register device\n");
>>>>>> +		acpi_unregister_gsi(gsi);
>>>>>> +	}
>>>>>> +}
>>>>>> +#else
>>>>>> +static inline void arm_trbe_acpi_register_device(void)
>>>>>> +{
>>>>>> +
>>>>>> +}
>>>>>> +#endif /* CONFIG_CORESIGHT_TRBE */
>>>>>
>>>>> This looks like you ran s/spe/trbe/ over the SPE device registration
>>>>> code :)
>>>>
>>>> Yeah, almost :) 
>>>>
>>>>> Please can you refactor things so we don't have all the duplication? I
>>>>> suspect this won't be the last device which needs the same treatement.
>>>>
>>>> Should the refactoring just accommodate SPE, and TRBE or make it more generic to
>>>> accommodate future devices as well. Something like the following enumeration.
>>>>
>>>> enum arm_platform_device {
>>>>        ARM_PLATFORM_DEVICE_SPE,
>>>>        ARM_PLATFORM_DEVICE_TRBE,
>>>>        ARM_PLATFORM_DEVICE_MAX,
>>>> };
>>>>
>>>> But that would require adding some helper functions to select these following
>>>> elements based on the above enumeration via a common function
>>>>
>>>> - gicc->XXX_interrupt
>>>> - ACPI_MADT_GICC_SPE/TRBE for header length comparison
>>>> - static struct platform_device/resources (static objects in the file)
>>>>
>>>> Seems like will add much more code for a refactor. Did you have something else
>>>> in mind for the refactor.
>>>
>>> All I'm saying is that we shouldn't have identical copies of the code to
>>> walk the MADT, pull out the irqs and register the device.
>>>
>>> So something like the totally untested hack below. I probably broke
>>> something, but hopefully you see what I mean.
>>>
>>> Will
>>>
>>> --->8
>>>
>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>> index 90815ad762eb..7f1cf36c6e69 100644
>>> --- a/drivers/perf/arm_pmu_acpi.c
>>> +++ b/drivers/perf/arm_pmu_acpi.c
>>> @@ -69,6 +69,62 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>>                 acpi_unregister_gsi(gsi);
>>>  }
>>>  
>>> +static int
>>> +arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>>> +                            u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
>>
>> This factored out helper should be wrapped inside CONFIG_ARM_SPE_PMU
>> and CONFIG_CORESIGHT_TRBE ? Otherwise, there will be no callers left
>> for this helper triggering warning.
>>
>> drivers/perf/arm_pmu_acpi.c:73:1: warning: ‘arm_acpi_register_pmu_device’ defined but not used [-Wunused-function]
>>    73 | arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> But in that case, we have to keep adding new configs when new devices
>> require platform devices to be registered. Is there a better way ?
> 
> __maybe_unused?
> 
> Like I said, I didn't test that thing at all, I was just trying to
> illustrate the sort of refactoring I had in mind.

Sure. If it's okay, will use your Co-developed-by/Signed-off-by tags
for this refactoring patch.
