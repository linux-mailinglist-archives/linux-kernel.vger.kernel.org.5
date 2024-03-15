Return-Path: <linux-kernel+bounces-104459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFA87CE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5693F281C20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFA2E62F;
	Fri, 15 Mar 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBikQgWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8236AED;
	Fri, 15 Mar 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509816; cv=none; b=QW1Dtb2yFi7mOa+9a+USvlQ3PxK+lGMgTlQsF17mUFik2YOtm8/z6icdGnDo9R361nRuS+iAmyfOZ4+aKrRBu1CkRbQDL4yBEym5tUdzK7h1y25FOXhCHzsXGMSIWkA98ivmwvjeW3aBhqw/hykvWEmXsGyLFN/tXnJjUy7zB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509816; c=relaxed/simple;
	bh=mnKx/USIAWKFowB3UECi37soYZOTeSdjE7YC6dui0gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQbgdKYHyu/lcRDgYQy6/uQJdqrpI4ceH+tiMPMEm6idfyntRHVuH1+X4ZOArh+vH/8k4mj9ZYLXQV4HzTQ1NV7TTu/sRC7lYSXudSWGR7JfhKVA8y1ACxJEyNKXsSIvKsyf6MhbSW+rgSwgBSeE/OUBd+rpL/oR24uuRUAL4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBikQgWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B990C433F1;
	Fri, 15 Mar 2024 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710509815;
	bh=mnKx/USIAWKFowB3UECi37soYZOTeSdjE7YC6dui0gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBikQgWFYtKFSQn7AJHJtgle7tDUdFM0GNQ/6JqxAf0lxH6kRfm2hxTIXdG5E6Egy
	 YAzTuwY1PjSj0ojy2bfIUYwcULJe3/38mYLHr+20Nw39reMae5OEJudFQOAYqJS1cG
	 mjHGzUI/L69hkyZrBEUsb8oCQhOHCT3JZQ44vfSkw/OskPHgcBcH2rCpWA6LWBCF5E
	 diWwtCdzYwAdPO346YhitMreYA0mq7RAR0VnKsuUT5V6yoGUgrZLjFm21Xpp4uFg52
	 3KzbWdPKyTbVDmpXxzm5MDzWsiHQEt7QAGwNh5hjZUGzrkEU44uZ9fAbLix7zN5tme
	 8jjsI9jEx/Dhw==
Date: Fri, 15 Mar 2024 13:36:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH 12/25] ASoC: meson: t9015: add support for A1 SoC family
Message-ID: <5f8e8cd2-f9c4-4961-a85d-a0f3217294e6@sirena.org.uk>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-13-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4AHceM7kGoMGggFJ"
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-13-jan.dakinevich@salutedevices.com>
X-Cookie: A well-known friend is a treasure.


--4AHceM7kGoMGggFJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 02:21:48AM +0300, Jan Dakinevich wrote:

> +static const char * const a1_adc_mic_bias_level_txt[] = { "2.0V", "2.1V",
> +	"2.3V", "2.5V", "2.8V" };
> +static const unsigned int a1_adc_mic_bias_level_values[] = { 0, 1, 2, 3, 7 };

Why would this be varied at runtime rather than being something fixed
when the system is designed?

> +static const char * const a1_adc_pga_txt[] = { "None", "Differential",
> +	"Positive", "Negative" };
> +static const unsigned int a1_adc_pga_right_values[] = { 0, PGAR_DIFF,
> +	PGAR_POSITIVE, PGAR_NEGATIVE };
> +static const unsigned int a1_adc_pga_left_values[] = { 0, PGAL_DIFF,
> +	PGAL_POSITIVE, PGAL_NEGATIVE };

Similarly here.

> +	SOC_SINGLE("ADC Mic Bias Switch", LINEIN_CFG, MICBIAS_EN, 1, 0),
> +	SOC_ENUM("ADC Mic Bias Level", a1_adc_mic_bias_level),

Why would micbias be user controlled rather than a DAPM widget as
normal?

--4AHceM7kGoMGggFJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0Tu8ACgkQJNaLcl1U
h9B7RQf/eYxVKAjAigpYP4vgwBWRE/HosjdaaB5ogMo8PMSiXfacGnLx0ZtIpWa9
i6saOA5iW9E/n7Et4JpmJ0J/fYdN7d5TkSlgYGwYP/ojBAChias0hOS7f+fHKvdM
qH8C+20ovZC5RpNOZUjLmiwJ1WMJQrXgjYVTLpBHn23XPsf8fV3i+B5JEQzBJtXI
px2DiSaV2iQ+nBmrZQEQo7KnJsQiLahPLQgr81xq5322lUfLN0+kRHrNGnqMU/Aw
BW++2BV+mf6HXT8WKXrn2DeQByMpBN+jc7eeRDI7xIiB4iAWwpDL9Cn5HsSuYYvI
ZdU3lU/s6CaDa3e5AyxYVatZ42Rx4Q==
=sm4b
-----END PGP SIGNATURE-----

--4AHceM7kGoMGggFJ--

