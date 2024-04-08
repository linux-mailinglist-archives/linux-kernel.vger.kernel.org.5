Return-Path: <linux-kernel+bounces-134864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A089B805
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7FCB2152B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27125760;
	Mon,  8 Apr 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ishNHKJ7"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370162561D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559335; cv=none; b=BeYlrHl2x+9iUlKigwY/4qLnq2gg6i81o7Mz2YHHttme77GSCnWPecJrsr5CdSqnAgAeez+Chgk9rwrQZ5e18Dyk0MV4r8Sp4onP756Cei7IKcVQWRV2ZwxmO8WbQMGoOZFHjj8ZftJ2vBPYT2VtjHufuXz60OpvRMSIoAeEL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559335; c=relaxed/simple;
	bh=zgDAo289x0U/TZNT9NKJ1VYrGO5gX5wXQdlG/iGGklc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNO6XZ+GmY2ZQ9QURYNR1OGt8iNyIIU7qWqAf5Ube2UDYBWNLpxKXU0FlGHaD/6CbbNGSGPs3RlPrg0vosv+bI2fy3pH7YvJM1lVi8qmOUVt8ekJs4o+1CwikE1RH54Xs8JCkDXk2ZnNxtT+BpXdloMrIiebbKcDDeqxXOYMsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ishNHKJ7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78d57b9f3caso127626985a.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712559331; x=1713164131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEnBkTJmawels7rfHs4eisYW0lP9mltDK+Dnyfci/+o=;
        b=ishNHKJ77FOeIvZiwCZCAub2+s8RPQ61ALsnehgDKTPqMllp8OyAl0KUHV9VY89E6K
         Sw52C552CqcwfbOqK5hPAOh/Y6StbMrhUmtxkT6VjZT5cQayCKplBWGxvSTsVUqew2jc
         tB3x1U7iXq3OMiNVJSLJfNCQvC0OeiitSvMqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559331; x=1713164131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEnBkTJmawels7rfHs4eisYW0lP9mltDK+Dnyfci/+o=;
        b=SnXyGtuNPxfaG3/g0JnlPJEizqsDKpEJ6/PiyEUeg6J4FkxuJzC1Zg3San3qqBkloo
         g4r6/SWTQJEn40oHj0rnehvt/kO/n0HC7pS/m3jL9hrT301JuxLlLFGRPglpcYzAHzH7
         24VYSdT0gfHvNRm1ol95nXZTFgdUEmrMluLjscGnE+6EmHSmyanyO2h9pA6qT9nBH76j
         z2ABr9DYPWQRlmKdrroHGRMIdUUaZotgXhhHFccXHWm42qnkTDwbWay7f4SkGz40s9qY
         Dot6fo+AsFkvUo3bIbIcUX+ZsP4j8n8Y0zxSr/q6M9uHz1qOi9IC8ztX2s1c56Gl5SEl
         6oZw==
X-Forwarded-Encrypted: i=1; AJvYcCW9rtcqh2yvfOHH+/cBka/Huv0U1KdKPHZnzC8wEkFsSHne/1+L2hv8Rngvobi9IpttiH8dG3/iMQO2OeMz8MvRSDpcR3NaMXwS6z/h
X-Gm-Message-State: AOJu0Yw5IRqofrccuBIVAcvPTqFpyMUp7LYh4jHS8VaupzPTOJZd9f8X
	DUiNFiT78+Z5Vp0oeSbPqc2uDPnzUTbvlOWCPGuSJ8XFugRvTn72ecLhkB9NcwInbbcy7awU3JR
	q0g==
