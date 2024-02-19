Return-Path: <linux-kernel+bounces-70641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B23859A99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7632813AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1651FC8;
	Mon, 19 Feb 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nps3WOc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FD810;
	Mon, 19 Feb 2024 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708307970; cv=none; b=ShakKUnU4EMLXPaUpB9glqS46YwrkxiFRWir7V3ecVBySwPZEl6PAE8iORmo41G5FVSQJZ0Em1rlXTjft2TUUKwzNwsWKP53QWxEEAoJXJ/hQ7GN8BI98Ub/MqibWtzrGapz+/Ayiqa6kZE5jwcv+oJY0fIxSTkr8UGVkX276kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708307970; c=relaxed/simple;
	bh=H0r59aUP52FMwFT9xemyKEWcqTDK4960Ordka6E2bcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S82is5Xj6rzKPCAxPBpJ2EP/Xh7MgKQ6ehcdjDEXp1ez2pL+95Alo3ZEf46GUYeJmHwuUvqP0w805JKozhQ6pWjkV/gkqWA469Yxua8063U2choJoTLPzPbrw5vvUUBeKV3yx+VW/nDGvL0LPUo15qVJAm0gEucqgRbOw0PB6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nps3WOc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B7C433F1;
	Mon, 19 Feb 2024 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708307970;
	bh=H0r59aUP52FMwFT9xemyKEWcqTDK4960Ordka6E2bcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nps3WOc3360GL59KSd9VDfYYmLHTAFp43smvyztbqhRI0IipZEKzhMA7THWb224/k
	 jbXTlZvrFeHXE9ZdgAz3kYszgECh5Pzn2k52FQyS0vXUF39Pika+Ak8r4fRoPRF0RM
	 64JD0PpVdGAo1R1KoH32Jn8XEW66EwvWWKpZuiBPCmRadARLLgxA2BK2cFP2DyYHfN
	 ydUDCegzd/c2ksbEMM8CuLTivWxXmxvA5L1mrJPLZuExyT5ogVryKjuOfh6diqZWsU
	 bkP6SK//MxiNAKncMP3wWvGhlomVS6adAVXpEGE8giqntiE/Cm/h/2Ti2B7PbUtNuc
	 9W5piOxJuGwDw==
Received: by mercury (Postfix, from userid 1000)
	id 9C9DB106062D; Mon, 19 Feb 2024 02:59:26 +0100 (CET)
Date: Mon, 19 Feb 2024 02:59:26 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/16] dt-bindings: bus: imx-weim: convert to YAML
Message-ID: <znyqirhcxfigmenthyrkpivraj43g23gbbx2e774uy3oc375dd@c6pmvckv3gjs>
References: <20240216223654.1312880-1-sre@kernel.org>
 <20240216223654.1312880-3-sre@kernel.org>
 <e3b54b1c-79ab-4f25-8b42-fadc922c0d25@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4pqq4oakpi55rbmd"
Content-Disposition: inline
In-Reply-To: <e3b54b1c-79ab-4f25-8b42-fadc922c0d25@linaro.org>


--4pqq4oakpi55rbmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sat, Feb 17, 2024 at 09:39:52AM +0100, Krzysztof Kozlowski wrote:
> On 16/02/2024 23:34, Sebastian Reichel wrote:
> > +properties:
> > +  reg: true
>=20
> Your pattern in weim schema suggests you have here minItems: 2.
> maxItems: can be 2 or 255.

Which part suggests minItems: 2?

It's minItems: 1 with each item consisting of two address cells and
one size cell. Most in-tree users actually have exactly one item.
The only exception seems to be arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts,
which has "davicom,dm9000" using two reg items. Considering this is an
external bus, any number is possible in theory. Should I keep it as is,
or use minItems: 1, maxItems: 255 instead?

-- Sebastian

--4pqq4oakpi55rbmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXStfcACgkQ2O7X88g7
+po+XxAAkw0sUKydUAzk8VOe0KFYWi+6WzNOk43Y+/2NuhG/1+G5Bx+EF/QJICNa
4L9vvi1xsNkoatYs0kuijJrqUoms99yBRqjiga5dmAIptFXT9XJCZbduY6BTbp3k
eM4ASa21krMrPbYNYKVTw19dv/bMIHKt7XAM5HMjUH4GUhstzGggWMjJB+UMmxJC
J/nZhn9MQfZwAVnQP7+tKTSVR5J8AEzNajWhpGOrLgOcD2pGhTB+TATDUv0WCaeY
tb+fD4iIV0yOSkj88UFkbO+DgEcDAfnNESQY7e+DyCMxNHBFZ+5iElVfba1FO3w1
XPm68VNY8GN2LaKjkb6ZiR4KGfX67rAPH8HZJKSgwvIFvoxgZ2qz0nlUliexsafc
scnXwjdlxDPwCUaSXzwmM9maQ+i0qBMAwZbiyd+w+g9hpc/wZBZQuDxTTpvy6eXm
A/w7kFvZA3k3mBaHfCy+sHanPS6SX1EP/kMfqe4S6ZM/XjLrjq6hxWmxOfBmcHtw
rRUqftizHby0u2fCGl9RWzaeUU6M2Ybl1c2K7OxXp58q4l6baFrr3r/+l6ELZ67s
DYe3HACtPQ8h61iz3KLQesZkkIpx9XMoUTz80vfokpNtZ5PFJcpz2+Bu8kncyvsx
P+XtkrI6D3A/+rHAqsMXljgBi8h9VtMFVje/ZhQDkrE7LTPw2/Y=
=t86p
-----END PGP SIGNATURE-----

--4pqq4oakpi55rbmd--

