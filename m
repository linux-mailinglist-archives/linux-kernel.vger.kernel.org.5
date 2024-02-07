Return-Path: <linux-kernel+bounces-56882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714684D0C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66778B24241
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D44127B65;
	Wed,  7 Feb 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="3CfqzVB5"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19118562A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328812; cv=none; b=kMzTDjaceqx1ckA0CHQziIE0nBi1madkJRofe8aWeCfiVnAu2P8yYs6PWYI9QEbJmkEkCM+Epz7GXDl+l5OmG5RO4h7cMhyp4rqlHUBlXu9+gxApDjV5pQXFgfiv+BHlLhQkANWezxEe3WDFXe2g6P9OOYsdCrivKthCbtQW5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328812; c=relaxed/simple;
	bh=/dH1SJ+1oGDDvblcOZkoEcbtGSXPkYVk2pQQtnvzRC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=op+xBjGUdo7BRQy8R9fKI7wvwtQCEPQ4Xyvl4k2dnUFNkJm/wATTGYX+GepgtUqFQHOBJ+GNPAoFiJ2UEWkSTngnQDiAayB45w3dzTsZ0F/R6j9sB0VNkkgX7fFLbeUsmqw+wJLyQc6Jhuc8V5BtPo7gkRd+nG4vI3NWDp8nAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=3CfqzVB5; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so589492b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707328809; x=1707933609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=atTeCdizyi3sZCKnlWTta7eXoq1GPnFuq1V8uU4FIFc=;
        b=3CfqzVB5SDgXdyN1SEczw4UoaF9BkA1YeUJTurK1/vKEk6MVolmzA+0iL2uca8qK8M
         vOhIU/73ybMlUn7Ggy/hJ6yvlwFEIo7cp8IKgl0ZYKBVTg++AdI3OlsNBGOBmCrnlt9K
         eVipAbTaUr/BDMaP5bw1XgwnmYEfUMKvPNWbOSQ9eRNMMPINwXOXC+Sag4wv7BEx2ZP4
         5dn9QSq50SSt0VVrIlqa8FLyYbivIx2DU8INSjyAApSxnSDfmj0FgaiTVmBwfi/8gZEX
         hncU6qmprsbXSM7lNdKHSR85pFiFtD13qJW1fss9jqqFqTt76a+a1+J5iRTQ94cRX7Do
         tA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328809; x=1707933609;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atTeCdizyi3sZCKnlWTta7eXoq1GPnFuq1V8uU4FIFc=;
        b=Sp7SFNgMa9vk4eLRnrKB5DPlQVTsNCkazBpxGZ0hxyo9ND/E3Pb/XekDlruIl++UDo
         SUaFEeUAXovpJ57cRNg+iaEJ/w3mBuShhaS9JZi+oEpIprgPMkH0z2WLA8gHFYAm+GAy
         xzfN2Pawwl+hy1vmEoZh4IZJtlTP39bFypT5U4DqtnZM1RaeAmwEAAV9+GS6255JopIh
         s/Eu0Xomfjl8tnm/CeFQ2fxf3k5oxq328DiUa25hjR91whDBpgW7IRF9+fAjWQZFNuUS
         041KiNhyUyrBfTN72b300XD+KUBqTtAA+PCSsrhFWiECz9quHM7URfdMe007Sy3th6Hl
         ZgYg==
X-Forwarded-Encrypted: i=1; AJvYcCVVah466we2oczJut/lGEeEeemM4IAOvv1/bpHj1UfgJZl2/SdnEP8jih/70OMwUPP1UztDsW61RVkYX6/KcRhSOsNKdWIpB6g9jeb4
X-Gm-Message-State: AOJu0Yw1saSFc/Q/9drfoF1tvGGrPIalrl9xQnzjPuHlGyb4j4WgFl6y
	Z7BxCF3jhgCUnEE4qqwb6RPoJ7mVNVj4X+PX/YalitonF1HhjDe6Spu4RM3QI0E=
