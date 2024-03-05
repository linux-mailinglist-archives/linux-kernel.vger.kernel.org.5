Return-Path: <linux-kernel+bounces-92702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90F87248A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3104B2465D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A51D528;
	Tue,  5 Mar 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZLB3kwA"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777BDD27E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656914; cv=none; b=LE2959WoymLY9kK7Lbgp4Rzm1vM+Fm+ksfeNGIQqIVH1CFZX2/Q9eWWygOwE9rfgJzB38TR1V7B2CtjZt03iTvj7gPX8sWIdoNqeGM+Akpt4ftclJZAK0zuEyxH4pqEBeYiaNI/E7A9ByVuOFJdv0jSvkvjyTRJNSoX8JB45QpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656914; c=relaxed/simple;
	bh=S/EdNDlxGIv4pqNwPHcSHChbUsZW/lyMmwsUT63kN6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3yV05QEqh4Gyv2P3pz8YoOOa2XhfjKcRUFgZtn32yStF6G0ZBoRCkA6gZUg/XxCGPJ6r9oRJ96iPvxYjowwW4NXHIvj4DvPUipAYWmpIC10i0j9MqG3yrLD0OHKvHrCzQon0KYPk1tjAfQm35UEdf/AKH41DZ/Ej6y6bckc0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BZLB3kwA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so7755505a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709656909; x=1710261709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dWdOILkv04MghoL0J2bObNEGpgLHwKa8AFZCAJqUcE=;
        b=BZLB3kwAwBLv5a7FHMFLamfpBHx7aWJbbaQHWQ0kVEv3HoGulF3/plYeZJRjyIRvfq
         LjDGN0JeY8mXn4v9/uK5r4t7u7bbzoTEaVg200t4avdaT/g9nHsywqZBsp75pXVWrJGy
         6Qjz+Zf0tp5JNO+8esXh/Lo4gt7ED2iMi59hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709656909; x=1710261709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dWdOILkv04MghoL0J2bObNEGpgLHwKa8AFZCAJqUcE=;
        b=BIRJYO34UJM1aSLGVhob9y8V+pv7kC/8sqW7P8eEbY3zYEv5vyySTJUYnVUPfIGf/D
         zkwvS44iRwQ8VEaZXddbh+AQJbg8cEggKgAsEl6rHPS0MOkxmltxGbP5d7IqZqRHnTSp
         uk4CJAsKmYXuxqPySBAn888+wRUMFpthwbnYDKBtSBZz6AlzjgOoQxGpKjsyVBCisx8c
         CRI1Oz5YAYx1jCe84KH0bPGLsZFVHtP4qmOKipKRS8hruiKPFwBQ+TfoJn6beidcngpe
         KWKukAV+goQ0Q1aC18ETxcZXzY2//S4uTRhF9PleWa2RB6ah3kOjPz9P+oUJHM7h5Xau
         4lPA==
X-Forwarded-Encrypted: i=1; AJvYcCUDnoZw2TXVKS2Pst7LEZYLoF9ip6ZbIIWuB4WdHQglcsO2JCAkot8X2MObTmAN1bGsMVIVJgk2qtivNQM1Ye1X2FAFKrBN4WdeK9+V
X-Gm-Message-State: AOJu0YzkfY3PAF/rllWcG+0aHyBnw1JwaSpWk7bMuBd+g/SuTENtxcfb
	DY+vTvd5uXREjTgcjEqctq2/TTES2bn/A7DHn4iw7Xl3Jwy159ItLKHuTXggWt2Rv6vyPqvLCPY
	3ALiN
X-Google-Smtp-Source: AGHT+IEZZR4rkR5pY+ayxArkVY6G0pAsS5uyS/7JNjRHNEPV+rwnIILMaR/NQeDDromCQDV6WWZyVA==
X-Received: by 2002:a05:6402:cba:b0:565:de91:5c7e with SMTP id cn26-20020a0564020cba00b00565de915c7emr8305061edb.27.1709656909296;
        Tue, 05 Mar 2024 08:41:49 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id n14-20020a056402060e00b0056717df82d5sm3567426edv.64.2024.03.05.08.41.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:41:48 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412dd723af4so95225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:41:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNFVfDZ1UF2rzigxJl7e0BvQNxFNbkheIz0EzFuzKppbTvvPS4goFQlyy1JPbUAZJMG8GH5o7yH8PROZmEiDLAHWCgDeQy+qkGBBIy
X-Received: by 2002:a05:600c:1c90:b0:412:e426:a1a7 with SMTP id
 k16-20020a05600c1c9000b00412e426a1a7mr141737wms.1.1709656907185; Tue, 05 Mar
 2024 08:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
 <CAA8EJppQYQCGL8UCX28JwrkX7Nb4pQStboXbyaEw=T+D6F-OAQ@mail.gmail.com>
In-Reply-To: <CAA8EJppQYQCGL8UCX28JwrkX7Nb4pQStboXbyaEw=T+D6F-OAQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 5 Mar 2024 08:41:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WNCmU9wzZKvcZJH3Cr75tHBrFpfVwro9AG-Mvup7UooA@mail.gmail.com>
Message-ID: <CAD=FV=WNCmU9wzZKvcZJH3Cr75tHBrFpfVwro9AG-Mvup7UooA@mail.gmail.com>
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Sean Paul <sean@poorly.run>, Thomas Zimmermann <tzimmermann@suse.de>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 3:26=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 28 Feb 2024 at 00:19, Douglas Anderson <dianders@chromium.org> wr=
ote:
> >
> > Even though the UDL driver converts to RGB565 internally (see
> > pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> > compatibility. Let's add ARGB8888 to that list.
> >
> > This makes UDL devices work on ChromeOS again after commit
> > c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> > commit things were "working" because we'd silently treat the ARGB8888
> > that ChromeOS wanted as XRGB8888.
> >
> > Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/udl/udl_modeset.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

It's been ~a week, the fix is trivial, and according to MAINTAINERS
this driver goes through drm-misc. ...so I've applied this with
Dmitry's tag (thanks!) to drm-misc-fixes.

95bf25bb9ed5 drm/udl: Add ARGB8888 as a format

-Doug

