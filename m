Return-Path: <linux-kernel+bounces-7104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EEF81A1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3039287886
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9159C3FE30;
	Wed, 20 Dec 2023 14:59:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223F3D995;
	Wed, 20 Dec 2023 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-593f89bf864so53441eaf.0;
        Wed, 20 Dec 2023 06:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703084369; x=1703689169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yNUQQhDlXSA+kKL1RX6n67yltVo/o8uP8xR+J+8NcY=;
        b=PHYObc5CP82aP6WZ/h+iSMh5CGRT1+6QeMbjT+1NZOC9LC63ZyIYG/IB+HMPTxd3d0
         ZuVUHxYZb/BxHpZ+UZavX8gN94WSIy5d/7NeCZjeO3ZvdOqmhRbBwddYUojZaIlNJRZ5
         jo72EYl3zbQ2Hm+ECj+NLm5fwFKN0K34KwJtbRA/Gw6sHile5cRANIrMRvC0jQQ/YlC1
         82jUaz+GABvqU+Wm4OFawP8wH3y1iDiU6oaKicxgnL+HvTwvpOVkN8PAfZ0m0Mm8IJ9O
         9gN4S1kvNLW7ZpoAu5Nzf+i8lNVht+tCKP8ZwXlNPHZv+8Tp+Rge0Z2u/Or1ViO50lSv
         Zamg==
X-Gm-Message-State: AOJu0YxErR4tDNTtjmyLPqE9ppfadUSOT7inbHjDUrlTE8iVBJ3bVtP5
	QJewyhIYGNp4ovv48a942WOQs8uwq1e9jxyBLqg=
X-Google-Smtp-Source: AGHT+IHM9nCIiTqcx9cJxfipU54xJjpnbbOY7dx9pugg82tx0WUCqHA0EyP3NhgSMEcjqRK3Zq/SFNoUl721JRu/wzU=
X-Received: by 2002:a05:6820:258a:b0:593:e53b:2df1 with SMTP id
 cs10-20020a056820258a00b00593e53b2df1mr4696049oob.1.1703084368940; Wed, 20
 Dec 2023 06:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-9-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-9-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:59:17 +0100
Message-ID: <CAJZ5v0gEFNhPYh8MdG6JPaXC0XggvyED+0QDuV+aLa5vASzhhA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] thermal: gov_power_allocator: Support new update
 callback of weights
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> When the thermal instance's weight is updated from the sysfs the governor
> update_tz() callback is triggered. Implement proper reaction to this
> event in the IPA, which would save CPU cycles spent in throttle().
> This will speed-up the main throttle() IPA function and clean it up
> a bit.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 574aa5822112..a9f1549e6355 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -61,6 +61,7 @@ static inline s64 div_frac(s64 x, s64 y)
>   *                     @trip_switch_on should be NULL.
>   * @trip_max:          last passive trip point of the thermal zone. The
>   *                     temperature we are controlling for.
> + * @total_weight:      Sum of all thermal instances weights
>   * @num_actors:                number of cooling devices supporting IPA =
callbacks
>   * @buffer_size:       IPA internal buffer size
>   * @req_power:         IPA buffer for requested power
> @@ -76,6 +77,7 @@ struct power_allocator_params {
>         u32 sustainable_power;
>         const struct thermal_trip *trip_switch_on;
>         const struct thermal_trip *trip_max;
> +       int total_weight;
>         int num_actors;
>         int buffer_size;
>         u32 *req_power;
> @@ -403,16 +405,11 @@ static int allocate_power(struct thermal_zone_devic=
e *tz, int control_temp)
>         u32 total_req_power =3D 0;
>         u32 *weighted_req_power;
>         u32 power_range, weight;
> -       int total_weight =3D 0;
>         int i =3D 0;
>
>         if (!params->num_actors)
>                 return -ENODEV;
>
> -       list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> -               if (power_actor_is_valid(params, instance))
> -                       total_weight +=3D instance->weight;
> -
>         /* Clean all buffers for new power estimations */
>         memset(params->req_power, 0, params->buffer_size);
>
> @@ -430,7 +427,7 @@ static int allocate_power(struct thermal_zone_device =
*tz, int control_temp)
>                 if (cdev->ops->get_requested_power(cdev, &req_power[i]))
>                         continue;
>
> -               if (!total_weight)
> +               if (!params->total_weight)
>                         weight =3D 1 << FRAC_BITS;
>                 else
>                         weight =3D instance->weight;
> @@ -666,6 +663,12 @@ static void power_allocator_update_tz(struct thermal=
_zone_device *tz,
>
>                 allocate_actors_buffer(params, num_actors);
>                 break;
> +       case THERMAL_INSTANCE_WEIGHT_UPDATE:
> +               params->total_weight =3D 0;
> +               list_for_each_entry(instance, &tz->thermal_instances, tz_=
node)
> +                       if (power_actor_is_valid(params, instance))
> +                               params->total_weight +=3D instance->weigh=
t;
> +               break;
>         default:
>                 break;
>         }
> --

This one looks good to me, but if you decide to follow my advice from
the previous comments, it will need to be adjusted.

