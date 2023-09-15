Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA57A1BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjIOKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjIOKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:05:54 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2E271D;
        Fri, 15 Sep 2023 03:03:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A7961C0009;
        Fri, 15 Sep 2023 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694772210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0RJaHCWox609H1viPdZua6BwY1o0hPjtbEeqoNA0ha8=;
        b=eXSkWgBNTxWofIKNGKxhYddW9tYHgH3Wp9sQ3WMOAJKvh/dFQhFZqiIDlkln+hRu83l/ue
        97J5B3RGkyDpxjiSLAvDGt6MygKC4qp+WGv0+fesqjQlsHkGvzhhsCJt6JYggG1fzrEgb4
        VbPT8/jPnvPUDl3wFnTc9b0D2RwZ2nZkDuW36/cyWq3Zv4p62gexn0q74ZZTExxw6N8wBN
        VAYsOU+TxH4ZojwVepCBGTrweACm2JpVvS3Yz5lR8w+EYx0dyDB0wMY62R28RUGxHVyfxN
        JW3JF6Ei73lBpHsMoEGL1dXP4YN6AZRkQbJwcFlXPaS6RbGfnapBe6V6yGITuQ==
Date:   Fri, 15 Sep 2023 12:03:28 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, gregkh@linuxfoundation.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: Fix clock/reset sequence
Message-ID: <ZQQr8LdOpALMIant@aptenodytes>
References: <20230911184612.1754373-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U/o0wQSnyl6QuOjI"
Content-Disposition: inline
In-Reply-To: <20230911184612.1754373-1-jernej.skrabec@gmail.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U/o0wQSnyl6QuOjI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon 11 Sep 23, 20:46, Jernej Skrabec wrote:
> According to H6 user manual, resets should always be de-asserted before
> clocks are enabled. This is also consistent with vendor driver.

You're right, thanks for the patch!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Fixes: d5aecd289bab ("media: cedrus: Implement runtime PM")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index b696bf884cbd..32af0e96e762 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -172,12 +172,12 @@ int cedrus_hw_suspend(struct device *device)
>  {
>  	struct cedrus_dev *dev =3D dev_get_drvdata(device);
> =20
> -	reset_control_assert(dev->rstc);
> -
>  	clk_disable_unprepare(dev->ram_clk);
>  	clk_disable_unprepare(dev->mod_clk);
>  	clk_disable_unprepare(dev->ahb_clk);
> =20
> +	reset_control_assert(dev->rstc);
> +
>  	return 0;
>  }
> =20
> @@ -186,11 +186,18 @@ int cedrus_hw_resume(struct device *device)
>  	struct cedrus_dev *dev =3D dev_get_drvdata(device);
>  	int ret;
> =20
> +	ret =3D reset_control_reset(dev->rstc);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to apply reset\n");
> +
> +		return ret;
> +	}
> +
>  	ret =3D clk_prepare_enable(dev->ahb_clk);
>  	if (ret) {
>  		dev_err(dev->dev, "Failed to enable AHB clock\n");
> =20
> -		return ret;
> +		goto err_rst;
>  	}
> =20
>  	ret =3D clk_prepare_enable(dev->mod_clk);
> @@ -207,21 +214,14 @@ int cedrus_hw_resume(struct device *device)
>  		goto err_mod_clk;
>  	}
> =20
> -	ret =3D reset_control_reset(dev->rstc);
> -	if (ret) {
> -		dev_err(dev->dev, "Failed to apply reset\n");
> -
> -		goto err_ram_clk;
> -	}
> -
>  	return 0;
> =20
> -err_ram_clk:
> -	clk_disable_unprepare(dev->ram_clk);
>  err_mod_clk:
>  	clk_disable_unprepare(dev->mod_clk);
>  err_ahb_clk:
>  	clk_disable_unprepare(dev->ahb_clk);
> +err_rst:
> +	reset_control_assert(dev->rstc);
> =20
>  	return ret;
>  }
> --=20
> 2.42.0
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--U/o0wQSnyl6QuOjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmUEK/AACgkQ3cLmz3+f
v9E8hQf9GCb2ltMDDoEoNcg6RITV8kvOIFCVHC3ltcesf2VF+MAj+cVGmfAen28O
r6UX5rQhptLslyX/0BJGnXhdek/fY+m/UpQuAvRSiML43HkSObcg0FU8hTnerJiF
v5WXmxrKEmOUTNNRt/OSgbtyOlCm+8rHkvbh0NdHn9T+liNXm84TxCv9GISU+OEs
8Eynlw/FOakPWImKlXBhxmhxDEs2YQYFN8f7UmjW9BDQkOFIO+kAWQX1/SwEM4ji
tLB/kcx+vq7XG6yiLmGmfG3vabJD3BMFE9qla210IgJF6NhV+ZMfyYbGVBMm/KOo
yvYTthou+syRnZfM3tQh519yYnXIbw==
=bUDq
-----END PGP SIGNATURE-----

--U/o0wQSnyl6QuOjI--
