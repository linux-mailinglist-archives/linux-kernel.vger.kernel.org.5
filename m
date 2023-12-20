Return-Path: <linux-kernel+bounces-7075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A081A14C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CA4281C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF93D3AE;
	Wed, 20 Dec 2023 14:41:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B3D966;
	Wed, 20 Dec 2023 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59415f07ee4so2974eaf.1;
        Wed, 20 Dec 2023 06:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083313; x=1703688113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+XJtAZSW6XAM9Qwm/kB+hjQt5tSRjulwvOVlKrXhqs=;
        b=cy6PxAYDDfNb6lbhwEkh2BZmotTqg+d9LyS4anqROLyBMidxaSJ5EwSS0UXCiIjdyK
         InCS6awY/hfExE2LGIw2J88GQVvdav5Jrc6EThzHBLh0BIO6wWVbs1R0Wpz/WOTt2QYe
         bZXYmDYpQZTH40n+CLj+lFe3BLJvlpXtSbK8jduX6z2SISqFZRTUAjvVG5E4TNQACMQu
         uoqKCVXtQ64qKu8M9oURUZoeJvvyxRqCvHZ7zABE4SfjcrOL+2JH2bfF3jUizJmsys5Z
         URoRUM4Xnv2m9nN8RqTRtotJeDcdxMdVdmPKCufTv6Kd9v7tO0rJQLxZLz194XLn3hCM
         qjXA==
X-Gm-Message-State: AOJu0YxnoxYSLYsGUSCj7eqssdR7rpq8yVDvefv3Hn0eiBZ1nn4eWOWC
	L6zu4OrLFE1gIYtau/fo1VqZV0Pspkhfd2WfCsE=
X-Google-Smtp-Source: AGHT+IEvXa9Urj590Qy4NyjoC8dihiPWvI7Rf7th0N6QvUdPo1ZuvQtGHDf38rozoim6yRSOs3b9lvwCY/mnZnscvt4=
X-Received: by 2002:a05:6820:2c91:b0:593:e60a:493e with SMTP id
 dx17-20020a0568202c9100b00593e60a493emr4341253oob.0.1703083312931; Wed, 20
 Dec 2023 06:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-6-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-6-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:41:41 +0100
Message-ID: <CAJZ5v0hmzRbEG3V9WeJ7d2Kx1va-Fox18rKafms_wkNe36H_YQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] thermal: gov_power_allocator: Refactor checks in divvy_up_power()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Simplify the code and remove one extra 'if' block.
>
> No intentional functional impact.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 1a605fd9c8c6..574aa5822112 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -349,7 +349,8 @@ static void divvy_up_power(u32 *req_power, u32 *max_p=
ower, int num_actors,
>                            u32 total_req_power, u32 power_range,
>                            u32 *granted_power, u32 *extra_actor_power)
>  {
> -       u32 extra_power, capped_extra_power;
> +       u32 capped_extra_power =3D 0;
> +       u32 extra_power =3D 0;
>         int i;
>
>         /*
> @@ -358,8 +359,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_p=
ower, int num_actors,
>         if (!total_req_power)
>                 total_req_power =3D 1;
>
> -       capped_extra_power =3D 0;
> -       extra_power =3D 0;
>         for (i =3D 0; i < num_actors; i++) {
>                 u64 req_range =3D (u64)req_power[i] * power_range;
>
> @@ -375,7 +374,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_p=
ower, int num_actors,
>                 capped_extra_power +=3D extra_actor_power[i];
>         }
>
> -       if (!extra_power)
> +       if (!extra_power || !capped_extra_power)
>                 return;
>
>         /*
> @@ -383,12 +382,13 @@ static void divvy_up_power(u32 *req_power, u32 *max=
_power, int num_actors,
>          * how far they are from the max
>          */
>         extra_power =3D min(extra_power, capped_extra_power);
> -       if (capped_extra_power > 0)
> -               for (i =3D 0; i < num_actors; i++) {
> -                       u64 extra_range =3D (u64)extra_actor_power[i] * e=
xtra_power;
> -                       granted_power[i] +=3D DIV_ROUND_CLOSEST_ULL(extra=
_range,
> -                                                        capped_extra_pow=
er);
> -               }
> +
> +       for (i =3D 0; i < num_actors; i++) {
> +               u64 extra_range =3D (u64)extra_actor_power[i] * extra_pow=
er;
> +
> +               granted_power[i] +=3D DIV_ROUND_CLOSEST_ULL(extra_range,
> +                                                capped_extra_power);
> +       }
>  }
>
>  static int allocate_power(struct thermal_zone_device *tz, int control_te=
mp)
> --

Looks good to me.

