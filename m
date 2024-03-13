Return-Path: <linux-kernel+bounces-102458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6487B266
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F95728A1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BBC4CE04;
	Wed, 13 Mar 2024 19:58:18 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AA20DDB;
	Wed, 13 Mar 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359898; cv=none; b=ImeV9DvLjNvLogHLRbtuM7rC4SodVDX5svar8zu9BUVC6R6bVBaeivJxAH4SSnAhs4xlm9Y+piUG4PyuYFmtx6c8dzjXyr4vl9CDZj6K4l0NH/Ux3URsBaLq2bYp3sNZRwMJSihLFp2spVWTIs1Nd2dbXbyPYkSEARhiGcKmGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359898; c=relaxed/simple;
	bh=hhFq5IpzNKqt3vASlinqD/E0HbWm7PiMwUPQBESAj5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCwFzEsWezUjZH8fv04mi0bJZBH6+tuzneg2tUh/d9TyV63k2DOr3bljkaDqkByp17tATkVqlzrzLVRxisB6dFboc/TNdYJxoPuNVRuk+C1jrVxEtITX8GRAJKRJmsO+Rf5OoVdTi0oYB2QBuyO81qja0QHlhcHenGrbeeta6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2219edd959dso74895fac.0;
        Wed, 13 Mar 2024 12:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359895; x=1710964695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdP8F+x5j1lSl9Kjac5VCWtp2OKa5wXezFE2irQlxPY=;
        b=a0Z04Dna8Gtl25EDeNATVlB59ubX0/tiAtYJlvgryvdokzvYz+eWuu+Z9AX4maeHoK
         jOIQpFnt/SAADin7E6OCoqIzxTlwJ2vKMZUfcTeyUhbQc2UNv4sKPiQbIjYRhwRkf+Iq
         pImL6fA8hCJkeInpdxDF+kq/Of+7MyvmC4rDAAleU/4teFrM9I/jhx+YmVUZ1Ov0uPWZ
         OTkxVbL5o1AFBDm5vW5rM3V6MaCbb68z8ZWMDpqt8/bh+QzF6RVJv3FAq02mRqbmoQAi
         gUcnhlL/5wZY6imdqWV4Zmz+nieWoBfYdTzwfk+5X2K9BrFb//AkSzOcg3uObKM+USwk
         oHLg==
X-Forwarded-Encrypted: i=1; AJvYcCVJZEg3ArUTE8aNv3QGGlmHEXzhlSuQQLiZ+3SZLyn8QoCs099nrjdYacb7++GoQJGzRlV4QwYEsXa1BU3ZPKM+Bdf5tR76AXu4Qo4aDJF8bkxs40D2QLu1unVCdxTU+lPpobspiwSJ/qAajyCcXbFV34wd/XsAcQBWKWaWgMXu0PFLuwmy
X-Gm-Message-State: AOJu0Yx0LO+PUL8p6GQBHCHiWemX9Dni2XD+cDFgBaGbgaVPmNFVYaI4
	c+6loQSWCa6RUZKrxT+Ds7TSuFF/bYOfigKdBRa2JCJ631axKYFExYNUVnLT2k1YdsF3MbCgzlo
	vjI8rMg0NY/Aa2Xwt9+rM9UvWMl8=
X-Google-Smtp-Source: AGHT+IEWlkP/2kfvt3B2rhZO97HkoSPYHA2GD7sErHQcZOV/0GMkTwiKtB++GlXS5E0yL2Z77yUf5VdyVQXQhFtovPU=
X-Received: by 2002:a05:6871:3325:b0:221:cb1b:cc05 with SMTP id
 nf37-20020a056871332500b00221cb1bcc05mr3047428oac.0.1710359895299; Wed, 13
 Mar 2024 12:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312103723.3469762-1-quic_sibis@quicinc.com>
In-Reply-To: <20240312103723.3469762-1-quic_sibis@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Mar 2024 20:58:04 +0100
Message-ID: <CAJZ5v0iLvq_4mNTTNw9eXZL4rG25jpRuWAKvY_7HZvLDRmGZNw@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: dietmar.eggemann@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	xuwei5@hisilicon.com, zhanjie9@hisilicon.com, sudeep.holla@arm.com, 
	cristian.marussi@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_rgottimu@quicinc.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, d-gole@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:37=E2=80=AFAM Sibi Sankar <quic_sibis@quicinc.co=
m> wrote:
>
> In the existing code, per-policy flags doesn't have any impact i.e.
> if cpufreq_driver boost is enabled and one or more of the per-policy
> boost is disabled, the cpufreq driver will behave as if boost is
> enabled. Fix this by incorporating per-policy boost flag in the policy->m=
ax
> calculus used in cpufreq_frequency_table_cpuinfo and setting the default
> per-policy boost to mirror the cpufreq_driver boost flag.
>
> Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> v3:
> * Pickup Rbs.
> * Simplify per-policy boost setting. [Viresh]
>
> v2:
> * Enable per-policy boost flag in the core instead. [Viresh]
> * Add more details regarding the bug. [Viresh]
> * Drop cover-letter and patch 2.
>
> Logs reported-by Dietmar Eggemann:
> https://lore.kernel.org/lkml/265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com=
/
>
>  drivers/cpufreq/cpufreq.c    | 18 ++++++++++++------
>  drivers/cpufreq/freq_table.c |  2 +-
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f6f8d7f450e7..66e10a19d76a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -653,14 +653,16 @@ static ssize_t store_local_boost(struct cpufreq_pol=
icy *policy,
>         if (policy->boost_enabled =3D=3D enable)
>                 return count;
>
> +       policy->boost_enabled =3D enable;
> +
>         cpus_read_lock();
>         ret =3D cpufreq_driver->set_boost(policy, enable);
>         cpus_read_unlock();
>
> -       if (ret)
> +       if (ret) {
> +               policy->boost_enabled =3D !policy->boost_enabled;
>                 return ret;
> -
> -       policy->boost_enabled =3D enable;
> +       }
>
>         return count;
>  }
> @@ -1428,6 +1430,9 @@ static int cpufreq_online(unsigned int cpu)
>                         goto out_free_policy;
>                 }
>
> +               /* Let the per-policy boost flag mirror the cpufreq_drive=
r boost during init */
> +               policy->boost_enabled =3D cpufreq_boost_enabled() && poli=
cy_has_boost_freq(policy);
> +
>                 /*
>                  * The initialization has succeeded and the policy is onl=
ine.
>                  * If there is a problem with its frequency table, take i=
t
> @@ -2769,11 +2774,12 @@ int cpufreq_boost_trigger_state(int state)
>
>         cpus_read_lock();
>         for_each_active_policy(policy) {
> +               policy->boost_enabled =3D state;
>                 ret =3D cpufreq_driver->set_boost(policy, state);
> -               if (ret)
> +               if (ret) {
> +                       policy->boost_enabled =3D !policy->boost_enabled;
>                         goto err_reset_state;
> -
> -               policy->boost_enabled =3D state;
> +               }
>         }
>         cpus_read_unlock();
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index c4d4643b6ca6..c17dc51a5a02 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -40,7 +40,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_poli=
cy *policy,
>         cpufreq_for_each_valid_entry(pos, table) {
>                 freq =3D pos->frequency;
>
> -               if (!cpufreq_boost_enabled()
> +               if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>                     && (pos->flags & CPUFREQ_BOOST_FREQ))
>                         continue;
>
> --

Applied as 6.9-rc material, thanks!

