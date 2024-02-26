Return-Path: <linux-kernel+bounces-81576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1BF8677C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C83CB247FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9A7129A95;
	Mon, 26 Feb 2024 14:04:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3821292FB;
	Mon, 26 Feb 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956275; cv=none; b=GtN6FOBwhvjDUBJ/4uxEQSTEMSPyZgwYOD8yIcSTrFmzwWqkMT14F11ijikPBmndX7Wb4bnBfIHtdeIAakCzfr04SMliMotA1l1chHQ5gjUTzXwJ3IQ75ZuZdJN0cxAx7tPsTclyE7X+O/B0P9mPg/KjI7URFSnw1YDlB1TqQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956275; c=relaxed/simple;
	bh=eE9D94MSGkexm4+cS9xd5Yz5/AUzCiXROv8azBoWYqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQUtUXtgFfXrPvZyB/5l4TS44t6nRIM3gfB/APXYzgZ8+eKil7gHWgEfSBs5bfXKPeRRVIiK6h38hmXbuLg35dC55g42sMV1PD27VBBZZKMdZR2ZOIvuCVlJa7+IomxD7L89elmWKX2IC7wBy99vdSOrQfPYwTMT2xtsH8E5x8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543F5DA7;
	Mon, 26 Feb 2024 06:05:11 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC99E3F762;
	Mon, 26 Feb 2024 06:04:30 -0800 (PST)
Date: Mon, 26 Feb 2024 14:04:28 +0000
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
Subject: Re: [PATCH 4/5] firmware: imx: support BBM module
Message-ID: <ZdyabHM25C9TF7cm@pluto>
References: <20240202-imx95-bbm-misc-v1-0-3cb743020933@nxp.com>
 <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-imx95-bbm-misc-v1-4-3cb743020933@nxp.com>

On Fri, Feb 02, 2024 at 02:34:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The BBM module provides RTC and BUTTON feature. To i.MX95, this module
> is managed by System Manager. Linux could use i.MX SCMI BBM Extension
> protocol to use RTC and BUTTON feature.
> 
> This driver is to use SCMI interface to get/set RTC, enable pwrkey.
> 

Hi some further remarks questin about pwrkey down below.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Makefile |   1 +
>  drivers/firmware/imx/sm-bbm.c | 317 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 318 insertions(+)
> 
 [snip]

> +static int scmi_imx_bbm_pwrkey_init(struct scmi_device *sdev)
> +{
> +	const struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct scmi_imx_bbm *bbnsm = dev_get_drvdata(dev);
> +	struct input_dev *input;
> +	int ret;
> +
> +	if (device_property_read_u32(dev, "linux,code", &bbnsm->keycode)) {
> +		bbnsm->keycode = KEY_POWER;
> +		dev_warn(dev, "key code is not specified, using default KEY_POWER\n");
> +	}

This linux,code binding prop is searched in the SCMI device node, BUT
your BB< protocol binding does NOT mention it at all.

> +
> +	INIT_DELAYED_WORK(&bbnsm->check_work, scmi_imx_bbm_pwrkey_check_for_events);
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input) {
> +		dev_err(dev, "failed to allocate the input device for SCMI IMX BBM\n");
> +		return -ENOMEM;
> +	}
> +
> +	input->name = dev_name(dev);
> +	input->phys = "bbnsm-pwrkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, bbnsm->keycode);
> +
> +	ret = devm_add_action_or_reset(dev, scmi_imx_bbm_pwrkey_act, bbnsm);
> +	if (ret) {
> +		dev_err(dev, "failed to register remove action\n");
> +		return ret;
> +	}
> +
> +	bbnsm->input = input;
> +
> +	ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_BBM,
> +							       SCMI_EVENT_IMX_BBM_BUTTON,
> +							       NULL, &bbnsm->nb);
> +
> +	if (ret)
> +		dev_err(dev, "Failed to register BBM Button Events %d:", ret);
> +
> +	ret = input_register_device(input);
> +	if (ret) {
> +		dev_err(dev, "failed to register input device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

I suppose you cannot use std SystemPower protocol and scmi_power_control
existent upstream driver because you are configuring the event keycode that
is associated with your button press event using linux,code DT properies
looked up above, right ? (which you need to define somewhere as said
above..)

I was thinking that maybe handling events associated with generic button-presses
could be done via some std SCMI protocols like PINCTRL/GPIO (IF IT HAD NOTIFICATIONS)
and some custom SCMI gpio-keys driver in the future (not now clearly :D)...thoughts ?

Thanks,
Cristian

