Return-Path: <linux-kernel+bounces-150787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128CF8AA494
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9309288201
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31FF194C72;
	Thu, 18 Apr 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="HlDpnjRT"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BEA146596
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474210; cv=none; b=tzywLChvDjprizpdg+4/qU82J5ty3n2ehh7PYM8mufAmkpmGEwXgeiavHOvLzIQJGffA9RAlRTaPiqNPs5iRI/ol5mO/g4U2XCnAjI5p/okSCX1S8elI9uMBXWo2K5KADkU+/28hHo0AYiJLammbnHXFWASlMaB+OapRjz0Mexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474210; c=relaxed/simple;
	bh=YdIrAz/KMtkUKmggYiV13of5L1nbBL76K6D4YA00Zfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6y7SsJfWS9+GZqXXJlY56QRqiHvrqJL6zq0pbamFvl2dXA3Qjysk73EMDHR0SJCW07BQljcXw9GCsFdB2qpW8vKA9WwHpv99OvIFQowByRYt5pb6Owv/0F/avg27oIa2pRFxV1foZpjdCRCbpjzrHLFiecJHqwTFIERzYDvK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=HlDpnjRT; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78f0e3b650cso57684585a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1713474207; x=1714079007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KtlV7W1EmHvf2Vuu9/vgdclf/P+L3ImtFXLrHG7s0UQ=;
        b=HlDpnjRTmeilKW7ZkgaB6M3I+toU2OlN0RJYH1/xCP1FggzVwx1XJ6zank1csOuyNz
         EfAewORHJ1aUIjxHvSnZAoYvuRiDl04qpTAfiMQxVSTK7vzd3eW1xjb2uwLpqnxIatIh
         Wot76LJmaWQIaaGRreWlH+iZbKOGUWqj7jI9ndUYwux9Jt2BRiMfSxqR1tR3Jiz0NO5v
         UWjyVCDSgSwvvUEgMzPwoPxz+gmJ/MCYU+edNTdmaOmyCVSvaM1C2EW23W6g5dr8Xtgc
         14eupNGWJdMhNZdDOL26+TxrnVG2VLWRM5OlVADZcAO7+fJzvJ0VXq+227FwiCb/kmg4
         qgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713474207; x=1714079007;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtlV7W1EmHvf2Vuu9/vgdclf/P+L3ImtFXLrHG7s0UQ=;
        b=EtF/tq6u9VYzABcBIHeLMBYY5QqGvKpVg36ITgcXxl9EtryGEn5h5yF1o4memdl7n0
         5U8V8L7Gx0QUxaAVc/q2iqcsGEZpYTX6yohDhX30UA01WL4uhxQbeT3d8yhLAhfFC2h3
         6YQmrPDfUWsUR9WEmcBOqbVi/w669unsdk7aa0pPSEcRaDrBDdAc/QoCgVubCkfkwjoU
         IxytiVmXroJqh6/Yh7K2Z70YKFKPWO7JfE/Fnfp5L4bgdazpR3tZaE7zXtA6w3CEWYtX
         gb5grvi1pFFvXforJhfr3hJ+Aii6Cvrlv7kCoMemTBmr9GKGHKtIGyzAcAL21EUPvrLl
         PjEA==
X-Forwarded-Encrypted: i=1; AJvYcCV+sdo7fiROA0+9FJ6AXszcse4T7PJt/g9Cb5ZeXv5/IzF/YgJKLgatwMBRBYWxmFQZh59coKEhSZEpKUC0kGfyUQuXUmL5yzyIcCoj
X-Gm-Message-State: AOJu0YyrUWmDaWS3A5HuHVdWGagbfIYzWlK8EEzJhhSdFu68D9F0StXG
	p/V/+okHaJOPmjlq6tYHkA+oDQ3m/Gq+gzzkz3GYzaJMz6nBWiJEL8nE7DUfcao=
X-Google-Smtp-Source: AGHT+IGVyBqNKj/J0dsOq9biCC2WQ7FEzIwhDruKumBxfoSvWG0NMlBlAoTLjABduWqwj4zIUSyhyw==
X-Received: by 2002:a05:620a:1186:b0:78f:1226:94c7 with SMTP id b6-20020a05620a118600b0078f122694c7mr226847qkk.56.1713474206463;
        Thu, 18 Apr 2024 14:03:26 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id qp8-20020a05620a388800b0078f13e59dc9sm509293qkn.102.2024.04.18.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:03:26 -0700 (PDT)
Message-ID: <7a2c4cda3c8719230c241e27f1e1cca024d02e69.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v2 3/4] media: chips-media: wave5: Use helpers to
 calculate bytesperline and sizeimage.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hverkuil@xs4all.nl, nas.chung@chipsnmedia.com, lafley.kim@chipsnmedia.com, 
	b-brnich@ti.com
