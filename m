Return-Path: <linux-kernel+bounces-29432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90D830E25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB601C2153A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D442250F7;
	Wed, 17 Jan 2024 20:43:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433B250E6;
	Wed, 17 Jan 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524197; cv=none; b=Qd4KW9S4lRfRKpRACvDmgfct7c7DJJtrIB9oTPELIlshWWalysL/Dzgn+QK/ZMlhbBqSqMfzxbEr6e9ggufD26AoE+QFaXh6IASo991tmCZJ9if++ww2QYRSWw99E9ccMLqT1ej486PsvIGcU1ztK9tEBJCZSNdzPqd8sjoQKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524197; c=relaxed/simple;
	bh=CKIqWY6bniHgYHR52mR5xO2X/Aq6Z5AV/erKRUEjfcM=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=pYH51PACA0898Cw8pG9/7BhjqWBjTSIW5C1eh5ut9vjH7t8+64K/fa5sMyrh89bXxD2qCOaGy+8Iwo700DAwd8Y379lcaScSFket7bvOq0ThjQ6if6QLloQUIxxNkNpjvlaezUFSlT/yMT3ykHYKHEGG1mxGjmaR9rVUmpr2+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6258311FB;
	Wed, 17 Jan 2024 12:43:59 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 025B53F766;
	Wed, 17 Jan 2024 12:43:10 -0800 (PST)
Date: Wed, 17 Jan 2024 20:43:08 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 4/6] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <Zag73Dj_6IT8dB00@pluto>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
 <20240104-pinctrl-scmi-v2-4-a9bd86ab5a84@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-pinctrl-scmi-v2-4-a9bd86ab5a84@nxp.com>

On Thu, Jan 04, 2024 at 06:48:48PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
> 

Hi,

a few remarks.

> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pinctrl/Kconfig        |  11 +
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 524 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 537 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 487bff0d44c0..3fe790e90834 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21314,6 +21314,7 @@ F:	drivers/clk/clk-sc[mp]i.c
>  F:	drivers/cpufreq/sc[mp]i-cpufreq.c
>  F:	drivers/firmware/arm_scmi/
>  F:	drivers/firmware/arm_scpi.c
> +F:	drivers/pinctrl/pinctrl-scmi.c
>  F:	drivers/pmdomain/arm/
>  F:	drivers/powercap/arm_scmi_powercap.c
>  F:	drivers/regulator/scmi-regulator.c
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 8163a5983166..27b26e428f60 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -432,6 +432,17 @@ config PINCTRL_ROCKCHIP
>  	help
>            This support pinctrl and GPIO driver for Rockchip SoCs.
>  
> +config PINCTRL_SCMI
> +	tristate "Pinctrl driver using SCMI protocol interface"
> +	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	help
> +	  This driver provides support for pinctrl which is controlled
> +	  by firmware that implements the SCMI interface.
> +	  It uses SCMI Message Protocol to interact with the
> +	  firmware providing all the pinctrl controls.
> +
>  config PINCTRL_SINGLE
>  	tristate "One-register-per-pin type device tree based pinctrl driver"
>  	depends on OF
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 1071f301cc70..ba755ed2d46c 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
>  obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
>  obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
>  obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
> +obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
>  obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
>  obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
>  obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> new file mode 100644
> index 000000000000..146308d27f54
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Power Interface (SCMI) Protocol based pinctrl driver
> + *
> + * Copyright (C) 2023 EPAM
> + * Copyright 2023 NXP
> + */

2023-2024

> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include "pinctrl-utils.h"
> +#include "core.h"
> +#include "pinconf.h"
> +
> +#define DRV_NAME "scmi-pinctrl"
 
 [snip]

