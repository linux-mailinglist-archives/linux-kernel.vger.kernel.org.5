Return-Path: <linux-kernel+bounces-75875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A685F02A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB621F21DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED31773E;
	Thu, 22 Feb 2024 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8K79ujf"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9373E111B2;
	Thu, 22 Feb 2024 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573857; cv=none; b=I4NXzV+WKt3bAuko4G7SjMa0ATEBp1cYyHTYY/MlwV8u/TGR4No5CFfr55IuIHo2OyQMj8KwJYoAsZkqBUchEImUdMNvyNbAEUuBm9ZILv3jPO9durOWJ+e0kn3L0+/Sb7YyfdUs2lPCw05u2QYIKff6cwcReQmOPsORWHr2XxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573857; c=relaxed/simple;
	bh=J3j8PZZdp5i0Gd+0rx6IZWHUtQPKYoQur7jAPifN9go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMkaX5RaDbTnAhfaLgSlBHyX7edoreggJtFyQZhogs/W9jgWGrEkhYvh/3lY5j82MKEvbg+TUklDIpXCKieyHAvIky9uo/vZIz+Q9hbaj19WtdIOrHzH6Pv7nSuomBiGNDykFK2uN/spa1eXI9Gr4sak3sNdfHPBgaghiAEdTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8K79ujf; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c72294e3d1so284571339f.1;
        Wed, 21 Feb 2024 19:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708573855; x=1709178655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Q0YGTOKcdouf/IIlA2xOaiZYdgb6GG89hveRTd/5g=;
        b=f8K79ujf/hbdxRtSaN4HrY35pZYF8BBwW7zY4yzNK6HfT+rlN2O6BE024uL1u/c96Z
         iwEJvuwtUjyQ8cLbUHVf31+3rTf1K54H2LnZN4iAuI41GG2GZ+U11D4fkCWApCFM+acB
         +3ysARRj6I+1b6t1Eye8dKTjLAZHRAMsIOUe1QrDVfLJ+VfwTWbDswVDdkMeWHiig3qw
         abpqw+RQlYt5eKeGUGXYI9P0TUcVa78L4bR3nDizeBbJE9kzyu7oV4O3WCmybstKLQNR
         1S/gWbrsthiQEswDnOnQzlDtwmZjKM1gZ+EM1GKjIqPxIok+vj1gIxv4S0wNdg27dFhR
         GFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573855; x=1709178655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/Q0YGTOKcdouf/IIlA2xOaiZYdgb6GG89hveRTd/5g=;
        b=Aj2CeEIoKi3HGXnevSxBW7dsQZizdoGY62iDn+lmumGhlqY5SI2CRqsksg5T3d4vi2
         YJ6yO43g8TRzsad4innFPrcJcL9KYgmXaoh5t6LPB3TOVUvgHfgJjLAsC5/utg8uDxzq
         LGt9y7+BMrP4hPpUN9y17V5+dTl6OPDherwUhhI/bPLnPMXfXnEc7We6wlMF0V+p+GUm
         ZJw+AQyUuGrC91/FkXOqzS5mzYRYnEKdwTkbBJ7veTCaA4dWrTa2J56hSighmMDYQZjd
         vNssLtl0IPzR3dIXnOsedmctko5H2D+d/35BWJjisReZo2MCy8wtmaXbluyxhnKGpH6t
         EFrw==
X-Forwarded-Encrypted: i=1; AJvYcCWc8zKhPL+AFvd4QprZe83YBK8/hEtB/qT2TRHAlwLVZWvNQpb4F/r1JbnDFYJsSZu0pUjxhu5KU63ORVmslPui12tI5wGnwAOlz0/LwjggGLvxrry5e0yq2ctN/vHYbeV7Bl2WA6TLUac=
X-Gm-Message-State: AOJu0YwuWaYqyMnDxO1c1RAExOVftfJo3FZR2FfLUrWuQdXwLdsrJuZG
	zP5zoNyrtUdZx2/glvslqdxVtAGDi3S6XgYXguwYDKKL54iEXa7uJWDpoDV90SkqEkH7YF59biu
	UdztA0y6YW6EYwVL7+586x+tyuTw=
