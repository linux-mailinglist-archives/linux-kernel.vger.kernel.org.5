Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568C7786D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHKFDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjHKFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:03:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C20270C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:03:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAC6BD75;
        Thu, 10 Aug 2023 22:03:47 -0700 (PDT)
Received: from [10.163.54.13] (unknown [10.163.54.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57D803F6C4;
        Thu, 10 Aug 2023 22:03:01 -0700 (PDT)
Message-ID: <b7808976-1e4d-d4f5-cc8c-7905e60b05e1@arm.com>
Date:   Fri, 11 Aug 2023 10:32:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, yangyicong@huawei.com,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
 <20230808082247.383405-2-anshuman.khandual@arm.com>
 <8bef9c5a-eede-f78f-4418-da10c99a5bef@arm.com>
 <20230808131634.GA2369@willie-the-truck>
 <c2448e06-b46f-8a6d-163d-32364954fc23@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c2448e06-b46f-8a6d-163d-32364954fc23@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/23 18:24, Suzuki K Poulose wrote:
> On 08/08/2023 14:16, Will Deacon wrote:
>> On Tue, Aug 08, 2023 at 09:48:16AM +0100, Suzuki K Poulose wrote:
>>> On 08/08/2023 09:22, Anshuman Khandual wrote:
>>>> Sanity checking all the GICC tables for same interrupt number, and ensuring
>>>> a homogeneous ACPI based machine, could be used for other platform devices
>>>> as well. Hence this refactors arm_spe_acpi_register_device() into a common
>>>> helper arm_acpi_register_pmu_device().
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Co-developed-by: Will Deacon <will@kernel.org>
>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    drivers/perf/arm_pmu_acpi.c | 105 ++++++++++++++++++++++--------------
>>>>    1 file changed, 65 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>>> index 90815ad762eb..72454bef2a70 100644
>>>> --- a/drivers/perf/arm_pmu_acpi.c
>>>> +++ b/drivers/perf/arm_pmu_acpi.c
>>>> @@ -69,6 +69,63 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>>>            acpi_unregister_gsi(gsi);
>>>>    }
>>>> +static int __maybe_unused
>>>> +arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>>>> +                 u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
>>>> +{
>>>> +    int cpu, this_hetid, hetid, irq, ret;
>>>> +    u16 this_gsi, gsi = 0;
>>>> +
>>>> +    /*
>>>> +     * Ensure that platform device must have IORESOURCE_IRQ
>>>> +     * resource to hold gsi interrupt.
>>>> +     */
>>>> +    if (pdev->num_resources != 1)
>>>> +        return -ENXIO;
>>>> +
>>>> +    if (pdev->resource[0].flags != IORESOURCE_IRQ)
>>>> +        return -ENXIO;
>>>> +
>>>> +    /*
>>>> +     * Sanity check all the GICC tables for the same interrupt
>>>> +     * number. For now, only support homogeneous ACPI machines.
>>>> +     */
>>>> +    for_each_possible_cpu(cpu) {
>>>> +        struct acpi_madt_generic_interrupt *gicc;
>>>> +
>>>> +        gicc = acpi_cpu_get_madt_gicc(cpu);
>>>> +        if (gicc->header.length < len)
>>>> +            return gsi ? -ENXIO : 0;
>>>> +
>>>> +        this_gsi = parse_gsi(gicc);
>>>> +        if (!this_gsi)
>>>> +            return gsi ? -ENXIO : 0;
>>>> +
>>>> +        this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
>>>> +        if (!gsi) {
>>>> +            hetid = this_hetid;
>>>> +            gsi = this_gsi;
>>>> +        } else if (hetid != this_hetid || gsi != this_gsi) {
>>>> +            pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
>>>> +            return -ENXIO;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
>>>> +    if (irq < 0) {
>>>> +        pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
>>>> +        return -ENXIO;
>>>> +    }
>>>> +
>>>> +    pdev->resource[0].start = irq;
>>>> +    ret = platform_device_register(pdev);
>>>> +    if (ret < 0) {
>>>> +        pr_warn("ACPI: %s: Unable to register device\n", pdev->name);
>>>> +        acpi_unregister_gsi(gsi);
>>>> +    }
>>>> +    return ret;
>>>
>>> A postivie return value here could confuse the caller. Also, with my comment
>>> below, we don't really need to return something from here.
>>
>> How does this return a positive value?
> 
> Right now, there aren't. My point is this function returns a "return value" of another function. And the caller of this function doesn't
> really follow the "check" it needs.  e.g.:
> 
> ret = foo();
> if (ret < 0)
>     error;
> return ret;
> 
> 
> 
> And the caller only checks for
> 
> if (ret)
>     error;
> 
> This seems fragile.
> 
>>
>>>> +    int ret = arm_acpi_register_pmu_device(&spe_dev, ACPI_MADT_GICC_SPE,
>>>> +                           arm_spe_parse_gsi);
>>>> +    if (ret)
>>>>            pr_warn("ACPI: SPE: Unable to register device\n");
>>>
>>> With this change, a system without SPE interrupt description always
>>> generates the above message. Is this intended ?
>>
>> If there are no irqs, why doesn't this return 0?
> 
> Apologies, I missed that.
> 
>> arm_acpi_register_pmu_device() should only fail if either:
>>
>>    - The static resources passed in are broken
>>    - The tables are not homogeneous
>>    - We fail to register the interrupt
>>
>> so something is amiss.
> 
> Agreed. We don't need duplicate messages about an error ?
> i.e., one in arm_acpi_register_pmu_device() and another
> one in the caller ? (Of course adding any missing error msgs).
> 
> 
>>
>>> Could we not drop the above message as all the other possible error
>>> scenarios are reported. We could simply make the above helper void, see my
>>> comment above.
>>
>> I disagree. If the ACPI tables are borked, we should print a message saying
>> so.
> 
> Ok, fair point.

I am confused, what's the conclusion, should we just leave this unchanged ?
