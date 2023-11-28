Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77B87FB25E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbjK1HJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343699AbjK1HJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:09:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2696F197;
        Mon, 27 Nov 2023 23:09:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9F5C15;
        Mon, 27 Nov 2023 23:10:35 -0800 (PST)
Received: from [10.163.33.60] (unknown [10.163.33.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5221B3F5A1;
        Mon, 27 Nov 2023 23:09:44 -0800 (PST)
Message-ID: <8305dee1-6668-4011-aaf7-68d072a1251c@arm.com>
Date:   Tue, 28 Nov 2023 12:39:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] coresight: tmc: Move ACPI support from AMBA driver to
 platform driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-6-anshuman.khandual@arm.com> <ZV40itsgT5OSJmdC@bogus>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZV40itsgT5OSJmdC@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 22:34, Sudeep Holla wrote:
> On Fri, Oct 27, 2023 at 12:59:41PM +0530, Anshuman Khandual wrote:
>> Add support for the tmc devices in the platform driver, which can then be
>> used on ACPI based platforms. This change would now allow runtime power
>> management for ACPI based systems. The driver would try to enable the APB
>> clock if available.
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
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/acpi/arm64/amba.c                     |   2 -
>>  .../hwtracing/coresight/coresight-tmc-core.c  | 127 +++++++++++++++---
>>  drivers/hwtracing/coresight/coresight-tmc.h   |   1 +
>>  3 files changed, 113 insertions(+), 17 deletions(-)
> 
> [...]
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 7ec5365e2b64..618bc0b7a1a5 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> 
> [...]
> 
>> @@ -573,9 +579,9 @@ static void tmc_shutdown(struct amba_device *adev)
>>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>  }
>>  
>> -static void tmc_remove(struct amba_device *adev)
>> +static void __tmc_remove(struct device *dev)
>>  {
>> -	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
>>  
>>  	/*
>>  	 * Since misc_open() holds a refcount on the f_ops, which is
>> @@ -586,6 +592,11 @@ static void tmc_remove(struct amba_device *adev)
>>  	coresight_unregister(drvdata->csdev);
>>  }
>>  
>> +static void tmc_remove(struct amba_device *adev)
>> +{
>> +	__tmc_remove(&adev->dev);
>> +}
>> +
>>  static const struct amba_id tmc_ids[] = {
>>  	CS_AMBA_ID(0x000bb961),
>>  	/* Coresight SoC 600 TMC-ETR/ETS */
>> @@ -613,6 +624,92 @@ static struct amba_driver tmc_driver = {
>>  
>>  module_amba_driver(tmc_driver);
>>  
>> +static int tmc_platform_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	struct tmc_drvdata *drvdata;
>> +	int ret = 0;
>> +
>> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +
>> +	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
>> +	if (IS_ERR(drvdata->pclk))
>> +		return -ENODEV;
>> +
> 
> --->8
>> +	if (res) {
>> +		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(drvdata->base)) {
>> +			clk_put(drvdata->pclk);
>> +			return PTR_ERR(drvdata->base);
>> +		}
>> +	}
>> +
> ---
> 
> You need drop the above hunk as _tmc_probe() already takes care of that.

Dropped.

> This is the root cause for the issue I reported in the other thread. Also
> sorry for the confusion, I had to refer to coresight-tmc-core.c and post
> the patch to unify module_init/exit but completely mixed up the file/patch
> and referred coresight-tpiu-core.c instead as that patch was dealing with
> it.
> 
