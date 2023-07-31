Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5587695A3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjGaMIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGaMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:08:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC6A410F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:08:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A407DD75;
        Mon, 31 Jul 2023 05:09:27 -0700 (PDT)
Received: from [10.163.53.56] (unknown [10.163.53.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362FA3F5A1;
        Mon, 31 Jul 2023 05:08:41 -0700 (PDT)
Message-ID: <3ee165d7-3727-53cc-295d-a2108734952d@arm.com>
Date:   Mon, 31 Jul 2023 17:38:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/3] arm_pmu: acpi: Add a representative platform device
 for TRBE
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230728112733.359620-1-anshuman.khandual@arm.com>
 <20230728112733.359620-2-anshuman.khandual@arm.com>
 <20230728144056.GE21718@willie-the-truck>
Content-Language: en-US
In-Reply-To: <20230728144056.GE21718@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 20:10, Will Deacon wrote:
> On Fri, Jul 28, 2023 at 04:57:31PM +0530, Anshuman Khandual wrote:
>> ACPI TRBE does not have a HID for identification which could create and add
>> a platform device into the platform bus. Also without a platform device, it
>> cannot be probed and bound to a platform driver.
>>
>> This creates a dummy platform device for TRBE after ascertaining that ACPI
>> provides required interrupts uniformly across all cpus on the system. This
>> device gets created inside drivers/perf/arm_pmu_acpi.c to accommodate TRBE
>> being built as a module.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> --->8
> 
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 90815ad762eb..dd3df6729808 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -139,6 +139,68 @@ static inline void arm_spe_acpi_register_device(void)
>>  }
>>  #endif /* CONFIG_ARM_SPE_PMU */
>>  
>> +#ifdef CONFIG_CORESIGHT_TRBE
>> +static struct resource trbe_acpi_resources[] = {
>> +	{
>> +		/* irq */
>> +		.flags          = IORESOURCE_IRQ,
>> +	}
>> +};
>> +
>> +static struct platform_device trbe_acpi_dev = {
>> +	.name = ARMV8_TRBE_PDEV_NAME,
>> +	.id = -1,
>> +	.resource = trbe_acpi_resources,
>> +	.num_resources = ARRAY_SIZE(trbe_acpi_resources)
>> +};
>> +
>> +static void arm_trbe_acpi_register_device(void)
>> +{
>> +	int cpu, hetid, irq, ret;
>> +	bool first = true;
>> +	u16 gsi = 0;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct acpi_madt_generic_interrupt *gicc;
>> +
>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>> +		if (gicc->header.length < ACPI_MADT_GICC_TRBE)
>> +			return;
>> +
>> +		if (first) {
>> +			gsi = gicc->trbe_interrupt;
>> +			if (!gsi)
>> +				return;
>> +
>> +			hetid = find_acpi_cpu_topology_hetero_id(cpu);
>> +			first = false;
>> +		} else if ((gsi != gicc->trbe_interrupt) ||
>> +			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
>> +			pr_warn("ACPI: TRBE must be homogeneous\n");
>> +			return;
>> +		}
>> +	}
>> +
>> +	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
>> +	if (irq < 0) {
>> +		pr_warn("ACPI: TRBE Unable to register interrupt: %d\n", gsi);
>> +		return;
>> +	}
>> +	trbe_acpi_resources[0].start = irq;
>> +
>> +	ret = platform_device_register(&trbe_acpi_dev);
>> +	if (ret < 0) {
>> +		pr_warn("ACPI: TRBE: Unable to register device\n");
>> +		acpi_unregister_gsi(gsi);
>> +	}
>> +}
>> +#else
>> +static inline void arm_trbe_acpi_register_device(void)
>> +{
>> +
>> +}
>> +#endif /* CONFIG_CORESIGHT_TRBE */
> 
> This looks like you ran s/spe/trbe/ over the SPE device registration
> code :)

Yeah, almost :) 

> 
> Please can you refactor things so we don't have all the duplication? I
> suspect this won't be the last device which needs the same treatement.

Should the refactoring just accommodate SPE, and TRBE or make it more generic to
accommodate future devices as well. Something like the following enumeration.

enum arm_platform_device {
       ARM_PLATFORM_DEVICE_SPE,
       ARM_PLATFORM_DEVICE_TRBE,
       ARM_PLATFORM_DEVICE_MAX,
};

But that would require adding some helper functions to select these following
elements based on the above enumeration via a common function

- gicc->XXX_interrupt
- ACPI_MADT_GICC_SPE/TRBE for header length comparison
- static struct platform_device/resources (static objects in the file)

Seems like will add much more code for a refactor. Did you have something else
in mind for the refactor.
