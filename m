Return-Path: <linux-kernel+bounces-15501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B79822CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C42858BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E781945A;
	Wed,  3 Jan 2024 12:18:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091518EC9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0CN-00039L-L8; Wed, 03 Jan 2024 13:18:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0CM-00073n-NR; Wed, 03 Jan 2024 13:18:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rL0CM-003LaY-20;
	Wed, 03 Jan 2024 13:18:14 +0100
Date: Wed, 3 Jan 2024 13:18:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: pratikmanvar09@gmail.com, linux-pwm@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, Pratik Manvar <pratik.manvar@ifm.com>, 
	linux-kernel@vger.kernel.org, thierry.reding@gmail.com, Clark Wang <xiaoning.wang@nxp.com>, 
	linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, 
	linux-arm-kernel@lists.infradead.org, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH] pwm: imx27: workaround of the pwm output bug
Message-ID: <sdqgerar4utskfvp2pxbjsjesf2s5zuxtlssur2v3kdvq5m7a6@jaueiad7zvcf>
References: <20231229063013.1786-1-pratikmanvar09@gmail.com>
 <20240103103421.GA3758@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oig3ms6c3h2nuufe"
Content-Disposition: inline
In-Reply-To: <20240103103421.GA3758@francesco-nb>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--oig3ms6c3h2nuufe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 11:34:21AM +0100, Francesco Dolcini wrote:
> On Fri, Dec 29, 2023 at 12:00:07PM +0530, pratikmanvar09@gmail.com wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> >=20
> > This fixes the pwm output bug when decrease the duty cycle.
> > This is a limited workaround for the PWM IP issue TKT0577206.
> >=20
> > Root cause:
> > When the SAR FIFO is empty, the new write value will be directly applied
> > to SAR even the current period is not over.
> > If the new SAR value is less than the old one, and the counter is
> > greater than the new SAR value, the current period will not filp the
> > level. This will result in a pulse with a duty cycle of 100%.
> >=20
> > Workaround:
> > Add an old value SAR write before updating the new duty cycle to SAR.
> > This will keep the new value is always in a not empty fifo, and can be
> > wait to update after a period finished.
> >=20
> > Limitation:
> > This workaround can only solve this issue when the PWM period is longer
> > than 2us(or <500KHz).
> >=20
> > Reviewed-by: Jun Li <jun.li@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba=
0e5a479990507816317
> > Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
>=20
> You need to add your signed-off-by at the end when sending a patch, no
> matter if you are the author or not.

FTR: This also applies to the v2 patch. I discarded both from the pwm
patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oig3ms6c3h2nuufe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWVUIUACgkQj4D7WH0S
/k6ytAf/UIcvOinV3MPezxtggAVXZ/zCrUR/WE0fMJhwd0PD1uOWXFt5wjEDkUzB
WxzrfbXSWpjcn1lwITWpxr74Mu7qJ4LU9ia+Mu3ApqBGOgc3qy+SuCMouSWthctC
MNon899rT1PFMT3TQRsKHW2fXLvlisMPv9wZhdm/LaCSpaodt362cJN0zRMFZl9u
qzYrlcM2xaHewPsU7ALJiJOZtA9V7LX05Fu+H4sAZynShGDxzdnzugEFjR2gu4Ax
ZTiTTr4+Mg9vyNuEHdNwFNMA7Aj40bN77HP9AvM6tBytbUrzCA3kC58631IfAxIn
rQ6qXijhPWfYk5WPgWEjUlKSLqTVCA==
=Reno
-----END PGP SIGNATURE-----

--oig3ms6c3h2nuufe--