X-Google-Smtp-Source: AGHT+IGObMpA8I/bjIFzhd2/BOrRWHNb8S+mrmq/qw5er4vLZtC3xDXgfTc2XDOuXSracqAay+Hkeu1DOzd3Ewhetl0=
X-Received: by 2002:a05:6e02:1d95:b0:365:1305:fac5 with SMTP id
 h21-20020a056e021d9500b003651305fac5mr19489792ila.0.1708573854696; Wed, 21
 Feb 2024 19:50:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
 <1705581128-4604-9-git-send-email-shengjiu.wang@nxp.com> <20240217101926.3f1d2452@coco.lan>
 <CAA+D8APD+zL0xYkf6FxPNfM3Y3O8+PhT7WEXO7XCLAmBjoMmUA@mail.gmail.com>
 <20240219135618.5c557e66@coco.lan> <e98a23c6-a35d-422b-be8a-1179392215c1@xs4all.nl>
In-Reply-To: <e98a23c6-a35d-422b-be8a-1179392215c1@xs4all.nl>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 22 Feb 2024 11:50:43 +0800
Message-ID: <CAA+D8AN1KEjmb7f5dzMn1EV=UB5QqA4q__y2mTOW8-CH_7gchQ@mail.gmail.com>
Subject: Re: [PATCH v12 08/15] media: uapi: Define audio sample format fourcc type
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi, 
	tfiga@chromium.org, m.szyprowski@samsung.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:10=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 19/02/2024 13:56, Mauro Carvalho Chehab wrote:
> > Em Mon, 19 Feb 2024 12:05:02 +0800
> > Shengjiu Wang <shengjiu.wang@gmail.com> escreveu:
> >
> >> Hi Mauro
> >>
> >> On Sat, Feb 17, 2024 at 5:19=E2=80=AFPM Mauro Carvalho Chehab
> >> <mchehab@kernel.org> wrote:
> >>>
> >>> Em Thu, 18 Jan 2024 20:32:01 +0800
> >>> Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:
> >>>
> >>>> The audio sample format definition is from alsa,
> >>>> the header file is include/uapi/sound/asound.h, but
> >>>> don't include this header file directly, because in
> >>>> user space, there is another copy in alsa-lib.
> >>>> There will be conflict in userspace for include
> >>>> videodev2.h & asound.h and asoundlib.h
> >>>>
> >>>> Here still use the fourcc format.
> >>>>
> >>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>>> ---
> >>>>  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 ++++++++++++++++=
+++
> >>>>  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
> >>>>  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
> >>>>  include/uapi/linux/videodev2.h                | 23 +++++
> >>>>  4 files changed, 124 insertions(+)
> >>>>  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-aud=
io.rst
> >>>>
> >>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> >>>> new file mode 100644
> >>>> index 000000000000..04b4a7fbd8f4
> >>>> --- /dev/null
> >>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> >>>> @@ -0,0 +1,87 @@
> >>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> >>>> +
> >>>> +.. _pixfmt-audio:
> >>>> +
> >>>> +*************
> >>>> +Audio Formats
> >>>> +*************
> >>>> +
> >>>> +These formats are used for :ref:`audiomem2mem` interface only.
> >>>> +
> >>>> +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
> >>>> +
> >>>> +.. cssclass:: longtable
> >>>> +
> >>>> +.. flat-table:: Audio Format
> >>>> +    :header-rows:  1
> >>>> +    :stub-columns: 0
> >>>> +    :widths:       3 1 4
> >>>> +
> >>>> +    * - Identifier
> >>>> +      - Code
> >>>> +      - Details
> >>>> +    * .. _V4L2-AUDIO-FMT-S8:
> >>>> +
> >>>> +      - ``V4L2_AUDIO_FMT_S8``
> >>>> +      - 'S8'
> >>>> +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
> >>>> +    * .. _V4L2-AUDIO-FMT-S16-LE:
> >>>
> >>> Hmm... why can't we just use SNDRV_*_FORMAT_*? Those are already part=
 of
