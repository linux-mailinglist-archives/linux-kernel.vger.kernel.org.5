Return-Path: <linux-kernel+bounces-78649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF2861687
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBBF1C24970
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A882C60;
	Fri, 23 Feb 2024 15:56:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D10823A8;
	Fri, 23 Feb 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703798; cv=none; b=dy3ZwBW+tXxnoGtQVlnrOlD54uZsrseItlja2pLmUdYQZe/2uiXLIqxcobr8iHg4E1Z5PhiOj4MxPJBHOEmtVoYIOvxuNJjRKng+30VA9AON7Xt40tm9QbeRIAxiDM80zVwepa09hNZKRUw7HpEu6t9FG3TG0opjLp/UJJrPRVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703798; c=relaxed/simple;
	bh=0Tkl5y43qBEZsVivMRr0+gq9bJqRw6sso07RZ0g1mvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E33Fp07DGsqFe+52fx0DNaJgfvWh/GEf7Jdy8hnrzaaXc4hPw82OUI6g81IUdbwrF8PBv6vpSM4DPt6AFCjK8VjitA2LLQPR9rhaIlQeCXx+IYRA/GC0SzMycekRfDY78nr2EekqC08qWmna/vU0FEHX7vOAgfgPzoenhesZhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 405F2DA7;
	Fri, 23 Feb 2024 07:57:13 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79B3E3F762;
	Fri, 23 Feb 2024 07:56:32 -0800 (PST)
Date: Fri, 23 Feb 2024 15:56:30 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Message-ID: <ZdjALicBK4XB89b9@pluto>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-3-3cb743020933@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-imx95-bbm-misc-v1-3-3cb743020933@nxp.com>

On Fri, Feb 02, 2024 at 02:34:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX MISC protocol is for misc settings, such as gpio expander
> wakeup.
> 

Hi,

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/arm_scmi/Kconfig       |  10 ++
>  drivers/firmware/arm_scmi/Makefile      |   1 +
>  drivers/firmware/arm_scmi/imx-sm-misc.c | 289 ++++++++++++++++++++++++++++++++
>  include/linux/scmi_nxp_protocol.h       |  17 ++
>  4 files changed, 317 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 56d11c9d9f47..bfeae92f6420 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
>  	  and BUTTON.
>  
>  	  This driver can also be built as a module.
> +
> +config IMX_SCMI_MISC_EXT
> +	tristate "i.MX SCMI MISC EXTENSION"
> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +	default y if ARCH_MXC
> +	help
> +	  This enables i.MX System MISC control logic such as gpio expander
> +	  wakeup
> +
> +	  This driver can also be built as a module.
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index 327687acf857..a23fde721222 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -12,6 +12,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
>  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
>  scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
>  scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
> +scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
>  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> diff --git a/drivers/firmware/arm_scmi/imx-sm-misc.c b/drivers/firmware/arm_scmi/imx-sm-misc.c
> new file mode 100644
> index 000000000000..7805d41cca4d
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System control and Management Interface (SCMI) NXP MISC Protocol
> + *
> + * Copyright 2024 NXP
> + */
> +
> +#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_nxp_protocol.h>
> +
> +#include "protocols.h"
> +#include "notify.h"
> +
> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x0
> +

Same considerations on this 0-versioning as in previous patch.

> +enum scmi_imx_misc_protocol_cmd {
> +	SCMI_IMX_MISC_CTRL_SET	= 0x3,
> +	SCMI_IMX_MISC_CTRL_GET	= 0x4,
> +	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
> +};
> +
> +struct scmi_imx_misc_info {
> +	u32 version;
> +	u32 nr_ctrl;
> +	u32 nr_reason;
> +};
> +
> +struct scmi_msg_imx_misc_protocol_attributes {
> +	__le32 attributes;
> +};
> +
> +#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
> +#define GET_CTRLS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
> +

Please lineup this tabs

