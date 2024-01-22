Return-Path: <linux-kernel+bounces-33759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306E836E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60FC28514D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F54CB26;
	Mon, 22 Jan 2024 17:14:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0B3B282;
	Mon, 22 Jan 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943657; cv=none; b=d6AhKRcSN/wOkFIJr4t3wC1BWT84TuqL9FIiuSXim5hsmY1L/azqCrfuaUfOx99Zp3hlu/QmzhsUgiWV8EvvGHDv6fqjjnENuUObIX8/JETzxqtfNfG4MlnetVoahSqTxCtCDUpNQt3WeytffZIJ44J9w0VzKv8vsKVNgqqIT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943657; c=relaxed/simple;
	bh=+qG1P27++ZpACChLFYOFYkY7FxEwyWbybMQXOcfGB6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fizXyDI+B9NYJ3ydeyPL5eIG3VH+uMKbsuKixRyyTHUo6PsKWa+kCV722lr/dik4IFxceddty5jjqScOLbpFAP5TBJwMhVs9SUsi1F2/RsJ92C8TlEVmYYJpTNxuhVKtPN/zY9jAD1k8fuXfVWzSSLZokOb0I2+KCD8Hk32pPlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2E21FB;
	Mon, 22 Jan 2024 09:14:59 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF31C3F5A1;
	Mon, 22 Jan 2024 09:14:08 -0800 (PST)
Date: Mon, 22 Jan 2024 17:14:06 +0000
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
Subject: Re: [PATCH v3 4/6] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <Za6iXlhATdMmVVUI@pluto>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <20240121-pinctrl-scmi-v3-4-8d94ba79dca8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121-pinctrl-scmi-v3-4-8d94ba79dca8@nxp.com>

On Sun, Jan 21, 2024 at 06:21:53PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
> 
Hi Peng,

