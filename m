Return-Path: <linux-kernel+bounces-64783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F78542C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3272850BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D221173A;
	Wed, 14 Feb 2024 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJ2ziGb9"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5631111B9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891922; cv=none; b=UkmQSatULgy16Md0uexFHp31fc+dS83n5zY4P8yBEFkFrH1sHS2FMqFpKRcJpn9eM9CMVdP0uZonsQYpr0jX1gAXTNP8JpPA2D8CWmfUWArRtwcZQVp9PkNPjgAUL6ZbjXrhKBwu0BSUTPSr5ET2UYq0VC+rgygy6gcC875dgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891922; c=relaxed/simple;
	bh=Zk9sRCx+9BNoM+6Eq3/gA3Qz9FrB5sZfIr456q3kBGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTGuYac0Avg0uVZf7Gi0r86GlibV3N6wN4J57NPDhaVGG/0cnNX30Ht3hi54JnD+obaf8nab2QUGw1RALSU3N2wCZXO1i+qkOEOTYHMnP7dufwQs2bn6tP3gka3LHJnTlWeCQSwhBfsdhoCPxOT97CdYfVmUlleNgCp92wAkrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DJ2ziGb9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2e58feaefso756822a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707891919; x=1708496719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf0JaDe/v/whRIZd8Ld92JiQKoN/oDT7LT2E1YHg6KQ=;
        b=DJ2ziGb9KhvBvUADoBAz0EJ6WoAUneC5lxM6kRlAyUrd2v+3IWm4RBtVam2crmm4tM
         E+xggxNL9l27r2KuyIUu4mlJntQtks8zxQGwKBvKAeHZbpV+VELRMKopo2N5Y66DZiEc
         xaD6xFBiITk52P8WDSQTZ0Iedicj40g6FhSlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891919; x=1708496719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wf0JaDe/v/whRIZd8Ld92JiQKoN/oDT7LT2E1YHg6KQ=;
        b=VTJfg6MpYQVRHI0F4Tah1B2/rzS/GwxpbRH++LWq/EFR8qnk+eiPatMd8dAXFMOy8j
         K9GsbD6I/Jat/uwJuX8zx8FUm4WwpiNiC8JoXrMfJ76cOzlf/jF4/9Bavl+Y2bqqTJqj
         q2ICzT9l9U+5pA63KLw9Eva3gnKYnvBLFu/MmuWr2Ov5qs7gK0G1sA6D2aO+IjfXW7GV
         Dgew7I58P5Aa/ooEFEjb8x+mK0VVr+Q1/wQIBappp6Kdf6ccTrJG+iVFz1fM486kWGZz
         R47B/APZsNurZwVdQsswPGUk350OrDGvbN4ixkL6NDjnz0N5jtYf8L6rUvlcVSJ2TWS0
         L0eg==
X-Forwarded-Encrypted: i=1; AJvYcCXe60vkGVbWCNaBDcNp9m1t95gPM9pxw8+cjH90l67/5hKxc8uAOWJa+/wHZQsAakx8G1qMqtZ8TKIpl2rtGfomWoUgM13L7I7KMU/f
X-Gm-Message-State: AOJu0Ywplkq0e884FjwLBIBxWRKYbDuFifwp5T4zMaJDCeIPuG5IQsa0
	zduDeLvPmzFMOBNK4MB2yGfgl9kVlHKn89QOGDWEZG6VcVYov+kYCl3Qo7Lnq1Yy/arRWCxWeWW
	jH6UY8Q8jv7VOUl/fxuZBpZ2Rclj7Lyix3DFE
X-Google-Smtp-Source: AGHT+IGrfJM6/ISO76awK+/6mCArsM5o8X+G8rSeUZA5OJd420Db+eZsu2zrZlV2W9LMf9Jywkeuz0wLrkg6nbQllMU=
X-Received: by 2002:a05:6830:1d87:b0:6e2:dd2e:aa20 with SMTP id
 y7-20020a0568301d8700b006e2dd2eaa20mr1865222oti.13.1707891919693; Tue, 13 Feb
 2024 22:25:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
In-Reply-To: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 14 Feb 2024 14:24:53 +0800
Message-ID: <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:
>
> If an eDP panel is not powered on then any attempts to talk to it over
> the DP AUX channel will timeout. Unfortunately these attempts may be
> quite slow. Userspace can initiate these attempts either via a
> /dev/drm_dp_auxN device or via the created i2c device.
>
> Making the DP AUX drivers timeout faster is a difficult proposition.
> In theory we could just poll the panel's HPD line in the AUX transfer
> function and immediately return an error there. However, this is
> easier said than done. For one thing, there's no hard requirement to
> hook the HPD line up for eDP panels and it's OK to just delay a fixed
> amount. For another thing, the HPD line may not be fast to probe. On
> parade-ps8640 we need to wait for the bridge chip's firmware to boot
> before we can get the HPD line and this is a slow process.
>
> The fact that the transfers are taking so long to timeout is causing
> real problems. The open source fwupd daemon sometimes scans DP busses
> looking for devices whose firmware need updating. If it happens to
> scan while a panel is turned off this scan can take a long time. The
> fwupd daemon could try to be smarter and only scan when eDP panels are
> turned on, but we can also improve the behavior in the kernel.
>
> Let's let eDP panels drivers specify that a panel is turned off and
> then modify the common AUX transfer code not to attempt a transfer in
> this case.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

