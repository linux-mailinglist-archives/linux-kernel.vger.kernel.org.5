Return-Path: <linux-kernel+bounces-150759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AE8AA434
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0900A2835F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D598190693;
	Thu, 18 Apr 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="liG7LA+C"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188016C858
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472960; cv=none; b=BBIVCyY72BrBd1nGWUPpfVJ+pj9Sh+zFj2Gpq871rVL07b+lTZoV/CknZkp7bNOPeG9J9kYwOsGFx5HmdH683RYeNZqtCV5n1ybGKDWmAJZRnJ7DPGX9eoIXP720QB2kgMPgfXYSQmdSZZSrnkoSk4ZDVKuhwviQJ73A63aA5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472960; c=relaxed/simple;
	bh=cmUh/RMXY3m7Q7zoie/Ha+d21Jf0n3rJA3Rtai9dZlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eut5+Qv6XI96/rnxyhtkmaDyYvbOgNSw20X5EaDAOvC9b0ou/PRwQuQ+yF5UCzXQM4n0DcyrqXjKcNbEJ/+fOVQNsvowraPuf1AUIEyL7buQ7c6Sc8AUjXA4IKrAVXj2IZdyTrTsyciApbaUCiVb1nd46pkkaUlk44Y9avWmtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=liG7LA+C; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f03917484so78123685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1713472957; x=1714077757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Zc8fWit1e1eqZNNNWhrr8d7897nANJa2k6qso1lNSs=;
        b=liG7LA+C/h7EzI3gIYsCiIemLdUe+uqUFSr+lczowvgzfx/AhRY7d168MZzdEvGH44
         uH4Zeri1thArjU9qQM21KvTb/w0B5FhD4Rmc9pU1CGiuHUCzCj3e4yXT10vKnA74Wotc
         XkKcjPFzoyWyguV+AadoEpLGw1ThxnpevsXeWSRaURy0BQvGRSp/xkcmnsbWDYK74ZZm
         diZ/HBDEXfVxqTN2U/G/3Z6Pctk+Ifi4zs1U4gPQcvHAGvNv0CNs1Ixq8Zmk4u9tqIQk
         Q13BrKDBHAh7Yr/LV5UV4ligqRx6kxZtafl2U7HEJNp6/NbZDGtey7VcOPusSi+AQzS8
         62PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472957; x=1714077757;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zc8fWit1e1eqZNNNWhrr8d7897nANJa2k6qso1lNSs=;
        b=HPGy06g6Hc3JINr7USzxXvqIaCkY+0VMO2D5dwfGFAvOS0w618ckiDHt0Xkryvett2
         YWt/dlAIvQzjIn8lnTyAWd4+SCKS1zCuFYFVZ1n3KLDCbHIC1lD8LIK33b0gDxCd4PJL
         W68bHEBmIh8rAnrtl0KVqNWlHXDfwcJudTTPWtljB03zerlqNB1HtaT7+OC7dFI2v16V
         d8jxNlHMd2u1bfAZX+2GjcZEu9jT973n8ucS+f4LC4aGY5NE5DzJVYqf0tgWjqctlNzf
         l305f3/sRmDYhPlp4/TD7AAWIiveY5j8DBiKAPA4Uad9sLSudvdLwP6gxOXDop/i0Ibj
         Ibtw==
X-Forwarded-Encrypted: i=1; AJvYcCW1mRW5QlPElYL32NVFWms6pFT+2AnaZnN7WAyDfiKrAccNPvc7O3HknTLbIgnwf3+w20W3tdGmpHeYHsdgXZExHj8K6+BMVhphXOcS
X-Gm-Message-State: AOJu0YwzpH5WnLHAdsYgRCOS//0AIpk0tZLZASWaIebQ0lnQLbOU26Qo
	9zl2YC7hR1ROXWkMItzG7AA8Ew4a81+m262ZtbmVrjZErbLQu7nQHN6YS1K+daQ=
X-Google-Smtp-Source: AGHT+IGdJc3FPJgE45fxf39vCXmz9qTYcy/n4jbgz/ECNg9EIN8d2UprWRdtewBFXKYnM/m0f+Br4g==
X-Received: by 2002:a05:620a:13e1:b0:78e:dc09:a961 with SMTP id h1-20020a05620a13e100b0078edc09a961mr238199qkl.63.1713472956930;
        Thu, 18 Apr 2024 13:42:36 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id o11-20020a05620a2a0b00b0078f03c9eda1sm958366qkp.94.2024.04.18.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:42:36 -0700 (PDT)
Message-ID: <b2bd37736630d339091ff829a8437b1a34eff292.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v2 1/4] media: chips-media: wave5: Support
 SPS/PPS generation for each IDR
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hverkuil@xs4all.nl, nas.chung@chipsnmedia.com, lafley.kim@chipsnmedia.com, 
	b-brnich@ti.com