X-Google-Smtp-Source: AGHT+IFYAdfEEPYHXZrZD8drsRK2WPzrtgCEfz1KwgUtllEkgkufhwR9Wb11m728D4Ks2bQ7ptg38g==
X-Received: by 2002:a05:6808:384b:b0:3bf:ee86:6ecc with SMTP id ej11-20020a056808384b00b003bfee866eccmr2749857oib.34.1707328808632;
        Wed, 07 Feb 2024 10:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaJY4UrjJA7uNj1pRPY7DD5LTHRmxwbPRf5Noge3Q2pTDGB2ptvmhwB3FYL/3a2pY3wXctmd3Fw1Kuvzc0oZAXiMZE2+sGhDnT1f9ZKQo+Y0v+RMgUP8UwS9pRHb4+qa0CZb1Mq94sRItdllW1NOU12r1v87HVU8vC4PqfJPULLfki+kOLDgLyoTK0oXY9wGL9vFt3nh3sxN61/NewCjf7Zs23paPJUCRx
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id m21-20020a05620a24d500b007840a08a097sm717844qkn.76.2024.02.07.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:00:08 -0800 (PST)
Message-ID: <cdcf594ecaefaac748655bdcb7dcc1c4f9ad1a68.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 2/5] wave5: Support to prepend sps/pps to IDR
 frame.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nas.chung@chipsnmedia.com
Cc: lafley.kim@chipsnmedia.com, b-brnich@ti.com
Date: Wed, 07 Feb 2024 13:00:06 -0500
In-Reply-To: <20240131013046.15687-3-jackson.lee@chipsnmedia.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-3-jackson.lee@chipsnmedia.com>
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

Hi Jackson,

Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.lee a =C3=A9crit=C2=
=A0:
> Indicates whether to generate SPS and PPS at every IDR. Setting it to 0 d=
isables generating SPS and PPS at every IDR.
> Setting it to one enables generating SPS and PPS at every IDR.
>=20
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  drivers/media/platform/chips-media/wave5/wave5-hw.c      | 6 ++++--
>  drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 7 +++++++
>  drivers/media/platform/chips-media/wave5/wave5-vpuapi.h  | 1 +
>  3 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/driver=
s/media/platform/chips-media/wave5/wave5-hw.c
> index f1e022fb148e..8ad7f3a28ae1 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -1602,11 +1602,13 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *i=
nst)
>  	if (inst->std =3D=3D W_AVC_ENC)
>  		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp=
 |
>  				((p_param->intra_period & 0x7ff) << 6) |
> -				((p_param->avc_idr_period & 0x7ff) << 17));
> +				((p_param->avc_idr_period & 0x7ff) << 17) |
> +				(p_param->forced_idr_header_enable << 28));

I can spot evident hard-coding of mask and bit shifts in here. In order to
continuously improve this driver code, I would like to see this (and the
following) magic number being defined with well named macros as a preparati=
on
patch to this feature change.

regards,
Nicolas

>  	else if (inst->std =3D=3D W_HEVC_ENC)
>  		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
>  			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
> -				(p_param->intra_period << 16));
> +			      (p_param->forced_idr_header_enable << 9) |
> +			      (p_param->intra_period << 16));
> =20
>  	reg_val =3D (p_param->rdo_skip << 2) |
>  		(p_param->lambda_scaling_enable << 3) |
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index 0cb5bfb67258..761775216cd4 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -1125,6 +1125,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *c=
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
> @@ -1292,6 +1295,7 @@ static void wave5_set_enc_openparam(struct enc_open=
_param *open_param,
>  		else
>  			open_param->wave_param.intra_refresh_arg =3D num_ctu_row;
>  	}
> +	open_param->wave_param.forced_idr_header_enable =3D input.forced_idr_he=
ader_enable;
>  }
> =20
>  static int initialize_sequence(struct vpu_instance *inst)
> @@ -1775,6 +1779,9 @@ static int wave5_vpu_open_enc(struct file *filp)
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


