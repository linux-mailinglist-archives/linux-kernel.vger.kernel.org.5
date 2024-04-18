Return-Path: <linux-kernel+bounces-153835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD08AD3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1BA1F21C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907315533F;
	Mon, 22 Apr 2024 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CEnsjZA0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D348154C1E;
	Mon, 22 Apr 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810587; cv=none; b=i/JYfFsAhou61wCVINBFSgGxudeEAJgb1yJfL4k8K08XPfRNQdNxWp0ejVV+ogaOvswjkI5cpAiAmG9pc7eAAzCq7M0E5mv4obZ3XYWxuCxLM6AZtYIhtfTOIFpND8v9UPpO+yWkyBjxYLODiJiLXbw6UAX351mfsnfAOQeye54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810587; c=relaxed/simple;
	bh=2ixnCGqL0IkSleO59d/pziF1WHGkr6y/66rgnEeHDHI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kdJV9y16ZOYTlf6TngS8GHhUgxFRVv7VBXj/9wQ36ey5HZL8J4V6OArHtZ/j9JwqlDth9S+fA2I4kWWRS9eTY2OburPhJuwKKbYcVtCrSmRm0HkUr7vPFzqw53XeoA0wcEfVLOtQsiRrIo5z+t+Y3M+/KLHiSXo75GL9MeAuRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CEnsjZA0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713810583;
	bh=2ixnCGqL0IkSleO59d/pziF1WHGkr6y/66rgnEeHDHI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=CEnsjZA0NDjyeiH4rcjsdcjWCEn2qLVKgaDJ8QsECsjfUcnslNyc5csmTKUb4IDmJ
	 +oT6k0mPzRY5EXYivhlPGaS922BnMw/ePdjzJsnJhzQOy06HqqSVILEc9hQBagdyzQ
	 DshkQFQ3TEe0Cq1h98P8l0MN3K5GsG5qVDIk2S5tRMdCTT22avAuksgp/Yo4Sqmq/G
	 q/awOt8OOgfnAOmB+K4iU4OIEPCtM8HMilm8AoVtDOLvyFtnTJyWiYLi94gf8E0f70
	 3jM5aHm5nTZRatXoOhtLeuQ1X7tjU3/NRGBmElkL7Y21Y+X2ZGVq0QJg5JOQeSnoUn
	 oF0AXTP2M6d+A==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3CAE3782134;
	Mon, 22 Apr 2024 18:29:41 +0000 (UTC)
Message-ID: <de7cc23f9d8b3f28dd69c1e0a029587d563a16b3.camel@collabora.com>
Subject: Re: [PATCH v2,5/5] media: mediatek: vcodec: fix incorrect
 sizeimage for 10bit bitstream
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>, =?ISO-8859-1?Q?N=EDcolas?= "F .
 R . A . Prado" <nfraprado@collabora.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
 Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig
 <frkoenig@chromium.org>,  Daniel Vetter <daniel@ffwll.ch>, Steve Cho
 <stevecho@chromium.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20240409064431.16909-6-yunfei.dong@mediatek.com>
References: <20240409064431.16909-1-yunfei.dong@mediatek.com>
	 <20240409064431.16909-6-yunfei.dong@mediatek.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 16:33:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 

Le mardi 09 avril 2024 =C3=A0 14:44 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> The sizeimage of each plane is calculated the same way for 8bit and
> 10bit bitstream. Using v4l2 common interface v4l2_fill_pixfmt_mp to
> separate.
>=20
> Fixes: 9d86be9bda6c ("media: mediatek: vcodec: Add driver to support 10bi=
t")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 28 ++++++-------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> index 9107707de6c4..fbfba69682ea 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> @@ -262,40 +262,28 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx=
 *ctx, struct v4l2_format *f,
>  		int tmp_w, tmp_h;
> =20
>  		/*
> -		 * Find next closer width align 64, height align 64, size align
> -		 * 64 rectangle
> +		 * Find next closer width align 64, heign align 64, size align 64 rect=
angle
>  		 * Note: This only get default value, the real HW needed value
>  		 *       only available when ctx in MTK_STATE_HEADER state
>  		 */
>  		tmp_w =3D pix_fmt_mp->width;
>  		tmp_h =3D pix_fmt_mp->height;
> +
>  		v4l_bound_align_image(&pix_fmt_mp->width, MTK_VDEC_MIN_W, frmsize->max=
_width, 6,
>  				      &pix_fmt_mp->height, MTK_VDEC_MIN_H, frmsize->max_height, 6,
>  				      9);
> =20
> -		if (pix_fmt_mp->width < tmp_w &&
> -		    (pix_fmt_mp->width + 64) <=3D frmsize->max_width)
> +		if (pix_fmt_mp->width < tmp_w && (pix_fmt_mp->width + 64) <=3D frmsize=
->max_width)
>  			pix_fmt_mp->width +=3D 64;
> -		if (pix_fmt_mp->height < tmp_h &&
> -		    (pix_fmt_mp->height + 64) <=3D frmsize->max_height)
> +		if (pix_fmt_mp->height < tmp_h && (pix_fmt_mp->height + 64) <=3D frmsi=
ze->max_height)
>  			pix_fmt_mp->height +=3D 64;

This seems overlay complicated, make sure your frmsize is valid (with
step_width/height set to 64 from your Mali requirement) and then simply cal=
l:

	v4l2_apply_frmsize_constraints(...)

All this hand written clamping code with hardcoded values should go away.

> =20
> +		v4l2_fill_pixfmt_mp(pix_fmt_mp, fmt->fourcc, pix_fmt_mp->width, pix_fm=
t_mp->height);
>  		mtk_v4l2_vdec_dbg(0, ctx,
> -				  "before resize wxh=3D%dx%d, after resize wxh=3D%dx%d, sizeimage=3D=
%d",
> +				  "before resize:%dx%d, after resize:%dx%d, sizeimage=3D0x%x_0x%x",
>  				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
> -				  pix_fmt_mp->width * pix_fmt_mp->height);
> -
> -		pix_fmt_mp->num_planes =3D fmt->num_planes;
> -		pix_fmt_mp->plane_fmt[0].sizeimage =3D
> -				pix_fmt_mp->width * pix_fmt_mp->height;
> -		pix_fmt_mp->plane_fmt[0].bytesperline =3D pix_fmt_mp->width;
> -
> -		if (pix_fmt_mp->num_planes =3D=3D 2) {
> -			pix_fmt_mp->plane_fmt[1].sizeimage =3D
> -				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
> -			pix_fmt_mp->plane_fmt[1].bytesperline =3D
> -				pix_fmt_mp->width;
> -		}
> +				  pix_fmt_mp->plane_fmt[0].sizeimage,
> +				  pix_fmt_mp->plane_fmt[1].sizeimage);
>  	}
> =20
>  	pix_fmt_mp->flags =3D 0;


