Return-Path: <linux-kernel+bounces-56910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DA384D138
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1431C2207C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5A21E4AB;
	Wed,  7 Feb 2024 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="wkL728VJ"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199F1D54A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330723; cv=none; b=iO1QfyCks9qHqXoPodu1MnTbRLCzUtUjfM74pNUqGSXjdHFON7Q/zbRHnhAIv6ZwtWrRXrdOTStwx3Ws/P9zQSjJs3yPge1QMwgk7nQDqMIonbbKCW72vTpfcRa2VPI2f+5bXLH6ESTrJ+ovcrDnSQzu0o62sLpJ3IqJ9i2XGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330723; c=relaxed/simple;
	bh=ugjzdpdqWvk/XRxaXitZV7UeF73SOnU4F9tATJvn5jY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwROD/XwNUhoEoTNKvewcDYkWOiwr4M0r7nXHttNEBE/xz9FRwGqdT+ulCdIdlLSrkOEPsKyf9+m/Odn9bxoSqa9nG3euoWLATLrlvhKgWQVP3pwRdGsi3cgviAtfcS/jnfJwc5iR8WSNaGXKtp9K3lx2Va620VdHsbgXLqyHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=wkL728VJ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7857bbfb25bso55824785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707330720; x=1707935520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xiZrfaXoDns80FS5vZuJhwtMeBB/GDE4Y1RJbKsgQl8=;
        b=wkL728VJlEXgmrBfCXhKYNRMAv18MD/Bg/Kv5U8wDEP+kBptmVpZEjVIyUdf0mjaAz
         FFUjXpOl5bDYx7ji1nngmq/DVE9lqzZQrxUt8EQkaWQJVrGMxI1rFlf0Uf57tYZyhj3u
         ktj+9GHriGFUmloDsNUDW8E3BxBsQciQNMsF2C9MwLSrSj88cxH2D11XhPqp5z9y2XDe
         2ebv44PYkbwKNeG11EWxXtyVSrwvWnCy+c/Dw49v1K728pbuBotBqgSGyW8fRQi0Mz3O
         t4t8Yq48jCjK+r0pWJ17Ptl7gON7vUdVMBu9ctGxAyU/iQequiEYKOEbo4eGhr8g704h
         1Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330720; x=1707935520;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiZrfaXoDns80FS5vZuJhwtMeBB/GDE4Y1RJbKsgQl8=;
        b=NtVhFXNzaBRbuM1opM3j7U93jSHn9Cx9Pw1s7mL4eA4Mv68dJkreiVu6LRmHqZ7mOP
         pBmxpSoETaj/1ryTNoVXAbPfgjGZGFPmZKQ4oG2yMbFZKoQ0rrkbtOYFxBsYmVyaREqz
         HS2Yn4DFnBu/gAoZMO3Ah2DBa6vSut9efH5k1zVSybdGSg8wvE6mFFGPfxyFxOGH8Q9P
         4B+/JOaWbWxvdxOjsN5ehjkJtot2SKrOd384pUTWUasdCJZGQgmZnztxjNJ1fXh+sUsP
         hpFxhrZZD3n+aZlj26SXZQtoQn16IWHJ73Suf/stg0OfMTakvQ5clm2ThMtampt1i8TA
         /4kA==
X-Gm-Message-State: AOJu0YxeH2llTHVeGgwLr4lNaxnpEwzRrlTH7OO5G+sw9F3US3wxWl0n
	AtRkXXzDA5ZHV8VUt387ImB4/bwK4w5o9O9670z2DtaXrhMh2R8QvfcDlIQhbTk=
