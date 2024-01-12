Return-Path: <linux-kernel+bounces-24721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9D82C150
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18E81F270E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF736D1C8;
	Fri, 12 Jan 2024 14:04:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35B6BB41;
	Fri, 12 Jan 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2176D1FB;
	Fri, 12 Jan 2024 06:05:16 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21A93F5A1;
	Fri, 12 Jan 2024 06:04:26 -0800 (PST)
Message-ID: <2c920dda-fdd3-436a-85cc-ead018f28ee4@arm.com>
Date: Fri, 12 Jan 2024 14:04:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] coresight: config: Add preloaded configuration
Content-Language: en-US
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com, leo.yan@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20240105055840.1977897-1-lcherian@marvell.com>
 <20240105055840.1977897-8-lcherian@marvell.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240105055840.1977897-8-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/2024 05:58, Linu Cherian wrote:
> Add a preloaded configuration for generating
> external trigger on address match. This can be
> used by CTI and ETR blocks to stop trace capture
> on kernel panic.
> 
> Kernel address for panic function to be
> programmed as below.
> 
> $cd /config/cs-syscfg/features/gen_etrig/params
> $echo <panic_address> > address/value
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v5:
> * No changes
> 
>   drivers/hwtracing/coresight/Makefile          |  2 +-
>   .../coresight/coresight-cfg-preload.c         |  2 +
>   .../coresight/coresight-cfg-preload.h         |  2 +
>   .../hwtracing/coresight/coresight-cfg-pstop.c | 83 +++++++++++++++++++
>   4 files changed, 88 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 995d3b2c76df..68b15c8d9462 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -5,7 +5,7 @@
>   obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>   		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> -		coresight-cfg-preload.o coresight-cfg-afdo.o \
> +		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
>   		coresight-syscfg-configfs.o coresight-trace-id.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> index e237a4edfa09..4980e68483c5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> @@ -13,6 +13,7 @@
>   static struct cscfg_feature_desc *preload_feats[] = {
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   	&strobe_etm4x,
> +	&gen_etrig_etm4x,
>   #endif
>   	NULL
>   };
> @@ -20,6 +21,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
>   static struct cscfg_config_desc *preload_cfgs[] = {
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   	&afdo_etm4x,
> +	&pstop_etm4x,
>   #endif
>   	NULL
>   };
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> index 21299e175477..291ba530a6a5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> @@ -10,4 +10,6 @@
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   extern struct cscfg_feature_desc strobe_etm4x;
>   extern struct cscfg_config_desc afdo_etm4x;
> +extern struct cscfg_feature_desc gen_etrig_etm4x;
> +extern struct cscfg_config_desc pstop_etm4x;
>   #endif
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-pstop.c b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
> new file mode 100644
> index 000000000000..037d6773fab8
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(C) 2023  Marvell.
> + * Based on coresight-cfg-afdo.c
> + */
> +
> +#include "coresight-config.h"
> +
> +/* ETMv4 includes and features */
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
> +#include "coresight-etm4x-cfg.h"
> +
> +/* preload configurations and features */
> +
> +/* preload in features for ETMv4 */
> +
> +/* panic_stop feature */
> +static struct cscfg_parameter_desc gen_etrig_params[] = {
> +	{
> +		.name = "address",
> +		.value = 0x0,
> +	},
> +};
> +
> +static struct cscfg_regval_desc gen_etrig_regs[] = {
> +	/* resource selector */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCRSCTLRn(2),
> +		.hw_info = ETM4_CFG_RES_SEL,
> +		.val32 = 0x40001,
> +	},
> +	/* single address comparator */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_64BIT |
> +			CS_CFG_REG_TYPE_VAL_PARAM,
> +		.offset =  TRCACVRn(0),
> +		.val32 = 0x0,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCACATRn(0),
> +		.val64 = 0xf00,
> +	},
> +	/* Driver external output[0] with comparator out */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCEVENTCTL0R,
> +		.val32 = 0x2,
> +	},
> +	/* end of regs */
> +};
> +
> +struct cscfg_feature_desc gen_etrig_etm4x = {
> +	.name = "gen_etrig",
> +	.description = "Generate external trigger on address match\n"
> +		       "parameter \'address\': address of kernel address\n",
> +	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
> +	.nr_params = ARRAY_SIZE(gen_etrig_params),
> +	.params_desc = gen_etrig_params,
> +	.nr_regs = ARRAY_SIZE(gen_etrig_regs),
> +	.regs_desc = gen_etrig_regs,
> +};
> +
> +/* create a panic stop configuration */
> +
> +/* the total number of parameters in used features */
> +#define PSTOP_NR_PARAMS	ARRAY_SIZE(gen_etrig_params)
> +
> +static const char *pstop_ref_names[] = {
> +	"gen_etrig",
> +};
> +
> +struct cscfg_config_desc pstop_etm4x = {
> +	.name = "panicstop",
> +	.description = "Stop ETM on kernel panic\n",

Since this is actually generic, i.e., Stop trace on a Kernel address, we
could rename this ?  Or why don't we pre-populate the address of "panic"
at load time. That way the user doesn't have to figure out the kernel
address (e.g., if KASLR is enabled)

Suzuki


> +	.nr_feat_refs = ARRAY_SIZE(pstop_ref_names),
> +	.feat_ref_names = pstop_ref_names,
> +	.nr_total_params = PSTOP_NR_PARAMS,
> +};
> +
> +/* end of ETM4x configurations */
> +#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */


