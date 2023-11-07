Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A67E4B82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjKGWIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjKGWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:08:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165C5BB0;
        Tue,  7 Nov 2023 14:04:25 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63D6766074B1;
        Tue,  7 Nov 2023 22:04:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699394664;
        bh=04rhiFjHql0umbupap9BGzsDxQDuWsaWY3kbI0GkfMg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dD6a0gE5VGJ11H1gEAhwTR9FrUH1jsaVFWBZcIaDwrKwDSEgpDTGR9kTpICfU7DIp
         uXpjMqvifA+cXid4SW4666SHkqAyKkgZcAz4RpDgF861Gy8FW51okhct8Pa5fvU/LO
         Nut+BAejc+U0TXoEx/P/44zyCckWpZzYf1kzsdEn/OSNM4gsr7EutmybCikL4aBMbB
         /RyA9SjIASKhJao3uC7eWxnx28nU4NzXDq0pXAz50/qPnjbCUzkC1zP/EIT7a1MO2V
         J2sC7nv9tQc5UseDNDbJDuZAYtDFSnh84FSIM1NSczREIJJnK9jhkHk1ua0V/wOKEb
         6x17EmcdEe/LA==
Message-ID: <100a1528a551627c86ec00b7e50c82e515707f01.camel@collabora.com>
Subject: Re: [PATCH v4 06/11] media: rkvdec: Extract
 rkvdec_fill_decoded_pixfmt into helper
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
Date:   Tue, 07 Nov 2023 17:04:13 -0500
In-Reply-To: <20231105165521.3592037-7-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-7-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Extract call to v4l2_fill_pixfmt_mp() and ajusting of sizeimage into a
> helper. Replace current code with a call to the new helper.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v4:
> - Do not reset pix_mp->field in rkvdec_fill_decoded_pixfmt()
>=20
> v3:
> - No changes
>=20
>  drivers/staging/media/rkvdec/rkvdec.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/medi=
a/rkvdec/rkvdec.c
> index 84a41792cb4b..0570c790ad08 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -27,6 +27,16 @@
>  #include "rkvdec.h"
>  #include "rkvdec-regs.h"
> =20
> +static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
> +				       struct v4l2_pix_format_mplane *pix_mp)
> +{
> +	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> +			    pix_mp->width, pix_mp->height);
> +	pix_mp->plane_fmt[0].sizeimage +=3D 128 *
> +		DIV_ROUND_UP(pix_mp->width, 16) *
> +		DIV_ROUND_UP(pix_mp->height, 16);
> +}
> +
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct rkvdec_ctx *ctx =3D container_of(ctrl->handler, struct rkvdec_ct=
x, ctrl_hdl);
> @@ -192,13 +202,9 @@ static void rkvdec_reset_decoded_fmt(struct rkvdec_c=
tx *ctx)
> =20
>  	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
>  	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> -	v4l2_fill_pixfmt_mp(&f->fmt.pix_mp,
> -			    ctx->coded_fmt_desc->decoded_fmts[0],
> -			    ctx->coded_fmt.fmt.pix_mp.width,
> -			    ctx->coded_fmt.fmt.pix_mp.height);
> -	f->fmt.pix_mp.plane_fmt[0].sizeimage +=3D 128 *
> -		DIV_ROUND_UP(f->fmt.pix_mp.width, 16) *
> -		DIV_ROUND_UP(f->fmt.pix_mp.height, 16);
> +	f->fmt.pix_mp.width =3D ctx->coded_fmt.fmt.pix_mp.width;
> +	f->fmt.pix_mp.height =3D ctx->coded_fmt.fmt.pix_mp.height;
> +	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
>  }
> =20
>  static int rkvdec_enum_framesizes(struct file *file, void *priv,
> @@ -264,12 +270,7 @@ static int rkvdec_try_capture_fmt(struct file *file,=
 void *priv,
>  				       &pix_mp->height,
>  				       &coded_desc->frmsize);
> =20
> -	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> -			    pix_mp->width, pix_mp->height);
> -	pix_mp->plane_fmt[0].sizeimage +=3D
> -		128 *
> -		DIV_ROUND_UP(pix_mp->width, 16) *
> -		DIV_ROUND_UP(pix_mp->height, 16);
> +	rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
>  	pix_mp->field =3D V4L2_FIELD_NONE;
> =20
>  	return 0;

