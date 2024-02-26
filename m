Return-Path: <linux-kernel+bounces-81541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABD867749
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F21FB22650
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225BD1292CD;
	Mon, 26 Feb 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="Mr6H1+vd"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660997E570
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955726; cv=none; b=MhJFGhRCgyiyvNvirH2Vb06eF7Jf333l6Ivn0KWEl95wXL669SmgiXnMMXlu9CQEa+HwYwKt6WhRv6aopCcT4j5UzgMBIPZHUn3OtnC/e6ahi9isj7Ff7SKlBcA6Xa0dtDfmYtbFAJCAh8vHqkdJbSrWhS3YqlOteJbKvgr2ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955726; c=relaxed/simple;
	bh=7xwrFz4sFeqKPniO94AnhAiAfapBnmfBZ453cxW1CU8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9hBWmAzRDvlTRx2doqkuoQ006VVViv5eNfuvwjAdtsBPVO8hgy71iQ+hnutuaHq4gSYBLA61KIGXtSo97qak5BfM/s9Jja1byg6zdDP5m+Z/xaMg102fVLv3SVjwqWBy3x4bnCDKurN32wrvwpfkFR855zoR4eU1q35vr5Stjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=Mr6H1+vd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68fb74416ccso13130606d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1708955723; x=1709560523; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mX0LkxU1mUxO71xVr5XgHY3HEQGcHTxe7iHJJpIZNU=;
        b=Mr6H1+vdmTwMm5ljxsHU0ve3RqfeB32G5DPTsxbmZhJAX+WZ8L76o3U3Z8taA3jzBS
         G3XMpGx+r5lIKCEyEqB64OvUGmeWJZx/sHD8JoUAOMex8F8yimepv1VKUMCrHdCwtjjC
         +FrdIo0lgC6iJoCSiPg60q9GbRGQlHh5eFAr5OkCfI9Cp7ciQV3b+NS1IBaLBor/ub6Z
         VDFsaDcyU/zSi7t8rJoLSdx9ohTwueeaZxX8frcBZ/jQh2X+vG4uEOTquPmerCF15v9l
         pdWP0WV2BQSj0cdsv85fk/flfsNW1WsjQow7H3tWMDrDszc9B+bX2gtsyTM1z1OmrSEy
         S8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955723; x=1709560523;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mX0LkxU1mUxO71xVr5XgHY3HEQGcHTxe7iHJJpIZNU=;
        b=BeBIjoCWem3WJLdup/2DHoWlIrphdcZMpMOFaaPmzTG8BTIMDvd8ek5B4IGAbSpnkI
         s+qPfaKD2y4xTRYFD8JrS+4MiUbfqRiUiMwJcfw4nzhcDGHnKjL/jnJXgYtEbgipcXBg
         930eUYqyonflsLWQNIiv4Vi1G/s3guQNxyqBk3uKqyBG6RnrPhucvy3Y5WIdrFn6GR6k
         gotoE+xiW/jOnbKD+OVitXDLN5gGBwgtviZ+9W2Z6qPDF18SfQWX2ptod2s8uUsLu0f2
         WtfDdB0u2dAn2YA3wGi+hdPjH1pySXQI1vi6os+h/65t4nvgWFtTCZac0n9SHO/EGPJX
         iYeA==
X-Forwarded-Encrypted: i=1; AJvYcCUNwEuhb857SdPaBkcge1zkeRtwBFrFRiaG7DctNBx6CtRcauiSCMEM0F4D+BXZrAwTIdM8RL7EH0jRfkmq+rNJKGR37gwAPPRlke8g
X-Gm-Message-State: AOJu0YyjYfaHQBa4VSSYyUeAtcevlJmGqAOzidHtSGDDj+FbVP2Er69M
	xbgOOVe8IIIy4qbxR8f0JV+NFnS2ISCCBhxn6qQYry2ndw+9nelnPNzZdIg8xRTBnuCKzngeV5A
	MZWI=
X-Google-Smtp-Source: AGHT+IHjPdfShNJb8Rc/lo8p7b+SENTW0Ze38RKXDgrgdkPf621TDjGDvsXbx49ge1zti3/zZ5Onmw==
X-Received: by 2002:ad4:5aab:0:b0:68f:fe88:cc4c with SMTP id u11-20020ad45aab000000b0068ffe88cc4cmr5470020qvg.41.1708955723271;
        Mon, 26 Feb 2024 05:55:23 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b0068fcfef2077sm2953628qvb.93.2024.02.26.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:55:23 -0800 (PST)
