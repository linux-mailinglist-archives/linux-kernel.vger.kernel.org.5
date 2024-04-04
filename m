Return-Path: <linux-kernel+bounces-131957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A6898DED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8970D1C22AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD4130ADD;
	Thu,  4 Apr 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2wirKzlL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13212CD9C;
	Thu,  4 Apr 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255349; cv=none; b=R9srwrApNSKihKJo47pv7gwC9ouzWH14bBRgEq/hrm+c5elV36LnmyWVD/MabbQTPl7hiWRALxzk2ij7Sv1QKnFg65ExuZXJKqpjnLagybb285UB/OXcEl1nzkXD+cwY1TLOoQgtP0XdnPuHva87SMHm9Ipf5u9nsbNgVbJYWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255349; c=relaxed/simple;
	bh=NmU8KFMfNoUMM9NLhO7uk8bPhscbUNMmBYEZDzGYqCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzCKI0N5X1ogPw4eK5WadrDRIxaDHLZflCtPfC1vEia2lHvmvkxBelTyWIOuu4071KWBiFm1i+zbGVWfmxI7JPYain9D0AeUTyS6FqZ4l/VRTZb/aBYWvi3Y099qeBq30DjQ3YEhZ93+MzQhFBBa3t6sr9ZpzpX69IL7Laj3Kwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2wirKzlL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712255345;
	bh=NmU8KFMfNoUMM9NLhO7uk8bPhscbUNMmBYEZDzGYqCA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=2wirKzlL2FX0E2q3XU0W+0S+XRZK0fL7JC5B3/y0ikWxuSRC2BWz3bBMYaiNJB+qX
	 ppaoLO1WHmCDbQHNzduxpH44j2ZZqXVfdDDZa37l4BjeQuedjR7rwtr2rE3VBcVBTn
	 tONu6WKfKo5GxGQcssYfnwL8Eyvr/XnmitdSgOOKuTg8QocxhkNWtcYCmRiQecWfz4
	 Pkl+l+PyVN1U0rPTeToNOFyRVCFr4z+NI6DWzW8Zb6lvU/FakrDh9IKpr+HeL+N5HY
	 wR5T5lcdTQ6oGmq0pqRGLHiXFl0Tr2RKBLsOUPXofgL7NIFFr2pWBhFt1mj+GcpAJn
	 gAi9278YX4vHw==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 387EA37813DF;
	Thu,  4 Apr 2024 18:29:03 +0000 (UTC)
Message-ID: <1ca5278d8c15b45ebd6f28b9043a98f28b5ae128.camel@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: fix the error sizeimage for
 10bit bitstream
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>, =?ISO-8859-1?Q?N=EDcolas?= "F .
 R . A . Prado" <nfraprado@collabora.com>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Nathan Hebert
 <nhebert@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig
 <frkoenig@chromium.org>,  Daniel Vetter <daniel@ffwll.ch>, Steve Cho
 <stevecho@chromium.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
