Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847777E16A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbjHPMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbjHPMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:22:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9812F2D48;
        Wed, 16 Aug 2023 05:22:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3EE51063;
        Wed, 16 Aug 2023 05:22:42 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B3183F6C4;
        Wed, 16 Aug 2023 05:22:00 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:21:49 +0100
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
Subject: Re: [PATCH v4 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZNy_Xb7knK5GzjEa@pluto>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
 <cde361d9d2b155c72fbd6aa85fd077864e36b6e3.1691518314.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde361d9d2b155c72fbd6aa85fd077864e36b6e3.1691518314.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:25:35PM +0000, Oleksii Moisieiev wrote:
> Add basic implementation of the SCMI v3.2 pincontrol protocol.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
> Changes v3 -> v4
>   - Fixed MAINTAINERS file description
>   - adjusted pinctrl ops position and callback names
>   - add trailing coma in scmi_protocol list
>   - removed unneeded pi checks
>   - corrected selector check
>   - resource allocation refactoring
>   - scmi_*_info swap params to generate better code
>   - style, add trailing coma in definitions
> ---

Hi Oleksii,

thanks to have addressed all the previous reported issues.
At this point my only residual blocker issue is that, after the recent
changes to PINCTRL_CONFIG_GET/SET command formats [1], as requested by Peng
(multiple config values per message), the support added by this patch
around CONFIG_GET/SET is not out-of-spec, because the changes from the
previous BETA were not backward compatible.

So, even sending just one config/val request, as it is now, won't work
because an out-of-spec message will be sent.

I am NOT aware of any further change to this last BETA but you may want
to check with Souvik.

[1]: https://developer.arm.com/documentation/den0056/latest/

Some more comments on this down below.

>  MAINTAINERS                           |   6 +
>  drivers/firmware/arm_scmi/Makefile    |   2 +-
>  drivers/firmware/arm_scmi/driver.c    |   2 +
>  drivers/firmware/arm_scmi/pinctrl.c   | 791 ++++++++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h |   1 +
>  include/linux/scmi_protocol.h         |  42 ++
>  6 files changed, 843 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dab9737ec16..2d81d00e5f4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
>  F:	include/trace/events/scmi.h
>  F:	include/uapi/linux/virtio_scmi.h
>  
> +PINCTRL DRIVER FOR SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI)
> +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/arm_scmi/pinctrl.c
> +
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index b31d78fa66cc..603430ec0bfe 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -10,7 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
>  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 729201d8f935..03686bff000e 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3024,6 +3024,7 @@ static int __init scmi_driver_init(void)
>  	scmi_voltage_register();
>  	scmi_system_register();
>  	scmi_powercap_register();
> +	scmi_pinctrl_register();
>  
>  	return platform_driver_register(&scmi_driver);
>  }
> @@ -3041,6 +3042,7 @@ static void __exit scmi_driver_exit(void)
>  	scmi_voltage_unregister();
>  	scmi_system_unregister();
>  	scmi_powercap_unregister();
> +	scmi_pinctrl_unregister();
>  
>  	scmi_transports_exit();
>  
> diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> new file mode 100644
> index 000000000000..868a2f9821be
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/pinctrl.c
> @@ -0,0 +1,791 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Pinctrl Protocol
> + *
> + * Copyright (C) 2023 EPAM
> + */
> +
> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include "protocols.h"
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
> +	__le32 config_value;
> +};
> +
> +struct scmi_msg_conf_get {
> +	__le32 identifier;
> +	__le32 attributes;
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
> +static int scmi_pinctrl_config_get(const struct scmi_protocol_handle *ph,
> +				   u32 selector,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u8 config_type, unsigned long *config_value)
> +{
> +	int ret;
> +	u32 attributes;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_conf_get *tx;
> +
When supporting new multiple config/values calls here you should be able
to use the iterators helpers for the multipart reply.
(beside reworking all the message field-bits ...)

> +	if (!config_value || type == FUNCTION_TYPE)
> +		return -EINVAL;
> +
> +	ret = scmi_pinctrl_validate_id(ph, selector, type);
> +	if (ret)
> +		return ret;
> +
> +	ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_GET, sizeof(*tx), sizeof(__le32), &t);
> +	if (ret)
> +		return ret;
> +
> +	tx = t->tx.buf;
> +	tx->identifier = cpu_to_le32(selector);
> +	attributes = FIELD_PREP(REG_TYPE_BITS, type) |
> +		FIELD_PREP(REG_CONFIG, config_type);
> +	tx->attributes = cpu_to_le32(attributes);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret)
> +		*config_value = get_unaligned_le32(t->rx.buf);
> +
> +	ph->xops->xfer_put(ph, t);
> +	return ret;
> +}
> +
> +static int scmi_pinctrl_config_set(const struct scmi_protocol_handle *ph,
> +				   u32 selector,
> +				   enum scmi_pinctrl_selector_type type,
> +				   u8 config_type, unsigned long config_value)
> +{
> +	struct scmi_xfer *t;
> +	struct scmi_msg_conf_set *tx;
> +	u32 attributes = 0;
> +	int ret;
> +

Here instead when suppoting setting multiple config/values at once
you'll have anyway to split your request by hand into multiple messages
based on the underlying transport size.

Not sure if it is worth to add some support helper for multi-part
request, probably NO, given that this protocol would be the only user
of such multi-part request at the moment and this would add just more
complexity for just one user.

Anyway, per-transport max_msg_size is NOT exposed explicitly to the
protocols as of now, but, off-the-top-of-my-head I think you should be
able to obtain the current desc->max_msg_size reading t->rx.len after the
xfer_get_init() since that rx.len is initialized to max_msg_size when
you call xfer_get_init() with 0 as rx_size as you do.

Thanks,
Cristian