> +static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
> +	.request = pinctrl_scmi_request,
> +	.free = pinctrl_scmi_free,
> +	.get_functions_count = pinctrl_scmi_get_functions_count,
> +	.get_function_name = pinctrl_scmi_get_function_name,
> +	.get_function_groups = pinctrl_scmi_get_function_groups,
> +	.set_mux = pinctrl_scmi_func_set_mux,
> +};
> +
> +static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param, u8 *type)
> +{

Same as in the previous patch, is it reasonable to use the new enum here instead
of a generic u8 * ?

> +	u8 arg = param;
> +
> +	switch (arg) {
> +	case PIN_CONFIG_BIAS_BUS_HOLD:
> +		*type = SCMI_PIN_BIAS_BUS_HOLD;
> +		break;
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		*type = SCMI_PIN_BIAS_DISABLE;
> +		break;
> +	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
> +		*type = SCMI_PIN_BIAS_HIGH_IMPEDANCE;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		*type = SCMI_PIN_BIAS_PULL_DOWN;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
> +		*type = SCMI_PIN_BIAS_PULL_DEFAULT;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		*type = SCMI_PIN_BIAS_PULL_UP;
> +		break;
> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +		*type = SCMI_PIN_DRIVE_OPEN_DRAIN;
> +		break;
> +	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> +		*type = SCMI_PIN_DRIVE_OPEN_SOURCE;
> +		break;
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		*type = SCMI_PIN_DRIVE_PUSH_PULL;
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		*type = SCMI_PIN_DRIVE_STRENGTH;
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH_UA:
> +		*type = SCMI_PIN_DRIVE_STRENGTH;
> +		break;
> +	case PIN_CONFIG_INPUT_DEBOUNCE:
> +		*type = SCMI_PIN_INPUT_DEBOUNCE;
> +		break;
> +	case PIN_CONFIG_INPUT_ENABLE:
> +		*type = SCMI_PIN_INPUT_MODE;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT:
> +		*type = SCMI_PIN_INPUT_SCHMITT;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		*type = SCMI_PIN_INPUT_MODE;
> +		break;
> +	case PIN_CONFIG_MODE_LOW_POWER:
> +		*type = SCMI_PIN_LOW_POWER_MODE;
> +		break;
> +	case PIN_CONFIG_OUTPUT:
> +		*type = SCMI_PIN_OUTPUT_VALUE;
> +		break;
> +	case PIN_CONFIG_OUTPUT_ENABLE:
> +		*type = SCMI_PIN_OUTPUT_MODE;
> +		break;
> +	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
> +		*type = SCMI_PIN_OUTPUT_VALUE;
> +		break;
> +	case PIN_CONFIG_POWER_SOURCE:
> +		*type = SCMI_PIN_POWER_SOURCE;
> +		break;
> +	case PIN_CONFIG_SLEW_RATE:
> +		*type = SCMI_PIN_SLEW_RATE;
> +		break;
> +	case SCMI_PIN_OEM_START ... SCMI_PIN_OEM_END:
> +		*type = param;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned int _pin,
> +				    unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	u32 config_value;
> +	u8 type;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +
> +	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
> +	if (ret) {
> +		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +		return ret;
> +	}
> +

Issuing a cat /sys/kernel/debug/pictrl/<scmi_dev>/pinconf-pins
got a string of (adding some debug to print config_type):

[   89.843868] scmi-pinctrl scmi_dev.12: Error map pinconf_type 22 - ret:-95
[   89.846125] scmi-pinctrl scmi_dev.12: Error map pinconf_type 23 - ret:-95

but I suppose is due to some missing matching definitions in the SCMI
spec....just a heads up for the future.

> +	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type, &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *configs,
> +				    unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		ret = pinctrl_scmi_map_pinconf_type(pinconf_to_config_param(configs[i]),
> +						    &pmx->config_type[i]);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +			return ret;
> +		}
> +		pmx->config_value[i] = pinconf_to_config_argument(configs[i]);
> +	}
> +

Are you sure that this pinctrl function cannot be called multiple times
concurrently ? Because pmx->config_type/value are globally defined for
the driver so any concurrent call will lead to corruption.

Moreover, you allocate those pmx->config_ arrays in probe as SZ_4K, but
effectively how many of these are effectively used in reality ?

I mean, we clearly have to address the worst case, which is 256 values by
the SCMI spec CONFIG_SET definitions, but typically how many configs are
going to be sent in a call ? because if it is a reasonable small values
you could just put in on the stack here with a check for overlflow and
a dynamic allocation to address the special case...this would also solve
the potential concurrent calls issue described above.

..but I could be missing something about Pinctrl so please explain.

> +	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
> +				      pmx->config_type,  pmx->config_value);
> +	if (ret)
> +		dev_err(pmx->dev, "Error parsing config %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
> +					  unsigned int group,
> +					  unsigned long *configs,
> +					  unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx =  pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		ret = pinctrl_scmi_map_pinconf_type(pinconf_to_config_param(configs[i]),
> +						    &pmx->config_type[i]);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +			return ret;
> +		}
> +		pmx->config_value[i] = pinconf_to_config_argument(configs[i]);
> +	}
> +
> +	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
> +				      pmx->config_type, pmx->config_value);
> +	if (ret)
> +		dev_err(pmx->dev, "Error parsing config %d", ret);
> +
> +	return ret;
> +};
> +
> +static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
> +					  unsigned int group,
> +					  unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	u32 config_value;
> +	u8 type;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);

You dont check ret here ?

> +
> +	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type, &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +

Thanks,
Cristian

