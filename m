Return-Path: <linux-kernel+bounces-7068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C381A134
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C88E1C22381
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25C3B7B2;
	Wed, 20 Dec 2023 14:35:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194E3B78C;
	Wed, 20 Dec 2023 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58dd5193db4so1133028eaf.1;
        Wed, 20 Dec 2023 06:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703082944; x=1703687744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNs3YbM4xU/NYj8q5cqBvYeMvRHeC/nT/8WoJ73HBXE=;
        b=Qx9MQ88Kod/5GaO+2N0POLSPkt+oOizlQMjpaVtw4fujWZvdMTSTEnRFKww138BdKE
         UGMz3scDTYLoRpCqz7K5WDJ0kI7tHRgiyrD4/OLZzjcIwu5a/0omuTpU1KiZ23bCB4My
         7srcUqRT86s53LUlglcDHWLxZAY+e7D0BF1od+30qYB/y4gijg7UMeMO5owZ1R9O9dux
         m7Gq7VeeTRIcvitwIBozT61m+ggAgsVlaUVSIsM71lues23lRnoV8KSuee45rgOLCWcR
         WVRAYLSoeuDh1PIEeltDYr0+R82CNgYSHjiLE/RJwAv0pVRgLq0jihTiDOj5zUpZ/ons
         X6Mw==
X-Gm-Message-State: AOJu0YzIj0t7MRVOkpBNASOSO39f19673Li20UkqPOnb9wh6TSYCPDto
	/x5AxZf5L0F5NNfhIJutrLIENXHRdfY6Vr0E4z0LCYmiTlw=
X-Google-Smtp-Source: AGHT+IE7/gRX+cbPHAWzR9mEXzAcgrsKKOdH701KVi9+3dOxrzfdJdC170BQkUexlaLlaaLftu8ViVXusx5M+xcYqPA=
X-Received: by 2002:a05:6820:104f:b0:594:33c:f126 with SMTP id
 x15-20020a056820104f00b00594033cf126mr1722524oot.0.1703082943845; Wed, 20 Dec
 2023 06:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-4-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-4-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:35:32 +0100
Message-ID: <CAJZ5v0j_FNhi_nzBz-n9Dk4_VBm2yiRLnkAS5btNE8cYD+trRQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] thermal: gov_power_allocator: Move memory
 allocation out of throttle()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> The new thermal callback allows to react to the change of cooling
