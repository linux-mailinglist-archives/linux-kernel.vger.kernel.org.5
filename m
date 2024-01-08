Return-Path: <linux-kernel+bounces-20140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21053827A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2821F23A46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5856478;
	Mon,  8 Jan 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z2MHaa3Z"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856F56463
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so2426678e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 14:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704751562; x=1705356362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZA6MVaxiJ2A9l409ToIFuD+Lm8QfNuypGfD4+VFQBc=;
        b=Z2MHaa3Z5mG6Oa+aIkFVSwOmG+RAYc3Qx+JOnO+ArJdo6JqpWZgic1gir4c9S9HmAm
         Z/ytWsyHoyUf9tZKwYu5+2o97VP8G9Lttl4XzF4SvGQt3V99FHWvw8kZGXQjXcOmxXVd
         Lfhyc27d8N2x1ubH+i7e0+olcNF+idmkMwnQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704751562; x=1705356362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZA6MVaxiJ2A9l409ToIFuD+Lm8QfNuypGfD4+VFQBc=;
        b=Q5wN/qB6FRTWWjkzCrmbJdNr+vwJYTiziANjst9rMQte5j9tPLTeyzLib9vMnlcXEa
         C/vWg+y3QJD/I37jyzsRwDaB39i9QGmehUtMOMnZzxN47EnfiB/UdCM1ADIAaqwRFiQS
         o7d9QPIYZdRY0/WD7iPeN6Yl2wBaV546Yd17xLv71k2ClqY8ohNLVUxi0MW2/QipUTvF
         9BxYLl3Qe2/a1GH/XLClZNLtJ7SG94Y8IoMz1mkuuVhI9zM+9ww/PakAcq82W/RUhoqk
         v7EdzofcC7JstOvWEumuCEheaEDYxa9w9I7OttmY/JqqBpTixFoJ1LxxYfbOPKYnTd1M
         MiFw==
X-Gm-Message-State: AOJu0Yx+zEzyo/KezVz5+d4Z4rtwn+HYh56V0jny2HBQ5KxN+fMJggkO
	C65eIgGN/Ym6gvDhofflnYqOAyeLF4XqGHQtUNxO57AnyI8eMfc=
X-Google-Smtp-Source: AGHT+IFlztI6azz7TG+OuQUgkKA038JKNk4tCrt1npmjDMgnawMys7zy0q9xy6zxsm5yKe4kp0tvLg==
X-Received: by 2002:a19:8c13:0:b0:50e:5a25:efbf with SMTP id o19-20020a198c13000000b0050e5a25efbfmr1582071lfd.42.1704751562458;
        Mon, 08 Jan 2024 14:06:02 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0055668ccd9a3sm257879edb.17.2024.01.08.14.06.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 14:06:02 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so1172a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 14:06:02 -0800 (PST)
X-Received: by 2002:a05:600c:444b:b0:40d:87df:92ca with SMTP id
 v11-20020a05600c444b00b0040d87df92camr1890wmn.3.1704751185061; Mon, 08 Jan
 2024 13:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221135548.1.I10f326a9305d57ad32cee7f8d9c60518c8be20fb@changeid>
 <CAEXTbpdUjCvLE+m3d1vSvsE2njRSk1Ou3bZZGEvD_7oYt4+k4Q@mail.gmail.com>
 <CAD=FV=WDb7y-9dRgb0D=VxVB6EjUkcOJ+9D0Mp0-vw6wuKUHEg@mail.gmail.com> <CAEXTbpdWPcc9==xb-_+2wY29aNdieLThmn_7JD4KV8U1LWgB2g@mail.gmail.com>