X-Google-Smtp-Source: AGHT+IE4cdzI6omn160Zh4nV7jizWSOo2Fx3aXlHEQYAwxbiHHWHVJaanYJSvPSUNU1bQTZPH0wnBA==
X-Received: by 2002:a05:620a:3914:b0:783:de24:f315 with SMTP id qr20-20020a05620a391400b00783de24f315mr7621646qkn.58.1707330720559;
        Wed, 07 Feb 2024 10:32:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiUFVIgBA0PGPxbkkrzGPB4hqJv029fW7V7vQgXHAHWrm9BxX9Oh2wysHQZn9caufV/0iPprLUHlAfkUbg5ZT6QAdp+W7h/4hJ8l1hHxp0hM83IM0OoKHnJEQwTVBVNUi2hi2uwSAQfY63dIb7OKhUwTMdGyeSDSfuywiUku1iL7ezj+5m1iTBQZxmetaxHCuWHJyRgzn5U8zVcuYZeVJpFdT+Y84cqHdS
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id v22-20020ae9e316000000b007840bab5897sm741901qkf.111.2024.02.07.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:32:00 -0800 (PST)
Message-ID: <90e82dd29a10fb196332e9228fa318febb5e035b.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 5/5] wave5 : Fixed the wrong buffer size
 formula.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nas.chung@chipsnmedia.com
Cc: lafley.kim@chipsnmedia.com, b-brnich@ti.com
Date: Wed, 07 Feb 2024 13:31:59 -0500
In-Reply-To: <20240131013046.15687-6-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-6-jackson.lee@chipsnmedia.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.lee a =C3=A9crit=C2=
=A0:
> S_FMT/G_FMT should report the buffer size based on aligned width and heig=
ht.
> And, Host can set the real encoding size through s_selection and g_select=
ion.
> So, Driver should use the conf_win information for encoding size instead =
of size of S_FMT/G_FMT.

This patch will go away as soon as you have ported to v4l2-common as reques=
ted
in patch 1/5. It will also make future addition of pixel formats less tedio=
us.

regards,
Nicolas

