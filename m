Return-Path: <linux-kernel+bounces-31945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE4F83540F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65EDFB2175C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31DE1F5F4;
	Sun, 21 Jan 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVURKBzj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B31E870;
	Sun, 21 Jan 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705799070; cv=none; b=pKSa1zBBI6PyNPgjndCJXM9t5FhYsBbpKHs1tK/WG/P2rUmvFA5BtcdoqAziM9OH2gpt+pnaRa9+mutZtj5+1xGo2UnapZZX9vOjR4qNWPOzAOUd1djd3xgYf5f8iKm3zeryqwJlN01SmtTEBoJBzcC/sm6tJDaN5XVh0iNEJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705799070; c=relaxed/simple;
	bh=d3XsdJmOrPceBBoewmuW2GJNC71GNXagT5eGFvKkFyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Tq2jl1vn1BFK4gkBJHNDAJ0AkRAROxH2fsaShvBCKgV+I7RHwu3c6OR2IGyMGgfZAwdkcYFZWSEGRI9C/6Rvv+Dv0S1bkzXcOKY4GN48AKf5/wBVvv4DwLNDb5dq+vxDgzgsR7ytjWkpMB+k8C4wBnJ9b1z3tTFUkMdb9iG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVURKBzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A34BC433C7;
	Sun, 21 Jan 2024 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705799069;
	bh=d3XsdJmOrPceBBoewmuW2GJNC71GNXagT5eGFvKkFyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVURKBzj+xJyBsvL4Hp5ZEf4Y1BburBTkn3HSSonkiyqUYQw910DdugQjvjVjupRr
	 QU2eExc7ZrjXtcVYPC3PyDhpVdfbub8Hat2hoZhtfeaSP8lALrVlVBs7BMR4uELmoC
	 mqsIPPcuon3uEX5ePlDtmPAU+jPi7v1EOIXLfbb85B/VKF5pNE/fD8kaKI69IyNUZQ
	 dkj5qxFhfvr5XbTT0MjEDVhtbqoptR73v7Bgz40vSEdtL1+PtzKzS1jIG0WdBXGMDK
	 jR+BUcv3NfWbVSkxP6jUV8FdsO1Lj87T9cIRYcsU9ql1TfdZ9bpTs6F4/8/EIZYlgJ
	 bekzpo8TMkTWA==
Date: Sun, 21 Jan 2024 01:04:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	tudor.ambarus@linaro.org, pratyush@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sbinding@opensource.cirrus.com, lee@kernel.org,
	james.schulman@cirrus.com, david.rhodes@cirrus.com,
	rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael@walle.cc, linux-mtd@lists.infradead.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, michal.simek@amd.com,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 03/10] spi: Add multi-cs memories support in SPI core
Message-ID: <Zaxtm0JlQYU0/K/v@finisterre.sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-4-amit.kumar-mahapatra@amd.com>
 <3d3a11b1-8396-4d8e-9bb3-61ecb67e7efa@roeck-us.net>
 <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gbj27IA6g3j5b4VB"
Content-Disposition: inline
In-Reply-To: <d3c93c4c-3754-480c-84c2-9455ec8af702@roeck-us.net>
X-Cookie: You might have mail.


--gbj27IA6g3j5b4VB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 09:05:43AM -0800, Guenter Roeck wrote:

> FWIW, the problem is due to

> +#define SPI_CS_CNT_MAX 4

> in the offending patch, but apeed2400 FMC supports up to 5 SPI chip selec=
ts.
>=20
>  static const struct aspeed_spi_data ast2400_fmc_data =3D {
>         .max_cs        =3D 5,
> 	^^^^^^^^^^^^^^^^^^^
>         .hastype       =3D true,

> Limiting .max_cs to 4 or increasing SPI_CS_CNT_MAX to 5 fixes the problem,
> though of course I don't know if increasing SPI_CS_CNT_MAX has other side
> effects.

Yeah, I was coming to a similar conclusion myself - the limit is just
too low.  I can't see any problem with increasing it.

--gbj27IA6g3j5b4VB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWsbY8ACgkQJNaLcl1U
h9Cd8Af/avJ6OwNEUdXRf7+Y/ez1nlW4KmF435+5Krs7iC0gW1bASAqTgK1wW/vH
Qn1dkyXEXhJr6D0AXzIaOBKg3k6gmKJ9AL0kbeMeIMsxj5f/2BYI62z0B8nx7dZC
Y3fMiOxEqHxwU0eWCD2HuzN/GxHD7mrLi5VEFCE572HROza7PRt0jFfRyy7GAfaM
BIfHMtCRiq5SMmya80D0iKJ9aZgeI0bf/DmzRVDOQnjo6sG7uCSyzPp4Rg1Z6wk1
kottzJ+R1VHbzCngl404KHzG8SBHAXxYOVxf1HqiBzSgJ2/aa/asAsV0mHnoccn9
5wKmraNTPzlncfC6l1dz4k3QPdXH7g==
=vqew
-----END PGP SIGNATURE-----

--gbj27IA6g3j5b4VB--