Date: Thu, 18 Apr 2024 16:42:35 -0400
In-Reply-To: <20240311105623.20406-2-jackson.lee@chipsnmedia.com>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-2-jackson.lee@chipsnmedia.com>
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

Le lundi 11 mars 2024 =C3=A0 19:56 +0900, jackson.lee a =C3=A9crit=C2=A0:
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> Provide a control to toggle (0 =3D off / 1 =3D on), whether the SPS and
> PPS are generated for every IDR.
>=20
> Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  .../platform/chips-media/wave5/wave5-hw.c     | 19 +++++++++++++++----
>  .../chips-media/wave5/wave5-vpu-enc.c         |  7 +++++++
>  .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
>  3 files changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/driver=
s/media/platform/chips-media/wave5/wave5-hw.c
> index f1e022fb148e..4a262822bf17 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -23,6 +23,15 @@
>  #define FEATURE_AVC_ENCODER		BIT(1)
>  #define FEATURE_HEVC_ENCODER		BIT(0)
> =20
> +#define ENC_AVC_INTRA_IDR_PARAM_MASK	0x7ff
> +#define ENC_AVC_INTRA_PERIOD		6
> +#define ENC_AVC_IDR_PERIOD		17
> +#define ENC_AVC_FORCED_IDR_HEADER	28
> +
> +#define ENC_HEVC_INTRA_QP		3
> +#define ENC_HEVC_FORCED_IDR_HEADER	9
> +#define ENC_HEVC_INTRA_PERIOD		16
> +

Perhaps add the suffix _SHIFT to these macro ? I think it can easily be con=
fused
with a default value otherwise.

nit: can happen later, since this is how things got merged in this driver, =
but
typically, registers offsets, shift and masks are usually consolidated in a
single reg header. It would be nice to consider cleaning this up in future
patches.

>  /* Decoder support fields */
>  #define FEATURE_AVC_DECODER		BIT(3)
>  #define FEATURE_HEVC_DECODER		BIT(2)
> @@ -1601,12 +1610,14 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *i=
nst)
> =20
>  	if (inst->std =3D=3D W_AVC_ENC)
>  		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp=
 |
> -				((p_param->intra_period & 0x7ff) << 6) |
> -				((p_param->avc_idr_period & 0x7ff) << 17));
> +				((p_param->intra_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_I=
NTRA_PERIOD) |
> +				((p_param->avc_idr_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC=
_IDR_PERIOD) |
> +				(p_param->forced_idr_header_enable << ENC_AVC_FORCED_IDR_HEADER));
>  	else if (inst->std =3D=3D W_HEVC_ENC)
>  		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
> -			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
> -				(p_param->intra_period << 16));
> +			      p_param->decoding_refresh_type | (p_param->intra_qp << ENC_HEVC=
_INTRA_QP) |
> +			      (p_param->forced_idr_header_enable << ENC_HEVC_FORCED_IDR_HEADE=
R) |
> +			      (p_param->intra_period << ENC_HEVC_INTRA_PERIOD));
> =20
>  	reg_val =3D (p_param->rdo_skip << 2) |
>  		(p_param->lambda_scaling_enable << 3) |
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index f29cfa3af94a..f04baa93a9b7 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1061,6 +1061,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *c=
trl)
>  	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
>  		inst->enc_param.entropy_coding_mode =3D ctrl->val;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
> +		inst->enc_param.forced_idr_header_enable =3D ctrl->val;
> +		break;
>  	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
>  		break;
>  	default:
> @@ -1219,6 +1222,7 @@ static void wave5_set_enc_openparam(struct enc_open=
_param *open_param,
>  		else
>  			open_param->wave_param.intra_refresh_arg =3D num_ctu_row;
>  	}
> +	open_param->wave_param.forced_idr_header_enable =3D input.forced_idr_he=
ader_enable;

in the long term, there is one too many abstraction in this driver, we shou=
ld
remove that.

>  }
> =20
>  static int initialize_sequence(struct vpu_instance *inst)
> @@ -1702,6 +1706,9 @@ static int wave5_vpu_open_enc(struct file *filp)
>  			  0, 1, 1, 0);
>  	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
>  			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
> +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> +			  V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR,
> +			  0, 1, 1, 0);
> =20
>  	if (v4l2_ctrl_hdl->error) {
>  		ret =3D -ENODEV;
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> index 352f6e904e50..3ad6118550ac 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> @@ -566,6 +566,7 @@ struct enc_wave_param {
>  	u32 lambda_scaling_enable: 1; /* enable lambda scaling using custom GOP=
 */
>  	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 tran=
sform */
>  	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
> +	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR f=
rame */
>  };
> =20
>  struct enc_open_param {

With the suggested _SHIFT suffix (or equivalent) added.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>


