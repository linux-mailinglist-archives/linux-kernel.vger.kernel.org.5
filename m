Return-Path: <linux-kernel+bounces-118204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6D88B5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A0297B08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFC380;
	Tue, 26 Mar 2024 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrKkmiYv"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E9179
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411670; cv=none; b=NEbP2m5uEg20yvprGD31JNE047xq/7iS34LvKeDHwb3eAl0JEwublXDimghxCkL1yeOv+rh1XzMWrWY6utuR5sZFqR4tCQX5vuWYqpI6YXWz1RD23MhVQTVk3nHb2p9n0EQVnZmV7MucTfwseQJiw33q2f617xGJ4yw+eUKvT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411670; c=relaxed/simple;
	bh=8xL+VM0Oy4/TfI1Eqh7kNO+OdcV9wQvs0/vpHoPqAt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyK2PTXvUs5jObSl50J/bXU2MYTo7nVku4eqNGjGmxDGt4sWQUpeU5POCuu1/yZ3BEeVrA9KhvsYeOXtN2QuUynVdsj5KG/WgiXCZg7XtIb+TtkXKnExHi62/WhC/01rwCsSqW+kew0C6G7ar1qoyrFLglAD2OrHqVN8jCyG3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SrKkmiYv; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6e37d33c5so327565a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711411668; x=1712016468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYeKsmV2r7g+5PcUym8Kx46wv3d2A5owIUauWGUarMM=;
        b=SrKkmiYvsOdXv4UcFPBu3ETA9Fc6W/CP9/g/19HJtbqsau4baggiSd+whZFFed68hl
         R5bEBva4SFD3E9o7+5EGtNhXDEa2LEF/PaPhBDNXPdZygUGZJdH+81qtZcVZnzU/JR3E
         IfL8YSYimGrlLsDOQALTcGVZiMajSvla9AWSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711411668; x=1712016468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYeKsmV2r7g+5PcUym8Kx46wv3d2A5owIUauWGUarMM=;
        b=SiMitpscLqVHs/WHtc/+b5JemOnOeuyPQFq+e/GmZMJZDrA9xpf/iQZcg+k6ObRVq6
         /ox78bpVgYgjhxcJ2cOItyXPnElD0ucex25Ka2riPmd6atUpIJJGi1nl3+sN8PM1L2BD
         ZtSNZ1OlhR4XIJDq9mYMUEp3IVLeFKPeh7VPo8bKa1dwKnMomDqus9IMKnTvEOPX4Sq4
         gBbZbAA/TWJ7tvt6QH450PFztWapK8WX7Ze743ZslsTJildNzlTRFZQKbs9CWFwcyb9S
         //1P2pHVtgTo1Gbtq/xmWl+NofY6jwCocRRoaDe3mEHrTPXQP+36cNLGsh2LJ0V3tMSm
         yDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSsb6NBS+Owgo1dBkFcoI6t83EbfWQG1cFZCFnL4hXKmUtUKGSzlZZa6+ytS+cbAdfp29bw5fKvhZ6Bl24s3D3YEZiVhUzgIAdapau
X-Gm-Message-State: AOJu0YwavD9Bs7zgoMOkjhzOwNZMQSPhZjKfcQ9mdiKzm4GZlju+Npaj
	bvmNm626H8jCX+gCi3zFp6sQF+pjyqp9DCB6slRtyzQnABVU22rXvUdQbtBtzb7W5XH5DKj/hiz
	dSBRyoz092HxIXo6JRLJJON7twxe4VkH3SVae
X-Google-Smtp-Source: AGHT+IHmbf8f+HuCGnIfN0RBk/EEGKt2beufnVRwM8q6gQlWevq1HJEVzWv+oy02rn1rYbfzW4qrBqrz3iKeJWhhPxQ=
X-Received: by 2002:a9d:480f:0:b0:6e6:d042:87dd with SMTP id
 c15-20020a9d480f000000b006e6d04287ddmr6743728otf.35.1711411667934; Mon, 25
 Mar 2024 17:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215631.3804796-1-dianders@chromium.org> <20240325145626.3.I552e8af0ddb1691cc0fe5d27ea3d8020e36f7006@changeid>
In-Reply-To: <20240325145626.3.I552e8af0ddb1691cc0fe5d27ea3d8020e36f7006@changeid>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 25 Mar 2024 17:07:22 -0700
Message-ID: <CAJMQK-iu6Z5kfEij1K8TdAxpCOoR3FL_gfRQMT2LS=e9o6C6qg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm-panel: If drm_panel_dp_aux_backlight() fails,
 don't fail panel probe
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Pin-yen Lin <treapking@chromium.org>, 
	Prahlad Kilambi <prahladk@google.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:
>
> If we're using the AUX channel for eDP backlight and it fails to probe
> for some reason, let's _not_ fail the panel probe.
>
> At least one case where we could fail to init the backlight is because
> of a dead or physically missing panel. As talked about in detail in
> the earlier patch in this series, ("drm/panel-edp: If we fail to
> powerup/get EDID, use conservative timings"), this can cause the
> entire system's display pipeline to fail to come up and that's
> non-ideal.
>
> If we fail to init the backlight for some transitory reason, we should
> dig in and see if there's a way to fix this (perhaps retries?). Even
> in that case, though, having a panel whose backlight is stuck at 100%
> (the default, at least in the panel Samsung ATNA33XC20 I tested) is
> better than having no panel at all.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
> If needed, I could split this into two patches: one for each of the
> two panels that use drm_panel_dp_aux_backlight(). Since they both go
> through drm-misc, though, it doesn't feel worth it.
>
>  drivers/gpu/drm/panel/panel-edp.c                | 8 +++++++-
>  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 9 +++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 607cdd6feda9..0bf66d9dd5b8 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -944,8 +944,14 @@ static int panel_edp_probe(struct device *dev, const=
 struct panel_desc *desc,
>                 err =3D drm_panel_dp_aux_backlight(&panel->base, panel->a=
ux);
>                 pm_runtime_mark_last_busy(dev);
>                 pm_runtime_put_autosuspend(dev);
> +
> +               /*
> +                * Warn if we get an error, but don't consider it fatal. =
Having
> +                * a panel where we can't control the backlight is better=
 than
> +                * no panel.
> +                */
>                 if (err)
> -                       goto err_finished_pm_runtime;
> +                       dev_warn(dev, "failed to register dp aux backligh=
t: %d\n", err);
>         }
>
>         drm_panel_add(&panel->base);
> diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/g=
pu/drm/panel/panel-samsung-atna33xc20.c
> index 9c336c71562b..6828a4f24d14 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> @@ -328,9 +328,14 @@ static int atana33xc20_probe(struct dp_aux_ep_device=
 *aux_ep)
>         ret =3D drm_panel_dp_aux_backlight(&panel->base, aux_ep->aux);
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
> +
> +       /*
> +        * Warn if we get an error, but don't consider it fatal. Having
> +        * a panel where we can't control the backlight is better than
> +        * no panel.
> +        */
>         if (ret)
> -               return dev_err_probe(dev, ret,
> -                                    "failed to register dp aux backlight=
\n");
> +               dev_warn(dev, "failed to register dp aux backlight: %d\n"=
, ret);
>
>         drm_panel_add(&panel->base);
>
> --
> 2.44.0.396.g6e790dbe36-goog
>

