Return-Path: <linux-kernel+bounces-7032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03281A0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0E328C8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDF38DDF;
	Wed, 20 Dec 2023 14:08:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7038DD9;
	Wed, 20 Dec 2023 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso1445981a34.0;
        Wed, 20 Dec 2023 06:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703081290; x=1703686090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XhtQFN3mZQ/Dw8ZbAdKZYMHrSfvWlcNoVNMZmYn47s=;
        b=KJCaxSjYaT3s3lB6bUtmnp6DRV+Z7QDmaHrHYoh71pR5IAplMqstPzbTP8tsrRO5xR
         bXCsR5G+BsYjSukiTHxiCzTsX/a16opPlGzH19NTTSf1c3HG093V0JOfX3aW/NakUXzs
         wzfLpegaUCdzoB0hVT85hyufsSBxHpf1IBsFO1CkthW9KEeHXZyZi+wb+zW5+FRfP6XY
         DVLqE5wqLqYLsO3aJvz+7+wnXi8SNuDF9pzA+t2L095oJ/gUFMnYO5ONLBWYoLP0XX28
         /hea+5IjAUs0AMmJVpQp36Dat1Q266WZIisNsFPZO0Bcw33IGRAxlmtJw+sI4+hqOzN1
         2fEg==
X-Gm-Message-State: AOJu0YzxS38D7GKl4SMfK1gF+kaeGEwYH0z5nBudtHgZOGVOVWSYf7ph
	5xBY+Ff9Su34eyUIbV+vlJMumYSyeyICk+mYz4Y=
X-Google-Smtp-Source: AGHT+IFzmOJOqjqOBRB6g1dbVELMhLRT7SmkuthyUaBl0tQTEwy7ae4sETVM4yefl7ZPhZN8oi4e9LW1+P0hQXN0RH4=
X-Received: by 2002:a4a:b141:0:b0:591:c8cd:a13a with SMTP id
 e1-20020a4ab141000000b00591c8cda13amr11108064ooo.0.1703081290634; Wed, 20 Dec
 2023 06:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206113138.3576492-1-lukasz.luba@arm.com> <20231206113138.3576492-3-lukasz.luba@arm.com>
In-Reply-To: <20231206113138.3576492-3-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:07:59 +0100
Message-ID: <CAJZ5v0jSt87KXB0HPXhc+T05K0FgQNKzrNVj4NqYJ+a_WCJbWw@mail.gmail.com>
Subject: Re: [PATCH 2/5] thermal: gov_power_allocator: Refactor check_power_actors()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:30=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Refactor check_power_actors() to make it possible for re-use in the
> upcoming new callback.

I would say "In preparation for a subsequent change, rearrange
check_power_actors()".
>
> No intentional functional impact.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 785fff14223d..38e1e89ba10c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -581,8 +581,9 @@ static void allow_maximum_power(struct thermal_zone_d=
evice *tz, bool update)
>   * power actor API. The warning should help to investigate the issue, wh=
ich
>   * could be e.g. lack of Energy Model for a given device.
>   *
> - * Return: 0 on success, -EINVAL if any cooling device does not implemen=
t
> - * the power actor API.
> + * Return number of cooling devices or -EINVAL if any cooling device doe=
s not
> + * implement the power actor API. Return value 0 is also valid since coo=
ling
> + * devices might be attached later.

I would say "If all of the cooling devices currently attached to @tz
implement the power actor API, return the number of them (which may be
0, because some cooling devices may be attached later).  Otherwise,
return -EINVAL."

>   */
>  static int check_power_actors(struct thermal_zone_device *tz,
>                               struct power_allocator_params *params)
> @@ -597,8 +598,9 @@ static int check_power_actors(struct thermal_zone_dev=
ice *tz,
>                 if (!cdev_is_power_actor(instance->cdev)) {
>                         dev_warn(&tz->device, "power_allocator: %s is not=
 a power actor\n",
>                                  instance->cdev->type);
> -                       ret =3D -EINVAL;
> +                       return -EINVAL;
>                 }
> +               ret++;
>         }
>
>         return ret;
> @@ -631,7 +633,7 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>         }
>
>         ret =3D check_power_actors(tz, params);
> -       if (ret) {
> +       if (ret < 0) {
>                 dev_warn(&tz->device, "power_allocator: binding failed\n"=
);
>                 kfree(params);
>                 return ret;
> --

