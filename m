Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD0B7C86D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjJMN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjJMN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:29:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B6D3AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:29:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371CA11FB;
        Fri, 13 Oct 2023 06:29:44 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE93F3F762;
        Fri, 13 Oct 2023 06:29:02 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:28:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: xgene: Use device_get_match_data()
Message-ID: <ZSlGASa6sn57b6Me@FVFF77S0Q05N.cambridge.arm.com>
References: <20231009172923.2457844-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009172923.2457844-14-robh@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:29:09PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() and
> acpi_match_device() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume that Will can pick this up.

Mark.

> ---
>  drivers/perf/xgene_pmu.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index 9972bfc11a5c..7ce344248dda 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -16,11 +16,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> -#include <linux/of_fdt.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_platform.h>
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> @@ -1731,6 +1729,12 @@ static const struct xgene_pmu_data xgene_pmu_v2_data = {
>  	.id   = PCP_PMU_V2,
>  };
>  
> +#ifdef CONFIG_ACPI
> +static const struct xgene_pmu_data xgene_pmu_v3_data = {
> +	.id   = PCP_PMU_V3,
> +};
> +#endif
> +
>  static const struct xgene_pmu_ops xgene_pmu_ops = {
>  	.mask_int = xgene_pmu_mask_int,
>  	.unmask_int = xgene_pmu_unmask_int,
> @@ -1773,9 +1777,9 @@ static const struct of_device_id xgene_pmu_of_match[] = {
>  MODULE_DEVICE_TABLE(of, xgene_pmu_of_match);
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id xgene_pmu_acpi_match[] = {
> -	{"APMC0D5B", PCP_PMU_V1},
> -	{"APMC0D5C", PCP_PMU_V2},
> -	{"APMC0D83", PCP_PMU_V3},
> +	{"APMC0D5B", (kernel_ulong_t)&xgene_pmu_data},
> +	{"APMC0D5C", (kernel_ulong_t)&xgene_pmu_v2_data},
> +	{"APMC0D83", (kernel_ulong_t)&xgene_pmu_v3_data},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
> @@ -1831,7 +1835,6 @@ static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  static int xgene_pmu_probe(struct platform_device *pdev)
>  {
>  	const struct xgene_pmu_data *dev_data;
> -	const struct of_device_id *of_id;
>  	struct xgene_pmu *xgene_pmu;
>  	int irq, rc;
>  	int version;
> @@ -1850,24 +1853,10 @@ static int xgene_pmu_probe(struct platform_device *pdev)
>  	xgene_pmu->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, xgene_pmu);
>  
> -	version = -EINVAL;
> -	of_id = of_match_device(xgene_pmu_of_match, &pdev->dev);
> -	if (of_id) {
> -		dev_data = (const struct xgene_pmu_data *) of_id->data;
> -		version = dev_data->id;
> -	}
> -
> -#ifdef CONFIG_ACPI
> -	if (ACPI_COMPANION(&pdev->dev)) {
> -		const struct acpi_device_id *acpi_id;
> -
> -		acpi_id = acpi_match_device(xgene_pmu_acpi_match, &pdev->dev);
> -		if (acpi_id)
> -			version = (int) acpi_id->driver_data;
> -	}
> -#endif
> -	if (version < 0)
> +	dev_data = device_get_match_data(&pdev->dev);
> +	if (!dev_data)
>  		return -ENODEV;
> +	version = dev_data->id;
>  
>  	if (version == PCP_PMU_V3)
>  		xgene_pmu->ops = &xgene_pmu_v3_ops;
> -- 
> 2.42.0
> 
