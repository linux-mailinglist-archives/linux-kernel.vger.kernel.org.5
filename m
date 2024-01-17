Return-Path: <linux-kernel+bounces-29368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81357830D54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A817281E03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE451249F5;
	Wed, 17 Jan 2024 19:38:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71A1E877;
	Wed, 17 Jan 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520332; cv=none; b=gG7dE7pTB29Nh7+jq1h42q/L9EXLXxix8iI9P4Oc7HGFZgBDk9qBxsKZbIGqaTOnvW7t7sB0XD/gyiWdwiEKiw5NilZTkg7GIu1uI8aR1QSgBIyiQLgjqsAkLfR0gDzP6YM9CYfVUyR4s24YlGaq/83/8XwbnREWR2bAiq2oRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520332; c=relaxed/simple;
	bh=qQ2aC4nPMxreqaxf3HfplVIIaem0J4U9g997mzbSJjk=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=QPKi+JSRPVty+5qVA53iHTEuJEha3GPV7hqXOHxZKH6ogrNXxTinGpn6QQfKhl7nCwfKxOGK4YFZlK+dJS0Oxay5AJ+FCI6AS+lysuHLpILtIrUKUXWd7nxb92Xw4Ttr75f7rfSzhPAqaG2aUDMTKoN4Dm1OH1xPRcFvOMoIIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 889F111FB;
	Wed, 17 Jan 2024 11:39:34 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C77F3F766;
	Wed, 17 Jan 2024 11:38:46 -0800 (PST)
Date: Wed, 17 Jan 2024 19:38:44 +0000
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
Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZagsxLBw3eZCpafI@pluto>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
 <20240104-pinctrl-scmi-v2-3-a9bd86ab5a84@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-pinctrl-scmi-v2-3-a9bd86ab5a84@nxp.com>

On Thu, Jan 04, 2024 at 06:48:47PM +0800, Peng Fan (OSS) wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
> 
> Add basic implementation of the SCMI v3.2 pincontrol protocol.

Hi Peng,

a few minor remarks below but this LGTM, and in my testing I could not
find any issue/misbehaviour at the protocol layer (i.e. stressing pinctrl_ops)

In general, can we stick to 80cols ? since it is how the SCMI stack is
currently formatted and this patch introduced just few minor lomng lines
that can be easily wrapped by moving a few params (or return types) on a
new line....

..but only when this does not render the thing unreadable of course, I
mean just in the obvious places where it is just a matter of hitting a
Return :D

> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Co-developed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

[nitpick]: I have a silly spelling mistakes on email from checkpatch

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>' != 'Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

> ---
>  MAINTAINERS                           |   6 +
>  drivers/firmware/arm_scmi/Makefile    |   1 +
>  drivers/firmware/arm_scmi/driver.c    |   2 +
>  drivers/firmware/arm_scmi/pinctrl.c   | 930 ++++++++++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |   1 +
>  include/linux/scmi_protocol.h         |  73 +++
>  6 files changed, 1013 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0275a2c58f0f..487bff0d44c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21322,6 +21322,12 @@ F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
>  F:	include/uapi/linux/virtio_scmi.h
>  
> +SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) PINCTRL DRIVER
> +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/arm_scmi/pinctrl.c
> +

I've got to check this with Sudeep since giving exclusive maintainership
of this bit could lead to troubles if the assigned maintainer becomes
unresponsive, and it seems this is already the case indeed even before
this thing is merged. Oleksii and EPAM will anyway maintain authorship
in any case; I'll check with Sudeep, as said.

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
> index a12afc254afa..4c3752749105 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3050,6 +3050,7 @@ static int __init scmi_driver_init(void)
>  	scmi_voltage_register();
>  	scmi_system_register();
>  	scmi_powercap_register();
> +	scmi_pinctrl_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3067,6 +3068,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_voltage_unregister();
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
> +	scmi_pinctrl_unregister();
>  
>  	scmi_transports_exit();
>  
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> new file mode 100644
> index 000000000000..aa6e698e7b7c
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -0,0 +1,930 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Pinctrl Protocol
> + *
> + * Copyright (C) 2023 EPAM

2023-2024

> + */
> +
> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include "common.h"
> +#include "protocols.h"
> +
> +/* Updated only after ALL the mandatory features for that version are merged */
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x40000

Why 0x40000, this should be 0x10000 I think looking at SCMI Pinctrl on v3.2-bet3,
BUT there are still other missing (minor) features as of now related to v3.2-bet3
(that impacts on all protocols like NEGOTIATE_PROTOCOL) and I will add those missing
feats in the SCMI core shortly in the upcoming weeks.

So, for the moment I would set this to 0x0, and I will bump it up to 0x10000
when the still missing v3.2-bet3 features are all in, because if not we would
be lying here saying that we now support Pinctrl 0x10000, while instead
something is still missing.

> +
> +#define REG_TYPE_BITS GENMASK(9, 8)
> +#define REG_CONFIG GENMASK(7, 0)
> +
> +#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
> +#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
> +#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> +
> +#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
> +#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
> +
> +#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
> +#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))

[snip]

> +
> +static int scmi_pinctrl_config_get_all(const struct scmi_protocol_handle *ph,
> +				       u32 selector,
> +				       enum scmi_pinctrl_selector_type type,
> +				       u16 size, u8 *config_types,
> +				       u32 *config_values)

