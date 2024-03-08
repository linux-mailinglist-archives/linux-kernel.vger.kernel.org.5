Return-Path: <linux-kernel+bounces-96968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776E8763EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9691C21026
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276356471;
	Fri,  8 Mar 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ribX3y84"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FC055E78
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899319; cv=none; b=jcTaZjZYfyvGg6OiRoyqeUH2N+u+U0iadSsYkPhAOIq3l3eWAr79j/VjRedbq3eZuCP/87T5cKKS87cI2EIUg49sFuJv0N8gxZWvGzM+LNDc5CIseZfy1y4AEKs6uoEFPl7dlNFN5R2vKfrzywuUXIX3IjFF4AwBK55P2c7/3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899319; c=relaxed/simple;
	bh=oeP7aC45TRtPWvlWuB0bbz3B6QHquGjrT2HnyIlow1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMdS6yKiqabf3qM4BDjmqFUSL6NXlb3sg3eXSrLhXN1a9AnSlJDKvA/DL+WNb3Hwkoxbuj5yYwnpTuHv+xanbeMzaVn4scL4ebMllL7OPmKg7gGt2g4fZnyAAX6Q3sS3iD4uOl9zhv+xIFiGAJpj5mwTE6HndPONOzQithoGUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ribX3y84; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29ba41e6dfdso962796a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709899317; x=1710504117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UpFXbxHyDDIXq6xBO2ciUViM+MprPaGpz2/78ljgIr0=;
        b=ribX3y84Z9T0o4JcvVaT+bIZQvFsaSayBhF9yv0zE9C40VaZZPaDoT3962h12rqJBq
         mJI+vdeGedHGOaYyQRKdjPaCbX9wHedqO8sOPq9jIYIt9tT/ubxHKWU/5IHKMWDkckR1
         zzBS8+Az3sPzD11dv3q2/jAmb5+OzFb/kH6gi4K8kNhGcFyW7BXjH2KSVOqONWUqz6sr
         1g3GPAs1pyJrVeB69DxmnyU1YnuAWEYSnROAKmDxtv3ylkv1mP7zu0JAwzPxARjw9MlJ
         VX5idicCnGcagsC1Q2UiWemIe1wdPTDDzK9grT9BEAsCtcaov969NBMEg6qfdIAkHz94
         Y9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899317; x=1710504117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpFXbxHyDDIXq6xBO2ciUViM+MprPaGpz2/78ljgIr0=;
        b=W3mwjIRsBP6+wMF2ubv8cSJAPmbM9DUatj3UVg7bcEjwFOJ94LvZOpKdDd3s+mmJ4k
         70TkcTOA/mdKKF11pw/oW1GVnAnETFjuN532ACpinHjnT6NRruNGkbplZcDZ/exgnln6
         kV69Qf2axlHFF6Vf9dmK1w4MDe1EnNuhIh+PrX9qC3xK+prGwH54TDAPs9crW9O2zmyl
         UtTGL46lmj42Mv71QF4nM9OeBCtDKNrDFIJ1o1dX2gpNTJeV/Y/1fJDTvDrw9CXVGQXd
         TX2EGYB9BqUDscl+9MNhNzx31ZQuFL6sfY5H1ehbVTywyRpySKiBaKlF8YTIV5sbnDjb
         o7nw==
X-Gm-Message-State: AOJu0Yw60PPvtC4+XW1X/QRFhR096Sqw58W++ER4OcF4yELaXX4/f92J
	HKcT2JqgweW4qfZlYtSORzAh7eOOF16Owj9OWY2imjqIn0cFslkdVh1Qu2YZSio/cc17h+7JaTW
	LArp+aYwlTJlnVKMyk58pbs5Ja8yVg5VK9RGGOg==
