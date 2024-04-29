Return-Path: <linux-kernel+bounces-163078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF13C8B64BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A718E2818E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8D184105;
	Mon, 29 Apr 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVgs+/c9"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8D946C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426979; cv=none; b=LJx+btGUYEu4BPQPp/XTuv2Io2dp/bUznzrqafxX/2Ox6lQ+FM3af8K4yDLcw8pLZO8Eows0uUMNcKOErEnPixWhA2bhdH+q+g9AJ13I+ETqw5iy4fTq1guHyuCpf5Ka1IyJsHvWK0dz5N1o1nn1Q38IVs/xnUR8qoj0LYJPZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426979; c=relaxed/simple;
	bh=LEQHju8fsKHtiTStMJz8A27pQpAO2tZToySraVKTxQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cnkz6JutsexcGTt650oeU8P18NnzxFz+TLscT4bOdTGCAMHxoJ7CfvxbtgCHnX5xHoJfAIPUofnjCsrtu/nrh5jCR4AAT/SIAptAv8CH4k3tO2NDmg2VRtq/CapUg+cAhyCnITyjrjYh1KNTzJlDKkgRRHgQWOi9PH+7UF7ZTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EVgs+/c9; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47c5bf7aadaso330729137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714426975; x=1715031775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqnFNN8zPFgAcPpgK4V26OF8GBtrp6I1yBRCL/sHKGw=;
        b=EVgs+/c9l8rQLuVKbhJ0R1/Efm6n/1VEVOk55htQK3Nfs61TQcjwMl5UzAfKTpN9Py
         7+gA1c9aYIocC0gq+odDrf3xj0up164mMhkF7KweJU+N6ATvD/M8jATGE5iOpBOkigPI
         N3TUTNCLbpEDb3cWr9gIzgqkfWnlA1iFTZS04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426975; x=1715031775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqnFNN8zPFgAcPpgK4V26OF8GBtrp6I1yBRCL/sHKGw=;
        b=gr1GmVN335ARxzp3T2VB9rcUvXhwWJqJIzsWOe2oI/CNbMBLNNgNzSm9hg5W2sMzMK
         8O6IGb+QT8g9meGnKGIKL7luf4MAXnKn5dWYN4aFRzXEDsEwYnYOlbk8F8dddRNzLiAs
         L8vr0Zed0iSRMfmGMbLzdllSvf2kyX0tQjkEs9rxVMUwBRAjSaKwA8BeGosLALzNC74S
         f4rg+r6cL62pN52AjDskgIeTfJsctJR0rRJC/WKBVJmPMu9oPkuVeGcQcgun6ru+bmyk
         57kTZAWcmvAp7fq+jDFnlrFemP0iGeWkVdX2zcFyqBxVSECjZ+dJM8TuPRuPNtDTS6wO
         S5+A==
X-Forwarded-Encrypted: i=1; AJvYcCWBF+7Qh0FOd0Axv8EOkRLXruGKJuXcK904Rq86H0pFSQHzQLNT5QAx+HLaOiPkUGLU5EfAbeOfzOPC5Xl/+0q707+xacJk5LCsD7ZO
X-Gm-Message-State: AOJu0YxWvRYX1vRA24NyhIQ5K0h6CdYykqr5e3xaFL/SRn5buKfWoZYp
	wUVoTs5er8cRc4BiT3HRQcPEvdCr3hIgjumLFhk1emEYKdLuUf34C/Xpxb93YZY2KIUeNwG9WDA
	=
X-Google-Smtp-Source: AGHT+IHvzB32WgWZL9mjMTT2lHFTtv+2Z/xGMUD8Ram4cUnnYc4+HTU5M21azwzmPq2xB7cDIRuHlA==
X-Received: by 2002:a05:6102:292a:b0:47c:3492:cb0 with SMTP id cz42-20020a056102292a00b0047c34920cb0mr1160946vsb.25.1714426974996;
        Mon, 29 Apr 2024 14:42:54 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id n11-20020a056214008b00b006a0d0c6ed22sm35450qvr.98.2024.04.29.14.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 14:42:54 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-436ed871225so39131cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:42:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcC2HBqAEl83A2BhnCo8fojHh8pxYps7xU51IyFGUxqmXGG4tm/mND5OAN5zxQNyBWcpiLiwsWgzYICl58Ju6xlaOKEr90jdwLMiO4
