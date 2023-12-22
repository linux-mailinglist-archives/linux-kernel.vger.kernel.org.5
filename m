Return-Path: <linux-kernel+bounces-9858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2E81CC76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C4E1F224FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6941241F5;
	Fri, 22 Dec 2023 15:58:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F0241E0;
	Fri, 22 Dec 2023 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB7F2F4;
	Fri, 22 Dec 2023 07:59:08 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 864633F738;
	Fri, 22 Dec 2023 07:58:19 -0800 (PST)
Date: Fri, 22 Dec 2023 15:58:16 +0000
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
Message-ID: <ZYWyGKEZi5YLYeQu@pluto>
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

Hi

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
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include "common.h"
> +#include "protocols.h"
> +
> +/* Updated only after ALL the mandatory features for that version are merged */
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x40000
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
> +
> +enum scmi_pinctrl_protocol_cmd {
> +	PINCTRL_ATTRIBUTES = 0x3,
> +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> +	PINCTRL_CONFIG_GET = 0x5,
> +	PINCTRL_CONFIG_SET = 0x6,
> +	PINCTRL_FUNCTION_SELECT = 0x7,
> +	PINCTRL_REQUEST = 0x8,
> +	PINCTRL_RELEASE = 0x9,
> +	PINCTRL_NAME_GET = 0xa,
> +	PINCTRL_SET_PERMISSIONS = 0xb
> +};
> +
> +struct scmi_msg_conf_set {
> +	__le32 identifier;
> +	__le32 attributes;
> +	__le32 configs[];
> +};
> +
> +struct scmi_msg_conf_get {
> +	__le32 identifier;
> +	__le32 attributes;
> +};
> +
> +struct scmi_resp_conf_get {
> +	__le32 num_configs;
> +	__le32 configs[];
> +};
> +
> +struct scmi_msg_pinctrl_protocol_attributes {
> +	__le32 attributes_low;
> +	__le32 attributes_high;
> +};
> +
> +struct scmi_msg_pinctrl_attributes {
> +	__le32 identifier;
> +	__le32 flags;
> +};
> +
> +struct scmi_resp_pinctrl_attributes {
> +	__le32 attributes;
> +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> +};
> +
> +struct scmi_msg_pinctrl_list_assoc {
> +	__le32 identifier;
> +	__le32 flags;
> +	__le32 index;
> +};
> +
> +struct scmi_resp_pinctrl_list_assoc {
> +	__le32 flags;
> +	__le16 array[];
> +};
> +
> +struct scmi_msg_func_set {
> +	__le32 identifier;
> +	__le32 function_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_msg_request {
> +	__le32 identifier;
> +	__le32 flags;
> +};
> +
> +struct scmi_group_info {
> +	char name[SCMI_MAX_STR_SIZE];
> +	bool present;
> +	unsigned int *group_pins;
> +	unsigned int nr_pins;
> +};
> +
> +struct scmi_function_info {
> +	char name[SCMI_MAX_STR_SIZE];
> +	bool present;
> +	unsigned int *groups;
> +	unsigned int nr_groups;
> +};
> +
> +struct scmi_pin_info {
> +	char name[SCMI_MAX_STR_SIZE];
> +	bool present;
> +};
> +
> +struct scmi_pinctrl_info {
> +	u32 version;
> +	int nr_groups;
> +	int nr_functions;
> +	int nr_pins;
> +	struct scmi_group_info *groups;
> +	struct scmi_function_info *functions;
> +	struct scmi_pin_info *pins;
> +};
> +
> +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
> +				       struct scmi_pinctrl_info *pi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
> +		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
> +		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *ph,
> +				  enum scmi_pinctrl_selector_type type)
> +{
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	switch (type) {
> +	case PIN_TYPE:
> +		return pi->nr_pins;
> +	case GROUP_TYPE:
> +		return pi->nr_groups;
> +	case FUNCTION_TYPE:
> +		return pi->nr_functions;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
> +				    u32 identifier,
> +				    enum scmi_pinctrl_selector_type type)
> +{
> +	int value;
> +
> +	value = scmi_pinctrl_count_get(ph, type);
> +	if (value < 0)
> +		return value;
> +
> +	if (identifier >= value)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u32 selector, char *name,
> +				   unsigned int *n_elems)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_attributes *tx;
> +	struct scmi_resp_pinctrl_attributes *rx;
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx), sizeof(*rx), &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	rx = t->rx.buf;
> +	tx->identifier = cpu_to_le32(selector);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		if (n_elems)
> +			*n_elems = NUM_ELEMS(rx->attributes);
> +
> +		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	/*
> +	 * If supported overwrite short name with the extended one;
> +	 * on error just carry on and use already provided short name.
> +	 */
> +	if (!ret && EXT_NAME_FLAG(rx->attributes))
> +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> +					    (u32 *)&type, name,
> +					    SCMI_MAX_STR_SIZE);
> +	return ret;
> +}
> +
> +struct scmi_pinctrl_ipriv {
> +	u32 selector;
> +	enum scmi_pinctrl_selector_type type;
> +	unsigned int *array;
> +};
> +
> +static void iter_pinctrl_assoc_prepare_message(void *message,
> +					       unsigned int desc_index,
> +					       const void *priv)
> +{
> +	struct scmi_msg_pinctrl_list_assoc *msg = message;
> +	const struct scmi_pinctrl_ipriv *p = priv;
> +
> +	msg->identifier = cpu_to_le32(p->selector);
> +	msg->flags = cpu_to_le32(p->type);
> +	/* Set the number of OPPs to be skipped/already read */
> +	msg->index = cpu_to_le32(desc_index);
> +}
> +
> +static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
> +					   const void *response, void *priv)
> +{
> +	const struct scmi_resp_pinctrl_list_assoc *r = response;
> +
> +	st->num_returned = RETURNED(r->flags);
> +	st->num_remaining = REMAINING(r->flags);
> +
> +	return 0;
> +}
> +
> +static int
> +iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
> +				    const void *response,
> +				    struct scmi_iterator_state *st, void *priv)
> +{
> +	const struct scmi_resp_pinctrl_list_assoc *r = response;
> +	struct scmi_pinctrl_ipriv *p = priv;
> +
> +	p->array[st->desc_index + st->loop_idx] =
> +		le16_to_cpu(r->array[st->loop_idx]);
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
> +					  u32 selector,
> +					  enum scmi_pinctrl_selector_type type,
> +					  u16 size, unsigned int *array)
> +{
> +	int ret;
> +	void *iter;
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_pinctrl_assoc_prepare_message,
> +		.update_state = iter_pinctrl_assoc_update_state,
> +		.process_response = iter_pinctrl_assoc_process_response,
> +	};
> +	struct scmi_pinctrl_ipriv ipriv = {
> +		.selector = selector,
> +		.type = type,
> +		.array = array,
> +	};
> +
> +	if (!array || !size || type == PIN_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, size,
> +					    PINCTRL_LIST_ASSOCIATIONS,
> +					    sizeof(struct scmi_msg_pinctrl_list_assoc),
> +					    &ipriv);
> +
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +struct scmi_conf_get_ipriv {
> +	u32 selector;
> +	enum scmi_pinctrl_selector_type type;
> +	u8 all;
> +	u8 *config_types;
> +	unsigned long *config_values;
> +};
> +
> +static void iter_pinctrl_conf_get_prepare_message(void *message,
> +						  unsigned int desc_index,
> +						  const void *priv)
> +{
> +	struct scmi_msg_conf_get *msg = message;
> +	const struct scmi_conf_get_ipriv *p = priv;
> +	u32 attributes;
> +
> +	msg->identifier = cpu_to_le32(p->selector);
        ^^^^^

> +	attributes = FIELD_PREP(BIT(18), p->all) |
> +		     FIELD_PREP(GENMASK(17, 16), p->type);
> +
> +	if (p->all)
> +		attributes |= FIELD_PREP(GENMASK(15, 8), desc_index);
> +	else
> +		attributes |= FIELD_PREP(GENMASK(7, 0), p->config_types[0]);
> +
> +	msg->attributes = cpu_to_le32(attributes);
> +	msg->identifier = cpu_to_le32(p->selector);
Duplicated .. see above ^^^^

> +}
> +
> +static int iter_pinctrl_conf_get_update_state(struct scmi_iterator_state *st,
> +					      const void *response, void *priv)
> +{
> +	const struct scmi_resp_conf_get *r = response;
> +
> +	st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
> +	st->num_remaining = le32_get_bits(r->num_configs, GENMASK(31, 24));
> +

You use the same iterators for both config_get and config_get_all() with proper
conditional ifs (and that is fine) BUT also here you should take care of
the case in which !p->all because in such a case the spec says that the
r->num_configs field should be ignored, which means that the platform
could return 0 or garbage, and you should assume insetad that

      if (!p->all) {
      		st->num_returned = 1;
		st->num_remaining = 0;
      }

...if not the iterator could not work.

(I still have to emulate and test this on my setup though...but at first
sight it is out of spec as it is now...)

> +	return 0;
> +}
> +
> +static int iter_pinctrl_conf_get_process_response(const struct scmi_protocol_handle *ph,
> +						  const void *response,
> +						  struct scmi_iterator_state *st, void *priv)
> +{
> +	const struct scmi_resp_conf_get *r = response;
> +	struct scmi_conf_get_ipriv *p = priv;
> +
> +	if (!p->all) {
> +		if (p->config_types[0] !=
> +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> +			return -EINVAL;
> +	} else {
> +		p->config_types[st->desc_index + st->loop_idx] =
> +			le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0));
> +	}
> +
> +	p->config_values[st->desc_index + st->loop_idx] =
> +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
> +				   u32 selector,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u8 config_type, unsigned long *config_value)
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
> +		.all = 0,
> +		.config_types = &config_type,
> +		.config_values = config_value,
> +	};
> +
> +	if (!config_value || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_CONFIG_GET,
> +					    sizeof(struct scmi_msg_conf_get),
> +					    &ipriv);
> +
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +static int scmi_pinctrl_config_get_all(const struct scmi_protocol_handle *ph,
> +				       u32 selector,
> +				       enum scmi_pinctrl_selector_type type,
> +				       u16 size, u8 *config_types,
> +				       unsigned long *config_values)
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
> +	while (conf_num < nr_configs) {
> +		chunk = (nr_configs - conf_num > configs_in_chunk) ? configs_in_chunk :
> +			nr_configs - conf_num;
> +
> +		ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_SET,
> +					      sizeof(*tx) + chunk * 2 * sizeof(unsigned long),
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

The chunking seems good to me till here, BUT these last lines should not be like:

> +		for (i = 0; i < chunk; i++) {
> +			tx->configs[i * 2] = cpu_to_le32(pinconf_to_config_param(configs[i]));

			tx->configs[i * 2] = cpu_to_le32(pinconf_to_config_param(configs[conf_num + i]));

> +			tx->configs[i * 2 + 1] =
> +				cpu_to_le32(pinconf_to_config_argument(configs[i]));

				cpu_to_le32(pinconf_to_config_argument(configs[conf_num + i]));

..sice you are indexing the provided configs inside a chunk loop ?
(still to be properly 'fully' tested too...)

> +		}
> +
> +		ret = ph->xops->do_xfer(ph, t);
> +
> +		ph->xops->xfer_put(ph, t);
> +
> +		if (ret)
> +			break;
> +
> +		conf_num += chunk;
> +	}
> +
> +	return ret;
> +}

As said, I'll plan to exercise a bit more these interfaces directly BUT
as it is now my basic test case using the original generic pinctrl scmi
driver is still working after these latest changes.

Thanks,
Cristian

