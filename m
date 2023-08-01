Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6548076A786
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjHADgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHADgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:36:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77E0D1BEA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:35:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E08BD75;
        Mon, 31 Jul 2023 20:36:42 -0700 (PDT)
Received: from [10.163.53.114] (unknown [10.163.53.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6A5E3F59C;
        Mon, 31 Jul 2023 20:35:56 -0700 (PDT)
Message-ID: <dffbb48e-cb7d-4862-af1c-9723cdc5652e@arm.com>
Date:   Tue, 1 Aug 2023 09:05:54 +0530
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230731145922.GB24881@willie-the-truck>
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



On 7/31/23 20:29, Will Deacon wrote:
> On Mon, Jul 31, 2023 at 05:38:38PM +0530, Anshuman Khandual wrote:
>> On 7/28/23 20:10, Will Deacon wrote:
>>> On Fri, Jul 28, 2023 at 04:57:31PM +0530, Anshuman Khandual wrote:
>>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>>> index 90815ad762eb..dd3df6729808 100644
>>>> --- a/drivers/perf/arm_pmu_acpi.c
>>>> +++ b/drivers/perf/arm_pmu_acpi.c
> 
> [...]
> 
>>>> +	ret = platform_device_register(&trbe_acpi_dev);
>>>> +	if (ret < 0) {
>>>> +		pr_warn("ACPI: TRBE: Unable to register device\n");
>>>> +		acpi_unregister_gsi(gsi);
>>>> +	}
>>>> +}
>>>> +#else
>>>> +static inline void arm_trbe_acpi_register_device(void)
>>>> +{
>>>> +
>>>> +}
>>>> +#endif /* CONFIG_CORESIGHT_TRBE */
>>>
>>> This looks like you ran s/spe/trbe/ over the SPE device registration
>>> code :)
>>
>> Yeah, almost :) 
>>
>>> Please can you refactor things so we don't have all the duplication? I
>>> suspect this won't be the last device which needs the same treatement.
>>
>> Should the refactoring just accommodate SPE, and TRBE or make it more generic to
>> accommodate future devices as well. Something like the following enumeration.
>>
>> enum arm_platform_device {
>>        ARM_PLATFORM_DEVICE_SPE,
>>        ARM_PLATFORM_DEVICE_TRBE,
>>        ARM_PLATFORM_DEVICE_MAX,
>> };
>>
>> But that would require adding some helper functions to select these following
>> elements based on the above enumeration via a common function
>>
>> - gicc->XXX_interrupt
>> - ACPI_MADT_GICC_SPE/TRBE for header length comparison
>> - static struct platform_device/resources (static objects in the file)
>>
>> Seems like will add much more code for a refactor. Did you have something else
>> in mind for the refactor.
> 
> All I'm saying is that we shouldn't have identical copies of the code to
> walk the MADT, pull out the irqs and register the device.
> 
> So something like the totally untested hack below. I probably broke
> something, but hopefully you see what I mean.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 90815ad762eb..7f1cf36c6e69 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -69,6 +69,62 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>                 acpi_unregister_gsi(gsi);
>  }
>  
> +static int
> +arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
> +                            u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))

This factored out helper should be wrapped inside CONFIG_ARM_SPE_PMU
and CONFIG_CORESIGHT_TRBE ? Otherwise, there will be no callers left
for this helper triggering warning.

drivers/perf/arm_pmu_acpi.c:73:1: warning: ‘arm_acpi_register_pmu_device’ defined but not used [-Wunused-function]
   73 | arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

But in that case, we have to keep adding new configs when new devices
require platform devices to be registered. Is there a better way ?

> +{
> +       int cpu, hetid, irq, ret;
> +       bool matched = false;
> +       u16 gsi = 0;
> +
> +       if (pdev->num_resources != 1)
> +               return -ENXIO;
> +
> +       if (pdev->resource[0].flags != IORESOURCE_IRQ)
> +               return -ENXIO;
> +
> +       /*
> +        * Sanity check all the GICC tables for the same interrupt number.
> +        * For now, we only support homogeneous ACPI machines.
> +        */
> +       for_each_possible_cpu(cpu) {
> +               struct acpi_madt_generic_interrupt *gicc;
> +               u16 this_gsi;
> +
> +               gicc = acpi_cpu_get_madt_gicc(cpu);
> +               if (gicc->header.length < len)
> +                       return matched ? -ENXIO : 0;
> +
> +               this_gsi = parse_gsi(gicc);
> +               if (!matched) {
> +                       hetid = find_acpi_cpu_topology_hetero_id(cpu);
> +                       gsi = this_gsi;
> +                       matched = true;
> +               } else if (hetid != find_acpi_cpu_topology_hetero_id(cpu) ||
> +                          gsi != this_gsi) {
> +                       pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> +                       return -ENXIO;
> +               }
> +       }
> +
> +       irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
> +                               ACPI_ACTIVE_HIGH);
> +       if (irq < 0) {
> +               pr_warn("ACPI: %s Unable to register interrupt: %d\n",
> +                       pdev->name, gsi);
> +               return -ENXIO;
> +       }
> +
> +       pdev->resource[0].start = irq;
> +       ret = platform_device_register(pdev);
> +       if (ret < 0) {
> +               pr_warn("ACPI: %s: Unable to register device\n", pdev->name);
> +               acpi_unregister_gsi(gsi);
> +       }
> +
> +       return ret;
> +}
> +
>  #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
>  static struct resource spe_resources[] = {
>         {
> @@ -89,49 +145,18 @@ static struct platform_device spe_dev = {
>   * and create a SPE device if we detect a recent MADT with
>   * a homogeneous PPI mapping.
>   */
> +static u16 arm_spe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
> +{
> +       return gicc->spe_interrupt;
> +}
> +
>  static void arm_spe_acpi_register_device(void)
>  {
> -       int cpu, hetid, irq, ret;
> -       bool first = true;
> -       u16 gsi = 0;
> +       int err = arm_acpi_register_pmu_device(&spe_dev, ACPI_MADT_GICC_SPE,
> +                                              arm_spe_parse_gsi);
>  
> -       /*
> -        * Sanity check all the GICC tables for the same interrupt number.
> -        * For now, we only support homogeneous ACPI/SPE machines.
> -        */
> -       for_each_possible_cpu(cpu) {
> -               struct acpi_madt_generic_interrupt *gicc;
> -
> -               gicc = acpi_cpu_get_madt_gicc(cpu);
> -               if (gicc->header.length < ACPI_MADT_GICC_SPE)
> -                       return;
> -
> -               if (first) {
> -                       gsi = gicc->spe_interrupt;
> -                       if (!gsi)
> -                               return;
> -                       hetid = find_acpi_cpu_topology_hetero_id(cpu);
> -                       first = false;
> -               } else if ((gsi != gicc->spe_interrupt) ||
> -                          (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
> -                       pr_warn("ACPI: SPE must be homogeneous\n");
> -                       return;
> -               }
> -       }
> -
> -       irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
> -                               ACPI_ACTIVE_HIGH);
> -       if (irq < 0) {
> -               pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
> -               return;
> -       }
> -
> -       spe_resources[0].start = irq;
> -       ret = platform_device_register(&spe_dev);
> -       if (ret < 0) {
> -               pr_warn("ACPI: SPE: Unable to register device\n");
> -               acpi_unregister_gsi(gsi);
> -       }
> +       if (err)
> +               pr_warn("ACPI: Failed to register SPE device\n");
>  }
>  #else
>  static inline void arm_spe_acpi_register_device(void)
> 
