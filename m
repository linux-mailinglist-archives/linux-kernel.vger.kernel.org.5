Return-Path: <linux-kernel+bounces-6992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA081A047
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA221C2253F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3236B0F;
	Wed, 20 Dec 2023 13:51:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AD38DD8;
	Wed, 20 Dec 2023 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da6576064dso1009890a34.1;
        Wed, 20 Dec 2023 05:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080279; x=1703685079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2lU+eMx3+kOMFg1wDlc+9EMfswuKkS1DBslLLWNXWE=;
        b=h9FPeVoNAnCGg+nh8e4CO6zTeCyoekXFCSW7JNrBsvIgx0NYfHBW7vY8k9Ym1Ln+lY
         OlpoMkV2DtAIMi+AJhgrdKROoSo+iA+I0/c0PDtZjaikVicvX0n2KA+/RBY+glJTFJn1
         4L3APLr5NAKE8NMKZKjrZNiIoMhj4T/vqKonnBeIaxOC0+hPTXh20aPQLH4f9sBsTYMQ
         nL6I2zsegWK2rbmsGI9Zrx7X681Fg0Ylk4chSRmHMaTvoUOVbdOabGVj0oh8SgNfoeaV
         lkxSdEHCTdp8OTXqzCvykk53jdxGoF+ed73OCMA36SxOEpSdEb/8DapHkpCEb7gM0AEw
         x54A==
X-Gm-Message-State: AOJu0Yz66x3L74bDRqPJSNVg3fdrpk6Kg/9cKZq5oqOObxNM0PDFthaG
	C7c9vM47QxKla9PzfP3wfIPt4kc0DtGCtvvi+Kk=
X-Google-Smtp-Source: AGHT+IE2325k4JDGlJJwoytkERkv8LDhLcy0rhdfXp0W2j5XnLlymgPbXD0ZO/MRtZcXLZt9f3yWuw4cArCMsjf/wfI=
X-Received: by 2002:a05:6870:b028:b0:1fb:e5f:c530 with SMTP id
 y40-20020a056870b02800b001fb0e5fc530mr35863963oae.4.1703080279087; Wed, 20
 Dec 2023 05:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-2-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-2-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 14:51:07 +0100
Message-ID: <CAJZ5v0iFOrgtN82pqUqDhE1jMA4wjhH19DFhzPP3yYO05O03=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] thermal: core: Add governor callback for thermal
 zone change
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Add a new callback which can update governors when there is a change in
> the thermal zone internals, e.g. thermal cooling instance list changed.

I would say what struct type the callback is going to be added to.

> That makes possible to move some heavy operations like memory allocations
> related to the number of cooling instances out of the throttle() callback=
.
>
> Reuse the 'enum thermal_notify_event' and extend it with a new event:
> THERMAL_INSTANCE_LIST_UPDATE.

I think that this is a bit too low-level (see below).

> Both callback code paths (throttle() and update_tz()) are protected with
> the same thermal zone lock, which guaranties the consistency.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/thermal_core.c | 13 +++++++++++++
>  include/linux/thermal.h        |  5 +++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 625ba07cbe2f..592c956f6fd5 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -314,6 +314,14 @@ static void handle_non_critical_trips(struct thermal=
_zone_device *tz,
>                        def_governor->throttle(tz, trip);
>  }
>

I needed a bit more time to think about this.

> +static void handle_instances_list_update(struct thermal_zone_device *tz)
> +{
> +       if (!tz->governor || !tz->governor->update_tz)
> +               return;
> +
> +       tz->governor->update_tz(tz, THERMAL_INSTANCE_LIST_UPDATE);
> +}

So I would call the above something more generic, like
thermal_governor_update_tz() and I would pass the "reason" argument to
it.

> +
>  void thermal_zone_device_critical(struct thermal_zone_device *tz)
>  {
>         /*
> @@ -723,6 +731,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_dev=
ice *tz,
>                 list_add_tail(&dev->tz_node, &tz->thermal_instances);
>                 list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
>                 atomic_set(&tz->need_update, 1);
> +
> +               handle_instances_list_update(tz);

In particular for this, I would use a special "reason" value, like
THERMAL_TZ_BIND_CDEV.

Yes, the list of instances will change as a result of the binding, but
that is an internal detail specific to the current implementation.

>         }
>         mutex_unlock(&cdev->lock);
>         mutex_unlock(&tz->lock);
> @@ -781,6 +791,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone=
_device *tz,
>                 if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cd=
ev =3D=3D cdev) {
>                         list_del(&pos->tz_node);
>                         list_del(&pos->cdev_node);
> +
> +                       handle_instances_list_update(tz);

Analogously, I'd use something like THERMAL_TZ_UNBIND_CDEV here.

> +
>                         mutex_unlock(&cdev->lock);
>                         mutex_unlock(&tz->lock);
>                         goto unbind;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c7190e2dfcb4..9fd0d3fb234a 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -51,6 +51,7 @@ enum thermal_notify_event {
>         THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability chan=
ged */
>         THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
>         THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to re=
spond */
> +       THERMAL_INSTANCE_LIST_UPDATE, /* List of thermal instances change=
d */

So I would add THERMAL_TZ_BIND_CDEV and THERMAL_TZ_UNBIND_CDEV to the list.

>  };
>
>  /**
> @@ -195,6 +196,8 @@ struct thermal_zone_device {
>   *                     thermal zone.
>   * @throttle:  callback called for every trip point even if temperature =
is
>   *             below the trip point temperature
> + * @update_tz: callback called when thermal zone internals have changed,=
 e.g.
> + *             thermal cooling instance was added/removed
>   * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>   */
>  struct thermal_governor {
> @@ -203,6 +206,8 @@ struct thermal_governor {
>         void (*unbind_from_tz)(struct thermal_zone_device *tz);
>         int (*throttle)(struct thermal_zone_device *tz,
>                         const struct thermal_trip *trip);
> +       void (*update_tz)(struct thermal_zone_device *tz,
> +                         enum thermal_notify_event reason);
>         struct list_head        governor_list;
>  };
>
> --

