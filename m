Return-Path: <linux-kernel+bounces-74506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6EF85D53E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C241C22E22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341C3D98D;
	Wed, 21 Feb 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6g9NgkM"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C63D970;
	Wed, 21 Feb 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510316; cv=none; b=qFDvuK3zhfRvQofsJkHwoeM3uG/4rEDpweB+d9JpWG7CSx32Sc+p/ts2xg0vZUeXDfaCy6E62NbJrZd9/vBQJE/ma1mhXZD0moELCvKbEg8LgY69Z2Q6K10HwalzYGbJHaYtJUKnkhiMKQEtsAdljScpG0Q2TVzmUIpHR6x1Nwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510316; c=relaxed/simple;
	bh=VdwD3m6NWXC/1HXAPru75QbF/kFD+gQGSknB2LVxzwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPcPwxzD7kFaYrsKtewFWqUSfYGLuk7yd1d38Y+avZyJasbxtF4Lvz7c2iqq9czsWWdKQNZ6nEq10GCBmMbXh/o1wL7kVzyrFa6sIa1NlvFOaml/FKxgDZFcxUbJdCWJ5kK/Op7ll7CGjda5hJ+9AKnUyPkiVVDlvaqCg29lkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6g9NgkM; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-365220a2c3dso18016155ab.0;
        Wed, 21 Feb 2024 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708510314; x=1709115114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZKbp4usF7ZooMwkbNPV/awlOsKnx7RNduGOVFzVFPI=;
        b=G6g9NgkM6GXDEGvrH8n571EQRZcPjYpfhMsmiqrbyKUdzIonXp1jQzFWKC5AlMMBvH
         CKHTaT+jyKDos1DojznSlB2tcVEZth+X6iHHB31VL3vgmrdC8Ms3dKAOq1Gshv+i2tMO
         IZ22BDQJ7/N69v8Ui6gkN1m4cibyEtHAhlXXEYGqFtyc4BbLVTVZ/b0g/MdPHaGpnzGw
         crBKpKzx3n4Khe/g7e1nphD3O+J2bHL5fMgCZ0fhDzW0fIkTLiBDoSVgyDQbn//focBl
         ccDPNNGEyUCXLQyyRtXgtGw9KqNWCsxPP8LurJjVGrqh4qTZIlC9j2uFdMFB81roqroQ
         8Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708510314; x=1709115114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZKbp4usF7ZooMwkbNPV/awlOsKnx7RNduGOVFzVFPI=;
        b=D2XIa29tOasXgRPQ+0albKqADAVDUxihboYq+qbLwXUXh/HwJ/u2umf8BqI1r2qqEr
         1XjhmaxTS8oN7KzYu9y8yfWdwFjQmwSFz6j7+P/9CH77jk1YyoZu8U8WsCFuW03E5veF
         30N5BAlhwhfoOv3/Ifu/KcNH1N8IC50bBKfhx8SsEbVgApTsbhQvpG1tn+qvQ+q9rdLl
         PZWyNyNhaSVWYxgOJw3fn46T2mhdNirsU5Qw3MoQrKTGprthtS9hVhTMrvLRu+SUjQCu
         YUwr+eFeeFo2qp/p/PTZhTyh03XpIYM4lFtn6NLK00vKRJzEdv1t5ukjeCV1AtltvhHm
         F1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX/DMd6y+vpcYVu8SZ+P8SNRSINn5dXX28JhKR9MV1cHECc9ZhL9Zh4hwNhYaklPwEU8+0lwwNgVSLw/mmHlaXuhoDUHa1c+NjUegAPgrVztQNYs6QeQG0WJtIvvI0y1ZcSchvrGmXb9jQ=
X-Gm-Message-State: AOJu0YyKN7WZphgOfdY7EG84TCFIRbDLkeGBbmuZT9WdLvnp5FSKt0eY
	D8czabc5YchYDqllG8BWS6949+59UnaZpi7Y8m9DFALV6Eq2dJbd75jT4eATaoHuxmyIRFNQIG8
	KVSEKAWLhIiirWfcGU8zAFe1jnZM=
X-Google-Smtp-Source: AGHT+IHwP0YGlKphHtm67xpwTbsPvnykS5moEGEGjG8wLiOUfX/6e8WVQL0nA7L2tX6O8Xl8WZ/vKMFsIJfBgPoCVzU=
X-Received: by 2002:a05:6e02:1143:b0:364:fffe:44c4 with SMTP id
 o3-20020a056e02114300b00364fffe44c4mr15812470ill.7.1708510313179; Wed, 21 Feb
 2024 02:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
 <1705581128-4604-8-git-send-email-shengjiu.wang@nxp.com> <20240217104212.32f07e3a@coco.lan>
 <CAAFQd5CY731HRhFHpmwzGxAZ-BFV_pT7NNGwNGy4ZOA=qz8ntg@mail.gmail.com>
