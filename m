Return-Path: <linux-kernel+bounces-80934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE2866E35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5362852F9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37354BEF;
	Mon, 26 Feb 2024 08:44:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8255C05
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937065; cv=none; b=jV2LiBceANYOGf9O/+0R5foX060/Tl3WzV6gjzrN6lEau9iDxK+C4FDheA07x2EDQ9jesMe8QvUqtnEJne82M29U/ovblZ7CkyX88ytQRFrpb/LY0AFON7E2Mj+4XKgAF8JRguONZTPQ4b7DtDwOg6iMneX6vHv31113nBLAp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937065; c=relaxed/simple;
	bh=14h6bEt9kyYrSJWXkUqMar7Y0aGg2X9iIPMlMIea9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvSYgKqK8Z7WoeoRMCdxFj7RTbWBO8L9jYWYuvDwQcloWt3AHr513nEA34vO50Ori2QHPOeFLGfuBlZTKNcnbTFHcN7TLYkNPaWNCRQ1fb1T4ODoHo80FkBIDtnVDGIGFn+P2o8/PDzsud2ezh1CtI8pVXYqwlTW49nnvFw5GSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWav-00043K-Bh; Mon, 26 Feb 2024 09:44:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWau-002xOT-CL; Mon, 26 Feb 2024 09:44:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWau-00BVlo-0w;
	Mon, 26 Feb 2024 09:44:16 +0100
Date: Mon, 26 Feb 2024 09:44:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Leif Middelschulte <leif.middelschulte@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Leif Middelschulte <Leif.Middelschulte@klsmartin.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] pwm: imx27: fix race condition .apply,.get_state
Message-ID: <qucbpwau55tuaf5m5fqpsbub2bbtxcye4djxwrwkabssd2vc4j@weuiawrzbbnn>
References: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
 <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gx6q65kgn6hbj44y"
Content-Disposition: inline
In-Reply-To: <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gx6q65kgn6hbj44y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Feb 24, 2024 at 12:29:00PM +0100, Leif Middelschulte wrote:
> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>=20
> With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
> register in .apply(), the register is read in .get_state().
> Unless a period completed in the meantime, this read yields the
> previously used duty cycle configuration. As the PWM_DEBUG code
> applies the read out configuration for testing purposes this
> effectively undoes the intended effect by rewriting the previous
> hardware state.
>=20
> Note that this change merely implements a sensible heuristic.
> The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
> cannot be read back in its entirety. The "write x then read back
> x from hw" semantics are therefore not easily applicable.
> With this change, the .get_state() function tries to wait for some
> stabilization in the FIFO (empty state). In this state it keeps
> applying the last value written to the sample register.
>=20
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>

Another few things I noticed only after replying to this patch and
trying to apply #2:

 - Please make sure you have a S-o-b line for the sender (i.e. you with
   your gmail identity).
 - My reply to your klsmartin.com address couldn't be delivered, The MS
   mailserver told: "leif.middelschulte wasn't found at klsmartin.com."
 - Please start a new thread if you send a v5, as applying patches from
   a thread containing many patches is a bit less trivial.
 - Consider using git format-patch's --base parameter to document your
   patch base.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gx6q65kgn6hbj44y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXcT18ACgkQj4D7WH0S
/k5/1AgAsv7GIPFu33eJYqefznjKB5CWEDraqN7l2mBgZ1sW9MPtWm9AvON87WET
0az+MsQVtH4wN1BcZa+3SgKY+Q1r56+FOaD3Y3GUdkEvEvIWLK+EQppYooHMaacK
IaS+hRJwoFqzrGjjzlqQRE5vXN0szSjgOn/zFYq0vfMsQohd8ibY+5SdtaBwfSlh
bTPt5MnqBCfzMEG9r9MVwZrdyojy3/BSgeutK5AKZr1KWsNQ3pwDm4414ChL2tVw
pjxRedvVYk6ThHO77XOxXzjrietgeh5D6Bg4r5wWwTrjENtK//h+843O8C0dCT6v
QnBgwigIWpRgcen7zPGO7VfclV8pQg==
=+JRg
-----END PGP SIGNATURE-----

--gx6q65kgn6hbj44y--

