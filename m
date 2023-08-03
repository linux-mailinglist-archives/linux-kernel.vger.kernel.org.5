Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8859676E412
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjHCJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHCJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:15:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36CAC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:14:59 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGjl669TczNmlt;
        Thu,  3 Aug 2023 17:11:30 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 17:14:56 +0800
CC:     <yangyicong@hisilicon.com>, Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        Junhao He <hejunhao3@huawei.com>
Subject: Re: [PATCH V3 2/4] arm_pmu: acpi: Add a representative platform
 device for TRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-3-anshuman.khandual@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ca382ed6-7f16-304c-e937-c620dfed6f6e@huawei.com>
Date:   Thu, 3 Aug 2023 17:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230803055652.1322801-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/3 13:56, Anshuman Khandual wrote:
> ACPI TRBE does not have a HID for identification which could create and add
> a platform device into the platform bus. Also without a platform device, it
> cannot be probed and bound to a platform driver.
> 
> This creates a dummy platform device for TRBE after ascertaining that ACPI
> provides required interrupts uniformly across all cpus on the system. This
> device gets created inside drivers/perf/arm_pmu_acpi.c to accommodate TRBE
> being built as a module.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h |  3 +++
>  drivers/perf/arm_pmu_acpi.c   | 37 ++++++++++++++++++++++++++++++++++-
>  include/linux/perf/arm_pmu.h  |  1 +
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bd68e1b7f29f..4d537d56eb84 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -42,6 +42,9 @@
>  #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
>  	spe_interrupt) + sizeof(u16))
>  
> +#define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
> +	trbe_interrupt) + sizeof(u16))
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 235c14766a36..79feea548e6e 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -69,7 +69,7 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>  		acpi_unregister_gsi(gsi);
>  }
>  
> -#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
> +#if IS_ENABLED(CONFIG_ARM_SPE_PMU) || IS_ENABLED(CONFIG_CORESIGHT_TRBE)
>  static int
>  arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
>  			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
> @@ -166,6 +166,40 @@ static inline void arm_spe_acpi_register_device(void)
>  }
>  #endif /* CONFIG_ARM_SPE_PMU */
>  
> +#ifdef CONFIG_CORESIGHT_TRBE

Maybe we should use #if IS_ENABLED(CONFIG_CORESIGHT_TRBE) here and other places?

As trbe can be configured as a module, when CONFIG_CORESIGHT_TRBE=m this block
won't be compiled. Referred to

https://github.com/torvalds/linux/blob/c7c90e121e992eefdf07945e5a6e9cf097b29463/include/linux/kconfig.h#L68

> +static struct resource trbe_resources[] = {
> +	{
> +		/* irq */
> +		.flags          = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device trbe_dev = {
> +	.name = ARMV8_TRBE_PDEV_NAME,
> +	.id = -1,
> +	.resource = trbe_resources,
> +	.num_resources = ARRAY_SIZE(trbe_resources)
> +};
> +
> +static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
> +{
> +	return gicc->trbe_interrupt;
> +}
> +
> +static void arm_trbe_acpi_register_device(void)
> +{
> +	int ret = arm_acpi_register_pmu_device(&trbe_dev, ACPI_MADT_GICC_TRBE,
> +					       arm_trbe_parse_gsi);
> +	if (ret)
> +		pr_warn("ACPI: TRBE: Unable to register device\n");
> +}
> +#else
> +static inline void arm_trbe_acpi_register_device(void)
> +{
> +
> +}
> +#endif /* CONFIG_CORESIGHT_TRBE */
> +
>  static int arm_pmu_acpi_parse_irqs(void)
>  {
>  	int irq, cpu, irq_cpu, err;
> @@ -401,6 +435,7 @@ static int arm_pmu_acpi_init(void)
>  		return 0;
>  
>  	arm_spe_acpi_register_device();
> +	arm_trbe_acpi_register_device();
>  
>  	return 0;
>  }
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index a0801f68762b..143fbc10ecfe 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
>  #endif /* CONFIG_ARM_PMU */
>  
>  #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
> +#define ARMV8_TRBE_PDEV_NAME "arm,trbe"
>  
>  #endif /* __ARM_PMU_H__ */
> 
