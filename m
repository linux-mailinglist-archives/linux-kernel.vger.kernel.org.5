Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748C47E4B73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjKGWFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjKGWEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:04:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB635AB;
        Tue,  7 Nov 2023 14:01:14 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9073C66074B5;
        Tue,  7 Nov 2023 22:01:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699394473;
        bh=kl2jjVmIoGV4j4wny32gFtvgWSKHKwWLI3Ngr8+kGgE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B//ZgroOgxg/nhU4EmN+zhYY3+pIKTam4MPNMg0n87Wd4iQVXG9FyhsDMWcKj75iR
         PIQIIq1j9o62aRqKWUWbhAzx725msK3iXOghpJrk6nyHSjNwEciklkmq30s7dz+Was
         drfy0fX7WCjRiEv1LLED1TwbPVEHkj4wvU5NyK1g3kFI+q5JnSE87LMDYhzfjshraC
         VZ6abiqhAx0oA1Rrz0jMxTDhj52FqckO7wfszj09SEfeVETfqebqf7gE+2lOkgZWCx
         bpU/QQDtAsWuZX97J8LdWNfZ8cF/fOjI4hNwO4djFeeTDN3ZWRQqbfWCyuWtrI8EMp
         bHH+KpW/08Q9g==
Message-ID: <c75c894a09292775773ad338121ee81924337cf0.camel@collabora.com>
Subject: Re: [PATCH v4 05/11] media: rkvdec: h264: Remove SPS validation at
 streaming start
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 17:01:02 -0500
In-Reply-To: <20231105165521.3592037-6-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-6-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> SPS parameters is validated in try_ctrl() ops so there is no need to

                 are

> re-validate when streaming starts.
>=20
> Remove the unnecessary call to validate sps at streaming start.

This patch is not working since user may change the format after the
control have been set. The proper fix should actually reset the SPS
(well all header controls) to match the the newly set format. Then this
validation won't be needed anymore.

The sequence that is problematic after this patch is:

S_FMT (OUTPUT, width, height);
S_CTRL (SPS) // valid
S_FMT(OUTPUT, width', height'); // SPS is no longer valid

One suggestion I may make is to add a ops so that each codec
implementation can reset their header controls to make it valid against
the new resolution. With that in place you'll be able drop the check.

Nicolas

p.s. you can also just drop this patch from the series and revisit it
later, though I think its worth fixing.

>=20
> Suggested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v4:
> - No change
>=20
> v3:
> - New patch
>=20
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging=
/media/rkvdec/rkvdec-h264.c
> index 8bce8902b8dd..815d5359ddd5 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1070,17 +1070,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ct=
x)
>  	struct rkvdec_dev *rkvdec =3D ctx->dev;
>  	struct rkvdec_h264_priv_tbl *priv_tbl;
>  	struct rkvdec_h264_ctx *h264_ctx;
> -	struct v4l2_ctrl *ctrl;
> -	int ret;
> -
> -	ctrl =3D v4l2_ctrl_find(&ctx->ctrl_hdl,
> -			      V4L2_CID_STATELESS_H264_SPS);
> -	if (!ctrl)
> -		return -EINVAL;
> -
> -	ret =3D rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> -	if (ret)
> -		return ret;
> =20
>  	h264_ctx =3D kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
>  	if (!h264_ctx)
> @@ -1089,8 +1078,8 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx=
)
>  	priv_tbl =3D dma_alloc_coherent(rkvdec->dev, sizeof(*priv_tbl),
>  				      &h264_ctx->priv_tbl.dma, GFP_KERNEL);
>  	if (!priv_tbl) {
> -		ret =3D -ENOMEM;
> -		goto err_free_ctx;
> +		kfree(h264_ctx);
> +		return -ENOMEM;
>  	}
> =20
>  	h264_ctx->priv_tbl.size =3D sizeof(*priv_tbl);
> @@ -1100,10 +1089,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ct=
x)
> =20
>  	ctx->priv =3D h264_ctx;
>  	return 0;
> -
> -err_free_ctx:
> -	kfree(h264_ctx);
> -	return ret;
>  }
> =20
>  static void rkvdec_h264_stop(struct rkvdec_ctx *ctx)

