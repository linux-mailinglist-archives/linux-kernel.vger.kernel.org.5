Return-Path: <linux-kernel+bounces-100378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D4879687
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CE1C221F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A27AE73;
	Tue, 12 Mar 2024 14:39:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605978286;
	Tue, 12 Mar 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254356; cv=none; b=s1ozK8e4K8K+EV/s543Lqcv6H2U/6nRrf54J0i5wSXdrPoB5i8+DM1VkHf72YYtOR+FB08AU6JQQebT6d3fytemJSCA7V52F4e9WxBTz1tPggWmoLsV+W9qPZNqc9fiMeclwbhOBYfvhP+nNGpAnQEadnVBzAEr+/pZa2S2uvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254356; c=relaxed/simple;
	bh=A4yPPNx2A/vP3ZK0ygDuOKWhQXboHEU9aZot/+5ZzZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVNxgun9oVCRc2jeHVQDln1MOhNaNRKuCeE25bqG9EDxetTVkKGPyT2z45YiJvbE8r+7HGC0H/BhPu2C6Li8AITyeMLnAgMhsz9+VVY4SLGbjmh3VV6EtHKG/L3MUUwUIbsso9ExSwcxse8zhz1LVyqtLj7SOr3Rh1XHaquQfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2F98FEC;
	Tue, 12 Mar 2024 07:39:49 -0700 (PDT)
Received: from [10.57.50.231] (unknown [10.57.50.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15E053F73F;
	Tue, 12 Mar 2024 07:39:09 -0700 (PDT)
Message-ID: <9f95ba15-b75c-414c-b87a-e88fddc77ebf@arm.com>
Date: Tue, 12 Mar 2024 14:39:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 05/11] coresight: replicator: Move ACPI support from
 AMBA driver to platform driver
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240312102318.2285165-1-anshuman.khandual@arm.com>
 <20240312102318.2285165-6-anshuman.khandual@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240312102318.2285165-6-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2024 10:23, Anshuman Khandual wrote:
> Add support for the dynamic replicator device in the platform driver, which
> can then be used on ACPI based platforms. This change would now allow
> runtime power management for replicator devices on ACPI based systems.
> 
> The driver would try to enable the APB clock if available. Also, rename the
> code to reflect the fact that it now handles both static and dynamic
> replicators. But first this refactors replicator_probe() making sure it can
> be used both for platform and AMBA drivers, by moving the pm_runtime_put()
> to the callers.
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
> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V6:
> 
> - Added clk_disable_unprepare() for pclk in replicator_probe() error path
> - Added WARN_ON(!drvdata) check in replicator_platform_remove()
> - Added additional elements for acpi_device_id[]
> 
>   drivers/acpi/arm64/amba.c                     |  1 -
>   .../coresight/coresight-replicator.c          | 68 ++++++++++++-------
>   2 files changed, 45 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 171b5c2c7edd..270f4e3819a2 100644
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
> index ddb530a8436f..ed9be5435f94 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -31,6 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>    * @base:	memory mapped base address for this component. Also indicates
>    *		whether this one is programmable or not.
>    * @atclk:	optional clock for the core parts of the replicator.
> + * @pclk:	APB clock if present, otherwise NULL
>    * @csdev:	component vitals needed by the framework
>    * @spinlock:	serialize enable/disable operations.
>    * @check_idfilter_val: check if the context is lost upon clock removal.
> @@ -38,6 +39,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>   struct replicator_drvdata {
>   	void __iomem		*base;
>   	struct clk		*atclk;
> +	struct clk		*pclk;
>   	struct coresight_device	*csdev;
>   	spinlock_t		spinlock;
>   	bool			check_idfilter_val;
> @@ -243,6 +245,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
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
> @@ -285,11 +291,12 @@ static int replicator_probe(struct device *dev, struct resource *res)
>   	}
>   
>   	replicator_reset(drvdata);
> -	pm_runtime_put(dev);
>   
>   out_disable_clk:
>   	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
>   		clk_disable_unprepare(drvdata->atclk);
> +	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_disable_unprepare(drvdata->pclk);
>   	return ret;
>   }
>   
> @@ -301,29 +308,34 @@ static int replicator_remove(struct device *dev)
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
> -
> -	if (ret) {
> -		pm_runtime_put_noidle(&pdev->dev);
> +	ret = replicator_probe(&pdev->dev, res);
> +	pm_runtime_put(&pdev->dev);
> +	if (ret)
>   		pm_runtime_disable(&pdev->dev);
> -	}
>   
>   	return ret;
>   }
>   
> -static void static_replicator_remove(struct platform_device *pdev)
> +static void replicator_platform_remove(struct platform_device *pdev)
>   {
> +	struct replicator_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> +
> +	if (WARN_ON(!drvdata))
> +		return;
> +
>   	replicator_remove(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
> +	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_put(drvdata->pclk);
>   }
>   
>   #ifdef CONFIG_PM
> @@ -334,6 +346,8 @@ static int replicator_runtime_suspend(struct device *dev)
>   	if (drvdata && !IS_ERR(drvdata->atclk))
>   		clk_disable_unprepare(drvdata->atclk);
>   
> +	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_disable_unprepare(drvdata->pclk);
>   	return 0;
>   }
>   
> @@ -344,6 +358,8 @@ static int replicator_runtime_resume(struct device *dev)
>   	if (drvdata && !IS_ERR(drvdata->atclk))
>   		clk_prepare_enable(drvdata->atclk);
>   
> +	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_prepare_enable(drvdata->pclk);

nit: drvdata is != NULL, so could drop it.

Rest looks fine

Suzuki