>=20
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> ---
>  .../chips-media/wave5/wave5-vpu-dec.c         | 77 +++++++------------
>  .../chips-media/wave5/wave5-vpu-enc.c         | 77 +++++++++++--------
>  2 files changed, 72 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 328a7a8f26c5..fb9449908ebd 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -243,54 +243,54 @@ static void wave5_update_pix_fmt(struct v4l2_pix_fo=
rmat_mplane *pix_mp, unsigned
>  	case V4L2_PIX_FMT_NV21:
>  		pix_mp->width =3D round_up(width, 32);
>  		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height * 3 / 2;
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height * 3 =
/ 2;
>  		break;
>  	case V4L2_PIX_FMT_YUV422P:
>  	case V4L2_PIX_FMT_NV16:
>  	case V4L2_PIX_FMT_NV61:
>  		pix_mp->width =3D round_up(width, 32);
>  		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height * 2;
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height * 2;
>  		break;
>  	case V4L2_PIX_FMT_YUV420M:
>  		pix_mp->width =3D round_up(width, 32);
>  		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height / 4;
> -		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[2].sizeimage =3D width * height / 4;
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width / 2;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height / 4;
> +		pix_mp->plane_fmt[2].bytesperline =3D pix_mp->width / 2;
> +		pix_mp->plane_fmt[2].sizeimage =3D pix_mp->width * pix_mp->height / 4;
>  		break;
>  	case V4L2_PIX_FMT_NV12M:
>  	case V4L2_PIX_FMT_NV21M:
>  		pix_mp->width =3D round_up(width, 32);
>  		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height / 2;
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height / 2;
>  		break;
>  	case V4L2_PIX_FMT_YUV422M:
>  		pix_mp->width =3D round_up(width, 32);
>  		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height / 2;
> -		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[2].sizeimage =3D width * height / 2;
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width / 2;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height / 2;
> +		pix_mp->plane_fmt[2].bytesperline =3D pix_mp->width / 2;
> +		pix_mp->plane_fmt[2].sizeimage =3D pix_mp->width * pix_mp->height / 2;
>  		break;
>  	case V4L2_PIX_FMT_NV16M:
>  	case V4L2_PIX_FMT_NV61M:
>  		pix_mp->width =3D round_up(width, 32);
>  		pix_mp->height =3D round_up(height, 16);
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D width * height;
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height;
>  		break;
>  	default:
>  		pix_mp->width =3D width;
> @@ -1003,6 +1003,7 @@ static int wave5_vpu_dec_queue_setup(struct vb2_que=
ue *q, unsigned int *num_buff
>  	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
>  	struct v4l2_pix_format_mplane inst_format =3D
>  		(q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : i=
nst->dst_fmt;
> +	unsigned int i;
> =20
>  	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %=
u\n", __func__,
>  		*num_buffers, *num_planes, q->type);
> @@ -1016,31 +1017,9 @@ static int wave5_vpu_dec_queue_setup(struct vb2_qu=
eue *q, unsigned int *num_buff
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
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index 19018ace41b6..762973d0677b 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -152,46 +152,46 @@ static void wave5_update_pix_fmt(struct v4l2_pix_fo=
rmat_mplane *pix_mp, unsigned
>  	case V4L2_PIX_FMT_YUV420:
>  	case V4L2_PIX_FMT_NV12:
>  	case V4L2_PIX_FMT_NV21:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height * 3 / =
2;
> +		pix_mp->width =3D round_up(width, 32);
> +		pix_mp->height =3D round_up(height, 16);
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height * 3 =
/ 2;
>  		break;
>  	case V4L2_PIX_FMT_YUV420M:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 4;
> -		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> -		pix_mp->plane_fmt[2].sizeimage =3D round_up(width, 32) * height / 4;
> +		pix_mp->width =3D round_up(width, 32);
> +		pix_mp->height =3D round_up(height, 16);
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width / 2;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height / 4;
> +		pix_mp->plane_fmt[2].bytesperline =3D pix_mp->width / 2;
> +		pix_mp->plane_fmt[2].sizeimage =3D pix_mp->width * pix_mp->height / 4;
>  		break;
>  	case V4L2_PIX_FMT_NV12M:
>  	case V4L2_PIX_FMT_NV21M:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 2;
> +		pix_mp->width =3D round_up(width, 32);
> +		pix_mp->height =3D round_up(height, 16);
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height / 2;
>  		break;
>  	case V4L2_PIX_FMT_YUV422P:
>  	case V4L2_PIX_FMT_NV16:
>  	case V4L2_PIX_FMT_NV61:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height * 2;
> +		pix_mp->width =3D round_up(width, 32);
> +		pix_mp->height =3D round_up(height, 16);
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height * 2;
>  		break;
>  	case V4L2_PIX_FMT_NV16M:
>  	case V4L2_PIX_FMT_NV61M:
> -		pix_mp->width =3D width;
> -		pix_mp->height =3D height;
> -		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> -		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> -		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height;
> +		pix_mp->width =3D round_up(width, 32);
> +		pix_mp->height =3D round_up(height, 16);
> +		pix_mp->plane_fmt[0].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[0].sizeimage =3D pix_mp->width * pix_mp->height;
> +		pix_mp->plane_fmt[1].bytesperline =3D pix_mp->width;
> +		pix_mp->plane_fmt[1].sizeimage =3D pix_mp->width * pix_mp->height;
>  		break;
>  	default:
>  		pix_mp->width =3D width;
> @@ -638,6 +638,8 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file,=
 void *fh, struct v4l2_form
>  	inst->xfer_func =3D f->fmt.pix_mp.xfer_func;
> =20
>  	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp=
height);
> +	inst->conf_win.width =3D inst->dst_fmt.width;
> +	inst->conf_win.height =3D inst->dst_fmt.height;
> =20
>  	return 0;
>  }
> @@ -653,12 +655,17 @@ static int wave5_vpu_enc_g_selection(struct file *f=
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
> @@ -681,8 +688,10 @@ static int wave5_vpu_enc_s_selection(struct file *fi=
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
> @@ -1229,8 +1238,8 @@ static void wave5_set_enc_openparam(struct enc_open=
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
> @@ -1806,6 +1815,8 @@ static int wave5_vpu_open_enc(struct file *filp)
>  	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
> =20
>  	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
> +	inst->conf_win.width =3D inst->dst_fmt.width;
> +	inst->conf_win.height =3D inst->dst_fmt.height;
>  	inst->colorspace =3D V4L2_COLORSPACE_REC709;
>  	inst->ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
>  	inst->quantization =3D V4L2_QUANTIZATION_DEFAULT;


