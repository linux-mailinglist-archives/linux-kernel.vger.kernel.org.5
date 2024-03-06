Return-Path: <linux-kernel+bounces-94171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A5873AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560872814DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BEE135401;
	Wed,  6 Mar 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGbh7rcm"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBE80605
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739452; cv=none; b=qmDJzOcTSRRLV0/AODb16tU2AV2bJGnQy8r4VsTzoxjDAQ5QXwe0kVk+JsRhAx6zc11lKIrGWOJ7XPMu4D0clz6tILjJy7yB846XtyzxDiW1Dx00v/L9V01/S0bZRS3rh5GqKrknAnKC7E39zO/Ssw3D55v391kc50BjQS0eDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739452; c=relaxed/simple;
	bh=u1/Yc+IAFEUXc5d7chyPtNMhHboxhzwpw49Grb8KD50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fqs7/UVnMO2k9Ezgy3A6gIIPJmlLzsKIFvPtscUMSM9gj/toPECWitSnXvyQawdfu6BYwMhVFJd4EGpFuRjcxBg2n/wplsKvk6BddQH4obaIDqJrCRIrBSeDfGgJHnWdV1iEc0pGCr8mjdcB8XQjOcDHrbEUVJcm8tS4LUFpyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGbh7rcm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so10276753a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709739449; x=1710344249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1/Yc+IAFEUXc5d7chyPtNMhHboxhzwpw49Grb8KD50=;
        b=HGbh7rcmth7pUVDRg0RuC6VD65rdjvO2VjE7bRsS19Isj3bhW5BLFGQgCquxANmZW7
         U1jvsbx3/ONSOzyCDX5KZ4TJZTqSa1YEQvL9bAPWMJHxXBouFrsEHW2zk9BI7GBPHoxH
         ArvKRLd0jkOmhZm7vvO171LdvskYrkctkt+J+tTpPwI0+nrNn9qZsIb6mK6ZAkZ0txHS
         3YrdJ037OX+nZLq+p7C7LoIDxwYilEmhdGx2Gq6IveMLt0N0HWX1el8ze9+5uEguPhYh
         SS95y3ysWkyKcz/rQ3PNsVriGs7U969v+Y85xyi4sRuaEvo+zLqcp7JslxtGDs0sbl+9
         svIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739449; x=1710344249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1/Yc+IAFEUXc5d7chyPtNMhHboxhzwpw49Grb8KD50=;
        b=FJowzBgotrygONF5Ij9lJhqTH8GLJivrUncpAzXRXYn5NfJ63UGn9+hQgkjjGdobHO
         RsB4NhO94xM6KoGe9bjTdCwrtBD0uCVrKymterVPy5Cw/AmSH1dED3C7QLc0HdMRNlI+
         X15dNLf42ekvD/NFZ1QU5JIitvohTlfLNb+vVnXiZlwSbaqiJ++oMpy6mnCd6+MgI4Di
         D9tSt6UZ4ep+O1jyS24Ew3rBdoDpktrP1bFVW073JzMG9gB5wYVJAPBNPwZYMWOtcLqY
         FnT9fj2tz1g/GQeXBJfc1S0FPnHxkImNh0EiWYXDkOBgYUFEQ8u+5wglqr2k9KQqK9eZ
         CQAw==
X-Forwarded-Encrypted: i=1; AJvYcCVcoJhetPsUBeP4QMp7QPrPh+NXfIrwA0KbxmiOS7z5zPcFGyI0xz/qxclCvLZBKTe02KLiv72Z/ePPnHWbS/2jGjxqQOBBja9nNIES
X-Gm-Message-State: AOJu0YzHlltaO+4xgCgfJY9KdFb/o7HLY+m/V1sE6iqgaOsoW/E9fGiE
	VmMvm8f8l4qJa9aZD12wDOBgoren/1exVqpJhzJ8T28bQzNd6yWP5ZCrY2sj7brr0oTUOcuEbux
	yaAWVokbvjyqPRJWJez+LvGZSJ3SI3sU+
X-Google-Smtp-Source: AGHT+IFPBo/wgUiW7TE1+MYYfswg9itE4B5nwKJcVcwSilfEDgdHUVhvIZwW0ZUMtglS+OrSGmle1I+8sszEi1RcBKA=
X-Received: by 2002:a05:6402:c02:b0:567:e280:6411 with SMTP id
 co2-20020a0564020c0200b00567e2806411mr1467481edb.15.1709739449054; Wed, 06
 Mar 2024 07:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de> <CAF6AEGs2zCP1SWPzxz4v2CU--yyEsN0+PS3dKM1nOuGyVkCpLg@mail.gmail.com>
 <ZeiGi4l1lL_fYJ69@intel.com>
In-Reply-To: <ZeiGi4l1lL_fYJ69@intel.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 6 Mar 2024 07:37:16 -0800
Message-ID: <CAF6AEGs1ce2xzuo3xEO+xgj+0iCi59nM8AiTwBfEhwZZ2w6Vww@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 7:06=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Mar 06, 2024 at 06:49:15AM -0800, Rob Clark wrote:
> > On Wed, Mar 6, 2024 at 4:18=E2=80=AFAM Thomas Zimmermann <tzimmermann@s=
use.de> wrote:
> > >
> > > Hi,
> > >
> > > sorry that I did not see the patch before.
> > >
> > > Am 27.02.24 um 23:19 schrieb Douglas Anderson:
> > > > Even though the UDL driver converts to RGB565 internally (see
> > > > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> > > > compatibility. Let's add ARGB8888 to that list.
> > >
> > > We had a heated discussion about the emulation of color formats. It w=
as
> > > decided that XRGB8888 is the only format to support; and that's only
> > > because legacy userspace sometimes expects it. Adding other formats t=
o
> > > the list should not be done easily.
> >
> > OTOH it is fixing a kernel change that broke userspace
> >
> > > >
> > > > This makes UDL devices work on ChromeOS again after commit
> > > > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> > > > commit things were "working" because we'd silently treat the ARGB88=
88
> > > > that ChromeOS wanted as XRGB8888.
> > >
> > > This problem has been caused by userspace. Why can it not be fixed th=
ere?
> > >
> > > And udl is just one driver. Any other driver without ARGB8888, such a=
s
> > > simpledrm or ofdrm, would be affected. Do these work?
> >
> > Probably any driver where ARGB8888 is equivalent to XRGB8888 (ie.
> > single primary plane, etc) should advertise both.
>
> To me that seemes likely to trick userspace developers into
> assuming that ARGB is always available, and then when they
> finally try on hardware that doesn't have ARGB it'll just
> fail miserably.

I think that ship has sailed already, at least for any drivers that
previously silently accepted ARGB8888

BR,
-R

> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

