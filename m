Return-Path: <linux-kernel+bounces-96288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D48759C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E291C210D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561F13B7BC;
	Thu,  7 Mar 2024 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VJVtEvUY"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BC1CAAD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848016; cv=none; b=kcy8tpaDKB40fi78K9GjTsGXP/hytPF5JcBqWVgUp0STYbxj8AaZURAMWa57ZrSHROx3cYdj8uuQy5tnhwvSm92wNYQ63fwOnEJ+UDh9fxhlnuBbmBZW0FKqSW1nf6VHLBp4sUEpdtI82Md1SmcG0TgC7pLGX4iNaiTV7G4UFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848016; c=relaxed/simple;
	bh=F3j/Z7+N4PcZCKrZiW0FCtgEdoKzgCyuGNASm1A9AQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0UtB70Hq+shzRMvIpPOdWbxETGGRZ+ZmAA6MsUlEFTihy9okTlv5tBtjTm5mZOv7hlbXfkXt/1zCx4XjamirmEzpiHelMjun6uEKfbrao7b3NePNU6IxYZ2wSMflP2/qcNIDRjDMAaVcYmSC8cyEPLfKq0qIOQ2SQcYOMIhWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VJVtEvUY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68fb7928970so6254856d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709848012; x=1710452812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4K+s5sUxDYWx5pg6uBsJMOUkr+xrBl+2jFYJBWQaGY=;
        b=VJVtEvUYOMg7EjH8K+TPe81sPj0UDQvmk/MD6YegnUiPOcA8OLrd00Nm9X+Xw4ojT9
         7x6jRRiT7hnBHsZbGil7fyXfmtC5jWSsFhqAB5WAEnyT/RmdkroFh+fddg/8xMoXXnpO
         QCPmnN5yXPSuvzUY5/tqI34vc4fAHykqnSQU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709848012; x=1710452812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4K+s5sUxDYWx5pg6uBsJMOUkr+xrBl+2jFYJBWQaGY=;
        b=H79YrkiQ72Io4DR50y64aVHvdmrbOXR+IC+1n30tAn3wVkHQZkbmD84zOnFtG6vHwP
         lgnm32MtR8QvI2a7iqgMMJKhRWfRXmHrm2oYsLEpFTwywwrD6BK7YqPVOdMonuVaKpJy
         665WsTUmREu2kPTaEo8zPZ9cgR1OjsR3790Jx9CV/bmARn0DoR3RfsP0sQgvtp8IBITh
         bJ/IGeBGyvdAssYhgMUu/zzvJ42OLwA9rIcbjWJi5bAbi4ekhwFJ4g5Yvmg59fQ/29N1
         vyqdJXO3+Wy9jGbQIlD3bM00rVAMEFPpeO9wigqDVZIITjf/Pm/S7PJ+uWv0kChCt4pg
         TYhw==
X-Forwarded-Encrypted: i=1; AJvYcCVmScNejY439RGsHRuGoc1GOce+AR6UwOOqKKpLfCWD20NB21Cdbb2SLT4vHK4uW2r53PYeQEAW5F0RNnT2dFNvdi69wDNnmmfJdhV4
X-Gm-Message-State: AOJu0Yxi9hIhY3gdbl2VWtf+6K6ZALTAb04JHt8BmzNlO5l56BMvTYZy
	Q1TZw/gHyMCdxyHnnGgAAIUmKXqkUZyU7SMNUCijEbZ6p/I5oBU5HsEwThFhTcYx0oZ3Cz2c4b4
	=
X-Google-Smtp-Source: AGHT+IFV0dL39xs/9IQlosPk4fApjtul8EYvoNp11mMQ3k900vUTW9qp9nW1HaUpxL/xBXXGGa1AOA==
X-Received: by 2002:ad4:4421:0:b0:690:513e:347 with SMTP id e1-20020ad44421000000b00690513e0347mr9374274qvt.30.1709848012379;
        Thu, 07 Mar 2024 13:46:52 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id nc8-20020a0562142dc800b006907904691dsm4876487qvb.17.2024.03.07.13.46.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 13:46:51 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42f024b809cso81971cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:46:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4ZA5dDPjX8ImQVlIr+IAAyhQk6NmAy4aP03hhVBunL9l+3est6jTKtd7hmCTar6EPpGCnbTyfefhdA4ry7zm5a7/wteELHfUooRrP
