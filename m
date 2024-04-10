Return-Path: <linux-kernel+bounces-138077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94489EC27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1781C20F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15313D269;
	Wed, 10 Apr 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M52vL4hY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F5262A8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734493; cv=none; b=ZkE56ApXa/sQ5EL0MxAxKobj1WqYxlVLpfx27hyT4FH1b2h1qPPs1/B85+1joxPUkz3TSE/zTVQf2ECaGmeJHu6pBEGVd+g4uygbsW7mGpK/1WGaRf5+VqiM0i0tdtXq3aWZJGvcRcAXyAJiHiNm4Xb71HJYvSf//cNmfyB8P7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734493; c=relaxed/simple;
	bh=GzMajnRhVWwSSFCvoCQYcGJ95Q7cO0vkJty02tR1Tr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTGOgvS5BBkcWsVDWo/vIDJbPsnWPOoJgnf2xrov7gD+m6whAlWxM3EX0hgeZ2/c6iYI2Xcg6jhNeDz/KJ2dMEoymwAg5DNufOmTP4Rjx9YhPXZSb4oyjC15W4OOr0+0MLuTfMoXBwFzRdtoyygtOsPoPUtg7sZo/2ozJ70eSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M52vL4hY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0b889901bso52310295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712734491; x=1713339291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bc109Vj6y1Ty15KbbWjVXjECQ7GN3mgz3N6WHdWVWg=;
        b=M52vL4hY6px4aWlfAZyrLH5ayxWqCpgb8X05OWM7RAqVTKJeXWBRq6WrOrZve3HlZO
         yD1d/kOtLyzW69mogHf1Jo/oi089FMMIdKXZYAdhTSatWrVWI0sBPoH6xZZ46d+Jddpp
         UT7EGqyHL1iv/YaEi7rPUIzMaFhX6PYOmSXkHu2eYQpONojxcRVijQibXKgw65aJq/rm
         JTGk2aTf0C5zlNrWOjGb8WFlkk80S4Btndxneb0cEHli361pe1iAGmfq0jTz/x/8Zj/6
         HdbdEBmdWSK7+7RIehR5d0WXFVOR+PctkvBTU67AlnsaQnIYXzz94WjY51v+gI20G6VC
         8Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734491; x=1713339291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bc109Vj6y1Ty15KbbWjVXjECQ7GN3mgz3N6WHdWVWg=;
        b=VRsSxWCUVLBqHfg3aLcEfjoBlOrzr5Qxt48cIJlSKLE5EUF78r3mHWj6JFjV2KnG3B
         d/tAfI0lJdanx/21G6nci/3QnC0VkFPV+YMiyxFMF3em21xoDuN34WJjWoLtThTflqYO
         fZm3pnKX7u2FEvYLqmlVN0lWtC9iPBfNRbM0B1WKKUiitkgrviQCKvZ5EyfBxxTkvcSk
         0l0bSOVxIVgzlFhQju3XDMHDTtRSYdrsybv6woFLOh4yHBMg6orasIcRbVT0sVs6b6uz
         ydoHOIXUKaWGvEtnLPOTkJ1yPR05xsMCf/DptxHTNFO+ib+uysetBOzvMGZ38/6wJfxl
         7wyg==
X-Gm-Message-State: AOJu0YxBrnx4brZylBwz+seQU/P0ZdiZDdUJ8TgqAq4svK1t4mt79I51
	WEWi8ijGfSE01AjB4j6JJeIBPlKT498VLGTG/FiLool61TDOJv2NUxz+TEAotVktUhGTPQYTPR4
	FU09j5OCyVe8iw9h5oc1b3XoZ2PpT9zBiuBYZ9Q==
X-Google-Smtp-Source: AGHT+IGlxr3AmkAOUdY5wvmBDu50i+oXrZ+kc93WdqyjoKCnju5iXMyYdQVJb8Cu0NlNQN5AqWKved7oEiAkrSB/5LE=
X-Received: by 2002:a17:902:d2c5:b0:1e3:e0a5:4cab with SMTP id
 n5-20020a170902d2c500b001e3e0a54cabmr2342777plc.63.1712734491243; Wed, 10 Apr
 2024 00:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409155250.3660517-1-kyle.meyer@hpe.com> <20240409155250.3660517-3-kyle.meyer@hpe.com>
In-Reply-To: <20240409155250.3660517-3-kyle.meyer@hpe.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Apr 2024 09:34:40 +0200
Message-ID: <CAKfTPtAyYbWS=NYxD6B+z3g3A3gOeQ2oD6SSAVijGHi8hi_j3w@mail.gmail.com>
Subject: Re: [PATCH 2/2 RESEND] sched/topology: Optimize topology_span_sane()
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com, 
	andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, russ.anderson@hpe.com, dimitri.sivanich@hpe.com, 
	steve.wahl@hpe.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 17:54, Kyle Meyer <kyle.meyer@hpe.com> wrote:
>
> Optimize topology_span_sane() by removing duplicate comparisons.
>
> The total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 (per non-NUMA scheduling domain level).
>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/topology.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99ea5986038c..b6bcafc09969 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2347,7 +2347,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  static bool topology_span_sane(struct sched_domain_topology_level *tl,
>                               const struct cpumask *cpu_map, int cpu)
>  {
> -       int i;
> +       int i = cpu + 1;
>
>         /* NUMA levels are allowed to overlap */
>         if (tl->flags & SDTL_OVERLAP)
> @@ -2359,9 +2359,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>          * breaking the sched_group lists - i.e. a later get_group() pass
>          * breaks the linking done for an earlier span.
>          */
> -       for_each_cpu(i, cpu_map) {
> -               if (i == cpu)
> -                       continue;
> +       for_each_cpu_from(i, cpu_map) {
>                 /*
>                  * We should 'and' all those masks with 'cpu_map' to exactly
>                  * match the topology we're about to build, but that can only
> --
> 2.44.0
>

