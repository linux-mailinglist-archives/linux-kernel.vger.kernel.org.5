Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395A7E4B27
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbjKGVv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjKGVvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:51:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D454610D0;
        Tue,  7 Nov 2023 13:51:20 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5AB16607401;
        Tue,  7 Nov 2023 21:45:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699393546;
        bh=DtbLU0wHZ0G0WvnrPIsVpEezzlIwBSG/DKHMXei+PGE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eDdNhy3HAVeIpimFOnx++8cKWFrOm9CuaBvSj80xx0LAPNSeKgT/18S86QDq7bwTn
         jcPzgBoWwClqBB9s+zxh/h+i65DmZ4gbTJ6z7L7lj/tuUj94neeSVP8S+ux5ME3ibF
         t8yRibvqDJWn0lW/6bK332c/k2jn/1Sf5T9du8SRCFebsQJ079BZ0T/xhS+FmBw8Go
         nzQzy4Z6rNbrvVeHkdLlQ3Bp91G2Wu6cPp8H0l05uTJtaWT7YVlY97W7431ebm2RGn
         BsZqZ7rfx1MkSLmbNCLECiO1UMhQEMllZ9mGhQ+ss+3JsFSHms4HDu46Wb5sDrqBhN
         NlffeoLIyPGMA==
Message-ID: <ebbecd2d2ecda8b3d94939a6408ef6dad6c6e6fe.camel@collabora.com>
Subject: Re: [PATCH v4 03/11] media: rkvdec: h264: Use bytesperline and
 buffer height as virstride
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
Date:   Tue, 07 Nov 2023 16:45:33 -0500
In-Reply-To: <20231105165521.3592037-4-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-4-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Use bytesperline and buffer height to calculate the strides configured.
>=20
> This does not really change anything other than ensuring the
> bytesperline that is signaled to userspace matches what is configured
> in HW.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v4:
> - No change
>=20
> v3:
> - Remove unnecessary yuv_virstride +=3D
>=20
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging=
/media/rkvdec/rkvdec-h264.c
> index 4fc167b42cf0..7a1e76d423df 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -896,9 +896,9 @@ static void config_registers(struct rkvdec_ctx *ctx,
>  	dma_addr_t rlc_addr;
>  	dma_addr_t refer_addr;
>  	u32 rlc_len;
> -	u32 hor_virstride =3D 0;
> -	u32 ver_virstride =3D 0;
> -	u32 y_virstride =3D 0;
> +	u32 hor_virstride;
> +	u32 ver_virstride;
> +	u32 y_virstride;
>  	u32 yuv_virstride =3D 0;
>  	u32 offset;
>  	dma_addr_t dst_addr;
> @@ -909,16 +909,16 @@ static void config_registers(struct rkvdec_ctx *ctx=
,
> =20
>  	f =3D &ctx->decoded_fmt;
>  	dst_fmt =3D &f->fmt.pix_mp;
> -	hor_virstride =3D (sps->bit_depth_luma_minus8 + 8) * dst_fmt->width / 8=
;
> -	ver_virstride =3D round_up(dst_fmt->height, 16);
> +	hor_virstride =3D dst_fmt->plane_fmt[0].bytesperline;
> +	ver_virstride =3D dst_fmt->height;
>  	y_virstride =3D hor_virstride * ver_virstride;
> =20
>  	if (sps->chroma_format_idc =3D=3D 0)
>  		yuv_virstride =3D y_virstride;
>  	else if (sps->chroma_format_idc =3D=3D 1)
> -		yuv_virstride +=3D y_virstride + y_virstride / 2;
> +		yuv_virstride =3D y_virstride + y_virstride / 2;
>  	else if (sps->chroma_format_idc =3D=3D 2)
> -		yuv_virstride +=3D 2 * y_virstride;
> +		yuv_virstride =3D 2 * y_virstride;
> =20
>  	reg =3D RKVDEC_Y_HOR_VIRSTRIDE(hor_virstride / 16) |
>  	      RKVDEC_UV_HOR_VIRSTRIDE(hor_virstride / 16) |

