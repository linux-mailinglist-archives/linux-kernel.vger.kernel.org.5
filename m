Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31147E4EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjKHBnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKHBnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:43:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04190129;
        Tue,  7 Nov 2023 17:43:02 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BE6B66074D9;
        Wed,  8 Nov 2023 01:42:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699407781;
        bh=J8F5Q7ucdMDs/e825oZPhe28Q01sYQtT6UezG1I9+Zk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gPvdItBkqnp1eFGQfq7ZAnizTv5HNNT2uUN0dWG3KHtRuXZOS61TXHufhP+L1bnw7
         RpoTmfGbd7jiSHeR8IIIJllJBdj3RDpGN8ktvtcTO4YgFEqxuokLWqxPpYMNYbUVDj
         vjKrxgb/PFvX1DaMdz2twer8S8FnY9kG8buVVa9hcUbR5rN8nQUuu9qX2oz4F+XMJ5
         //YIacAyIKhCnoRHJgWCb/YLBbv+Bg41MlJKmMaOILI9qAygqf+zxR0jz6GXwF6Lx8
         8JbxmytCy3taORa7JOqnKvlIHgGCsqk9qBFVXoKo57/Rx4lqpvwTA6MtaoAyA627lQ
         CppVPfx7TA4FQ==
Message-ID: <7461e7b7cc9abc4cee027a950550192fea8ff972.camel@collabora.com>
Subject: Re: [PATCH v4 07/11] media: rkvdec: Move rkvdec_reset_decoded_fmt
 helper
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
Date:   Tue, 07 Nov 2023 20:42:49 -0500
In-Reply-To: <20231105165521.3592037-8-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-8-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Move rkvdec_reset_decoded_fmt() and the called rkvdec_reset_fmt() helper
> functions in preparation for adding a new caller in an upcoming patch.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v4:
> - No change
>=20
> v3:
> - New patch
>=20
>  drivers/staging/media/rkvdec/rkvdec.c | 46 +++++++++++++--------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/medi=
a/rkvdec/rkvdec.c
> index 0570c790ad08..7a79840470e1 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -37,6 +37,29 @@ static void rkvdec_fill_decoded_pixfmt(struct rkvdec_c=
tx *ctx,
>  		DIV_ROUND_UP(pix_mp->height, 16);
>  }
> =20
> +static void rkvdec_reset_fmt(struct rkvdec_ctx *ctx, struct v4l2_format =
*f,
> +			     u32 fourcc)
> +{
> +	memset(f, 0, sizeof(*f));
> +	f->fmt.pix_mp.pixelformat =3D fourcc;
> +	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	f->fmt.pix_mp.colorspace =3D V4L2_COLORSPACE_REC709;
> +	f->fmt.pix_mp.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
> +	f->fmt.pix_mp.quantization =3D V4L2_QUANTIZATION_DEFAULT;
> +	f->fmt.pix_mp.xfer_func =3D V4L2_XFER_FUNC_DEFAULT;
> +}
> +
> +static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
> +{
> +	struct v4l2_format *f =3D &ctx->decoded_fmt;
> +
> +	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
> +	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	f->fmt.pix_mp.width =3D ctx->coded_fmt.fmt.pix_mp.width;
> +	f->fmt.pix_mp.height =3D ctx->coded_fmt.fmt.pix_mp.height;
> +	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
> +}
> +
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct rkvdec_ctx *ctx =3D container_of(ctrl->handler, struct rkvdec_ct=
x, ctrl_hdl);
> @@ -169,18 +192,6 @@ rkvdec_find_coded_fmt_desc(u32 fourcc)
>  	return NULL;
>  }
> =20
> -static void rkvdec_reset_fmt(struct rkvdec_ctx *ctx, struct v4l2_format =
*f,
> -			     u32 fourcc)
> -{
> -	memset(f, 0, sizeof(*f));
> -	f->fmt.pix_mp.pixelformat =3D fourcc;
> -	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> -	f->fmt.pix_mp.colorspace =3D V4L2_COLORSPACE_REC709;
> -	f->fmt.pix_mp.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
> -	f->fmt.pix_mp.quantization =3D V4L2_QUANTIZATION_DEFAULT;
> -	f->fmt.pix_mp.xfer_func =3D V4L2_XFER_FUNC_DEFAULT;
> -}
> -
>  static void rkvdec_reset_coded_fmt(struct rkvdec_ctx *ctx)
>  {
>  	struct v4l2_format *f =3D &ctx->coded_fmt;
> @@ -196,17 +207,6 @@ static void rkvdec_reset_coded_fmt(struct rkvdec_ctx=
 *ctx)
>  		ctx->coded_fmt_desc->ops->adjust_fmt(ctx, f);
>  }
> =20
> -static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
> -{
> -	struct v4l2_format *f =3D &ctx->decoded_fmt;
> -
> -	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
> -	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> -	f->fmt.pix_mp.width =3D ctx->coded_fmt.fmt.pix_mp.width;
> -	f->fmt.pix_mp.height =3D ctx->coded_fmt.fmt.pix_mp.height;
> -	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
> -}
> -
>  static int rkvdec_enum_framesizes(struct file *file, void *priv,
>  				  struct v4l2_frmsizeenum *fsize)
>  {

