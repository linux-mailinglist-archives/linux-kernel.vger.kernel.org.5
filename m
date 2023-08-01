Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BD76B7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjHAOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjHAOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82D1BE7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C81AA615C4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A07C433C8;
        Tue,  1 Aug 2023 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901382;
        bh=INsuVNO/wR50prZmg2Ysz1eWgtnwO2EveqPcDa30rzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdoAuptvxrc+JwCibFkcOHgjU84uQetNEEwlwQMLHwQLZzF17eNth6qX5y6gt6Xn0
         FdDY0m3yYld0AAszLNGg1KIU9pwh21QcMIcWTZhjOjKnhLZQs+vMdsQj0lzwwYO0OI
         nQtiZ7BrwOFMklnJI50tyNNAVvRuB9AxnLC3oearNF/O4OzWyg+TTPegCA8wOoFn5i
         UZEXuKriYfdYgsX+/SWXl8/5B8us6N4kX/KNr/ZHfn0OtaT+mmfgpAMIjMC8g88xsZ
         gE6F3iWj1ZhbEyPFLV0gDb8cPrdhU0I39vUS7GO5dmwmi+PpZk48w9tDFhinuzEcu6
         F5MiOQGToY5Pg==
Date:   Tue, 1 Aug 2023 15:49:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] arm_pmu: acpi: Refactor
 arm_spe_acpi_register_device()
Message-ID: <20230801144936.GE26253@willie-the-truck>
References: <20230801094052.750416-1-anshuman.khandual@arm.com>
 <20230801094052.750416-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801094052.750416-2-anshuman.khandual@arm.com>
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

On Tue, Aug 01, 2023 at 03:10:49PM +0530, Anshuman Khandual wrote:
> Sanity checking all the GICC tables for same interrupt number, and ensuring
> a homogeneous ACPI based machine, could be used for other platform devices
> as well. Hence this refactors arm_spe_acpi_register_device() into a common
> helper arm_acpi_register_pmu_device().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Co-developed-by: Will Deacon <will@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/perf/arm_pmu_acpi.c | 110 +++++++++++++++++++++++-------------
>  1 file changed, 70 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 90815ad762eb..d9d5a7bbb92f 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -70,6 +70,68 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>  }
>  
>  #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
> +static int
> +arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
> +			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
> +{
> +	int cpu, hetid, irq, ret;
> +	bool matched = false;
> +	u16 gsi = 0;
> +
> +	/*
> +	 * Ensure that platform device must have IORESOURCE_IRQ
> +	 * resource to hold gsi interrupt.
> +	 */
> +	if (pdev->num_resources != 1)
> +		return -ENXIO;
> +
> +	if (pdev->resource[0].flags != IORESOURCE_IRQ)
> +		return -ENXIO;
> +
> +	/*
> +	 * Sanity check all the GICC tables for the same interrupt
> +	 * number. For now, only support homogeneous ACPI machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct acpi_madt_generic_interrupt *gicc;
> +		u16 this_gsi;
> +
> +		gicc = acpi_cpu_get_madt_gicc(cpu);
> +		if (gicc->header.length < len)
> +			return matched ? -ENXIO : 0;
> +
> +		this_gsi = parse_gsi(gicc);
> +		if (!this_gsi)
> +			return matched ? -ENXIO : 0;

I think you can push this check into the conditional below...

> +
> +		if (!matched) {
> +			hetid = find_acpi_cpu_topology_hetero_id(cpu);

... i.e. add a:

			if (!this_gsi)
				return -ENXIO;

here.

> +			gsi = this_gsi;
> +			matched = true;

And then, come to think of it, can we get rid of 'matched' altogether?
Since a gsi of 0 is treated as invalid, we could just check that instead,
no? So this becomes:


		gicc = acpi_cpu_get_madt_gicc(cpu);
		if (gicc->header.length < len)
			return gsi ? -ENXIO : 0;

		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
		this_gsi = parse_gsi(gicc);
		if (!gsi) {
			if (!this_gsi)
				return -ENXIO;
			gsi = this_gsi;
			hetid = this_hetid;
		} else if (hetid != this_hetid || gsi != this_gsi) {
			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
			return -ENXIO;
		}


What do you reckon?

Will
