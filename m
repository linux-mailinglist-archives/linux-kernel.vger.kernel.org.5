Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2FF7E4F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjKHCpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjKHCp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:45:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C3184;
        Tue,  7 Nov 2023 18:45:25 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6822766074D3;
        Wed,  8 Nov 2023 02:45:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699411524;
        bh=6wXQfetxwy+D5CmT3AkE+ELY/xU4NDY2a0E7Zs38Vz4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gVXqAw5QrLvzAZsKe7m0U0ovIcOZJt8Z4Au74SpOcRx71jGcpQiv7/1pyXNvMpIbh
         EOajx1g7hwDYm+UTOVDrbYRL7z8nACJOlwOLTPGPeVZGzeTiWHwGDLKajM5+W3eRiN
         hlV2YjksBvR8Te4IXk8RAN9SLJuNmPvxSxyo2v95Q0/r4ObFhvOGIGJHSYcYkzfG8c
         kzexPDsVjO2tq0azSXENPbe4rt0Epd/T6qEtast7Gw01Cobya/qgbjpFWQ3LNORlGs
         b38XDz7FckLTyn0lrRElEnEqamKhkWRpnxrd/xB3XINysoqO1pvFgaRcyQ5IEliy5Y
         wMuzSe/3o1vxA==
Message-ID: <02c819bbbaa34342be39cfaed707ddf9a33a9087.camel@collabora.com>
Subject: Re: [PATCH v4 01/11] media: v4l2-common: Add helpers to calculate
 bytesperline and sizeimage
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 21:45:13 -0500
In-Reply-To: <20231105165521.3592037-2-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-2-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Add helper functions to calculate plane bytesperline and sizeimage,
> these new helpers consider bpp div, block width and height when
> calculating plane bytesperline and sizeimage.

Is this only refactoring to reduce duplicated code ? I haven't seen
what is new in there yet, maybe the commit message could clarify.

regards,
Nicolas

