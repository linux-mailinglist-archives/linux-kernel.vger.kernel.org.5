Return-Path: <linux-kernel+bounces-24777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DCD82C24E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB454281727
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608BC6E2CA;
	Fri, 12 Jan 2024 14:56:47 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C126DD10;
	Fri, 12 Jan 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-204458dec9cso959111fac.1;
        Fri, 12 Jan 2024 06:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071404; x=1705676204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZpJF8ckEKzWu9JP8njFy/DUirOzmC1WDS5E6Eh5HQE=;
        b=vpYJVkY56vJ529a8QLXr/I53SCt+UPq5RlT0wfdtCRECnJnR2F0MFJTdsQIMvCdE0k
         iFEmPebd4S7Gls7kokLkjxrDcCssMzdMsFWm7J1yjqgPTw33n8xmtF85rWMBV0BDYd2y
         FqVouq7kF8F8qJ8SguiQ3Lo1WzBTLCnc7ateRVeG023Xs2qi/lg0hGxn6ubVhCz5AxB4
         Gtlozq2GzVh/fsI8JcGoOj7YIUaRQhdxp5GZ4YkM5m5A347loFCTDgs1eLwAjuhwGWyH
         iAzTOWE9cR4K7jD46318S4RH2H5PVMAQpYoUJddLgf6yHhkRWHvV3OxyruwbWcooDqM+
         X6Ng==
X-Gm-Message-State: AOJu0YzYdfqU1ebItncnujeEBYQuShypn+t1A1YMdYcSaH8yBaSfTDjl
	pf4hJBHG83bcpQIpPeYx2l3ImjfSjdS2N/dUO1g2CLHD
X-Google-Smtp-Source: AGHT+IHqdJiMlARxTIb24YUXWd/c0ds830Sg3iyR4kvxB+qlqlYNB3iD2rCb8R1UK7EeVyED1cArKWr9rQST90WmkS0=
X-Received: by 2002:a05:6870:c904:b0:206:b53d:474f with SMTP id
 hj4-20020a056870c90400b00206b53d474fmr2693743oab.3.1705071404641; Fri, 12 Jan
 2024 06:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <efe2a897-4af0-4204-8105-1bee7d6b9380@moroto.mountain>
In-Reply-To: <efe2a897-4af0-4204-8105-1bee7d6b9380@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jan 2024 15:56:31 +0100
Message-ID: <CAJZ5v0isUXAPq0Vh-RU0iopes_4r7KaejgqgFpzRT_zeZySDBQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/debugfs: Unlock on error path in thermal_debug_tz_trip_up()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:30=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> Add a missing mutex_unlock(&thermal_dbg->lock) to this error path.
>
> Fixes: 4731c8f16a0e ("thermal/debugfs: Add thermal debugfs information fo=
r mitigation episodes")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/thermal/thermal_debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index a3fa09235da1..a3f06029fc54 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -591,7 +591,7 @@ void thermal_debug_tz_trip_up(struct thermal_zone_dev=
ice *tz,
>         if (!tz_dbg->nr_trips) {
>                 tze =3D thermal_debugfs_tz_event_alloc(tz, now);
>                 if (!tze)
> -                       return;
> +                       goto unlock;
>
>                 list_add(&tze->node, &tz_dbg->tz_episodes);
>         }
> @@ -619,6 +619,7 @@ void thermal_debug_tz_trip_up(struct thermal_zone_dev=
ice *tz,
>                 (temperature - tze->trip_stats[trip_id].avg) /
>                 tze->trip_stats[trip_id].count;
>
> +unlock:
>         mutex_unlock(&thermal_dbg->lock);
>  }
>
> --

Applied, thanks!

