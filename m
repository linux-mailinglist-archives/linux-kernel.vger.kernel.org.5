Return-Path: <linux-kernel+bounces-157061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8F8B0C59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19141F274E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D615E5D0;
	Wed, 24 Apr 2024 14:19:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5B15E5BD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968354; cv=none; b=Au7oUhlUFKruHqE6VDfFQOD1fAK2htFbkgBp4pND5C1lyagYhYQq6RjIJxQ70auZHAhhNEuDAnufNqA7e+xS/b2CDLjm93yt27+w0MIUsydrL628ClR1DG5H/NMpRMwQVpw1lPln5pqy8LY3zPMtj8lw2UqZMm+WacgDwdbrphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968354; c=relaxed/simple;
	bh=7OfnhU8HUosrXlE9LscXGpZNCgqv6yIHtmXb1myfwM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsuRG60VE+Cu/sGVvBmYftVVKzXPUVfO/hi3OT0vKV6q7/ttUW8oyKZomG0wvOw2PN38XgUB+wt4Na3SnhNn19B9bHtO5xte9ydbMtP72VWEg1UatydZlilmG2FsreT1SC/lDuHEpAlH+jn68GsLPlMZabauzFZKCYsNtKKdM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzdSj-0003vP-Nj; Wed, 24 Apr 2024 16:19:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzdSi-00E638-Nf; Wed, 24 Apr 2024 16:19:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzdSi-007q8K-23;
	Wed, 24 Apr 2024 16:19:04 +0200
Date: Wed, 24 Apr 2024 16:19:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, thierry.reding@gmail.com, hkallweit1@gmail.com, 
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v2 2/2] pwm: meson: Add check for error from
 clk_round_rate()
Message-ID: <xb2prc5ewslr74eh22xo4heeiepeiu4rb72zekuatcuhp45p6s@nhwhnq26tthg>
References: <20240424132408.2565916-1-gnstark@salutedevices.com>
 <20240424132408.2565916-3-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fikxshr2mxc6iptg"
Content-Disposition: inline
In-Reply-To: <20240424132408.2565916-3-gnstark@salutedevices.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--fikxshr2mxc6iptg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 04:24:08PM +0300, George Stark wrote:
> clk_round_rate() can return not only zero if requested frequency can not
> be provided but also negative error code so add check for it too.
>=20
> Also change type of variable holding clk_round_rate() result from
> unsigned long to long. It's safe due to clk_round_rate() returns long.
>=20
> Fixes: 329db102a26d ("pwm: meson: make full use of common clock framework=
")
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>  drivers/pwm/pwm-meson.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index f4d70da621ec..d4228ac1e7ea 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -148,7 +148,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	struct meson_pwm *meson =3D to_meson_pwm(chip);
>  	struct meson_pwm_channel *channel =3D &meson->channels[pwm->hwpwm];
>  	unsigned int cnt, duty_cnt;
> -	unsigned long fin_freq;
> +	long fin_freq;
>  	u64 duty, period, freq;
> =20
>  	duty =3D state->duty_cycle;
> @@ -168,9 +168,10 @@ static int meson_pwm_calc(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		freq =3D ULONG_MAX;
> =20
>  	fin_freq =3D clk_round_rate(channel->clk, freq);
> -	if (fin_freq =3D=3D 0) {
> -		dev_err(pwmchip_parent(chip), "invalid source clock frequency\n");
> -		return -EINVAL;
> +	if (fin_freq <=3D 0) {
> +		dev_err(pwmchip_parent(chip),
> +			"invalid source clock frequency %llu\n", freq);
> +		return fin_freq ? fin_freq : -EINVAL;
>  	}
> =20
>  	dev_dbg(pwmchip_parent(chip), "fin_freq: %lu Hz\n", fin_freq);
                                                   ^
With fin_freq now being unsigned, this ------------' should be a 'd'.

If you want to still extend your fixes series: A bit further below there
is

	cnt =3D div_u64(fin_freq * period, NSEC_PER_SEC);

=2E The multiplication there might overflow. This should better use
mul_u64_u64_div_u64() (or one of it's variants).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fikxshr2mxc6iptg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYpFNcACgkQj4D7WH0S
/k6FHwgAgAJd3kevEdN/itUIoFGC4HyfsHU4mupmXhK8vQlLQeSLp88NOl8o4aq1
krOsXkTeyPpYboayP13PMoNCEalGdGz0u1O6YRT7zhNmjTgho+BDeC5aYheIFNEr
sBop9BWBnlUWXxKJNvv89YVYJX8/gm1lYUbJ+aY5cp4x1Sima7d81bIU6XGrKwZu
Kay2eRvXf9c8F2WpSNhTS/NlQWOFZYHUQujWJKBUOQuIc6g9q916JnX9MalzD25a
3sP5sShWiSiNdGJ0Z9oVqmWU4O4A9o3WZHYWg3mZme79PTQdVIO9oIcOMMUOiKm/
t754lFYORol+j34xFOkG3l1bcOnwpg==
=xYuN
-----END PGP SIGNATURE-----

--fikxshr2mxc6iptg--

