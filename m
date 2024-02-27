Return-Path: <linux-kernel+bounces-82658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78C8687D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7FF1F230F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620C4C3CD;
	Tue, 27 Feb 2024 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQtsR49a"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A45C82;
	Tue, 27 Feb 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005455; cv=none; b=lX7uVioMiUfxRWCa0D8mDkoDs6O7qgRMwdQunE6dZlyqRem4M3KZWrQ9JMpZnH02Bt6A2axeCvFBTjhladav+wOzYEnBJY0YqWpGzZQhVQ7/pjqinQ3LZV1VoNkF2HA5Pm2iozetAncE7O8vGT/ZjN0sNuBys1Xl8fwGSpLJEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005455; c=relaxed/simple;
	bh=lIbmhOiQaUClrvOu6WT/oBvlAm6sh1yj/e8dT0C6lHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4qXlBW1OjoFf5893RajfoeaAIsJHt1k4aIsiSJytxFVGzolSTBsIvuRgilhlxOsMCLbJJi0J+KscaFKNQPEjsueVAIFuT11Hh2v3H9eIz0EPixYXBTz6ZKQpfRwBOvgCB2S+Ld/KSgCzbtGnB97U0STb43fDmrliP0c29kRX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQtsR49a; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c7701f95b6so90815939f.1;
        Mon, 26 Feb 2024 19:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005453; x=1709610253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0m1IEz/3wkY8c34XuQVjwcaeuH7mfm7kh/jPGQpBjU=;
        b=VQtsR49a9hrvMzqDFYGqBwfPSDrUAxTovAolV50nqlOuXM3FmZ5sg8IP0Ga5hd6j4G
         YOkPXUrx1hgRVmyupDCkvm1FQXQGBmkSrHAeW3Im7cg1Ww0g9MVGMj7dSceNipym8PO+
         gxWtux/dXudZakMJaXtn0lC3hKvhJOyLJgCV+cBVyKIWTkrqIVki/sYWw9wn9XSBxMAI
         r3yk2j8Lt4XfwR8zkPEdTDiB+oFp2gUguuoCjX8f9qdAO5LHzMyE5cs643jHAmb3Wexy
         JNdwGWsT9i7IA/yc4yfnYnOZGzfpHWGJJOV+SB1Qpb14GRd6hxOmv648v4FHIbg6G6P3
         p/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005453; x=1709610253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0m1IEz/3wkY8c34XuQVjwcaeuH7mfm7kh/jPGQpBjU=;
        b=jOsxlImxdaTXfTYpmp3eyXpGU17SC4Bnxu2VoLJ4MsxBUT0t3vMkhxT4aqmJGrNdv4
         YQ+L+71E4ikeiLa1jUerlQuR0LGgPO6qqVlwPo9vaU8eIt3VMb6CsFp54t2m++rSo+5E
         2nkCRc8tIi68dFpVoK4rT+pimWjuoZ1zFOCHLgVC+iwyuU/Qg4Jo2pf8eqKIM8ibg+yr
         pJoHYCvh1Lc58MjWei0tT0Bx8cETFX/wV2LI4pmUXe0+nZkHRxzFFZDOYMi4XykSw2/2
         HwBZzJTMzc4r9lZET8jkQRiMT3gdQM64CvkkXi0pkpD2kqLH1NaNcyC5bdgcI8AbcqB3
         J9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWEvi2ClAINjydZs5XMTajcS8X9o1Lj6etgQcVIUSG96XKKLqngUAtKEQyRTtyDyhxge4MHJMEOYYW+gGrCxQTZmSbeEtsyV+x8AmSfcqVJEdr3lF3cLGOMnAMUeF1wDi9D4IAQZSszJvg=
X-Gm-Message-State: AOJu0YzL4STo1PIadeuVUJWZthgOiYeGjbNZE+QGK/T2WzwAvkFxibO2
	hq9GHq53KBI4yLHFYV9jG+/evRK7JRkUj8iJMuM0DLlvofZHiQettGU8Xs71XRQo63sDx/ajRHf
	+hKHy1IXCgYCG9dQHVUaD+wo572c=
X-Google-Smtp-Source: AGHT+IEcZHNy22KpBlVhUYmj1+eNLatGGwFDoA7ukQLkIRnAm/YaKRZduIECheyzjsRmSfzYRSLtXm0bSZIeozgX+Ds=
X-Received: by 2002:a92:1e03:0:b0:365:1edf:8e2a with SMTP id
 e3-20020a921e03000000b003651edf8e2amr6768951ile.14.1709005452937; Mon, 26 Feb
 2024 19:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
 <1708936109-11587-10-git-send-email-shengjiu.wang@nxp.com> <71c860869caf899a72ebc547608220074c5939b1.camel@ndufresne.ca>
