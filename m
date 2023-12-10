Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719480BB8D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjLJONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:13:42 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B8F4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 06:13:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCKZ0-0002pO-4i; Sun, 10 Dec 2023 15:13:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCKYz-00Et15-12; Sun, 10 Dec 2023 15:13:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1rCKYy-000Bkm-OD; Sun, 10 Dec 2023 15:13:44 +0100
Date:   Sun, 10 Dec 2023 15:13:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/2] bus: ts-nbus: Improve error reporting
Message-ID: <20231210141344.c7ym5jupttir3i2n@pengutronix.de>
References: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
 <20702efe8ab96add9773e97ceed1a6cf91a065ee.1702160838.git.u.kleine-koenig@pengutronix.de>
 <e02bc48e-58dd-44d6-ae89-a6a2936df778@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sjtyo5xclzujuogo"
Content-Disposition: inline
In-Reply-To: <e02bc48e-58dd-44d6-ae89-a6a2936df778@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sjtyo5xclzujuogo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Sebastien from Cc, the address doesn't work]

On Sun, Dec 10, 2023 at 07:55:02AM +0100, Christophe JAILLET wrote:
> Le 09/12/2023 =E0 23:35, Uwe Kleine-K=F6nig a =E9crit=A0:
> > Using dev_err_probe() brings several improvements:
> >=20
> >   - emits the symbolic error code
> >   - properly handles EPROBE_DEFER
> >   - combines error message generation and return value handling
> >=20
> > While at it add error messages to two error paths that were silent
> > before.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/bus/ts-nbus.c | 65 ++++++++++++++++++-------------------------
> >   1 file changed, 27 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
>=20
> ...
>=20
> > @@ -289,25 +283,19 @@ static int ts_nbus_probe(struct platform_device *=
pdev)
> >   		return ret;
> >   	pwm =3D devm_pwm_get(dev, NULL);
> > -	if (IS_ERR(pwm)) {
> > -		ret =3D PTR_ERR(pwm);
> > -		if (ret !=3D -EPROBE_DEFER)
> > -			dev_err(dev, "unable to request PWM\n");
> > -		return ret;
> > -	}
> > +	if (IS_ERR(pwm))
> > +		return dev_err_probe(dev, ret, "unable to request PWM\n");
>=20
> s/ret/PTR_ERR(pwm)/

Indeed. Thanks for spotting that. Will send a v2 after waiting a bit
more for feedback.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sjtyo5xclzujuogo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV1x5cACgkQj4D7WH0S
/k4U+Af/X+yfPql6LaAOnN0wsXH0T0V8SLEBGZBodm8ToZfKrZRGp/d69PXAMljB
wWfTtqaSorHFWx4ofspQzcl9bYWHK+H2Eg/6rIzoEtCJwLv6kRR3jR4WdiAcjkx/
qLIAFLuIb+nlT1z0bI0l37o86jkyLDLHVMfPOHaS4oCD2yV3L+We+QZPP7PFshZI
qyKcG7BIlQG1kpjSq7J24QVbmX88Am+2uRnfrW3DqZM1YEzkqRSSzbM7n8I1ZWW+
OW22O7XAhzrewvHIfX+WxhJs1w5L1hQAniFeSHiBjc6u9v5cnmWQdwE1+qLYArWX
RppElBQJfXA62effROzMblg8lq4J0A==
=aQ6/
-----END PGP SIGNATURE-----

--sjtyo5xclzujuogo--
