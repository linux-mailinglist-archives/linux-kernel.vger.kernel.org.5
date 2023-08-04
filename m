Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678D476FD69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjHDJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjHDJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:34:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12ED349CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:34:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CC01007;
        Fri,  4 Aug 2023 02:35:25 -0700 (PDT)
Received: from [10.163.54.21] (unknown [10.163.54.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6683C3F6C4;
        Fri,  4 Aug 2023 02:34:37 -0700 (PDT)
Message-ID: <417700d0-0bae-09d9-06f4-16f4af2e960d@arm.com>
Date:   Fri, 4 Aug 2023 15:04:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 2/4] arm_pmu: acpi: Add a representative platform
 device for TRBE
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     yangyicong@hisilicon.com, Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, Junhao He <hejunhao3@huawei.com>
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-3-anshuman.khandual@arm.com>
 <ca382ed6-7f16-304c-e937-c620dfed6f6e@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ca382ed6-7f16-304c-e937-c620dfed6f6e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 14:44, Yicong Yang wrote:
> On 2023/8/3 13:56, Anshuman Khandual wrote:
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
>> ---
>>  arch/arm64/include/asm/acpi.h |  3 +++
>>  drivers/perf/arm_pmu_acpi.c   | 37 ++++++++++++++++++++++++++++++++++-
>>  include/linux/perf/arm_pmu.h  |  1 +
>>  3 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index bd68e1b7f29f..4d537d56eb84 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -42,6 +42,9 @@
>>  #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
>>  	spe_interrupt) + sizeof(u16))
>>  
>> +#define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
>> +	trbe_interrupt) + sizeof(u16))
>> +
>>  /* Basic configuration for ACPI */
>>  #ifdef	CONFIG_ACPI
>>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>> index 235c14766a36..79feea548e6e 100644
>> --- a/drivers/perf/arm_pmu_acpi.c
>> +++ b/drivers/perf/arm_pmu_acpi.c
>> @@ -69,7 +69,7 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>>  		acpi_unregister_gsi(gsi);
>>  }
>>  
>> -#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
>> +#if IS_ENABLED(CONFIG_ARM_SPE_PMU) || IS_ENABLED(CONFIG_CORESIGHT_TRBE)
>>  static int
>>  arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>>  			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
>> @@ -166,6 +166,40 @@ static inline void arm_spe_acpi_register_device(void)
>>  }
>>  #endif /* CONFIG_ARM_SPE_PMU */
>>  
>> +#ifdef CONFIG_CORESIGHT_TRBE
> Maybe we should use #if IS_ENABLED(CONFIG_CORESIGHT_TRBE) here and other places?
> 
> As trbe can be configured as a module, when CONFIG_CORESIGHT_TRBE=m this block
> won't be compiled. Referred to
> 
> https://github.com/torvalds/linux/blob/c7c90e121e992eefdf07945e5a6e9cf097b29463/include/linux/kconfig.h#L68

You are right, just making CONFIG_CORESIGHT_TRBE=m make it fall back on the
stub arm_trbe_acpi_register_device() definition, which does not create the
required dummy platform device thus preventing TRBE probe on the platform.

Will change the above #ifdef as IS_ENABLED() for CONFIG_CORESIGHT_TRBE and
revert back using IS_ENABLED() in the previous patch for CONFIG_ARM_SPE_PMU
as well. Thanks for noticing this problem.