In-Reply-To: <CAEXTbpdWPcc9==xb-_+2wY29aNdieLThmn_7JD4KV8U1LWgB2g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jan 2024 13:59:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W4dkqhDbt6z=+C-pkU4HKd+NkzjRaa6P3Dxn-+cy3rCA@mail.gmail.com>
Message-ID: <CAD=FV=W4dkqhDbt6z=+C-pkU4HKd+NkzjRaa6P3Dxn-+cy3rCA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
To: Pin-yen Lin <treapking@chromium.org>
Cc: dri-devel@lists.freedesktop.org, hsinyi@chromium.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 25, 2023 at 1:08=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Dec 22, 2023 at 11:34=E2=80=AFPM Doug Anderson <dianders@chromium=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Dec 22, 2023 at 2:29=E2=80=AFAM Pin-yen Lin <treapking@chromium=
org> wrote:
> > >
> > > Hi Douglas,
> > >
> > > On Fri, Dec 22, 2023 at 5:56=E2=80=AFAM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > >
> > > > Unlike what is claimed in commit f5aa7d46b0ee ("drm/bridge:
> > > > parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux"), =
if
> > > > someone manually tries to do an AUX transfer (like via `i2cdump ${b=
us}
> > > > 0x50 i`) while the panel is off we don't just get a simple transfer
> > > > error. Instead, the whole ps8640 gets thrown for a loop and goes in=
to
> > > > a bad state.
> > > >
> > > > Let's put the function to wait for the HPD (and the magical 50 ms
> > > > after first reset) back in when we're doing an AUX transfer. This
> > > > shouldn't actually make things much slower (assuming the panel is o=
n)
> > > > because we should immediately poll and see the HPD high. Mostly thi=
s
> > > > is just an extra i2c transfer to the bridge.
> > > >
> > > > Fixes: f5aa7d46b0ee ("drm/bridge: parade-ps8640: Provide wait_hpd_a=
sserted() in struct drm_dp_aux")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/d=
rm/bridge/parade-ps8640.c
> > > > index 541e4f5afc4c..fb5e9ae9ad81 100644
> > > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > > @@ -346,6 +346,11 @@ static ssize_t ps8640_aux_transfer(struct drm_=
dp_aux *aux,
> > > >         int ret;
> > > >
> > > >         pm_runtime_get_sync(dev);
> > > > +       ret =3D _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
> > > > +       if (ret) {
> > > > +               pm_runtime_put_sync_suspend(dev);
> > > > +               return ret;
> > > > +       }
> > > >         ret =3D ps8640_aux_transfer_msg(aux, msg);
> > > >         pm_runtime_mark_last_busy(dev);
> > > >         pm_runtime_put_autosuspend(dev);
> > > > --
> > > > 2.43.0.472.g3155946c3a-goog
> > > >
> > >
> > > I think commit 9294914dd550 ("drm/bridge: parade-ps8640: Link device
> > > to ensure suspend/resume order")  is trying to address the same
> > > problem, but we see this issue here because the device link is missin=
g
> > > DL_FLAG_PM_RUNTIME. I prefer to add DL_FLAG_PM_RUNTIME here so we
> > > don't need to add a _ps8640_wait_hpd_asserted() after every
> > > pm_runtime_get_*() call.
> >
> > I disagree. We've had several discussions on the lists about this
> > topic before, though since I'm technically on vacation right now I'm
> > not going to go look them up. In general "pm_runtime" is not
> > sufficient for powering up DRM components. While DRM components can
> > use pm_runtime themselves (as we are doing here), powering up another
> > DRM component by grabbing a pm_runtime reference isn't right. There is
> > a reason for the complexity of the DRM prepare/enable and all the
> > current debates about the right order to call components in prepare()
> > just demonstrates further that a simple pm_runtime reference isn't
> > enough.
> >
> > It can be noted that, with ${SUBJECT} patch we _aren't_ powering up
> > the panel. I actually tested two cases on sc7180-lazor. In one case I
> > just closed the lid, which powered off the panel, but the touchscreen
> > kept the panel power rail on. In this case with my patch I could still
> > read the panel EDID. I then hacked the touchscreen off. Now when I
> > closed the lid I'd get a timeout. This is different than if we tried
> > to get a pm_runtime reference to the panel.
> >
> Okay, thanks for the detailed explanation. Then, let's go with the
> approach in this patch. So,
>
> Tested-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Pin-yen Lin <treapking@chromium.org>

Thanks for the tags. I've pushed this to drm-misc-fixes:

024b32db43a3 drm/bridge: parade-ps8640: Wait for HPD when doing an AUX tran=
sfer

