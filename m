Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B257E4ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjKHCUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKHCUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:20:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C892E10F8;
        Tue,  7 Nov 2023 18:20:31 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF89866074E1;
        Wed,  8 Nov 2023 02:20:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699410029;
        bh=WH85Amg99tF0eV69bwx6cJ+htvNyxS1t7CApZufIQ0U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S8gRO9yZW8EkIY1hZ5B3ug0/yGipCRWYro1TMVvZpom5Qqi6w+GjoT+o8oPlq0hPl
         N/cVHoMYfiDIIaEt18SrZ0u6dUw2ra1GGO2Aglkco4vTRAM4WQWOljnusucLzkwFTt
         JksxQVAdd312jkY1O7hZIfG05+1D4YcwfR/oif3ZTm2t0VVwF4QlxmcS+P933fAEGr
         Q/O1AYfA7PR87DaqjvQqJuS1o21+XJJPus73ai7Q6cMwR5fkEhz4hShutfeL+6eqHK
         zNn4t2EU75W0TV1DBWQfFbZVGQ1oXg+WXANObJBtXaeVJVaxgPF07jyZ5bdt2YLhHb
         jGQHh7iYAGGLw==
Message-ID: <cef435872095e95e132eb9902040fa5af22c685f.camel@collabora.com>
Subject: Re: [PATCH v4 11/11] media: rkvdec: h264: Support High 10 and 4:2:2
 profiles
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
Date:   Tue, 07 Nov 2023 21:20:18 -0500
In-Reply-To: <20231105165521.3592037-12-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-12-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Add support and enable decoding of H264 High 10 and 4:2:2 profiles.
>=20
> Decoded CAPTURE buffer width is aligned to 64 pixels to accommodate HW
> requirement of 10-bit format buffers, fixes decoding of:
>=20
> - Hi422FR13_SONY_A
> - Hi422FR14_SONY_A
> - Hi422FR15_SONY_A
> - Hi422FR6_SONY_A
> - Hi422FR7_SONY_A
> - Hi422FR8_SONY_A
> - Hi422FR9_SONY_A
> - Hi422FREXT18_SONY_A
>=20
> The get_image_fmt() ops is implemented to select an image format
> required for the provided SPS control.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v4:
> - Change to use get_image_fmt() ops
>=20
> v3:
> - Add get_fmt_opaque ops, the expected pixelformat is used as opaque
> - Add new valid_fmt ops that validate pixelformat matches opaque
> - Update H264_PROFILE control max value
>=20
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 37 ++++++++++++++++------
>  drivers/staging/media/rkvdec/rkvdec.c      | 33 +++++++++++++++----
>  drivers/staging/media/rkvdec/rkvdec.h      |  3 ++
>  3 files changed, 57 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging=
/media/rkvdec/rkvdec-h264.c
> index 815d5359ddd5..baac6d012ddd 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1027,24 +1027,42 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_c=
tx *ctx,
>  	return 0;
>  }
> =20
> +static enum rkvdec_image_fmt rkvdec_h264_get_image_fmt(struct rkvdec_ctx=
 *ctx,
> +						       struct v4l2_ctrl *ctrl)
> +{
> +	const struct v4l2_ctrl_h264_sps *sps =3D ctrl->p_new.p_h264_sps;
> +
> +	if (ctrl->id !=3D V4L2_CID_STATELESS_H264_SPS)
> +		return RKVDEC_IMG_FMT_ANY;
> +
> +	if (sps->bit_depth_luma_minus8 =3D=3D 0) {
> +		if (sps->chroma_format_idc =3D=3D 2)
> +			return RKVDEC_IMG_FMT_422_8BIT;
> +		else
> +			return RKVDEC_IMG_FMT_420_8BIT;
> +	} else if (sps->bit_depth_luma_minus8 =3D=3D 2) {
> +		if (sps->chroma_format_idc =3D=3D 2)
> +			return RKVDEC_IMG_FMT_422_10BIT;
> +		else
> +			return RKVDEC_IMG_FMT_420_10BIT;
> +	}
> +
> +	return RKVDEC_IMG_FMT_ANY;
> +}
> +
>  static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
>  				    const struct v4l2_ctrl_h264_sps *sps)
>  {
>  	unsigned int width, height;
> =20
> -	/*
> -	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> -	 * but it's currently broken in the driver.
> -	 * Reject them for now, until it's fixed.
> -	 */
> -	if (sps->chroma_format_idc > 1)
> -		/* Only 4:0:0 and 4:2:0 are supported */
> +	if (sps->chroma_format_idc > 2)
> +		/* Only 4:0:0, 4:2:0 and 4:2:2 are supported */
>  		return -EINVAL;
>  	if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus8)
>  		/* Luma and chroma bit depth mismatch */
>  		return -EINVAL;
> -	if (sps->bit_depth_luma_minus8 !=3D 0)
> -		/* Only 8-bit is supported */
> +	if (sps->bit_depth_luma_minus8 !=3D 0 && sps->bit_depth_luma_minus8 !=
=3D 2)
> +		/* Only 8-bit and 10-bit is supported */
>  		return -EINVAL;
> =20
>  	width =3D (sps->pic_width_in_mbs_minus1 + 1) * 16;
> @@ -1175,4 +1193,5 @@ const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_o=
ps =3D {
>  	.stop =3D rkvdec_h264_stop,
>  	.run =3D rkvdec_h264_run,
>  	.try_ctrl =3D rkvdec_h264_try_ctrl,
> +	.get_image_fmt =3D rkvdec_h264_get_image_fmt,
>  };
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/medi=
a/rkvdec/rkvdec.c
> index 225aa1f0ac48..eb59605ccf28 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -73,7 +73,7 @@ static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ct=
x *ctx,
>  				       struct v4l2_pix_format_mplane *pix_mp)
>  {
>  	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
> -			    pix_mp->width, pix_mp->height);
> +			    ALIGN(pix_mp->width, 64), pix_mp->height);