X-Received: by 2002:ac8:5fd6:0:b0:42e:f79c:ca37 with SMTP id
 k22-20020ac85fd6000000b0042ef79cca37mr425362qta.18.1709848010477; Thu, 07 Mar
 2024 13:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-7-hsinyi@chromium.org>
 <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
 <87msraw4q6.fsf@intel.com> <CAJMQK-izRv18V1o7_Q23vWFXQsFgaR74xxZ4Vby0FVtNn21TMg@mail.gmail.com>
 <874jdhwzw4.fsf@intel.com>
In-Reply-To: <874jdhwzw4.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 7 Mar 2024 13:46:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UKWd743ZWOgkP4Sn_aq9ca97QygdEcS93=tcGa7r7s8g@mail.gmail.com>
Message-ID: <CAD=FV=UKWd743ZWOgkP4Sn_aq9ca97QygdEcS93=tcGa7r7s8g@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and add
 a variant
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 7, 2024 at 12:28=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 07 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > On Thu, Mar 7, 2024 at 5:28=E2=80=AFAM Jani Nikula <jani.nikula@linux.i=
ntel.com> wrote:
> >>
> >> On Wed, 06 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> >> > Hi,
> >> >
> >> > On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromiu=
m.org> wrote:
> >> >>
> >> >> @@ -1009,6 +1009,19 @@ static const struct panel_desc auo_b101ean01=
 =3D {
> >> >>         },
> >> >>  };
> >> >>
> >> >> +static const struct drm_display_mode auo_b116xa3_mode =3D {
> >> >> +       .clock =3D 70589,
> >> >> +       .hdisplay =3D 1366,
> >> >> +       .hsync_start =3D 1366 + 40,
> >> >> +       .hsync_end =3D 1366 + 40 + 40,
> >> >> +       .htotal =3D 1366 + 40 + 40 + 32,
> >> >> +       .vdisplay =3D 768,
> >> >> +       .vsync_start =3D 768 + 10,
> >> >> +       .vsync_end =3D 768 + 10 + 12,
> >> >> +       .vtotal =3D 768 + 10 + 12 + 6,
> >> >> +       .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> >> >> +};
> >> >> +
> >> >>  static const struct drm_display_mode auo_b116xak01_mode =3D {
> >> >>         .clock =3D 69300,
> >> >>         .hdisplay =3D 1366,
> >> >> @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panel=
s[] =3D {
> >> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, =
"B116XAN06.1"),
> >> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, =
"B116XTN02.5"),
> >> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, =
"B140HAN04.0"),
> >> >> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay=
, "B116XAK01.0"),
> >> >> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay=
, "B116XAN04.0"),
> >> >> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.dela=
y, "B116XAK01.0 ",
> >> >
> >> > Remove the trailing space from the string above now?
> >>
> >> Maybe it actually needs to be considered part of the name; see my othe=
r
> >> reply in the earlier patch.
> >>
> > I randomly checked 3 of the AUO panels that I had a datasheet with,
> > and all of them have a white space padding before \n.
> > The descriptor of that field is marked as "Reserved for definition",
> > unlike other characters, representing the name, which are marked with
> > "Manufacture P/N".
> >
> > For this example, do we still want to consider the white space part of
> > the name? I know they didn't follow the spec exactly.
>
> If there's one thing that's for sure, EDIDs are full of stuff like this,
> across the board.
>
> Ignoring the whitespace at the end seemed reasonable, initially, to me
> too. But the question is, if we start catering for this, what else
> should we cater for? Do we keep adding "reasonable" interpretations, or
> just go by the spec?

Personally, I don't really care a whole lot either way. If I had to
make a judgement call I think it's a little cleaner the way Hsin-Yi
has it where we ignore whitespace at the end. Given that Dmitry also
suggested ignoring whitespace at the end [1] I guess I'd believe that
he also feels it's a little cleaner that way. However, If the only way
to get the patch series landed is to put the space at the end of the
name in panel-edp.c then I'm OK with that.

In terms of what else we should cater to, I guess we'd have to answer
that question when it comes up, with a bias against adding more
special case rules. _Hopefully_ it won't be common that we even need
this code and it will be the exception rather than the rule that
panels with incompatible timings have the same panel ID anyway...

In any case, hopefully the above explains my opinion on this. If you
feel strongly that we should remove the code handling whitespace at
the end then so be it. If you're on the fence then I guess I'd say
let's keep it...


[1] https://lore.kernel.org/lkml/CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qVUz=
51TJeSQrA@mail.gmail.com/

