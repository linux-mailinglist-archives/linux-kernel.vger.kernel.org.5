Return-Path: <linux-kernel+bounces-29135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE5830958
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B59E1F218FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22672261D;
	Wed, 17 Jan 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUADrWpV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A44225DB;
	Wed, 17 Jan 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504340; cv=none; b=ViDSSSam/1kPp9cWt2WDNyIHS8d3NZaXIgHNVAhPGNcqYpcBQ9y2EGYVCR0nG5nSXmpjSG/P/so/4fukx7Sgq10fgZJdv5LR1m26bKqe9kr4eTakuzGXUhNIYsSHG/gl7eq0hkBdwOjBv08nw1tbO/FdnLA13JplYhNnRFLMaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504340; c=relaxed/simple;
	bh=A34tDGOyjAsdjOUsmbUUAZArIqY5t5xrNGVo1R3xsl8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=UEX0n0w10jOAlDDPtyvoVEAu+9jZlylpUn+SGVobGVLqoTugRNj428WH4epEH07Oa/hNJhwooSPdsgwHsEvweA4Lt6c4td8tg3+pPnofdjNGn2HfxvfC9d/aawsEbNszgwhR/YqEvgrTEHGIwJzGZBSVEaeGKh/tt5BWO//sc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUADrWpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EFAC43394;
	Wed, 17 Jan 2024 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705504339;
	bh=A34tDGOyjAsdjOUsmbUUAZArIqY5t5xrNGVo1R3xsl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUADrWpVR/Uh/G90UDB9uyE8Sv2+CswU6qdMlBPrM1g6LCEUVO2ry3Jo6StjLjmE/
	 QDJnRRprGq5yIHIr7/4y/OerT4PVr/pslwuAosBTeVAOV32QMFVgT/33jAAL9NpisL
	 HAQuNRHCqi4aVTqljfjfDK64KIk654MSDzyZDOJ2Sn0VI9vRevvUfmJc6S7bQIBd22
	 pc3cqWNfMxGXdbZC42cWNiZq5rVWvyY4989o11tH+H76p6R8GmypkAZKzMuccV1xWj
	 DeZmCbnE0CSNAYx+cIvY5jZ7qRuepoCGKe7jevKi0wmKgrtMkX8ihL8De1MC5vE4gx
	 L9L1wzOKO4Udw==
Date: Wed, 17 Jan 2024 15:12:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
Message-ID: <20240117-endurance-caliber-e3424450d291@spud>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aLyhfwRZwwPVc64g"
Content-Disposition: inline
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>


--aLyhfwRZwwPVc64g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 08:56:16AM +0100, Krzysztof Kozlowski wrote:
> Drop the requirement of "-master" suffix in node names because:
> 1. "Master" word is discouraged and MIPI Alliance renamed it to
>    "Controller".
> 2. Some devices can operate in Controller (Master) or Target mode, thus
>    the name is not accurate in such cases.
> 3. Other buses, like I2C controllers, use simple "i2c".
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--aLyhfwRZwwPVc64g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZafuTAAKCRB4tDGHoIJi
0qOUAQCiE1lrShOfXW5DHVs22SCv9n0E+X01iWyVhRYwByKe7wD/WsaG8wOfwFiK
a4TeDt3owTN4VnKqNpdfHPpPnU9H+g4=
=PuQ9
-----END PGP SIGNATURE-----

--aLyhfwRZwwPVc64g--

