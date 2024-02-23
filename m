Return-Path: <linux-kernel+bounces-78991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B3861BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EC51F28BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6212AACB;
	Fri, 23 Feb 2024 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmXLdPF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212D79E1;
	Fri, 23 Feb 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713550; cv=none; b=oN11wqWV+7xh1HjlQOcUhOCcGSnYzDsmfWMLeI0NxtckB6tTfuQ2jovvdeQ86I+4behlHmidHwRUhAlEhFqMKnW7gSTchCt40MDOxCTueP5nmuHBz9xmWfX8M6uGTk4cell9fB3HjbWlCSQBFOeaVtsNEecFo3soVH1byUPDh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713550; c=relaxed/simple;
	bh=QDS/QxStd3bhILl9B7Zw7Z+1WM5UW/bFXxfJUPfdC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9gycRyjqdtgkK3PFf1mCefMk753zC9rbcLc4gV4bJYRe+mgnj0qFmuaeWjBhBn2yHX1T0DMpgks7n0XqgxI6HD6E5n7ZAx3qXDnh8FAy2Zq2Kl69XoRDbaTJcQUB2jxnLkJQ7hRokvCCOz3FRaW6n/ULVSg0EdeUHDP4y2TlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmXLdPF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239DDC433C7;
	Fri, 23 Feb 2024 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713549;
	bh=QDS/QxStd3bhILl9B7Zw7Z+1WM5UW/bFXxfJUPfdC28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmXLdPF139JNdqBsbwivVNXxXpI8O4IIPi6oD0xfiNSYq44zT0Rz8ubUFARKtApGf
	 q3pSXcAxybYkgEr13duA3JtvjKzdoYqObTgdoS+H6XbnEQcBkA5octcdFmZy53XgRT
	 KSVo3ij20soSJdLjoMpPTiH+yeK1S6pTwpTpX5WNv7JDnATb70MayFu4SMQ6Y/+FhO
	 odMh//gkqAQcP1SOIWRVLK0/YbTWOeZbqheIw85hPvGRMMRxPHPhfy2/e3dTJi7tzG
	 o05+WaPfGsaOp7aq1n3FwTJHYoFtLofRBOra+WrRS3oDfjANP9eQXwJJxyOMMVYKcD
	 EuIoyXOARrJ1g==
Date: Fri, 23 Feb 2024 18:39:02 +0000
From: Conor Dooley <conor@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
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
Subject: Re: [PATCH v14 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240223-verbally-morbidly-fba33804a8b4@spud>
References: <20240222110817.29670-1-mitrutzceclan@gmail.com>
 <20240222-defeat-nearly-f83f8b920f51@spud>
 <f2fe30fb-3dd6-4190-8ca1-fc579a06f452@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+fXBT8W8px1vHb6"
Content-Disposition: inline
In-Reply-To: <f2fe30fb-3dd6-4190-8ca1-fc579a06f452@gmail.com>


--x+fXBT8W8px1vHb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:12:21AM +0200, Ceclan, Dumitru wrote:
> On 22/02/2024 17:50, Conor Dooley wrote:
> > On Thu, Feb 22, 2024 at 01:07:41PM +0200, Dumitru Ceclan wrote:
>=20
>=20
> >> V13->V14
> >=20
> > I gave you an R-b tag on v13, conditional on the descriptions.
> > Why didn't you take it? The only other relevant change is the added
> > restriction on channel reg. Is that the reason you didn't take or was
> > there smething else.
> >=20
>=20
> Just that change. Should I consider that change minor enough to include
> a previous R-b tag?

Yah, you coulda.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--x+fXBT8W8px1vHb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjmRgAKCRB4tDGHoIJi
0osAAQCHLJqEVz4+C/Eko08gRV6zbAXQVRSTDKtb5n7XHZPOkwEA48QgDHs5hj3c
xHN2Bkw9otRKHyj0He3Vaqqmqm+h5gE=
=ghJ2
-----END PGP SIGNATURE-----

--x+fXBT8W8px1vHb6--

