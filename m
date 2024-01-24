Return-Path: <linux-kernel+bounces-36673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06183A4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED30B1C21B16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519DD17BC5;
	Wed, 24 Jan 2024 09:02:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1017BAA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086974; cv=none; b=XAAy0rNOJxjidFB3lgzqFlqOnDUvyngttbH0SD2k8ahQrrjFebx8pjjMrTB90V3nL49AgoGtOYayu8mGefcSQinx5MSsRFi7Ct8IieHzdOqsi2nyMB5OethQKnZ0F+O3ikZGYN8qqImpAa5qUCcU8bTMq3wczr0bpL2a/xHlzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086974; c=relaxed/simple;
	bh=IUzPpBw3waxXsmF2u/OJpdQqbjdb1ELOjeunXCIZSuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRuaOG+BcnEnfnQPV0DqFWZEM6/nus+YdcWjQxXnWGhQO/paF8vF8FjkZHLKav2DaAkh6GzolebX46dCKmG6Dz6/8VbKOzmshVh97mtTbiYk9YBcQOZO1/HtcH2mGPuQLVFH9V2C8omZ/agwakYxJI6JjgZ/TEGUeZhMMICAcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZ9d-0001F3-HK; Wed, 24 Jan 2024 10:02:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZ9c-00217d-KQ; Wed, 24 Jan 2024 10:02:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZ9c-0070Sy-1j;
	Wed, 24 Jan 2024 10:02:40 +0100
Date: Wed, 24 Jan 2024 10:02:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 5/6] pwm: meson: don't carry internal clock elements
 around
Message-ID: <gyhea42rtydw3g45lfkfbxfm6xcbwibz67vw7xke2sm7powz2a@i33g4pyanu4l>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-6-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h373wi4nrohxmd3v"
Content-Disposition: inline
In-Reply-To: <20231222111658.832167-6-jbrunet@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--h373wi4nrohxmd3v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:16:53PM +0100, Jerome Brunet wrote:
> Pointers to the internal clock elements of the PWM are useless
> after probe. There is no need to carry this around in the device
> data. Just let devres deal with it.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 67 ++++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 15c44185d784..fb113bc8da29 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -90,9 +90,6 @@ struct meson_pwm_channel {
>  	unsigned int hi;
>  	unsigned int lo;
> =20
> -	struct clk_mux mux;
> -	struct clk_divider div;
> -	struct clk_gate gate;
>  	struct clk *clk;
>  };
> =20
> @@ -442,6 +439,13 @@ static int meson_pwm_init_channels(struct device *de=
v)
>  		struct meson_pwm_channel *channel =3D &meson->channels[i];
>  		struct clk_parent_data div_parent =3D {}, gate_parent =3D {};
>  		struct clk_init_data init =3D {};
> +		struct clk_divider *div;
> +		struct clk_gate *gate;
> +		struct clk_mux *mux;
> +
> +		mux =3D devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +		if (!mux)
> +			return -ENOMEM;

I don't like this change. While it doesn't increase the memory used, it
fragments the used memory and increases the overhead of memory
management and the number of devm allocations.

Are these members of meson_pwm_channel in the way for anything later?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h373wi4nrohxmd3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWw0i8ACgkQj4D7WH0S
/k683gf9GGBr93JUCS2xEl/m1YAKTTgHqxB2JExfwiC6KJfo/FURTvQbLwW4gtu9
BqujrqKJuEIj5YPmfS2DfmnGEQteeSmoeb6vtHwsKyehVtqSqDOF/1ZPSIakbMdx
hE3kSBmZVCVPwj9s1JoNAlR+AtWRnzVYUdF40iEjJ6VPhWZB9Swh9KJhNfWAuUIg
KxSIivAcwtRrtX9ThjzjKj5sPWGqdaVGTFxir66leKCCmsboGdDOAV60d39u0bSY
cDXdp36+vG5DQh1bpjAUE7S/+URvABaCmV8CKBRpMSfyxLo9M65b8VlZS1Q36pl0
ljk2vMhvu45fpewQYEgUv6kO82pUfw==
=J1Jy
-----END PGP SIGNATURE-----

--h373wi4nrohxmd3v--

