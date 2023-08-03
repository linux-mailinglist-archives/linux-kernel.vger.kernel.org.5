Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8B76E4FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjHCJwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjHCJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:52:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E193588
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:52:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRV0P-0000Up-HN; Thu, 03 Aug 2023 11:52:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRV0N-000oIT-CL; Thu, 03 Aug 2023 11:52:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRV0M-00A7I5-FF; Thu, 03 Aug 2023 11:52:26 +0200
Date:   Thu, 3 Aug 2023 11:52:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in
 sdhci_f_sdh30_remove
Message-ID: <20230803095226.q2pux43f7q7zbym5@pengutronix.de>
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-62-frank.li@vivo.com>
 <90febfa5-b520-05f5-53ca-af0e1f3fc7c4@intel.com>
 <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nsgm45mhytywalmb"
Content-Disposition: inline
In-Reply-To: <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nsgm45mhytywalmb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 03, 2023 at 08:46:08AM +0300, Adrian Hunter wrote:
> On 27/07/23 16:55, Adrian Hunter wrote:
> >> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci=
_f_sdh30.c
> >> index 840084ee72e6..964fa18a61a4 100644
> >> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> >> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> >> @@ -211,11 +211,11 @@ static void sdhci_f_sdh30_remove(struct platform=
_device *pdev)
> >>  	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >>  	struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> >> =20
> >> +	sdhci_pltfm_unregister(pdev);
> >=20
> > That also frees priv
> >=20
> >> +
> >>  	reset_control_assert(priv->rst);
> >>  	clk_disable_unprepare(priv->clk);
> >>  	clk_disable_unprepare(priv->clk_iface);
> >> -
> >> -	sdhci_pltfm_unregister(pdev);
> >>  }
> >> =20
> >>  #ifdef CONFIG_OF
> >=20
>=20
> So it needs to end up looking something like below, right?
>=20
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_=
sdh30.c
> index 840084ee72e6..47ae853f51aa 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -210,12 +210,15 @@ static void sdhci_f_sdh30_remove(struct platform_de=
vice *pdev)
>  {
>  	struct sdhci_host *host =3D platform_get_drvdata(pdev);
>  	struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> -
> -	reset_control_assert(priv->rst);
> -	clk_disable_unprepare(priv->clk);
> -	clk_disable_unprepare(priv->clk_iface);
> +	struct clk *clk_iface =3D priv->clk_iface;
> +	struct reset_control *rst =3D priv->rst;
> +	struct clk *clk =3D priv->clk;
> =20
>  	sdhci_pltfm_unregister(pdev);
> +
> +	reset_control_assert(rst);
> +	clk_disable_unprepare(clk);
> +	clk_disable_unprepare(clk_iface);
>  }

Looks right to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nsgm45mhytywalmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTLeNkACgkQj4D7WH0S
/k4YdQf9G5m3yP4UVxPdwMMQuaXC/eWSKiHfzuJamfjUN5BSMZZTGwLtgYBsSgiL
MWlK3UKxBcQopwXSXJ9LIPtiKdaQUZDXuBVDbz/Q2Nae1JnBAUzyx1VxFDltE48R
BpmQiQpovni4jhOGKcAKjfGTmU9NNcAdRh9xz/2/Zgx8tQfTBN6dZQVFTUNdHT4P
UfsJzdt9pmUYT8l7IlcIPyt5MD2J40NwR2VWzXZGUXWwyqYL1IuDiV8arO3+VDp0
ssfzkWo4gBDDwmR/FlFyyrcTXCTz9dKkaEh90b/VKWRokRi/e1VtMOnCswidvwVk
GBEdslXwiE4EOyWNA/chNh8nrZhnsw==
=ULx4
-----END PGP SIGNATURE-----

--nsgm45mhytywalmb--
