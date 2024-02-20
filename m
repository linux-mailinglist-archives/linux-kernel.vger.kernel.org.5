Return-Path: <linux-kernel+bounces-72839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB10A85B939
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EFBB23E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CAE63509;
	Tue, 20 Feb 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpb50nH8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E83F8DA;
	Tue, 20 Feb 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425511; cv=none; b=iMMspE33Ne5Xh2u4dSOM3nHGuuKfnrdpRNN3UIBKthkzNnE23jMybcJcEDSjw4FATux9LbkyiYVmJbKxyVCxEHD2dUy6BSY+uvrD0QuePsiRPIxM7LC/LuYkW7Fz+W/B0vOl5VmVEHUyBCEPYZ5pMZRhlJ4UGa1VybbwOIi7DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425511; c=relaxed/simple;
	bh=85QlOFu2YhSQ9TMT5qDulDBsbqMYoTEK5apqI6RUa/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKkfHzshe6+2gxGKYzEhK1xjiLeiixIzhr4GTyi3INvPqEjye6sXZ+Rcqix+G3AdX3DfiSRtSvzComAHZ3UtPfqCMCIpVHz89wtk8x7csSu92LRZq7Od9EvxapozhjNTvv2BfNdn/tG3Fiw+qecv3xOBU7NiGvO16PuKQJNcCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpb50nH8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26fa294e56so835168866b.0;
        Tue, 20 Feb 2024 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708425507; x=1709030307; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1XtqId6iHlaoYYjxliVTuVP5w5azb5xdx241ndbj1o=;
        b=Fpb50nH8BtsY60f7ZyV8Jy4gTRQzZ10Amt6axP7K8Vhc92GBWvZQJPZr4ouKem9unR
         Z1puR3z8j4zvUQNc2HAncAolYrO7eDpOsWE97w6g5K43GibjjZvfueM41aZMKQSvZeg+
         hyPZv8u0uXmE4obN68gpq+nxSXirr9InI9CwfSJfGzzpM++fc6E2HpZffimkUwPXRmnS
         fDHnWzepCPdFC+x7gn0ofXNoH4Q3OvTAgia/cRnGFNqXE0b15lmLNYUVcOfhohK/qcKJ
         mV+Q3fCKHbUsGHU/ArHZZSus3Nr+f/6uVVCl3TBqMSArbfIZwoGYCz97axAJYoA0oLPz
         f3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425507; x=1709030307;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1XtqId6iHlaoYYjxliVTuVP5w5azb5xdx241ndbj1o=;
        b=ZK0vZoxCavS3Asmvrlz5XZ/NGO3JGNa7eddAF8zuQ2LDh3GRcrGte9nNNUzbPEfc16
         Smujg12qkwP5QQDknP5BnwBFdRRel/35ln6V8xFMbqVWzmZGjKjmddS2WeFAUTJwCMZS
         P89AAPgqNKpAreE+QJOl9CTTH/lk71WLAtUqyeaaW8zIwVnkx6DdeUZp29WWmohXh78Q
         GBWD7uGnC9uIZxA36eJEmsFb2DNEPvJM3Frv8muEjg7aQec9hG2uxWLypFahf6lDlAXc
         HOIUH1bd67rKdmxIllNsAhC5UFjtwRPHDutP0Bt3Cqq0VZHy0BIhzW1WWg0iBD9ReXgJ
         m8EA==
X-Forwarded-Encrypted: i=1; AJvYcCUisET57+Lv6vO2lIsqz10RzqnPxXQ5yT4CYBAvF1/jLLkkIjSKdgea7OwUUEyCURx/w1XKvJ1f9HIIUZEDaiB2fbykvpR1m3QRsN0aZY/lq1gkVZ2oYVS7mgYJXl13QqphXR2kgyR3uJwsvdTHo2PSjSOT2sWfnt52lJTiLD9N2VxDVgMzTN/CHKfEPPL72RdSCXocFb4zLploOnocdfg=
X-Gm-Message-State: AOJu0Yx47nS2u6xn8HNGOODca2LfvsAsJo6HHOiI7Yr15Kp1OViBtpOm
	9csBePo2OTrdUAaz2AeGbKN20pPnlXKfsZDiZF7hH7TCYOeJj8a2
X-Google-Smtp-Source: AGHT+IGzDT+/gIS4cp1zwvn8P+xfh9QBWAauqBrx/h9SQaNyFq6J4r0lVXHGOwF970Cnf6Z3YnrsvQ==
X-Received: by 2002:a17:906:fa19:b0:a3e:f83d:f8a0 with SMTP id lo25-20020a170906fa1900b00a3ef83df8a0mr1293951ejb.52.1708425507113;
        Tue, 20 Feb 2024 02:38:27 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b00a3d80d7f986sm3796152ejk.82.2024.02.20.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:38:26 -0800 (PST)
Message-ID: <6af326b1bf24faea652b4549ff5db24b96ee80c5.camel@gmail.com>
Subject: Re: [PATCH v13 3/3] iio: adc: ad7173: add AD7173 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,  ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2024 11:38:25 +0100
In-Reply-To: <20240220094344.17556-3-mitrutzceclan@gmail.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
	 <20240220094344.17556-3-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 11:43 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org> # for changes up until V12
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>=20

Hi Dumitru,

Just a couple of things... With those addressed:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

..

>=20
> +static int ad7173_disable_all(struct ad_sigma_delta *sd)
> +{
> +	struct ad7173_state *st =3D ad_sigma_delta_to_ad7173(sd);
> +	int ret;
> +	int i;
> +
> +	for (i =3D 0; i < st->num_channels; i++) {
> +		ret =3D ad_sd_write_reg(sd, AD7173_REG_CH(i), 2, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct ad_sigma_delta_info ad7173_sigma_delta_info =3D {
> +	.set_channel =3D ad7173_set_channel,
> +	.append_status =3D ad7173_append_status,
> +	.disable_all =3D ad7173_disable_all,
> +	.set_mode =3D ad7173_set_mode,
> +	.has_registers =3D true,
> +	.addr_shift =3D 0,
> +	.read_mask =3D BIT(6),
> +	.status_ch_mask =3D GENMASK(3, 0),
> +	.data_reg =3D AD7173_REG_DATA,
> +	.irq_flags =3D IRQF_TRIGGER_FALLING,

You need to rebase on the current testing (or maybe Jonathan can fix it if =
this get's
applied in this version). Basically, I would drop the above .irq_flags assi=
gment. The
lib will now check if you gave the trigger over Firmware (like device tree)=
 and use
it. And that#s how we should set the IRQ trigger type. I did not removed th=
e variable
just for backward compatibility [1].

..

> +};
>=20
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad7173_info;
> +
> +	spi->mode =3D SPI_MODE_3;
> +

I don't think we need the above. We should just enforce it to SPI_CPOL| SPI=
_CPHA in
the bindings [2].

[1]: https://lore.kernel.org/linux-iio/20240117-dev_sigma_delta_no_irq_flag=
s-v1-2-db39261592cf@analog.com/
[2]: https://elixir.bootlin.com/linux/latest/source/Documentation/devicetre=
e/bindings/iio/imu/adi,adis16475.yaml#L45

- Nuno S=C3=A1
>=20

