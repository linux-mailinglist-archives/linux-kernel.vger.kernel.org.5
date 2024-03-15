Return-Path: <linux-kernel+bounces-104830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21B87D448
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68411F213C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1385F4E1D1;
	Fri, 15 Mar 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB1iePyr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B81F94B;
	Fri, 15 Mar 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529445; cv=none; b=tjAU+JuS6GcRNu/dGCpakgZi+twnPcd9JEv6MaVNXi26PgmabHIiMU/Uh1BjgpdjvnyOpcMQwXgEQ5uBaZ1zGLEaAjgCkNpsfWQm94l75N4MTr5moy8v0R4/vMD/JqrBFurSTgOWxqdTo78qsAbUGn88SNuuxu+Vynm0R5YuZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529445; c=relaxed/simple;
	bh=XdThChpVAKQYKHp6iMa8gsxf9YJQb5s6EJHGFTjOL5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRFlNzVZ5mClUR/pVXnkMIZhS25GgM2Cc0qmKud8N7iFBg+9A7bsWa6KSFu+TQlXA+2wQ0HiD6xRQqlZBt9jo6froZdzOXPduK2PHE2GZ2xyupcTAfBoxdrfJMTyw1eNDSk3MfJSq6ZxeryjCLU4YEsz+5Aeh61/4uVtHqhu/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB1iePyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E3FC433C7;
	Fri, 15 Mar 2024 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529444;
	bh=XdThChpVAKQYKHp6iMa8gsxf9YJQb5s6EJHGFTjOL5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mB1iePyrjVuTzqvELe81dQyrjFCYKGo3tJe5uOlXC3FxoJc0pNfjGGBfemOAOZo8D
	 env5gYytUuoXICkOnz2vQX+fqmQQ/nIxSPXujAckBKQtsgUnaGQadWw2XjAFA0FiLq
	 loD5u6l/HiQDT52qAxYrH86dWm8bw0h2cwkr6MCXilmuSHTB3B3JFGcUd2eJCc86Z/
	 +Hz70rWIZz0mD4bDB58ozIySoCfe5wUESLgz6dvVPJF+pbjEmbleZBDv9wCZaDZotd
	 aiN7nH21rQ/zwhGwur72QEVNmfianVgVUzSwaX38Z7vKIk/bjptlrdkOMvmKK7JhUi
	 4ZWP0B5Y+dM3g==
Date: Fri, 15 Mar 2024 19:03:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Message-ID: <ba2d158c-db0f-4037-b21b-82ee25208ea7@sirena.org.uk>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0C9fqa+uIcpzgFeK"
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-8-ayushdevel1325@gmail.com>
X-Cookie: A well-known friend is a treasure.


--0C9fqa+uIcpzgFeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 16, 2024 at 12:19:05AM +0530, Ayush Singh wrote:

> +	if (dev->regulators) {
> +		if (dev->protocol == GREYBUS_PROTOCOL_SPI) {
> +			snprintf(devname, sizeof(devname), "%s.%u", dev_name(&port->spi_ctrl->dev),
> +				 port->chip_select[dev->reg]);
> +			regulator.dev_name = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
> +		} else if (dev->protocol == GREYBUS_PROTOCOL_RAW) {

It looks like you're trying to write a switch statement here...

> +		for (i = 0; i < dev->num_regulators; i++) {
> +			val = dev->regulators[i].value.u64_data;
> +			regulator.supply =
> +				kmemdup(dev->regulators[i].name, MIKROBUS_NAME_SIZE, GFP_KERNEL);
> +			dev_info(&port->dev, "adding fixed regulator %llu uv, %s for %s", *val,
> +				 regulator.supply, regulator.dev_name);
> +			regulator_register_always_on(0, dev->regulators[i].name, &regulator, 1,
> +						     *val);
> +		}

The registered regualtor is ignored here which means you leak the
regualtors every time a device is unregistered...

> +static void mikrobus_device_unregister(struct mikrobus_port *port, struct board_device_info *dev,
> +				       char *board_name)

..an operation which does seem to be supported?

--0C9fqa+uIcpzgFeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0m5wACgkQJNaLcl1U
h9Dg3Af9HDcsEVs7HgxyXgcr3FK1SHc5inY3iwQz3gw6LS5jvZ4BKzqDCrmVE7+j
mS+9j46N8GAEr7mdFFr87noquoTs9wAHf41j2b9Quc9wwLHnUoafkJlpkOBLd4MG
IC8Hzbom6tCjSckTvvjBPqMN17pBKMryd8UHpMc/YknZTdpQF8YZmnix3+R8VaxW
6o/yVeHTV3i2T6tz05vATBfZvj/oWJjd6pn0I9Nr+wMTmVWAE11dHVSXNR9wRMnN
lVbkHnB0y0yMJCNEkzdj1j3zfslzHFIE+VDuJoMrP/ZbXDeYliEZMsLzqLIhmdQV
M1kWAQAUlPF8mZDFrTQanPMEBZ89cw==
=0g9k
-----END PGP SIGNATURE-----

--0C9fqa+uIcpzgFeK--