In-Reply-To: <CAAFQd5CY731HRhFHpmwzGxAZ-BFV_pT7NNGwNGy4ZOA=qz8ntg@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 21 Feb 2024 18:11:42 +0800
Message-ID: <CAA+D8AOKNK37urZfVsuzaTv8PYP-ggTORQEVSpNO0pbaereyLg@mail.gmail.com>
Subject: Re: [PATCH v12 07/15] media: v4l2: Add audio capture and output support
To: Tomasz Figa <tfiga@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl, 
	sakari.ailus@iki.fi, m.szyprowski@samsung.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:30=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> w=
rote:
>
> On Sat, Feb 17, 2024 at 6:42=E2=80=AFPM Mauro Carvalho Chehab
> <mchehab@kernel.org> wrote:
> >
> > Em Thu, 18 Jan 2024 20:32:00 +0800
> > Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:
> >
> > > Audio signal processing has the requirement for memory to
> > > memory similar as Video.
> > >
> > > This patch is to add this support in v4l2 framework, defined
> > > new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> > > V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> > > for audio case usage.
> > >
> > > The created audio device is named "/dev/v4l-audioX".
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  .../userspace-api/media/v4l/buffer.rst        |  6 ++
> > >  .../media/v4l/dev-audio-mem2mem.rst           | 71 +++++++++++++++++=
++
> > >  .../userspace-api/media/v4l/devices.rst       |  1 +
> > >  .../media/v4l/vidioc-enum-fmt.rst             |  2 +
> > >  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |  4 ++
> > >  .../media/videodev2.h.rst.exceptions          |  2 +
> > >  .../media/common/videobuf2/videobuf2-v4l2.c   |  4 ++
> > >  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |  9 +++
> > >  drivers/media/v4l2-core/v4l2-dev.c            | 17 +++++
> > >  drivers/media/v4l2-core/v4l2-ioctl.c          | 53 ++++++++++++++
> > >  include/media/v4l2-dev.h                      |  2 +
> > >  include/media/v4l2-ioctl.h                    | 34 +++++++++
> > >  include/uapi/linux/videodev2.h                | 17 +++++
> > >  13 files changed, 222 insertions(+)
> > >  create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-m=
em2mem.rst
> > >
> > > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Docum=
entation/userspace-api/media/v4l/buffer.rst
> > > index 52bbee81c080..a3754ca6f0d6 100644
> > > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > > @@ -438,6 +438,12 @@ enum v4l2_buf_type
> > >      * - ``V4L2_BUF_TYPE_META_OUTPUT``
> > >        - 14
> >
> > >        - Buffer for metadata output, see :ref:`metadata`.
> > > +    * - ``V4L2_BUF_TYPE_AUDIO_CAPTURE``
> > > +      - 15
> > > +      - Buffer for audio capture, see :ref:`audio`.
> > > +    * - ``V4L2_BUF_TYPE_AUDIO_OUTPUT``
> > > +      - 16
> >
> > Hmm... alsa APi define input/output as:
> >         enum {
> >                 SNDRV_PCM_STREAM_PLAYBACK =3D 0,
> >                 SNDRV_PCM_STREAM_CAPTURE,
> >                 SNDRV_PCM_STREAM_LAST =3D SNDRV_PCM_STREAM_CAPTURE,
> >         };
> >
> >
> > I would use a namespace as close as possible to the
> > ALSA API. Also, we're not talking about V4L2, but, instead
> > audio. so, not sure if I like the prefix to start with
> > V4L2_. Maybe ALSA_?
> >
> > So, a better namespace would be:
> >
> >         ${prefix}_BUF_TYPE_PCM_STREAM_PLAYBACK
> > and
> >         ${prefix}_BUF_TYPE_PCM_STREAM_CAPTURE
> >
>
> The API is still V4L2, and all the other non-video buf types also use
> the V4L2_ prefix, so perhaps that's good here as well?
>
> Whether AUDIO or PCM_STREAM makes more sense goes outside of my
> expertise. Subjectively, a PCM stream sounds more specific than an
> audio stream. Do those buf types also support non-PCM audio streams?

