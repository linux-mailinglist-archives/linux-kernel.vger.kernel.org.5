Return-Path: <linux-kernel+bounces-82464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32188684FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EE81F235C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660337E;
	Tue, 27 Feb 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICUffEOI"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ECD161
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993486; cv=none; b=LH7uBjXRHTGNtZ7T50VapAC2Vsn0DXvZ8xqJLWcaSNC7TePc8f3l/I/VGfGO3WyiELG+qbCMsuleLVmZXMLiilyv8XXMT3FPo9eOxMQ99CSw8Wzl9ribfITwYayPRSMeAK+YdlBVZTz71POnr/GoWF0CHtJztbYo5wfxj87gWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993486; c=relaxed/simple;
	bh=Z3JmCULH6mtQ5aLGNesdJIBvLW9PajOrrLwSE+PIFPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc1pmC2sTdmD/O9g4xmdFz3H5zmA7G8oQ+/hmCpz3NoEH21fcLfm2uSV2tvOQUMeI9TYOYB4hsWT7ivoLbPWjbGqVAQkf6OPyvZQMzN5S+131vP0ik0GLN1XIygQJPaZc+9L0ycLBvWGqtdyDjdfc5GPBCXSXYM/i8D35+Wyr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICUffEOI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so1991633a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708993481; x=1709598281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3JmCULH6mtQ5aLGNesdJIBvLW9PajOrrLwSE+PIFPc=;
        b=ICUffEOIAWuA9474yZV0VQClfpZ7yoqMI8NXSr6RxsCU6pvaDArUdCH0CzxhP5jRpM
         3/tP3+0Jb8r8kCnAxo8W5wTSYdupr52IsSVT89gLmFvkR0ybNCmIrIahb/MyZ0FY75Hi
         iRSk29XsM7DUFq/tmc1KJalFJHt1XvlRjj8vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708993481; x=1709598281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3JmCULH6mtQ5aLGNesdJIBvLW9PajOrrLwSE+PIFPc=;
        b=EkjXZeGFR9j99U73OcNJidYT0PwgdSXY+KpOhwpqbWYUNEBEuQdfb5uuq5Qhp0j1Zw
         qsaeDo0+ViVbUgDv452ke7WfHqEJdP94JN6PbUqULBNeNknkoqEIT4otIVW69yBi7cYu
         lvydYVkDnZTJ1RgtQwXyc/SDAoKYBD8xm6l47NQJBptdLbI65bzztxB4Y91Lf3mJhEqX
         cjP+FQE1hC2BqywV7XPgsn6/1DBjX53NSikepIz+z+xwxAtAj3ncnYWBFHx4ozjRWe3z
         tPIGXTHkLuqvVTF1PWt0DLTQdTkJf3UjSkkuldEcJ/f+kqsTNykgu0gZUiSOMERy+K/v
         F0DA==
X-Forwarded-Encrypted: i=1; AJvYcCWb0UfXRruWZCG2fUXBZhIU2mh7tVgP+HaC9zZmXCYORmvoxjBriSVMTklSeyoc8D4Ku3WXTypPc6rmHZOLAdO/Yx0Di4n2F3cMRHYo
X-Gm-Message-State: AOJu0YxO6aKraO/cos3cAZw10fQCo9OcR09AVcvwpHW8czUiSWOE7CXS
	S9WLSsxWY1mbEGiyZf6hCVqZ4ZlV0TUwZ3wcFw9f6KtQE+abxADevu3JwU9kYmCK4bKDHkBm10K
	fQF9+
X-Google-Smtp-Source: AGHT+IEvzJLdkZ/reHURqn9Dt5EdTOsjPbRSC3g0xr+LS/8DsS2hmFGtbrrM7IWCUlJsYPwndYUMyA==
X-Received: by 2002:a05:6402:28d:b0:565:b456:4357 with SMTP id l13-20020a056402028d00b00565b4564357mr4209841edv.20.1708993481068;
        Mon, 26 Feb 2024 16:24:41 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id eo5-20020a056402530500b00564fa936b2bsm223255edb.94.2024.02.26.16.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 16:24:40 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so21785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:24:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2rmPdHSOqziwk2Np35ViNftel1J0x4wrgPtzSQmJUApsRN+XTQw8rQ+YoWA2OLI1dGuzmNSqtQN3KfbdPmCuWJXp1TQAM7sQBe3cy
X-Received: by 2002:a05:600c:a017:b0:412:ad68:f73e with SMTP id
 jg23-20020a05600ca01700b00412ad68f73emr8676wmb.1.1708993479487; Mon, 26 Feb
 2024 16:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-3-hsinyi@chromium.org>
 <CAD=FV=Xs4V7ei4NW0T0x0Bq6_dQF6sZKvFSy2WGQFQsHae=61Q@mail.gmail.com> <CAJMQK-jKuA_2Y+rQ5q4MkbmkQFJh4+DC98GhExuVt39DTfBwsg@mail.gmail.com>
In-Reply-To: <CAJMQK-jKuA_2Y+rQ5q4MkbmkQFJh4+DC98GhExuVt39DTfBwsg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 16:24:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYLgFUhmvNdLe8JgQzNKrb=TDyE1qj-AgU6Z8DH9WcZw@mail.gmail.com>
Message-ID: <CAD=FV=WYLgFUhmvNdLe8JgQzNKrb=TDyE1qj-AgU6Z8DH9WcZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: panel-edp: Match with panel hash for
 overridden modes
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 2:39=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Mon, Feb 26, 2024 at 2:29=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Feb 23, 2024 at 2:40=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.o=
rg> wrote:
> > >
> > > It's found that some panels have variants that they share the same pa=
nel id
> > > although their EDID and names are different. One of the variants requ=
ires
> > > using overridden modes to resolve glitching issue as described in com=
mit
> > > 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode"). Other variants =
should
> > > use the modes parsed from EDID.
> > >
> > > For example, AUO 0x405c B116XAK01.0, it has at least 2 different vari=
ants
> > > that EDID and panel name are different, but using the same panel id. =
One of
> > > the variants require using overridden mode. Same case for AUO 0x615c
> > > B116XAN06.1.
> > >
> > > Add such entries and use the hash of the EDID to match the panel need=
s the
> > > overridden modes.
> >
> > As pointed out in an offline discussion, it's possible that we might
> > want to "ignore" some of these bytes for the purpose of the CRC.
> > Specifically, we might want to ignore:
> > * byte 16 - Week of manufacture
> > * byte 17 - Year of manufacture
> > * byte 127 - Checksum
> >
> > That way if a manufacturer actually is updating those numbers in
> > production we can still have one hash that captures all the panels. I
> > have no idea if manufacturers actually are, but IMO the hash of the
> > rest of the base block should be sufficient to differentiate between
> > different panels anyway. It would be easy to just zero out those 3
> > bytes before computing the CRC.
> >
> > What do you think?
>
> Agreed that we can zero out these fields.

Ah, in (yet another) offline comment, someone also pointed out bytes
12-15 should also be ignored for the CRC. Those are the serial number.

-Doug

