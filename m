Return-Path: <linux-kernel+bounces-30330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90E831D37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9381F2423C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3442941F;
	Thu, 18 Jan 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE5Ha2Bs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396E1DDC6;
	Thu, 18 Jan 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593996; cv=none; b=Jxv5oqlfmyU/g9IqPS3q062VluoBjxaJAKT3asTSwoV/KMgHuPjA8iA720Dtdqc4mLqK/iHdWfOJAjxNndBoYhJxBit3i06IDbg25kd9aizcYVmbG9qXByW2oWymaTGglOEgVF7wJ2iR3Tl1yWrxV6sGTOZaSQD1dm9AT7/Qyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593996; c=relaxed/simple;
	bh=nwQHxPOUjjJ4GuHl5raPFPdhRyG6WMAS+hUTdTAaVbc=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=FkWQ/wHEW861/TrLJZ/+6CJzlkNGHt4sttt3yEF4SIY5DPRLsOqdGYsrAn8mk2sw8PwXlpnHXQp3v9Z/GQaSIU7yYJhynokH+TPrjAMvO/YE8j6KzpbksSgDLYtZdZVgpCclcTtfmRIIa84zbsTlN1S0uQwxzD82/OdY+EJwq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE5Ha2Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A8C433C7;
	Thu, 18 Jan 2024 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705593996;
	bh=nwQHxPOUjjJ4GuHl5raPFPdhRyG6WMAS+hUTdTAaVbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LE5Ha2BsPxxze+LhYr0lZKir5QBO605DNQjCo24g0V/iwQihBexhy9Xiq1pWT2+82
	 uTSjWJ8arM1v0+28qwRvDPTyMth8TTQCUVFlVzmElMDEZKW381K4Hj75TXe2klD2FM
	 nIMIlSs+VAQmftzDh1Ej0gxGrxamfnatYh6NLhM3DPEm3zdjistuZWg+j5FhLhqL3B
	 NYUJ2jDQRmg9Ue2KbJfYxJWKzZMd9YksQybou8srF0x6Iyrpa/wXajCnL5pC/CmVRs
	 /IQEpSqrn9KpyuKGo88+F2fqOVwN7RpEiEb+0QYgUpLlVKIX4jN2bxzIPgWSgPvnPX
	 Uhbg3mAm900eA==
Date: Thu, 18 Jan 2024 16:06:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] dt-bindings: adc: add AD7173
Message-ID: <20240118-freebase-uptake-ec5fdf786d20@spud>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
 <20240118-lunar-anthem-31bf3b9b351d@spud>
 <b96d5bfc-cc38-44c7-a88f-e7ac5e4eb71d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LOsWyA9HATo5sHZY"
Content-Disposition: inline
In-Reply-To: <b96d5bfc-cc38-44c7-a88f-e7ac5e4eb71d@gmail.com>


--LOsWyA9HATo5sHZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 05:51:20PM +0200, Ceclan Dumitru wrote:
>=20
>=20
> On 1/18/24 17:23, Conor Dooley wrote:
> > On Thu, Jan 18, 2024 at 02:49:22PM +0200, Dumitru Ceclan wrote:
>=20
> ...
>=20
> >> +  adi,clock-select:
> >> +    description: |
> >> +      Select the ADC clock source. Valid values are:
> >> +      int         : Internal oscillator
> >> +      int-out     : Internal oscillator with output on XTAL2 pin
> >> +      ext-clk     : External clock input on XTAL2 pin
> >> +      xtal        : External crystal on XTAL1 and XTAL2 pins
> >> +
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    enum:
> >> +      - int
> >> +      - int-out
> >> +      - ext-clk
> >> +      - xtal
> >> +    default: int
> > I am not a fan of properties like this one, that in my view reimplement
> > things that are supported by the regular clocks properties. I've got
> > some questions for you so I can understand whether or not this custom
> > property is required.
> >=20
> > Whether or not the ext-clk or xtal is used is known based on
> > clock-names - why is the custom property required to determine that?

> > If neither of those clocks are present, then the internal clock would be
> > used. Choosing to use the internal clock if an external one is provided
> > sounds to me like a software policy decision made by the operating
> > system.
>=20
> If there was no int-out, sure. I considered that the choice between int
> and int-out could be made here. So better for driver to choose int/int-ou=
t?

This part of my comments was specifically about choosing between use of
the internal clock when ext-clk or xtal are provided, which I think
excludes the possibility of using int-out, since the XTAL2 pin is an
input.

There's 3 situations:
- no external clock provided
- ext-clk provided
- xtal provided

For the former, you know you're in that state when no "clocks" property
is present. The latter two you can differentiate based on "clock-names".

Choosing to use the internal clock if an external clock is provided
seems to be a software policy decision, unless I am mistaken.

> >=20
> > Finally, if the ADC has a clock output, why can that not be represented
> > by making the ADC a clock-controller?
> >=20
>=20
> Was not familiar with this/did not cross my mind. So if xtal/ext-clk is
> present, the driver should detect it and disable the option for clock
> output? (Common pin XTAL2)

Yeah, if those clocks are provided you would not register as a clock
controller. If there is a user of the output clock, it should have its
own "clocks" property that references the ADC's output.

Your dt-binding could also make clocks/clock-names & clock-controller
mutually exclusive.

Cheers,
Conor.

--LOsWyA9HATo5sHZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalMhAAKCRB4tDGHoIJi
0u1GAQDLF9wUQ+s0LZcpRfaCXxjuTn+bnIp1+ISbdg+ShIwu1QEAozUJEcnwITnj
abuVUXJ5gSOUB5wZwS7hYPBOxPhpngA=
=nOWF
-----END PGP SIGNATURE-----

--LOsWyA9HATo5sHZY--

