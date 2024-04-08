Return-Path: <linux-kernel+bounces-135184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F889BC66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C99B21BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD54DA03;
	Mon,  8 Apr 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CfmJXQ22"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45304CE09;
	Mon,  8 Apr 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569995; cv=none; b=TzZA/FAaR3h6+FaSfij+7kMoYvlFkcYAb6GkOnLkkzR6QEkfg07J8xOJbLDprf7mEasSXL6gdYF9uWnKu8N2VK0BkgOPAZ8ArXWq4wJnKFuY/SS8ICwM5RLUYYZxeUu4dOC/E7kvBWMzOcQ40iqxeVtEBsx4H3cjKAAn2rp3zcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569995; c=relaxed/simple;
	bh=3dqG+MDn1fmztumZBMOjS1/9HGAOWrrlqo4qQcvep5s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUfUqSNMNT2eN0dcSnYMG2XNlHSTWdSQ7Qb+ADr8mE/aQbMAw2m5AyUptp3tMerbO1fbwoZtlbwBvx1NVe2j99WNzlIZXctoiiGO0Yn+b7Z8R2eXKILvIkKoj2UoXAGQtguWAJAfQ085ji8wY3+mTZBEn8B2DLAHM6gy3JNdv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CfmJXQ22; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4389qdT0076431;
	Mon, 8 Apr 2024 04:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712569959;
	bh=Ekb1pkDDGqHOyOnzyNQhFpv72C8vwJHWI0nwrs8xuaw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CfmJXQ22AeV3y3eBhVd7WzQrE4X0cCy8BZxAB5eoQUr1m1U/l/QIAE8F3WtckYkQt
	 U7zxLvisfTaPA/Wx1SNGOxiQ9ASCntZH3no72mtcGcbzz/0BkvV1V72Pmv8kVWzMaJ
	 ZyNLlthbehUHvJlEcSlqitggMbQjklkKbMzBYL84=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4389qdjH128840
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 04:52:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 04:52:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 04:52:38 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4389qbNk039561;
	Mon, 8 Apr 2024 04:52:38 -0500
Date: Mon, 8 Apr 2024 15:22:37 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Oleksii Moisieiev
	<oleksii_moisieiev@epam.com>,
        Tony Lindgren <tony@atomide.com>, Kevin Hilman
	<khilman@baylibre.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v8 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <20240408095237.fc7dldg5qrlsoojt@dhruva>
References: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
 <20240405-pinctrl-scmi-v8-4-5fc8e33871bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405-pinctrl-scmi-v8-4-5fc8e33871bf@nxp.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Apr 05, 2024 at 09:59:35 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.
> 
> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pinctrl/Kconfig        |  11 +
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 564 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 577 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b511a55101c..d8270ac6651a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21457,6 +21457,7 @@ F:	drivers/cpufreq/sc[mp]i-cpufreq.c
>  F:	drivers/firmware/arm_scmi/
>  F:	drivers/firmware/arm_scpi.c
>  F:	drivers/hwmon/scmi-hwmon.c
> +F:	drivers/pinctrl/pinctrl-scmi.c
>  F:	drivers/pmdomain/arm/
>  F:	drivers/powercap/arm_scmi_powercap.c
>  F:	drivers/regulator/scmi-regulator.c
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index d45657aa986a..4e6f65cf0e76 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -450,6 +450,17 @@ config PINCTRL_ROCKCHIP
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
> index 2152539b53d5..cc809669405a 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
>  obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
>  obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
>  obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
> +obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
>  obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
>  obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
>  obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> new file mode 100644
> index 000000000000..0f55f000a679
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -0,0 +1,564 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Power Interface (SCMI) Protocol based pinctrl driver
> + *
> + * Copyright (C) 2024 EPAM
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
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
> +struct scmi_pinctrl {
> +	struct device *dev;
> +	struct scmi_protocol_handle *ph;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_desc pctl_desc;
> +	struct pinfunction *functions;
> +	unsigned int nr_functions;
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
> +					    const char * const **p_groups,
> +					    unsigned int * const p_num_groups)
> +{
> +	struct pinfunction *func;
> +	const unsigned int *group_ids;
> +	unsigned int num_groups;
> +	const char **groups;
> +	int ret, i;

Just a nit maybe, but I would be more comfortable making i with
num_groups as unsigned, because you're comparing them after all in the
loop. Also, I don't see a reason for i to become negative in any case.

> +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!p_groups || !p_num_groups)
> +		return -EINVAL;
> +
> +	if (selector >= pmx->nr_functions)
> +		return -EINVAL;
> +
> +	func = &pmx->functions[selector];
> +	if (func->ngroups)
> +		goto done;
> +
> +	ret = pinctrl_ops->function_groups_get(pmx->ph, selector, &num_groups,
> +					       &group_ids);
> +	if (ret) {
> +		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
> +		return ret;
> +	}
> +	if (!num_groups)
> +		return -EINVAL;
> +
> +	groups = kcalloc(num_groups, sizeof(*groups), GFP_KERNEL);
> +	if (!groups)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_groups; i++) {
> +		groups[i] = pinctrl_scmi_get_group_name(pctldev, group_ids[i]);
> +		if (!groups[i]) {
> +			ret = -EINVAL;
> +			goto err_free;
> +		}
> +	}
> +
> +	func->ngroups = num_groups;
> +	func->groups = groups;
> +done:
> +	*p_groups = func->groups;
> +	*p_num_groups = func->ngroups;
> +
> +	return 0;
> +
> +err_free:
> +	kfree(groups);
> +
> +	return ret;
> +}
> +
[...]
> +
> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 struct pinctrl_desc *desc)
> +{
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int npins;
> +	int ret, i;

better unsigned i?

> +
> +	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> +	/*
> +	 * npins will never be zero, the scmi pinctrl driver has bailed out
> +	 * if npins is zero.
> +	 */
> +	pins = devm_kmalloc_array(pmx->dev, npins, sizeof(*pins), GFP_KERNEL);
> +	if (!pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < npins; i++) {
> +		pins[i].number = i;
> +		/*
> +		 * The memory for name is handled by the scmi firmware driver,
> +		 * no need free here
> +		 */
> +		ret = pinctrl_ops->name_get(pmx->ph, i, PIN_TYPE, &pins[i].name);
> +		if (ret)
> +			return dev_err_probe(pmx->dev, ret,
> +					     "Can't get name for pin %d", i);
> +	}
> +
> +	desc->npins = npins;
> +	desc->pins = pins;
> +	dev_dbg(pmx->dev, "got pins %u", npins);
> +
> +	return 0;
> +}
> +
[...]

Unrelated and beyond scope of this patch series, but would've loved to
see concept of wakeup enable and wakeup event bits inside the pinctrl
SCMI spec like we have in pinctrl-single kernel driver. There are SOC's
out there that support wakeup IRQ's from their padconfig controllers
itself... But this is more of a feedback for the SCMI spec. Maybe a
future revision can take care of this.

The reason this needs to be
standard and not something vendor specific is because the kernel does
support a wake IRQ framework, and we will need to make this driver have
wake IRQ support if a device that supports pinctrl wakeup need to use
scmi to configure it.
Look at Table 6-2045. Description Of The Pad Configuration Register Bit
in [0] for further details for an example of a padconfig wakeup config
specially bits 29,30.

No major comments otherwise,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

[0] https://www.ti.com/lit/pdf/SPRUIV7

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

