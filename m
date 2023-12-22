Return-Path: <linux-kernel+bounces-9903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CD81CD12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393F41F23E65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331EB250EC;
	Fri, 22 Dec 2023 16:26:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600125542;
	Fri, 22 Dec 2023 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38260C15;
	Fri, 22 Dec 2023 08:27:14 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143433F738;
	Fri, 22 Dec 2023 08:26:24 -0800 (PST)
Date: Fri, 22 Dec 2023 16:26:22 +0000
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
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/7] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZYW4rgVoh5uOo6g_@pluto>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-5-0fe35e4611f7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-pinctrl-scmi-v1-5-0fe35e4611f7@nxp.com>

On Fri, Dec 15, 2023 at 07:56:33PM +0800, Peng Fan (OSS) wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> Add basic implementation of the SCMI v3.2 pincontrol protocol.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Co-developed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS                           |   6 +
>  drivers/firmware/arm_scmi/Makefile    |   1 +
>  drivers/firmware/arm_scmi/driver.c    |   2 +
>  drivers/firmware/arm_scmi/pinctrl.c   | 927 ++++++++++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |   1 +
>  include/linux/scmi_protocol.h         |  46 ++
>  6 files changed, 983 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b589218605b4..8d971adeee22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21180,6 +21180,12 @@ F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
>  F:	include/uapi/linux/virtio_scmi.h
>  
> +SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) PINCTRL DRIVER
> +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/arm_scmi/pinctrl.c
> +
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index a7bc4796519c..8e3874ff1544 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> +scmi-protocols-y += pinctrl.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3174da57d832..1cf9f5d4f7bd 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3057,6 +3057,7 @@ static int __init scmi_driver_init(void)
>  	scmi_voltage_register();
>  	scmi_system_register();
>  	scmi_powercap_register();
> +	scmi_pinctrl_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3074,6 +3075,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_voltage_unregister();
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
> +	scmi_pinctrl_unregister();
>  
>  	scmi_transports_exit();
>  
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> new file mode 100644
> index 000000000000..a25c8edcedd2
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -0,0 +1,927 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Pinctrl Protocol
> + *
> + * Copyright (C) 2023 EPAM
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pinctrl/pinconf-generic.h>

I spotted this only later while looking at the SCMI Pinctrl driver...

...Get rid of this and please make these conversions in the SCMI pinctrl driver
NOT here in the protocol layer....these ops should receive SCMI valid requests
and should not have any need to invoke some other subsystem helpers to
pack/unpack.

See below..


> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

[snip]

> +
> +static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
> +				   u32 selector,
> +				   enum scmi_pinctrl_selector_type type,
> +				   unsigned long *configs, unsigned int nr_configs)
> +{
> +	struct scmi_xfer *t;
> +	struct scmi_msg_conf_set *tx;
> +	u32 attributes;
> +	int ret, i;
> +	unsigned int configs_in_chunk, conf_num = 0;
> +	unsigned int chunk;
> +	int max_msg_size = ph->hops->get_max_msg_size(ph);
> +
> +	if (!configs || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(unsigned long) * 2);
									^^
									sizeof(__le32))
> +	while (conf_num < nr_configs) {
> +		chunk = (nr_configs - conf_num > configs_in_chunk) ? configs_in_chunk :
> +			nr_configs - conf_num;
> +
> +		ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
> +					      sizeof(*tx) + chunk * 2 * sizeof(unsigned long),

									^^
									sizeof(__le32))
> +					      0, &t);
> +		if (ret)
> +			return ret;
> +
> +		tx = t->tx.buf;
> +		tx->identifier = cpu_to_le32(selector);
> +		attributes = FIELD_PREP(GENMASK(1, 0), type) |
> +			FIELD_PREP(GENMASK(9, 2), chunk);
> +		tx->attributes = cpu_to_le32(attributes);
> +
> +		for (i = 0; i < chunk; i++) {
> +			tx->configs[i * 2] = cpu_to_le32(pinconf_to_config_param(configs[i]));

This should be the bare config_type as received already in SCMI format
as a param.

> +			tx->configs[i * 2 + 1] =
> +				cpu_to_le32(pinconf_to_config_argument(configs[i]));

and here the config_values...this also means you will have to change the
parameters to this function to pass a

	uint8_t *config_types
	uint32_t *config_values
	unsigne int num_configs

or something like that....there is also a subtle need to remap the types
from Pinctrl to SCMI in the pinctrl SCMI driver (I commented this on
that patch)

Thanks,
Cristian