In-Reply-To: <71c860869caf899a72ebc547608220074c5939b1.camel@ndufresne.ca>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 27 Feb 2024 11:44:02 +0800
Message-ID: <CAA+D8AMEMr_PSsfuSByxd0Sxv1zXJoQjEkJEWEpk59kmLGOD1Q@mail.gmail.com>
Subject: Re: [PATCH v13 09/16] media: uapi: Define audio sample format fourcc type
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl, sakari.ailus@iki.fi, 
	tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:55=E2=80=AFPM Nicolas Dufresne <nicolas@ndufresne=
ca> wrote:
>
> Le lundi 26 f=C3=A9vrier 2024 =C3=A0 16:28 +0800, Shengjiu Wang a =C3=A9c=
rit :
> > The audio sample format definition is from alsa,
> > the header file is include/uapi/sound/asound.h, but
> > don't include this header file directly, because in
> > user space, there is another copy in alsa-lib.
> > There will be conflict in userspace for include
> > videodev2.h & asound.h and asoundlib.h
> >
> > Here still use the fourcc format.
>
> I'd like to join Mauro's voice that duplicating the audio formats is a ba=
d idea.
> We have the same issues with video formats when you look at V4L2 vs DRM. =
You're
> rationale is that videodev2.h will be ambiguous if it includes asound.h, =
but
> looking at this change, there is no reason why you need to include asound=
h in
> videodev2.h at all. The format type can be abstracted out with a uint32 i=
n the
> API, and then it would be up to the users to include and use the appropri=
ate
> formats IDs.
>

Resend for the plain text issue

Thanks.

There is another reason mentioned by Hans:

"
The problem is that within V4L2 we use fourcc consistently to describe a
format, including in VIDIOC_ENUM_FMT. And the expectation is that the fourc=
c
can be printed to a human readable string (there is even a printk format fo=
r
that these days).

But the pcm values are all small integers (and can even be 0!), and
printing the fourcc will give garbage. It doesn't work well at all
with the V4L2 API. But by having a straightforward conversion between the
pcm identifier and a fourcc it was really easy to deal with this.

There might even be applications today that call VIDIOC_ENUM_FMT to see
what is supported and fail if it is not a proper fourcc is returned.

It will certainly report nonsense in v4l_print_fmtdesc() (v4l2-ioctl.c).

One of the early versions of this patch series did precisely what you reque=
st,
but it just doesn't work well within the V4L2 uAPI.
"

Best regards
Shengjiu Wang
> Nicolas
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 +++++++++++++++++++
> >  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
> >  include/uapi/linux/videodev2.h                | 23 +++++
> >  4 files changed, 124 insertions(+)
> >  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.=
rst
> >
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst b/D=
ocumentation/userspace-api/media/v4l/pixfmt-audio.rst
> > new file mode 100644
> > index 000000000000..04b4a7fbd8f4
> > --- /dev/null
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> > @@ -0,0 +1,87 @@
> > +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> > +
> > +.. _pixfmt-audio:
> > +
> > +*************
> > +Audio Formats
> > +*************
> > +
> > +These formats are used for :ref:`audiomem2mem` interface only.
> > +
> > +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table:: Audio Format
> > +    :header-rows:  1
> > +    :stub-columns: 0
> > +    :widths:       3 1 4
> > +
> > +    * - Identifier
> > +      - Code
> > +      - Details
> > +    * .. _V4L2-AUDIO-FMT-S8:
> > +
> > +      - ``V4L2_AUDIO_FMT_S8``
> > +      - 'S8'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S16-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S16_LE``
> > +      - 'S16_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S16_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U16-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U16_LE``
> > +      - 'U16_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U16_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S24-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S24_LE``
> > +      - 'S24_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S24_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U24-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U24_LE``
> > +      - 'U24_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U24_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S32-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S32_LE``
> > +      - 'S32_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S32_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U32-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U32_LE``
> > +      - 'U32_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U32_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-FLOAT-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_FLOAT_LE``
> > +      - 'FLOAT_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_FLOAT_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-IEC958-SUBFRAME-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE``
> > +      - 'IEC958_SUBFRAME_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S24-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S24_3LE``
> > +      - 'S24_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U24-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U24_3LE``
> > +      - 'U24_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U24_3LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S20-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S20_3LE``
> > +      - 'S20_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U20-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U20_3LE``
> > +      - 'U20_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U20_3LE in ALSA
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Documen=
tation/userspace-api/media/v4l/pixfmt.rst
> > index 11dab4a90630..2eb6fdd3b43d 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt.rst
> > @@ -36,3 +36,4 @@ see also :ref:`VIDIOC_G_FBUF <VIDIOC_G_FBUF>`.)
> >      colorspaces
> >      colorspaces-defs
> >      colorspaces-details
> > +    pixfmt-audio
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 961abcdf7290..be229c69e991 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1471,6 +1471,19 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc=
 *fmt)
