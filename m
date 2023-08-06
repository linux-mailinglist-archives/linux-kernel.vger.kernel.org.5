Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AFE771488
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjHFLaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFLaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:30:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACCC19C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 04:30:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qSbxU-0008Gh-Du; Sun, 06 Aug 2023 13:30:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qSbxT-001VMe-3R; Sun, 06 Aug 2023 13:30:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qSbxS-00AqWs-AO; Sun, 06 Aug 2023 13:30:02 +0200
Date:   Sun, 6 Aug 2023 13:30:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: bmp280: Use i2c_get_match_data
Message-ID: <20230806113001.26neek3slt3w77zt@pengutronix.de>
References: <cover.1691276610.git.ang.iglesiasg@gmail.com>
 <b3483bd87093d4cd0862904b70a167ebbb538644.1691276610.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzetm4d6c34w7mbf"
Content-Disposition: inline
In-Reply-To: <b3483bd87093d4cd0862904b70a167ebbb538644.1691276610.git.ang.iglesiasg@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bzetm4d6c34w7mbf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 06, 2023 at 01:15:03AM +0200, Angel Iglesias wrote:
> Replaces device_get_match_data() and fallback match_id logic by new
> unified helper function i2c_get_match_data().
>=20
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
>=20
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp=
280-i2c.c
> index 693eb1975fdc..4ebaa4edc4fc 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -11,9 +11,9 @@ static int bmp280_i2c_probe(struct i2c_client *client)
>  	const struct bmp280_chip_info *chip_info;
>  	struct regmap *regmap;
> =20
> -	chip_info =3D device_get_match_data(&client->dev);
> +	chip_info =3D i2c_get_match_data(client);
>  	if (!chip_info)
> -		chip_info =3D (const struct bmp280_chip_info *) id->driver_data;
> +		return -ENODEV;

the old code assumed that chip_info isn't NULL (implicitly by
dereferencing that pointer in the line below). I wouldn't change
semantics in a patch converting to a helper and so just do:

-	chip_info =3D device_get_match_data(&client->dev);
+	chip_info =3D i2c_get_match_data(client);
-	if (!chip_info)
-		chip_info =3D (const struct bmp280_chip_info *) id->driver_data;

or alternatively, if you think adding a check is a good idea, add an
error message in the error path and mention the semantic change in the
commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bzetm4d6c34w7mbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTPhDkACgkQj4D7WH0S
/k598gf/QYIEI5D+K8ylQZxk0SXcmUtPK1FbAhUY5CwUpmcE2tV0lG917a/XtYOI
+T2fLwtlZvVwQY2BiuObqtiqRZPNi3zHW1OsulMfKpD0MZLxtcZsVHlW3nTnEPYu
YKia11jR4Oj5TQbfzG8GSekIFZ4/5VqR+So+7DDaAWa+8c3RZ9o1oJU+Kqyu5H9d
huk7YtgDHdNu5FbgT3CbqFgECoq63cUYiQVcK4R0WRY8dOqRMAfDompSSx+eA8xb
oTOHltgJyHgC4cb/f0IHzR89ns8PuE0dRcPFE0NVKu7m7MSOUupHwu7bS0hLxPhL
ATrH21jzbIDuJoakCiEbEYbyFuQRxQ==
=R2Cx
-----END PGP SIGNATURE-----

--bzetm4d6c34w7mbf--
