Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA35762C78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGZHE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGZHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:04:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206130F0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:02:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYXe-0004vz-Ks; Wed, 26 Jul 2023 09:02:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYXd-002BMQ-HU; Wed, 26 Jul 2023 09:02:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOYXc-007s5H-TJ; Wed, 26 Jul 2023 09:02:36 +0200
Date:   Wed, 26 Jul 2023 09:02:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 60/61] mmc: sdhci_am654: Properly handle failures in
 .remove()
Message-ID: <20230726070234.4im3v23qbago763b@pengutronix.de>
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-60-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mb7py2dtbfutl63d"
Content-Disposition: inline
In-Reply-To: <20230726040041.26267-60-frank.li@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mb7py2dtbfutl63d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 12:00:40PM +0800, Yangtao Li wrote:
> Returning an error code in a platform driver's remove function is wrong
> most of the time and there is an effort to make the callback return
> void. To prepare this rework the function not to exit early.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am65=
4.c
> index 7cdf0f54e3a5..abe83736d396 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -873,8 +873,7 @@ static int sdhci_am654_remove(struct platform_device =
*pdev)
>  	int ret;
> =20
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> -		return ret;
> +	WARN_ON(ret < 0);

You must use pm_runtime_get_sync() instead of
pm_runtime_resume_and_get() here because in the error case
pm_runtime_resume_and_get() already calls pm_runtime_put_noidle() which
is repeated here in this driver.

Also WARN_ON is a pretty big hammer, I'd go with a dev_err() instead.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mb7py2dtbfutl63d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTAxQkACgkQj4D7WH0S
/k51NwgAktdF0e8v1rBrxIzaK20EAwbITFou+8sdxKFCWruhIUq7bNIBj1ws7uzO
ztJL2yqPQpj4T28JKALELmkcvuvAf3RG2BKHfbdETIMOjhNr58Xpk04PmrQMQU3W
cmWBYnItCndnmLNbyTSEHFM86hjpWMx3hoF37XImhU71vnpHeLAfRUYWLfkG+X4H
ke48+SUE33kWgjjaBb8+9P8aNdxrKnVNO+KStb3b+JONRbpRmDVM6wIiow1b/dwS
mqZlLpznQxIwtp5w47eKj3ThZttrB0WVQnG6BaYahIDNz/dxfVurYEmvbQjcimhS
O/xpTYl5WyP+qzfgDT2QLIbbH0/1Gg==
=VGBu
-----END PGP SIGNATURE-----

--mb7py2dtbfutl63d--
