Return-Path: <linux-kernel+bounces-101104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3F87A261
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FB82843ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74981111A9;
	Wed, 13 Mar 2024 04:42:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE342BA2D;
	Wed, 13 Mar 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710304962; cv=none; b=Eus4e7vOCuxn08IUjyIOF8mB68e4OQdH0h2STCUO5+N62xLwa42Xmfa6T0B/mtcTN2092SgxkQ47qJgH+mBqc8vRrdXcynAFaq0u3unk0AWCYSxtSrWDivvzA1Od26YijvzZoDwR1eDHCYTf+3i/dsFN0llthUc1F59LEDUofpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710304962; c=relaxed/simple;
	bh=XjSHvM1JIxVI4PqeAs+gAdddv59vnwaLFlZNJZe9lUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8gv5u2tYe/5NZaAKrDCebpktIxha8Z8mBtElvIxMu85p0S4hpZCM3zHuh/0ARyg7bVxOBtYA41C7COZQy2remS8klfvygD2jur1MQZJwNtMUSBKb506gpcwTdzvOENp2JX4mRb5Mt2FcuYaFGMY4TTSdMwBZuLOlP9nb22cMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03AB81007;
	Tue, 12 Mar 2024 21:43:17 -0700 (PDT)
Received: from [10.162.43.8] (a077893.blr.arm.com [10.162.43.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA5793F64C;
	Tue, 12 Mar 2024 21:42:36 -0700 (PDT)
Message-ID: <bf609360-d3ac-4a18-8165-41ad31e4d02b@arm.com>
Date: Wed, 13 Mar 2024 10:12:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 08/11] coresight: tpiu: Move ACPI support from AMBA
 driver to platform driver
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240312102318.2285165-1-anshuman.khandual@arm.com>
 <20240312102318.2285165-9-anshuman.khandual@arm.com>
 <6d812f7b-169c-45bd-99f6-56b993381bd4@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <6d812f7b-169c-45bd-99f6-56b993381bd4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/12/24 22:07, Suzuki K Poulose wrote:
> On 12/03/2024 10:23, Anshuman Khandual wrote:
>> Add support for the tpiu device in the platform driver, which can then be
>> used on ACPI based platforms. This change would now allow runtime power
>> management for ACPI based systems. The driver would try to enable the APB
>> clock if available. But first this renames and then refactors tpiu_probe()
>> and tpiu_remove(), making sure it can be used both for platform and AMBA
>> drivers. This also moves pm_runtime_put() from tpiu_probe() to the callers.
>>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: coresight@lists.linaro.org
>> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
>> Reviewed-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V6:
>>
>> - Added WARN_ON(!drvdata) check in tpiu_platform_remove()
>> - Added additional elements for acpi_device_id[]
>>
>>   drivers/acpi/arm64/amba.c                    |   1 -
>>   drivers/hwtracing/coresight/coresight-tpiu.c | 103 +++++++++++++++++--
>>   2 files changed, 93 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
>> index 587061b0fd2f..6d24a8f7914b 100644
>> --- a/drivers/acpi/arm64/amba.c
>> +++ b/drivers/acpi/arm64/amba.c
>> @@ -25,7 +25,6 @@ static const struct acpi_device_id amba_id_list[] = {
>>       {"ARMHC501", 0}, /* ARM CoreSight ETR */
>>       {"ARMHC502", 0}, /* ARM CoreSight STM */
>>       {"ARMHC503", 0}, /* ARM CoreSight Debug */
>> -    {"ARMHC979", 0}, /* ARM CoreSight TPIU */
>>       {"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
>>       {"", 0},
>>   };
>> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
>> index 29024f880fda..4117475f8889 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
>> @@ -5,6 +5,8 @@
>>    * Description: CoreSight Trace Port Interface Unit driver
>>    */
>>   +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
> 
> nit: Please could you keep them alphabetic order (including the existing ones below).

Sorting the existing ones along with the new header being added here, creates
the following code churn. Sure, will do the changes.

--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -5,17 +5,19 @@
  * Description: CoreSight Trace Port Interface Unit driver
  */

+#include <linux/acpi.h>
+#include <linux/amba/bus.h>
 #include <linux/atomic.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/coresight.h>
 #include <linux/device.h>
-#include <linux/io.h>
 #include <linux/err.h>
-#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/coresight.h>
-#include <linux/amba/bus.h>
-#include <linux/clk.h>
+#include <linux/slab.h>

> 
>>   #include <linux/atomic.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> @@ -52,11 +54,13 @@ DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
>>   /*
>>    * @base:    memory mapped base address for this component.
>>    * @atclk:    optional clock for the core parts of the TPIU.
>> + * @pclk:    APB clock if present, otherwise NULL
>>    * @csdev:    component vitals needed by the framework.
>>    */
>>   struct tpiu_drvdata {
>>       void __iomem        *base;
>>       struct clk        *atclk;
>> +    struct clk        *pclk;
>>       struct coresight_device    *csdev;
>>       spinlock_t        spinlock;
>>   };
>> @@ -122,14 +126,12 @@ static const struct coresight_ops tpiu_cs_ops = {
>>       .sink_ops    = &tpiu_sink_ops,
>>   };
>>   -static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>> +static int __tpiu_probe(struct device *dev, struct resource *res)
>>   {
>>       int ret;
>>       void __iomem *base;
>> -    struct device *dev = &adev->dev;
>>       struct coresight_platform_data *pdata = NULL;
>>       struct tpiu_drvdata *drvdata;
>> -    struct resource *res = &adev->res;
>>       struct coresight_desc desc = { 0 };
>>         desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
>> @@ -142,12 +144,16 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>>         spin_lock_init(&drvdata->spinlock);
>>   -    drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
>> +    drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
>>       if (!IS_ERR(drvdata->atclk)) {
>>           ret = clk_prepare_enable(drvdata->atclk);
>>           if (ret)
>>               return ret;
>>       }
>> +
>> +    drvdata->pclk = coresight_get_enable_apb_pclk(dev);
>> +    if (IS_ERR(drvdata->pclk))
>> +        return -ENODEV;
>>       dev_set_drvdata(dev, drvdata);
>>         /* Validity for the resource is already checked by the AMBA core */
>> @@ -173,21 +179,34 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>>       desc.dev = dev;
>>       drvdata->csdev = coresight_register(&desc);
>>   -    if (!IS_ERR(drvdata->csdev)) {
>> -        pm_runtime_put(&adev->dev);
>> +    if (!IS_ERR(drvdata->csdev))
>>           return 0;
>> -    }
>>         return PTR_ERR(drvdata->csdev);
>>   }
>>   -static void tpiu_remove(struct amba_device *adev)
>> +static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>>   {
>> -    struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> +    int ret;
>> +
>> +    ret = __tpiu_probe(&adev->dev, &adev->res);
>> +    if (!ret)
>> +        pm_runtime_put(&adev->dev);
>> +    return ret;
>> +}
>> +
>> +static void __tpiu_remove(struct device *dev)
>> +{
>> +    struct tpiu_drvdata *drvdata = dev_get_drvdata(dev);
>>         coresight_unregister(drvdata->csdev);
>>   }
>>   +static void tpiu_remove(struct amba_device *adev)
>> +{
>> +    __tpiu_remove(&adev->dev);
>> +}
>> +
>>   #ifdef CONFIG_PM
>>   static int tpiu_runtime_suspend(struct device *dev)
>>   {
>> @@ -196,6 +215,8 @@ static int tpiu_runtime_suspend(struct device *dev)
>>       if (drvdata && !IS_ERR(drvdata->atclk))
>>           clk_disable_unprepare(drvdata->atclk);
>>   +    if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
>> +        clk_disable_unprepare(drvdata->pclk);
>>       return 0;
>>   }
>>   @@ -206,6 +227,8 @@ static int tpiu_runtime_resume(struct device *dev)
>>       if (drvdata && !IS_ERR(drvdata->atclk))
>>           clk_prepare_enable(drvdata->atclk);
>>   +    if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
>> +        clk_prepare_enable(drvdata->pclk);
>>       return 0;
>>   }
>>   #endif
>> @@ -245,7 +268,67 @@ static struct amba_driver tpiu_driver = {
>>       .id_table    = tpiu_ids,
>>   };
>>   -module_amba_driver(tpiu_driver);
>> +static int tpiu_platform_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    int ret;
>> +
>> +    pm_runtime_get_noresume(&pdev->dev);
>> +    pm_runtime_set_active(&pdev->dev);
>> +    pm_runtime_enable(&pdev->dev);
>> +
>> +    ret = __tpiu_probe(&pdev->dev, res);
>> +    pm_runtime_put(&pdev->dev);
>> +    if (ret)
>> +        pm_runtime_disable(&pdev->dev);
>> +
>> +    return ret;
>> +}
>> +
>> +static int tpiu_platform_remove(struct platform_device *pdev)
>> +{
>> +    struct tpiu_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
>> +
>> +    if (WARN_ON(!drvdata))
>> +        return -ENODEV;
>> +
>> +    __tpiu_remove(&pdev->dev);
>> +    pm_runtime_disable(&pdev->dev);
>> +    if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
> 
> Same as the previous patches.

Sure, will drop the above drvdata check.

> 
> Suzuki
> 
> 
>> +        clk_put(drvdata->pclk);
>> +    return 0;
>> +}
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id tpiu_acpi_ids[] = {
>> +    {"ARMHC979", 0, 0, 0}, /* ARM CoreSight TPIU */
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
>> +#endif
>> +
>> +static struct platform_driver tpiu_platform_driver = {
>> +    .probe    = tpiu_platform_probe,
>> +    .remove    = tpiu_platform_remove,
>> +    .driver = {
>> +        .name            = "coresight-tpiu-platform",
>> +        .acpi_match_table    = ACPI_PTR(tpiu_acpi_ids),
>> +        .suppress_bind_attrs    = true,
>> +        .pm            = &tpiu_dev_pm_ops,
>> +    },
>> +};
>> +
>> +static int __init tpiu_init(void)
>> +{
>> +    return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver);
>> +}
>> +
>> +static void __exit tpiu_exit(void)
>> +{
>> +    coresight_remove_driver(&tpiu_driver, &tpiu_platform_driver);
>> +}
>> +module_init(tpiu_init);
>> +module_exit(tpiu_exit);
>>     MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
>>   MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> 

