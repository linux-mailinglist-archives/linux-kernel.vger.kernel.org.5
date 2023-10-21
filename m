Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EFD7D1A38
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjJUBHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUBHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:07:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1FCD45;
        Fri, 20 Oct 2023 18:07:34 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57D4A6607332;
        Sat, 21 Oct 2023 02:07:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697850453;
        bh=CH2omJCCy1KMhoXJh0T2xrBmJV7+OSQaAbEtAx3a87U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUN5ukDwPyNzcMOhSJhIOlXwO5+XrSQ8Az1ADcG2lRkgUpVoMfSFy3t/aAsN94Yz0
         lQgAmDULCqpm1FWL2Y1bWm5oQUlLTYiX/Jz6xV0W/zNqc5u+xb1NTjhsQO5/K3cYQX
         YLtNLWH1WPz3lMGga7sgnZl0KMR9uUmRCbCfDtOEQsFxkkOllvNlk9htz+xqc9FOIr
         W5nVqrPCUVX1UPNBdaTW4rFLOmiDOydi0Xqrp7qR72wh1OGI7a8JZyDTet8R6YDY1J
         omJzjkDIVrj4nLsPX3VavgCAyp3uzeQWGPViwSJRSQzyrw65JS+qLkVwdWwOmjsa4v
         6g0h1bpFfaIbw==
Received: by mercury (Postfix, from userid 1000)
        id 40DE7106061E; Sat, 21 Oct 2023 03:07:30 +0200 (CEST)
Date:   Sat, 21 Oct 2023 03:07:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com,
        Hermes Zhang <chenhuiz@axis.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: bq24190_charger: Add support for
 BQ24296
Message-ID: <20231021010730.zk2hlbin75fn3cy6@mercury.elektranox.org>
References: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
 <20231007020701.1912553-3-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3sqfrwaboxcezix5"
Content-Disposition: inline
In-Reply-To: <20231007020701.1912553-3-Hermes.Zhang@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3sqfrwaboxcezix5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 07, 2023 at 10:07:01AM +0800, Hermes Zhang wrote:
> From: Hermes Zhang <chenhuiz@axis.com>
>=20
> The BQ24296 is most similar to the BQ24196, but the:
> 1. OTG config is split from CHG config (REG01)
> 2. ICHG (Fast Charge Current limit) range is smaller (<=3D3008mA)
> 3. NTC fault is simplified to 2 bits
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

Thanks for your patch. I did not look into tiny details, because I
think this needs to be restructured first. Please follow the style
of bq256xx_charger.c, bq24257_charger.c and bq2515x_charger.c and
use a struct together with i2c_get_match_data().

Also put device specific functions into the struct to avoid a switch
case structure like the following:

> [...]
> +static int bq24190_hw_init(struct bq24190_dev_info *bdi)
> +{
> +	int ret;
> +
> +	/* First check that the device really is what its supposed to be */
> +	switch (bdi->chip) {
> +	case BQ24190:
> +	case BQ24192:
> +	case BQ24192i:
> +	case BQ24196:
> +		ret =3D bq24190_check_chip(bdi);
> +		break;
> +	case BQ24296:
> +		ret =3D bq24296_check_chip(bdi);
> +		break;
> +	default:
> +		dev_err(bdi->dev, "Error unsupported model: %d\n", bdi->chip);
> +		return -EINVAL;
> +	}
> [...]

Instead it should look like this:

struct info {
    ...
    int (*check_chip)(struct bq24190_dev_info *bdi);
    ...
};

static int bq24190_hw_init(struct bq24190_dev_info *bdi)
{
    return bdi->info->check_chip(bdi);
}

Thanks,

-- Sebastian

--3sqfrwaboxcezix5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUzJEkACgkQ2O7X88g7
+pqjUA//QgjsvVdr3gAtIx/BnsNZdVBnoF3sXd12HE+GNGQ/LYYYGYpanZRE8Ak/
T/GUx27lrGEEDMEYM80N6m8fgm0Y9lVPHn7t7QIKRMItWhiMtzV1vUfWoP6E1v8J
m8Z/cSGZ5NMdJMnWaNig4Udm8VDA87aE7fRqObXlMBCfF8iTNc2eFkxwBCgpHM/k
5LJKTyOQFMIvOJOQZe7eTevA1NL6rQORyaNudOoxWVJKHfeYkx4PB97iXLtDDT6c
0AVaPXehlq7eLaLc56fBVCZeRfJc1E67fiC+eecb+/BUrDsi5LMlSAMX6/Ln9lsf
684HsVHfGYXJHbemkEWcOveDd2NxqzNm9VA+/B23MkSR1QTL7o5elGPxmpjLsOvX
ER/nIjsbhccHy/MrFLBIFLNwuwZ5Eo1V0vHxmyYc6sEQRKH3/nXrImwzGFVaP3h2
wmtFNnm0EramP3CVdGTaYME8G5GTk9da6/C5vP4f9V8KA+ZTbaYlvPickwVZAtMo
dDKwuRsqORH5oIfxkPvIrQuv1mBLed6SMFCoqZMJ3UDKzPQkG+FrK9eEfGhvWPNW
4Ffu2xr/A15LuudyGYcA2qtA76Q85N2Q6KtqvIIXcyaDmVtozUFLOUOOp/ESbVhg
a897/urwUkZP+ccWCaiQTJOUu82ROfEqTwHCwafV9Qzrht89o5s=
=95PO
-----END PGP SIGNATURE-----

--3sqfrwaboxcezix5--
