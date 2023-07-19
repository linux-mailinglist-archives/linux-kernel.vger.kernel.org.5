Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4BF759736
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGSNku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGSNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:40:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE176123
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:40:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM7Pz-0007az-Nb; Wed, 19 Jul 2023 15:40:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM7Py-000cHN-Ir; Wed, 19 Jul 2023 15:40:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM7Px-0066y8-RK; Wed, 19 Jul 2023 15:40:37 +0200
Date:   Wed, 19 Jul 2023 15:40:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: fix irq domain leak
Message-ID: <20230719134036.w5lsqxcg6u3v3ynm@pengutronix.de>
References: <20230719114101.55051-1-brgl@bgdev.pl>
 <CAHp75VfdCsAE8dGfTe2PsT5kxvoT84nChNptwgaA4Q5jf5oJvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ujodkpnhmenu4mny"
Content-Disposition: inline
In-Reply-To: <CAHp75VfdCsAE8dGfTe2PsT5kxvoT84nChNptwgaA4Q5jf5oJvQ@mail.gmail.com>
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


--ujodkpnhmenu4mny
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 04:02:39PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 19, 2023 at 2:41=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Uwe Kleine-K=C3=B6nig pointed out we still have one resource leak in th=
e mvebu
> > driver triggered on driver detach. Let's address it with a custom devm
> > action.
>=20
> One nit-pick below, in either case
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> > Fixes: 812d47889a8e ("gpio/mvebu: Use irq_domain_add_linear")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpio-mvebu.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> > index a35958e7adf6..67497116ce27 100644
> > --- a/drivers/gpio/gpio-mvebu.c
> > +++ b/drivers/gpio/gpio-mvebu.c
> > @@ -1112,6 +1112,13 @@ static int mvebu_gpio_probe_syscon(struct platfo=
rm_device *pdev,
> >         return 0;
> >  }
> >
> > +static void mvebu_gpio_remove_irq_domain(void *data)
> > +{
> > +       struct irq_domain *domain =3D data;
> > +
> > +       irq_domain_remove(domain);
>=20
> The from/to void * doesn't need an explicit casting in C. This can be
> a one liner
>=20
> static void mvebu_gpio_remove_irq_domain(void *domain)
> {
>       irq_domain_remove(domain);
> }

I slightly prefer Bartosz's version, but wouldn't get sleepless nights
=66rom that one.

Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

for whatever variant you pick.

Best regards and thanks for acting on my report,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ujodkpnhmenu4mny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS359QACgkQj4D7WH0S
/k4e9Af8CqmHYpZTvAibrO7NUTwH5Wv9wPOjn08hjFMA9+EVEq0IZWC04rJdNXxK
Q9N+jeCJoAWVQNL73ZVUlIzK1CjcJnppEsn92O0G4b4PybMCQGqd+UPyR1naMW7d
ieNq857UHMYaUUBt1Y+yDNTahs5EsTXXV7uEmlgyHAQXzIGc+4KHzCSF9umSYxyq
foaTpnOe3llRQGh3TtZVDDsRdDy5HK/wbAwG0Hn9mgYKK0UOJ0P2dpxJncKl2Hgx
LlNUmXQ4SoF3PlEXBYc7pCSEHF62Qm0agQke4dQHP+af/cBk1QSQQT51UJAzBw3X
j81qfIKaAF02tBPKvuPlKdWXMNQaaQ==
=uUOV
-----END PGP SIGNATURE-----

--ujodkpnhmenu4mny--
