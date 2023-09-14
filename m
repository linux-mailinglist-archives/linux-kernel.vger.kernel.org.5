Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D547A1143
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjINWr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjINWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:47:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6326B7;
        Thu, 14 Sep 2023 15:47:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF79C433C9;
        Thu, 14 Sep 2023 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694731673;
        bh=8oQq0VYcvVbisN6FW9kbAh9+TeVEDESzGIQyb2pXlFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ7gxIhHti/Me6L5sAEzKxN7FrFJDkV8vaOQnFAMFeXZXZM3GO3tRozkwk24k9EJC
         6/aW17lXE9Gg6aR8ePVzzP8yfp9uVjDmQMJYsZKYV3ZDuVxrMJU/FwQPUU1vkZ6mhr
         zFMl78uyS5AI7NuZX2mJWdfzNRcjmojIp9VuiHrh/dzYNWU5IKoHKkpIUkFzdOpurv
         3RGuQ2HWkrAI4Iwp819RX2HZVwbvRePYlOcGuKGbu04+VUQV6gjw8ayEOm7FG8dUoh
         +QMX9E1hN+xnL0TkvyKcQlxN6I05any05XQzNaFhAtPq/yZ9gGQIGvVAtLIx9xRdzI
         QpEUM331gNJUw==
Received: by mercury (Postfix, from userid 1000)
        id E67F710609D6; Fri, 15 Sep 2023 00:47:49 +0200 (CEST)
Date:   Fri, 15 Sep 2023 00:47:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <20230914224749.kmg4xqsg3wmfwwhj@mercury.elektranox.org>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lxinejkm3oweqd2g"
Content-Disposition: inline
In-Reply-To: <20230628125406.237949-1-stefan.moring@technolution.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lxinejkm3oweqd2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 28, 2023 at 02:54:06PM +0200, Stefan Moring wrote:
> IMX51 supports 4096 bit burst lengths. Using the spi transfer length
> instead of bits_per_word increases performance significantly.
>=20
> Signed-off-by: Stefan Moring <stefan.moring@technolution.nl>
> ---

I have an i.MX6ULL system with "inanbo,t28cp45tn89-v17" panel, which
breaks due to this change. Reverting this patch results in working
panel. Note, that the panel driver [0] does 'spi->bits_per_word =3D 9;'.

[0] drivers/gpu/drm/panel/panel-sitronix-st7789v.c

-- Sebastian

>  drivers/spi/spi-imx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 34e5f81ec431..cbd306c25d28 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -644,9 +644,13 @@ static int mx51_ecspi_prepare_transfer(struct spi_im=
x_data *spi_imx,
>  	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
>  		ctrl |=3D (spi_imx->slave_burst * 8 - 1)
>  			<< MX51_ECSPI_CTRL_BL_OFFSET;
> -	else
> -		ctrl |=3D (spi_imx->bits_per_word - 1)
> -			<< MX51_ECSPI_CTRL_BL_OFFSET;
> +	else {
> +		if (spi_imx->count >=3D 512)
> +			ctrl |=3D 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
> +		else
> +			ctrl |=3D (spi_imx->count*8 - 1)
> +				<< MX51_ECSPI_CTRL_BL_OFFSET;
> +	}
> =20
>  	/* set clock speed */
>  	ctrl &=3D ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
> @@ -1243,6 +1247,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  		spi_imx->spi_bus_clk =3D t->speed_hz;
> =20
>  	spi_imx->bits_per_word =3D t->bits_per_word;
> +	spi_imx->count =3D t->len;
> =20
>  	/*
>  	 * Initialize the functions for transfer. To transfer non byte-aligned
> --=20
> 2.34.1
>=20

--lxinejkm3oweqd2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUDjYYACgkQ2O7X88g7
+prukBAAnl9cT+kmXltGA07ukiiFUS+xePDTzU3O6pJ+3SO9zIhRHU+vPijobqCA
U9oBWiJA5TbSTVZiwBz77Ty+PyTufqRl2isJLfSTrQDVjDluGtMxlwKafqkVohqG
Js32INNEOsCX1hWhsn8Szv61XfkYjR3uik4Mu2g6/UXrGMOSNQBWxwlijMMM2QRF
/tTJUdBIKIAzJcw73Bsr+eoO2v+4sa3EkcC39CerAYNzCSt0RBrNpdCa3HhjSt6X
9RfxKL5KH8ZS6U+XJ5M0u6iy0xL60QmGLip1Ypyp7nLhjrUuw7VLyGBKomCPNboP
2bju8OJosb4V5vF1jlPU9icA1FPCvWnBhyw/THcXG2m1DnnnMUjp77lhoLHx5pDS
8qYVemRqSw8wqwxivSH3KYXjUP2PctGByDjL5W09C7Xwk5g7NlJejX9o/o4pxCoD
NPWQphAlxhPTxkADGrxMw8zdrD2urPaiQyXPQmZqY3LIu6l2MAIQ5ASJ+jaDrgzQ
tRVkBHPWXLqpaaR0oLuraJ75WcM51g0t2Q5/jpM2AAzb0BnxDiyA/Js6uybx08or
bRuCkbUbMo9NGNBNO8iFlYrE/9vhJwyHzlhuPAltOPvqKTRqSsJ4Luwk2mWm2PtO
0SGxQaidlCGOa+f9i61sf8agNsoNF4u1dcwlBbWlt7A7kad4PQo=
=kCXx
-----END PGP SIGNATURE-----

--lxinejkm3oweqd2g--
