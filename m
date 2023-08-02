Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042176CEE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHBNhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjHBNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:37:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846941BF9;
        Wed,  2 Aug 2023 06:37:03 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-241.ewe-ip-backbone.de [91.248.189.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB6946607033;
        Wed,  2 Aug 2023 14:37:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690983421;
        bh=Q916s/RETmFvwEeE9hvCKAFRN4VWxOOiZNW6vUujMug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVO7zJMyAJBlHEYRN61mcvK2EwXu6Uj78TAHI/G1Nq2Z6qCWyEjp6invGFAHnu0gF
         L9H338eDPYCBtjKb/2m0YS9+F0XfbOovJi77iBNlyZjCXkwYGO5tgUBu+VLUTB1M24
         K1yYs2dboz3aakOVwV7kfcm7AoNOqQGrEGeulcA4k8p52lyc5HChle8SF4IZTc65gg
         OzXopN+Nb3hJTDDjQSiWYrun2XVEIJQc7M5vCOrlyG94YIqQ8JsVwYgliUTlvCbcW0
         Y+Gy11SuJ6t1nrVLdUJVYcpnV4wr3m9nh4pJHIsao/+8RFm+XNANHNn89Q95mLxj0A
         J+jVbmuLrVpvw==
Received: by mercury (Postfix, from userid 1000)
        id DAE131060359; Wed,  2 Aug 2023 15:36:59 +0200 (CEST)
Date:   Wed, 2 Aug 2023 15:36:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        maemo-leste@lists.dyne.org
Subject: Re: [PATCH v3] bus: omap_l3_smx: identify timeout cause before
 rebooting
Message-ID: <20230802133659.kelu7tfz27ovi364@mercury.elektranox.org>
References: <20230801192240.1063764-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvmbmryvhzknqvw7"
Content-Disposition: inline
In-Reply-To: <20230801192240.1063764-1-absicsz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvmbmryvhzknqvw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2023 at 09:22:40PM +0200, Sicelo A. Mhlongo wrote:
> Identify and print the error source before rebooting the board due to an =
l3
> timeout error. This is helpful when debugging, e.g. via serial.
>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/bus/omap_l3_smx.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

nice, adding features with a negative diffstat :)

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
> index bb1606f5ce2d..8e1a38bfcd8b 100644
> --- a/drivers/bus/omap_l3_smx.c
> +++ b/drivers/bus/omap_l3_smx.c
> @@ -166,19 +166,10 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *=
_l3)
>  	irqreturn_t ret =3D IRQ_NONE;
> =20
>  	int_type =3D irq =3D=3D l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_E=
RROR;
> -	if (!int_type) {
> +	if (!int_type)
>  		status =3D omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
> -		/*
> -		 * if we have a timeout error, there's nothing we can
> -		 * do besides rebooting the board. So let's BUG on any
> -		 * of such errors and handle the others. timeout error
> -		 * is severe and not expected to occur.
> -		 */
> -		BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
> -	} else {
> +	else
>  		status =3D omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_1);
> -		/* No timeout error for debug sources */
> -	}
> =20
>  	/* identify the error source */
>  	err_source =3D __ffs(status);
> @@ -190,6 +181,14 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_=
l3)
>  		ret |=3D omap3_l3_block_irq(l3, error, error_addr);
>  	}
> =20
> +	/*
> +	 * if we have a timeout error, there's nothing we can
> +	 * do besides rebooting the board. So let's BUG on any
> +	 * of such errors and handle the others. timeout error
> +	 * is severe and not expected to occur.
> +	 */
> +	BUG_ON(!int_type && status & L3_STATUS_0_TIMEOUT_MASK);
> +
>  	/* Clear the status register */
>  	clear =3D (L3_AGENT_STATUS_CLEAR_IA << int_type) |
>  		L3_AGENT_STATUS_CLEAR_TA;
> --=20
> 2.40.1
>=20

--kvmbmryvhzknqvw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTKW+8ACgkQ2O7X88g7
+poe8Q//SSYjPstLhqYXg3QRvPJ7iD3mLuqV7NBikaw6dLkhURzD2dKM4Fo+v9Pd
szFXGiwKvJ21EyMqan6aIsctF+c8JD1uGZ9PrO8XPId0pTL9101Bwo4VpFJUjtwP
Z3TK1JonlsIm0J+HoGImZU318Rrr4CBxL4x3TyBaPXCH2hGSUzIRai6WLdYw8rkq
My4vgQ4jsm08ySRg02AAmDFJciLiN8eviEdt3cLHoMupce2iyWy8WW4yz8hLpbs7
MkE3cS9muqlTblaaumVLU924Ait+uIGC+tBhKsoF1J+RaZ0gUwFwREt2tm34kC0o
oRxIDWXCtTD94XImpShU9JE8zRTnXn4lBhyTfVWCBGC7b4e3Vh2Gqbm8Tt1Czy0P
GMmxW45XJfeF6IMqnMcZyiwxqqMDK0dVGSuz5IOrG/4ppG0xNVOOrKOKaneqjYKv
UFOinZ6ANho1V1Dfe3kEIS0RBlnKRtovyvXu0lQGkXrz+dLu2k+/uYnR41yXNj9V
yhfbNlU4IJPino+QuTXCkmhLuWT9HCYxZ3JCaZGBEpgsLC5HvRzxEx0o7hTZumlO
HhuwkhynqKhLKTzK8PfwZ40X0xVo4wxdc/VQxQFEiL5sXr0UNZj/OHeG/3aaToyx
j4Itbn+M7HwIjpe3kcbvj1UMPoTJnNwnQVWkO3kjRCWMDY8qWOk=
=XXDb
-----END PGP SIGNATURE-----

--kvmbmryvhzknqvw7--
