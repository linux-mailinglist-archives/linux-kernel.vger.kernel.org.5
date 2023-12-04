Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ACA8030BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjLDKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjLDKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:42:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FA3CF0;
        Mon,  4 Dec 2023 02:42:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44B581684;
        Mon,  4 Dec 2023 02:42:59 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B7A03F6C4;
        Mon,  4 Dec 2023 02:42:10 -0800 (PST)
Message-ID: <12a9c5da-4b96-78de-4007-211989bdcfa3@arm.com>
Date:   Mon, 4 Dec 2023 10:42:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 5/7] coresight: tmc: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-6-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231201062053.1268492-6-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2023 06:20, Anshuman Khandual wrote:
> Add support for the tmc devices in the platform driver, which can then be
> used on ACPI based platforms. This change would now allow runtime power
> management for ACPI based systems. The driver would try to enable the APB
> clock if available.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/acpi/arm64/amba.c                     |   2 -
>  .../hwtracing/coresight/coresight-tmc-core.c  | 130 +++++++++++++++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |   1 +
>  3 files changed, 115 insertions(+), 18 deletions(-)
> 
[...]
> -static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
> +static int __tmc_probe(struct device *dev, struct resource *res, void *dev_caps)
>  {
>  	int ret = 0;
>  	u32 devid;
>  	void __iomem *base;
> -	struct device *dev = &adev->dev;
>  	struct coresight_platform_data *pdata = NULL;
> -	struct tmc_drvdata *drvdata;
> -	struct resource *res = &adev->res;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
>  	struct coresight_desc desc = { 0 };
>  	struct coresight_dev_list *dev_list = NULL;
>  
>  	ret = -ENOMEM;
> -	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> -	if (!drvdata)
> -		goto out;
> -
> -	dev_set_drvdata(dev, drvdata);
>  
>  	/* Validity for the resource is already checked by the AMBA core */
>  	base = devm_ioremap_resource(dev, res);
> @@ -487,8 +482,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		desc.type = CORESIGHT_DEV_TYPE_SINK;
>  		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
>  		desc.ops = &tmc_etr_cs_ops;
> -		ret = tmc_etr_setup_caps(dev, devid,
> -					 coresight_get_uci_data(id));
> +		ret = tmc_etr_setup_caps(dev, devid, dev_caps);
>  		if (ret)
>  			goto out;
[...]
> -module_amba_driver(tmc_driver);
> +static int tmc_platform_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct tmc_drvdata *drvdata;
> +	int ret = 0;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
> +	if (IS_ERR(drvdata->pclk))
> +		return -ENODEV;
> +
> +	dev_set_drvdata(&pdev->dev, drvdata);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = __tmc_probe(&pdev->dev, res, NULL);

What effect does passing NULL here have? It seems like the dev_caps did
something useful when it's set to CORESIGHT_SOC_600_ETR_CAPS. Maybe
Suzuki knows as he added it?