> >>> an uAPI header. No need to add any abstraction here and/or redefine
> >>> what is there already at include/uapi/sound/asound.h.
> >>>
> >> Actually I try to avoid including the include/uapi/sound/asound.h.
> >> Because in user space, there is another copy in alsa-lib (asoundlib.h)=
.
> >> There will be conflict in userspace when including videodev2.h and
> >> asoundlib.h.
> >
> > Well, alsasoundlib.h seems to be using the same definitions:
> >       https://github.com/michaelwu/alsa-lib/blob/master/include/pcm.h
> >
> > So, I can't see what would be the actual issue, as both userspace libra=
ry
> > and ALSA internal headers use the same magic numbers.
> >
> > You can still do things like:
> >
> >       #ifdef __KERNEL__
> >       #  include <sound/asound.h>
> >       #else
> >       #  include <asoundlib.h>
> >       #endif
> >
> > To avoid such kind of conflicts, if you need to have it included on
> > some header file. Yet, I can't see why you would need that.
> >
> > IMO, at uAPI headers, you just need to declare the uAPI audiofmt field
> > to be either __u32 or __u64, pointing it to where this value comes from
> > (on both userspace and Kernelspace. E. g.:
> >
> > /**
> >  * struct v4l2_audio_format - audio data format definition
> >  * @audioformat:
> >  *    an integer number matching the fields inside
> >  *    enum snd_pcm_format_t (e. g. `SNDRV_PCM_FORMAT_*`), as defined
> >  *    in include/uapi/sound/asound.h and
> >  *      https://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.ht=
ml#gaa14b7f26877a812acbb39811364177f8.
> >  * @channels:         channel numbers
> >  * @buffersize:               maximum size in bytes required for data
> >  */
> > struct v4l2_audio_format {
> >       __u32                           audioformat;
> >       __u32                           channels;
> >       __u32                           buffersize;
> > } __attribute__ ((packed));
> >
> > Then, at documentation you just need to point to where the
> > possible values for SNDRV_PCM_FORMAT_ are defined. No need to
> > document them one by one.
> >
> > With such definition, you'll only need to include sound/asound.h
> > within the kAPI scope.
> >
> >>
> >> And in the V4l framework, the fourcc type is commonly used in other
> >> cases (video, radio, touch, meta....), to avoid changing common code
> >> a lot, so I think using fourcc definition for audio may be simpler.
> >
> > Those are real video streams (or a video-related streams, in the case
> > of metadata) where fourcc is widely used. There, it makes sense.
> > However, ALSA format definitions are already being used for a long time=
.
> > There's no sense on trying to reinvent it - or having an abstract layer
> > to convert from/to fourcc <=3D=3D> enum snd_pcm_format_t. Just use what=
 is
> > there already.
>
> The problem is that within V4L2 we use fourcc consistently to describe a
> format, including in VIDIOC_ENUM_FMT. And the expectation is that the fou=
rcc
> can be printed to a human readable string (there is even a printk format =
for
> that these days).
>
> But the pcm values are all small integers (and can even be 0!), and
> printing the fourcc will give garbage. It doesn't work well at all
> with the V4L2 API. But by having a straightforward conversion between the
> pcm identifier and a fourcc it was really easy to deal with this.
>
> There might even be applications today that call VIDIOC_ENUM_FMT to see
> what is supported and fail if it is not a proper fourcc is returned.
>
> It will certainly report nonsense in v4l_print_fmtdesc() (v4l2-ioctl.c).
>
> One of the early versions of this patch series did precisely what you req=
uest,
> but it just doesn't work well within the V4L2 uAPI.
>

Thanks all.

So can I reach the conclusion below?
1. Keep using the fourcc definition for v4l2_audio_format.audioformat.
2. Keep the name V4L2_BUF_TYPE_AUDIO_CAPTURE and
    V4L2_BUF_TYPE_AUDIO_OUTPUT.
3. Fix Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
    to change 'pixelformat' to 'audioformat'.
4. Update Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
    to add more description for clock drift.

Best Regards
Shengjiu Wang

> Regards,
>
>         Hans
>
> >
> > Thanks,
> > Mauro
>