This function is a bit odd, since you provide a pair of arrays and their
size to fetch all the results BUT there is no way, agfter the call, to know how
many valid results have been filled in the array, so it is a bit difficult
to use properly (given also that 0/0 is a valid config/val pair), BUT on the
other side I cannot see this being called from anywhere as of now, so I think
it can be left as it is and maybe will fix in the future when needed.

Another option could be to drop it, but it worked fine anyway when tested, and
needs only a minor fix (as said above) so I would keep even though unused.

Up to you. No strong opinion since it does not misbehave anyway, it is
just awkward a bit...

> +{
> +	int ret;
> +	void *iter;
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_pinctrl_conf_get_prepare_message,
> +		.update_state = iter_pinctrl_conf_get_update_state,
> +		.process_response = iter_pinctrl_conf_get_process_response,
> +	};
> +	struct scmi_conf_get_ipriv ipriv = {
> +		.selector = selector,
> +		.type = type,
> +		.all = 1,
> +		.config_types = config_types,
> +		.config_values = config_values,
> +	};
> +
> +	if (!config_values || !config_types || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, size, PINCTRL_CONFIG_GET,
> +					    sizeof(struct scmi_msg_conf_get),
> +					    &ipriv);
> +
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}

[snip]

>  DECLARE_SCMI_REGISTER_UNREGISTER(reset);
>  DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index f2f05fb42d28..d8e2bb828ee7 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -717,6 +717,78 @@ struct scmi_powercap_proto_ops {
>  					  u32 *power_thresh_high);
>  };
>  
> +enum scmi_pinctrl_selector_type {
> +	PIN_TYPE = 0,
> +	GROUP_TYPE,
> +	FUNCTION_TYPE,
> +};
> +
> +/**
> + * struct scmi_pinctrl_proto_ops - represents the various operations provided
> + * by SCMI Pinctrl Protocol
> + *
> + * @count_get: returns count of the registered elements in given type
> + * @name_get: returns name by index of given type
> + * @group_pins_get: returns the set of pins, assigned to the specified group
> + * @function_groups_get: returns the set of groups, assigned to the specified
> + *	function
> + * @mux_set: set muxing function for groups of pins
> + * @config_get: returns configuration parameter for pin or group
> + * @config_set: sets the configuration parameter for pin or group
> + * @pin_request: aquire pin before selecting mux setting
> + * @pin_free: frees pin, acquired by request_pin call
> + */
> +struct scmi_pinctrl_proto_ops {
> +	int (*count_get)(const struct scmi_protocol_handle *ph,
> +			 enum scmi_pinctrl_selector_type type);
> +	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
> +			enum scmi_pinctrl_selector_type type, const char **name);
> +	int (*group_pins_get)(const struct scmi_protocol_handle *ph, u32 selector,
> +			      const unsigned int **pins, unsigned int *nr_pins);
> +	int (*function_groups_get)(const struct scmi_protocol_handle *ph, u32 selector,
> +				   unsigned int *nr_groups, const unsigned int **groups);
> +	int (*mux_set)(const struct scmi_protocol_handle *ph, u32 selector, u32 group);
> +	int (*config_get)(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  u8 config_type, u32 *config_value);
> +	int (*config_get_all)(const struct scmi_protocol_handle *ph,
> +			      u32 selector,
> +			      enum scmi_pinctrl_selector_type type, u16 size,
> +			      u8 *config_types, u32 *config_values);
> +	int (*config_set)(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  unsigned int nr_configs,
> +			  u8 *config_type, u32 *config_value);
> +	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
> +	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
> +};
> +
> +enum scmi_pinctrl_conf_type {
> +	SCMI_PIN_NONE = 0x0,
> +	SCMI_PIN_BIAS_BUS_HOLD = 0x1,
> +	SCMI_PIN_BIAS_DISABLE = 0x2,
> +	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 0x3,
> +	SCMI_PIN_BIAS_PULL_UP = 0x4,
> +	SCMI_PIN_BIAS_PULL_DEFAULT = 0x5,
> +	SCMI_PIN_BIAS_PULL_DOWN = 0x6,
> +	SCMI_PIN_DRIVE_OPEN_DRAIN = 0x7,
> +	SCMI_PIN_DRIVE_OPEN_SOURCE = 0x8,
> +	SCMI_PIN_DRIVE_PUSH_PULL = 0x9,
> +	SCMI_PIN_DRIVE_STRENGTH = 0xA,
> +	SCMI_PIN_INPUT_DEBOUNCE = 0xB,
> +	SCMI_PIN_INPUT_MODE = 0xC,
> +	SCMI_PIN_PULL_MODE = 0xD,
> +	SCMI_PIN_INPUT_VALUE = 0xE,
> +	SCMI_PIN_INPUT_SCHMITT = 0xF,
> +	SCMI_PIN_LOW_POWER_MODE = 0x10,
> +	SCMI_PIN_OUTPUT_MODE = 0x11,
> +	SCMI_PIN_OUTPUT_VALUE = 0x12,
> +	SCMI_PIN_POWER_SOURCE = 0x13,
> +	SCMI_PIN_SLEW_RATE = 0x20,
> +	SCMI_PIN_OEM_START = 0xC0,
> +	SCMI_PIN_OEM_END = 0xFF,
> +};

Can you move this enum above the pinctrl_proto_ops for consistency?

Maybe use it in the ops prototype as the type of config_type param or
is there a reason to stick with u8 config_type even having the enum ?
We anyway place a u32 in the message at the end, so it does not seem
any gain in size.

Thanks,
Cristian

