Return-Path: <linux-kernel+bounces-81490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B5867699
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9281F25C81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6915128839;
	Mon, 26 Feb 2024 13:32:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565C128363;
	Mon, 26 Feb 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954324; cv=none; b=NfQTxPMaoAyczIJEv7ogs/vMiZgKnVXH6q2H/HKvOmcfp3BDCMTRHXjeQQ5jVisl9TI4vpMlm6WlwB4vF23yCwwYQWmDq8nSnqB87z8l+mJp5U6lRvYgD/Ynxy4+nz9zZ/sHG8P1KPk220bEMMo9Yp8YM6ROgCmbJE03PUEQQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954324; c=relaxed/simple;
	bh=QhNVe/9EhMm8bsHqC7+dEDFK180IjFO1c9ZsUt6BgLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b12Tj7yfzzc7QDt1FOKt+FyWz7Kd80Hpvijh4bLoJlWrCYbPW3IPX7n6W8lXeZhF8YvLQSyJOljRcsQyUlOY3u48bx7ZYutcTNyT+mckwYV+c0XuGyyksPjVp0UEzwnXcvJqKktiObV0LwzJ1qh/g2XhWdVSIFMxkglNjdAxB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E17DA7;
	Mon, 26 Feb 2024 05:32:40 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195D03F762;
	Mon, 26 Feb 2024 05:31:59 -0800 (PST)
Date: Mon, 26 Feb 2024 13:31:58 +0000
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
Subject: Re: [PATCH 5/5] firmware: imx: add i.MX95 MISC driver
Message-ID: <ZdySzr2JzohJgppR@pluto>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-5-3cb743020933@nxp.com>
 <ZdjlaiQQq67e52Q3@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdjlaiQQq67e52Q3@pluto>

On Fri, Feb 23, 2024 at 06:35:26PM +0000, Cristian Marussi wrote:
> On Fri, Feb 02, 2024 at 02:34:43PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > The i.MX95 System manager exports SCMI MISC protocol for linux to do
> > various settings, such as set board gpio expander as wakeup source.
> > 
> 
> Hi,
> 
> > The driver is to add the support.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/imx/Makefile   |  1 +
> >  drivers/firmware/imx/sm-misc.c  | 92 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/firmware/imx/sm.h | 33 +++++++++++++++
> >  3 files changed, 126 insertions(+)
> > 
> > diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> > index fb20e22074e1..cb9c361d9b81 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -2,3 +2,4 @@
> >  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
> >  obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
> > +obj-${CONFIG_IMX_SCMI_MISC_EXT}	+= sm-misc.o
> 
> Same considerations about missing Kconfig as in BBM and implicit
> dependency on the NXP MISC vendor module...this way also you cannot even
> NOT compile this module when the Vendor protocol is compiled in for,
> say, testing purposes...
> 
> > diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
> > new file mode 100644
> > index 000000000000..4410e69d256b
> > --- /dev/null
> > +++ b/drivers/firmware/imx/sm-misc.c
> > @@ -0,0 +1,92 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2024 NXP.
> > + */
> > +
> > +#include <linux/firmware/imx/sm.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/scmi_nxp_protocol.h>
> > +
> > +static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
> > +static struct scmi_protocol_handle *ph;
> 
> This global does NOT sound right...if there are multiple SCMI instances
> defined in the DT this can be probed multiple times, and the MISC
> protocol will be initialized multuple times, each instance will have
> its distinct protocol_handle *ph...so store it somewhere like you did in
> the BBM driver
> 
> > +struct notifier_block scmi_imx_misc_ctrl_nb;
> > +
> > +int scmi_imx_misc_ctrl_set(u32 id, u32 val)
> > +{
> > +	if (!ph)
> > +		return -EPROBE_DEFER;
> > +
> > +	return imx_misc_ctrl_ops->misc_ctrl_set(ph, id, 1, &val);
> > +};
> > +EXPORT_SYMBOL(scmi_imx_misc_ctrl_set);
> > +
> > +int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
> > +{
> > +	if (!ph)
> > +		return -EPROBE_DEFER;
> > +
> > +	return imx_misc_ctrl_ops->misc_ctrl_get(ph, id, num, val);
> > +}
> > +EXPORT_SYMBOL(scmi_imx_misc_ctrl_get);
> > +
> 
> Ok, now I suppose that you want to be sure to run just one instance if
> this driver...
> 
> > +static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
> > +				       unsigned long event, void *data)
> > +{
> > +	return 0;
> > +}
> 
> What is the point of this ?
> 
> > +
> > +static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
> > +{
> > +	const struct scmi_handle *handle = sdev->handle;
> > +	struct device_node *np = sdev->dev.of_node;
> > +	u32 src_id, evt_id, wu_num;
> > +	int ret, i;
> > +
> > +	if (!handle)
> > +		return -ENODEV;
> > +
> > +	imx_misc_ctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_MISC, &ph);
> > +	if (IS_ERR(imx_misc_ctrl_ops))
> > +		return PTR_ERR(imx_misc_ctrl_ops);
> > +
> > +	scmi_imx_misc_ctrl_nb.notifier_call = &scmi_imx_misc_ctrl_notifier;
> > +	wu_num = of_property_count_u32_elems(np, "wakeup-sources");
> > +	if (wu_num % 2) {
> > +		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < wu_num; i += 2) {
> > +		WARN_ON(of_property_read_u32_index(np, "wakeup-sources", i, &src_id));
> > +		WARN_ON(of_property_read_u32_index(np, "wakeup-sources", i + 1, &evt_id));
> > +		ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_MISC,
> > +								       evt_id,
> > +								       &src_id,
> > +								       &scmi_imx_misc_ctrl_nb);
> 
> ...when probed more than once this will lead to the same global nb registered on 2
> different notification chains....
> 
> > +		if (ret)
> > +			dev_err(&sdev->dev, "Failed to register scmi misc event: %d\n", src_id);
> > +	}
> > +
> > +	return 0;
> > +
> > +}
> > +
> > +static const struct scmi_device_id scmi_id_table[] = {
> > +	{ SCMI_PROTOCOL_IMX_MISC, "imx-misc-ctrl" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > +
> > +static struct scmi_driver scmi_imx_misc_ctrl_driver = {
> > +	.name = "scmi-imx-misc-ctrl",
> > +	.probe = scmi_imx_misc_ctrl_probe,
> > +	.id_table = scmi_id_table,
> > +};
> > +module_scmi_driver(scmi_imx_misc_ctrl_driver);
> > +
> 
> All in all, I suppose the main thing to reason about this driver is if you
> want/plan to allow for multiple instances of it to be loaded/probed on the same
> running system or not...
> 
> If you think that this driver HAS STRICTLY to be probed once, and having
> 2 DT protocol nodes for MISC it is certainly an error, we will have to
> add some mechianism in the SCMI core to be able to mark this as single
> instance and refuse to create more than one device for this protocol...a
> sort of generalization of what is done in a custom way by the core for
> SYSTEM_POWER, since we dont want to have multiple sources of shutdown
> events...

An easier solution would be of course for this driver to just check if
any global ph was already retrieved on a previous probe and just bail
out, but I want to have a chat with Sudeep about this approach.

Thanks,
Cristian