Date: Thu, 04 Apr 2024 14:28:59 -0400
In-Reply-To: <20240403093018.13168-1-yunfei.dong@mediatek.com>
References: <20240403093018.13168-1-yunfei.dong@mediatek.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mQGiBEUQN0MRBACQYceNSezSdMjx7sx6gwKkMghrrODgl3B0eXBTgNp6c431IfOOEsdvkoOh1kwoYcQgbg4MXw6beOltysX4e8fFWsiRkc2nvvRW9ir9kHDm49MkBLqaDjTqOkYKNMiurFW+gozpr/lUW15QqT6v68RYe0zRdtwGZqeLzX2LVuukGwCg4AISzswrrYHNV7vQLcbaUhPgIl0D+gILYT9TJgAEK4YHW+bFRcY+cgUFoLQqQayECMlctKoLOE69nIYOc/hDr9uih1wxrQ/yL0NJvQCohSPyoyLF9b2EuIGhQVp05XP7FzlTxhYvGO/DtO08ec85+bTfVBMV6eeY4MS3ZU+1z7ObD7Pf29YjyTehN2Dan6w1g2rBk5MoA/9nDocSlk4pbFpsYSFmVHsDiAOFje3+iY4ftVDKunKYWMhwRVBjAREOByBagmRau0cLEcElpf4hX5f978GoxSGIsiKoDAlXX+ICDOWC1/EXhEEmBR1gL0QJgiVviNyLfGJlZWnPjw6xhhmtHYWTDxBOP5peztyc2PqeKsLsLWzAr7RDTmljb2xhcyBEdWZyZXNuZSAoQi4gU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPohgBBMRAgAgBQJFlCyOAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQcVMCLawGqBwhLQCgzYlrLBj6KIAZ4gmsfjXD6ZtddT8AoIeGDicVq5WvMHNWign6ApQcZUihtElOaWNvbGFzIER1ZnJlc25lIChCLiBTYy4gSW5mb3JtYXRpcXVlKSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY28udWs+iGIEExECACIFAkuzca8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFTAi2sBqgcQX8An2By6LDEeMxi4B9hUbpvRnzaaeNqA
	J9Rox8rfqHZnSErw9bCHiBwvwJZ77QxTmljb2xhcyBEdWZyZXNuZSA8bmljb2xhcy5kdWZyZXNuZUBjb2xsYWJvcmEuY29tPohiBBMRAgAiBQJNzZzPAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHLlxAKCYAGf4JL7DYDLs/188CPMGuwLypwCfWKc9DorA9f5pyYlD5pQo6SgSoiC0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPohiBBMRAgAiBQJVwNwgAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBxUwItrAaoHCZ4AJ0QwU6/G4c7h9CkMBT9ZxGLX4KSnQCgq0P7CX7hv/M7HeyfMFZe8t3vAEW0RE5pY29sYXMgRHVmcmVzbmUgKEIuIFNjLiBJbmZvcm1hdGlxdWUpIDxuaWNvbGFzZEBibHVlc3RyZWFrdGVjaC5jb20+iGAEExECACAFAkZjGzoCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHBl7AJ0d2lrzshMmJaik/EaDEakzEwqgxQCg0JVZMZm9gRfEou1FvinuZxwf/mu0R05pY29sYXMgRHVmcmVzbmUgKEIgU2MuIEluZm9ybWF0aXF1ZSkgPG5pY29sYXMuZHVmcmVzbmVAdXNoZXJicm9va2UuY2E+iGAEExECACAFAkUQN0MCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRBxUwItrAaoHPTnAJ0WGgJJVspoctAvEcI00mtp5WAFGgCgr+E7ItOqZEHAs+xabBgknYZIFPW5Ag0ERRA3UhAIAJ0rxl2HsVg/nSOAUt7U/T/W+RKzVAlD9orCB0pRVvyWNxSr8MHcHmWCxykLuB34ouM4GuDVRKfGnqLzJRBfjs7Ax9K2FI3Odund9xpviLCt1jFC0K
	XL04RebrFT7xjDfocDaSLFvgxMVs/Jr2/ckKPId1oKvgYgt/o+MzUabKyFB8wIvq4GMtj3LoBKLCie2nCaSt7uVUt6q2t5bNWrd3lO6/mWn7YMc5Hsn33H9pS0+9szw6m3dG08eMKNueDlt72QxiYl2rhjzkT4ltKEkFgYBdyrtIj1UO6eX+YXb4E1rCMJrdjBSgqDPK1sWHC7gliy+izr+XTHuFwlfy8gBpsAAwUIAJJNus64gri4HAL632eqVpza83EphX1IuHzLi1LlMnQ9Tm7XKag46NhmJbOByMG33LwBsBdLjjHQSVkYZFWUifq+NWSFC/kqlb72vW8rBAv64+i3QdfxK9FWbweiRsPpvuHjJQuecbPDJpubLaxKbu2aqLCN5LuHXvdQr6KiXwabT+OJ9AJAqHG7q4IEzg4RNUVn9AS6L8bxqMSocjqpWNBCY2efCVd/c6k4Acv6jXu+wDAZEbWXK+71uaUHExhigBYBpiHGrobe32YlTVE/XEIzKKywhm/Hkn5YKWzumLte6xiD9JhKabmD7uqIvLt2twUpz4BdPzj0dvGlSmvFcaaISQQYEQIACQUCRRA3UgIbDAAKCRBxUwItrAaoHJLyAKDeS3AFowM3f1Y3OFU6XRCTKK2ZhwCfT/7P9WDjkkmiq5AfeOiwVlpuHtM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 03 avril 2024 =C3=A0 17:30 +0800, Yunfei Dong a =C3=A9crit=C2=
=A0:
> The sizeimage of each plane are calculated the same way for 8bit and
> 10bit bitstream. Need to enlarge the sizeimage with simeimage*5/4 for
> 10bit bitstream when try and set fmt.

