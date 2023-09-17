Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34AD7A3731
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjIQSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjIQSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:47:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F2100;
        Sun, 17 Sep 2023 11:47:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40F3C433C8;
        Sun, 17 Sep 2023 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694976444;
        bh=y9DaTHIMHXcC2SHHQISQSwuLwOseV81RIrU+F05nl+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUjXvIIbsjupe2iaaVMtaYPTH8GM5c+JDPmaUOEsYShPJNBXukjGoTpnNSinngw0Y
         eixLv/kfs4WyDTuXJDAffnQzuMTAvhlCN1hbr3LS9E3M4PoFYV6ye/T35ceFgL3NaO
         67ElypXpXyGprM5+Zsg9nosbiOAr0f26V7vdYdzHT4RxoTStAzPjQwRPYsiQa49syt
         G0AVQaz8fBEoLfH8sajUxcGcfKv2smE6LRIyM3AVkCLq+yQPaAkq2DBFSasQ2dw8yV
         A6D6vCAmbCaVUeXiXGnKY0lRaE9uBksGdzxNlye6iqTvr5m6LEDJM0/9ZL4vkevcop
         hmfqQT+yt7dMw==
Received: by mercury (Postfix, from userid 1000)
        id AC68910604B5; Sun, 17 Sep 2023 20:47:20 +0200 (CEST)
Date:   Sun, 17 Sep 2023 20:47:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stefan Moring <stefanmoring@gmail.com>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronxi.de,
        festevam@gmail.com, linux-imx@nxmp.com, linux-psi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: imx: take in account bits per word instead of
 assuming 8-bits
Message-ID: <20230917184720.wzigwjk4v5wakmz6@mercury.elektranox.org>
References: <20230917164037.29284-1-stefanmoring@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vvnncv4uod55cjfd"
Content-Disposition: inline
In-Reply-To: <20230917164037.29284-1-stefanmoring@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vvnncv4uod55cjfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 17, 2023 at 06:40:37PM +0200, Stefan Moring wrote:
> The IMX spi driver has a hardcoded 8, breaking the driver for word
> lengths other than 8.
>=20
> Signed-off-by: Stefan Moring <stefanmoring@gmail.com>
> ---

patch subject is missing the 'spi: imx:' prefix. Otherwise:

Reported-by: Sebastian Reichel <sre@kernel.org>
Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on trans=
fer length")
Tested-by: Sebastian Reichel <sre@kernel.org>

(no need to Cc stable, since the regression is only in v6.6-rc1)

-- Sebastian

>  drivers/spi/spi-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index a8a74c7cb79f..498e35c8db2c 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -662,7 +662,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx=
_data *spi_imx,
>  		if (spi_imx->count >=3D 512)
>  			ctrl |=3D 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
>  		else
> -			ctrl |=3D (spi_imx->count*8 - 1)
> +			ctrl |=3D (spi_imx->count * spi_imx->bits_per_word - 1)
>  				<< MX51_ECSPI_CTRL_BL_OFFSET;
>  	}
> =20
> --=20
> 2.42.0
>=20

--vvnncv4uod55cjfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUHSbUACgkQ2O7X88g7
+powOA//QZi68hCcG91zq7ECQd53AtdSj97EofoYYBRp1lQsfEkwzm4aHVzgvais
C4hXyiMZBLBstnH8+yTu/h5md2IwzZQVSftEyPyzrGIQwWu89DRZtUnWbo6fMtdI
Qq5T310rWgGETjjItrUgm727TJFbpSz/bIwSXYBLBaUIgcJnjITm2BwzyDDkpncl
qSA2Iww8oC/Lcowj9MJQ3JFu9YIpgdhaUdLARSzV3qGHJ235gh9FadH4S1sl2XXL
KHgYC9tJwuTz54vdqXSmOs3Qj/UF4JY0KAuKCZOHy43IDPtuuxIG87dU65+Fhd5M
nlorLWNa9r80VyilEJWkRu+GVOoIX17fDR0geYDU4AJfHYuIjYqSBHJ3AJU1Y384
irzfV4GePDnpAX7Noh1Q/Y8XqciD1P5I2JREyzWYvcyC+SvALU5gfJXU3Sy7pnXL
Yvvt9BqZSqrva3nbj3ModjoxRJqLdJIPGSeMdN+DaQ1AM2iVAQSiiX9bmbu4/JQ7
TmESFigxFC/D+1z7eS2qQmVPumMMFRfNPVBwo0f0hX48MIqU3I0KVpEnbI03ibKQ
z0eqhjg2jGtpQvZjdmcKUTsgUzZopUy/ramuPm5Dts0kbh+IVbil3ElEevzsCUQr
NR4Un8cDpWDdBTBRVYEjyEoK4v3nPMmq8JM26RK6EpBMpTSQeuw=
=2z3Y
-----END PGP SIGNATURE-----

--vvnncv4uod55cjfd--
