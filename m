Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25667A975C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIURXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjIURWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096CC4ED6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F2921570;
        Thu, 21 Sep 2023 04:11:30 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392EC3F5A1;
        Thu, 21 Sep 2023 04:10:52 -0700 (PDT)
Message-ID: <6a72387f-2749-0e27-000f-aeec265cb789@arm.com>
Date:   Thu, 21 Sep 2023 12:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC RESEND 1/7] coresight: replicator: Move ACPI support from
 AMBA driver to platform driver
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230921042040.1334641-1-anshuman.khandual@arm.com>
 <20230921042040.1334641-2-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230921042040.1334641-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 05:20, Anshuman Khandual wrote:
> Add support for the dynamic replicator device in the platform driver, which
> can then be used on ACPI based platforms. This change would now allow
> runtime power management for repliacator devices on ACPI based systems.
> 
> The driver would try to enable the APB clock if available. Also, rename the
> code to reflect the fact that it now handles both static and dynamic
> replicators.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   drivers/acpi/arm64/amba.c                     |  1 -
>   .../coresight/coresight-replicator.c          | 44 ++++++++++++-------
>   2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 60be8ee1dbdc..ac59ce50de07 100644
> --- a/drivers/acpi/arm64/amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -27,7 +27,6 @@ static const struct acpi_device_id amba_id_list[] = {
>   	{"ARMHC503", 0}, /* ARM CoreSight Debug */
>   	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
>   	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
> -	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
>   	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
>   	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
>   	{"", 0},
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b6be73034996..a18d5e8fcba1 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -38,6 +38,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>   struct replicator_drvdata {
>   	void __iomem		*base;
>   	struct clk		*atclk;
> +	struct clk		*pclk;
>   	struct coresight_device	*csdev;
>   	spinlock_t		spinlock;
>   	bool			check_idfilter_val;
> @@ -243,6 +244,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
>   			return ret;
>   	}
>   
> +	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
> +	if (IS_ERR(drvdata->pclk))
> +		return -ENODEV;
> +
>   	/*
>   	 * Map the device base for dynamic-replicator, which has been
>   	 * validated by AMBA core
> @@ -301,16 +306,16 @@ static int replicator_remove(struct device *dev)
>   	return 0;
>   }
>   
> -static int static_replicator_probe(struct platform_device *pdev)
> +static int replicator_platform_probe(struct platform_device *pdev)
>   {
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	int ret;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   
> -	/* Static replicators do not have programming base */
> -	ret = replicator_probe(&pdev->dev, NULL);
> +	ret = replicator_probe(&pdev->dev, res);
>   
>   	if (ret) {
>   		pm_runtime_put_noidle(&pdev->dev);
> @@ -320,7 +325,7 @@ static int static_replicator_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int static_replicator_remove(struct platform_device *pdev)
> +static int replicator_platform_remove(struct platform_device *pdev)
>   {
>   	replicator_remove(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
> @@ -335,6 +340,8 @@ static int replicator_runtime_suspend(struct device *dev)
>   	if (drvdata && !IS_ERR(drvdata->atclk))
>   		clk_disable_unprepare(drvdata->atclk);
>   
> +	if (drvdata && !IS_ERR(drvdata->pclk))

!IS_ERR_OR_NULL() ? If we don't have pclk, drvdata->pclk is always NULL

Same applies throughout the series.

Suzuki


