Return-Path: <linux-kernel+bounces-94834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39348745B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D97CB211C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8564C97;
	Thu,  7 Mar 2024 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/udQcMt"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4F441F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775578; cv=none; b=vBWxo6EET2L0hZrTwHJcnPdepK42yXyW4c8qMw/CVhdEJQifV+LhVrobIy3WveWWbCvSH5z+Cq/hriu2N5+swsPeKNkb3Ul1gJCZFuX+kC8cIeitT2eibGtMPKoEHt5O8T0k3uQj2gI1+7jr+mZL1sjEne7tuXBWf1Ui5M5NmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775578; c=relaxed/simple;
	bh=ZiOZIBlTnrRuWu1vi5UFZ2Jy/cNQDCwLFkpzJcYZkQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJgs4OeOnsSenHBmPQCzWUyvlHkHkJPWxxLQWSeAAD9EnTc5EIUJ5L93I4OBgXtkiU4wRsxzxoMXjL9XU1rjbyp2gzXVlbAh2rXW2bRES48M22ammF0o0rPFibTtkQ8CLuuOHEtzoKGh1fjqk2C0a9M0W3bQjy8NyoE+PXOJ4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/udQcMt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d382a78c38so2860881fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709775575; x=1710380375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3QXNsXc4pbyWagxE+E+WBrsLyAj39ySKirLt5REkOI=;
        b=a/udQcMtEuYimvBdAUFmNpWGQU0QN9nx7QUwzErwNJvfhy/DWh4KbHWGTMqkS4QEIl
         iMZb3P6NvE5IFFyhXW4N7WAV2dLvOmc/6XAtE6HrZfJM/MMvpXVXCRKmPM/HN+MuL7BG
         FdQPTS/vMKlc+lH41511KwzBh6VFSDVQSIU8MmGrlg6Fd7WeZvaEGPeYsZ739H0tsvSm
         TXGy/k7ckYMyqr2FdSFhDndb5ogqEPEizE5BBmuGbQNHggAHTfD9nH2lFefM66lMa5lG
         ojXnWJwKer1Mo08C0yakUwvtlmYlYhEMgXmvXcE0oVtFTLycxBV8NjP7GmmtwbD5zOjO
         J0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709775575; x=1710380375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3QXNsXc4pbyWagxE+E+WBrsLyAj39ySKirLt5REkOI=;
        b=G+/WZW9BZjDzatv24a0HrWcBkaUP5hhGt+VdIflYyLSjpQmGOcGwp9ZpmqXO5W8Gfu
         +b4CLXQDGf692qzDL5BAk75l5Qct6VTkDLmuuT6HjAVNHMpLiQDEmHxsI9XQlwNnbQuf
         najM5WOf9/1X1q0aLthsLwTQy7uz3GS+v27enbo/Ks5DFUiHh1OCMfjSVLvy4uEQtdor
         mJbVL3OEofpJCHyXtxlFdPZ8y7z4JTDZnTYXr+hsDBP0SpwaTr51B2KfXflds/l9A67B
         A7crlF0xZoZANGT/E8vb0HQYP7NzSuGuyfrEG5prOqer3+EP17qj/QObjKWMgTHDV4E5
         SvJw==
X-Forwarded-Encrypted: i=1; AJvYcCVInTA56yCUKiSEJiYqDOFkBQ5h/zyUy5CWO8at0Z5g1n8+UDOnRZK76vfiRAGL4jPkqXB9w+oa9iW3kBoP+sE+PYKwkWmpeDQdJ02b
X-Gm-Message-State: AOJu0YzWz95RtDOzMzds+YS3ajUAkgZ/TPmE7nQ52pbmqdzaqigVAm2c
	QOTOVKaaRjuNxbayxIfY2H76XuW5AyDdhjtsoNxGCs31ypH6Gxa7yJrE+FFTi+LN4a3SOmu0xfB
	++UmxDG51lWOEAGoV60YaQTloNJo=
