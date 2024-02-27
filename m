Return-Path: <linux-kernel+bounces-82507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66A868588
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D30287A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7724A21;
	Tue, 27 Feb 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cXs8LYse"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7EC1847
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996043; cv=none; b=bjCyM4Ss6Gu4dE/Bei06RGwNOWbKJ3uHhW3hDPRq7z4hLHrl46fLo5I1PcmXuup9rX0z/qKKAUghZ5aY4xTnko/6m7AvssYNIVKnPGgU1DDAj//c2jF+/Grl3WTGMTQ+GM0TTtu9uuDruIjsHVsuoQLg32zJy/pKG/ef/uUuXDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996043; c=relaxed/simple;
	bh=xlhrIQ+W/f+848er0yzcAblrCEsNA61Nvlr2TS/B7n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQOYJgukM7/Hg4mRrb/QQKHtjbNzUNX1AieyJ0il4ihrbQgqS1wpsw3q46HWlQiBWaEzh2UjKpGSn/zKo8GAAwudgZA5ThwEDv7r6dzijU8tSpTUgCdZBCG66Txfn3b1PsA3tz2ZpfKNOBHaTL1doPlfnFiN5y0k0+vRLK1npi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cXs8LYse; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51197ca63f5so5623370e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708996040; x=1709600840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlhrIQ+W/f+848er0yzcAblrCEsNA61Nvlr2TS/B7n4=;
        b=cXs8LYseEzX/FIxwW+BDKfTXS/SOcFTn8bNBwLZIJvOxry1TewdpxIgELqJMrLoVgi
         bEa4NMZR+HfRJ4gEeL5MSXKbAC6ltGWOR26E5goJY5282kXiCm4BQ0x/r0BJgxT8aS83
         wYVe6PC9wHVUfDfKRcPzhs84UeG+K+GGYPgsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708996040; x=1709600840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlhrIQ+W/f+848er0yzcAblrCEsNA61Nvlr2TS/B7n4=;
        b=jWpJ7AvyPGuMgXBalDwsMgIYKxnYlw9j4jMLb6Ejg1Fyh/sl+1a2YIjAZB/dDCYDUr
         sNpDDxMD78FbOxLPOqXSLW6ciC7PwkdGn4fXW5zsydJfr4Isxgd8OkbkzLttd1xTsC9W
         F2wLEg7QaIuMgdjW8rdgBlj2uq8xAtdPxinKIKGaeR1lSSVvFHDzVy8iWUfYEdR+C4F/
         okWqNnktt1FKzpHLu6zz2DdI66hxABy9LUpjfi5vZXyrFvWteDfyDFHD/7BMm4IxTUyR
         SCteogdENfnnpzqYJjb1Z8pcZ3egHl/WJySgYNyfaMQUCxJKTGeO+1Pz8VV743pX9agR
         a1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXfGvPaenan6G9J/qPSwx3lchPPNxw/wdtsXM11uPfhKEGky+6z+2+QBb4eYWfx8NqaODtSMEsY99xC9Y2Ir+hbp9Q/vytqDcvaACy4
X-Gm-Message-State: AOJu0Yx+d9bZqZjsF/LKQ+1Z+RQezzm+rjKN2macznpqlOzJEv1GJjc4
	rL7sETvMNkfmtcT0BuZfgMYpiG/FKzQx+Uwo2ew3e+eOwhW7xbXIneL1tiObkVlIpz5V4jN8Rll
	4Ocm8
X-Google-Smtp-Source: AGHT+IGmhfnrZhfJ1xCOqQh1hVOm7IDVEwETvcsgXPoGBXiiO0Sam/2uVEZJ/8YK1/UaKUqLR1Jogw==
X-Received: by 2002:a17:906:a893:b0:a43:9780:9492 with SMTP id ha19-20020a170906a89300b00a4397809492mr819788ejb.5.1708995626462;
        Mon, 26 Feb 2024 17:00:26 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00a3f9949743dsm237410ejb.209.2024.02.26.17.00.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 17:00:25 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so2509a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:00:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXl8CuBi3dMXfWz99TEYD97bsz4fxJEoRwizVfmAxGZPq19mvqJ1//fK0mvNwSe7mApqLsMi3mTa3U11b9DOkz32lz1HIZGGJSbCCu
X-Received: by 2002:a50:d650:0:b0:566:1390:6329 with SMTP id
 c16-20020a50d650000000b0056613906329mr59190edj.1.1708995625011; Mon, 26 Feb
 2024 17:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
In-Reply-To: <CAA8EJpre_HOY1xzOZPv5gPiJ-kEZEJiEm8oyYzXTiPj66vY8aw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 17:00:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WjZZfHBdMVG3R_iT9bskP3AyHrRsSK6Hfw9h4tEZBHFg@mail.gmail.com>
Message-ID: <CAD=FV=WjZZfHBdMVG3R_iT9bskP3AyHrRsSK6Hfw9h4tEZBHFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Match panel hash for overridden mode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 4:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 24 Feb 2024 at 00:40, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: Ad=
d
> > auo_b116xa3_mode""). It's found that 2 different AUO panels use the sam=
e
> > product id. One of them requires an overridden mode, while the other sh=
ould
> > use the mode directly from edid.
> >
> > Since product id match is no longer sufficient, EDP_PANEL_ENTRY2 is ext=
ended
> > to check the crc hash of the entire edid base block.
>
> Do you have these EDIDs posted somewhere? Can we use something less
> cryptic than hash for matching the panel, e.g. strings from Monitor
> Descriptors?

We could try it if need be. I guess I'm worried that if panel vendors
ended up re-using the panel ID for two different panels that they
might also re-use the name field too. Hashing the majority of the
descriptor's base block makes us more likely not to mix two panels up.
In general it feels like the goal is that if there is any doubt that
we shouldn't override the mode and including more fields in the hash
works towards that goal.

I guess one thing that might help would be to make it a policy that
any time a panel is added to this list that a full EDID is included in
the commit message. That would mean that if we ever needed to change
things we could. What do you think?

That being said, if everyone thinks that the "name" field is enough,
we could do it. I think that in the one case that we ran into it would
have been enough...

-Doug

