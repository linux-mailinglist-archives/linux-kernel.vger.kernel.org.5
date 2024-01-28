Return-Path: <linux-kernel+bounces-41836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F164083F842
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA31C22ADC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833D2EB1D;
	Sun, 28 Jan 2024 16:44:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC55A2D03C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706460247; cv=none; b=l32IGELjPtHLfR4sK3erw6h+Trtc+rjKudPatyfZ/efQxmwZyv1/VHbJ0cLob+uO6Wxs4WVNFe1+XB1XRZHZczQFmM9n4fDhFA8jcZLpOJrR/4GcChOrGyvRh7EAdFX+7Jld9rDUJ8VHyjSIMhSDGTeFD9VGzvz2dGUHgdM0/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706460247; c=relaxed/simple;
	bh=EmgOgNfJOoUg/I2634CBEsy1X290BU37QjN2TFLRu2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7a14NrnegyezIBFDV/63tDB8QlF2WgphpE50i2egT2pHF4FyyRUXjCg1h0H/Z6ONrwhIr6RLY/vB/AF9u67paLFComb3BD/+HdVYbgHMvsV6AxtpEJb1SPZaLbFo6Z87/FdpsxqfTHpAWMliNy9ikVRcbma44jBgbSXeKT00nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8Fv-0002V2-20; Sun, 28 Jan 2024 17:43:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8Ft-002z8T-Uv; Sun, 28 Jan 2024 17:43:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rU8Ft-00AGqM-2m;
	Sun, 28 Jan 2024 17:43:37 +0100
Date: Sun, 28 Jan 2024 17:43:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] backlight: mp3309c: Use pwm_apply_might_sleep()
Message-ID: <apuuk7hi5233xi2ujou4ndovlkq5qr5rgbkoij2jsfi7rwxgbi@2nie6c53ru3z>
References: <20240128154905.407302-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvi2qh5kgw6q2equ"
Content-Disposition: inline
In-Reply-To: <20240128154905.407302-1-sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kvi2qh5kgw6q2equ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Sun, Jan 28, 2024 at 03:49:04PM +0000, Sean Young wrote:
> pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
> pwm_apply_state() to pwm_apply_might_sleep()"). This is the final user
> in the tree.
>=20
> Signed-off-by: Sean Young <sean@mess.org>

The "problem" here is that the mp3309c driver didn't exist yet in commit
c748a6d77c06a, so it relies on the pwm_apply_state compatibility stub.

I would mention that in the commit log.

Otherwise the change looks fine.

thanks for catching and addressing this issue
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kvi2qh5kgw6q2equ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmW2hDMACgkQj4D7WH0S
/k769AgAuhICKH8tjWxmVW/U6B4fj9zEKtlPa3ebg5wrtKvlXBuwKhif676Epb1q
OCvuQNg5wsJ5MSngBPzpoGK+AL9Ew4oRzlNl+AUCpJUw/6IlhZXw/Ga0TLCdVuig
a6kz+rAq4/NDOck8BAhOqBjoo6xM4/4GDQaV3E39lJPQfZrtXWpJ407w6HvXor//
x9+7x7oIL3bLkBboHzkRFChlRvqsj6HIYLI9RNpBlJiu2MymHIOgN0SyyFILIA4Y
fv2DNlEZjceu6ubg+JdHd9nUFUDftD+bt979N6q8BXv9oz1nq/qTIpELI/f2UotK
NogEFu3nSIG56vcJAJZIimQ9qxbYtw==
=nndy
-----END PGP SIGNATURE-----

--kvi2qh5kgw6q2equ--

