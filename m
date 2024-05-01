Return-Path: <linux-kernel+bounces-165719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6498B902C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CCE1F22CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C831635A4;
	Wed,  1 May 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="EfdMSuzA"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A610BEAF6
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592771; cv=none; b=Qgor++Kxd2alz7N3F9vvbz2DJU3ezGkor4cg1SBC7MZLo2oZNWpleYtFi4aVgADwfekrp0hylqmMYrvqGqeqx3vFDxHe+PUy8/EmDlPWwEOrFSaDJ6U+RvddlPGgmOc4bJAJWlorzxGhm/PVfn2HJ6Tyja9GmRF61Ezq3VA5O6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592771; c=relaxed/simple;
	bh=YRvtPD2w7ksQM6HUcn+zEJI7Zie3ognuLPNAsCXy+pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1wy90DtM4oPuFpYKXG9dTcWohJDivPV3sdETLV0DkDTw6qQJFJXmTOYSLS7gYHRpiXhx7dibP2xwS2x1Or+3ANpRuMeOYL/HpzpUJyxmtDNkkr8bkVnRihCQqBI+8bZg0t1JDyOQ0Vjnyod9aq2J9+5al17SWDGEmrrN3vHYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=EfdMSuzA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-790c7785ddbso336529285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1714592768; x=1715197568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p1OT6UbwxG+GczDDS2np0Qabln0s++2iuGn20geJbX0=;
        b=EfdMSuzA4jxshnuRT/QYe0fY/ypykIAZUI6p5b2E5UyDsAmBqjdHMlMq45bNVtcbEK
         GETvix1e9vokHc4M3k+gCFCYxKc2Li+CDJeSbatGHj1DEfapywiNC+UzNwJKZ8erzDSE
         Tb11dyZHgbnGPI1u5yvo+pU3cZ4MFa552enBVjpuaZdKUdCpqpOxCvUR0aIaWK/1NxIi
         7UYx9IHTvsLBpQcUm/JRxCi3W4eamA4nVdd/w/dj30hdyu0MrBz/ZuBKvcb3TcVKZzWW
         F6nzINBaF2Q/9Uj0QKxv03d2awQ4wEr6jXvwILImODEQ1WgSCHZijOLgS47rqQa8MtiT
         F+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714592768; x=1715197568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1OT6UbwxG+GczDDS2np0Qabln0s++2iuGn20geJbX0=;
        b=ncnvwIaTAojk6T4z5VQJIOLHDH1aLrPZ6C19IRSOmYjjFWrEBbQ7IO6bGwloskTlup
         9/fA4p5/h41QyQ3QLxAi4mLpGcoZ9AsLdr0HjoeO4pGWCQAisjgQQiC/5NPGJaFQeac6
         p0pK8STHKmGhZd9yOi3Z0atSzUN8SwGRdzZ8Ep8sbmdMeiEHCErvcHn+Dk8g6jObzj/o
         r87K0TSP04CXaZYsdaJAIOh1Nh/MAWeYbgeF+NbESOpwlo/PL9Jw2g0dHucRLSH1H0IP
         b9k/vq8bar8IniCaz3qETMJz/DrVp8shmPdPmEiv1of9mJUnyFDH+pY5c7kJ3qlUiVCa
         oYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9A6KxkmRVLPXP9xaMklZmaLASIAfQWR3zZ8OaqHHydQOjodhugVCXORLB46FrYOnwLvYNwIs/pt4KWeLTWPfpIg2HJdBYNLVFv1u2
X-Gm-Message-State: AOJu0YzyjbknZtJkgJkGDk+bG8SHyNKxUBHq41hojOoNAHbL5o9X9DgN
	+xXM9xIkSo3LOJvm9GHim70ElEho0Ym2h471EblGOhvsys6gKjmyEO40Ze0oKGU=
X-Google-Smtp-Source: AGHT+IEpeOxZd9v/QGfnwprLZwaaDjr+QYtP+B4WIlSnw5bbzlREEJ4EXbjcmIO+kYiEMKpCyBFPKw==
X-Received: by 2002:a05:620a:1095:b0:790:d62a:da08 with SMTP id g21-20020a05620a109500b00790d62ada08mr3690364qkk.4.1714592768520;
        Wed, 01 May 2024 12:46:08 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id s2-20020ae9f702000000b0078efd872d3csm12632740qkg.14.2024.05.01.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:46:08 -0700 (PDT)
Message-ID: <131cf8a5ac97ac800e19205c5d2b5359ac266de3.camel@ndufresne.ca>
Subject: Re: [PATCH v3 4/4] media: chips-media: wave5: Support YUV422 raw
 pixel-formats on the encoder.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Nas Chung <nas.chung@chipsnmedia.com>, mchehab@kernel.org, 
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hverkuil@xs4all.nl, lafley.kim@chipsnmedia.com, b-brnich@ti.com, 
	jackson.lee@chipnsmedia.com, "Jackson.lee" <jackson.lee@chipsnmedia.com>
Date: Wed, 01 May 2024 15:46:07 -0400
In-Reply-To: <20240430013900.187-5-nas.chung@chipsnmedia.com>
References: <20240430013900.187-1-nas.chung@chipsnmedia.com>
	 <20240430013900.187-5-nas.chung@chipsnmedia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nas,

