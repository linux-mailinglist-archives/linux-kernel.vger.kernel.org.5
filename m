Return-Path: <linux-kernel+bounces-74240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7A985D179
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6552845CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885D3A8FF;
	Wed, 21 Feb 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCM52Wk/"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179139879
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500918; cv=none; b=kxabJ5F+oQl0TzHC9OQnTyYc+MDdG9K+XxQwF0ZfIeQPp7fCeGIXe2uSW8plyX5TaFWP5NdtZBkf1Ufc7quRdoPC65xUi/1ci7TWsJcFp6VC/R+xO2GLLnua56QqLxnMc52wD8+qYUm+/uMF0s2LTfbKYGpBy6QPBdFgS64CuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500918; c=relaxed/simple;
	bh=i5Sx85wmsctPs2/SldKw+W2TXiIuxqDh80PQGqdlem0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXfZDe7/281DtUtM7gO09Um05SahlxSbHvfF/C3FB8TwLpefhR2C9fSo9WqjL46akJvKqiO+q4R6hJ+wrDLWGd6V4eJIAVDpncu4QoGRzJjNQYGL7TCZxgl0laax00FbtlLx9LbxunYUO3dPg9bzJ2IwaZlddPqGgZhNjiFHz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCM52Wk/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3848260a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708500916; x=1709105716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmIOqBg1/8WHQOr613NChMcnfIzd4pmzronJgXlBxNw=;
        b=lCM52Wk/CDoH1ctptopF4UM6eZld/BixeX54ztPdMY4QDvO+n8XvrTTy0bXvOTbNR9
         FLBFKKm8CwhnqBbe139T+UoZ2Dz1t0DF6aMDHDhMfmuFVF5cJ3qmgfbrGLtJIP/js19+
         MhWMUSowMV3wt39NeGMZsjkY8jrgeNdJODo+4k0k0q2KXRE99IM6XI/x7MZp+Kiu30G7
         AJOmIuzsYcbpNvLlmLVo7YD/Ms2xtD/x8yU04BtYbNJP7ZTKeufiBDvc1tF1puvBcKIO
         QwVk7Y+jL7gDZ1PLJ88G/zAHC8lyvp/syQfNzZo39Z3O4mSxa49n5+7EIaZGDANyk4jC
         vzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500916; x=1709105716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmIOqBg1/8WHQOr613NChMcnfIzd4pmzronJgXlBxNw=;
        b=j9e7BGLcFkp90+XIr2ENE2T7iPy8dwMYG1GiPiRkFG8aTACAJ6+VgN87011cis8Bsf
         hpf+9WY57UA0ckIvy+phBgDEHvMeokBIaIKCEHv2tlf4OMZWzBQVkrZm+FWJr7IIcyMa
         fx+0uMtGzNYH+QCDfV724L3Pqn1lVwnExCJxnmDAkbOC4hKf/rUzCcbwN6iv5U2TniNb
         V6Mkd5/J2s5tvSaFf1qI5PFpmCILAjGHxUgD++Yz2gQEWNyIJr7kiJPaJuS9zsMHVnxj
         F/nR/TVaCF587IDSwU7II0B4bU4yRgp0pot88sJWq7wV05vKWG3nVivcYBLa0gJvTOuy
         Eafw==
X-Forwarded-Encrypted: i=1; AJvYcCVJBDYJOuiI5jT9boAttgF2NOlXrI7rmMZFhEC49RzLk6nVMmHh+LX94MNwocmS8vZdlueVN7AEhmSK7OsmcduLBnhAM1vZ+Dybi4JU
X-Gm-Message-State: AOJu0YwJX5l7XkATfLLDDgNWM8taQs/haKl8Txek5fM5M64wvupcjulc
	An4rPzAnQAI3TbB2tskBbum3WoViI3gJYtUteJAB5FRIyvONOkbuVT5lBO9lCGkM7nvW090UDuX
	XAopMkWnhW7F36Po2wxheznFYj3kMuE5jrCFRTw==
X-Google-Smtp-Source: AGHT+IEyfoGtlAAp8JSHXSGnVPdzKYbAy+h9ELuMYVkP7dMmdJMLjD22VuOCWasVIiW5Xy2n1mWGUbmmePwJtG1WB18=
X-Received: by 2002:a17:90a:5b06:b0:29a:2349:4d1e with SMTP id
 o6-20020a17090a5b0600b0029a23494d1emr477974pji.23.1708500916001; Tue, 20 Feb
 2024 23:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220180820.2597581-1-qyousef@layalina.io>
In-Reply-To: <20240220180820.2597581-1-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 21 Feb 2024 08:35:04 +0100
Message-ID: <CAKfTPtDO1r+_htQWTB3V-iXChozFtPCRMQpaRY8ecsMu1QDacA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 19:08, Qais Yousef <qyousef@layalina.io> wrote:
>
> We are providing headroom for the utilization to grow until the next
> decision point to pick the next frequency. Give the function a better
> name and give it some documentation. It is not really mapping anything.
>
> Also move it to cpufreq_schedutil.c. This function relies on updating
> util signal appropriately to give a headroom to grow. This is tied to
> schedutil and scheduler and not something that can be shared with other
> governors.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
> Changes in v2:
>
>         1. Add Acked-by from Viresh and Raphael (Thanks!)
>         2. Move the function to cpufreq_schedutil.c instead of sched.h
>         3. Name space the function with sugov_ to indicate it is special to
>            this governor only and not generic.
>
>  include/linux/sched/cpufreq.h    |  5 -----
>  kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..d01755d3142f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
>  {
>         return freq * util / cap;
>  }
> -
> -static inline unsigned long map_util_perf(unsigned long util)
> -{
> -       return util + (util >> 2);
> -}
>  #endif /* CONFIG_CPU_FREQ */
>
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index eece6244f9d2..575df3599813 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> +/*
> + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> + * continue to grow, which means it could need to run at a higher frequency
> + * before the next decision point was reached. IOW, we can't follow the util as
> + * it grows immediately, but there's a delay before we issue a request to go to
> + * higher frequency. The headroom caters for this delay so the system continues
> + * to run at adequate performance point.
> + *
> + * This function provides enough headroom to provide adequate performance
> + * assuming the CPU continues to be busy.
> + *
> + * At the moment it is a constant multiplication with 1.25.
> + */
> +static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
> +{
> +       return util + (util >> 2);
> +}
> +
>  unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
>                                  unsigned long min,
>                                  unsigned long max)
>  {
>         /* Add dvfs headroom to actual utilization */
> -       actual = map_util_perf(actual);
> +       actual = sugov_apply_dvfs_headroom(actual);
>         /* Actually we don't need to target the max performance */
>         if (actual < max)
>                 max = actual;
> --
> 2.34.1
>

