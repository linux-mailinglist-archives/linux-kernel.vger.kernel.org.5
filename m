Return-Path: <linux-kernel+bounces-98493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA1877AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD561C216C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105ACA47;
	Mon, 11 Mar 2024 06:05:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256158F4A;
	Mon, 11 Mar 2024 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710137110; cv=none; b=H5q/ONfzV1D43AcLubvgHl9anhckgjEZFfO26DQiEqgAxpTv6SDCr/bW7t7uvfT4aGEssxTt5LLaZ+terrqGc+BnHxLbUvexQmcixds4wBcXhyEzILnebhEwYmyL82iOXdDBxBXt9lnf5XvBpgIuZfETMeQdEApcuaehQHNvT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710137110; c=relaxed/simple;
	bh=TXK5HSlimSGNRAJ7qO57SuGX/bRuFSCVlzTsdBRuad0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePowLJ+pinAs8iil8RpvxiFs0uyMBPkUdV0Iy+zxmoZ4lsjYncWNevuM3xT8Rbm/lgHlYCAICCLx2MtOIQAdfh5kg52arBY/tR1cFVjZHzbCyjCdOQYmoVPXBk/fgKsCCodK+mQtrlnAu6OyfBYl3x6dp3Ui3JPw7BWtQRdAYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143F1FEC;
	Sun, 10 Mar 2024 23:05:38 -0700 (PDT)
Received: from [10.162.42.8] (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B65C3F73F;
	Sun, 10 Mar 2024 23:04:57 -0700 (PDT)
Message-ID: <379bf6df-3568-43c0-9a68-4a5693bf5ccc@arm.com>
Date: Mon, 11 Mar 2024 11:34:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/11] coresight: Move remaining AMBA ACPI devices into
 platform driver
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
References: <20240222082142.3663983-1-anshuman.khandual@arm.com>
 <8ef57dd9-a16d-4847-89f5-a309c4ccb849@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8ef57dd9-a16d-4847-89f5-a309c4ccb849@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/5/24 23:55, Suzuki K Poulose wrote:
> On 22/02/2024 08:21, Anshuman Khandual wrote:
>> This moves remaining AMBA ACPI devices into respective platform drivers for
>> enabling ACPI based power management support. This series applies on kernel
>> v6.8-rc5 release. This series has been built, and boot tested on a DT based
>> (RB5) and ACPI supported coresight platform (N1SDP).
> 
> Please rebase your series on coresight next and fix build failures with the extra warnings turned ON (should be on by default with next).

I did rebase the series (which required some rebase related changes for some) on
coresight next i.e with the following commit as HEAD.

a4f3057d19ff ("coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits")

Although did not see any warning either with = m or = y based coresight options.
Is there any other particular config which needs to be enabled for these warnings
to come up ?

