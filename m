Return-Path: <linux-kernel+bounces-53004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E454849F68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1674428405F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784683A1CF;
	Mon,  5 Feb 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zz4Qxtgn"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6A39FFA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150237; cv=none; b=rr9w4xsGZNQo29JOj6gPdgRwPjilH0Ncur3xg9ihDRNtVG4pRVG3Gi3LjogKedJEScS42WdfNAlF1nF+PO6Lv7dtwJywM+dehsoQmkitTU6OU0eqjCM3mthiVkirQfWIWvf805ZBxyUp72uNNVXPDQ95hCmUguwG4YE9w4stBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150237; c=relaxed/simple;
	bh=UqFSrAEJyuKkYiecikc67XEFMHOq4AKZCrfCWi7N71c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw5zTwWXDNrms+qSFh0lUirpSKE467smHUVBH511eUhW5EQxzCaRcaMQPXqZLraxSCAtMcfxLGD4g5WOmaRlni57cHmaQz1BNFq8ZFxBlE7vh0QBA+iTbFg7T+uIdKxHyKg7trBL9xT2v+lsDBMZT+Rj6DIHxbhnLIiaOFPT2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zz4Qxtgn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3604697d63so717767566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707150232; x=1707755032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqFSrAEJyuKkYiecikc67XEFMHOq4AKZCrfCWi7N71c=;
        b=Zz4Qxtgne32Unyij+viLgPMKdVJaiyS5PKULuwrxqwdpxkgJtilGCxhm7QAeHfGS8W
         SAwgfX2/gIP+FYh3QGxUgKzmg9aWNWd8g6piswJUf4MyTywKhlmbC7VDxF/qjWTfIg9Q
         oIOflboKTYaopxIuNq2HXKk78rjE7MrlqBCl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150232; x=1707755032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqFSrAEJyuKkYiecikc67XEFMHOq4AKZCrfCWi7N71c=;
        b=lYNDBklfmvQn2FT1VRuvinXt5pC37dckWGstYtWktTMEbNLoJcw4DXLiKRj2Ab1apH
         G3zkwFdV7Rn+3EalZOMnxZMqBETIvz8/ANgnP362g3FGowrariIVW53vsmtD9z+C8d97
         20dGLp0yCSaXY7qzZ6wux+42nOn2H+9YKeJTVfEe20ckEPux5TdxzlDuYx5dDz7Kvfvp
         55JFHh5zvru4uVqvemqpadM/KA4NOHcMmD8Lngzd1w05pewx/kVCh/A7dE0DZMf/vulu
         8xiQ1IuTBwTjisdgh3nLVf3Y8KzvEHe76IhyAtIyisrIHrXNC0KObvpimJIYNGTTw9bM
         yLMQ==
X-Gm-Message-State: AOJu0YzEQTsI5GMK4GtsrhFZYovzKrXTwU1G2yk1VVYadDq5/B/hsV50
	Qqx6ahyRxyj+oEAdTV3Zfg/BI/l4Ix3R+BGlEf/JcWCYrDmtu0BUOMmmbguapPQelMGYyUHoUNv
	wJg==
X-Google-Smtp-Source: AGHT+IHTYIrSLSpQf76uCq395kGyzlqPFu3BeEnmwj+1lTmFjL61WknYjCDXeWK+m1FmJJN4/n3K+g==
X-Received: by 2002:a17:907:7ea8:b0:a37:65ce:ac47 with SMTP id qb40-20020a1709077ea800b00a3765ceac47mr5791254ejc.66.1707150231926;
        Mon, 05 Feb 2024 08:23:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+bk+Id0KIqo6ia3JrjYU34Vx3RFhAS+rPpMEv48xoAT0xIEOg+FhAlaKZym9mbyU+O48KhofBbgAIP383OToLI1MvkPWsgQKlkefU
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090603c100b00a379ef08ecbsm446eja.74.2024.02.05.08.23.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 08:23:51 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so13406a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:23:50 -0800 (PST)
X-Received: by 2002:a50:9b02:0:b0:55f:9918:dadd with SMTP id
 o2-20020a509b02000000b0055f9918daddmr272667edi.2.1707150230007; Mon, 05 Feb
 2024 08:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <87fry7dusz.fsf@intel.com>