X-Google-Smtp-Source: AGHT+IFifYjzZ/VbXdJg2k03w/d2DbEamX19t+VBa7FxeJGH6Q+c1RaMXlqXd+u+YshJL4C/0rPyGA==
X-Received: by 2002:a05:622a:15d0:b0:434:bbfc:29d1 with SMTP id d16-20020a05622a15d000b00434bbfc29d1mr249582qty.36.1712559331573;
        Sun, 07 Apr 2024 23:55:31 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id b3-20020ac844c3000000b00434a165d45asm802896qto.38.2024.04.07.23.55.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:55:29 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4348110e888so192951cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:55:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeWbsnqgWaLbFMYZc6SYSTINdalck7DXkK7SWGRl2JoZP9eqo01ocTUizThmVNuBWl4F+yQ31bROjfWj8dpgmv0PhOMVtbTo5V+4hK
X-Received: by 2002:ac8:5255:0:b0:434:7929:93fd with SMTP id
 y21-20020ac85255000000b00434792993fdmr175687qtn.3.1712559329181; Sun, 07 Apr
 2024 23:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215631.3804796-1-dianders@chromium.org>
 <20240325145626.2.Ia7a55a9657b0b6aa4644fd497a0bc595a771258c@changeid> <CAJMQK-j0aCtH8KU5UiWuJbbgRLTmM4d6rkxXff1VBPsdXX2WHQ@mail.gmail.com>
In-Reply-To: <CAJMQK-j0aCtH8KU5UiWuJbbgRLTmM4d6rkxXff1VBPsdXX2WHQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 7 Apr 2024 23:55:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xwk-pQRsPkFPwD=f_WxRJvARHjt01W5xvVNdnDmp_q9A@mail.gmail.com>
Message-ID: <CAD=FV=Xwk-pQRsPkFPwD=f_WxRJvARHjt01W5xvVNdnDmp_q9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/panel-edp: If we fail to powerup/get EDID, use
 conservative timings
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Pin-yen Lin <treapking@chromium.org>, 
	Prahlad Kilambi <prahladk@google.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 5:05=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > If at boot we fail to power up the eDP panel (most often happens if
> > the eDP panel never asserts HPD to us) or if we are unable to read the
> > EDID at bootup to figure out the panel's ID then let's use the
> > conservative eDP panel powerup/powerdown timings but _not_ fail the
> > probe.
> >
> > It might seem strange to _not_ fail the probe in this case since we
> > were unable to powerup the panel and confirm it's there. However,
> > there is a reason to do this. Specifically, if we fail to probe the
> > panel then it really throws the whole display pipeline for loop. Most
> > DRM subsystems are written so that they wait until all components
> > (including the panel) have probed before they set everything up. When
> > the panel doesn't come up then this never happens. As a side effect of
> > not setting everything up then other display adapters don't get
> > initialized. As a practical example, I can see that if I open up a
> > sc7180-trogdor based Chromebook that's using the generic "edp-panel"
> > and unplug the eDP panel that it causes the _external_ DP monitor not
> > to function. This is obviously bad because it means that a device with
> > a dead eDP panel becomes e-waste when it could instead still be given
> > useful life with an external display.
> >
> > NOTES:
> > - When we fail to probe like this, boot is a bit slow because we try
> >   several times to power the panel up. This doesn't feel horrible
> >   because it'll eventually work and the retries are known to help
> >   bring some panels up.
> > - In the case where we hit the condition of failing to power up, the
> >   display will likely _never_ have a chance to work again until
> >   reboot. Once the panel-edp pm_runtime resume function fails it
> >   doesn't ever seem to retry. This is probably for the best given that
> >   we don't have any real timing/modes. eDP isn't expected to be
> >   "hotplugged" so this makes some sense.
> > - It turns out that this makes panel-edp behave more similarly for
> >   users of the generic "edp-panel" compatible string and the old fixed
> >   panel compatible string. With the old fixed panel compatible string
> >   we don't talk to the panel during probe so we'd actually behave much
> >   the same way that we'll now behave for the generic "edp-panel".
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Pushed to drm-misc-next:

ce0ff22388ab drm/panel-edp: If we fail to powerup/get EDID, use
conservative timings