If you align regardless if its 8/10bit (which I don't really mind, it
does not cost much and helps if you have a Mali GPU), please do in=20
rkvdec_coded_fmts[].frmsize.step_width.

Otherwise you'll endup creating a config per bit depth, and probably
won't need any of the rk format stuff, since you could just update the
config, and enumerate from there. I don't mind your method though, but
lets not hardcode alignment where it shouldn't be.

>  	pix_mp->plane_fmt[0].sizeimage +=3D 128 *
>  		DIV_ROUND_UP(pix_mp->width, 16) *
>  		DIV_ROUND_UP(pix_mp->height, 16);
> @@ -193,7 +193,7 @@ static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl=
_descs[] =3D {
>  	{
>  		.cfg.id =3D V4L2_CID_MPEG_VIDEO_H264_PROFILE,
>  		.cfg.min =3D V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,

Do we want to keep this small lie ? Baseline is not supported as we
don't support FMO and ASO. That being said, in framework like
GStreamer, we try to decode anyway, cause we know we don't have a
software fallback anyway.

> -		.cfg.max =3D V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> +		.cfg.max =3D V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422,

Should include V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10_INTRA and
V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422_INTRA too ....

>  		.cfg.menu_skip_mask =3D
>  			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),

Which requires substracting
V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE too.

>  		.cfg.def =3D V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
> @@ -210,11 +210,23 @@ static const struct rkvdec_ctrls rkvdec_h264_ctrls =
=3D {
>  	.num_ctrls =3D ARRAY_SIZE(rkvdec_h264_ctrl_descs),
>  };
> =20
> -static const struct rkvdec_decoded_fmt_desc rkvdec_h264_vp9_decoded_fmts=
[] =3D {
> +static const struct rkvdec_decoded_fmt_desc rkvdec_h264_decoded_fmts[] =
=3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.image_fmt =3D RKVDEC_IMG_FMT_420_8BIT,
>  	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV15,
> +		.image_fmt =3D RKVDEC_IMG_FMT_420_10BIT,
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV16,
> +		.image_fmt =3D RKVDEC_IMG_FMT_422_8BIT,
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV20,
> +		.image_fmt =3D RKVDEC_IMG_FMT_422_10BIT,
> +	},
>  };
> =20
>  static const struct rkvdec_ctrl_desc rkvdec_vp9_ctrl_descs[] =3D {
> @@ -237,6 +249,13 @@ static const struct rkvdec_ctrls rkvdec_vp9_ctrls =
=3D {
>  	.num_ctrls =3D ARRAY_SIZE(rkvdec_vp9_ctrl_descs),
>  };
> =20
> +static const struct rkvdec_decoded_fmt_desc rkvdec_vp9_decoded_fmts[] =
=3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12,
> +		.image_fmt =3D RKVDEC_IMG_FMT_420_8BIT,
> +	},
> +};
> +
>  static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_H264_SLICE,
> @@ -250,8 +269,8 @@ static const struct rkvdec_coded_fmt_desc rkvdec_code=
d_fmts[] =3D {
>  		},
>  		.ctrls =3D &rkvdec_h264_ctrls,
>  		.ops =3D &rkvdec_h264_fmt_ops,
> -		.num_decoded_fmts =3D ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
> -		.decoded_fmts =3D rkvdec_h264_vp9_decoded_fmts,
> +		.num_decoded_fmts =3D ARRAY_SIZE(rkvdec_h264_decoded_fmts),
> +		.decoded_fmts =3D rkvdec_h264_decoded_fmts,
>  		.subsystem_flags =3D VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
>  	},
>  	{
> @@ -266,8 +285,8 @@ static const struct rkvdec_coded_fmt_desc rkvdec_code=
d_fmts[] =3D {
>  		},
>  		.ctrls =3D &rkvdec_vp9_ctrls,
>  		.ops =3D &rkvdec_vp9_fmt_ops,
> -		.num_decoded_fmts =3D ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
> -		.decoded_fmts =3D rkvdec_h264_vp9_decoded_fmts,
> +		.num_decoded_fmts =3D ARRAY_SIZE(rkvdec_vp9_decoded_fmts),
> +		.decoded_fmts =3D rkvdec_vp9_decoded_fmts,
>  	}
>  };
> =20
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/medi=
a/rkvdec/rkvdec.h
> index e466a2753ccf..9a9f4fced7a1 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -80,6 +80,9 @@ struct rkvdec_coded_fmt_ops {
>  enum rkvdec_image_fmt {
>  	RKVDEC_IMG_FMT_ANY =3D 0,
>  	RKVDEC_IMG_FMT_420_8BIT,
> +	RKVDEC_IMG_FMT_420_10BIT,
> +	RKVDEC_IMG_FMT_422_8BIT,
> +	RKVDEC_IMG_FMT_422_10BIT,
>  };
> =20
>  struct rkvdec_decoded_fmt_desc {

