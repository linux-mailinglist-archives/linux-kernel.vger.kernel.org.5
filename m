Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278B877DA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbjHPGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbjHPGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:30:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9523D1FC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:30:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849A81063;
        Tue, 15 Aug 2023 23:31:25 -0700 (PDT)
Received: from [10.162.40.18] (a077893.blr.arm.com [10.162.40.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21AEB3F762;
        Tue, 15 Aug 2023 23:30:39 -0700 (PDT)
Message-ID: <294158a2-19cf-66f0-ea27-a0243f99f907@arm.com>
Date:   Wed, 16 Aug 2023 12:00:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        yangyicong@huawei.com, Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
 <20230808082247.383405-2-anshuman.khandual@arm.com>
 <9d22520a-3450-0e75-59a2-035209f239e6@arm.com>
 <20230811101201.GA6827@willie-the-truck>
 <7920ce3b-15ee-c8d8-a7c0-59009620073c@arm.com>
 <20230811110035.GA6993@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230811110035.GA6993@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 16:30, Will Deacon wrote:
> On Fri, Aug 11, 2023 at 03:55:43PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 8/11/23 15:42, Will Deacon wrote:
>>> On Fri, Aug 11, 2023 at 02:13:42PM +0530, Anshuman Khandual wrote:
>>>> On 8/8/23 13:52, Anshuman Khandual wrote:
>>>>> +	/*
>>>>> +	 * Sanity check all the GICC tables for the same interrupt
>>>>> +	 * number. For now, only support homogeneous ACPI machines.
>>>>> +	 */
>>>>> +	for_each_possible_cpu(cpu) {
>>>>> +		struct acpi_madt_generic_interrupt *gicc;
>>>>> +
>>>>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>>>>> +		if (gicc->header.length < len)
>>>>> +			return gsi ? -ENXIO : 0;
>>>>> +
>>>>> +		this_gsi = parse_gsi(gicc);
>>>>> +		if (!this_gsi)
>>>>> +			return gsi ? -ENXIO : 0;
>>>>> +
>>>>> +		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
>>>>> +		if (!gsi) {
>>>>> +			hetid = this_hetid;
>>>>> +			gsi = this_gsi;
>>>>> +		} else if (hetid != this_hetid || gsi != this_gsi) {
>>>>> +			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
>>>>> +			return -ENXIO;
>>>>> +		}
>>>>> +	}
>>>>
>>>> As discussed on the previous version i.e V3 thread, will move the
>>>> 'this_gsi' check after parse_gsi(), inside if (!gsi) conditional
>>>> block. This will treat subsequent cpu parse_gsi()'s failure as a
>>>> mismatch thus triggering the pr_warn() message.
>>>>
>>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>>> index 845683ca7c64..6eae772d6298 100644
>>>> --- a/drivers/perf/arm_pmu_acpi.c
>>>> +++ b/drivers/perf/arm_pmu_acpi.c
>>>> @@ -98,11 +98,11 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>>>>                         return gsi ? -ENXIO : 0;
>>>>  
>>>>                 this_gsi = parse_gsi(gicc);
>>>> -               if (!this_gsi)
>>>> -                       return gsi ? -ENXIO : 0;
>>>> -
>>>>                 this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
>>>>                 if (!gsi) {
>>>> +                       if (!this_gsi)
>>>> +                               return 0;
>>>
>>> Why do you need this hunk?
>>
>> Otherwise '0' gsi on all cpus would just clear the above homogeneity
>> test, and end up in acpi_register_gsi() making it fail, but with the
>> following warning before returning with -ENXIO.
>>
>> irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
>> if (irq < 0) {
>> 	pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
>> 	return -ENXIO;
>> }
> 
> Ah gotcha, thanks.
> 
>> Is this behaviour better than returning 0 after detecting '0' gsi in
>> the first cpu to avoid the above mentioned scenario ? Although 0 gsi
>> followed by non-zero ones will still end up warning about a mismatch.
> 
> Can we move the check _after_ the loop, then? That way, we still detect
> mismatches but we'll quietly return 0 if nobody has an interrupt.

Sure, will fold in the following changes instead. 

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 845683ca7c64..d7beb035345a 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -98,9 +98,6 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
                        return gsi ? -ENXIO : 0;
 
                this_gsi = parse_gsi(gicc);
-               if (!this_gsi)
-                       return gsi ? -ENXIO : 0;
-
                this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
                if (!gsi) {
                        hetid = this_hetid;
@@ -111,6 +108,15 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
                }
        }
 
+       /*
+        * This is a special case where no cpu on
+        * the system has the interrupt and which
+        * could not have been detected via above
+        * homogeneous mismatch test.
+        */
+       if (!this_gsi)
+               return 0;
+
        irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
        if (irq < 0) {
                pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