In-Reply-To: <87fry7dusz.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Feb 2024 08:23:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XOyMDRT9dtW_mC_yQy-38oOXugFXJdOY5pkVy7DJhAJg@mail.gmail.com>
Message-ID: <CAD=FV=XOyMDRT9dtW_mC_yQy-38oOXugFXJdOY5pkVy7DJhAJg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 5, 2024 at 3:17=E2=80=AFAM Jani Nikula <jani.nikula@intel.com> =
wrote:
>
> On Fri, 02 Feb 2024, Douglas Anderson <dianders@chromium.org> wrote:
> > If an eDP panel is not powered on then any attempts to talk to it over
> > the DP AUX channel will timeout. Unfortunately these attempts may be
> > quite slow. Userspace can initiate these attempts either via a
> > /dev/drm_dp_auxN device or via the created i2c device.
> >
> > Making the DP AUX drivers timeout faster is a difficult proposition.
> > In theory we could just poll the panel's HPD line in the AUX transfer
> > function and immediately return an error there. However, this is
> > easier said than done. For one thing, there's no hard requirement to
> > hook the HPD line up for eDP panels and it's OK to just delay a fixed
> > amount. For another thing, the HPD line may not be fast to probe. On
> > parade-ps8640 we need to wait for the bridge chip's firmware to boot
> > before we can get the HPD line and this is a slow process.
> >
> > The fact that the transfers are taking so long to timeout is causing
> > real problems. The open source fwupd daemon sometimes scans DP busses
> > looking for devices whose firmware need updating. If it happens to
> > scan while a panel is turned off this scan can take a long time. The
> > fwupd daemon could try to be smarter and only scan when eDP panels are
> > turned on, but we can also improve the behavior in the kernel.
> >
> > Let's let eDP panels drivers specify that a panel is turned off and
> > then modify the common AUX transfer code not to attempt a transfer in
> > this case.
>
> I guess my question is, why not make the aux->transfer function handle
> the powered down case and return the appropriate error?

The basic problem is that the aux->transfer() function doesn't have
knowledge of the power state of the eDP panel and that's the component
whose power state matters here. The aux->transfer() function is
implemented by the DP controller driver and can't access the internal
state of the eDP panel driver.

The traditional solution here would be to use the "HPD" pin to know if
the DP device is powered and ready to accept AUX commands. That works
fine for external DP devices where HPD is mandatory, but it has issues
for eDP as talked about in my commit description. If nothing else, the
eDP spec lists "HPD" as optional. In addition to that, however, we
have additional difficulties for eDP because of the "connected but not
powered on" state that eDP panels can be in. For DP if you see HPD you
know that the device is connected+powered on. If you don't see HPD
then the device is disconnected and/or powered off. For eDP you may
power off components (like the controller / eDP panel) when the device
is still physically connected and that adds complexities.

Another possible solution someone could come up with would be to use
the DRM state of the DP controller driver and fail all AUX commands if
the DP controller isn't powered. Unfortunately this doesn't work
either. Specifically at panel probe time we need to do AUX transfers
even though the full DRM bridge isn't powered. We had many discussions
about this on the mailing lists when coming up with the generic eDP
panel driver and this is fairly well documented in the kernel-docs of
the transfer() function in "struct drm_dp_aux". As documented, an eDP
controller driver needs to return an error for transfer() if the panel
isn't powered, but nothing says that it needs to do it quickly. The
slowness is what we're trying to solve here.


> For example, the transfer hook in i915 checks whether the display is
> connected and bails out early if not.

I'm not massively familiar with the i915 code, so I'd love a pointer
to the exact code you're referring to. I took a quick look and found a
Type-C specific check in intel_dp_aux_xfer(). That doesn't help here
since we're not Type-C, though the comments do back up my argument
that the long timeouts are something worth avoiding. After that I
don't see anything obvious so I'd love a pointer.


> Having to track and set the state all over the place seems more
> complicated to me than dynamically checking where needed i.e. in the
> transfer hook.

Huh. I was actually surprised by how simple/straightforward my patch
was compared to how ugly I thought it was going to be. I guess it's
just a different perspective? Specifically it can be noted that there
aren't many distinct eDP panel drivers out there since all but one of
them was able to use the generic "panel-edp.c". However, there are
quite a number of eDP controller drivers, especially considering all
the bridge chips out there. That means that this short patch means we
don't need to add weird logic/hacks to all of the eDP controller
drivers...

-Doug