> 
> 
> Suzuki
> 
>>
>> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v5)
>>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: coresight@lists.linaro.org
>> Cc: linux-stm32@st-md-mailman.stormreply.com
>>
>> Changes in V5:
>>
>> - Used table->mask to filter out bits from pid in coresight_get_uci_data_from_amba()
>> - Dropped custom masks such as STM_AMBA_MASK and TMC_AMBA_MASK
>> - Modified tmc_etr_setup_caps() to accept struct csdev_access argument
>> - Reverted back tmc_etr_setup_caps() call site position in tmc_probe()
>> - Changed replicator and funnel devices to use the new helpers earlier in series
>> - Updated the commit messages regarding xxx_probe() refactoring and renaming
>>
>> Changes in V4:
>>
>> https://lore.kernel.org/all/20240123054608.1790189-1-anshuman.khandual@arm.com/
>>
>> - Fixed PM imbalance in etm4_probe() error path with pm_runtime_disable()
>> - Restored back the pm_runtime_disable() on platform probe error paths
>>    in replicator, funnel, catu, tpiu, tmc and stm devices
>> - Dropped dev_caps argument from __tmc_probe()
>> - Changed xxxx_platform_remove() for platform_driver->remove_new() callback
>>
>> Changes in V3:
>>
>> https://lore.kernel.org/all/20231208053939.42901-1-anshuman.khandual@arm.com/
>>
>> - Split coresight_init_driver/remove_driver() helpers into a separate patch
>> - Added 'drvdata->pclk' comments in replicator, funnel, tpiu, tmc, and stm devices
>> - Updated funnel, and replicator drivers to use these new helpers
>> - Check for drvdata instead of drvdata->pclk in suspend and resume paths in catu,
>>    tmc and debug devices
>> - Added patch to extract device name from AMBA pid based table lookup for stm
>> - Added patch to extract device properties from AMBA pid based table look for tmc
>> - Dropped pm_runtime_put() from common __probe() functions
>> - Handled pm_runtime_put() in AMBA driver in success path
>> - Handled pm_runtime_put() in platform driver in both success and error paths
>>
>> Changes in V2:
>>
>> https://lore.kernel.org/all/20231201062053.1268492-1-anshuman.khandual@arm.com/
>>
>> - Dropped redundant devm_ioremap_resource() hunk from tmc_platform_probe()
>> - Defined coresight_[init|remove]_driver() for both AMBA/platform drivers
>> - Changed catu, tmc, tpiu, stm and debug coresight drivers to use the new
>>    helpers avoiding build issues arising from module_amba_driver(), and
>>    module_platform_driver() being on the same file
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20231027072943.3418997-1-anshuman.khandual@arm.com/
>>
>> - Replaced all IS_ERR() instances with IS_ERR_OR_NULL() as per Suzuki
>>
>> Changes in RFC:
>>
>> https://lore.kernel.org/all/20230921042040.1334641-1-anshuman.khandual@arm.com/
>>
>> Anshuman Khandual (11):
>>    coresight: etm4x: Fix unbalanced pm_runtime_enable()
>>    coresight: stm: Extract device name from AMBA pid based table lookup
>>    coresight: tmc: Extract device properties from AMBA pid based table lookup
>>    coresight: Add helpers registering/removing both AMBA and platform drivers
>>    coresight: replicator: Move ACPI support from AMBA driver to platform driver
>>    coresight: funnel: Move ACPI support from AMBA driver to platform driver
>>    coresight: catu: Move ACPI support from AMBA driver to platform driver
>>    coresight: tpiu: Move ACPI support from AMBA driver to platform driver
>>    coresight: tmc: Move ACPI support from AMBA driver to platform driver
>>    coresight: stm: Move ACPI support from AMBA driver to platform driver
>>    coresight: debug: Move ACPI support from AMBA driver to platform driver
>>
>>   drivers/acpi/arm64/amba.c                     |   8 -
>>   drivers/hwtracing/coresight/coresight-catu.c  | 142 +++++++++++++---
>>   drivers/hwtracing/coresight/coresight-catu.h  |   1 +
>>   drivers/hwtracing/coresight/coresight-core.c  |  29 ++++
>>   .../hwtracing/coresight/coresight-cpu-debug.c | 141 ++++++++++++++--
>>   .../coresight/coresight-etm4x-core.c          |   3 +
>>   .../hwtracing/coresight/coresight-funnel.c    |  86 +++++-----
>>   drivers/hwtracing/coresight/coresight-priv.h  |  10 ++
>>   .../coresight/coresight-replicator.c          |  81 +++++-----
>>   drivers/hwtracing/coresight/coresight-stm.c   | 115 +++++++++++--
>>   .../hwtracing/coresight/coresight-tmc-core.c  | 153 +++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>>   drivers/hwtracing/coresight/coresight-tpiu.c  | 102 ++++++++++--
>>   include/linux/coresight.h                     |   7 +
>>   14 files changed, 721 insertions(+), 159 deletions(-)
>>
> 

