Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD17E4EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjKHBuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKHBuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:50:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0B199;
        Tue,  7 Nov 2023 17:50:20 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51E9F66074D9;
        Wed,  8 Nov 2023 01:50:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699408219;
        bh=djBTnvej1NJw96WFQnceU1jAj+Exjgi1104R6Pyel94=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bBdiMTE/C99/f9E1FZvUIA59EToJnZqUOmxE9LZqiwzxgHkMv3MZoe0vGH+UAndwF
         05vSa7q/quGzJWBJ3wvzHXJMmkuoqUEeW5do03JAcSaojhP14ZG2WMtyhVIW2iQqeD
         JC6Ntv2bojyaIDiRgs6rvd/A4fRE/IjXceXfLZ09WUaDYGlZYUiAQigF+SVc0m72nE
         4jaeX6tgybebdBPytTsxlIhlxinawyN8a56SWRa6+fuljxkwh3bBaWMRt1TOI0JGWq
         yRyr+Fn+oR6v/81UgDV8HH+Gufryj+HVonXIkzY3/QrD6MaSBDG1QXkeX2oS3hx+cw
         zcmfttqxUQrDQ==
Message-ID: <4e6767958d1f0d82db8a9a7c7807648519f5e7ee.camel@collabora.com>
Subject: Re: [PATCH v4 08/11] media: rkvdec: Extract decoded format
 enumeration into helper
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
Date:   Tue, 07 Nov 2023 20:50:07 -0500
In-Reply-To: <20231105165521.3592037-9-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-9-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Add a rkvdec_is_valid_fmt() helper that check if a fourcc is a supported
> CAPTURE format, and a rkvdec_enum_decoded_fmt() helper that enumerate
                                                              enumerates
> valid formats.
>=20
> This move current code into helper functions in preparation for adding
       moves
> CAPTURE format filtering and validation in next patch.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

With the fixed,
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v4:
> - Rename rkvdec_decoded_fmts() to rkvdec_enum_decoded_fmt()
> - Rename rkvdec_valid_fmt() to rkvdec_is_valid_fmt()
>=20
> v3:
> - New patch
>=20
>  drivers/staging/media/rkvdec/rkvdec.c | 49 +++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/medi=
a/rkvdec/rkvdec.c
> index 7a79840470e1..c3aede94c872 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -27,6 +27,32 @@
>  #include "rkvdec.h"
>  #include "rkvdec-regs.h"
> =20
> +static u32 rkvdec_enum_decoded_fmt(struct rkvdec_ctx *ctx, int index)
> +{
> +	const struct rkvdec_coded_fmt_desc *desc =3D ctx->coded_fmt_desc;
> +
> +	if (WARN_ON(!desc))
> +		return 0;
> +
> +	if (index >=3D desc->num_decoded_fmts)
> +		return 0;
> +
> +	return desc->decoded_fmts[index];
> +}
> +
> +static bool rkvdec_is_valid_fmt(struct rkvdec_ctx *ctx, u32 fourcc)
> +{
> +	const struct rkvdec_coded_fmt_desc *desc =3D ctx->coded_fmt_desc;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < desc->num_decoded_fmts; i++) {
> +		if (desc->decoded_fmts[i] =3D=3D fourcc)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
>  				       struct v4l2_pix_format_mplane *pix_mp)
>  {
> @@ -52,8 +78,10 @@ static void rkvdec_reset_fmt(struct rkvdec_ctx *ctx, s=
truct v4l2_format *f,
>  static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
>  {
>  	struct v4l2_format *f =3D &ctx->decoded_fmt;
> +	u32 fourcc;
> =20
> -	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
> +	fourcc =3D rkvdec_enum_decoded_fmt(ctx, 0);
> +	rkvdec_reset_fmt(ctx, f, fourcc);
>  	f->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>  	f->fmt.pix_mp.width =3D ctx->coded_fmt.fmt.pix_mp.width;
>  	f->fmt.pix_mp.height =3D ctx->coded_fmt.fmt.pix_mp.height;
> @@ -244,7 +272,6 @@ static int rkvdec_try_capture_fmt(struct file *file, =
void *priv,
>  	struct v4l2_pix_format_mplane *pix_mp =3D &f->fmt.pix_mp;
>  	struct rkvdec_ctx *ctx =3D fh_to_rkvdec_ctx(priv);
>  	const struct rkvdec_coded_fmt_desc *coded_desc;
> -	unsigned int i;
> =20
>  	/*
>  	 * The codec context should point to a coded format desc, if the format
> @@ -255,13 +282,8 @@ static int rkvdec_try_capture_fmt(struct file *file,=
 void *priv,
>  	if (WARN_ON(!coded_desc))
>  		return -EINVAL;
> =20
> -	for (i =3D 0; i < coded_desc->num_decoded_fmts; i++) {
> -		if (coded_desc->decoded_fmts[i] =3D=3D pix_mp->pixelformat)
> -			break;
> -	}
> -
> -	if (i =3D=3D coded_desc->num_decoded_fmts)
> -		pix_mp->pixelformat =3D coded_desc->decoded_fmts[0];
> +	if (!rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat))
> +		pix_mp->pixelformat =3D rkvdec_enum_decoded_fmt(ctx, 0);
> =20
>  	/* Always apply the frmsize constraint of the coded end. */
>  	pix_mp->width =3D max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
> @@ -425,14 +447,13 @@ static int rkvdec_enum_capture_fmt(struct file *fil=
e, void *priv,
>  				   struct v4l2_fmtdesc *f)
>  {
>  	struct rkvdec_ctx *ctx =3D fh_to_rkvdec_ctx(priv);
> +	u32 fourcc;
> =20
> -	if (WARN_ON(!ctx->coded_fmt_desc))
> -		return -EINVAL;
> -
> -	if (f->index >=3D ctx->coded_fmt_desc->num_decoded_fmts)
> +	fourcc =3D rkvdec_enum_decoded_fmt(ctx, f->index);
> +	if (!fourcc)
>  		return -EINVAL;
> =20
> -	f->pixelformat =3D ctx->coded_fmt_desc->decoded_fmts[f->index];
> +	f->pixelformat =3D fourcc;
>  	return 0;
>  }
> =20

