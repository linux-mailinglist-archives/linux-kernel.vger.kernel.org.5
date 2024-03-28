Return-Path: <linux-kernel+bounces-123185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41408903D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E321F24DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E796130E5A;
	Thu, 28 Mar 2024 15:47:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1382D66;
	Thu, 28 Mar 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640844; cv=none; b=LEzbUcvNz0yNEyNxukUtkojdQLTOc3lDZ3ENSYOy6/+mlKdJ/Qxm/IojHs2k9hMN5L7S+ptvZ58AMHTziNVUNgnBrocCdbieG8XRNN5GfRyvTmA+TebqEgIOTQkbSY0sQZ6zIerI8MN1mDXOej6ImE+MIueSAis2zVAbj8DBFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640844; c=relaxed/simple;
	bh=uyMfSGS98sMzGFjuta02pbrMDMcQ4e1nTLL0uafG/4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UngnQ+nUTHmnapb3CGnJsRROWYzklXls2C+IAKojvfoGvBX863AHXqVyfNOHpft/o/2PnWJ0lBvTvcdkoH1XdNtNQdzlLeNcC7f1S0r+LdjqsHEJLQAqcvz/UqSmTXV+pr/1WFNgxkWC/DFcR5CGQYY6JbIyaZTFbWtelY9k9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67C861476;
	Thu, 28 Mar 2024 08:47:53 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED893F7BD;
	Thu, 28 Mar 2024 08:47:17 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:47:15 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgWRA2V3PF_q9yRM@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>

On Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add basic implementation of the SCMI v3.2 pincontrol protocol.
> 

Hi,

a few more comments down below...

> Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/Makefile    |   1 +
>  drivers/firmware/arm_scmi/driver.c    |   2 +
>  drivers/firmware/arm_scmi/pinctrl.c   | 921 ++++++++++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |   1 +
>  include/linux/scmi_protocol.h         |  75 +++
>  5 files changed, 1000 insertions(+)
> 
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
> index 415e6f510057..ac2d4b19727c 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3142,6 +3142,7 @@ static int __init scmi_driver_init(void)
>  	scmi_voltage_register();
>  	scmi_system_register();
>  	scmi_powercap_register();
> +	scmi_pinctrl_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3159,6 +3160,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_voltage_unregister();
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
> +	scmi_pinctrl_unregister();
>  
>  	scmi_transports_exit();
>  
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> new file mode 100644
> index 000000000000..87d9b89cab13
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -0,0 +1,921 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Pinctrl Protocol
> + *
> + * Copyright (C) 2024 EPAM
> + * Copyright 2024 NXP
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
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x0
> +

AFAICS, the only missing things are PINCTRL_SET_PERMISSIONS (optional command)
and the multiple-configs on SETTINGS_GET, but this latter is something really
that we have to ask for in the request AND we did not as of now since we dont
need it...so I would say to bump the version to 0x10000 just to avoid needless
warning as soon as a server supporting Pinctrl is met.

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
> +#define CONFIG_FLAG_MASK	GENMASK(19, 18)
> +#define SELECTOR_MASK		GENMASK(17, 16)
> +#define SKIP_CONFIGS_MASK	GENMASK(15, 8)
> +#define CONFIG_TYPE_MASK	GENMASK(7, 0)
> +
> +enum scmi_pinctrl_protocol_cmd {
> +	PINCTRL_ATTRIBUTES = 0x3,
> +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> +	PINCTRL_SETTINGS_GET = 0x5,
> +	PINCTRL_SETTINGS_CONFIGURE = 0x6,
> +	PINCTRL_REQUEST = 0x7,
> +	PINCTRL_RELEASE = 0x8,
> +	PINCTRL_NAME_GET = 0x9,
> +	PINCTRL_SET_PERMISSIONS = 0xa
> +};
> +
> +struct scmi_msg_settings_conf {
> +	__le32 identifier;
> +	__le32 function_id;
> +	__le32 attributes;
> +	__le32 configs[];
> +};
> +
> +struct scmi_msg_settings_get {
> +	__le32 identifier;
> +	__le32 attributes;
> +};
> +
> +struct scmi_resp_settings_get {
> +	__le32 function_selected;
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

As said by Dan...drop this.

> +struct scmi_msg_request {
> +	__le32 identifier;
> +	__le32 flags;
> +};
> +
> +struct scmi_group_info {
> +	char name[SCMI_MAX_STR_SIZE];
> +	bool present;
> +	u32 *group_pins;
> +	u32 nr_pins;
> +};
> +
> +struct scmi_function_info {
> +	char name[SCMI_MAX_STR_SIZE];
> +	bool present;
> +	u32 *groups;
> +	u32 nr_groups;
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
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr),
> +				      &t);
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

