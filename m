Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E880C218
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjLKHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjLKHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:39:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0D99DB;
        Sun, 10 Dec 2023 23:39:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7FD1007;
        Sun, 10 Dec 2023 23:40:00 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB9A3F762;
        Sun, 10 Dec 2023 23:39:10 -0800 (PST)
Message-ID: <5c9371bd-9f29-408f-9419-df2209e55f7e@arm.com>
Date:   Mon, 11 Dec 2023 13:09:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/10] coresight: tmc: Move ACPI support from AMBA
 driver to platform driver
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20231208053939.42901-1-anshuman.khandual@arm.com>
 <20231208053939.42901-9-anshuman.khandual@arm.com>
 <22cfb197-b8bd-46c5-f3cb-ea04b95c0792@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <22cfb197-b8bd-46c5-f3cb-ea04b95c0792@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/23 21:01, James Clark wrote:
> 
> On 08/12/2023 05:39, Anshuman Khandual wrote:
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
>> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V3:
>>
>> - Added commnets for 'drvdata->pclk'
>> - Used coresight_init_driver()/coresight_remove_driver() helpers instead
>> - Dropped pm_runtime_put() from __tmc_probe()
>> - Added pm_runtime_put() on success path in tmc_probe()
>> - Added pm_runtime_put() on success/error paths in tmc_platform_probe()
>> - Check for drvdata instead of drvdata->pclk in suspend and resume paths
>>
>>  drivers/acpi/arm64/amba.c                     |   2 -
>>  .../hwtracing/coresight/coresight-tmc-core.c  | 137 ++++++++++++++++--
>>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>>  3 files changed, 124 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
>> index 6d24a8f7914b..d3c1defa7bc8 100644
>> --- a/drivers/acpi/arm64/amba.c
>> +++ b/drivers/acpi/arm64/amba.c
>> @@ -22,10 +22,8 @@
>>  static const struct acpi_device_id amba_id_list[] = {
>>  	{"ARMH0061", 0}, /* PL061 GPIO Device */
>>  	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
>> -	{"ARMHC501", 0}, /* ARM CoreSight ETR */
>>  	{"ARMHC502", 0}, /* ARM CoreSight STM */
>>  	{"ARMHC503", 0}, /* ARM CoreSight Debug */
>> -	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
>>  	{"", 0},
>>  };
>>  
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index ad61d02f5f75..8482830d73ef 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -23,6 +23,8 @@
>>  #include <linux/of.h>
>>  #include <linux/coresight.h>
>>  #include <linux/amba/bus.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
>>  
>>  #include "coresight-priv.h"
>>  #include "coresight-tmc.h"
>> @@ -437,24 +439,17 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
>>  	return burst_size;
>>  }
>>  
>> -static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>> +static int __tmc_probe(struct device *dev, struct resource *res, void *dev_caps)
> I don't think the dev_caps argument is used anymore since the v3 changes.

Sure, will drop the argument.
