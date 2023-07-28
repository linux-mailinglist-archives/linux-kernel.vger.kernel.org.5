Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA58766FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjG1OlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjG1OlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083813C31
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738666216F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E46AC433C8;
        Fri, 28 Jul 2023 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690555261;
        bh=kSXsnHnwVcJeZp6xR87fgehZfFMYiwcUJhbgW1tPkp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOM6vudpAc9TxxYRLu9oYyWRiQzi3SLFY4/7ktvnUqaD0+H6Uensn1ACf9+BWOyD1
         yPWlQ7JqpbKqgrqQpAeTNauI+mozOUVOJwnTk2jzLT6NvBVmd6+rq5O1uRb1SEs8Np
         DeuuhuBLhPIQpK3AZQbjaIJgMNifZ1UOUdIbXsZXQk1cX00smBn0/V404oT5Npfl2a
         QaTPxBpgo0+9UjhpEoC3FnR2Qb58MlHPKSSNIVQ6Lk3UUmwlbm80s331IiVP14FyKC
         x5SXJM1rczf546NzeJevmgy+hpKqS2ws7yhQRs+yybC2ZuUNAzgJxg9RjPoWRkBXtM
         utfFNV6zclPww==
Date:   Fri, 28 Jul 2023 15:40:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm_pmu: acpi: Add a representative platform device
 for TRBE
Message-ID: <20230728144056.GE21718@willie-the-truck>
References: <20230728112733.359620-1-anshuman.khandual@arm.com>
 <20230728112733.359620-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728112733.359620-2-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:57:31PM +0530, Anshuman Khandual wrote:
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

--->8

> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 90815ad762eb..dd3df6729808 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -139,6 +139,68 @@ static inline void arm_spe_acpi_register_device(void)
>  }
>  #endif /* CONFIG_ARM_SPE_PMU */
>  
> +#ifdef CONFIG_CORESIGHT_TRBE
> +static struct resource trbe_acpi_resources[] = {
> +	{
> +		/* irq */
> +		.flags          = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device trbe_acpi_dev = {
> +	.name = ARMV8_TRBE_PDEV_NAME,
> +	.id = -1,
> +	.resource = trbe_acpi_resources,
> +	.num_resources = ARRAY_SIZE(trbe_acpi_resources)
> +};
> +
> +static void arm_trbe_acpi_register_device(void)
> +{
> +	int cpu, hetid, irq, ret;
> +	bool first = true;
> +	u16 gsi = 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct acpi_madt_generic_interrupt *gicc;
> +
> +		gicc = acpi_cpu_get_madt_gicc(cpu);
> +		if (gicc->header.length < ACPI_MADT_GICC_TRBE)
> +			return;
> +
> +		if (first) {
> +			gsi = gicc->trbe_interrupt;
> +			if (!gsi)
> +				return;
> +
> +			hetid = find_acpi_cpu_topology_hetero_id(cpu);
> +			first = false;
> +		} else if ((gsi != gicc->trbe_interrupt) ||
> +			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
> +			pr_warn("ACPI: TRBE must be homogeneous\n");
> +			return;
> +		}
> +	}
> +
> +	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
> +	if (irq < 0) {
> +		pr_warn("ACPI: TRBE Unable to register interrupt: %d\n", gsi);
> +		return;
> +	}
> +	trbe_acpi_resources[0].start = irq;
> +
> +	ret = platform_device_register(&trbe_acpi_dev);
> +	if (ret < 0) {
> +		pr_warn("ACPI: TRBE: Unable to register device\n");
> +		acpi_unregister_gsi(gsi);
> +	}
> +}
> +#else
> +static inline void arm_trbe_acpi_register_device(void)
> +{
> +
> +}
> +#endif /* CONFIG_CORESIGHT_TRBE */

This looks like you ran s/spe/trbe/ over the SPE device registration
code :)

Please can you refactor things so we don't have all the duplication? I
suspect this won't be the last device which needs the same treatement.

Cheers,

Will
