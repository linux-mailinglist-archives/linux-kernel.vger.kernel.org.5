Return-Path: <linux-kernel+bounces-135052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1CD89BA6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F572838A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDA3985A;
	Mon,  8 Apr 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7xiSuB9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F638F82
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565367; cv=none; b=YlGfdWZE8foToiUUnkrcSs/fm1KoRQa1uzIkNM1BSqkU3MYTvm9eBpxMVCMJDtY/BBa0ZNoVzftFSdWQDrRjypRZQRZTzNyUQLynbvTePKuFRaqrsOE7DJLVUui7So3zin2XYFLmltPyh3mVdNOtVDtY+58CQ+zpwGVs1dPCzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565367; c=relaxed/simple;
	bh=2KvXfDxpGvTs7nicLHoygqjS9zU8Ya7bdOYchMiAGxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8Shpogi92tpJBBXjv4ydmSGrk08j3dyEQElGZ8Uh4strUWJj/ZFgzVApgx5QtOZV6tkCXfDtPDZEyYf2L9XdknLBOc+hM2BGh2O68ic8QTFv1PwMjs0Qc9hycXr4IYD2Tw9LXvaZhk/FyMXTB14Y+PCGj1PyifKe56dMoY2Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7xiSuB9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e41f984d34so5052555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712565364; x=1713170164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieck+aaN2kHUROY0QeEKB3LJ0efWjt+x+5IctTrffoU=;
        b=A7xiSuB9yfopOpm+BUX6CBzPJ4kv9oPoi149SIoFFHccPZJu/dOBLb1tqxOkTlfTx2
         +y3wXwl3duWu3h297KIOrXQxkGctMXHF4tsEWJjH4uT8uMNnH8MInL0K19NV45ojkXwR
         RPNiSJQjokIRxZ8EdLN8/m3irJALsAXE6+B4z6l8eIF7Z0TcpCDTmHM1jD6QKGK0zyRw
         llqA6hLCaLx241ukNrwT6obZdxFeZc+XFXHmPu4EiRM3WifWcobQZVcn/MHDybd36614
         azuODeEVIlDcDZdG+c+5YBunJ3kRjz0zVH1kNz3XmajImWpj4pEscD4vFJyHlRkcuZhp
         BUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565364; x=1713170164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieck+aaN2kHUROY0QeEKB3LJ0efWjt+x+5IctTrffoU=;
        b=Xjwx+t+LaZG659VK3zhA4GYmy4kLZtvPilCgjNbPTR1cY8SvwwaHwlOg/8anaX2i+w
         JqsvXdnnK7O01+UCWPvkBI9AnhuK2dhY6ZZS9cn3q8Vdx4w/2H7Ieui+ox+t4ZqBoJ1W
         9DQiSu94iNbtHoMBSVD6WiXEecEuvM/1YkcQXSUWazelsEB0G6hWe3sBHuA+2AiwX+XW
         0gDPoy8K/bjv16iKzzVbZlelKZa7WczBA/w/Nl9Yo5bjdN2Xq2EfZD6R2q+Q8kwVeril
         TTHqchc8a0NSqpGkxnffC7PNtJuHAin8W5vj/2mSIqCTcSi14CWKzLmgCxqwslTFM6xD
         Zuww==
X-Gm-Message-State: AOJu0YzDuP1bAheVIPx8JYwp1ZOS5ubSkhWw31mIoSQUhWw1T228X2dN
	4ij2fAU7wm1ZsD1AYBJd6DA8s2VsgAFHVH9bo4i6QTLkc19SkxgoXM6BUnA5lYIL/0TisY2rdRm
	V3Y975TAOH340YAz1DmSmnJ3DsxEzXK+OJiwWXA==
X-Google-Smtp-Source: AGHT+IHKeb0f+xWBy55xm1QpQkWYjZ87cuVhjOYFEew4/oFELiJk7+VuImioD91sD1/uegsweduAEn82Biwm69Fk5mU=
X-Received: by 2002:a17:902:d4c7:b0:1e3:e6cb:a33c with SMTP id
 o7-20020a170902d4c700b001e3e6cba33cmr4386858plg.65.1712565364614; Mon, 08 Apr
 2024 01:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405133319.859813-1-beata.michalska@arm.com> <20240405133319.859813-2-beata.michalska@arm.com>
In-Reply-To: <20240405133319.859813-2-beata.michalska@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Apr 2024 10:35:53 +0200
Message-ID: <CAKfTPtBpb-A011icfitvvAY8Z7pSt-cTmQ-TMsWG_3_sREuEmg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] arch_topology: init capacity_freq_ref to 0
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com, 
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	sumitg@nvidia.com, yang@os.amperecomputing.com, lihuisong@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 15:33, Beata Michalska <beata.michalska@arm.com> wrote:
>
> From: Ionela Voinescu <ionela.voinescu@arm.com>
>
> It's useful to have capacity_freq_ref initialized to 0 for users of
> arch_scale_freq_ref() to detect when capacity_freq_ref was not
> yet set.
>
> The only scenario affected by this change in the init value is when a
> cpufreq driver is never loaded. As a result, the only setter of a
> cpu scale factor remains the call of topology_normalize_cpu_scale()
> from parse_dt_topology(). There we cannot use the value 0 of
> capacity_freq_ref so we have to compensate for its uninitialized state.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  drivers/base/arch_topology.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 024b78a0cfc1..7d4c92cd2bad 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -27,7 +27,7 @@
>  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
> -DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
> +DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 0;
>  EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
>
>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
> @@ -292,13 +292,15 @@ void topology_normalize_cpu_scale(void)
>
>         capacity_scale = 1;
>         for_each_possible_cpu(cpu) {
> -               capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> +               capacity = raw_capacity[cpu] *
> +                          (per_cpu(capacity_freq_ref, cpu) ?: 1);
>                 capacity_scale = max(capacity, capacity_scale);
>         }
>
>         pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
>         for_each_possible_cpu(cpu) {
> -               capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> +               capacity = raw_capacity[cpu] *
> +                          (per_cpu(capacity_freq_ref, cpu) ?: 1);
>                 capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
>                         capacity_scale);
>                 topology_set_cpu_scale(cpu, capacity);
> --
> 2.25.1
>

