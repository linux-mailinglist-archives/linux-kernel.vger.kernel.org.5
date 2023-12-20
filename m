Return-Path: <linux-kernel+bounces-7091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71BD81A187
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E08286A41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF53E499;
	Wed, 20 Dec 2023 14:53:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981693E494;
	Wed, 20 Dec 2023 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59408b117b6so8904eaf.0;
        Wed, 20 Dec 2023 06:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083995; x=1703688795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/zlRVnAA6clM7lU88Df5rRPOkk60KNgaWc/JlduENc=;
        b=hTZ4kuz2AcTqlPAtbv+3XNdbkiTSVOYbyRSEZnCkGYMKodhSICtvbPAC9imvB2KoHC
         SyT+m+k/8Z3euOwN1vVe78TJ9Qgjwm9ly7APgXq7gqj5ruO5nl3+5tkzs3rNkqdSNvGU
         CUbefC6is9vELKkKB6AE1+vLvrB/jlsEaj0oJkcP81rCrZteTLwFaSubbOkOzGae+w7M
         dUbzPn34XSKzAzLKHWd9+AgKVQcaRm3ttpojTpCjBf25oosdDmTc9MxRX99UHEHNLT8L
         OXI1BsfMIbR8eyWhxl5BBFChgl6q/gwtS0pExsJCjb1sEEq7SaKQYbDvgpbfndNdrCbE
         D6Uw==
X-Gm-Message-State: AOJu0Yw5tuapx0HPUjQ5uVR39DtiwJJglmxzVvTww/4CbdshtTs6uB+L
	zXKWPn++YGNiUTLGQffTUXxqDP2ZY/j75RyJTtY=
X-Google-Smtp-Source: AGHT+IH5gvpLiU9kletTxr2CIKmMAJVwRMcFmJj8elwT/RQ5BhGe0hdc1mfboHxDz//Qx2+AhpQHWyapaD2aY9Pdx+8=
X-Received: by 2002:a4a:b141:0:b0:591:c8cd:a13a with SMTP id
 e1-20020a4ab141000000b00591c8cda13amr11252400ooo.0.1703083995668; Wed, 20 Dec
 2023 06:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-7-lukasz.luba@arm.com>
In-Reply-To: <20231212134844.1213381-7-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 15:53:04 +0100
Message-ID: <CAJZ5v0hes13rmAgcyMYtz1ZXxV72pM3QgRY=LKF9jK=GbAyS=g@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] thermal/sysfs: Update instance->weight under tz lock
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> The user-space can change thermal instance weight value while the
> throtte() callback is running for a governor.

This needs to be more precise IMV.  Something like

"User space can change the weight of a thermal instance via sysfs
while the .throttle() callback is running for a governor, because
weight_store() does not use the zone lock."

> The IPA governor uses the
> 'weight' value for power calculation and also keeps it in 'total_weight'.
> Therefore, the 'weight' value must not change during the throttle()
> callback. Use 'tz->lock' mutex which also guards the throttle() to make
> the update value safe.

"The IPA governor uses instance weight values for power calculations
and caches the sum of them as total_weight, so it gets confused when
one of them changes while its .throttle() callback is running.

To prevent that from happening, use thermal zone locking in weight_store().=
"

>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index eef40d4f3063..df85df7d4a88 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -961,6 +961,7 @@ ssize_t weight_store(struct device *dev, struct devic=
e_attribute *attr,
>                      const char *buf, size_t count)
>  {
>         struct thermal_instance *instance;
> +       struct thermal_zone_device *tz;

IMO the local var doesn't help much.  You may as well use
instance->tz->lock directly below.

>         int ret, weight;
>
>         ret =3D kstrtoint(buf, 0, &weight);
> @@ -968,7 +969,12 @@ ssize_t weight_store(struct device *dev, struct devi=
ce_attribute *attr,
>                 return ret;
>
>         instance =3D container_of(attr, struct thermal_instance, weight_a=
ttr);
> +       tz =3D instance->tz;
> +
> +       /* Don't race with governors using the 'weight' value */
> +       mutex_lock(&tz->lock);
>         instance->weight =3D weight;
> +       mutex_unlock(&tz->lock);
>
>         return count;
>  }
> --