> instances in the thermal zone. Move the memory allocation to that new
> callback and save CPU cycles in the throttle() code path.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 144 ++++++++++++++++++++------
>  1 file changed, 113 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 38e1e89ba10c..3328c3ec71f2 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -61,6 +61,13 @@ static inline s64 div_frac(s64 x, s64 y)
>   *                     @trip_switch_on should be NULL.
>   * @trip_max:          last passive trip point of the thermal zone. The
>   *                     temperature we are controlling for.
> + * @num_actors:                number of cooling devices supporting IPA =
callbacks
> + * @buffer_size:       IPA internal buffer size
> + * @req_power:         IPA buffer for requested power
> + * @max_power:         IPA buffer for max allocatable power
> + * @granted_power:     IPA buffer for granted power
> + * @extra_actor_power: IPA buffer for extra power
> + * @weighted_req_power:        IPA buffer for weighted requested power
>   */
>  struct power_allocator_params {
>         bool allocated_tzp;
> @@ -69,6 +76,13 @@ struct power_allocator_params {
>         u32 sustainable_power;
>         const struct thermal_trip *trip_switch_on;
>         const struct thermal_trip *trip_max;
> +       int num_actors;
> +       int buffer_size;

None of the above can be negative, so maybe consider using unsigned int?

> +       u32 *req_power;
> +       u32 *max_power;
> +       u32 *granted_power;
> +       u32 *extra_actor_power;
> +       u32 *weighted_req_power;
>  };
>
>  /**
> @@ -387,39 +401,24 @@ static int allocate_power(struct thermal_zone_devic=
e *tz, int control_temp)
>         u32 *weighted_req_power;
>         u32 power_range, weight;
>         int total_weight =3D 0;
> -       int num_actors =3D 0;

You could retain this local var and set it to params->num_actors.  It
is kind of inconsistent to drop it and still use the local variables
above.

>         int i =3D 0;
>
> -       list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> +       if (!params->num_actors)
> +               return -ENODEV;
> +
> +       list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>                 if ((instance->trip =3D=3D params->trip_max) &&
> -                   cdev_is_power_actor(instance->cdev)) {
> -                       num_actors++;
> +                   cdev_is_power_actor(instance->cdev))
>                         total_weight +=3D instance->weight;
> -               }
> -       }
> -
> -       if (!num_actors)
> -               return -ENODEV;
>
> -       /*
> -        * We need to allocate five arrays of the same size:
> -        * req_power, max_power, granted_power, extra_actor_power and
> -        * weighted_req_power.  They are going to be needed until this
> -        * function returns.  Allocate them all in one go to simplify
> -        * the allocation and deallocation logic.
> -        */
> -       BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*max_power));
> -       BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*granted_power));
> -       BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*extra_actor_power));
> -       BUILD_BUG_ON(sizeof(*req_power) !=3D sizeof(*weighted_req_power))=
;
> -       req_power =3D kcalloc(num_actors * 5, sizeof(*req_power), GFP_KER=
NEL);
> -       if (!req_power)
> -               return -ENOMEM;
> +       /* Clean all buffers for new power estimations */
> +       memset(params->req_power, 0, params->buffer_size);
>
> -       max_power =3D &req_power[num_actors];
> -       granted_power =3D &req_power[2 * num_actors];
> -       extra_actor_power =3D &req_power[3 * num_actors];
> -       weighted_req_power =3D &req_power[4 * num_actors];
> +       req_power =3D params->req_power;
> +       max_power =3D params->max_power;
> +       granted_power =3D params->granted_power;
> +       extra_actor_power =3D params->extra_actor_power;
> +       weighted_req_power =3D params->weighted_req_power;
>
>         list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>                 cdev =3D instance->cdev;
> @@ -453,7 +452,7 @@ static int allocate_power(struct thermal_zone_device =
*tz, int control_temp)
>
>         power_range =3D pid_controller(tz, control_temp, max_allocatable_=
power);
>
> -       divvy_up_power(weighted_req_power, max_power, num_actors,
> +       divvy_up_power(weighted_req_power, max_power, params->num_actors,
>                        total_weighted_req_power, power_range, granted_pow=
er,
>                        extra_actor_power);
>
> @@ -474,12 +473,10 @@ static int allocate_power(struct thermal_zone_devic=
e *tz, int control_temp)
>
>         trace_thermal_power_allocator(tz, req_power, total_req_power,
>                                       granted_power, total_granted_power,
> -                                     num_actors, power_range,
> +                                     params->num_actors, power_range,
>                                       max_allocatable_power, tz->temperat=
ure,
>                                       control_temp - tz->temperature);
>
> -       kfree(req_power);
> -
>         return 0;
>  }
>
> @@ -606,6 +603,81 @@ static int check_power_actors(struct thermal_zone_de=
vice *tz,
>         return ret;
>  }
>
> +static void _power_buffers_init(struct power_allocator_params *params,
> +                               u32 *req_power, u32 *max_power,
> +                               u32 *granted_power, u32 *extra_actor_powe=
r,
> +                               u32 *weighted_req_power)
> +
> +{
> +       /* Setup internal buffers for power calculations. */
> +       params->req_power =3D req_power;
> +       params->max_power =3D max_power;
> +       params->granted_power =3D granted_power;
> +       params->extra_actor_power =3D extra_actor_power;
> +       params->weighted_req_power =3D weighted_req_power;
> +}
> +
> +static int allocate_actors_buffer(struct power_allocator_params *params,
> +                                 int num_actors)
> +{
> +       u32 *req_power;
> +       int ret;
> +
> +       kfree(params->req_power);
> +
> +       /* There might be no cooling devices yet. */
> +       if (!num_actors) {
> +               ret =3D -EINVAL;
> +               goto clean_buffers;
> +       }
> +
> +       req_power =3D kcalloc(num_actors * 5, sizeof(u32), GFP_KERNEL);

I'd use sizeof(*req_power) instead of sizeof(u32) here and below.

> +       if (!req_power) {
> +               ret =3D -ENOMEM;
> +               goto clean_buffers;
> +       }
> +
> +       params->num_actors =3D num_actors;
> +       params->buffer_size =3D num_actors * 5 * sizeof(u32);
> +
> +       _power_buffers_init(params, req_power, &req_power[params->num_act=
ors],
> +                           &req_power[2 * params->num_actors],
> +                           &req_power[3 * params->num_actors],
> +                           &req_power[4 * params->num_actors]);

Why don't you use the local var in this instead of the struct member?
It would be easier to read then IMO.

Also, I would rather use pointer arithmetic, so it would become

_power_buffers_init(params, req_power, req_power + num_actors,
req_power + 2 * num_actors, req_power + 3 * num_actors, req_power + 4
* num_actors);

And note that you could introduce something like

struct power_actor {
        u32 req_power;
        u32 max_power;
        u32 granted_power;
        u32 extra_actor_power;
        u32 weighted_req_power;
};

and use a single array of these instead of 5 different arrays of u32,
which would result in more straightforward code if I'm not mistaken.

> +
> +       return 0;
> +
> +clean_buffers:
> +       params->num_actors =3D -EINVAL;
> +       params->buffer_size =3D 0;
> +       _power_buffers_init(params, NULL, NULL, NULL, NULL, NULL);
> +       return ret;
> +}
> +
> +static void power_allocator_update_tz(struct thermal_zone_device *tz,
> +                                     enum thermal_notify_event reason)
> +{
> +       struct power_allocator_params *params =3D tz->governor_data;
> +       struct thermal_instance *instance;
> +       int num_actors =3D 0;
> +
> +       switch (reason) {
> +       case THERMAL_INSTANCE_LIST_UPDATE:
> +               list_for_each_entry(instance, &tz->thermal_instances, tz_=
node)
> +                       if ((instance->trip =3D=3D params->trip_max) &&
> +                           cdev_is_power_actor(instance->cdev))
> +                               num_actors++;
> +
> +               if (num_actors =3D=3D params->num_actors)
> +                       return;
> +
> +               allocate_actors_buffer(params, num_actors);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
>  /**
>   * power_allocator_bind() - bind the power_allocator governor to a therm=
al zone
>   * @tz:        thermal zone to bind it to
> @@ -639,6 +711,13 @@ static int power_allocator_bind(struct thermal_zone_=
device *tz)
>                 return ret;
>         }
>
> +       ret =3D allocate_actors_buffer(params, ret);
> +       if (ret) {
> +               dev_warn(&tz->device, "power_allocator: allocation failed=
\n");
> +               kfree(params);
> +               return ret;
> +       }
> +
>         if (!tz->tzp) {
>                 tz->tzp =3D kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
>                 if (!tz->tzp) {
> @@ -663,6 +742,7 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>         return 0;
>
>  free_params:
> +       kfree(params->req_power);
>         kfree(params);
>
>         return ret;
> @@ -679,6 +759,7 @@ static void power_allocator_unbind(struct thermal_zon=
e_device *tz)
>                 tz->tzp =3D NULL;
>         }
>
> +       kfree(params->req_power);
>         kfree(tz->governor_data);
>         tz->governor_data =3D NULL;
>  }
> @@ -717,5 +798,6 @@ static struct thermal_governor thermal_gov_power_allo=
cator =3D {
>         .bind_to_tz     =3D power_allocator_bind,
>         .unbind_from_tz =3D power_allocator_unbind,
>         .throttle       =3D power_allocator_throttle,
> +       .update_tz      =3D power_allocator_update_tz,
>  };
>  THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> --