Message-ID: <71c860869caf899a72ebc547608220074c5939b1.camel@ndufresne.ca>
Subject: Re: [PATCH v13 09/16] media: uapi: Define audio sample format
 fourcc type
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl, 
 sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com, 
 mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,  shengjiu.wang@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com,  nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,  tiwai@suse.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 26 Feb 2024 08:55:19 -0500
In-Reply-To: <1708936109-11587-10-git-send-email-shengjiu.wang@nxp.com>
References: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
	 <1708936109-11587-10-git-send-email-shengjiu.wang@nxp.com>
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

Le lundi 26 f=C3=A9vrier 2024 =C3=A0 16:28 +0800, Shengjiu Wang a =C3=A9cri=
t=C2=A0:
> The audio sample format definition is from alsa,
> the header file is include/uapi/sound/asound.h, but
> don't include this header file directly, because in
> user space, there is another copy in alsa-lib.
> There will be conflict in userspace for include
> videodev2.h & asound.h and asoundlib.h
>=20
> Here still use the fourcc format.

I'd like to join Mauro's voice that duplicating the audio formats is a bad =
idea.
We have the same issues with video formats when you look at V4L2 vs DRM. Yo=
u're
rationale is that videodev2.h will be ambiguous if it includes asound.h, bu=
t
looking at this change, there is no reason why you need to include asound.h=
 in
videodev2.h at all. The format type can be abstracted out with a uint32 in =
the
API, and then it would be up to the users to include and use the appropriat=
e
formats IDs.

Nicolas

>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 +++++++++++++++++++
>  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
>  include/uapi/linux/videodev2.h                | 23 +++++
>  4 files changed, 124 insertions(+)
>  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.rs=
t
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst b/Doc=
umentation/userspace-api/media/v4l/pixfmt-audio.rst
> new file mode 100644
> index 000000000000..04b4a7fbd8f4
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +
> +.. _pixfmt-audio:
> +
> +*************
> +Audio Formats
> +*************
> +
> +These formats are used for :ref:`audiomem2mem` interface only.
> +
> +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: Audio Format
> +    :header-rows:  1
> +    :stub-columns: 0
> +    :widths:       3 1 4
> +
> +    * - Identifier
> +      - Code
> +      - Details
> +    * .. _V4L2-AUDIO-FMT-S8:
> +
> +      - ``V4L2_AUDIO_FMT_S8``
> +      - 'S8'
> +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
> +    * .. _V4L2-AUDIO-FMT-S16-LE:
> +
> +      - ``V4L2_AUDIO_FMT_S16_LE``
> +      - 'S16_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_S16_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-U16-LE:
> +
> +      - ``V4L2_AUDIO_FMT_U16_LE``
> +      - 'U16_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_U16_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-S24-LE:
> +
> +      - ``V4L2_AUDIO_FMT_S24_LE``
> +      - 'S24_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_S24_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-U24-LE:
> +
> +      - ``V4L2_AUDIO_FMT_U24_LE``
> +      - 'U24_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_U24_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-S32-LE:
> +
> +      - ``V4L2_AUDIO_FMT_S32_LE``
> +      - 'S32_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_S32_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-U32-LE:
> +
> +      - ``V4L2_AUDIO_FMT_U32_LE``
> +      - 'U32_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_U32_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-FLOAT-LE:
> +
> +      - ``V4L2_AUDIO_FMT_FLOAT_LE``
> +      - 'FLOAT_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_FLOAT_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-IEC958-SUBFRAME-LE:
> +
> +      - ``V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE``
> +      - 'IEC958_SUBFRAME_LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-S24-3LE:
> +
> +      - ``V4L2_AUDIO_FMT_S24_3LE``
> +      - 'S24_3LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-U24-3LE:
> +
> +      - ``V4L2_AUDIO_FMT_U24_3LE``
> +      - 'U24_3LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_U24_3LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-S20-3LE:
> +
> +      - ``V4L2_AUDIO_FMT_S20_3LE``
> +      - 'S20_3LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> +    * .. _V4L2-AUDIO-FMT-U20-3LE:
> +
> +      - ``V4L2_AUDIO_FMT_U20_3LE``
> +      - 'U20_3LE'
> +      - Corresponds to SNDRV_PCM_FORMAT_U20_3LE in ALSA
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Documenta=
tion/userspace-api/media/v4l/pixfmt.rst
> index 11dab4a90630..2eb6fdd3b43d 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt.rst
> @@ -36,3 +36,4 @@ see also :ref:`VIDIOC_G_FBUF <VIDIOC_G_FBUF>`.)
>      colorspaces
>      colorspaces-defs
>      colorspaces-details
> +    pixfmt-audio
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 961abcdf7290..be229c69e991 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1471,6 +1471,19 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *=
fmt)
>  	case V4L2_PIX_FMT_Y210:		descr =3D "10-bit YUYV Packed"; break;
>  	case V4L2_PIX_FMT_Y212:		descr =3D "12-bit YUYV Packed"; break;
>  	case V4L2_PIX_FMT_Y216:		descr =3D "16-bit YUYV Packed"; break;
> +	case V4L2_AUDIO_FMT_S8:		descr =3D "8-bit Signed"; break;
> +	case V4L2_AUDIO_FMT_S16_LE:	descr =3D "16-bit Signed LE"; break;
> +	case V4L2_AUDIO_FMT_U16_LE:		descr =3D "16-bit Unsigned LE"; break;
> +	case V4L2_AUDIO_FMT_S24_LE:		descr =3D "24(32)-bit Signed LE"; break;
> +	case V4L2_AUDIO_FMT_U24_LE:		descr =3D "24(32)-bit Unsigned LE"; break;
> +	case V4L2_AUDIO_FMT_S32_LE:		descr =3D "32-bit Signed LE"; break;
> +	case V4L2_AUDIO_FMT_U32_LE:		descr =3D "32-bit Unsigned LE"; break;
> +	case V4L2_AUDIO_FMT_FLOAT_LE:		descr =3D "32-bit Float LE"; break;
> +	case V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE:	descr =3D "32-bit IEC958 LE"; b=
reak;
> +	case V4L2_AUDIO_FMT_S24_3LE:		descr =3D "24(24)-bit Signed LE"; break;
> +	case V4L2_AUDIO_FMT_U24_3LE:		descr =3D "24(24)-bit Unsigned LE"; break=
;
> +	case V4L2_AUDIO_FMT_S20_3LE:		descr =3D "20(24)-bit Signed LE"; break;
> +	case V4L2_AUDIO_FMT_U20_3LE:		descr =3D "20(24)-bit Unsigned LE"; break=
;
> =20
>  	default:
>  		/* Compressed formats */
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 2c03d2dfadbe..673a6235a029 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -843,6 +843,29 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* =
Rockchip ISP1 3A Parameters */
>  #define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /*=
 Rockchip ISP1 3A Statistics */
