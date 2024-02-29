Return-Path: <linux-kernel+bounces-85991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0652086BE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2FF1F22E10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B262C856;
	Thu, 29 Feb 2024 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9aXcc3y"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B823C6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169478; cv=none; b=TT4HEdmYUeFiYYq7j+a1q2hRcuFrc0a6CM2+UqWhOJ0tE0j0zvYot6I4Y/tB7Ev7gmes8N1FOXx8jweEFXBDfSJt2Z0Jpip1VaM9ZF97e7KeYBM0H7sNKaEz9XLhKPRPLRzrnZrGW++XO18Qncl6NlaiVeAhRPsNuH9BeCyUlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169478; c=relaxed/simple;
	bh=hzv0ubnBLl7J3/BPI8ijVjfVpgQESpW94vrQ982GiMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg48ITfWoTq9VgBybYX3CYzWHrkwI9UatMEDWQx7mmQo8oQrWy3vVYbj0NRwhKH41CyjOlf4czrla61TVV1evrZbIFTFfB2X+UzThXRt9lJGkGp4zgd+W8uQXBt0F64t1zRVxoYEiN7pKYMbBogbHOLPr7XaYMzLuIjRdiueGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9aXcc3y; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e47498f4a2so169331a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709169475; x=1709774275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZQ76DkW7h4NA/X0r/CH+mLXIOYFICqmMAZUC0ZaMd0=;
        b=M9aXcc3y4EV5sr5Vosc9V3wC8kPgLLwDaXtP2dWYBJy7YU8ZBFvOz+rTzUJgu/iYSf
         2F+hVC+saD62QxFngE/RsTG6XowROrj/o/BPJ4/iKp3qTu9d3Ne0pbLR2JRq1p3A+4oM
         EhIarMbyP7uF6jo8w6goohPth3wW5ZMXIkqMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169475; x=1709774275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZQ76DkW7h4NA/X0r/CH+mLXIOYFICqmMAZUC0ZaMd0=;
        b=sQxmtbgl+ZR9Q5VGh14jTuqTIoTMpEFsvmKS2+W+xEhgmcxp5HWdF8KFvekH5Y7rPf
         h60xhBvTr7oWUn4BFSUL5KchF4BYL5+Xbx/XyYfwOKmWF21e0jgygcK+vyezG4QPEk3q
         TNBKHt1wpBsBBj2DF1HRw3jmrb0bqjefS8NRrLbpdbixfOm7bqN9EzyipXD0U7aJil28
         yttTBsb2L9blOVQ7KQ0tq+xsP9gj506chE0mhHUQilbCVEHTecdcqIxq+aLid/3odXI2
         EboFdEVRwoXx/Iz7yLo+Ex/ZDa/Cs10bLx6v/nB/tdubI0Iz86Ex9KELewTVvioHQPMg
         sBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZFtzvfNRgDI630kOGNEcsc7YjdTGIi2k+caNmAOeK9mzAVmu56aBLSG156fR1e7EShhwqeHFMiKBy4UHWlyeW/bAJC3lc5bkieLj
X-Gm-Message-State: AOJu0YxPVPQUTtIUTM4XdPwzCTAJbON1LJ3PIKNbXLIGXewhkrF4ULmH
	UsdTjZJ/UPcbVPEgv4yIWXYfCHRY64HnX0udPAyt87ziLYiWRVQdpe/1QYCo7uuNKokc+mJVGaK
	kCjWoZhYZ4uuX+8SUQ413ele1/Y3cT+VdjDHC
X-Google-Smtp-Source: AGHT+IHkb5TkeWTwPZcxuU3wBYJG29QOvSIqFciiMx+ydxhcAZAzMmWHvJsOvayKQsE18cYrwAxT2GSgQ+Di9rVejP0=
X-Received: by 2002:a05:6830:4da:b0:6e4:7371:33c5 with SMTP id
 s26-20020a05683004da00b006e4737133c5mr668472otd.37.1709169475655; Wed, 28 Feb
 2024 17:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-4-hsinyi@chromium.org>
 <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
 <CAJMQK-gmWHXNmxk4fWM0DEDN0kdUxVJF_D8pU_8CYCpBnd3-Ag@mail.gmail.com> <CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qVUz51TJeSQrA@mail.gmail.com>
In-Reply-To: <CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qVUz51TJeSQrA@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 28 Feb 2024 17:17:29 -0800
Message-ID: <CAJMQK-i-zvLdVRyCe=cNhsXoXASr__32Cm-xgYPw0w3F2-XaWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: panel-edp: Fix AUO 0x405c panel naming
 and add a variant
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:13=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 29 Feb 2024 at 03:05, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Wed, Feb 28, 2024 at 4:22=E2=80=AFPM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium=
org> wrote:
> > > >
> > > > There are 2 different AUO panels using the same panel id. One of th=
e
> > > > variants requires using overridden modes to resolve glitching issue=
 as
> > > > described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_m=
ode").
> > > > Other variants should use the modes parsed from EDID.
> > > >
> > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > ---
> > > > v2: new
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > The previous version of this patch that we reverted also had an
> > > override for AUO 0x615c. Is that one no longer needed?
> > >
> > >
> > > > @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panel=
s[] =3D {
> > > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, =
"B116XAN06.1"),
> > > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, =
"B116XTN02.5"),
> > > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, =
"B140HAN04.0"),
> > > > -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay=
, "B116XAK01.0"),
> > > > +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay=
, "B116XAN04.0 "),
> > > > +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.dela=
y, "B116XAK01.0 ",
> > > > +                        &auo_b116xa3_mode),
> > >
> > > The name string now has a space at the end of it. I _guess_ that's OK=
.
> > > Hmmm, but I guess you should update the kernel doc for "struct
> > > edp_panel_entry". The name field is described as "Name of this panel
> > > (for printing to logs)". Now it should include that it's also used fo=
r
> > > matching EDIDs in some cases too.
> >
> > The space here is because in the EDID, there is space at the end,
> > before 0x0a (\n).
> > Okay I will update the kernel doc to mention that the same should be
> > exactly the same as the panel name.
>
> Maybe it would be better to strip all the whitespace on the right?
>

Sounds good too.

> --
> With best wishes
> Dmitry