Date: Thu, 18 Apr 2024 17:03:25 -0400
In-Reply-To: <20240311105623.20406-4-jackson.lee@chipsnmedia.com>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-4-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
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

very nice cleanup.

Le lundi 11 mars 2024 =C3=A0 19:56 +0900, jackson.lee a =C3=A9crit=C2=A0:
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> Use v4l2-common helper functions to calculate bytesperline and sizeimage,=
 instead of calculating in a wave5 driver directly.
> In case of raw(YUV) v4l2_pix_format, the wave5 driver updates v4l2_pix_fo=
rmat_mplane struct through v4l2_fill_pixfmt_mp() function.
> Encoder and Decoder need same bytesperline and sizeimage values for same =
v4l2_pix_format.
> So, a wave5_update_pix_fmt is refactored to support both together.
>=20
> Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../platform/chips-media/wave5/wave5-helper.c |  24 ++
>  .../platform/chips-media/wave5/wave5-helper.h |   4 +
>  .../chips-media/wave5/wave5-vpu-dec.c         | 245 ++++--------------
>  .../chips-media/wave5/wave5-vpu-enc.c         | 179 +++++--------
>  .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
>  .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
>  6 files changed, 164 insertions(+), 317 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-helper.c
> index 8433ecab230c..53cad4d17aa7 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> @@ -7,6 +7,8 @@
> =20
>  #include "wave5-helper.h"
> =20
> +#define DEFAULT_BS_SIZE(width, height) ((width) * (height) / 8 * 3)
> +
>  const char *state_to_str(enum vpu_instance_state state)
>  {
>  	switch (state) {
> @@ -211,3 +213,25 @@ void wave5_return_bufs(struct vb2_queue *q, u32 stat=
e)
>  		v4l2_m2m_buf_done(vbuf, state);
>  	}
>  }
> +
> +void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp,
> +			  unsigned int width,
> +			  unsigned int height,
> +			  const struct v4l2_frmsize_stepwise frmsize)
> +{
> +	v4l2_apply_frmsize_constraints(&width, &height, &frmsize);
> +
> +	if (pix_mp->pixelformat =3D=3D V4L2_PIX_FMT_HEVC ||
> +	    pix_mp->pixelformat =3D=3D V4L2_PIX_FMT_H264) {

I notice the caller already index the frmsize between RAW and CODEC. I'd sa=
y
pass the information as an argument so we don't have to update code later w=
hen
more codecs are added.

> +		pix_mp->width =3D width;
> +		pix_mp->height =3D height;
> +		pix_mp->num_planes =3D 1;
> +		pix_mp->plane_fmt[0].bytesperline =3D 0;
> +		pix_mp->plane_fmt[0].sizeimage =3D max(DEFAULT_BS_SIZE(width, height),
> +						     pix_mp->plane_fmt[0].sizeimage);
> +	} else {
> +		v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat, width, height);
> +	}
> +	pix_mp->flags =3D 0;
> +	pix_mp->field =3D V4L2_FIELD_NONE;
> +}
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.h b/dr=
ivers/media/platform/chips-media/wave5/wave5-helper.h
> index 6cee1c14d3ce..a8ecd1920207 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-helper.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-helper.h
> @@ -28,4 +28,8 @@ const struct vpu_format *wave5_find_vpu_fmt_by_idx(unsi=
gned int idx,
>  						   const struct vpu_format fmt_list[MAX_FMTS]);
>  enum wave_std wave5_to_vpu_std(unsigned int v4l2_pix_fmt, enum vpu_insta=
nce_type type);
>  void wave5_return_bufs(struct vb2_queue *q, u32 state);
> +void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp,
> +			  unsigned int width,
> +			  unsigned int height,
> +			  const struct v4l2_frmsize_stepwise frmsize);
>  #endif
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index a199877c643b..43d0a21193dd 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -11,115 +11,74 @@
>  #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
>  #define VPU_DEC_DRV_NAME "wave5-dec"
> =20
> -#define DEFAULT_SRC_SIZE(width, height) ({			\
> -	(width) * (height) / 8 * 3;					\
> -})
> -
>  static const struct vpu_format dec_fmt_list[FMT_TYPES][MAX_FMTS] =3D {
>  	[VPU_FMT_TYPE_CODEC] =3D {
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_HEVC,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_H264,
> -			.max_width =3D 8192,
> -			.min_width =3D 32,
> -			.max_height =3D 4320,
> -			.min_height =3D 32,
>  		},

I notice that min/max was different per codec, but in this patch you actual=
ly
make them both identical. Is that an error, otherwise the change should be
underlined in the commit message.

If you really need per codec granularity, you could define the common frmsi=
ze
array before, and set a pointer here into the static array. This way you wo=
n't
have to type the same thing over and over, but still have per codec granula=
rity.

>  	},
>  	[VPU_FMT_TYPE_RAW] =3D {
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV420,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV12,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422P,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV420M,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV12M,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21M,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422M,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16M,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61M,
> -			.max_width =3D 8192,
> -			.min_width =3D 8,
> -			.max_height =3D 4320,
> -			.min_height =3D 8,
>  		},
>  	}
>  };
> =20
> +static const struct v4l2_frmsize_stepwise dec_frmsize[FMT_TYPES] =3D {
> +	[VPU_FMT_TYPE_CODEC] =3D {
> +		.min_width =3D W5_MIN_DEC_PIC_WIDTH,
> +		.max_width =3D W5_MAX_DEC_PIC_WIDTH,
> +		.step_width =3D W5_DEC_CODEC_STEP_WIDTH,
> +		.min_height =3D W5_MIN_DEC_PIC_HEIGHT,
> +		.max_height =3D W5_MAX_DEC_PIC_HEIGHT,
> +		.step_height =3D W5_DEC_CODEC_STEP_HEIGHT,
> +	},
> +	[VPU_FMT_TYPE_RAW] =3D {
> +		.min_width =3D W5_MIN_DEC_PIC_WIDTH,
> +		.max_width =3D W5_MAX_DEC_PIC_WIDTH,
> +		.step_width =3D W5_DEC_RAW_STEP_WIDTH,
> +		.min_height =3D W5_MIN_DEC_PIC_HEIGHT,
> +		.max_height =3D W5_MAX_DEC_PIC_HEIGHT,
> +		.step_height =3D W5_DEC_RAW_STEP_HEIGHT,
> +	},
> +};
> +
>  /*
>   * Make sure that the state switch is allowed and add logging for debugg=
ing
>   * purposes
> @@ -234,74 +193,6 @@ static void wave5_handle_src_buffer(struct vpu_insta=
nce *inst, dma_addr_t rd_ptr
>  	inst->remaining_consumed_bytes =3D consumed_bytes;
>  }
> =20
> -static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, =
unsigned int width,
> -				 unsigned int height)
> -{
> -	switch (pix_mp->pixelformat) {
> -	case V4L2_PIX_FMT_YUV420:
> -	case V4L2_PIX_FMT_NV12:
> -	case V4L2_PIX_FMT_NV21:
> -		pix_mp->width =3D round_up(width, 32);
> -		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height * 3 / 2;
> -		break;
> -	case V4L2_PIX_FMT_YUV422P:
> -	case V4L2_PIX_FMT_NV16:
> -	case V4L2_PIX_FMT_NV61:
> -		pix_mp->width =3D round_up(width, 32);
> -		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height * 2;
> -		break;
> -	case V4L2_PIX_FMT_YUV420M:
> -		pix_mp->width =3D round_up(width, 32);
> -		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height / 4;
> -		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[2].sizeimage =3D width * height / 4;
> -		break;
> -	case V4L2_PIX_FMT_NV12M:
> -	case V4L2_PIX_FMT_NV21M:
> -		pix_mp->width =3D round_up(width, 32);
> -		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height / 2;
> -		break;
> -	case V4L2_PIX_FMT_YUV422M:
> -		pix_mp->width =3D round_up(width, 32);
> -		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height / 2;
> -		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[2].sizeimage =3D width * height / 2;
> -		break;
> -	case V4L2_PIX_FMT_NV16M:
> -	case V4L2_PIX_FMT_NV61M:
> -		pix_mp->width =3D round_up(width, 32);
> -		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height;
> -		break;
> -	default:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D 0;
> -		pix_mp->plane_fmt[0].sizeimage =3D max(DEFAULT_SRC_SIZE(width, height)=
,
> -						     pix_mp->plane_fmt[0].sizeimage);
> -		break;
> -	}
> -}
> -
>  static int start_decode(struct vpu_instance *inst, u32 *fail_res)
>  {
>  	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
> @@ -397,9 +288,11 @@ static int handle_dynamic_resolution_change(struct v=
pu_instance *inst)
>  			initial_info->pic_crop_rect.top - initial_info->pic_crop_rect.bottom;
> =20
>  		wave5_update_pix_fmt(&inst->src_fmt, initial_info->pic_width,
> -				     initial_info->pic_height);
> +						     initial_info->pic_height,
> +						     dec_frmsize[VPU_FMT_TYPE_CODEC]);
>  		wave5_update_pix_fmt(&inst->dst_fmt, initial_info->pic_width,
> -				     initial_info->pic_height);
> +						     initial_info->pic_height,
> +						     dec_frmsize[VPU_FMT_TYPE_RAW]);
>  	}
> =20
>  	v4l2_event_queue_fh(fh, &vpu_event_src_ch);
> @@ -548,12 +441,7 @@ static int wave5_vpu_dec_enum_framesizes(struct file=
 *f, void *fh, struct v4l2_f
>  	}
> =20
>  	fsize->type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;
> -	fsize->stepwise.min_width =3D vpu_fmt->min_width;
> -	fsize->stepwise.max_width =3D vpu_fmt->max_width;
> -	fsize->stepwise.step_width =3D 1;
> -	fsize->stepwise.min_height =3D vpu_fmt->min_height;
> -	fsize->stepwise.max_height =3D vpu_fmt->max_height;
> -	fsize->stepwise.step_height =3D 1;
> +	fsize->stepwise =3D dec_frmsize[VPU_FMT_TYPE_CODEC];
> =20
>  	return 0;
>  }
> @@ -589,14 +477,10 @@ static int wave5_vpu_dec_try_fmt_cap(struct file *f=
ile, void *fh, struct v4l2_fo
>  		width =3D inst->dst_fmt.width;
>  		height =3D inst->dst_fmt.height;
>  		f->fmt.pix_mp.pixelformat =3D inst->dst_fmt.pixelformat;
> -		f->fmt.pix_mp.num_planes =3D inst->dst_fmt.num_planes;
>  	} else {
> -		const struct v4l2_format_info *info =3D v4l2_format_info(vpu_fmt->v4l2=
_pix_fmt);
> -
> -		width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_=
width);
> -		height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->m=
ax_height);
> +		width =3D f->fmt.pix_mp.width;
> +		height =3D f->fmt.pix_mp.height;
>  		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> -		f->fmt.pix_mp.num_planes =3D info->mem_planes;
>  	}
> =20
>  	if (p_dec_info->initial_info_obtained) {
> @@ -604,9 +488,9 @@ static int wave5_vpu_dec_try_fmt_cap(struct file *fil=
e, void *fh, struct v4l2_fo
>  		height =3D inst->dst_fmt.height;
>  	}
> =20
> -	wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
> -	f->fmt.pix_mp.flags =3D 0;
> -	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	wave5_update_pix_fmt(&f->fmt.pix_mp, width,
> +					     height,
> +					     dec_frmsize[VPU_FMT_TYPE_RAW]);
>  	f->fmt.pix_mp.colorspace =3D inst->colorspace;
>  	f->fmt.pix_mp.ycbcr_enc =3D inst->ycbcr_enc;
>  	f->fmt.pix_mp.quantization =3D inst->quantization;
> @@ -719,6 +603,7 @@ static int wave5_vpu_dec_try_fmt_out(struct file *fil=
e, void *fh, struct v4l2_fo
>  {
>  	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
>  	const struct vpu_format *vpu_fmt;
> +	int width, height;
> =20
>  	dev_dbg(inst->dev->dev,
>  		"%s: fourcc: %u width: %u height: %u num_planes: %u colorspace: %u fie=
ld: %u\n",
> @@ -727,20 +612,18 @@ static int wave5_vpu_dec_try_fmt_out(struct file *f=
ile, void *fh, struct v4l2_fo
> =20
>  	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, dec_fmt_list[=
VPU_FMT_TYPE_CODEC]);
>  	if (!vpu_fmt) {
> +		width =3D inst->src_fmt.width;
> +		height =3D inst->src_fmt.height;
>  		f->fmt.pix_mp.pixelformat =3D inst->src_fmt.pixelformat;
> -		f->fmt.pix_mp.num_planes =3D inst->src_fmt.num_planes;
> -		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fm=
t.height);
>  	} else {
> -		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->=
max_width);
> -		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fm=
t->max_height);
> -
> +		width =3D f->fmt.pix_mp.width;
> +		height =3D f->fmt.pix_mp.height;
>  		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> -		f->fmt.pix_mp.num_planes =3D 1;
> -		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>  	}
> =20
> -	f->fmt.pix_mp.flags =3D 0;
> -	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	wave5_update_pix_fmt(&f->fmt.pix_mp, width,
> +					     height,
> +					     dec_frmsize[VPU_FMT_TYPE_CODEC]);
> =20
>  	return 0;
>  }
> @@ -782,7 +665,9 @@ static int wave5_vpu_dec_s_fmt_out(struct file *file,=
 void *fh, struct v4l2_form
>  	inst->quantization =3D f->fmt.pix_mp.quantization;
>  	inst->xfer_func =3D f->fmt.pix_mp.xfer_func;
> =20
> -	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp=
height);
> +	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width,
> +					     f->fmt.pix_mp.height,
> +					     dec_frmsize[VPU_FMT_TYPE_RAW]);
> =20
>  	return 0;
>  }
> @@ -1005,6 +890,7 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queu=
e *q, unsigned int *num_buff
>  	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
>  	struct v4l2_pix_format_mplane inst_format =3D
>  		(q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : i=
nst->dst_fmt;
> +	unsigned int i;
> =20
>  	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %=
u\n", __func__,
>  		*num_buffers, *num_planes, q->type);
> @@ -1018,31 +904,9 @@ static int wave5_vpu_dec_queue_setup(struct vb2_que=
ue *q, unsigned int *num_buff
>  		if (*num_buffers < inst->fbc_buf_count)
>  			*num_buffers =3D inst->fbc_buf_count;
> =20
> -		if (*num_planes =3D=3D 1) {
> -			if (inst->output_format =3D=3D FORMAT_422)
> -				sizes[0] =3D inst_format.width * inst_format.height * 2;
> -			else
> -				sizes[0] =3D inst_format.width * inst_format.height * 3 / 2;
> -			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> -		} else if (*num_planes =3D=3D 2) {
> -			sizes[0] =3D inst_format.width * inst_format.height;
> -			if (inst->output_format =3D=3D FORMAT_422)
> -				sizes[1] =3D inst_format.width * inst_format.height;
> -			else
> -				sizes[1] =3D inst_format.width * inst_format.height / 2;
> -			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
> -				__func__, sizes[0], sizes[1]);
> -		} else if (*num_planes =3D=3D 3) {
> -			sizes[0] =3D inst_format.width * inst_format.height;
> -			if (inst->output_format =3D=3D FORMAT_422) {
> -				sizes[1] =3D inst_format.width * inst_format.height / 2;
> -				sizes[2] =3D inst_format.width * inst_format.height / 2;
> -			} else {
> -				sizes[1] =3D inst_format.width * inst_format.height / 4;
> -				sizes[2] =3D inst_format.width * inst_format.height / 4;
> -			}
> -			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\=
n",
> -				__func__, sizes[0], sizes[1], sizes[2]);
> +		for (i =3D 0; i < *num_planes; i++) {
> +			sizes[i] =3D inst_format.plane_fmt[i].sizeimage;
> +			dev_dbg(inst->dev->dev, "%s: size[%u]: %u\n", __func__, i, sizes[i]);
>  		}
>  	}
> =20
> @@ -1564,20 +1428,15 @@ static const struct vb2_ops wave5_vpu_dec_vb2_ops=
 =3D {
>  static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_=
fmt,
>  				     struct v4l2_pix_format_mplane *dst_fmt)
>  {
> -	unsigned int dst_pix_fmt =3D dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix=
_fmt;
> -	const struct v4l2_format_info *dst_fmt_info =3D v4l2_format_info(dst_pi=
x_fmt);
> -
>  	src_fmt->pixelformat =3D dec_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_f=
mt;
> -	src_fmt->field =3D V4L2_FIELD_NONE;
> -	src_fmt->flags =3D 0;
> -	src_fmt->num_planes =3D 1;
> -	wave5_update_pix_fmt(src_fmt, 720, 480);
> -
> -	dst_fmt->pixelformat =3D dst_pix_fmt;
> -	dst_fmt->field =3D V4L2_FIELD_NONE;
> -	dst_fmt->flags =3D 0;
> -	dst_fmt->num_planes =3D dst_fmt_info->mem_planes;
> -	wave5_update_pix_fmt(dst_fmt, 736, 480);
> +	wave5_update_pix_fmt(src_fmt, W5_DEF_DEC_PIC_WIDTH,
> +				      W5_DEF_DEC_PIC_HEIGHT,
> +				      dec_frmsize[VPU_FMT_TYPE_CODEC]);
> +
> +	dst_fmt->pixelformat =3D dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt=
;
> +	wave5_update_pix_fmt(dst_fmt, W5_DEF_DEC_PIC_WIDTH,
> +				      W5_DEF_DEC_PIC_HEIGHT,
> +				      dec_frmsize[VPU_FMT_TYPE_RAW]);
>  }
> =20
>  static int wave5_vpu_dec_queue_init(void *priv, struct vb2_queue *src_vq=
, struct vb2_queue *dst_vq)
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index 013e2bb37fbb..5a32bb138158 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -15,65 +15,52 @@ static const struct vpu_format enc_fmt_list[FMT_TYPES=
][MAX_FMTS] =3D {
>  	[VPU_FMT_TYPE_CODEC] =3D {
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_HEVC,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_H264,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  	},
>  	[VPU_FMT_TYPE_RAW] =3D {
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV420,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV12,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV420M,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV12M,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  		{
>  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21M,
> -			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> -			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> -			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> -			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
>  		},
>  	}
>  };
> =20
> +static const struct v4l2_frmsize_stepwise enc_frmsize[FMT_TYPES] =3D {
> +	[VPU_FMT_TYPE_CODEC] =3D {
> +		.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +		.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +		.step_width =3D W5_ENC_CODEC_STEP_WIDTH,
> +		.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +		.step_height =3D W5_ENC_CODEC_STEP_HEIGHT,
> +	},
> +	[VPU_FMT_TYPE_RAW] =3D {
> +		.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> +		.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> +		.step_width =3D W5_ENC_RAW_STEP_WIDTH,
> +		.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> +		.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> +		.step_height =3D W5_ENC_RAW_STEP_HEIGHT,
> +	},
> +};
> +
>  static int switch_state(struct vpu_instance *inst, enum vpu_instance_sta=
te state)
>  {
>  	switch (state) {
> @@ -106,46 +93,6 @@ static int switch_state(struct vpu_instance *inst, en=
um vpu_instance_state state
>  	return -EINVAL;
>  }
> =20
> -static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, =
unsigned int width,
> -				 unsigned int height)
> -{
> -	switch (pix_mp->pixelformat) {
> -	case V4L2_PIX_FMT_YUV420:
> -	case V4L2_PIX_FMT_NV12:
> -	case V4L2_PIX_FMT_NV21:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height * 3 / =
2;
> -		break;
> -	case V4L2_PIX_FMT_YUV420M:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 4;
> -		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[2].sizeimage =3D round_up(width, 32) * height / 4;
> -		break;
> -	case V4L2_PIX_FMT_NV12M:
> -	case V4L2_PIX_FMT_NV21M:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 2;
> -		break;
> -	default:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D 0;
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height / 8 * 3;
> -		break;
> -	}
> -}
> -
>  static int start_encode(struct vpu_instance *inst, u32 *fail_res)
>  {
>  	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
> @@ -360,13 +307,8 @@ static int wave5_vpu_enc_enum_framesizes(struct file=
 *f, void *fh, struct v4l2_f
>  			return -EINVAL;
>  	}
> =20
> -	fsize->type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;
> -	fsize->stepwise.min_width =3D vpu_fmt->min_width;
> -	fsize->stepwise.max_width =3D vpu_fmt->max_width;
> -	fsize->stepwise.step_width =3D 1;
> -	fsize->stepwise.min_height =3D vpu_fmt->min_height;
> -	fsize->stepwise.max_height =3D vpu_fmt->max_height;
> -	fsize->stepwise.step_height =3D 1;
> +	fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> +	fsize->stepwise =3D enc_frmsize[VPU_FMT_TYPE_CODEC];
> =20
>  	return 0;
>  }
> @@ -392,6 +334,7 @@ static int wave5_vpu_enc_try_fmt_cap(struct file *fil=
e, void *fh, struct v4l2_fo
>  {
>  	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
>  	const struct vpu_format *vpu_fmt;
> +	int width, height;
> =20
>  	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_planes=
: %u field: %u\n",
>  		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_m=
p.height,
> @@ -399,20 +342,18 @@ static int wave5_vpu_enc_try_fmt_cap(struct file *f=
ile, void *fh, struct v4l2_fo
> =20
>  	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_list[=
VPU_FMT_TYPE_CODEC]);
>  	if (!vpu_fmt) {
> +		width =3D inst->dst_fmt.width;
> +		height =3D inst->dst_fmt.height;
>  		f->fmt.pix_mp.pixelformat =3D inst->dst_fmt.pixelformat;
> -		f->fmt.pix_mp.num_planes =3D inst->dst_fmt.num_planes;
> -		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_fm=
t.height);
>  	} else {
> -		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->=
max_width);
> -		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fm=
t->max_height);
> -
> +		width =3D f->fmt.pix_mp.width;
> +		height =3D f->fmt.pix_mp.height;
>  		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> -		f->fmt.pix_mp.num_planes =3D 1;
> -		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>  	}
> =20
> -	f->fmt.pix_mp.flags =3D 0;
> -	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	wave5_update_pix_fmt(&f->fmt.pix_mp, width,
> +					     height,
> +					     enc_frmsize[VPU_FMT_TYPE_CODEC]);
>  	f->fmt.pix_mp.colorspace =3D inst->colorspace;
>  	f->fmt.pix_mp.ycbcr_enc =3D inst->ycbcr_enc;
>  	f->fmt.pix_mp.quantization =3D inst->quantization;
> @@ -500,6 +441,7 @@ static int wave5_vpu_enc_try_fmt_out(struct file *fil=
e, void *fh, struct v4l2_fo
>  {
>  	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
>  	const struct vpu_format *vpu_fmt;
> +	int width, height;
> =20
>  	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_planes=
: %u field: %u\n",
>  		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_m=
p.height,
> @@ -507,21 +449,18 @@ static int wave5_vpu_enc_try_fmt_out(struct file *f=
ile, void *fh, struct v4l2_fo
> =20
>  	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_list[=
VPU_FMT_TYPE_RAW]);
>  	if (!vpu_fmt) {
> +		width =3D inst->src_fmt.width;
> +		height =3D inst->src_fmt.height;
>  		f->fmt.pix_mp.pixelformat =3D inst->src_fmt.pixelformat;
> -		f->fmt.pix_mp.num_planes =3D inst->src_fmt.num_planes;
> -		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fm=
t.height);
>  	} else {
> -		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->=
max_width);
> -		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fm=
t->max_height);
> -		const struct v4l2_format_info *info =3D v4l2_format_info(vpu_fmt->v4l2=
_pix_fmt);
> -
> +		width =3D f->fmt.pix_mp.width;
> +		height =3D f->fmt.pix_mp.height;
>  		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> -		f->fmt.pix_mp.num_planes =3D info->mem_planes;
> -		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
>  	}
> =20
> -	f->fmt.pix_mp.flags =3D 0;
> -	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	wave5_update_pix_fmt(&f->fmt.pix_mp, width,
> +					     height,
> +					     enc_frmsize[VPU_FMT_TYPE_RAW]);
> =20
>  	return 0;
>  }
> @@ -568,7 +507,11 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file=
, void *fh, struct v4l2_form
>  	inst->quantization =3D f->fmt.pix_mp.quantization;
>  	inst->xfer_func =3D f->fmt.pix_mp.xfer_func;
> =20
> -	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp=
height);
> +	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width,
> +					     f->fmt.pix_mp.height,
> +					     enc_frmsize[VPU_FMT_TYPE_CODEC]);
> +	inst->conf_win.width =3D inst->dst_fmt.width;
> +	inst->conf_win.height =3D inst->dst_fmt.height;
> =20
>  	return 0;
>  }
> @@ -584,12 +527,17 @@ static int wave5_vpu_enc_g_selection(struct file *f=
ile, void *fh, struct v4l2_se
>  	switch (s->target) {
>  	case V4L2_SEL_TGT_CROP_DEFAULT:
>  	case V4L2_SEL_TGT_CROP_BOUNDS:
> -	case V4L2_SEL_TGT_CROP:
>  		s->r.left =3D 0;
>  		s->r.top =3D 0;
>  		s->r.width =3D inst->dst_fmt.width;
>  		s->r.height =3D inst->dst_fmt.height;
>  		break;
> +	case V4L2_SEL_TGT_CROP:
> +		s->r.left =3D 0;
> +		s->r.top =3D 0;
> +		s->r.width =3D inst->conf_win.width;
> +		s->r.height =3D inst->conf_win.height;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -612,8 +560,10 @@ static int wave5_vpu_enc_s_selection(struct file *fi=
le, void *fh, struct v4l2_se
> =20
>  	s->r.left =3D 0;
>  	s->r.top =3D 0;
> -	s->r.width =3D inst->src_fmt.width;
> -	s->r.height =3D inst->src_fmt.height;
> +	s->r.width =3D min(s->r.width, inst->dst_fmt.width);
> +	s->r.height =3D min(s->r.height, inst->dst_fmt.height);
> +
> +	inst->conf_win =3D s->r;
> =20
>  	return 0;
>  }
> @@ -1151,8 +1101,8 @@ static void wave5_set_enc_openparam(struct enc_open=
_param *open_param,
>  	open_param->wave_param.lambda_scaling_enable =3D 1;
> =20
>  	open_param->line_buf_int_en =3D true;
> -	open_param->pic_width =3D inst->dst_fmt.width;
> -	open_param->pic_height =3D inst->dst_fmt.height;
> +	open_param->pic_width =3D inst->conf_win.width;
> +	open_param->pic_height =3D inst->conf_win.height;
>  	open_param->frame_rate_info =3D inst->frame_rate;
>  	open_param->rc_enable =3D inst->rc_enable;
>  	if (inst->rc_enable) {
> @@ -1456,20 +1406,15 @@ static const struct vb2_ops wave5_vpu_enc_vb2_ops=
 =3D {
>  static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_=
fmt,
>  				     struct v4l2_pix_format_mplane *dst_fmt)
>  {
> -	unsigned int src_pix_fmt =3D enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix=
_fmt;
> -	const struct v4l2_format_info *src_fmt_info =3D v4l2_format_info(src_pi=
x_fmt);
> -
> -	src_fmt->pixelformat =3D src_pix_fmt;
> -	src_fmt->field =3D V4L2_FIELD_NONE;
> -	src_fmt->flags =3D 0;
> -	src_fmt->num_planes =3D src_fmt_info->mem_planes;
> -	wave5_update_pix_fmt(src_fmt, 416, 240);
> +	src_fmt->pixelformat =3D enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt=
;
> +	wave5_update_pix_fmt(src_fmt, W5_DEF_ENC_PIC_WIDTH,
> +				      W5_DEF_ENC_PIC_HEIGHT,
> +				      enc_frmsize[VPU_FMT_TYPE_RAW]);
> =20
>  	dst_fmt->pixelformat =3D enc_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_f=
mt;
> -	dst_fmt->field =3D V4L2_FIELD_NONE;
> -	dst_fmt->flags =3D 0;
> -	dst_fmt->num_planes =3D 1;
> -	wave5_update_pix_fmt(dst_fmt, 416, 240);
> +	wave5_update_pix_fmt(dst_fmt, W5_DEF_ENC_PIC_WIDTH,
> +				      W5_DEF_ENC_PIC_HEIGHT,
> +				      enc_frmsize[VPU_FMT_TYPE_CODEC]);
>  }
> =20
>  static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *src_vq=
, struct vb2_queue *dst_vq)
> @@ -1734,6 +1679,8 @@ static int wave5_vpu_open_enc(struct file *filp)
>  	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
> =20
>  	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
> +	inst->conf_win.width =3D inst->dst_fmt.width;
> +	inst->conf_win.height =3D inst->dst_fmt.height;
>  	inst->colorspace =3D V4L2_COLORSPACE_REC709;
>  	inst->ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
>  	inst->quantization =3D V4L2_QUANTIZATION_DEFAULT;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.h b/drive=
rs/media/platform/chips-media/wave5/wave5-vpu.h
> index 32b7fd3730b5..691d6341fcda 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.h
> @@ -38,10 +38,6 @@ enum vpu_fmt_type {
> =20
>  struct vpu_format {
>  	unsigned int v4l2_pix_fmt;
> -	unsigned int max_width;
> -	unsigned int min_width;
> -	unsigned int max_height;
> -	unsigned int min_height;
>  };
> =20
>  static inline struct vpu_instance *wave5_to_vpu_inst(struct v4l2_fh *vfh=
)
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b=
/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> index d9751eedb0f9..e6a34ae7084e 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> @@ -30,10 +30,27 @@
> =20
>  #define MAX_NUM_INSTANCE                32
> =20
> -#define W5_MIN_ENC_PIC_WIDTH            256
> -#define W5_MIN_ENC_PIC_HEIGHT           128
> -#define W5_MAX_ENC_PIC_WIDTH            8192
> -#define W5_MAX_ENC_PIC_HEIGHT           8192
> +#define W5_DEF_DEC_PIC_WIDTH            720U
> +#define W5_DEF_DEC_PIC_HEIGHT           480U
> +#define W5_MIN_DEC_PIC_WIDTH            32U
> +#define W5_MIN_DEC_PIC_HEIGHT           32U
> +#define W5_MAX_DEC_PIC_WIDTH            8192U
> +#define W5_MAX_DEC_PIC_HEIGHT           4320U
> +#define W5_DEC_CODEC_STEP_WIDTH         1U
> +#define W5_DEC_CODEC_STEP_HEIGHT        1U
> +#define W5_DEC_RAW_STEP_WIDTH           32U
> +#define W5_DEC_RAW_STEP_HEIGHT          16U
> +
> +#define W5_DEF_ENC_PIC_WIDTH            416U
> +#define W5_DEF_ENC_PIC_HEIGHT           240U
> +#define W5_MIN_ENC_PIC_WIDTH            256U
> +#define W5_MIN_ENC_PIC_HEIGHT           128U
> +#define W5_MAX_ENC_PIC_WIDTH            8192U
> +#define W5_MAX_ENC_PIC_HEIGHT           8192U
> +#define W5_ENC_CODEC_STEP_WIDTH         8U
> +#define W5_ENC_CODEC_STEP_HEIGHT        8U
> +#define W5_ENC_RAW_STEP_WIDTH           32U
> +#define W5_ENC_RAW_STEP_HEIGHT          16U
> =20
>  //  application specific configuration
>  #define VPU_ENC_TIMEOUT                 60000


I'll have to give this one a second pass on next revision, but nice work.

Nicolas