> =20
> +/*
> + * Audio-data formats
> + * All these audio formats use a fourcc starting with 'AU'
> + * followed by the SNDRV_PCM_FORMAT_ value from asound.h.
> + */
> +#define V4L2_AUDIO_FMT_S8			v4l2_fourcc('A', 'U', '0', '0')
> +#define V4L2_AUDIO_FMT_S16_LE			v4l2_fourcc('A', 'U', '0', '2')
> +#define V4L2_AUDIO_FMT_U16_LE			v4l2_fourcc('A', 'U', '0', '4')
> +#define V4L2_AUDIO_FMT_S24_LE			v4l2_fourcc('A', 'U', '0', '6')
> +#define V4L2_AUDIO_FMT_U24_LE			v4l2_fourcc('A', 'U', '0', '8')
> +#define V4L2_AUDIO_FMT_S32_LE			v4l2_fourcc('A', 'U', '1', '0')
> +#define V4L2_AUDIO_FMT_U32_LE			v4l2_fourcc('A', 'U', '1', '2')
> +#define V4L2_AUDIO_FMT_FLOAT_LE			v4l2_fourcc('A', 'U', '1', '4')
> +#define V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE	v4l2_fourcc('A', 'U', '1', '8'=
)
> +#define V4L2_AUDIO_FMT_S24_3LE			v4l2_fourcc('A', 'U', '3', '2')
> +#define V4L2_AUDIO_FMT_U24_3LE			v4l2_fourcc('A', 'U', '3', '4')
> +#define V4L2_AUDIO_FMT_S20_3LE			v4l2_fourcc('A', 'U', '3', '6')
> +#define V4L2_AUDIO_FMT_U20_3LE			v4l2_fourcc('A', 'U', '3', '8')
> +
> +#define v4l2_fourcc_to_audfmt(fourcc)	\
> +	(__force snd_pcm_format_t)(((((fourcc) >> 16) & 0xff) - '0') * 10  \
> +				   + ((((fourcc) >> 24) & 0xff) - '0'))
> +
>  /* priv field value to indicates that subsequent fields are valid. */
>  #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
> =20


