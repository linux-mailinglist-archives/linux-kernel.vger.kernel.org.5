Return-Path: <linux-kernel+bounces-78015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326EC860DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C545CB20F97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB95C8F1;
	Fri, 23 Feb 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6HxZk59"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D517BAC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680730; cv=none; b=Vj0/oivxkVXFNy5jExztqn8Y4/lSAd0gvWzp5DeUNOisit9aWB6EG+LBhBFnz1r2kU+lidEAF7rC9FUOON7xOnS3YMVLP3KtLcLVLoOQ2XNJ7gba2iNYmg/G8rVRaFtEndEe43q6sTIfmSNQqWRK4qHvTzDMbRQSltHSgEEjD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680730; c=relaxed/simple;
	bh=1VYx/axPQ/Y/kZ06Nqv3k98TVq+A97WOfptU9iKYjbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu/POTblgTJl4XOwjg9FluyXMSYlcwKiAb036DRnc0/v5l669cHe6Y/1vWvArROIe2Gw8o/I2kP0yiLH+GIy8qkuTYs1IFXDDyadISXnQ9nVX6F5iwBzkHzdJ1SuXJGQH922rIp12EZ7rjFsjo9r2y2ezClde4sR8ULQRWYdRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6HxZk59; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso513250a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708680728; x=1709285528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6MtRioIoGbmMgxjAxFCCvhtN1+GGLvZzkqp5B6pIt9g=;
        b=z6HxZk59x0V/HjqUOzbuNvs9YPU9uaoJO5b94c7QTZRF3aRwqNgOwiy7l6nEqo49+0
         A7HxRRNLW96J4gbBC9UAD0ruMvZQO5hlv50DWJ8zlGT0u/g8AM/DijNAVNbVPoufHmWc
         N57sFZ83hXGVW5Jeyp21vMj/ifjQdVPSy0jpPVB2+YitF5Dv6fq5HYtzy29kWzRzb02S
         AOZ7a+uXS3xaa9XH2DG+PnOagxTE6sXJpsh5eWnShc2N/S85bmnoj3r3s5MtReBVTf47
         x6NIXZwfI322yimyZ3rcVY6DuX3rTjCQfOVpFYU/rsYrGC2gV0XimzG3/h1ubrB2Jvtl
         mD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680728; x=1709285528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MtRioIoGbmMgxjAxFCCvhtN1+GGLvZzkqp5B6pIt9g=;
        b=F6xExmx+w1IPwMfErM4ip/f2UdyDOkpalj/P/28KpDPFTf6UgMiaRvzTKlZIy7Lv9h
         4O8PKIIWXokqpV2weFX67YBt/qEtJQhcakEjQifRyOXz9Poc1Kp/WTsDQJC1VQJP1eDn
         kE8NJJpAiXoYSvt0M9DwXhLHfRwr/Oi52X/eZOy0o954EB9PuTeUGVVWrblIuKA3s0pd
         pGpyTt7CNU5wZwbqKOAdNwmj/uTwOTHfWbcwuGs7Kuso0gi2PwgKnhcVEJNOKigpQAJ3
         OZfXWQ8KgyycHId0gNrXFaa9/GM0fSpSMM9MGeu6iGE2U7+fPdZhkkgtwbKb3I46IwJI
         qVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYtCkkPgYfBQybrTK2NWcZw225xXpmA2nHVHrHz1W39Xfafm3HIHDURAnbHKeeCdv9HI62siCUC8+YxCEuvvfAMI8DB080fe2WcK9J
X-Gm-Message-State: AOJu0Yx6W4JDcRi+j5m8986764XQ9djbhnSlaTs+RqZgkhKtlpMTuJ6V
	XJafx+SOL65hIr0NIXu4rd52UfRwN7b4bpn2UfbHIR0H4XzRT1SVClV7W2xBcNd748zHClc3Liw
	cZzsXqnFuCMla9ojdxAVOiqTNHtYkkVQ0rEwDUQ==
X-Google-Smtp-Source: AGHT+IHgcMD7lYWOBAfEs/KH+f5tKhGl2C+lRa25s1X4PdXzt4a9gGPZ5TNkiWHH3WHNz3KA1kxIE3aOz33ObHZjUKE=
X-Received: by 2002:a17:90a:3d4c:b0:299:1bf1:9351 with SMTP id
 o12-20020a17090a3d4c00b002991bf19351mr1167066pjf.29.1708680727925; Fri, 23
 Feb 2024 01:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220225622.2626569-1-qyousef@layalina.io> <20240220225622.2626569-4-qyousef@layalina.io>
In-Reply-To: <20240220225622.2626569-4-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 23 Feb 2024 10:31:56 +0100
Message-ID: <CAKfTPtAvmMFL355zrqCebZJg6Su-V_um4X-c629cOJoS09-fdQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] sched/topology: Remove max_cpu_capacity from root_domain
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, 
	Pierre Gondois <Pierre.Gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 23:56, Qais Yousef <qyousef@layalina.io> wrote:
>
> The value is no longer used as we now keep track of max_allowed_capacity
> for each task instead.
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/sched.h    |  2 --
>  kernel/sched/topology.c | 13 ++-----------
>  2 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e85976bd2bab..bc9e598d6f62 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -917,8 +917,6 @@ struct root_domain {
>         cpumask_var_t           rto_mask;
>         struct cpupri           cpupri;
>
> -       unsigned long           max_cpu_capacity;
> -
>         /*
>          * NULL-terminated list of performance domains intersecting with the
>          * CPUs of the rd. Protected by RCU.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 1505677e4247..a57c006d2923 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2513,16 +2513,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         /* Attach the domains */
>         rcu_read_lock();
>         for_each_cpu(i, cpu_map) {
> -               unsigned long capacity;
> -
>                 rq = cpu_rq(i);
>                 sd = *per_cpu_ptr(d.sd, i);
>
> -               capacity = arch_scale_cpu_capacity(i);
> -               /* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
> -               if (capacity > READ_ONCE(d.rd->max_cpu_capacity))
> -                       WRITE_ONCE(d.rd->max_cpu_capacity, capacity);
> -
>                 cpu_attach_domain(sd, d.rd, i);
>
>                 if (lowest_flag_domain(i, SD_CLUSTER))
> @@ -2536,10 +2529,8 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>         if (has_cluster)
>                 static_branch_inc_cpuslocked(&sched_cluster_active);
>
> -       if (rq && sched_debug_verbose) {
> -               pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
> -                       cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> -       }
> +       if (rq && sched_debug_verbose)
> +               pr_info("root domain span: %*pbl\n", cpumask_pr_args(cpu_map));
>
>         ret = 0;
>  error:
> --
> 2.34.1
>