> >       case V4L2_PIX_FMT_Y210:         descr =3D "10-bit YUYV Packed"; b=
reak;
> >       case V4L2_PIX_FMT_Y212:         descr =3D "12-bit YUYV Packed"; b=
reak;
> >       case V4L2_PIX_FMT_Y216:         descr =3D "16-bit YUYV Packed"; b=
reak;
> > +     case V4L2_AUDIO_FMT_S8:         descr =3D "8-bit Signed"; break;
> > +     case V4L2_AUDIO_FMT_S16_LE:     descr =3D "16-bit Signed LE"; bre=
ak;
> > +     case V4L2_AUDIO_FMT_U16_LE:             descr =3D "16-bit Unsigne=
d LE"; break;
> > +     case V4L2_AUDIO_FMT_S24_LE:             descr =3D "24(32)-bit Sig=
ned LE"; break;
> > +     case V4L2_AUDIO_FMT_U24_LE:             descr =3D "24(32)-bit Uns=
igned LE"; break;
> > +     case V4L2_AUDIO_FMT_S32_LE:             descr =3D "32-bit Signed =
LE"; break;
> > +     case V4L2_AUDIO_FMT_U32_LE:             descr =3D "32-bit Unsigne=
d LE"; break;
> > +     case V4L2_AUDIO_FMT_FLOAT_LE:           descr =3D "32-bit Float L=
E"; break;
> > +     case V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE: descr =3D "32-bit IEC958 =
LE"; break;
> > +     case V4L2_AUDIO_FMT_S24_3LE:            descr =3D "24(24)-bit Sig=
ned LE"; break;
> > +     case V4L2_AUDIO_FMT_U24_3LE:            descr =3D "24(24)-bit Uns=
igned LE"; break;
> > +     case V4L2_AUDIO_FMT_S20_3LE:            descr =3D "20(24)-bit Sig=
ned LE"; break;
> > +     case V4L2_AUDIO_FMT_U20_3LE:            descr =3D "20(24)-bit Uns=
igned LE"; break;
> >
> >       default:
> >               /* Compressed formats */
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 2c03d2dfadbe..673a6235a029 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -843,6 +843,29 @@ struct v4l2_pix_format {
> >  #define V4L2_META_FMT_RK_ISP1_PARAMS v4l2_fourcc('R', 'K', '1', 'P') /=
* Rockchip ISP1 3A Parameters */
> >  #define V4L2_META_FMT_RK_ISP1_STAT_3A        v4l2_fourcc('R', 'K', '1'=
, 'S') /* Rockchip ISP1 3A Statistics */
> >
> > +/*
> > + * Audio-data formats
> > + * All these audio formats use a fourcc starting with 'AU'
> > + * followed by the SNDRV_PCM_FORMAT_ value from asound.h.
> > + */
> > +#define V4L2_AUDIO_FMT_S8                    v4l2_fourcc('A', 'U', '0'=
, '0')
> > +#define V4L2_AUDIO_FMT_S16_LE                        v4l2_fourcc('A', =
'U', '0', '2')
> > +#define V4L2_AUDIO_FMT_U16_LE                        v4l2_fourcc('A', =
'U', '0', '4')
> > +#define V4L2_AUDIO_FMT_S24_LE                        v4l2_fourcc('A', =
'U', '0', '6')
> > +#define V4L2_AUDIO_FMT_U24_LE                        v4l2_fourcc('A', =
'U', '0', '8')
> > +#define V4L2_AUDIO_FMT_S32_LE                        v4l2_fourcc('A', =
'U', '1', '0')
> > +#define V4L2_AUDIO_FMT_U32_LE                        v4l2_fourcc('A', =
'U', '1', '2')
> > +#define V4L2_AUDIO_FMT_FLOAT_LE                      v4l2_fourcc('A', =
'U', '1', '4')
> > +#define V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE    v4l2_fourcc('A', 'U', '1'=
, '8')
> > +#define V4L2_AUDIO_FMT_S24_3LE                       v4l2_fourcc('A', =
'U', '3', '2')
> > +#define V4L2_AUDIO_FMT_U24_3LE                       v4l2_fourcc('A', =
'U', '3', '4')
> > +#define V4L2_AUDIO_FMT_S20_3LE                       v4l2_fourcc('A', =
'U', '3', '6')
> > +#define V4L2_AUDIO_FMT_U20_3LE                       v4l2_fourcc('A', =
'U', '3', '8')
> > +
> > +#define v4l2_fourcc_to_audfmt(fourcc)        \
> > +     (__force snd_pcm_format_t)(((((fourcc) >> 16) & 0xff) - '0') * 10=
  \
> > +                                + ((((fourcc) >> 24) & 0xff) - '0'))
> > +
> >  /* priv field value to indicates that subsequent fields are valid. */
> >  #define V4L2_PIX_FMT_PRIV_MAGIC              0xfeedcafe
> >
>