> +struct scmi_imx_misc_ctrl_set_in {
> +	__le32 id;
> +	__le32 num;
> +	__le32 value[MISC_MAX_VAL];
> +};
> +
> +struct scmi_imx_misc_ctrl_notify_in {
> +	__le32 ctrl_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_misc_ctrl_notify_payld {
> +	__le32 ctrl_id;
> +	__le32 flags;
> +};
> +
> +struct scmi_imx_misc_ctrl_get_out {
> +	__le32 num;
> +	__le32 val[MISC_MAX_VAL];
> +};
> +
> +static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
> +					struct scmi_imx_misc_info *mi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_imx_misc_protocol_attributes *attr;
> +
> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> +				      sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		mi->nr_ctrl = GET_CTRLS_NR(attr->attributes);
> +		mi->nr_reason = GET_REASONS_NR(attr->attributes);
> +		dev_info(ph->dev, "i.MX MISC NUM CTRL: %d, NUM Reason: %d\n",
> +			 mi->nr_ctrl, mi->nr_reason);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle *ph,
> +				     u32 ctrl_id, u32 flags)
> +{
> +	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
> +	struct scmi_imx_misc_ctrl_notify_in *in;
> +	struct scmi_xfer *t;
> +	int ret;
> +
> +	if (ctrl_id >= mi->nr_ctrl)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
> +				      sizeof(*in), 0, &t);
> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->ctrl_id = cpu_to_le32(ctrl_id);
> +	in->flags = cpu_to_le32(flags);

so this is an evt_id I see below...maybe calling this param or event
instead of flags is less misleading....I would not expect to see endian
handling on a bitfield (and flags suggests just that to me...

> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int
> +scmi_imx_misc_ctrl_set_notify_enabled(const struct scmi_protocol_handle *ph,
> +				      u8 evt_id, u32 src_id, bool enable)
> +{
> +	int ret;
> +
> +	ret = scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0);
> +	if (ret) {

No need for braces here. Please run checkpatch --strict on your next
series.

> +		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] - ret:%d\n",
> +			evt_id, src_id, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +scmi_imx_misc_ctrl_get_num_sources(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
> +
> +	return mi->nr_ctrl;
> +}
> +
> +static void *
> +scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handle *ph,
> +				      u8 evt_id, ktime_t timestamp,
> +				      const void *payld, size_t payld_sz,
> +				      void *report, u32 *src_id)
> +{
> +	const struct scmi_imx_misc_ctrl_notify_payld *p = payld;
> +	struct scmi_imx_misc_ctrl_notify_report *r = report;
> +
> +	if (sizeof(*p) != payld_sz)
> +		return NULL;
> +
> +	r->timestamp = timestamp;
> +	r->ctrl_id = p->ctrl_id;
> +	r->flags = p->flags;

Here you DO need instead endian-helpers when you access the payload p->
A static analyzer like smatch will have spotted this.

> +	if (src_id)

src_id param is assured to be non-NULL here...not neeed to check...as
you did not check in BBM module indeed...

> +		*src_id = r->ctrl_id;
> +	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__, r->ctrl_id, r->flags);
> +
> +	return r;
> +}
> +
> +static const struct scmi_event_ops scmi_imx_misc_event_ops = {
> +	.get_num_sources = scmi_imx_misc_ctrl_get_num_sources,
> +	.set_notify_enabled = scmi_imx_misc_ctrl_set_notify_enabled,
> +	.fill_custom_report = scmi_imx_misc_ctrl_fill_custom_report,
> +};
> +
> +static const struct scmi_event scmi_imx_misc_events[] = {
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	},
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	},
> +	{
> +		.id = SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
> +		.max_payld_sz = sizeof(struct scmi_imx_misc_ctrl_notify_payld),
> +		.max_report_sz = sizeof(struct scmi_imx_misc_ctrl_notify_report),
> +	}
> +};
> +
> +static struct scmi_protocol_events scmi_imx_misc_protocol_events = {
> +	.queue_sz = SCMI_PROTO_QUEUE_SZ,
> +	.ops = &scmi_imx_misc_event_ops,
> +	.evts = scmi_imx_misc_events,
> +	.num_events = ARRAY_SIZE(scmi_imx_misc_events),
> +};
> +
> +static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
> +{
> +	struct scmi_imx_misc_info *minfo;
> +	u32 version;
> +	int ret;
> +
> +	ret = ph->xops->version_get(ph, &version);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
> +		 PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	minfo = devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
> +	if (!minfo)
> +		return -ENOMEM;
> +
> +	ret = scmi_imx_misc_attributes_get(ph, minfo);
> +	if (ret)
> +		return ret;
> +
> +	return ph->set_priv(ph, minfo, version);
> +}
> +
> +static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *ph,
> +				  u32 ctrl_id, u32 *num, u32 *val)
> +{

Does *num here contains val[] max size on input and number of elements
filled into val[] on output ? I assume so down below

> +	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
> +	struct scmi_imx_misc_ctrl_get_out *out;
> +	struct scmi_xfer *t;
> +	int ret, i;
> +
> +	if (ctrl_id >= mi->nr_ctrl)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET, sizeof(u32),
> +				      sizeof(*out), &t);