X-Google-Smtp-Source: AGHT+IEYEHVj3nb4kRCZcQZDkCMShKzbuAM8uVmrXcumu0XaDmz6dW4wpGa5HO7Cs3zMl+/xQvrYnakhGewj59tjVU0=
X-Received: by 2002:a2e:b615:0:b0:2d2:9a8b:f45e with SMTP id
 r21-20020a2eb615000000b002d29a8bf45emr393672ljn.14.1709775574668; Wed, 06 Mar
 2024 17:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de> <CAF6AEGs2zCP1SWPzxz4v2CU--yyEsN0+PS3dKM1nOuGyVkCpLg@mail.gmail.com>
 <ZeiGi4l1lL_fYJ69@intel.com> <CAF6AEGs1ce2xzuo3xEO+xgj+0iCi59nM8AiTwBfEhwZZ2w6Vww@mail.gmail.com>
 <Zej7HOLVOAMtWvrn@intel.com>
In-Reply-To: <Zej7HOLVOAMtWvrn@intel.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 6 Mar 2024 17:39:21 -0800
Message-ID: <CAF6AEGvp9Z5axmjwjC7iJKm3NcOg9-8eL-Z86b4ZjBbMfv0HKw@mail.gmail.com>
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 3:24=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Mar 06, 2024 at 07:37:16AM -0800, Rob Clark wrote:
> > On Wed, Mar 6, 2024 at 7:06=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Wed, Mar 06, 2024 at 06:49:15AM -0800, Rob Clark wrote:
> > > > On Wed, Mar 6, 2024 at 4:18=E2=80=AFAM Thomas Zimmermann <tzimmerma=
nn@suse.de> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > sorry that I did not see the patch before.
> > > > >
> > > > > Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> > > > > > Even though the UDL driver converts to RGB565 internally (see
> > > > > > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 fo=
r
> > > > > > compatibility. Let's add ARGB8888 to that list.
> > > > >
> > > > > We had a heated discussion about the emulation of color formats. =
It was
> > > > > decided that XRGB8888 is the only format to support; and that's o=
nly
> > > > > because legacy userspace sometimes expects it. Adding other forma=
ts to
> > > > > the list should not be done easily.
> > > >
> > > > OTOH it is fixing a kernel change that broke userspace
> > > >
> > > > > >
> > > > > > This makes UDL devices work on ChromeOS again after commit
> > > > > > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to tha=
t
> > > > > > commit things were "working" because we'd silently treat the AR=
GB8888
> > > > > > that ChromeOS wanted as XRGB8888.
> > > > >
> > > > > This problem has been caused by userspace. Why can it not be fixe=
d there?
> > > > >
> > > > > And udl is just one driver. Any other driver without ARGB8888, su=
ch as
> > > > > simpledrm or ofdrm, would be affected. Do these work?
> > > >
> > > > Probably any driver where ARGB8888 is equivalent to XRGB8888 (ie.
> > > > single primary plane, etc) should advertise both.
> > >
> > > To me that seemes likely to trick userspace developers into
> > > assuming that ARGB is always available, and then when they
> > > finally try on hardware that doesn't have ARGB it'll just
> > > fail miserably.
> >
> > I think that ship has sailed already, at least for any drivers that
> > previously silently accepted ARGB8888
>
> Perhaps. Although I don't actually understand what kind of weird
> userspace people are running if it somehow expects ARGB to be there,
> but only for some specific kms drivers. Is said userspace really
> somehow checking which kms driver is present and then just ignoring
> the pixel format list exposed by the driver? Or is it just some
> super hw specific thing where they can just assume a specific kms
> driver?

I think chrome compositor (as in CrOS) always just picks ARGB8888
because, on devices that support overlays/underlays, it will use
underlays in some cases.  Yes, lazy, and a userspace bug.  But this
worked previously until commit c91acda3a380 ("drm/gem: Check for valid
formats"), so it seems to me like a clear case of kernel breaking
userspace.  I don't think we really have a choice other than to allow
ARGB8888.

A lot of drivers like simpledrm will never encounter the chrome
compositor, so it is ofc an option to leave them as-is until someone
reports a regression, which is maybe unlikely.  I suppose udl is a
special case because it can show up anywhere.

BR,
-R

> Anyways, adding ARGB to even more drivers seems like a terrible
> idea to me.
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

