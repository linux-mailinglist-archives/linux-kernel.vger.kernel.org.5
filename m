Return-Path: <linux-kernel+bounces-42817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD7384073D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97CA28AAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3AC657A9;
	Mon, 29 Jan 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKvyrcZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3B612FE;
	Mon, 29 Jan 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535650; cv=none; b=S22EwhsLIRvQxQj5EwLXj8HjTPdb1HENgAG4bjCwM8DTGpHDs4ut4/i0/rfA8AjUzdM81SppHeYnidANMUNLgR/lhnsmjwzvtP7t/Ns7ak64xaKV2ExiGlulzZRZDc6Cv5CahDHZLN+XntQTiyY32cloopATd41WS4IdsMuNaUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535650; c=relaxed/simple;
	bh=myYtOyQpPG13KAG+Jfjgn0hzsfD9Kx1Zu98b8RETqnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEeR2JDh2ciP1J0Mhx1Z80F6+LW0WBhpej0Ro7y9RP1/TiWaGTJ36POqTTZ/w44uocN6hdn6DO/VmiVAYbypyhWg4/jdbZWuomp9ZMSoiAqtWZLlSrPsFVsttbj+1CeACJyQdLskLQ0dC5Py8tIlLgOfthuqvZVB5yFSKdu08Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKvyrcZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9736C433F1;
	Mon, 29 Jan 2024 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706535650;
	bh=myYtOyQpPG13KAG+Jfjgn0hzsfD9Kx1Zu98b8RETqnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKvyrcZ7UjClhy7LEb2Fw37rHo77QPoiM+4zbmX8dA2tp90YgGt5gXUUyWBXpvb8o
	 p61PHtTg9Gw/Pg3V8ZRnltW500xu5TIWQ7ZxTs8prLIzVKwqA6ek5XUMOUbNxC+sRn
	 3CB3RW4khTD/jBvITNGq5zMLZ6QehQZYRr6WrHXmQyLXgIAqcd3ICkMYVSkRWSDkdo
	 53BHcGc/e7vzphQ2FGdOzfsd3P1MeClj61bcwwQGJVzfAm9qBbZnTqsdrJ6PkUDJKD
	 sgj0lmx4bMsil2WAGAUYBGL5rPf4MB84DxvQrUaNJrINb9KH1yYtvwcsUmojKrhLox
	 8neiCg+nICL0w==
Date: Mon, 29 Jan 2024 13:40:42 +0000
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"P O, Vijeth" <v-po@ti.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"Chawla, Mohit" <mohit.chawla@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
	"McPherson, Jeff" <j-mcpherson@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240
 Family driver code
Message-ID: <00acc379-2812-43da-aa14-4a43a0d25f79@sirena.org.uk>
References: <20240126035855.1785-1-shenghao-ding@ti.com>
 <6c1d04be-c558-4aa4-96a3-ac21ae36bfae@sirena.org.uk>
 <39804840911a44c8b9da9478f7b4c05d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gp4iAJ9213u/5udW"
Content-Disposition: inline
In-Reply-To: <39804840911a44c8b9da9478f7b4c05d@ti.com>
X-Cookie: Jenkinson's Law:


--Gp4iAJ9213u/5udW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 05:03:48AM +0000, Ding, Shenghao wrote:

> > It might be better to request the firmware in the I2C probe rather than=
 in the
> > ASoC level probe, that way there's more time for the firmware to be loa=
ded
> > before we actually need it.  That does mean you can't register the cont=
rols
> > immediately though so it may be more trouble than it's worth.

> I once put request_firmware_nowait in i2c_probe, but it sometimes returne=
d=20
> error in some platforms. So my customer suggest that it would be moved in=
to=20
> the codec_probe. It seemed filesystem is not completely ready in some=20
> platform during calling the i2c_probe.

That indicates that this is still racy - shuffling things around has
papered over a timing issue on their particular system but it's still
possible to have the card come up before the filesystems are fully ready
(especially if all the drivers are built in).  If the DSP firmware is
essential to the device's operation the driver should defer registration
with the core until the firmware has loaded.  wm8958 should have an
example of this IIRC.

> > Similarly for the reset, if we reset as early as possible that seems be=
tter.

> As to reset, it is also from my customers' suggestion. they found the iss=
ue that=20
> i2c access error in i2c_probe in some platform. So they put it into codec=
_probe.

That suggests the reset might be missing some delays or something and
again there might be some issues.

--Gp4iAJ9213u/5udW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW3qtoACgkQJNaLcl1U
h9DGDgf8Ddtf4ZwjLwPbD5U+SfhXdG5PnDKCAG+Dm/99/W5j65NEv4NLVzKe8GO6
1A+qnYNIQ+8pqs2PpaBUrrVTODhNOk5MEkICREVOVjNwDqmbOhGVe6vw3d9fiST0
VJOq6t1HQX4BV8TRuYWKr1FQQSc5OkzCccAnNleZrdrnVsQCR5XvzyaNtE1SXaYF
DJDZ3H6W1p1zOzeOGTErOha62WUjtaaAZ1e7cZmKp5mljc1BUkHAELBJCuUukMkS
QwnDiHApQ0XspY8efCWcvf5MYu2uBesQaEIxkCp9k4pT7g0iAmD12bf4BpasHeXy
CNyYPPIVDy9JB/DrXNJYCoFLw+4ULg==
=19Xl
-----END PGP SIGNATURE-----

--Gp4iAJ9213u/5udW--