I was thinking, does make sense to allow a nr_pins == 0 setup to probe
successfully ? Becasuse is legit for the platform to return zero groups or
zero functions BUT zero pins is just useless (spec does not say
anything)

Maybe you could just put a dev_warn() here on if (nr_pins == 0) and bail
out with -EINVAL...

On the other side looking at the zero groups/function case, that is
plausible and handled properly by the driver since a 0-bytes
devm_kcalloc will return ZERO_SIZE_PTR (not NULL) and all the remaining
references to pinfo->groups and pinfo->functions are guarded by a check
on selector >= nr_groups (or >= nr_functions), and by scmi_pinctrl_validate_id()
so the zero grouyps/fuctions scenarios should be safely handled.

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
> +				   u32 *n_elems)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_pinctrl_attributes *tx;
> +	struct scmi_resp_pinctrl_attributes *rx;
> +	u32 ext_name_flag;

what about a bool

> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> +				      sizeof(*rx), &t);
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
> +
> +		ext_name_flag = EXT_NAME_FLAG(rx->attributes);
> +	} else
> +		ext_name_flag = 0;

and you dont need this else branch to set ext_name_flag to false, since down
below you will check ext_flag ONLY if !ret, so it will have surely been
set if the do_xfer did not fail.

> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	/*
> +	 * If supported overwrite short name with the extended one;
> +	 * on error just carry on and use already provided short name.
> +	 */
> +	if (!ret && ext_name_flag)
> +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
> +					    (u32 *)&type, name,
> +					    SCMI_MAX_STR_SIZE);
> +	return ret;
> +}
> +
> +struct scmi_pinctrl_ipriv {
> +	u32 selector;
> +	enum scmi_pinctrl_selector_type type;
> +	u32 *array;
> +};
> +
> +static void iter_pinctrl_assoc_prepare_message(void *message,
> +					       u32 desc_index,
> +					       const void *priv)
> +{
> +	struct scmi_msg_pinctrl_list_assoc *msg = message;
> +	const struct scmi_pinctrl_ipriv *p = priv;
> +
> +	msg->identifier = cpu_to_le32(p->selector);
> +	msg->flags = cpu_to_le32(p->type);
> +	/* Set the number of OPPs to be skipped/already read */

OPP ? .. maybe drop this comment that was cut/pasted from somewhere else :D

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
> +					  u16 size, u32 *array)
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
> +struct scmi_settings_get_ipriv {
> +	u32 selector;
> +	enum scmi_pinctrl_selector_type type;
> +	u32 flag;
> +	enum scmi_pinctrl_conf_type *config_types;
> +	u32 *config_values;
> +};
> +
> +static void
> +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_index,
> +					  const void *priv)
> +{
> +	struct scmi_msg_settings_get *msg = message;
> +	const struct scmi_settings_get_ipriv *p = priv;
> +	u32 attributes;
> +
> +	attributes = FIELD_PREP(CONFIG_FLAG_MASK, p->flag) |
> +		     FIELD_PREP(SELECTOR_MASK, p->type);
> +
> +	if (p->flag == 1)

A boolean like .get_all would be more clear..see down below why you dont need
a flag 0|1|2

> +		attributes |= FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> +	else if (!p->flag)
> +		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);
> +
> +	msg->attributes = cpu_to_le32(attributes);
> +	msg->identifier = cpu_to_le32(p->selector);
> +}
> +
> +static int
> +iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
> +				       const void *response, void *priv)
> +{
> +	const struct scmi_resp_settings_get *r = response;
> +	struct scmi_settings_get_ipriv *p = priv;
> +
> +	if (p->flag == 1) {

Ditto... see below the explanation

> +		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
> +		st->num_remaining = le32_get_bits(r->num_configs,
> +						  GENMASK(31, 24));
> +	} else {
> +		st->num_returned = 1;
> +		st->num_remaining = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph,
> +				       const void *response,
> +				       struct scmi_iterator_state *st,
> +				       void *priv)
> +{
> +	const struct scmi_resp_settings_get *r = response;
> +	struct scmi_settings_get_ipriv *p = priv;
> +
> +	if (!p->flag) {
> +		if (p->config_types[0] !=
> +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> +			return -EINVAL;
> +	} else if (p->flag == 1) {
> +		p->config_types[st->desc_index + st->loop_idx] =
> +			le32_get_bits(r->configs[st->loop_idx * 2],
> +				      GENMASK(7, 0));
> +	} else if (p->flag == 2) {
> +		return 0;
> +	}

Unneeded...see down below for explanation

> +
> +	p->config_values[st->desc_index + st->loop_idx] =
> +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
> +			  enum scmi_pinctrl_selector_type type,
> +			  enum scmi_pinctrl_conf_type config_type,
> +			  u32 *config_value)
> +{
> +	int ret;
> +	void *iter;
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_pinctrl_settings_get_prepare_message,
> +		.update_state = iter_pinctrl_settings_get_update_state,
> +		.process_response = iter_pinctrl_settings_get_process_response,
> +	};
> +	struct scmi_settings_get_ipriv ipriv = {
> +		.selector = selector,
> +		.type = type,
> +		.flag = 0,
> +		.config_types = &config_type,
> +		.config_values = config_value,
> +	};
> +

So this function is used to retrieve configs; as of now, just one, then
it could be extended to fetch all the configs, and for this it uses the
iterators helpers, BUT it is not and will not be used to just fetch the
selected_function with flag_2 (even though is always provided), since in
that case you wont get back a multi-part SCMI response and so there is no
need to use iterators...

IOW... no need here to handle flag_2 scenario and as a consequence I would
change the ipriv flag to be be a boolean .get_all, like it was, since it is
more readable (and so you wont need to add any comment..)

In the future could make sense to add here also a *selected_function output
param to this function since you will always get it back for free when
retrieving configs ... BUT for now is just not needed really...no users
for this case till now...

..when the time will come that we will need a function_selected_get to
be issued without retrieveing also the configs I would add a distinct
routine that crafts properly a SETTINGS_GET with flag_2 without worrying
about multi-part responses (and with no need for iterators support)

Trying to handle all in here just complicates stuff...

> +	if (!config_value || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_SETTINGS_GET,
> +					    sizeof(struct scmi_msg_settings_get),
> +					    &ipriv);
> +
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
> +static int
> +scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
> +			   u32 selector,
> +			   enum scmi_pinctrl_selector_type type,
> +			   u32 nr_configs,
> +			   enum scmi_pinctrl_conf_type *config_type,
> +			   u32 *config_value)
> +{
> +	struct scmi_xfer *t;
> +	struct scmi_msg_settings_conf *tx;
> +	u32 attributes;
> +	int ret, i;
> +	u32 configs_in_chunk, conf_num = 0;
> +	u32 chunk;
> +	int max_msg_size = ph->hops->get_max_msg_size(ph);
> +
> +	if (!config_type || !config_value || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(__le32) * 2);
> +	while (conf_num < nr_configs) {
> +		chunk = (nr_configs - conf_num > configs_in_chunk) ?
> +			configs_in_chunk : nr_configs - conf_num;
> +
> +		ret = ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
> +					      sizeof(*tx) +
> +					      chunk * 2 * sizeof(__le32),
> +					      0, &t);
> +		if (ret)
> +			return ret;
 for consistency I would 
			break;

like below and you will exit always from the last return ret;

> +
> +		tx = t->tx.buf;
> +		tx->identifier = cpu_to_le32(selector);
> +		attributes = FIELD_PREP(GENMASK(1, 0), type) |
> +			FIELD_PREP(GENMASK(9, 2), chunk);
> +		tx->attributes = cpu_to_le32(attributes);
> +
> +		for (i = 0; i < chunk; i++) {
> +			tx->configs[i * 2] =
> +				cpu_to_le32(config_type[conf_num + i]);
> +			tx->configs[i * 2 + 1] =
> +				cpu_to_le32(config_value[conf_num + i]);
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
> +
> +static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
> +					u32 group,
> +					enum scmi_pinctrl_selector_type type,
> +					u32 function_id)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_settings_conf *tx;
> +	u32 attributes;
> +
> +	ret = scmi_pinctrl_validate_id(ph, group, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
> +				      sizeof(*tx), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(group);
> +	tx->function_id = cpu_to_le32(function_id);
> +	attributes = FIELD_PREP(GENMASK(1, 0), type) | BIT(10);
> +	tx->attributes = cpu_to_le32(attributes);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
> +				u32 identifier,
> +				enum scmi_pinctrl_selector_type type)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_request *tx;
> +
> +	if (type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(identifier);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +

.this function ...

> +static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
> +				    u32 pin)
> +{
> +	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
> +}
> +
> +static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
> +			     u32 identifier,
> +			     enum scmi_pinctrl_selector_type type)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_request *tx;
> +
> +	if (type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, identifier, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(identifier);
> +	tx->flags = cpu_to_le32(type);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +

..and this are completely identical, beside the used command msg_id...please make
it a common workhorse function by adding a param for the command...
 
> +static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u32 pin)
> +{
> +	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
> +}
> +

..and convert these _request/_free functions into a pair odf simple wrapper invoking
the common workhorse...

> +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
> +				       u32 selector,
> +				       struct scmi_group_info *group)
> +{
> +	int ret;
> +
> +	if (!group)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> +				      group->name,
> +				      &group->nr_pins);
> +	if (ret)
> +		return ret;
> +
> +	if (!group->nr_pins) {
> +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> +		return -ENODATA;
> +	}
> +
> +	group->group_pins = kmalloc_array(group->nr_pins,
> +					  sizeof(*group->group_pins),
> +					  GFP_KERNEL);
> +	if (!group->group_pins)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> +					     group->nr_pins, group->group_pins);
> +	if (ret) {
> +		kfree(group->group_pins);
> +		return ret;
> +	}
> +
> +	group->present = true;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
> +				       u32 selector, const char **name)
> +{
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	if (selector >= pi->nr_groups)
> +		return -EINVAL;
> +
> +	if (!pi->groups[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_group_info(ph, selector,
> +						  &pi->groups[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*name = pi->groups[selector].name;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
> +				       u32 selector, const u32 **pins,
> +				       u32 *nr_pins)
> +{
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	if (!pins || !nr_pins)
> +		return -EINVAL;
> +
> +	if (selector >= pi->nr_groups)
> +		return -EINVAL;
> +
> +	if (!pi->groups[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_group_info(ph, selector,
> +						  &pi->groups[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*pins = pi->groups[selector].group_pins;
> +	*nr_pins = pi->groups[selector].nr_pins;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
> +					  u32 selector,
> +					  struct scmi_function_info *func)
> +{
> +	int ret;
> +
> +	if (!func)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> +				      func->name,
> +				      &func->nr_groups);
> +	if (ret)
> +		return ret;
> +
> +	if (!func->nr_groups) {
> +		dev_err(ph->dev, "Function %d has 0 elements", selector);
> +		return -ENODATA;
> +	}
> +
> +	func->groups = kmalloc_array(func->nr_groups, sizeof(*func->groups),
> +				     GFP_KERNEL);
> +	if (!func->groups)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
> +					     func->nr_groups, func->groups);
> +	if (ret) {
> +		kfree(func->groups);
> +		return ret;
> +	}
> +
> +	func->present = true;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
> +					  u32 selector, const char **name)
> +{
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	if (selector >= pi->nr_functions)
> +		return -EINVAL;
> +
> +	if (!pi->functions[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_function_info(ph, selector,
> +						     &pi->functions[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*name = pi->functions[selector].name;
> +	return 0;
> +}
> +
> +static int
> +scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph,
> +				 u32 selector, u32 *nr_groups,
> +				 const u32 **groups)
> +{
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	if (!groups || !nr_groups)
> +		return -EINVAL;
> +
> +	if (selector >= pi->nr_functions)
> +		return -EINVAL;
> +
> +	if (!pi->functions[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_function_info(ph, selector,
> +						     &pi->functions[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*groups = pi->functions[selector].groups;
> +	*nr_groups = pi->functions[selector].nr_groups;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
> +				u32 selector, u32 group)
> +{
> +	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE, selector);
> +}
> +
> +static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
> +				     u32 selector, struct scmi_pin_info *pin)
> +{
> +	int ret;
> +
> +	if (!pin)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> +				      pin->name, NULL);
> +	if (ret)
> +		return ret;
> +
> +	pin->present = true;
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
> +				     u32 selector, const char **name)
> +{
> +	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
> +
> +	if (!name)
> +		return -EINVAL;
> +
> +	if (selector >= pi->nr_pins)
> +		return -EINVAL;
> +
> +	if (!pi->pins[selector].present) {
> +		int ret;
> +
> +		ret = scmi_pinctrl_get_pin_info(ph, selector,
> +						&pi->pins[selector]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	*name = pi->pins[selector].name;
> +
> +	return 0;
> +}
> +
> +static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
> +				 u32 selector,
> +				 enum scmi_pinctrl_selector_type type,
> +				 const char **name)
> +{
> +	switch (type) {
> +	case PIN_TYPE:
> +		return scmi_pinctrl_get_pin_name(ph, selector, name);
> +	case GROUP_TYPE:
> +		return scmi_pinctrl_get_group_name(ph, selector, name);
> +	case FUNCTION_TYPE:
> +		return scmi_pinctrl_get_function_name(ph, selector, name);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
> +	.count_get = scmi_pinctrl_count_get,
> +	.name_get = scmi_pinctrl_name_get,
> +	.group_pins_get = scmi_pinctrl_group_pins_get,
> +	.function_groups_get = scmi_pinctrl_function_groups_get,
> +	.mux_set = scmi_pinctrl_mux_set,
> +	.settings_get = scmi_pinctrl_settings_get,
> +	.settings_conf = scmi_pinctrl_settings_conf,
> +	.pin_request = scmi_pinctrl_pin_request,
> +	.pin_free = scmi_pinctrl_pin_free,
> +};
> +
> +static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	int ret;
> +	u32 version;
> +	struct scmi_pinctrl_info *pinfo;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> +	if (!pinfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_pinctrl_attributes_get(ph, pinfo);
> +	if (ret)
> +		return ret;

.as a I was saying is nr_pins == 0 the scmi_pinctrl_attributes_get
could return -EINVAL here and bail out....not sure that a running setup
with zero pins has any values (even for testing...) BUT, as said above,
I wuld certainly add a dev_warn in scmi_pinctrl_attributes_get() when
nr_pins == 0

Thanks,
Cristian

