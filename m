Return-Path: <linux-kernel+bounces-5486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7D818B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264EB1F231D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D71CABC;
	Tue, 19 Dec 2023 15:28:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA71CA8D;
	Tue, 19 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dba145f324so121915a34.1;
        Tue, 19 Dec 2023 07:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999697; x=1703604497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sre+LI+W6QWsnQNZB46uGl5A6pwBOuO9p4bcr4P12SI=;
        b=kaiHlnQCPGWHwUPIQ0xSSf794q52drasahsvzQWMbs9SyoNoXdbsp3zzB9h7ue2022
         JpaXWZg6bkf/Qkn+ETu+SZIAEaoI3rsDRe9jTYao85nL1XrNpts/A/Vhd+6Vp2k/CyWI
         EfL58I8d2RTcDGQLl+F8rTlb8xiBUoOX+1Ad9QcoAaFC3LRXqhNcXSXSmdCXIwXVPBlX
         +ZmRyy4PI0jgHnCYAoDUnY2vsfS3slrIaGg1VI2dcKQJtsu1xebFAxQkivEQnxLbnzuR
         xeHh3ER4rtQCkJxGO3rJh9bQnYRXzHCd42oEIhhhUG3Bn2M6b8n51xrHSeTMWiEjApJJ
         cEdQ==
X-Gm-Message-State: AOJu0Yx8hTwpfUM4VSvLLNh+Knscenibs8L7bybBV4eLyD0MoSPwCuaa
	p3cU5eUhe8WB1Jmq2ennfi8Vdg6YJ+7/AISxcg4=
X-Google-Smtp-Source: AGHT+IEP1tMrH2RA5HaFvvmy6neOfN8+ldfTVuGLhK6iodrlK0Ddyukdle1J7ckPB66avvbgX6iI9+33M2DAPvVqLHA=
X-Received: by 2002:a4a:a581:0:b0:591:cdc0:f28d with SMTP id
 d1-20020a4aa581000000b00591cdc0f28dmr7563659oom.0.1702999697067; Tue, 19 Dec
 2023 07:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219082726.844508-1-wenst@chromium.org>
In-Reply-To: <20231219082726.844508-1-wenst@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 16:28:05 +0100
Message-ID: <CAJZ5v0j2LTWt-vBLuDRk3aj0nK1Rmq5Np9QmzDe=_7RGq4rFiA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Correctly free tz->tzp in thermal zone
 registration error path
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:27=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> After commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
> zone parameters structure"), the core now copies the thermal zone
> parameters structure, and frees it if an error happens during thermal
> zone device registration, or upon unregistration of the device.
>
> In the error path, if device_register() was called, then `tz` disappears
> before kfree(tz->tzp) happens, causing a NULL pointer deference crash.
>
> In my case, the error path was entered from the sbs power supply driver,
> which through the power supply core registers a thermal zone *without
> trip points* for the battery temperature sensor. This combined with
> setting the default thermal governor to "power allocator", which
> *requires* trip_max, causes the thermal zone registration to error out.
>
> The error path should handle the two cases, one where device_register
> has not happened and the kobj hasn't been reference counted, and vice
> versa where it has. The original commit tried to cover the first case,
> but fails for the second. Fix this by adding kfree(tz->tzp) before
> put_device() to cover the second case, and check if `tz` is still valid
> before calling kfree(tz->tzp) to avoid crashing in the second case.
>
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone para=
meters structure")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This includes the minimal changes to fix the crash. I suppose some other
> things in the thermal core could be reworked:
> - Don't use "power allocator" for thermal zones without trip points
> - Move some of the thermal zone cleanup code into the release function
>
>  drivers/thermal/thermal_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2415dc50c31d..e47826d82062 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1392,12 +1392,16 @@ thermal_zone_device_register_with_trips(const cha=
r *type, struct thermal_trip *t
>  unregister:
>         device_del(&tz->device);
>  release_device:
> +       /* Free tz->tzp before tz goes away. */
> +       kfree(tz->tzp);
>         put_device(&tz->device);
>         tz =3D NULL;
>  remove_id:
>         ida_free(&thermal_tz_ida, id);
>  free_tzp:
> -       kfree(tz->tzp);
> +       /* If we arrived here before device_register() was called. */
> +       if (tz)
> +               kfree(tz->tzp);
>  free_tz:
>         kfree(tz);
>         return ERR_PTR(result);
> --

Can you please test linux-next from today?  The issue addressed by
your patch should be fixed there.

