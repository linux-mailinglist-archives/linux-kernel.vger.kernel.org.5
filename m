Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3A7B9E54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjJEODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjJEODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:03:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817C665B6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:21:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoHjP-0007bo-KR; Thu, 05 Oct 2023 08:21:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoHjO-00BCcF-Sj; Thu, 05 Oct 2023 08:21:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoHjO-009KGU-H5; Thu, 05 Oct 2023 08:21:06 +0200
Date:   Thu, 5 Oct 2023 08:20:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: brcmstb: Utilize appropriate clock APIs in
 suspend/resume
Message-ID: <20231005062032.kklxiavdkaix5sod@pengutronix.de>
References: <20231004175414.1738475-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ccrp3b53ojxudlcw"
Content-Disposition: inline
In-Reply-To: <20231004175414.1738475-1-florian.fainelli@broadcom.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ccrp3b53ojxudlcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Wed, Oct 04, 2023 at 10:54:14AM -0700, Florian Fainelli wrote:
> The suspend/resume functions currently utilize
> clk_disable()/clk_enable() respectively which may be no-ops with certain
> clock providers such as SCMI. Fix this to use clk_disable_unprepare()
> and clk_prepare_enable() respectively as we should.
>=20
> Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pwm/pwm-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
> index a3faa9a3de7c..a7d529bf76ad 100644
> --- a/drivers/pwm/pwm-brcmstb.c
> +++ b/drivers/pwm/pwm-brcmstb.c
> @@ -288,7 +288,7 @@ static int brcmstb_pwm_suspend(struct device *dev)
>  {
>  	struct brcmstb_pwm *p =3D dev_get_drvdata(dev);
> =20
> -	clk_disable(p->clk);
> +	clk_disable_unprepare(p->clk);
> =20
>  	return 0;
>  }
> @@ -297,7 +297,7 @@ static int brcmstb_pwm_resume(struct device *dev)
>  {
>  	struct brcmstb_pwm *p =3D dev_get_drvdata(dev);
> =20
> -	clk_enable(p->clk);
> +	clk_prepare_enable(p->clk);

While at it: Add another patch that checks the return value of
clk_prepare_enable()?

Orthogonally to that, the patch looks fine:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ccrp3b53ojxudlcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUeVa8ACgkQj4D7WH0S
/k64xwgAgYEYSUsqGUELNGbGXzyYRPZJSUtsFciRuZjNR9ZEwUKz+v43kwZaCkuA
Y32IIriYy62UcIA+qWny7cE/dDnTN8Vo+9dnxINQJX1qIDL3NgT+lak2xE9pdHwh
1qS7vWvwqLWE7Xo6xJtt6jmNO6Xogxg6s/lrpVBgyQL8ubPw/dxOlP6o9oem5B6V
IntnjW7+s3xjZ7MdZ8R+YaH9j1pigeP1floudtD8TxRo4hnz6tiWpvyM/qf41AFL
dM4ck42NE/vNspKRz2lMThpYFIzIbbSIBZrdO6SzaN3xPpIjO7vYFYfi1mmrOGMa
sT6wG3FZt12kYXNfxVTeUS+dtToi2g==
=508Y
-----END PGP SIGNATURE-----

--ccrp3b53ojxudlcw--