This *out size you require is really capped by the max transport size...so this
could fail depending on the transport...just be aware of this...not saying is bad
by itself...an alternative would be to define value inside the struct as 

  __le32 *value;

and here ask for an rx_size of 0 instead of sizeof(*out) so that you get
max transport payload size....then you will have to check if the
returned payload is as long as expected by the caller though...up 2 you really

> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(ctrl_id, t->tx.buf);
> +	ret = ph->xops->do_xfer(ph, t);
> +	if (!ret) {
> +		out = t->rx.buf;
> +		*num = le32_to_cpu(out->num);

out->num MUST be smaller than the original *num passed as input to fit
into *val...please check this before overwriting *num and bail out on overflow...

..moreover...out->val[] size is statically defined as MISC_MAX_VAL and
if you get here you know that you have enough space in t->rx.buf BUT you will
have also to check that the returned out->num is < MISC_MAX_VAL to avoid any
possible overflow while reading the payload if the value provided by fw
is bogus...

> +		for (i = 0; i < *num; i++)
> +			val[i] = le32_to_cpu(out->val[i]);
> +	}
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
> +				  u32 ctrl_id, u32 num, u32 *val)
> +{
> +	struct scmi_imx_misc_info *mi = ph->get_priv(ph);
> +	struct scmi_imx_misc_ctrl_set_in *in;
> +	struct scmi_xfer *t;
> +	int ret, i;
> +
> +	if (ctrl_id >= mi->nr_ctrl)
> +		return -EINVAL;
> +
> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET, sizeof(*in),
> +				      0, &t);

Similarly as above here you could fail if the requestes size for TX is
bigger than allowed by the transport..

> +	if (ret)
> +		return ret;
> +
> +	in = t->tx.buf;
> +	in->id = cpu_to_le32(ctrl_id);
> +	in->num = cpu_to_le32(num);
> +	for (i = 0; i < num; i++)

and num must be checked anyway to be < MISC_MAX_VAL before looping in->value

> +		in->value[i] = cpu_to_le32(val[i]);
> +
> +	ret = ph->xops->do_xfer(ph, t);
> +
> +	ph->xops->xfer_put(ph, t);
> +
> +	return ret;
> +}
> +
> +static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
> +	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
> +	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
> +};
> +
> +static const struct scmi_protocol scmi_imx_misc = {
> +	.id = SCMI_PROTOCOL_IMX_MISC,
> +	.owner = THIS_MODULE,
> +	.instance_init = &scmi_imx_misc_protocol_init,
> +	.ops = &scmi_imx_misc_proto_ops,
> +	.events = &scmi_imx_misc_protocol_events,
> +};
> +
> +module_scmi_protocol(scmi_imx_misc);
> diff --git a/include/linux/scmi_nxp_protocol.h b/include/linux/scmi_nxp_protocol.h
> index a2077e1ef5d8..45415a6ff845 100644
> --- a/include/linux/scmi_nxp_protocol.h
> +++ b/include/linux/scmi_nxp_protocol.h
> @@ -13,8 +13,14 @@
>  #include <linux/notifier.h>
>  #include <linux/types.h>
>  
> +#define SCMI_PAYLOAD_LEN	100
> +
> +#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
> +#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
> +

All of these payload size calculation does NOT consider the fact that
the underlying buffer inside scmi_xfer are really dependent on
transport max_size...so as said above all the xfer_get_init could fail
depending on the size of the configured transport...just a heads
up...fine for me.

>  enum scmi_nxp_protocol {
>  	SCMI_PROTOCOL_IMX_BBM = 0x81,
> +	SCMI_PROTOCOL_IMX_MISC = 0x84,
>  };
>  
>  struct scmi_imx_bbm_proto_ops {
> @@ -47,4 +53,15 @@ struct scmi_imx_bbm_notif_report {
>  	unsigned int		rtc_id;
>  	unsigned int		rtc_evt;
>  };
> +
> +struct scmi_imx_misc_ctrl_notify_report {
> +	ktime_t			timestamp;
> +	unsigned int		ctrl_id;
> +	unsigned int		flags;
> +};
> +
> +struct scmi_imx_misc_proto_ops {
> +	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id, u32 num, u32 *val);
> +	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id, u32 *num, u32 *val);
> +};

Please add some Doc commenting describing these protocol_ops as in any
proto_ops found in scmi_protocol.h

(same for the other BBM Vendor protocol ops in the previous patch that I
missed in the other review.

Thanks,
Cristian

