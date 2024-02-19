Return-Path: <linux-kernel+bounces-70693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA71859B38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A581C218C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1EBE4F;
	Mon, 19 Feb 2024 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3+NIuL/"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50ABA2F;
	Mon, 19 Feb 2024 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315516; cv=none; b=UWWDvbm18t1XTOJZMnWxxsT89l44ZrPmuwirBAulsaF11lsJJ1NIT1+2Rpb0N3HKhe0EAubfILM0ustkorgak5IiHsx41NCrQpCmWJoejYwbYipM6Wvj48ObjYafSOwJanO91DqyqLIRmFk9o8u+ybhHSt5S6Z+OPeThv4PUJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315516; c=relaxed/simple;
	bh=2m4ZJrrRoCw9vxAi916ZAJJ3u7pdL0JcwCVq3lUK7kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTOVUOKhdyVYEqwkIJFMe4V8kKwyNTawCaCFm2c07aiur7LCk/D+4MFBf8T1QzDZDn2nfjG4faZweD5RL3hkdGHMRcWcydPvoyHQ9HLOGs5upIZ2mezwayPxcKLRriInhWYhRrFbg8AzvN9hc5X8beLi9lsFI0PcIHQzlAjPUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3+NIuL/; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3651607db16so6586585ab.0;
        Sun, 18 Feb 2024 20:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708315513; x=1708920313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nna+GUj9CQ2WZrxvQX42Zjl9ya+Rgw72c7b/L2nye4Y=;
        b=a3+NIuL/A9eebUnl6jZ79nJm5LceNuUj0/HELPQZHXWg14xFRwXhAFo45PFFNIRes0
         2bdUqZ4zF+Aq4vuXTsPcIvUUDxaJ+nmiX06DegRWMTe+y1GM5NwtP35B4yrNgX3LdeSd
         OesOp4qrh8KDyX0XeN1bfoRC+8LKOid6vd6CM/pC+FAJTJEM5VANlxqgfHuKVoh+Wi6n
         Q5Cmx5VNtaFioob8St54JWTCmx8lh0Q8DtYtnMcWe1lCN/nbRaCRmyvOTohoDFrTmhm2
         IXcfQkrHf18NaLZ0gzcYyIktgCowoxcGRc579YrzAIc8b4W+Wg19qBsAwJxl5fp/TSjZ
         JZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708315513; x=1708920313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nna+GUj9CQ2WZrxvQX42Zjl9ya+Rgw72c7b/L2nye4Y=;
        b=P8EFj5y8K7x9/HQ0X9xODli00DD80JDkilkFIMqXGwae8OqgplqvvkF6FYTm1PbURP
         ObVCEC5SP+NPMLs7lOpjJzvAlctfYLme/5xTNXgHeCdt82/2kjH6HTo0Nplg9Jrpyd7M
         ER2oejIm62WLJBM8Rz6paCvMhAhDpRG6u3QXwUuRZyFE/ZUjasDYc8Hwr0PMIBfSo/hH
         u3GWcOhWkJQ/m5/KYO79NrmhtySUscWOz+HgxaPHRKQwPifn1wdV7p0JNa9jcohuYT6R
         OkMBlDsOZFZ2knthI91DofaQXmNGeeeKvz7GpsrheWArQIaKYo9o+4faIQJhukQQt/fh
         TmNg==
X-Forwarded-Encrypted: i=1; AJvYcCX5rhr4oX03c2d7XRZniil+0jYFqMkl2JDXXT7ypos4EQLH0NLrD2J1nHdMmw/GALWcmVaAQk4n3XBPBUZedcXuFn1WqQqJMBBPNS7s/1beUnA0yMDpZ96jyBJApwojcUrAW247pn2OMvM=
X-Gm-Message-State: AOJu0Yw0wyaHBN3GbP3CF7TC+2FD6P/D7MxlT5An5HYPutmPCBAGLGVL
	sJV9zm0+xmeC/hBOZckqQOzidE93pEA/Akkh5V8pD253ACInLIZLRtjRnuH3NINmdvpoJb41RDJ
	aEvt5Sus8F+HIuBrudRABtH8PKho=
X-Google-Smtp-Source: AGHT+IFQWSfphwrdCpDlSHfIm999z2WafX/W5AQCf8lo0hMoTfctrWBIvXyD3UbQ4B6TlRI0mbwQoS6T/QusE/aP/ng=
X-Received: by 2002:a05:6e02:1d88:b0:365:6:b56b with SMTP id
 h8-20020a056e021d8800b003650006b56bmr9547570ila.8.1708315513621; Sun, 18 Feb
 2024 20:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
 <1705581128-4604-9-git-send-email-shengjiu.wang@nxp.com> <20240217101926.3f1d2452@coco.lan>
In-Reply-To: <20240217101926.3f1d2452@coco.lan>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 19 Feb 2024 12:05:02 +0800
Message-ID: <CAA+D8APD+zL0xYkf6FxPNfM3Y3O8+PhT7WEXO7XCLAmBjoMmUA@mail.gmail.com>
Subject: Re: [PATCH v12 08/15] media: uapi: Define audio sample format fourcc type
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl, sakari.ailus@iki.fi, 
	tfiga@chromium.org, m.szyprowski@samsung.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mauro

On Sat, Feb 17, 2024 at 5:19=E2=80=AFPM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> Em Thu, 18 Jan 2024 20:32:01 +0800
> Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:
>
> > The audio sample format definition is from alsa,
> > the header file is include/uapi/sound/asound.h, but
> > don't include this header file directly, because in
> > user space, there is another copy in alsa-lib.
> > There will be conflict in userspace for include
> > videodev2.h & asound.h and asoundlib.h
> >
> > Here still use the fourcc format.
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
>
> Hmm... why can't we just use SNDRV_*_FORMAT_*? Those are already part of
> an uAPI header. No need to add any abstraction here and/or redefine
> what is there already at include/uapi/sound/asound.h.
>
Actually I try to avoid including the include/uapi/sound/asound.h.
Because in user space, there is another copy in alsa-lib (asoundlib.h).
There will be conflict in userspace when including videodev2.h and
asoundlib.h.

And in the V4l framework, the fourcc type is commonly used in other
cases (video, radio, touch, meta....), to avoid changing common code
a lot, so I think using fourcc definition for audio may be simpler.

Best regards
Shengjiu Wang

