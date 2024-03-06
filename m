Return-Path: <linux-kernel+bounces-94327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FE873D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124751C211E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822F13BAD7;
	Wed,  6 Mar 2024 17:22:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87313958C;
	Wed,  6 Mar 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745726; cv=none; b=lwRE9c9AhEvlzAN1k2J9erxn5n1e18tAY/iphRmok6Q2Lr2mmES/NtacQZdeneZeVeLR+cIWp5kjfpSrbr7VDjCSnlfSOnMNG5ZrWmPElWlP57RZiqvC6o6w7Ud9OrI1Q1q0FrUt4euuyes3Tk3B8Uu1noiphmYDWWMrMfhL0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745726; c=relaxed/simple;
	bh=DY6cFZTmgUJJaTEAtByqdoN93dmEbV+D1IkvVR6D0/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkK1/yi9DCLLu4S9ATmXcfwpu4+5qC8qz6Glekk14+jNyaS0SJfdQDb0J39dmTpIc/r+/roIndQ5i0GAaVxiA3OfH8LixFDHD2yJeXmBDCGqM6CpKRikoaf80CRECko8e9QwpoiZ8Sp63PPo2buv44kgiNecr3hWvBS3GL1JB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92A8E1FB;
	Wed,  6 Mar 2024 09:22:38 -0800 (PST)
