Return-Path: <linux-kernel+bounces-108069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A00880586
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBC7284511
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A01E3A1C5;
	Tue, 19 Mar 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6j86hOI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7331E4A9;
	Tue, 19 Mar 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877076; cv=none; b=ClMY/JFo/VYMsOw/rMbcv4nfa53K1CPxwjt4C99amqlucuKtTxxMzfXqzQYTZ+Kq1j/rZgza4EsRKtGjG4oxaVhF0U096GgMSe661V1hLwM+8EFDhZpFI68oigeDW04xvx3rFQ5gMdb8736ccPsyOlta2nAVdJt/O8a9blqr4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877076; c=relaxed/simple;
	bh=BF4CDuK9QPoSPXKTFf0+VPHSKTN403RWHUnsbnBFAxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS/DYgK1YEehPbLGgWC9puHtCO15qePgqIA8zU5IVOBWRjnxZdftvMYxkYgLLnIFzS2VRbooQX33AjZyuPLtd2SqQMxV3hE6iln9NXTnSCrnkymJQEiU82Dqj5RwOUytXf1MY+Dk/tAESHiJW5CcI4ALRqoMZSKWZ95GKW+gR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6j86hOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC67C433C7;
	Tue, 19 Mar 2024 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710877075;
	bh=BF4CDuK9QPoSPXKTFf0+VPHSKTN403RWHUnsbnBFAxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6j86hOII7uf85XVmvsdu1Z2RnVR0L9fayo9YvnpzjwgeeQb7g/T90myaZH7jnI1m
	 a8yyOlZ+Zskrj/gN+q9uQz66P5T4NA0Nk4ZUEdTern5WdBV1GSoxuWBbeH2Tkj0tEK
	 db3BgrpQLdQb4GDu8CbjPyY780rTlC+ezIc0iEGnnWwPvHKvpMjvifnLM3C0OZQ8Wn
	 QnkiaYxXRiVXrrG+0fpnlmkTyfoZdudGFn9w6ioxdSh0Hod4R/Kt12KsDyOjOKjKd5
	 /4Hl1a3H/8+8m16VHTTqaAv85eT/pVUvb/VAeQg1t6+E7H2tURtO1S2YvC8oz8h58U
	 FNh9r7/hjEgag==
Date: Tue, 19 Mar 2024 19:37:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Message-ID: <20240319-quarters-eskimo-be8e7db01438@spud>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K05xHvEr6Oot9xht"
Content-Disposition: inline
In-Reply-To: <20240317193714.403132-2-ayushdevel1325@gmail.com>


--K05xHvEr6Oot9xht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 01:07:09AM +0530, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
>=20
> mikroBUS is a connector and does not have a controller. Instead the
> software is responsible for identification of board and setting up /
> registering uart, spi, i2c, pwm and other buses. Thus it needs a way to
> get uart, spi, i2c, pwm and gpio controllers / adapters.
>=20
> A mikroBUS addon board is free to leave some of the pins unused which
> are marked as NC or Not Connected.

But your binding makes everything required. Why would I need to
instantiate and connect an i2c controller to the mikroebus header if
I don't intend connecting any mikroebus devices that need one?

> Some of the pins might need to be configured as GPIOs deviating from their
> reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
> configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.

> For some add-on boards the driver may not take care of some additional
> signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
> (RST pin on the mikrobus port) needs to be pulled high.

What drivers do is not relevant to the binding. Describe the hardware.

> Here's the list of pins in mikroBUS connector:
> Analog - AN
> Reset - RST
> SPI Chip Select - CS
> SPI Clock - SCK
> SPI Master Input Slave Output - MISO
> SPI Master Output Slave Input - MOSI
> VCC-3.3V power - +3.3V
> Reference Ground - GND
> PWM - PWM output
> INT - Hardware Interrupt
> RX - UART Receive
> TX - UART Transmit
> SCL - I2C Clock
> SDA - I2C Data
> +5V - VCC-5V power
> GND - Reference Ground
>=20
> Additionally, some new mikroBUS boards contain 1-wire EEPROM that contains
> a manifest to describe the addon board to provide plug and play
> capabilities.

My problem with this is that it purports to be some generic description
of the connector but it appears to be very centred on a particular use
case (this beagle product) with simple add-on boards or those that
support the auto-detection eeprom. For other use cases I'm at a loss for
why I'd not omit this node from my DT and treat the mikroebus connector
like any other header on my boards, where I just apply an overlay that
hooks up the device to the relevant spi/pwm/i2c/etc controllers.

I'd almost go as far as to say that this binding is misleading, because
it's worded like a complete description of the port but actually only
seems to describe a (set of) use case(s). What am I missing?

> Link: https://www.mikroe.com/mikrobus
> Link:
> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standar=
d-specification-v200.pdf
> mikroBUS specification
> Link: https://www.mikroe.com/sht1x-click SHT15 Click
> Link: https://www.mikroe.com/eth-click ENC28J60 Click
> Link: https://www.mikroe.com/clickid ClickID
>=20
> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>

> +required:
> +  - compatible
> +  - pinctrl-0
> +  - pinctrl-1
> +  - pinctrl-2
> +  - pinctrl-3
> +  - pinctrl-4
> +  - pinctrl-5
> +  - pinctrl-6
> +  - pinctrl-7
> +  - pinctrl-8
> +  - i2c-adapter
> +  - spi-controller
> +  - spi-cs
> +  - uart
> +  - pwms
> +  - mikrobus-gpios

Oh also, you're missing properties for the supplies.

--K05xHvEr6Oot9xht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnpjQAKCRB4tDGHoIJi
0s0WAP4sxMj7iEDAzcYFuI2/TAZhf+4wpnV6zkAEPu/GrABU6QD+IzPHBYa013DG
+wV/fVKKJxKX1uzafwvK4rmAAt5pUgI=
=CeYU
-----END PGP SIGNATURE-----

--K05xHvEr6Oot9xht--

