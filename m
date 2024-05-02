Return-Path: <linux-kernel+bounces-166756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648B8B9F1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528CE289F87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DB016D9D1;
	Thu,  2 May 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvpsicLv"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479C28FC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669195; cv=none; b=bvFjZle7/0rVHK55DPui2QDC4r/FxkxwfHcxzhSjfewCORs8JmYVrJ4xQMp/zzjZIGFlEG2fu1MNzZdjZnsrSkLtpa+XL5iO8Qs9dUNoTNZsJi3O4jcycdwGAB7DxbMC8L0tyMYC6cWJoRIObNmwJ79uABwtUwo99hs8yv5pU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669195; c=relaxed/simple;
	bh=yfEfgnbI/CxJ5ZrsYiF3f7UnPAi8m4tSyPA7mSTVJvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1I13Ylsxd6fLI85a+Xv52rwqIs6fl2Lrh6lIN8BJWnw5iErS10IUcM1nVYcZzusCgDyPrfFRj49QVe8jsIoKR3Q3+Kv2btIaWV0gyoNgMloiHf7dtfSK3md69tFAXxVfGmOPRTYI2flBJ3eGhZYKCX9u8ytbI95miFKc0vr9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PvpsicLv; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so19392516d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714669193; x=1715273993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfEfgnbI/CxJ5ZrsYiF3f7UnPAi8m4tSyPA7mSTVJvs=;
        b=PvpsicLvqMlOv6QQYqGqkTq5aXGswUtJvXdlRd1DATjOQ9QOacLtbO8RhDTQr09Mo3
         nQtMEs9aOxGeG+LIqjZx1Vzl58smB5LhQvgbiPp1/abFhTj4cpepG/DaYT44jHgC/zqE
         kJOyD6Fso3l6x5c/axGk4LyA3h/yJihxFwJ1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669193; x=1715273993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfEfgnbI/CxJ5ZrsYiF3f7UnPAi8m4tSyPA7mSTVJvs=;
        b=ChwnAZj4b7MVd8VwDu62cg0nqGrAL2k1QNQ41K+jSwTSG5HK+O/Dd/wRFJ1ZDr5tbq
         TRNusDIGQJPMszwILreB7Y/FQF1wIRvJlZm53Gn91fK7g9MEylvFflkbHetAHF49a9e8
         UNt8NpDQCLv8RBw7yyGPS6kVchkDDTn8Ul6eH/RjUZq43Xm14o+3UKOzTGHTsKJBFNnl
         THfCJyaPTCVnIyZW1ARRNE+SJtMmEHlg9nhcGqeYoIeSmQHCsSx2DBpiNV3zW2/gGtdR
         WitI6C+iX2m1i/SD5v3AsCY/Q5+C7FUtK4ljD9QRmtkB7dYrPzmNDnS06Kbh+XApiYqB
         3Pfw==
X-Forwarded-Encrypted: i=1; AJvYcCWDU11972MC4rpDAthNLAxjEvoiftJTEATar3/CgmPF2ug30cVW3zZridL+sedr1u3mopOlagAN5qqwBiIfAUZpWnRqlS6YEy2z1LAb
X-Gm-Message-State: AOJu0YwhpZSRApajdb+rl+5JD1AaHzmOHXCD39M77HG41dV0EswaU8wm
	tvipPkCQPwoiGtFzvLNcOnOY2HYS0jVyOlE4d5ZUOOmLz827chp69JYMnpkRDh+YX+U57uWRe5M
	=
X-Google-Smtp-Source: AGHT+IEp9nFRyycOxdmFLWAMn02CqgEalgW0PMrkHXU3PiAvbrV3bBWZjFgGLjLkzqoEHgwxDEOTEA==
X-Received: by 2002:a05:6214:240d:b0:6a0:66ad:c29 with SMTP id fv13-20020a056214240d00b006a066ad0c29mr775142qvb.10.1714669193268;
        Thu, 02 May 2024 09:59:53 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id s16-20020a0cf650000000b006a103d66c7esm490220qvm.14.2024.05.02.09.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 09:59:53 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43989e6ca42so18871cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLl+5+vKOOsUOv+1581vIoUFuA4DwjnYdJ0lveHs/eA2aF2QxLRK6XGBKXm4LH2DxrJH6hlmBkR2wbZfRNVogCOJz7OMTkYAlX2SKY
X-Received: by 2002:a05:622a:1449:b0:43a:cfd8:58e4 with SMTP id
 d75a77b69052e-43ca9f346b8mr3920991cf.12.1714669192391; Thu, 02 May 2024
 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501154251.3302887-1-dianders@chromium.org>
 <20240501084109.v3.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid> <CACRpkdb2eJWVYREhpCUoJnYeutBybBY8mic2SAUuU67MW5Hjbg@mail.gmail.com>
In-Reply-To: <CACRpkdb2eJWVYREhpCUoJnYeutBybBY8mic2SAUuU67MW5Hjbg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 May 2024 09:59:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEi8+FkKvQAXWGJDmPQ6e6ybj12xrfqi8jddBMEsNpHQ@mail.gmail.com>
Message-ID: <CAD=FV=WEi8+FkKvQAXWGJDmPQ6e6ybj12xrfqi8jddBMEsNpHQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Hsin-Yi Wang <hsinyi@google.com>, 
	Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Joel Selvaraj <jo@jsfamily.in>, lvzhaoxiong@huaqin.corp-partner.google.com, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 2, 2024 at 1:23=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Wed, May 1, 2024 at 5:43=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> > Through a cooperative effort between Hsin-Yi Wang and Dmitry
> > Baryshkov, we have realized the dev_err() in the
> > mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
> > kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
> > version of the functions that includes the print. While doing this,
> > add a bit more comments to these macros making it clear that they
> > print errors and also that they return out of _the caller's_ function.
>
> This doesn't really explain why this takes so much less space.
>
> Please add some explanation like that "the macro gets inlined
> and thus the error report string gets inlined into every call to
> mipi_dsi_dcs_write_seq() and mipi_dsi_generic_write_seq(),
> by using a call to a "chatty" function, the usage is reduced to one
> string in the chatty function and a function call at the invoking
> site".
>
> With some explanation like that +/- added in:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sure. I'll plan on not sending out a v4 (unless I need to for some
other reason) and I can just add your wording in when applying. Yell
if you want me to do something different.

-Doug