thanks for addressing the residual issues from v2.

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pinctrl/Kconfig        |  11 +
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 593 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 606 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fa33def310..d1b6f889e79c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21313,6 +21313,7 @@ F:	drivers/clk/clk-sc[mp]i.c
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
> index 000000000000..f2fef3fb85ae
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -0,0 +1,593 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Power Interface (SCMI) Protocol based pinctrl driver
> + *
> + * Copyright (C) 2024 EPAM
> + * Copyright 2024 NXP
> + */
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
> +
> +/* Define num configs, if not large than 4 use stack, else use kcalloc */
> +#define SCMI_NUM_CONFIGS	4
> +
> +static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
> +
> +struct scmi_pinctrl_funcs {
> +	unsigned int num_groups;
> +	const char **groups;
> +};
> +
> +struct scmi_pinctrl {
> +	struct device *dev;
> +	struct scmi_protocol_handle *ph;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_desc pctl_desc;
> +	struct scmi_pinctrl_funcs *functions;
> +	unsigned int nr_functions;
> +	char **groups;
> +	unsigned int nr_groups;
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int nr_pins;
> +};
> +
> +static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->count_get(pmx->ph, GROUP_TYPE);
> +}
> +
> +static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
> +					       unsigned int selector)
> +{
> +	int ret;
> +	const char *name;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	ret = pinctrl_ops->name_get(pmx->ph, selector, GROUP_TYPE, &name);
> +	if (ret) {
> +		dev_err(pmx->dev, "get name failed with err %d", ret);
> +		return NULL;
> +	}
> +
> +	return name;
> +}
> +
> +static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
> +				       unsigned int selector,
> +				       const unsigned int **pins,
> +				       unsigned int *num_pins)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->group_pins_get(pmx->ph, selector, pins, num_pins);
> +}
> +
> +static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
> +	.get_groups_count = pinctrl_scmi_get_groups_count,
> +	.get_group_name = pinctrl_scmi_get_group_name,
> +	.get_group_pins = pinctrl_scmi_get_group_pins,
> +#ifdef CONFIG_OF
> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
> +	.dt_free_map = pinconf_generic_dt_free_map,
> +#endif
> +};
> +
> +static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->count_get(pmx->ph, FUNCTION_TYPE);
> +}
> +
> +static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
> +						  unsigned int selector)
> +{
> +	int ret;
> +	const char *name;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	ret = pinctrl_ops->name_get(pmx->ph, selector, FUNCTION_TYPE, &name);
> +	if (ret) {
> +		dev_err(pmx->dev, "get name failed with err %d", ret);
> +		return NULL;
> +	}
> +
> +	return name;
> +}
> +
> +static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
> +					    unsigned int selector,
> +					    const char * const **groups,
> +					    unsigned int * const num_groups)
> +{
> +	const unsigned int *group_ids;
> +	int ret, i;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!groups || !num_groups)
> +		return -EINVAL;
> +
> +	if (selector < pmx->nr_functions &&
> +	    pmx->functions[selector].num_groups) {
> +		*groups = (const char * const *)pmx->functions[selector].groups;
> +		*num_groups = pmx->functions[selector].num_groups;
> +		return 0;
> +	}
> +
> +	ret = pinctrl_ops->function_groups_get(pmx->ph, selector,
> +					       &pmx->functions[selector].num_groups,
> +					       &group_ids);
> +	if (ret) {
> +		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
> +		return ret;
> +	}
> +
> +	*num_groups = pmx->functions[selector].num_groups;
> +	if (!*num_groups)
> +		return -EINVAL;
> +
> +	pmx->functions[selector].groups =
> +		devm_kcalloc(pmx->dev, *num_groups,
> +			     sizeof(*pmx->functions[selector].groups),
> +			     GFP_KERNEL);
> +	if (!pmx->functions[selector].groups)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < *num_groups; i++) {
> +		pmx->functions[selector].groups[i] =
> +			pinctrl_scmi_get_group_name(pmx->pctldev,
> +						    group_ids[i]);
> +		if (!pmx->functions[selector].groups[i]) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
> +	}
> +
> +	*groups = (const char * const *)pmx->functions[selector].groups;
> +
> +	return 0;
> +
> +err_free:
> +	devm_kfree(pmx->dev, pmx->functions[selector].groups);
> +
> +	return ret;
> +}
> +
> +static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
> +				     unsigned int selector, unsigned int group)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->mux_set(pmx->ph, selector, group);
> +}
> +
> +static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
> +				unsigned int offset)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->pin_request(pmx->ph, offset);
> +}
> +
> +static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->pin_free(pmx->ph, offset);
> +}
> +
> +static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
> +	.request = pinctrl_scmi_request,
> +	.free = pinctrl_scmi_free,
> +	.get_functions_count = pinctrl_scmi_get_functions_count,
> +	.get_function_name = pinctrl_scmi_get_function_name,
> +	.get_function_groups = pinctrl_scmi_get_function_groups,
> +	.set_mux = pinctrl_scmi_func_set_mux,
> +};
> +
> +static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
> +					 enum scmi_pinctrl_conf_type *type)
> +{
> +	u32 arg = param;
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
> +		*type = arg;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin, unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	enum scmi_pinctrl_conf_type type;
> +	u32 config_value;
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
> +	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, type,
> +				      &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static int
> +pinctrl_scmi_alloc_configs(struct pinctrl_dev *pctldev, u32 num_configs,
> +			   u32 **p_config_value,
> +			   enum scmi_pinctrl_conf_type **p_config_type)
> +{
> +	if (num_configs <= SCMI_NUM_CONFIGS)
> +		return 0;
> +
> +	*p_config_value = kcalloc(num_configs, sizeof(u32), GFP_KERNEL);
> +	*p_config_type = kcalloc(num_configs,
> +				 sizeof(enum scmi_pinctrl_conf_type),
> +				 GFP_KERNEL);
> +
> +	if (!*p_config_value || !*p_config_type) {
> +		kfree(*p_config_value);
> +		kfree(*p_config_type);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +pinctrl_scmi_free_configs(struct pinctrl_dev *pctldev, u32 num_configs,
> +			  u32 **p_config_value,
> +			  enum scmi_pinctrl_conf_type **p_config_type)
> +{
> +	if (num_configs <= SCMI_NUM_CONFIGS)
> +		return;
> +
> +	kfree(*p_config_value);
> +	kfree(*p_config_type);
> +}
> +
> +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *configs,
> +				    unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
> +	u32 config_value[SCMI_NUM_CONFIGS];
> +	enum scmi_pinctrl_conf_type *p_config_type = config_type;
> +	u32 *p_config_value = config_value;
> +	enum pin_config_param param;
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +
> +	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
> +					 &p_config_value);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		param = pinconf_to_config_param(configs[i]);
> +		ret = pinctrl_scmi_map_pinconf_type(param, &p_config_type[i]);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +			goto free_config;
> +		}
> +		p_config_value[i] = pinconf_to_config_argument(configs[i]);
> +	}
> +
> +	ret = pinctrl_ops->config_set(pmx->ph, _pin, PIN_TYPE, num_configs,
> +				      p_config_type,  p_config_value);
> +	if (ret)
> +		dev_err(pmx->dev, "Error parsing config %d\n", ret);
> +
> +free_config:
> +	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
> +				  &p_config_value);
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
> +	enum scmi_pinctrl_conf_type config_type[SCMI_NUM_CONFIGS];
> +	u32 config_value[SCMI_NUM_CONFIGS];
> +	enum scmi_pinctrl_conf_type *p_config_type = config_type;
> +	u32 *p_config_value = config_value;
> +	enum pin_config_param param;
> +
> +	if (!configs || !num_configs)
> +		return -EINVAL;
> +
> +	ret = pinctrl_scmi_alloc_configs(pctldev, num_configs, &p_config_type,
> +					 &p_config_value);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		param = pinconf_to_config_param(configs[i]);
> +		ret = pinctrl_scmi_map_pinconf_type(param,
> +						    &p_config_type[i]);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +			goto free_config;
> +		}
> +
> +		p_config_value[i] = pinconf_to_config_argument(configs[i]);
> +	}
> +
> +	ret = pinctrl_ops->config_set(pmx->ph, group, GROUP_TYPE, num_configs,
> +				      p_config_type, p_config_value);
> +	if (ret)
> +		dev_err(pmx->dev, "Error parsing config %d", ret);
> +
> +free_config:
> +	pinctrl_scmi_free_configs(pctldev, num_configs, &p_config_type,
> +				  &p_config_value);
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
> +	enum scmi_pinctrl_conf_type type;
> +	u32 config_value;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +	ret = pinctrl_scmi_map_pinconf_type(config_type, &type);
> +	if (ret) {
> +		dev_err(pmx->dev, "Error map pinconf_type %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pinctrl_ops->config_get(pmx->ph, group, GROUP_TYPE, type,
> +				      &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
> +	.is_generic = true,
> +	.pin_config_get = pinctrl_scmi_pinconf_get,
> +	.pin_config_set = pinctrl_scmi_pinconf_set,
> +	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
> +	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
> +	.pin_config_config_dbg_show = pinconf_generic_dump_config,
> +};
> +
> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 unsigned int *nr_pins,
> +				 const struct pinctrl_pin_desc **pins)
> +{
> +	int ret, i;
> +
> +	if (!pins || !nr_pins)
> +		return -EINVAL;
> +
> +	if (pmx->nr_pins) {
> +		*pins = pmx->pins;
> +		*nr_pins = pmx->nr_pins;
> +		return 0;
> +	}
> +
> +	*nr_pins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> +
> +	pmx->nr_pins = *nr_pins;
> +	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
> +				       GFP_KERNEL);
> +	if (!pmx->pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < *nr_pins; i++) {
> +		pmx->pins[i].number = i;
> +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE,
> +					    &pmx->pins[i].name);
> +		if (ret) {
> +			dev_err(pmx->dev, "Can't get name for pin %d: rc %d", i, ret);
> +			pmx->nr_pins = 0;
> +			return ret;
> +		}
> +	}
> +
> +	*pins = pmx->pins;
> +	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
> +
> +	return 0;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static int scmi_pinctrl_probe(struct scmi_device *sdev)
> +{
> +	int ret;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_pinctrl *pmx;
> +	const struct scmi_handle *handle;
> +	struct scmi_protocol_handle *ph;
> +
> +	if (!sdev || !sdev->handle)
> +		return -EINVAL;
> +
> +	handle = sdev->handle;
> +
> +	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
> +						&ph);
> +	if (IS_ERR(pinctrl_ops))
> +		return PTR_ERR(pinctrl_ops);
> +
> +	pmx = devm_kzalloc(dev, sizeof(*pmx), GFP_KERNEL);
> +	if (!pmx)
> +		return -ENOMEM;
> +
> +	pmx->ph = ph;
> +
> +	pmx->dev = dev;
> +	pmx->pctl_desc.name = DRV_NAME;
> +	pmx->pctl_desc.owner = THIS_MODULE;
> +	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
> +	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
> +	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
> +
> +	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
> +				    &pmx->pctl_desc.pins);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pinctrl_register_and_init(dev, &pmx->pctl_desc, pmx,
> +					     &pmx->pctldev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
> +
> +	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
> +	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
> +
> +	if (pmx->nr_functions) {
> +		pmx->functions = devm_kcalloc(dev, pmx->nr_functions,
> +					      sizeof(*pmx->functions),
> +					      GFP_KERNEL);
> +		if (!pmx->functions)
> +			return -ENOMEM;
> +	}
> +
> +	if (pmx->nr_groups) {
> +		pmx->groups = devm_kcalloc(dev, pmx->nr_groups,
> +					   sizeof(*pmx->groups), GFP_KERNEL);
> +		if (!pmx->groups)
> +			return -ENOMEM;
> +	}
> +
> +	return pinctrl_enable(pmx->pctldev);
> +}
> +
> +static struct scmi_driver scmi_pinctrl_driver = {
> +	.name = DRV_NAME,
> +	.probe = scmi_pinctrl_probe,
> +	.id_table = scmi_id_table,
> +};
> +module_scmi_driver(scmi_pinctrl_driver);
> +
> +MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_DESCRIPTION("ARM SCMI pin controller driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.37.1
> 