Can we stop adding more layers of custom code and port to v4l2-common helpe=
rs
please.

regards,
Nicolas

>=20
> Fixes: 9d86be9bda6c ("media: mediatek: vcodec: Add driver to support 10bi=
t")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 47 ++++++++++++++-----
>  1 file changed, 34 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> index 9107707de6c4..45209894f1fe 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
> @@ -259,6 +259,7 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx *=
ctx, struct v4l2_format *f,
>  		pix_fmt_mp->num_planes =3D 1;
>  		pix_fmt_mp->plane_fmt[0].bytesperline =3D 0;
>  	} else if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> +		unsigned int dram_y, dram_c, dram_y_10bit, dram_c_10bit;
>  		int tmp_w, tmp_h;
> =20
>  		/*
> @@ -280,22 +281,42 @@ static int vidioc_try_fmt(struct mtk_vcodec_dec_ctx=
 *ctx, struct v4l2_format *f,
>  		    (pix_fmt_mp->height + 64) <=3D frmsize->max_height)
>  			pix_fmt_mp->height +=3D 64;
> =20
> -		mtk_v4l2_vdec_dbg(0, ctx,
> -				  "before resize wxh=3D%dx%d, after resize wxh=3D%dx%d, sizeimage=3D=
%d",
> -				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
> -				  pix_fmt_mp->width * pix_fmt_mp->height);
> +		dram_y =3D pix_fmt_mp->width * pix_fmt_mp->height;
> +		dram_c =3D dram_y / 2;
> +
> +		dram_y_10bit =3D dram_y * 5 / 4;
> +		dram_c_10bit =3D dram_y_10bit / 2;
> =20
>  		pix_fmt_mp->num_planes =3D fmt->num_planes;
> -		pix_fmt_mp->plane_fmt[0].sizeimage =3D
> -				pix_fmt_mp->width * pix_fmt_mp->height;
> -		pix_fmt_mp->plane_fmt[0].bytesperline =3D pix_fmt_mp->width;
> -
> -		if (pix_fmt_mp->num_planes =3D=3D 2) {
> -			pix_fmt_mp->plane_fmt[1].sizeimage =3D
> -				(pix_fmt_mp->width * pix_fmt_mp->height) / 2;
> -			pix_fmt_mp->plane_fmt[1].bytesperline =3D
> -				pix_fmt_mp->width;
> +		if (pix_fmt_mp->num_planes =3D=3D 1) {
> +			if (ctx->is_10bit_bitstream) {
> +				pix_fmt_mp->plane_fmt[0].bytesperline =3D pix_fmt_mp->width * 5 / 4;
> +				pix_fmt_mp->plane_fmt[0].sizeimage =3D dram_y_10bit + dram_c_10bit;
> +			} else {
> +				pix_fmt_mp->plane_fmt[0].bytesperline =3D pix_fmt_mp->width;
> +				pix_fmt_mp->plane_fmt[0].sizeimage =3D dram_y + dram_c;
> +			}
> +		} else {
> +			if (ctx->is_10bit_bitstream) {
> +				pix_fmt_mp->plane_fmt[0].bytesperline =3D pix_fmt_mp->width * 5 / 4;
> +				pix_fmt_mp->plane_fmt[1].bytesperline =3D pix_fmt_mp->width * 5 / 4;
> +
> +				pix_fmt_mp->plane_fmt[0].sizeimage =3D dram_y_10bit;
> +				pix_fmt_mp->plane_fmt[1].sizeimage =3D dram_c_10bit;
> +			} else {
> +				pix_fmt_mp->plane_fmt[0].bytesperline =3D pix_fmt_mp->width;
> +				pix_fmt_mp->plane_fmt[1].bytesperline =3D pix_fmt_mp->width;
> +
> +				pix_fmt_mp->plane_fmt[0].sizeimage =3D dram_y;
> +				pix_fmt_mp->plane_fmt[1].sizeimage =3D dram_c;
> +			}
>  		}
> +
> +		mtk_v4l2_vdec_dbg(0, ctx,
> +				  "before resize:%dx%d, after resize:%dx%d, sizeimage=3D0x%x_0x%x",
> +				  tmp_w, tmp_h, pix_fmt_mp->width, pix_fmt_mp->height,
> +				  pix_fmt_mp->plane_fmt[0].sizeimage,
> +				  pix_fmt_mp->plane_fmt[1].sizeimage);
>  	}
> =20
>  	pix_fmt_mp->flags =3D 0;


