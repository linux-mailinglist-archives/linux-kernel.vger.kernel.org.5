Return-Path: <linux-kernel+bounces-100382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34287969A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D1B23BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BF7B3C0;
	Tue, 12 Mar 2024 14:42:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE57AE61;
	Tue, 12 Mar 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254521; cv=none; b=kZ78AiMmEZwIR2q+Qk0WrQaPHdiHatkU3bPIPYAc/vIHZox0JZ5ALXm9+PKu5D8EVTEqrXQnsocVcs2ee2brw1m0gFkmZq3OzdfDIqPmYaVo4TmeJi5bI6j1AApQBFaRiBQLyZG6HK0HU927rcgmpZu1OuKPcvovKJbR5yS02OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254521; c=relaxed/simple;
	bh=M1v1uL0PeBMOtfEeCj5symojL97Up1S915qiyNi3wKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJGF9E9IYQyv65hV2l6j/iJvbRjr/PnGWdjztmb2oVSKBz2KnjebCGns3fqx3oVQGIfPLhTBDChx+AHO0jg2Xd6d6OdL2V//5gzDgroyKStmDPFcxFwrUhsmA2w7U6zzrgdImFgyrwYczghfPF6MWNvbU1VNPgv01spYWaWQ/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2E4FEC;
	Tue, 12 Mar 2024 07:42:35 -0700 (PDT)
Received: from [10.57.50.231] (unknown [10.57.50.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53FC3F73F;
	Tue, 12 Mar 2024 07:41:55 -0700 (PDT)
Message-ID: <2dbef82c-96a0-419f-9950-8ee4169fb634@arm.com>
Date: Tue, 12 Mar 2024 14:41:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 06/11] coresight: funnel: Move ACPI support from AMBA
 driver to platform driver
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
 <20240312102318.2285165-7-anshuman.khandual@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240312102318.2285165-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2024 10:23, Anshuman Khandual wrote:
> Add support for the dynamic funnel device in the platform driver, which can
> then be used on ACPI based platforms. This change would allow runtime power
> management for ACPI based systems.
> 
> The driver would try to enable the APB clock if available. Also, rename the
> code to reflect the fact that it now handles both static and dynamic
> funnels. But first this refactors funnel_probe() making sure it can be used
> both for platform and AMBA drivers, by moving the pm_runtime_put() to the
> callers.
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
> - Added clk_disable_unprepare() for pclk in funnel_probe() error path
> - Added WARN_ON(!drvdata) check in funnel_platform_remove()
> - Added additional elements for acpi_device_id[]
> 
>   drivers/acpi/arm64/amba.c                     |  1 -
>   .../hwtracing/coresight/coresight-funnel.c    | 72 ++++++++++++-------
>   2 files changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 270f4e3819a2..afb6afb66967 100644
> --- a/drivers/acpi/arm64/amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -28,7 +28,6 @@ static const struct acpi_device_id amba_id_list[] = {
>   	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
>   	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
>   	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
> -	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
>   	{"", 0},
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index ff3ea0670a5b..3b4be10a0f0c 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -36,6 +36,7 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
>    * struct funnel_drvdata - specifics associated to a funnel component
>    * @base:	memory mapped base address for this component.
>    * @atclk:	optional clock for the core parts of the funnel.
> + * @pclk:	APB clock if present, otherwise NULL
>    * @csdev:	component vitals needed by the framework.
>    * @priority:	port selection order.
>    * @spinlock:	serialize enable/disable operations.
> @@ -43,6 +44,7 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
>   struct funnel_drvdata {
>   	void __iomem		*base;
>   	struct clk		*atclk;
> +	struct clk		*pclk;
>   	struct coresight_device	*csdev;
>   	unsigned long		priority;
>   	spinlock_t		spinlock;
> @@ -236,6 +238,10 @@ static int funnel_probe(struct device *dev, struct resource *res)
>   			return ret;
>   	}
>   
> +	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
> +	if (IS_ERR(drvdata->pclk))
> +		return -ENODEV;
> +
>   	/*
>   	 * Map the device base for dynamic-funnel, which has been
>   	 * validated by AMBA core.
> @@ -272,12 +278,13 @@ static int funnel_probe(struct device *dev, struct resource *res)
>   		goto out_disable_clk;
>   	}
>   
> -	pm_runtime_put(dev);
>   	ret = 0;
>   
>   out_disable_clk:
>   	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
>   		clk_disable_unprepare(drvdata->atclk);
> +	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_disable_unprepare(drvdata->pclk);
>   	return ret;
>   }
>   
> @@ -298,6 +305,9 @@ static int funnel_runtime_suspend(struct device *dev)
>   	if (drvdata && !IS_ERR(drvdata->atclk))
>   		clk_disable_unprepare(drvdata->atclk);
>   
> +	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_disable_unprepare(drvdata->pclk);
> +
>   	return 0;
>   }
>   
> @@ -308,6 +318,8 @@ static int funnel_runtime_resume(struct device *dev)
>   	if (drvdata && !IS_ERR(drvdata->atclk))
>   		clk_prepare_enable(drvdata->atclk);
>   
> +	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
> +		clk_prepare_enable(drvdata->pclk);
>   	return 0;
>   }
>   #endif
> @@ -316,55 +328,61 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
>   	SET_RUNTIME_PM_OPS(funnel_runtime_suspend, funnel_runtime_resume, NULL)
>   };
>   
> -static int static_funnel_probe(struct platform_device *pdev)
> +static int funnel_platform_probe(struct platform_device *pdev)
>   {
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	int ret;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   
> -	/* Static funnel do not have programming base */
> -	ret = funnel_probe(&pdev->dev, NULL);
> -
> -	if (ret) {
> -		pm_runtime_put_noidle(&pdev->dev);
> +	ret = funnel_probe(&pdev->dev, res);
> +	pm_runtime_put(&pdev->dev);
> +	if (ret)
>   		pm_runtime_disable(&pdev->dev);
> -	}
>   
>   	return ret;
>   }
>   
> -static void static_funnel_remove(struct platform_device *pdev)
> +static void funnel_platform_remove(struct platform_device *pdev)
>   {
> +	struct funnel_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> +
> +	if (WARN_ON(!drvdata))
> +		return;
> +
>   	funnel_remove(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
> +	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))

Same as the previous patch

Suzuki


