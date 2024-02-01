Return-Path: <linux-kernel+bounces-48867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BB846287
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EE41C21B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E6D3EA67;
	Thu,  1 Feb 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B0yD/cQC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E83CF4B;
	Thu,  1 Feb 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822145; cv=none; b=P/xKQuzcwNP8ztHCWomqDR7IlfJGyzJmcFLYjov9ViM8WzyF9G3bJRYS6ZLHo0vyRsfVcS6Om53xexAdrvqoGkvSf6TTJAAFLMoCzcoax19pYMgslZAYiub3hkP/JK4E4+JqZcA1mFANJOE25jDPdFivpvxbIPIgyvTxJaMzZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822145; c=relaxed/simple;
	bh=nbPLVcnpXdoLea02k3RQml8nSOfPIsnduWVK4k874jo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbpk2WT4woUTkoyxbC52wBEumbxMjNq6OcUafZIO6bSzdx8cHeXPx9Lz7gok5detseC2iTZ98xPTS7dGXVN2B9tYb5pv+4+5P+ftwVdeECQOWGBkGcPpBc9R+UCk/vyBEKpw1LUZM9bmJgB+SADOTQnIwHGcO6DbriJ0UvKFgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B0yD/cQC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411LFZbR109972;
	Thu, 1 Feb 2024 15:15:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706822135;
	bh=5WfwU34Z/QUv+EUKQFKyqy3U1KXtaKb6FiXT2xQF4ZE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=B0yD/cQCIJlHgUseRpdYp5HSwIADUq+dS+A1YBLPsJwfgIMX19PelkctcoX5DF63d
	 Mh/KNUe/Od/Wc7MkuF0fQqgddtCxvyuvgzRJm3oD1+WBup+9hXsxxDJMYs9sH714w8
	 2PFTbI3DOFHKB9VXT0ar0JFer4TBnp5Fdbzc91fI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411LFZoH022138
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 15:15:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 15:15:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 15:15:35 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411LFYqQ050473;
	Thu, 1 Feb 2024 15:15:34 -0600
Date: Thu, 1 Feb 2024 15:15:34 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 03/12] power: reset: Add TI-SCI reboot driver
Message-ID: <20240201211534.dv6qu7ila54vqykn@cheating>
References: <20240131221957.213717-1-afd@ti.com>
 <20240131221957.213717-4-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240131221957.213717-4-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:19-20240131, Andrew Davis wrote:
> This reboot driver calls into firmware using TI-SCI to reboot the system.
> We register the handler with low priority as we want PSCI to remain the
> main way these devices are rebooted. This driver acts as a fallback if
> PSCI is not able to reboot the system.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  MAINTAINERS                         |  1 +
>  drivers/power/reset/Kconfig         |  7 ++++
>  drivers/power/reset/Makefile        |  1 +
>  drivers/power/reset/ti-sci-reboot.c | 63 +++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+)
>  create mode 100644 drivers/power/reset/ti-sci-reboot.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 45983bb174fe4..ee67ea497fc56 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21758,6 +21758,7 @@ F:	drivers/clk/keystone/sci-clk.c
>  F:	drivers/firmware/ti_sci*
>  F:	drivers/irqchip/irq-ti-sci-inta.c
>  F:	drivers/irqchip/irq-ti-sci-intr.c
> +F:	drivers/power/reset/ti-sci-reboot.c
>  F:	drivers/reset/reset-ti-sci.c
>  F:	drivers/soc/ti/ti_sci_inta_msi.c
>  F:	drivers/pmdomain/ti/ti_sci_pm_domains.c
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fece990af4a75..d3e91e54cae24 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -205,6 +205,13 @@ config POWER_RESET_ST
>  	help
>  	  Reset support for STMicroelectronics boards.
>  
> +config POWER_RESET_TI_SCI
> +	tristate "TI System Control Interface (TI-SCI) reboot driver"
> +	depends on TI_SCI_PROTOCOL
> +	help
> +	  This enables the reboot driver support over TI System Control
> +	  Interface available on some TI's SoCs.
> +
>  config POWER_RESET_TPS65086
>  	bool "TPS65086 restart driver"
>  	depends on MFD_TPS65086
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index a95d1bd275d18..881ca58a43b9c 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
>  obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
>  obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
> +obj-$(CONFIG_POWER_RESET_TI_SCI) += ti-sci-reboot.o
>  obj-$(CONFIG_POWER_RESET_TPS65086) += tps65086-restart.o
>  obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
>  obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
> diff --git a/drivers/power/reset/ti-sci-reboot.c b/drivers/power/reset/ti-sci-reboot.c
> new file mode 100644
> index 0000000000000..400bd5d740f8b
> --- /dev/null
> +++ b/drivers/power/reset/ti-sci-reboot.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Texas Instrument's System Control Interface (TI-SCI) reboot driver
> + *
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *	Andrew Davis <afd@ti.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +
> +static int ti_sci_reboot_handler(struct sys_off_data *data)
> +{
> +	const struct ti_sci_handle *sci = data->cb_data;
> +	const struct ti_sci_core_ops *core_ops = &sci->ops.core_ops;
> +
> +	core_ops->reboot_device(sci);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int ti_sci_reboot_probe(struct platform_device *pdev)
> +{
> +	const struct ti_sci_handle *sci;
> +	int err;
> +
> +	sci = devm_ti_sci_get_handle(&pdev->dev);
> +	if (IS_ERR(sci))
> +		return PTR_ERR(sci);
> +
> +	err = devm_register_sys_off_handler(&pdev->dev,
> +					    SYS_OFF_MODE_RESTART,
> +					    SYS_OFF_PRIO_LOW,
> +					    ti_sci_reboot_handler,
> +					    (void *)sci);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err, "Cannot register restart handler\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ti_sci_reboot_of_match[] = {
> +	{ .compatible = "ti,sci-reboot", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ti_sci_reboot_of_match);
> +
> +static struct platform_driver ti_sci_reboot_driver = {
> +	.probe = ti_sci_reboot_probe,
> +	.driver = {
> +		.name = "ti-sci-reboot",
> +		.of_match_table = ti_sci_reboot_of_match,
> +	},
> +};
> +module_platform_driver(ti_sci_reboot_driver);
> +
> +MODULE_AUTHOR("Andrew Davis <afd@ti.com>");
> +MODULE_DESCRIPTION("TI System Control Interface (TI SCI) Reboot driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.39.2

Will assume the patch to go via Sebastien. Will be good for the dts to
go via SoC tree. So hoping Sebastien will just pick the driver and
bindings.

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

