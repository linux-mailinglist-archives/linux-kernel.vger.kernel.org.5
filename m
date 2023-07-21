Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65575BDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGUFv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:50:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02BA30D4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:50:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMj1Z-0000q2-5G; Fri, 21 Jul 2023 07:49:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMj1Y-000zrK-4u; Fri, 21 Jul 2023 07:49:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMj1X-006Xi5-De; Fri, 21 Jul 2023 07:49:55 +0200
Date:   Fri, 21 Jul 2023 07:49:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guiting Shen <aarongt.shen@gmail.com>,
        claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <20230721054955.4rzcgawqjeunlnm4@pengutronix.de>
References: <20230716020652.18557-1-aarongt.shen@gmail.com>
 <ZLlO3vGr-ECdnmKA@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ossejx6vs65qbsem"
Content-Disposition: inline
In-Reply-To: <ZLlO3vGr-ECdnmKA@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ossejx6vs65qbsem
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 05:12:30PM +0200, Thierry Reding wrote:
> On Sun, Jul 16, 2023 at 10:06:52AM +0800, Guiting Shen wrote:
> > +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm=
, bool on)
> > +{
> > +	unsigned int i, cnt =3D 0;
> > +	int ret =3D 0;
> > +	u32 sr;
> > +
> > +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
> > +	if (!sr)
> > +		return 0;
> > +
> > +	cnt =3D bitmap_weight((unsigned long *)&sr, atmel_pwm->chip.npwm);
>=20
> Tiny nit here: not sure if that cast is safe to do. You've got a 32-bit
> variable, but if you cast &sr to unsigned long * on a 64-bit machine it
> would cause hweight64() to get called and that would then read 64 bits
> from a 32-bit variable. This probably works most of the time because we
> don't read any of the upper bits, but it is strictly an illegal access
> and could be unaligned as well.

While relevance of BE systems ceases slowly, such a machine would
evaluate the wrong bits.
=20
> Should we just turn sr into an unsigned long to be safe here?

yes please.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ossejx6vs65qbsem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS6HIMACgkQj4D7WH0S
/k6Hogf+KbFJk1P7JeO7yfCVB9HeoT4GjLWtIGQjHaDYde5xPAg8nxba5De/Y+NP
lYh2+005hnYNkIoV9+fG8s/4eE5yAceqRbcj2e+EgUhFERASFZ5q5d7bCq7mxDIg
eq+wpjipWb2+zRoVXZqtAjga/GlKUtYBaorsG5MfO8ggC4ij31PUxR6XPOIzKT6U
6B34omkgtZpJcY9f4vCAADJ/oUvcte2IYtf8qHmtIgSAbfwFoTV0E/2wWRh/evOl
zzSRhoGRpXpiELleCq00X03DDeSfrR9r/FfjpzFczK5F9F703iMjshpGrVwg/vlJ
zKHRQpngH2iJHVoV3WBe5ixA8nMA+A==
=7YlN
-----END PGP SIGNATURE-----

--ossejx6vs65qbsem--
