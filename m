Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B2E77E197
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbjHPM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245252AbjHPM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:26:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2014A26B1;
        Wed, 16 Aug 2023 05:26:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1553A1063;
        Wed, 16 Aug 2023 05:26:48 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52A363F6C4;
        Wed, 16 Aug 2023 05:26:05 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:25:59 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZNzASBOBs7fK8_q1@pluto>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
 <a6cefa60500cd46313ad6cda4f13f4985c0f5237.1691518314.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6cefa60500cd46313ad6cda4f13f4985c0f5237.1691518314.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:25:35PM +0000, Oleksii Moisieiev wrote:
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
> Changes v3 -> v4
>   - ordered config option alphabetically
>   - ordered object file alphabetically
>   - rephrased PINCTRL_SCMI config description
>   - formatting fixes, removed blank lines after get_drvdata call
>   - code style adjustments
>   - add set_drvdata call
>   - removed goto label
>   - refactoring of the devm resource management
>   - removed pctldev != NULL check
>   - fix parameter name in pinconf-group-get
>   - probe function refactoring
>   - removed unneeded pmx checks
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pinctrl/Kconfig        |  11 +
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 442 +++++++++++++++++++++++++++++++++
>  4 files changed, 455 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-scmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d81d00e5f4f..c4e36f955e53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20527,6 +20527,7 @@ M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	drivers/firmware/arm_scmi/pinctrl.c
> +F:	drivers/pinctrl/pinctrl-scmi.c
>  
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 5787c579dcf6..956cfe76fbc6 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -428,6 +428,17 @@ config PINCTRL_ROCKCHIP
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
> index e196c6e324ad..25d67bac9ee0 100644
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
> index 000000000000..a9304402ddf1
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -0,0 +1,442 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Power Interface (SCMI) Protocol based pinctrl driver
> + *
> + * Copyright (C) 2023 EPAM
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
> +static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev, unsigned int selector)
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
> +#ifdef CONFIG_OF
> +static int pinctrl_scmi_dt_node_to_map(struct pinctrl_dev *pctldev,
> +				       struct device_node *np_config,
> +				       struct pinctrl_map **map,
> +				       u32 *num_maps)
> +{
> +	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
> +					      PIN_MAP_TYPE_INVALID);
> +}
> +
> +static void pinctrl_scmi_dt_free_map(struct pinctrl_dev *pctldev, struct pinctrl_map *map,
> +				     u32 num_maps)
> +{
> +	kfree(map);
> +}
> +
> +#endif /* CONFIG_OF */
> +
> +static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
> +	.get_groups_count = pinctrl_scmi_get_groups_count,
> +	.get_group_name = pinctrl_scmi_get_group_name,
> +	.get_group_pins = pinctrl_scmi_get_group_pins,
> +#ifdef CONFIG_OF
> +	.dt_node_to_map = pinctrl_scmi_dt_node_to_map,
> +	.dt_free_map = pinctrl_scmi_dt_free_map,
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
> +		devm_kcalloc(pmx->dev, *num_groups, sizeof(*pmx->functions[selector].groups),
> +			GFP_KERNEL);
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
> +static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
> +				     unsigned int group)
> +{
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl_ops->mux_set(pmx->ph, selector, group);
> +}
> +
> +static int pinctrl_scmi_request(struct pinctrl_dev *pctldev, unsigned int offset)
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
> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned int _pin,
> +				    unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!config)
> +		return -EINVAL;
> +
> +	config_type = pinconf_to_config_param(*config);
> +
> +	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, config_type, &config_value);
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
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!configs || num_configs == 0)
> +		return -EINVAL;
> +
Here if you re-implement the Pinctrl SCMI protocol with the latest spec
you could pack this into one config_set() with multiple config/values
pair (and let the SCMI Pinctrl protocol to chunk the request in messages
appropriate for the underlying transport size.

Thanks,
Cristian