X-Received: by 2002:a05:622a:1886:b0:43a:bcee:5b7f with SMTP id
 v6-20020a05622a188600b0043abcee5b7fmr79306qtc.24.1714426973449; Mon, 29 Apr
 2024 14:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426235857.3870424-1-dianders@chromium.org>
 <20240426165839.v2.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
 <CAA8EJpog5yn5kiabJOZRipTx--onH9cepPe0dD4nA=Hm0aZS+g@mail.gmail.com> <20240427062202.GA1137299@ravnborg.org>
In-Reply-To: <20240427062202.GA1137299@ravnborg.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Apr 2024 14:42:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLoz1S+iQG6qowEGUV_oSF7tcHuXhsw3_0sn30byC0ZA@mail.gmail.com>
Message-ID: <CAD=FV=XLoz1S+iQG6qowEGUV_oSF7tcHuXhsw3_0sn30byC0ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, 
	Linus Walleij <linus.walleij@linaro.org>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Joel Selvaraj <jo@jsfamily.in>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2024 at 11:22=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wr=
ote:
>
> On Sat, Apr 27, 2024 at 04:44:33AM +0300, Dmitry Baryshkov wrote:
> > On Sat, 27 Apr 2024 at 02:59, Douglas Anderson <dianders@chromium.org> =
wrote:
> > >
> > > The mipi_dsi_dcs_write_seq() macro makes a call to
> > > mipi_dsi_dcs_write_buffer() which returns a type ssize_t. The macro
> > > then stores it in an int and checks to see if it's negative. This
> > > could theoretically be a problem if "ssize_t" is larger than "int".
> > >
> > > To see the issue, imagine that "ssize_t" is 32-bits and "int" is
> > > 16-bits, you could see a problem if there was some code out there tha=
t
> > > looked like:
> > >
> > >   mipi_dsi_dcs_write_seq(dsi, cmd, <32767 bytes as arguments>);
> > >
> > > ...since we'd get back that 32768 bytes were transferred and 32768
> > > stored in a 16-bit int would look negative.
> > >
> > > Though there are no callsites where we'd actually hit this (even if
> > > "int" was only 16-bit), it's cleaner to make the types match so let's
> > > fix it.
> > >
> > > Fixes: 2a9e9daf7523 ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq =
macro")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - New
> > >
> > >  include/drm/drm_mipi_dsi.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > > index 82b1cc434ea3..b3576be22bfa 100644
> > > --- a/include/drm/drm_mipi_dsi.h
> > > +++ b/include/drm/drm_mipi_dsi.h
> > > @@ -337,12 +337,12 @@ int mipi_dsi_dcs_get_display_brightness_large(s=
truct mipi_dsi_device *dsi,
> > >         do {                                                         =
      \
> > >                 static const u8 d[] =3D { cmd, seq };                =
        \
> > >                 struct device *dev =3D &dsi->dev;                    =
        \
> > > -               int ret;                                             =
      \
> > > +               ssize_t ret;                                         =
      \
> > >                 ret =3D mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(=
d));    \
> > >                 if (ret < 0) {                                       =
      \
> > >                         dev_err_ratelimited(                         =
      \
> > >                                 dev, "sending command %#02x failed: %=
d\n", \
> > > -                               cmd, ret);                           =
      \
> > > +                               cmd, (int)ret);                      =
      \
> >
> > Please consider using %zd instead
>
> Hi Douglas,
> please consider the above for all the pathces, there are more places
> where a cast can be dropped.

Sure, I'll change in the next version. I personally prefer the %d with
an "int" type because technically we're printing an error code and
errors are int-sized. ...but I don't feel strongly and I guess there's
a tiny chance some bug in the code could lead to a negative value
that's more useful as 64-bits than 32-bits. ;-)

I will note that I will still need a cast in some of the later patches
for "%*ph" since, I believe, the size passed for the "*" in a printf
format string is defined to be an int, not a size_t or ssize_t.

-Doug

