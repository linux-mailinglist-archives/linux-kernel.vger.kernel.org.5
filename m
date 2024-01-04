Return-Path: <linux-kernel+bounces-17123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C48248A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5E81F22255
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35228E3D;
	Thu,  4 Jan 2024 19:08:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845E2C18C;
	Thu,  4 Jan 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb7e50679bso188849b6e.0;
        Thu, 04 Jan 2024 11:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395291; x=1705000091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHvkNoyDDxzbLwlNA3wT9KR65mBKm5P0nwrkbLsti3U=;
        b=q5WBGurLyfQC0VKvO8Rh0sE0OC7StNUhOnNS89gR3ENpkyNkU5kSC1cI8mreV3jz6Z
         T0uvWexe9TPquoc8qBpbliDGd1URnJ35q9s2jkMpCYQWOwrJGBxn/jLkZZoP6arym3gz
         ojaMsU3cZBKnoE3xYx8W+OHbJ9LJcGHcTybTmS9rPUWkALCQ+mteA5iEpRR2O3y397N3
         1TATnv0GRggBasWBXb9epojn1KA522XJ7G/1q3xHEi8MJQSjJwXL+VGBxwkX4MeP8dN2
         ZwhrhDI0uyeTMUE20fXfFFQ09HN/vhc1mKzU1oaBiVfzMGyfLpM6o12XMh+Y0lzRhHuK
         koHw==
X-Gm-Message-State: AOJu0YwOWNxE5sXOo0X2112G6QQVAIM9Tm9Mh/Xf30AZMHzClV55Ww9V
	912QF2QMBWJUDZd7zqCtZJBDrsnev1fJIODSKZE=
X-Google-Smtp-Source: AGHT+IECo+vuspUhcs7s76845zh7su3GowH0b83Oe/Q0O+NoCL0hKkiCZtCG9PSj/vh+F3VB8Y+VAKPTsIFuwjG2Ae8=
X-Received: by 2002:a4a:e70a:0:b0:596:27ee:455b with SMTP id
 y10-20020a4ae70a000000b0059627ee455bmr1857781oou.1.1704395290859; Thu, 04 Jan
 2024 11:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171553.2080674-1-lukasz.luba@arm.com> <20240104171553.2080674-3-lukasz.luba@arm.com>
In-Reply-To: <20240104171553.2080674-3-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 20:07:59 +0100
Message-ID: <CAJZ5v0jCtS1XHczORnZFhwO7N=FommFNbQC7NdaM5SHKXUnTog@mail.gmail.com>
Subject: Re: [PATCH v6 02/23] PM: EM: Refactor em_cpufreq_update_efficiencies()
 arguments
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The word "refactor" appears to be quite loaded in your patch
descriptions, but it is not always the best one to use IMV.

For instance, this patch simply extends the argument list of
em_cpufreq_update_efficiencies(), so I would say just that in the
subject: "Extend em_cpufreq_update_efficiencies() argument list"

On Thu, Jan 4, 2024 at 6:14=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> In order to prepare the code for the modifiable EM perf_state table,
> refactor existing function em_cpufreq_update_efficiencies().

"make em_cpufreq_update_efficiencies() take a pointer to the EM table
as its second argument and modify it to use that new argument instead
of the "table" member of dev->em_pd"

or something like this.

> The function now takes the ptr to the EM table as its argument.
>
> No functional impact.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 8b9dd4a39f63..42486674b834 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_=
states,
>         return 0;
>  }
>
> -static void em_cpufreq_update_efficiencies(struct device *dev)
> +static void
> +em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state =
*table)
>  {
>         struct em_perf_domain *pd =3D dev->em_pd;
> -       struct em_perf_state *table;
>         struct cpufreq_policy *policy;
>         int found =3D 0;
>         int i;
> @@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct dev=
ice *dev)
>                 return;
>         }
>
> -       table =3D pd->table;
> -
>         for (i =3D 0; i < pd->nr_perf_states; i++) {
>                 if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>                         continue;
> @@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, u=
nsigned int nr_states,
>
>         dev->em_pd->flags |=3D flags;
>
> -       em_cpufreq_update_efficiencies(dev);
> +       em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
>
>         em_debug_create_pd(dev);
>         dev_info(dev, "EM: created perf domain\n");
> --

The code change itself LGTM.

