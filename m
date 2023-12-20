Return-Path: <linux-kernel+bounces-7094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C081A193
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6031C2329E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC623D985;
	Wed, 20 Dec 2023 14:57:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDB3D972;
	Wed, 20 Dec 2023 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2041426d274so28571fac.0;
        Wed, 20 Dec 2023 06:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703084238; x=1703689038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvXXV7WAMWDWeQwnxROTImAzvvpI6U5xTz6U6+Bk+6k=;
        b=cGJTa9nlE4/XwR4DWl1W/ZRkGVD6beS7ul1mY32lJ8C3/6fgtSVS6fXUH0zM9HH8+z
         abhMcGmSIkKg93/2NCxpwGHXBLMffZbe6e+ofuwGhCcIeCFh+P1AjwKr8SlHMAHbL3C4
         WDKftj9ZkhH4V1dcsAeAaBONWFyeF6Ten9bIPJx5JbGc6Vn7f1mQVEfPgRYE8vSzKJGD
         61+Zs1UqOHF+q66NnuES+ATQI5CTGLyqz331xIetQOwOrvJEwhXJwYCGlSIi9m3/sUHs
         HGYGLD3QCbFdNKnzPmV6GH/Hs65lkksHze8t/Oau2meJvoH71b4KU5J6h01p5j4jKiSK
         nmeg==
X-Gm-Message-State: AOJu0YxdYLeQHT6pvZeiKPxaroHdBuk38eT6mi1jOf3n093JUCSlNomW
	1fbigPuFnyYqGqfdmKkw/7Y+xSZ5VaPqZkBtvKc=
X-Google-Smtp-Source: AGHT+IGajGCIjh3pu93JqWzGd0XqWu0wSWnK29biKOeETlQIGQplWubvhYwdzrH1uM6Oww1XbdFTdpSYD11gTU239Ww=
X-Received: by 2002:a05:6870:8914:b0:204:1d62:9a8b with SMTP id
 i20-20020a056870891400b002041d629a8bmr502514oao.5.1703084237759; Wed, 20 Dec
 2023 06:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-8-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-8-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:57:06 +0100
Message-ID: <CAJZ5v0h=1yXYzS0LH6dVT1YCMqJ_rYeBJXCmkRsgZEyDK8QCpA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] thermal/sysfs: Update governors when the 'weight'
 has changed
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Support governors update when the thermal instance's weight has changed.
> This allows to adjust internal state for the governor.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 9 +++++++++
>  include/linux/thermal.h         | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index df85df7d4a88..9afa2e2b76b9 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -957,6 +957,14 @@ weight_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
>         return sprintf(buf, "%d\n", instance->weight);
>  }
>
> +static void handle_weight_update(struct thermal_zone_device *tz)
> +{
> +       if (!tz->governor || !tz->governor->update_tz)
> +               return;
> +
> +       tz->governor->update_tz(tz, THERMAL_INSTANCE_WEIGHT_UPDATE);
> +}

So if you follow my advice from the comment on the first patch, you'll
be able to use the helper as is without introducing a new one.

> +
>  ssize_t weight_store(struct device *dev, struct device_attribute *attr,
>                      const char *buf, size_t count)
>  {
> @@ -974,6 +982,7 @@ ssize_t weight_store(struct device *dev, struct devic=
e_attribute *attr,
>         /* Don't race with governors using the 'weight' value */
>         mutex_lock(&tz->lock);
>         instance->weight =3D weight;
> +       handle_weight_update(tz);

So this will become

thermal_governor_update_tz(tz, THERMAL_INSTANCE_WEIGHT_UPDATE);

>         mutex_unlock(&tz->lock);
>
>         return count;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 9fd0d3fb234a..24176f075fbf 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -52,6 +52,7 @@ enum thermal_notify_event {
>         THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
>         THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to re=
spond */
>         THERMAL_INSTANCE_LIST_UPDATE, /* List of thermal instances change=
d */
> +       THERMAL_INSTANCE_WEIGHT_UPDATE, /* Thermal instance weight change=
d */

And I'd slightly prefer THERMAL_INSTANCE_WEIGHT_CHANGE.

>  };
>
>  /**
> --