>
>  drivers/gpu/drm/display/drm_dp_helper.c       | 35 +++++++++++++++++++
>  drivers/gpu/drm/panel/panel-edp.c             |  3 ++
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  |  2 ++
>  include/drm/display/drm_dp_helper.h           |  6 ++++
>  4 files changed, 46 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index b1ca3a1100da..6fa705d82c8f 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -532,6 +532,15 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux=
, u8 request,
>
>         mutex_lock(&aux->hw_mutex);
>
> +       /*
> +        * If the device attached to the aux bus is powered down then the=
re's
> +        * no reason to attempt a transfer. Error out immediately.
> +        */
> +       if (aux->powered_down) {
> +               ret =3D -EBUSY;
> +               goto unlock;
> +       }
> +
>         /*
>          * The specification doesn't give any recommendation on how often=
 to
>          * retry native transactions. We used to retry 7 times like for
> @@ -599,6 +608,29 @@ int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsign=
ed int offset)
>  }
>  EXPORT_SYMBOL(drm_dp_dpcd_probe);
>
> +/**
> + * drm_dp_dpcd_set_powered() - Set whether the DP device is powered
> + * @aux: DisplayPort AUX channel; for convenience it's OK to pass NULL h=
ere
> + *       and the function will be a no-op.
> + * @powered: true if powered; false if not
> + *
> + * If the endpoint device on the DP AUX bus is known to be powered down
> + * then this function can be called to make future transfers fail immedi=
ately
> + * instead of needing to time out.
> + *
> + * If this function is never called then a device defaults to being powe=
red.
> + */
> +void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered)
> +{
> +       if (!aux)
> +               return;
> +
> +       mutex_lock(&aux->hw_mutex);
> +       aux->powered_down =3D !powered;
> +       mutex_unlock(&aux->hw_mutex);
> +}
> +EXPORT_SYMBOL(drm_dp_dpcd_set_powered);
> +
>  /**
>   * drm_dp_dpcd_read() - read a series of bytes from the DPCD
>   * @aux: DisplayPort AUX channel (SST or MST)
> @@ -1858,6 +1890,9 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adap=
ter, struct i2c_msg *msgs,
>         struct drm_dp_aux_msg msg;
>         int err =3D 0;
>
> +       if (aux->powered_down)
> +               return -EBUSY;
> +
>         dp_aux_i2c_transfer_size =3D clamp(dp_aux_i2c_transfer_size, 1, D=
P_AUX_MAX_PAYLOAD_BYTES);
>
>         memset(&msg, 0, sizeof(msg));
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 7d556b1bfa82..d2a4e514d8fd 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -413,6 +413,7 @@ static int panel_edp_suspend(struct device *dev)
>  {
>         struct panel_edp *p =3D dev_get_drvdata(dev);
>
> +       drm_dp_dpcd_set_powered(p->aux, false);
>         gpiod_set_value_cansleep(p->enable_gpio, 0);
>         regulator_disable(p->supply);
>         p->unprepared_time =3D ktime_get_boottime();
> @@ -469,6 +470,7 @@ static int panel_edp_prepare_once(struct panel_edp *p=
)
>         }
>
>         gpiod_set_value_cansleep(p->enable_gpio, 1);
> +       drm_dp_dpcd_set_powered(p->aux, true);
>
>         p->powered_on_time =3D ktime_get_boottime();
>
> @@ -507,6 +509,7 @@ static int panel_edp_prepare_once(struct panel_edp *p=
)
>         return 0;
>
>  error:
> +       drm_dp_dpcd_set_powered(p->aux, false);
>         gpiod_set_value_cansleep(p->enable_gpio, 0);
>         regulator_disable(p->supply);
>         p->unprepared_time =3D ktime_get_boottime();
> diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/g=
pu/drm/panel/panel-samsung-atna33xc20.c
> index 5703f4712d96..76c2a8f6718c 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> @@ -72,6 +72,7 @@ static int atana33xc20_suspend(struct device *dev)
>         if (p->el3_was_on)
>                 atana33xc20_wait(p->el_on3_off_time, 150);
>
> +       drm_dp_dpcd_set_powered(p->aux, false);
>         ret =3D regulator_disable(p->supply);
>         if (ret)
>                 return ret;
> @@ -93,6 +94,7 @@ static int atana33xc20_resume(struct device *dev)
>         ret =3D regulator_enable(p->supply);
>         if (ret)
>                 return ret;
> +       drm_dp_dpcd_set_powered(p->aux, true);
>         p->powered_on_time =3D ktime_get_boottime();
>
>         if (p->no_hpd) {
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/dr=
m_dp_helper.h
> index 863b2e7add29..472359a9d675 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -463,9 +463,15 @@ struct drm_dp_aux {
>          * @is_remote: Is this AUX CH actually using sideband messaging.
>          */
>         bool is_remote;
> +
> +       /**
> +        * @powered_down: If true then the remote endpoint is powered dow=
n.
> +        */
> +       bool powered_down;
>  };
>
>  int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset);
> +void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered);
>  ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
>                          void *buffer, size_t size);
>  ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
> --
> 2.43.0.594.gd9cf4e227d-goog
>

