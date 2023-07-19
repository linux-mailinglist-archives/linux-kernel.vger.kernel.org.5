Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3675A047
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGSU7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:59:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708041B9;
        Wed, 19 Jul 2023 13:59:31 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37BC3660707B;
        Wed, 19 Jul 2023 21:59:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689800370;
        bh=cXRYIzQdseRHmaYd1OD7u2mYqJ0lfpwzolfl9iDjYCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bso5CMvAutuxB+K6shilAFIjHVoB/0W8tzBGg0L77Jz4HpY6K1JWihPgWWAy78/sx
         H4rvlCGz1CWwIjs4w2IRTRnhgz0jDwBNntcsO/3vUo96SSNaG6GzsKQg+DTr8T4AS9
         Qwo8hWuIMOVpCQosuAvT/8rshDGGP16xA+3yEe739pUMeNA5m6Uq8+tn4DC1INXQGt
         95uZ3cPB/MCdCGEtXL5NQ8qM9cOPbdJgfC0koqH6KPG+nfagplJCKyozE0C9iccLKE
         ptJV36VAkkw3LmXsYURZZ1r0Azalr6oV3uN6jLAM3DiSGLx2E4M8krNZ7jeNhOrDqW
         f0fEwhS720u2A==
Received: by mercury (Postfix, from userid 1000)
        id 6A41D1061387; Wed, 19 Jul 2023 22:59:27 +0200 (CEST)
Date:   Wed, 19 Jul 2023 22:59:27 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH] power: supply: bq24190: Considers FORCE_20PCT when
 getting IPRECHG
Message-ID: <20230719205927.5gdxmwsj4tgeckwq@mercury.elektranox.org>
References: <20230714174529.287045-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dg2nkogywbg63pik"
Content-Disposition: inline
In-Reply-To: <20230714174529.287045-1-rriveram@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dg2nkogywbg63pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 14, 2023 at 12:45:29PM -0500, Ricardo Rivera-Matos wrote:
> Adds a check of the FORCE_20PCT bit when getting the precharge
> current value.
>=20
> According to the bit description for the FORCE_20PCT bit, when
> FORCE_20PCT is true, the precharge current target is 50% of
> what is configured in the IPRECHG bit field.
>=20
> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> Reviewed-by: David Rhodes <drhodes@opensource.cirrus.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index ef8235848f56..3f99cb9590ba 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -965,7 +965,7 @@ static int bq24190_charger_get_precharge(struct bq241=
90_dev_info *bdi,
>  		union power_supply_propval *val)
>  {
>  	u8 v;
> -	int ret;
> +	int curr, ret;
> =20
>  	ret =3D bq24190_read_mask(bdi, BQ24190_REG_PCTCC,
>  			BQ24190_REG_PCTCC_IPRECHG_MASK,
> @@ -973,7 +973,20 @@ static int bq24190_charger_get_precharge(struct bq24=
190_dev_info *bdi,
>  	if (ret < 0)
>  		return ret;
> =20
> -	val->intval =3D ++v * 128 * 1000;
> +	curr =3D ++v * 128 * 1000;
> +
> +	ret =3D bq24190_read_mask(bdi, BQ24190_REG_CCC,
> +			BQ24190_REG_CCC_FORCE_20PCT_MASK,
> +			BQ24190_REG_CCC_FORCE_20PCT_SHIFT, &v);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* If FORCE_20PCT is enabled, then current is 50% of IPRECHG value */
> +	if (v)
> +		curr /=3D 2;
> +
> +	val->intval =3D curr;
> +
>  	return 0;
>  }
> =20
> --=20
> 2.34.1
>=20

--dg2nkogywbg63pik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4Tq8ACgkQ2O7X88g7
+ppWcQ/8DAiXQiXRfk+oNyczvgd0/Pp5Vtz0VPPWthWX9CkPR1fs19Y2vTcAyO0B
utjPHuCaOyPoqzeb9idcJrsO6GOpOMGkMMBMlJnQvrRiK+Ygj/mmXncfks6Hub4N
OJwU6bZnX8syy8i1BB7VI0gY8uxw9IAYtd9nzhdx4NC9c2oW+07bCltMv9hXVfx3
FaaKUYjG/rHldjO1yrQNy8JGkejP0u/CiRm+WGTVakKHWRPjWLXqY0/a75M+FrA/
tOiJaWdhVTU4PGhMQ8slhi7UpEB3eK3y/lKgonVGw3qCLt1xakQAfDME9WhthqQR
mGPxINxZfRLyLqvPb3WkcvTpXXOM3C2VinjaNACF9MzanJN+2yT3TkUd1NS3EWBH
R3prTVaAGMk29NGAwtWpZeDUVzBbfmAhwfdiZ0s5j2A+YjI2sNumGPgdD3SeftZY
nYEVjcSDvyWOa/u+g7Y1MEcJh8vdQkchIN9y8h4/lQzYph9EUp5J4r0aQMXMrenx
J0FTOdp5xn7Qyx+X/JT2EAmtvo+1sEXcY+VPjmBpvupLSp6IXNpNC6UqqMIwIgq8
5sTDhab5/B8jv6WnT8d+QHxudnEbrCV70CLITJcPlkjhS/BjhrOyPELXTXxAxiCf
pbeGFRTxYpRfTmbi+4k1OSzDbw7FVSj6yLLpC6HLzzv97+aaKfI=
=eIi4
-----END PGP SIGNATURE-----

--dg2nkogywbg63pik--
