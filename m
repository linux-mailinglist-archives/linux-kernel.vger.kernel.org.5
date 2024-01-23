Return-Path: <linux-kernel+bounces-35503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A83839211
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F098428ECE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429CC5FBA8;
	Tue, 23 Jan 2024 15:07:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694225FB9F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022434; cv=none; b=t3ixlIp+p0Sbh/msmMI8iP9r0eX5rJr22Uh1VrMeaCflXAnzHGXefsnQNCQZQCyln4Uq2RY9abTeSxEJTH2vfH3d2wjDkawJUMGFhTrogZcG0pvXdMmiTilRsrNj5RDR5eaNfxIWLpIp9tjnA5gILyHjd57acujMx8/qn2n04Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022434; c=relaxed/simple;
	bh=b0nsHC1LlsVf82gw0OcuACEz8HSMsfQcxZCNzRl/XfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXzbrjAOeUnhzLXevoEfHLIknaFSkz1BFhhmPeaez/BfkWU8L90T9YxNceBm7qMP3VKrwffT55hIBgcsFyAnI8/qRrrG4/LgPYhUSCjKO7bWxGP8/fqXE711t8+qi2aiRNmrV5AgOvZG+TqICPjmz6H0iwOGUHiyzwjp9PRsCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSIMU-0001Fo-Gh; Tue, 23 Jan 2024 16:06:50 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSIMR-001rL1-Fx; Tue, 23 Jan 2024 16:06:47 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSIMR-000Ab1-1K;
	Tue, 23 Jan 2024 16:06:47 +0100
Message-ID: <b9d2e1e5fd8b5022890e05fcc33410360e0d11d7.camel@pengutronix.de>
Subject: Re: [PATCH v4 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org,  alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Sean Anderson <sean.anderson@seco.com>
Date: Tue, 23 Jan 2024 16:06:47 +0100
In-Reply-To: <20240123141311.220505-5-krzysztof.kozlowski@linaro.org>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
	 <20240123141311.220505-5-krzysztof.kozlowski@linaro.org>
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

On Di, 2024-01-23 at 15:13 +0100, Krzysztof Kozlowski wrote:
> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
>=20
> If Devicetree-based device requests a reset line, while "resets"
> Devicetree property is missing but there is a "reset-gpios" one,
> instantiate a new "reset-gpio" platform device which will handle such
> reset line.  This allows seamless handling of such shared reset-gpios
> without need of changing Devicetree binding [1].
>=20
> To avoid creating multiple "reset-gpio" platform devices, store the
> Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> controller, GPIO number and GPIO flags) is used to check if reset
> controller for given GPIO was already registered.
>=20
> If two devices have conflicting "reset-gpios" property, e.g. with
> different ACTIVE_xxx flags, this would allow to spawn two separate
> "reset-gpio" devices, where the second would fail probing on busy GPIO
> request.
>=20
> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1=
]
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I'm nearly out of complaints, two tiny cosmetic issues remaining:

[...]
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 4d5a78d3c085..6e81b8d35055 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
[...]
> @@ -813,12 +838,161 @@ static void __reset_control_put_internal(struct re=
set_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
> =20
> +static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
> +					 unsigned int gpio,
> +					 unsigned int of_flags)
> +{
> +	unsigned int lookup_flags;
> +	const char *label_tmp;
> +
> +	/*
> +	 * Later we map GPIO flags between OF and Linux, however not all
> +	 * constants from include/dt-bindings/gpio/gpio.h and
> +	 * include/linux/gpio/machine.h match each other.
> +	 */
> +	if (of_flags > GPIO_ACTIVE_LOW) {
> +		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
> +			of_flags, gpio);

Alignment to parenthesis is slightly off.

> +		return -EINVAL;
> +	}
> +
> +	struct gpio_device *gdev __free(gpio_device_put) =3D gpio_device_find_b=
y_fwnode(of_fwnode_handle(np));

Adding a local fwnode variable would make this fit in the 100 character
limit again.

regards
Philipp

