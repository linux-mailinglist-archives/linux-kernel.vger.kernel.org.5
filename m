Return-Path: <linux-kernel+bounces-36737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0613783A5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998A22948E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B6618032;
	Wed, 24 Jan 2024 09:46:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816917C6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089599; cv=none; b=M56SMEvDvWSNFc/h+9Y/i2aPH3fgGQU6H+Bt343uiP+lYPYR9LoeSXm5Cenouih459s8trkGKa7ehBY3PmLrCsu5R5KTcWCEApYN5aZjDtEXEf6pR8c/lWfWFTvQLRUfNv5Nm0CSaLozFmUqaaRMsIo5Ygy7vx/iPSDPa1lUHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089599; c=relaxed/simple;
	bh=KAXpL6rcNOC7cpNY+gkbkcwqymqfb3e2TV1COL5RfDU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncKIO9c8hBv1PbXjqOpRmgW7Mb/fkWLxGO1VDNukKvgv/lSP++QGMYPM45E0fupYganpSUOKvxO0tiGQTIccwVYIzcSLcAHzOVCU1c+bD3+MZEMoX55MIQojgCE38jYzccD7Uzb0g38gVImGMWyHv0fOWrteGxxLK4Qe5gihris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSZpc-0003zO-ML; Wed, 24 Jan 2024 10:46:04 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSZpX-0021gf-GI; Wed, 24 Jan 2024 10:45:59 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSZpX-00064D-1N;
	Wed, 24 Jan 2024 10:45:59 +0100
Message-ID: <dccb808a2ba6ccb0fd0b4e7ccfe40cd871886b6b.camel@pengutronix.de>
Subject: Re: [PATCH v13 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for
 ASPEED g6 PWM/Fan tach
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com, 
 linux@roeck-us.net, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 corbet@lwn.net,  u.kleine-koenig@pengutronix.de,
 naresh.solanki@9elements.com,  linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-pwm@vger.kernel.org,
 BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Date: Wed, 24 Jan 2024 10:45:59 +0100
In-Reply-To: <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
	 <20240124060705.1342461-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-01-24 at 14:07 +0800, Billy Tsai wrote:
[...]
> +static int aspeed_pwm_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev, *hwmon;
> +	int ret;
> +	struct device_node *child;
> +	struct aspeed_pwm_tach_data *priv;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev =3D dev;
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +	priv->clk_rate =3D clk_get_rate(priv->clk);
> +	priv->reset =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");

Consider using devm_add_action_or_reset() to assert the reset in the
error paths and on driver unbind.

> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &aspeed_pwm_ops;
> +	priv->chip.npwm =3D PWM_ASPEED_NR_PWMS;
> +
> +	ret =3D devm_pwmchip_add(dev, &priv->chip);
> +	if (ret < 0) {
> +		reset_control_assert(priv->reset);

Then this ...

> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +	}
> +
> +	for_each_child_of_node(dev->of_node, child) {
> +		ret =3D aspeed_tach_create_fan(dev, child, priv);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			dev_warn(dev, "Failed to create fan %d", ret);
> +			return 0;
> +		}
> +	}
> +
> +	of_platform_populate(dev->of_node, NULL, NULL, dev);
> +
> +	hwmon =3D devm_hwmon_device_register_with_info(dev, "aspeed_tach", priv=
,
> +						     &aspeed_tach_chip_info, NULL);
> +	ret =3D PTR_ERR_OR_ZERO(hwmon);
> +	if (ret) {
> +		reset_control_assert(priv->reset);

.. and this ...

> +		return dev_err_probe(dev, ret,
> +				     "Failed to register hwmon device\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_pwm_tach_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_pwm_tach_data *priv =3D platform_get_drvdata(pdev);
> +
> +	reset_control_assert(priv->reset);
> +
> +	return 0;
> +}

.. and this could be dropped.

regards
Philipp