>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v4:
> - No change
>=20
> v3:
> - Consider bpp_div in calculation
>=20
>  drivers/media/v4l2-core/v4l2-common.c | 78 +++++++++++++--------------
>  1 file changed, 39 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 3a4b15a98e02..834b426da8b1 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -350,6 +350,34 @@ static inline unsigned int v4l2_format_block_height(=
const struct v4l2_format_inf
>  	return info->block_h[plane];
>  }
> =20
> +static inline unsigned int v4l2_format_plane_width(const struct v4l2_for=
mat_info *info, int plane,
> +						   unsigned int width)
> +{
> +	unsigned int hdiv =3D plane ? info->hdiv : 1;
> +	unsigned int aligned_width =3D
> +		ALIGN(width, v4l2_format_block_width(info, plane));
> +
> +	return DIV_ROUND_UP(aligned_width, hdiv) *
> +	       info->bpp[plane] / info->bpp_div[plane];
> +}
> +
> +static inline unsigned int v4l2_format_plane_height(const struct v4l2_fo=
rmat_info *info, int plane,
> +						    unsigned int height)
> +{
> +	unsigned int vdiv =3D plane ? info->vdiv : 1;
> +	unsigned int aligned_height =3D
> +		ALIGN(height, v4l2_format_block_height(info, plane));
> +
> +	return DIV_ROUND_UP(aligned_height, vdiv);
> +}
> +
> +static inline unsigned int v4l2_format_plane_size(const struct v4l2_form=
at_info *info, int plane,
> +						  unsigned int width, unsigned int height)
> +{
> +	return v4l2_format_plane_width(info, plane, width) *
> +	       v4l2_format_plane_height(info, plane, height);
> +}
> +
>  void v4l2_apply_frmsize_constraints(u32 *width, u32 *height,
>  				    const struct v4l2_frmsize_stepwise *frmsize)
>  {
> @@ -385,37 +413,19 @@ int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mpla=
ne *pixfmt,
> =20
>  	if (info->mem_planes =3D=3D 1) {
>  		plane =3D &pixfmt->plane_fmt[0];
> -		plane->bytesperline =3D ALIGN(width, v4l2_format_block_width(info, 0))=
 * info->bpp[0] / info->bpp_div[0];
> +		plane->bytesperline =3D v4l2_format_plane_width(info, 0, width);
>  		plane->sizeimage =3D 0;
> =20
> -		for (i =3D 0; i < info->comp_planes; i++) {
> -			unsigned int hdiv =3D (i =3D=3D 0) ? 1 : info->hdiv;
> -			unsigned int vdiv =3D (i =3D=3D 0) ? 1 : info->vdiv;
> -			unsigned int aligned_width;
> -			unsigned int aligned_height;
> -
> -			aligned_width =3D ALIGN(width, v4l2_format_block_width(info, i));
> -			aligned_height =3D ALIGN(height, v4l2_format_block_height(info, i));
> -
> -			plane->sizeimage +=3D info->bpp[i] *
> -				DIV_ROUND_UP(aligned_width, hdiv) *
> -				DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
> -		}
> +		for (i =3D 0; i < info->comp_planes; i++)
> +			plane->sizeimage +=3D
> +				v4l2_format_plane_size(info, i, width, height);
>  	} else {
>  		for (i =3D 0; i < info->comp_planes; i++) {
> -			unsigned int hdiv =3D (i =3D=3D 0) ? 1 : info->hdiv;
> -			unsigned int vdiv =3D (i =3D=3D 0) ? 1 : info->vdiv;
> -			unsigned int aligned_width;
> -			unsigned int aligned_height;
> -
> -			aligned_width =3D ALIGN(width, v4l2_format_block_width(info, i));
> -			aligned_height =3D ALIGN(height, v4l2_format_block_height(info, i));
> -
>  			plane =3D &pixfmt->plane_fmt[i];
>  			plane->bytesperline =3D
> -				info->bpp[i] * DIV_ROUND_UP(aligned_width, hdiv) / info->bpp_div[i];
> -			plane->sizeimage =3D
> -				plane->bytesperline * DIV_ROUND_UP(aligned_height, vdiv);
> +				v4l2_format_plane_width(info, i, width);
> +			plane->sizeimage =3D plane->bytesperline *
> +				v4l2_format_plane_height(info, i, height);
>  		}
>  	}
>  	return 0;
> @@ -439,22 +449,12 @@ int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt=
, u32 pixelformat,
>  	pixfmt->width =3D width;
>  	pixfmt->height =3D height;
>  	pixfmt->pixelformat =3D pixelformat;
> -	pixfmt->bytesperline =3D ALIGN(width, v4l2_format_block_width(info, 0))=
 * info->bpp[0] / info->bpp_div[0];
> +	pixfmt->bytesperline =3D v4l2_format_plane_width(info, 0, width);
>  	pixfmt->sizeimage =3D 0;
> =20
> -	for (i =3D 0; i < info->comp_planes; i++) {
> -		unsigned int hdiv =3D (i =3D=3D 0) ? 1 : info->hdiv;
> -		unsigned int vdiv =3D (i =3D=3D 0) ? 1 : info->vdiv;
> -		unsigned int aligned_width;
> -		unsigned int aligned_height;
> -
> -		aligned_width =3D ALIGN(width, v4l2_format_block_width(info, i));
> -		aligned_height =3D ALIGN(height, v4l2_format_block_height(info, i));
> -
> -		pixfmt->sizeimage +=3D info->bpp[i] *
> -			DIV_ROUND_UP(aligned_width, hdiv) *
> -			DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
> -	}
> +	for (i =3D 0; i < info->comp_planes; i++)
> +		pixfmt->sizeimage +=3D
> +			v4l2_format_plane_size(info, i, width, height);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_fill_pixfmt);

