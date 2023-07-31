Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9376A40C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjGaWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjGaWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DB5B2;
        Mon, 31 Jul 2023 15:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 588746130B;
        Mon, 31 Jul 2023 22:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969F5C433C8;
        Mon, 31 Jul 2023 22:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690841802;
        bh=7PYksuUVbqNm+X5BgFbgzL54hc7z3GGbyqf4A9vkXTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aG//2HxJx27ed2Ap2c0rN8KCPkjq+tVThqXN8cJotDeubuvsY+xaMFt/H2SeQafTM
         7sBXv7xP2mqWBjHXSiM+fDY8rrl6xKa6vJOxwul9snJdNa/HNPrC+i/ZlgcLWRkXT5
         qnCVDZQoALrNJxAe93fPfdZDYii5XtXqSx98XbpCr0RYde5ebqUsHJP5vQ6kfaQBhU
         hIxg3iKcilOEI6nAVH/tD8Q0J3Z2VNpXAJW+dAVl8aBnnf2hwKMIYN8gBKY9RZQ4d5
         Rr44rSHdf5w9UkHvNlC2kPPm8yu9VvXgF1biCtb57uRdVV1MRZfWeBto7ndmuyjtS6
         JlIde3WGELm0g==
Received: by mercury (Postfix, from userid 1000)
        id 2B66C10622DC; Tue,  1 Aug 2023 00:16:40 +0200 (CEST)
Date:   Tue, 1 Aug 2023 00:16:40 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] bus: omap_l3_smx: identify timeout source before
 rebooting
Message-ID: <20230731221640.6lugeimfg4f53rs2@mercury.elektranox.org>
References: <20230731210347.1048060-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjjw6qqbon2w45qk"
Content-Disposition: inline
In-Reply-To: <20230731210347.1048060-1-absicsz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wjjw6qqbon2w45qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 31, 2023 at 11:03:47PM +0200, Sicelo A. Mhlongo wrote:
> Identify and print the error source before rebooting the board due
> to an l3 application timeout error, by delaying the BUG_ON. This
> is helpful when debugging, e.g. via serial.
>=20
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/bus/omap_l3_smx.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
> index bb1606f5ce2d..0ccde12e33c0 100644
> --- a/drivers/bus/omap_l3_smx.c
> +++ b/drivers/bus/omap_l3_smx.c
> @@ -170,11 +170,9 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_=
l3)
>  		status =3D omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
>  		/*
>  		 * if we have a timeout error, there's nothing we can
> -		 * do besides rebooting the board. So let's BUG on any
> -		 * of such errors and handle the others. timeout error
> -		 * is severe and not expected to occur.
> +		 * do besides rebooting the board after identifying the
> +		 * error source.
>  		 */
> -		BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
>  	} else {
>  		status =3D omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_1);
>  		/* No timeout error for debug sources */

I think it's sensible to just remove the comments from both if/else
branches. They no longer make sense in this place. Afterwards you
should remove the curly brackets to follow kernel coding style.

> @@ -190,6 +188,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_=
l3)
>  		ret |=3D omap3_l3_block_irq(l3, error, error_addr);
>  	}
> =20
> +	/*
> +	 * BUG on application timeout errors since they are severe and not
> +	 * expected to occur.
> +	 */

I suggest using the original text. It does mention "there's nothing
we can do besides rebooting the board".

> +	BUG_ON(!int_type && status & L3_STATUS_0_TIMEOUT_MASK);
> +
>  	/* Clear the status register */
>  	clear =3D (L3_AGENT_STATUS_CLEAR_IA << int_type) |
>  		L3_AGENT_STATUS_CLEAR_TA;

-- Sebastian

--wjjw6qqbon2w45qk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTIMrsACgkQ2O7X88g7
+po+Cg/7BlaNwDcx4J3LqVhi6t+7ugBk2ufUde2MnqrVPxvwnFssPfEoRfOZsf/W
HWPfF1rkdwegg96vUMwWVQxdOdgvY6X1JkXravdaPD8hfrp9b73ApB2uChr+ZVLh
IN0ymqembLpAhVAKBKKFz1B4LKztRRdzpXTXb4YxfKV3/kiCp45ZoUNxdMX3Zjp6
LUz5YIvR47pOPGK3eiaKnW4Y7oukWxRsG8gRKvXZdWzi/+LgfO/p8S5vlCyAJoah
cAf71Lvrtl7x/AW3ipb9FgFVEVNYEPQdjv65rDinBwuiaA+335ZoK0NG8oxLFxYc
4cuUn/yVHYVPSUUQEaToLjbCBPJQL2qOTrd1/NEr5mgKCgYopncluAs9i53jgdXy
XttUmlDKPeiAAedH6e+VKEa0u+6YS81DWba5KosNTKvGFpBBN2CRSb1VoJI00n3e
cj2uFsv+ldxDzhAIrGpuxL4iL34qNLyomMUFndARaFcZ13nRWWaiBw4btGD9F64c
0W0sgvMcbXcIgo5kVxK+92E0yQbYmqSZwrnN6opMF5Km2OPKK++q3DixmSCzyGez
5M9OObYk5zD9/bveWyl5XA0AgEaaaiw8rUuruz4Na0kDgk3NyBkuEwEucpCxrO8R
N2GC35kaGAW2pR6LE4VMP/OfeQ+OeNmpMABt7jFhHriSJSbkCoo=
=du+q
-----END PGP SIGNATURE-----

--wjjw6qqbon2w45qk--
