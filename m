Return-Path: <linux-kernel+bounces-76816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5A85FD05
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CB288648
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6314E2F9;
	Thu, 22 Feb 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoFDFmH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520F39FC7;
	Thu, 22 Feb 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617049; cv=none; b=gNsB4KP2Z8jpHc8B56x+5qRqd0mo/2/Pn9LJnzCc/H5nMWnGCOhsvluw50QTfl5QkYs8Kvg7awnpXKoF2I0vqK/JdY1IVzgV8zdQHaVjcbUBxhU03Os+0lJAeVFKijiebWMSyjUBY65cw9oQZjBvq8tUVWbS4O9OhR2zVFdrVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617049; c=relaxed/simple;
	bh=qrXeUMXMXQQJJinBxkYIkgCdWWGqU0eYOxt+Ka3y1ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCRA1JoYvxu2sDBMnXcXgsaGtL+n9PAJH1hgNfBGhP9Rag5rXOX7QOC7pJUqR9huVrLG5LJ2AscneMofxD4UdsPpmfCLcud1kTKf66jjCpju6bx1gGrzCin6/eqDvmSof2huSzQFQPQqgEUiGJhLNhTRpv68GTH5I1k6URBgw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoFDFmH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF8C433C7;
	Thu, 22 Feb 2024 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708617049;
	bh=qrXeUMXMXQQJJinBxkYIkgCdWWGqU0eYOxt+Ka3y1ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoFDFmH8MtmBaZbxh9Y+QXZPIt/GC6HK+hBtylJmUMaqLtO4EmJ/I2wtce0rU7hw/
	 rRPodZCBceiYLQm833le+XLO/jj43g0dUfEeLrH9yohMA0s2GvjyKMx7Hm+Esns7TV
	 U1nXMDSjDJR95Ah78N13O6kXWP+ASblmMZLQlzzgma9hE9oll3HzDUeKZ73rEuHZ4r
	 q5CzQ9+A7mMBRfz/Jj5j5pJlzJVQctOXfC3nn0p0fAry0/BbgUYq0LMawNAeAIbW8a
	 6TfsQ0EO8Flq6ESot/6jC4c2oWDiQhIOquGJQJqm5O1Ij9KtmQnwWVk/s+3HkmNiMK
	 wE3O/5ZfWxz8g==
Date: Thu, 22 Feb 2024 15:50:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
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
Message-ID: <20240222-defeat-nearly-f83f8b920f51@spud>
References: <20240222110817.29670-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/1zEzl6q9dQoOtWc"
Content-Disposition: inline
In-Reply-To: <20240222110817.29670-1-mitrutzceclan@gmail.com>


--/1zEzl6q9dQoOtWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 01:07:41PM +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
> V13->V14

I gave you an R-b tag on v13, conditional on the descriptions.
Why didn't you take it? The only other relevant change is the added
restriction on channel reg. Is that the reason you didn't take or was
there smething else.

Cheers,
Conor.

>  - Refer in descriptions of the avdd-supply as AVDD1 in concordance to da=
tasheet
>  - Fix typo
>  - Place interrupts descriptions separately for each item
>  - Restrict max channel reg to 3 for models AD717x-2

--/1zEzl6q9dQoOtWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZddtUgAKCRB4tDGHoIJi
0nVIAP9CGmzcWRghRruPsZKM2A2VV/WKUkjaNA/s2KPcfRq5RwEAnMkRBLYeguK4
YwxbFkkSlG2NKIpNzstT+JArt8H6cQ8=
=eZG3
-----END PGP SIGNATURE-----

--/1zEzl6q9dQoOtWc--