X-Google-Smtp-Source: AGHT+IF9bjp2k3SSNqbz4JT7ZmtYwVSIwAP0YE7mHFgfWRx/W1J0/WhelxSenu90tlHyrEiIAIqV5+iAifpWMgeYIqo=
X-Received: by 2002:a17:90b:3507:b0:29b:a1b9:50d4 with SMTP id
 ls7-20020a17090b350700b0029ba1b950d4mr2929807pjb.45.1709899317353; Fri, 08
 Mar 2024 04:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308105901.1096078-1-mingo@kernel.org> <20240308105901.1096078-10-mingo@kernel.org>
In-Reply-To: <20240308105901.1096078-10-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 13:01:46 +0100
Message-ID: <CAKfTPtDN3Mj_ygeNqWn3NV1-ADS6-hvMwASSt5YjbcPQxBiSag@mail.gmail.com>
Subject: Re: [PATCH 09/10] sched/balancing: Vertically align the comments of
 'struct sg_lb_stats' and 'struct sd_lb_stats'
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:59, Ingo Molnar <mingo@kernel.org> wrote:
>
> Make them easier to read.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b567c0790f44..40b98e43d794 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9436,19 +9436,19 @@ static void update_blocked_averages(int cpu)
>   * sg_lb_stats - stats of a sched_group required for load_balancing
>   */
>  struct sg_lb_stats {
> -       unsigned long avg_load; /*Avg load across the CPUs of the group */
> -       unsigned long group_load; /* Total load over the CPUs of the group */
> +       unsigned long avg_load;                 /* Avg load across the CPUs of the group */
> +       unsigned long group_load;               /* Total load over the CPUs of the group */
>         unsigned long group_capacity;
> -       unsigned long group_util; /* Total utilization over the CPUs of the group */
> -       unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
> -       unsigned int sum_nr_running; /* Nr of tasks running in the group */
> -       unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
> +       unsigned long group_util;               /* Total utilization over the CPUs of the group */
> +       unsigned long group_runnable;           /* Total runnable time over the CPUs of the group */
> +       unsigned int sum_nr_running;            /* Nr of tasks running in the group */
> +       unsigned int sum_h_nr_running;          /* Nr of CFS tasks running in the group */
>         unsigned int idle_cpus;
>         unsigned int group_weight;
>         enum group_type group_type;
> -       unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
> -       unsigned int group_smt_balance;  /* Task on busy SMT be moved */
> -       unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
> +       unsigned int group_asym_packing;        /* Tasks should be moved to preferred CPU */
> +       unsigned int group_smt_balance;         /* Task on busy SMT be moved */
> +       unsigned long group_misfit_task_load;   /* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
>         unsigned int nr_numa_running;
>         unsigned int nr_preferred_running;
> @@ -9460,15 +9460,15 @@ struct sg_lb_stats {
>   *              during load balancing.
>   */
>  struct sd_lb_stats {
> -       struct sched_group *busiest;    /* Busiest group in this sd */
> -       struct sched_group *local;      /* Local group in this sd */
> -       unsigned long total_load;       /* Total load of all groups in sd */
> -       unsigned long total_capacity;   /* Total capacity of all groups in sd */
> -       unsigned long avg_load; /* Average load across all groups in sd */
> -       unsigned int prefer_sibling; /* tasks should go to sibling first */
> +       struct sched_group *busiest;            /* Busiest group in this sd */
> +       struct sched_group *local;              /* Local group in this sd */
> +       unsigned long total_load;               /* Total load of all groups in sd */
> +       unsigned long total_capacity;           /* Total capacity of all groups in sd */
> +       unsigned long avg_load;                 /* Average load across all groups in sd */
> +       unsigned int prefer_sibling;            /* tasks should go to sibling first */
>
> -       struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
> -       struct sg_lb_stats local_stat;  /* Statistics of the local group */
> +       struct sg_lb_stats busiest_stat;        /* Statistics of the busiest group */
> +       struct sg_lb_stats local_stat;          /* Statistics of the local group */
>  };
>
>  static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
> --
> 2.40.1
>