Currently I use it for PCM,  but I think it can also be used for non-PCM.
So use the below name?
V4L2_BUF_TYPE_AUDIO_CAPTURE
V4L2_BUF_TYPE_AUDIO_PLAYBACK

>
> > > +      - Buffer for audio output, see :ref:`audio`.
> > >
> > >
> > >  .. _buffer-flags:
> > > diff --git a/Documentation/userspace-api/media/v4l/dev-audio-mem2mem.=
rst b/Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
> > > new file mode 100644
> > > index 000000000000..68faecfe3a02
> > > --- /dev/null
> > > +++ b/Documentation/userspace-api/media/v4l/dev-audio-mem2mem.rst
> > > @@ -0,0 +1,71 @@
> > > +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> > > +
> > > +.. _audiomem2mem:
> > > +
> > > +********************************
> > > +Audio Memory-To-Memory Interface
> > > +********************************
> > > +
> > > +An audio memory-to-memory device can compress, decompress, transform=
, or
> > > +otherwise convert audio data from one format into another format, in=
 memory.
> > > +Such memory-to-memory devices set the ``V4L2_CAP_AUDIO_M2M`` capabil=
ity.
> > > +Examples of memory-to-memory devices are audio codecs, audio preproc=
essing,
> > > +audio postprocessing.
> > > +
> > > +A memory-to-memory audio node supports both output (sending audio fr=
ames from
> > > +memory to the hardware) and capture (receiving the processed audio f=
rames
> > > +from the hardware into memory) stream I/O. An application will have =
to
> > > +setup the stream I/O for both sides and finally call
> > > +:ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>` for both capture and output=
 to
> > > +start the hardware.
> > > +
> > > +Memory-to-memory devices function as a shared resource: you can
> > > +open the audio node multiple times, each application setting up thei=
r
> > > +own properties that are local to the file handle, and each can use
> > > +it independently from the others. The driver will arbitrate access t=
o
> > > +the hardware and reprogram it whenever another file handler gets acc=
ess.
> > > +
> > > +Audio memory-to-memory devices are accessed through character device
> > > +special files named ``/dev/v4l-audio``
> > > +
> > > +Querying Capabilities
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Device nodes supporting the audio memory-to-memory interface set the
> > > +``V4L2_CAP_AUDIO_M2M`` flag in the ``device_caps`` field of the
> > > +:c:type:`v4l2_capability` structure returned by the :c:func:`VIDIOC_=
QUERYCAP`
> > > +ioctl.
> > > +
> > > +Data Format Negotiation
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +
> > > +The audio device uses the :ref:`format` ioctls to select the capture=
 format.
> > > +The audio buffer content format is bound to that selected format. In=
 addition
> > > +to the basic :ref:`format` ioctls, the :c:func:`VIDIOC_ENUM_FMT` ioc=
tl must be
> > > +supported as well.
> > > +
> > > +To use the :ref:`format` ioctls applications set the ``type`` field =
of the
> > > +:c:type:`v4l2_format` structure to ``V4L2_BUF_TYPE_AUDIO_CAPTURE`` o=
r to
> > > +``V4L2_BUF_TYPE_AUDIO_OUTPUT``. Both drivers and applications must s=
et the
> > > +remainder of the :c:type:`v4l2_format` structure to 0.
> > > +
> > > +.. c:type:: v4l2_audio_format
> > > +
> > > +.. tabularcolumns:: |p{1.4cm}|p{2.4cm}|p{13.5cm}|
> > > +
> > > +.. flat-table:: struct v4l2_audio_format
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +    :widths:       1 1 2
> > > +
> > > +    * - __u32
> > > +      - ``pixelformat``
> > > +      - The sample format, set by the application. see :ref:`pixfmt-=
audio`
> >
> > pixelformat doesn't make any sense for audio: there are no pixels on a
> > PCM stream. Please use call it, instead: `snd_pcm_format`, making it ma=
tch
> > the values for snd_pcm_format_t.
> >
>
> +1
>
> FWIW v4l2_meta_format uses the name "dataformat".
>
> Actually, I just realized that the C code actually uses the name
> "audioformat". Tbh., after reading the kerneldoc comment, my
> subjective preference would be on "sample_format", since that's
> exactly what it is.
>
Ok, I will change it to sampleformat.

Best Regards
Shengjiu Wang

> > Yet, I would keep defining it as u32 (or u64?) instead of using a
> > typedef int field there (snd_pcm_format_t), as the size of integer
> > is different on 32 and 64 bit kernels.
>
> +1
>
> Best regards,
> Tomasz