Le mardi 30 avril 2024 =C3=A0 10:39 +0900, Nas Chung a =C3=A9crit=C2=A0:
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> Add support for the YUV422P, NV16, NV61, YUV422M, NV16M, NV61M raw pixel-=
formats to the Wave5 encoder.
> All these formats have a chroma subsampling ratio of 4:2:2 and therefore =
require a new image size calculation as the driver previously only handled =
a ratio of 4:2:0.

Same here, run check-patch, before sending your next version, it should tel=
l you
that this message is not indented properly.

>=20
> Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../chips-media/wave5/wave5-vpu-enc.c         | 59 +++++++++++++++++--
>  1 file changed, 54 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index 75d230df45f6..0d6bec4e28d1 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -66,6 +66,24 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES]=
[MAX_FMTS] =3D {
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21M,
>  			.v4l2_frmsize =3D &enc_frmsize[VPU_FMT_TYPE_RAW],
>  		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422P,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422M,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16M,
> +		},
> +		{
> +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61M,
> +		},
>  	}
>  };
> =20
> @@ -109,13 +127,30 @@ static int start_encode(struct vpu_instance *inst, =
u32 *fail_res)
>  	struct vb2_v4l2_buffer *dst_buf;
>  	struct frame_buffer frame_buf;
>  	struct enc_param pic_param;
> -	u32 stride =3D ALIGN(inst->dst_fmt.width, 32);
> -	u32 luma_size =3D (stride * inst->dst_fmt.height);
> -	u32 chroma_size =3D ((stride / 2) * (inst->dst_fmt.height / 2));
> +	u32 stride =3D inst->src_fmt.plane_fmt[0].bytesperline;
> +	u32 luma_size =3D (stride * inst->src_fmt.height);
> +	u32 chroma_size =3D 0;
> =20
>  	memset(&pic_param, 0, sizeof(struct enc_param));
>  	memset(&frame_buf, 0, sizeof(struct frame_buffer));
> =20
> +	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV420 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV420M)
> +		chroma_size =3D luma_size / 4;
> +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12 ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21 ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M)
> +		chroma_size =3D luma_size / 2;
> +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422P ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422M)
> +		chroma_size =3D luma_size / 2;
> +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16 ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61 ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16M ||
> +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61M)
> +		chroma_size =3D luma_size;
> +

I'm still unhappy to see all the supported format having to be listed again
here, this is error prone and a maintenance burden. In general, what I woul=
d do
is (and this is simplified to the subset of format we support):

// might want to bug on that the info->pixel_encoding =3D=3D V4L2_PIXEL_ENC=
_YUV
// if you believe some RGB or bayer formats could be added in the future an=
d
// want the devs to notice. I've ignored fractional bytes-per-pixel values =
as
// we don't use that, but another bugon if there is a chance the firmware=
=C2=A0
// will=C2=A0support more complex packing.

info =3D v4l2_format_info(inst->src_fmt.pixelformat);
if (info->mem_planes =3D=3D 1) {
	luma_size =3D stride * inst->dst_fmt.height;
	chroma_size =3D luma_size * info->bpp[1] / (info->hdiv * info->vdiv)
} else {
	luma_size =3D inst->src_fmt.plane_fmt[0].sizeimage;
	chroma_size =3D inst->src_fmt.plane_fmt[1].sizeimage;
}

Or something similar that works ... (untested code above)

>  	dst_buf =3D v4l2_m2m_next_dst_buf(m2m_ctx);
>  	if (!dst_buf) {
>  		dev_dbg(inst->dev->dev, "%s: No destination buffer found\n", __func__)=
;
> @@ -501,11 +536,15 @@ static int wave5_vpu_enc_s_fmt_out(struct file *fil=
e, void *fh, struct v4l2_form
>  	}
> =20
>  	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12 ||
> -	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M) {
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16M) {
>  		inst->cbcr_interleave =3D true;
>  		inst->nv21 =3D false;
>  	} else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21 ||
> -		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M) {
> +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M ||
> +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61 ||
> +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61M) {
>  		inst->cbcr_interleave =3D true;

This can be simplified to (avoiding enumerating formats):
=20
	inst->cbcr_interleave =3D (info->comp_planes =3D=3D 2) ? true : false;

>  		inst->nv21 =3D true;

Could be something to add into the info in the future, but for now this is =
list
of formats is needed. Would be a lot more efficient with a switch, but not =
a hot
path so not making this mandatory.

>  	} else {
> @@ -1102,6 +1141,16 @@ static void wave5_set_enc_openparam(struct enc_ope=
n_param *open_param,
>  	u32 num_ctu_row =3D ALIGN(inst->dst_fmt.height, 64) / 64;
>  	u32 num_mb_row =3D ALIGN(inst->dst_fmt.height, 16) / 16;
> =20
> +	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422P ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61 ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422M ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16M ||
> +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61M)
> +		open_param->src_format =3D FORMAT_422;
> +	else
> +		open_param->src_format =3D FORMAT_420;

Can be simplified to:

if (info->hdiv =3D=3D 2 && info->vdiv =3D=3D 2)
	open_param->src_format =3D FORMAT_422;
else if (info->hdiv =3D=3D 2 && info->vdiv =3D=3D 1)
	open_param->src_format =3D FORMAT_420;

> +
>  	open_param->wave_param.gop_preset_idx =3D PRESET_IDX_IPP_SINGLE;
>  	open_param->wave_param.hvs_qp_scale =3D 2;
>  	open_param->wave_param.hvs_max_delta_qp =3D 10;

regards,
Nicolas

