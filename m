Return-Path: <linux-kernel+bounces-33859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A078B83701A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FCEB262A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89312495C1;
	Mon, 22 Jan 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AABn7R/x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291B48CF0;
	Mon, 22 Jan 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945731; cv=none; b=t1U9g1Cm9sEGRJqIDUN8x0Cmhn/3SZuGTtm1ljSqVI6ABQ6YlRUOKlwn9IKnHZcoGEgJNxgg0LICiUXSa0EtE4hGJfZv2+gGs8oz17m7t/iAhoESneeFJUW4D1vkKkDrcHFWoykcTTHWPbf3APwda3GttMLUB8ENqyxqxML6WGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945731; c=relaxed/simple;
	bh=hgeoLm3uwg0td5z993vUSVC7oy/nuqOImO96wn1PMjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g11LGkm83H2wPnHdnRn8Ybwh8+6ehFT1RG+S9GkzNzS0UUhSNw5WF5cAUUjvcpI4T04I1Teuj/dm7oQyJQuYomS2qAbXVPB0TyNAn/qawXu7sEER0AJVt+0tP15Yz/sz3mEdpIPBYJ45UY2tWMVeBycvXTWmmS9NuudOCfzsyjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AABn7R/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBAFC433F1;
	Mon, 22 Jan 2024 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705945731;
	bh=hgeoLm3uwg0td5z993vUSVC7oy/nuqOImO96wn1PMjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AABn7R/xM+sFo+KOU71jD3AWD77zQjvu96pxhT5YNoFsNI2JSJ70u/Be0vLKHGpf1
	 VJSWfBH1Zf8ywdwmrrARCuKdJ8xHzzfgyqZFM3ABE7Bljf4XaAnzOLVIrrkwUNRI6e
	 HnxuRqO1KjIYQVzwWxxC74P9IilqhKbfDl93Dmb2XyRW3jeyw4ZZbbpZfx7+FaES3l
	 1uWr2lKi1C+lXKVcSacKYWQouKrVjTZCkoR820fJB0gFHuQLWVHYAEV/bcD78k2ynP
	 KLlxgoMSmRshS4OxEdXFZjytfjILIZi8BDWWl00ufIzzE8FG6v94RjdvriP3cZpnR0
	 Ff5XTEdUd8h9g==
Date: Mon, 22 Jan 2024 17:48:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ceclan Dumitru <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
	brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <20240122-bloating-dyslexic-cbc0258c898a@spud>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
 <20240118-lunar-anthem-31bf3b9b351d@spud>
 <b96d5bfc-cc38-44c7-a88f-e7ac5e4eb71d@gmail.com>
 <20240118-freebase-uptake-ec5fdf786d20@spud>
 <20240121154118.389e4e87@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dlghW/7VOeuyh/eL"
Content-Disposition: inline
In-Reply-To: <20240121154118.389e4e87@jic23-huawei>


--dlghW/7VOeuyh/eL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 03:41:18PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Jan 2024 16:06:29 +0000
> Conor Dooley <conor@kernel.org> wrote:
> > On Thu, Jan 18, 2024 at 05:51:20PM +0200, Ceclan Dumitru wrote:
> > > On 1/18/24 17:23, Conor Dooley wrote: =20
> > > > On Thu, Jan 18, 2024 at 02:49:22PM +0200, Dumitru Ceclan wrote: =20
> > > >> +  adi,clock-select:
> > > >> +    description: |
> > > >> +      Select the ADC clock source. Valid values are:
> > > >> +      int         : Internal oscillator
> > > >> +      int-out     : Internal oscillator with output on XTAL2 pin
> > > >> +      ext-clk     : External clock input on XTAL2 pin
> > > >> +      xtal        : External crystal on XTAL1 and XTAL2 pins
> > > >> +
> > > >> +    $ref: /schemas/types.yaml#/definitions/string
> > > >> +    enum:
> > > >> +      - int
> > > >> +      - int-out
> > > >> +      - ext-clk
> > > >> +      - xtal
> > > >> +    default: int =20
> > > > I am not a fan of properties like this one, that in my view reimple=
ment
> > > > things that are supported by the regular clocks properties. I've got
> > > > some questions for you so I can understand whether or not this cust=
om
> > > > property is required.
> > > >=20
> > > > Whether or not the ext-clk or xtal is used is known based on
> > > > clock-names - why is the custom property required to determine that=
? =20
> >=20
> > > > If neither of those clocks are present, then the internal clock wou=
ld be
> > > > used. Choosing to use the internal clock if an external one is prov=
ided
> > > > sounds to me like a software policy decision made by the operating
> > > > system. =20
> > >=20
> > > If there was no int-out, sure. I considered that the choice between i=
nt
> > > and int-out could be made here. So better for driver to choose int/in=
t-out? =20
> >=20
> > This part of my comments was specifically about choosing between use of
> > the internal clock when ext-clk or xtal are provided, which I think
> > excludes the possibility of using int-out, since the XTAL2 pin is an
> > input.
> >=20
> > There's 3 situations:
> > - no external clock provided
> > - ext-clk provided
> > - xtal provided
> >=20
> > For the former, you know you're in that state when no "clocks" property
> > is present. The latter two you can differentiate based on "clock-names".
> >=20
> > Choosing to use the internal clock if an external clock is provided
> > seems to be a software policy decision, unless I am mistaken.
>=20
> Agreed, though it rarely makes sense as if someone put down a precision
> clock they normally wanted you to use it!
>=20
> So as a general rule we don't both providing policy controls beyond if
> there is extra hardware (external clock source) then use that.
>=20
> If someone has a good reason to want to do something else then we can
> probably figure out a reasonable way to control it.

Yah, I figured there'd be few situations, outside of maybe debugging
hardware issues, where that internal clock is more desirable to use.

> > > > Finally, if the ADC has a clock output, why can that not be represe=
nted
> > > > by making the ADC a clock-controller?
> > > >  =20
> > >=20
> > > Was not familiar with this/did not cross my mind. So if xtal/ext-clk =
is
> > > present, the driver should detect it and disable the option for clock
> > > output? (Common pin XTAL2) =20
> >=20
> > Yeah, if those clocks are provided you would not register as a clock
> > controller. If there is a user of the output clock, it should have its
> > own "clocks" property that references the ADC's output.
> >=20
> > Your dt-binding could also make clocks/clock-names & clock-controller
> > mutually exclusive.
>=20
> That would indeed be the nicest solution.  How this has been done
> in drivers has somewhat 'evolved' over time, but this is the nicest
> option from point of view of standard bindings and clarity over what
> is going on.

Yeah, I know that this has not really been normal thing to do in some
corners of the kernel (ethernet PHYs in particular I think have been
rolling their own clock controller stuff) and I've been trying to push
back on these kinds of things for new devices.

Thanks,
Conor.

--dlghW/7VOeuyh/eL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6qfAAKCRB4tDGHoIJi
0vMQAQCkGjF6Fel/gAV0+3hyoOgjeGJlUQke4fQTA7TAyHhtgAD8D09ND39sB4Fl
GkrIpXdiwl4J3kvcv2KuxONa90Pj3QY=
=LJJG
-----END PGP SIGNATURE-----

--dlghW/7VOeuyh/eL--

