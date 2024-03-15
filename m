Return-Path: <linux-kernel+bounces-104456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF2A87CE23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41661F228C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC12CCD3;
	Fri, 15 Mar 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqYoumkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82C28DA0;
	Fri, 15 Mar 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509613; cv=none; b=apgjH8ZhaV2lSxLetYMbZPqbbVmUdaE6N/fHDUiYjLCnebU9CiiPLzLov9ABKzzG0YMGdSiAWisuYyNnIrkRqMfsVAvQ5m/0+H1dDULZeAt8dIGSJ2QJ2QVwI2OZtKTxwoSOjd4T2hC8yBlnDsM//CuzRJlm74n2DchKYtD4m74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509613; c=relaxed/simple;
	bh=JfFjAgEhqLnBfKgjQe9qzywYHRntA6N/TCPrlY0SO3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELZo2xPsH/fn1RoMPBip4mIgkzw1yuhCnhIultfmTdjPMW6nkdJB4/Z7QqsvWrijsQuN9lvAcdjovEYMHHxznevAfGg6G9AOvmadj+yPhgGTk2HS1TQ2q5eM/vxyfZ2rfA1c1HGFvMXzWU5KaPZfbOr1XnLxv160rHXH/pd5h6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqYoumkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1682EC433C7;
	Fri, 15 Mar 2024 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710509612;
	bh=JfFjAgEhqLnBfKgjQe9qzywYHRntA6N/TCPrlY0SO3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqYoumkNxTsioqSB8CHVWJv6WqJg7w80kOK6LuxD1ntomlPu2KhueYUskFagoOWcV
	 +/GjL/DAHUdcNR9lvwtkhKtwlRxaMhAv/b+c2X1Wr1J/+op42sMSrJYd11dOIStcRe
	 sD8Wsy1gnp7j/MgKDTbm6sc1Vi6hOZ9PwGlNWJBVz5Hl5puzNVm+BIwNOYT7l3I9Up
	 q3w9tASq5ZFgvWlIwcQlOstwahLObdzOuPViX3fhg+nIJyjfoqcWW1G4cdjJUe6JVh
	 40RmBTRBjMvoflBe/rhfxo04DMidctU7GO2AIDeYBE4zZ0/4hurR2VoNINr8LCSNyE
	 FFrSLJjsySVZQ==
Date: Fri, 15 Mar 2024 13:33:23 +0000
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
Subject: Re: [PATCH 09/25] ASoC: meson: g12a-toacodec: add support for A1 SoC
 family
Message-ID: <2a41e8b6-7e8a-4995-a1d7-c5d30e53c2d5@sirena.org.uk>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-10-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="whZtyi24go8F2IXG"
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-10-jan.dakinevich@salutedevices.com>
X-Cookie: A well-known friend is a treasure.


--whZtyi24go8F2IXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 02:21:45AM +0300, Jan Dakinevich wrote:

>  static const struct regmap_config g12a_toacodec_regmap_cfg = {
> -	.reg_bits	= 32,
> -	.val_bits	= 32,
> -	.reg_stride	= 4,
> +	.reg_bits		= 32,
> +	.val_bits		= 32,
> +	.reg_stride		= 4,
> +	.max_register		= TOACODEC_CTRL0,
> +	.max_register_is_0	= true,

If the maximum register is 0 how does the regmap have a stride?

--whZtyi24go8F2IXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0TiMACgkQJNaLcl1U
h9CfZwf9FCsJlpA0ZVHlgM+29kv/xJWAC/kxB2g9thms8cg6YPHLUd9VqS+DpK4u
Q1506N0mbJUukxVui6tAnM0IUp+AZDr/ZmpdA1+qqTmHXWJYdGW9AlLdwMKLrURg
HfnYEEeIqCizK2nTTVhOJfkIR9W7ynS35aFJvmsO4BYd1LD4eh4SeD+Qg+L+rW/p
rmEIYL1arUZjZy0n7oFuinL7TImzcPP64lNK2AN9ilTmp5QtoV6TX+Vs/3bifpct
GmTkrmSC7N+jX9S9djridoNIVNXjWGZIofNCpNZbOm+vnkwmAZ+jyKz5uPt+twrQ
R4METAHd4l9JPhWejRP3JBTwMZ3pug==
=VGfS
-----END PGP SIGNATURE-----

--whZtyi24go8F2IXG--