Received: from [10.57.51.153] (unknown [10.57.51.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3443F738;
	Wed,  6 Mar 2024 09:21:59 -0800 (PST)
Message-ID: <2bd6ed98-fd58-42ef-8b86-fddac28df5c7@arm.com>
Date: Wed, 6 Mar 2024 17:21:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 07/11] coresight: catu: Move ACPI support from AMBA
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
References: <20240222082142.3663983-1-anshuman.khandual@arm.com>
 <20240222082142.3663983-8-anshuman.khandual@arm.com>
 <c43fcd3a-9813-4e1f-adb3-25cc32c54438@arm.com>
 <c52865b2-8608-4a47-967a-6cf3e11b197a@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <c52865b2-8608-4a47-967a-6cf3e11b197a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2024 06:14, Anshuman Khandual wrote:
> 
> 
> On 3/5/24 23:02, Suzuki K Poulose wrote:
>> On 22/02/2024 08:21, Anshuman Khandual wrote:
>>> Add support for the catu devices in a new platform driver, which can then
>>> be used on ACPI based platforms. This change would now allow runtime power
>>> management for ACPI based systems. The driver would try to enable the APB
>>> clock if available. But first this renames and then refactors catu_probe()
>>> and catu_remove(), making sure it can be used both for platform and AMBA
>>> drivers. This also moves pm_runtime_put() from catu_probe() to the callers.
>>>
>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: linux-acpi@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: coresight@lists.linaro.org
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
>>> Reviewed-by: James Clark <james.clark@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Changes in V5:
>>>
>>> - Updated commit message regarding catu_probe/remove() refactoring and renaming
>>>
>>>    drivers/acpi/arm64/amba.c                    |   1 -
>>>    drivers/hwtracing/coresight/coresight-catu.c | 142 ++++++++++++++++---
>>>    drivers/hwtracing/coresight/coresight-catu.h |   1 +
>>>    3 files changed, 124 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
>>> index afb6afb66967..587061b0fd2f 100644
>>> --- a/drivers/acpi/arm64/amba.c
>>> +++ b/drivers/acpi/arm64/amba.c
>>> @@ -27,7 +27,6 @@ static const struct acpi_device_id amba_id_list[] = {
>>>        {"ARMHC503", 0}, /* ARM CoreSight Debug */
>>>        {"ARMHC979", 0}, /* ARM CoreSight TPIU */
>>>        {"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
>>> -    {"ARMHC9CA", 0}, /* ARM CoreSight CATU */
>>>        {"", 0},
>>>    };
>>>    diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>>> index 3949ded0d4fa..a3ea46b53898 100644
>>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>>> @@ -7,6 +7,8 @@
>>>     * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>     */
>>>    +#include <linux/platform_device.h>
>>> +#include <linux/acpi.h>
>>>    #include <linux/amba/bus.h>
>>>    #include <linux/device.h>
>>>    #include <linux/dma-mapping.h>
>>> @@ -502,28 +504,20 @@ static const struct coresight_ops catu_ops = {
>>>        .helper_ops = &catu_helper_ops,
>>>    };
>>>    -static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>>> +static int __catu_probe(struct device *dev, struct resource *res)
>>>    {
>>>        int ret = 0;
>>>        u32 dma_mask;
>>> -    struct catu_drvdata *drvdata;
>>> +    struct catu_drvdata *drvdata = dev_get_drvdata(dev);
>>>        struct coresight_desc catu_desc;
>>>        struct coresight_platform_data *pdata = NULL;
>>> -    struct device *dev = &adev->dev;
>>>        void __iomem *base;
>>>          catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
>>>        if (!catu_desc.name)
>>>            return -ENOMEM;
>>>    -    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>>> -    if (!drvdata) {
>>> -        ret = -ENOMEM;
>>> -        goto out;
>>> -    }
>>> -
>>> -    dev_set_drvdata(dev, drvdata);
>>> -    base = devm_ioremap_resource(dev, &adev->res);
>>> +    base = devm_ioremap_resource(dev, res);
>>>        if (IS_ERR(base)) {
>>>            ret = PTR_ERR(base);
>>>            goto out;
>>> @@ -567,19 +561,39 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>>>        drvdata->csdev = coresight_register(&catu_desc);
>>>        if (IS_ERR(drvdata->csdev))
>>>            ret = PTR_ERR(drvdata->csdev);
>>> -    else
>>> -        pm_runtime_put(&adev->dev);
>>>    out:
>>>        return ret;
>>>    }
>>>    -static void catu_remove(struct amba_device *adev)
>>> +static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>>>    {
>>> -    struct catu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>>> +    struct catu_drvdata *drvdata;
>>> +    int ret;
>>> +
>>> +    drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
>>> +    if (!drvdata)
>>> +        return -ENOMEM;
>>> +
>>> +    amba_set_drvdata(adev, drvdata);
>>> +    ret = __catu_probe(&adev->dev, &adev->res);
>>> +    if (!ret)
>>> +        pm_runtime_put(&adev->dev);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void __catu_remove(struct device *dev)
>>> +{
>>> +    struct catu_drvdata *drvdata = dev_get_drvdata(dev);
>>>          coresight_unregister(drvdata->csdev);
>>>    }
>>>    +static void catu_remove(struct amba_device *adev)
>>> +{
>>> +    __catu_remove(&adev->dev);
>>> +}
>>> +
>>>    static struct amba_id catu_ids[] = {
>>>        CS_AMBA_ID(0x000bb9ee),
>>>        {},
>>> @@ -598,13 +612,103 @@ static struct amba_driver catu_driver = {
>>>        .id_table            = catu_ids,
>>>    };
>>>    +static int catu_platform_probe(struct platform_device *pdev)
>>> +{
>>> +    struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    struct catu_drvdata *drvdata;
>>> +    int ret = 0;
>>> +
>>> +    drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
>>> +    if (!drvdata)
>>> +        return -ENOMEM;
>>> +
>>> +    drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
>>> +    if (IS_ERR(drvdata->pclk))
>>> +        return -ENODEV;
>>
>>
>> ---8>---
>>
>>> +
>>> +    if (res) {
>>> +        drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>>> +        if (IS_ERR(drvdata->base)) {
>>> +            clk_put(drvdata->pclk);
>>> +            return PTR_ERR(drvdata->base);
>>> +        }
>>> +    }
>>
>> ---<8---
>>
>> The above section seems unncessary as we already try to map the base in __catu_probe ?
> 
> Agreed, though it seems unnecessary, there is a small difference in there. In the platform
> driver case i.e catu_platform_probe(), clk_put() is called on platform clock drvdata->pclk
> (just enabled earlier) for cases when devm_ioremap_resource() fails.
> 
> To remove this redundancy, let's move devm_ioremap_resource() into it's AMBA caller i.e
> catu_probe() thus dropping struct resource argument from __catu_probe(). Similar situation
> is present in coresight-cpu-debug driver as well, will fix that.
> 
> But there are some other drivers in the series where coresight_get_enable_apb_pclk() called
> on 'drvdata->pclk' and devm_ioremap_resource() is attempted inside the factored __xxx_probe()
> function which is common for both AMBA and platform drivers.
> 
> Such drivers are ...
> 
> - tpiu
> - tmc
> - stm
> - replicator
> 
> IMHO it would be better to follow same scheme for all drivers in the series. Please do let
> me know which method will be preferred.

Lets pass the "res" to the common probe and deal it there.

> 
>>
>>> +
> 
>>> +    pm_runtime_get_noresume(&pdev->dev);
>>> +    pm_runtime_set_active(&pdev->dev);
>>> +    pm_runtime_enable(&pdev->dev);
>>> +
>>> +    dev_set_drvdata(&pdev->dev, drvdata);
>>> +    ret = __catu_probe(&pdev->dev, res);
>>> +    pm_runtime_put(&pdev->dev);
>>> +    if (ret)
>>> +        pm_runtime_disable(&pdev->dev);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int catu_platform_remove(struct platform_device *pdev)
>>> +{
>>> +    struct catu_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
>>> +
>>> +    if (drvdata)
>>> +        __catu_remove(&pdev->dev);
>>
>> I don't understand the need for if () check here (and on all the other drivers). Even if we have a drvdata != NULL, what guarantees that
>> the drvdata->csdev is valid (which is used in xx_remove) ?
> 
> Agreed, although drvdata is derived in __xxx_remove() functions, a pre-check here is not
> required - similar to the AMBA remove path. Sure, will drop them across drivers.

No, my point is : Is there a case where :

1) drvdata == NULL, but we have a device to do some cleanup ?
2) If drvdata != NULL, but drvdata->csdev is not valid, because we 
failed to register the coresight device ?


Suzuki


> 
>>
>> Suzuki
>>
>>> +
>>> +    pm_runtime_disable(&pdev->dev);
>>> +    if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
>>> +        clk_put(drvdata->pclk);
>>> +    return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +static int catu_runtime_suspend(struct device *dev)
>>> +{
>>> +    struct catu_drvdata *drvdata = dev_get_drvdata(dev);
>>> +
>>> +    if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
>>> +        clk_disable_unprepare(drvdata->pclk);
>>> +    return 0;
>>> +}
>>> +
>>> +static int catu_runtime_resume(struct device *dev)
>>> +{
>>> +    struct catu_drvdata *drvdata = dev_get_drvdata(dev);
>>> +
>>> +    if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
>>> +        clk_prepare_enable(drvdata->pclk);
>>> +    return 0;
>>> +}
>>> +#endif
>>> +
>>> +static const struct dev_pm_ops catu_dev_pm_ops = {
>>> +    SET_RUNTIME_PM_OPS(catu_runtime_suspend, catu_runtime_resume, NULL)
>>> +};
>>> +
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id catu_acpi_ids[] = {
>>> +    {"ARMHC9CA", 0}, /* ARM CoreSight CATU */
>>> +    {},
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(acpi, catu_acpi_ids);
>>> +#endif
>>> +
>>> +static struct platform_driver catu_platform_driver = {
>>> +    .probe    = catu_platform_probe,
>>> +    .remove    = catu_platform_remove,
>>> +    .driver    = {
>>> +        .name            = "coresight-catu-platform",
>>> +        .acpi_match_table    = ACPI_PTR(catu_acpi_ids),
>>> +        .suppress_bind_attrs    = true,
>>> +        .pm            = &catu_dev_pm_ops,
>>> +    },
>>> +};
>>> +
>>>    static int __init catu_init(void)
>>>    {
>>>        int ret;
>>>    -    ret = amba_driver_register(&catu_driver);
>>> -    if (ret)
>>> -        pr_info("Error registering catu driver\n");
>>> +    ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver);
>>>        tmc_etr_set_catu_ops(&etr_catu_buf_ops);
>>>        return ret;
>>>    }
>>> @@ -612,7 +716,7 @@ static int __init catu_init(void)
>>>    static void __exit catu_exit(void)
>>>    {
>>>        tmc_etr_remove_catu_ops();
>>> -    amba_driver_unregister(&catu_driver);
>>> +    coresight_remove_driver(&catu_driver, &catu_platform_driver);
>>>    }
>>>      module_init(catu_init);
>>> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
>>> index 442e034bbfba..141feac1c14b 100644
>>> --- a/drivers/hwtracing/coresight/coresight-catu.h
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.h
>>> @@ -61,6 +61,7 @@
>>>    #define CATU_IRQEN_OFF        0x0
>>>      struct catu_drvdata {
>>> +    struct clk *pclk;
>>>        void __iomem *base;
>>>        struct coresight_device *csdev;
>>>        int irq;
>>


