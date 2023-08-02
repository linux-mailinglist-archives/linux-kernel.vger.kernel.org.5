Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CEC76C30A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjHBCoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjHBCom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:44:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F8C1FD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:44:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5DDFD75;
        Tue,  1 Aug 2023 19:45:23 -0700 (PDT)
Received: from [10.163.53.180] (unknown [10.163.53.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF9E3F5A1;
        Tue,  1 Aug 2023 19:44:37 -0700 (PDT)
Message-ID: <e0c378fc-15f8-0f7f-1fa7-9b498294b9bb@arm.com>
Date:   Wed, 2 Aug 2023 08:14:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
 <20230801094052.750416-2-anshuman.khandual@arm.com>
 <20230801144936.GE26253@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230801144936.GE26253@willie-the-truck>
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



On 8/1/23 20:19, Will Deacon wrote:
> On Tue, Aug 01, 2023 at 03:10:49PM +0530, Anshuman Khandual wrote:
>> Sanity checking all the GICC tables for same interrupt number, and ensuring
>> a homogeneous ACPI based machine, could be used for other platform devices
>> as well. Hence this refactors arm_spe_acpi_register_device() into a common
>> helper arm_acpi_register_pmu_device().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Co-developed-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_acpi.c | 110 +++++++++++++++++++++++-------------
>>  1 file changed, 70 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 90815ad762eb..d9d5a7bbb92f 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -70,6 +70,68 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>  }
>>  
>>  #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
>> +static int
>> +arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>> +			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
>> +{
>> +	int cpu, hetid, irq, ret;
>> +	bool matched = false;
>> +	u16 gsi = 0;
>> +
>> +	/*
>> +	 * Ensure that platform device must have IORESOURCE_IRQ
>> +	 * resource to hold gsi interrupt.
>> +	 */
>> +	if (pdev->num_resources != 1)
>> +		return -ENXIO;
>> +
>> +	if (pdev->resource[0].flags != IORESOURCE_IRQ)
>> +		return -ENXIO;
>> +
>> +	/*
>> +	 * Sanity check all the GICC tables for the same interrupt
>> +	 * number. For now, only support homogeneous ACPI machines.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		struct acpi_madt_generic_interrupt *gicc;
>> +		u16 this_gsi;
>> +
>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>> +		if (gicc->header.length < len)
>> +			return matched ? -ENXIO : 0;
>> +
>> +		this_gsi = parse_gsi(gicc);
>> +		if (!this_gsi)
>> +			return matched ? -ENXIO : 0;
> 
> I think you can push this check into the conditional below...
> 
>> +
>> +		if (!matched) {
>> +			hetid = find_acpi_cpu_topology_hetero_id(cpu);
> 
> ... i.e. add a:
> 
> 			if (!this_gsi)
> 				return -ENXIO;
> 
> here.
> 
>> +			gsi = this_gsi;
>> +			matched = true;
> 
> And then, come to think of it, can we get rid of 'matched' altogether?
> Since a gsi of 0 is treated as invalid, we could just check that instead,
> no? So this becomes:
> 
> 
> 		gicc = acpi_cpu_get_madt_gicc(cpu);
> 		if (gicc->header.length < len)
> 			return gsi ? -ENXIO : 0;
> 
> 		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
> 		this_gsi = parse_gsi(gicc);
> 		if (!gsi) {
> 			if (!this_gsi)
> 				return -ENXIO;

Unlike before, this returns -ENXIO on the very first instance itself without
a match. Previously this returned 0 in such cases. But I guess that is okay.

> 			gsi = this_gsi;
> 			hetid = this_hetid;
> 		} else if (hetid != this_hetid || gsi != this_gsi) {
> 			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> 			return -ENXIO;
> 		}
> 
> 
> What do you reckon?

This makes sense, and the modified function will look something like

arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
                             u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
{
        int cpu, irq, ret;
        u16 gsi = 0;

        /*
         * Ensure that platform device must have IORESOURCE_IRQ
         * resource to hold gsi interrupt.
         */
        if (pdev->num_resources != 1)
                return -ENXIO;

        if (pdev->resource[0].flags != IORESOURCE_IRQ)
                return -ENXIO;

        /*
         * Sanity check all the GICC tables for the same interrupt
         * number. For now, only support homogeneous ACPI machines.
         */
        for_each_possible_cpu(cpu) {
                struct acpi_madt_generic_interrupt *gicc;
                int this_hetid, hetid;
                u16 this_gsi;

                gicc = acpi_cpu_get_madt_gicc(cpu);
                if (gicc->header.length < len)
                        return gsi ? -ENXIO : 0;

                this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
                this_gsi = parse_gsi(gicc);
                if (!gsi) {
                        if (!this_gsi)
                                return -ENXIO;

                        hetid = this_hetid;
                        gsi = this_gsi;
                } else if (hetid != this_hetid || gsi != this_gsi) {
                        pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
                        return -ENXIO;
                }
        }

        irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
        if (irq < 0) {
                pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
                return -ENXIO;
        }

        pdev->resource[0].start = irq;
        ret = platform_device_register(pdev);
        if (ret < 0) {
                pr_warn("ACPI: %s: Unable to register device\n", pdev->name);
                acpi_unregister_gsi(gsi);
        }
        return ret;
}
