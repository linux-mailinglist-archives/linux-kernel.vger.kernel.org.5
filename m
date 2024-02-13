Return-Path: <linux-kernel+bounces-63923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D4853667
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D41C1F270E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF65FBAE;
	Tue, 13 Feb 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYZ4DNPF"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE055DF29
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842751; cv=none; b=iQg/GVUYkOR7X2deMMtaPUh/W0L/2jV+nVtCszuiy/RVTw5fDPGG+wTDHyijAjNQkqzLUDhCUPaiZZFNWpwIEQXKCbKpx2U7etEDa0SvnYEN72qG32Zj7QbZLK+ZRR4r8hXnDtzZfT+dmgLER/7GE0rPkPkOemSh3YyvMFUNQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842751; c=relaxed/simple;
	bh=JGKGqteG7pa9oiFGxBsFc/ypgIEdRbcL4bGYyoD5wCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCbtAVIzETtPWUbJDb7ct7EoQUfmESCAAKsiB7MkmUTZLcidUCIVmLBGOjtK2vBnPeHFpAtjXwAxFbi+SgAPZMZZmi2ejM0IjhWheU/5jI4ZobWp2AbFVs+FvoTjen3mYU7dmZXoUIQ5PP+XaABK9k6ruy7yGGj8sdOT38TtsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYZ4DNPF; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd72353d9fso3367786b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707842749; x=1708447549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKaMT9k1GywCRhGtbqWLnybGL6gwpmReHhiJLpce1mY=;
        b=sYZ4DNPFPyX6BtdAF0qJaPchJ9ZSLc2efd2ueMS5AQp0idC9CFLhIorhPy+4wNhYyN
         rSIkNBLUHueX4tkWsqV5S3C9WyzJDKZQEyR7ICdb9q21emhAuByh7+L3eMM9/zWdZiAV
         Cltr7xU3Kex8KbhV1VAB/IdeDX0kO1mESTGFWo5LpX0603KaBg3yhYSezW8NdlAPxzta
         hNx0yC2NrOlVToI97OkUii2t+nJsexVxdXkg3iP5ySGKpjQRZy5UYAvw/XY1idIHxSpd
         l0MCYzhPHMDMJgxmXkVSRQO8Su3sBWhY88GuN3tZnca5SHloQ6Ye7OcCCEIrnLCZUP+B
         2o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842749; x=1708447549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKaMT9k1GywCRhGtbqWLnybGL6gwpmReHhiJLpce1mY=;
        b=ogJStu+J+D4u1erce6X42sbk73dYk2jCYa8QV7sfsHCkw+LtblILGa2NHwUgB6Skqs
         /dZCISCeAO0mZ0fdlsr0egGrOLz7oVQnb0Lmi3fezyeZUuhXhXllRxDjDZ4g1EmJ4GoW
         95Ra+5ZQ9kRD7r8F1bqPSSs+JgKgtJaz8D/CqHKYKHO2UHN6TIGjkb7cMbxJIzV7kXwi
         /d2lGjpEO6cljqYGmvwsoLt1BpcwsMfkKyO7DDitj0szK7XraLnkZvdi7ucTkV3kugvQ
         YQ7Cpswdtp735ozeIMU8uS9FToZjld+99y+sZUsBxLFpMakp7pbAJp3lMQLziq0N5Q09
         OGAQ==
X-Gm-Message-State: AOJu0Yy3JsYbAHf0vYchGeQXgiIJuHRkna3E6KjVgmKSkubjgJTXn79r
	12vwVZ380a6eItatzfTYWwoLlmNtSm9yMfwER/CR8Q+/jCoiwigGV8mGAsO49R0fo9PdUZ3EqmB
	+ax+Q9zW5LJIAUJGzYrUJpFhBTKsT1g+4urlCvA==
X-Google-Smtp-Source: AGHT+IHzgNd6UQAd8qbBbxHPgs0FRvXrbejv/hryrKRSmSp3L+KzCEQz1LTQv+93+2Qx9vvpALYUbyX44zW5hoDK1BY=
X-Received: by 2002:a05:6808:18a9:b0:3c0:3568:8d38 with SMTP id
 bi41-20020a05680818a900b003c035688d38mr8949729oib.47.1707842749307; Tue, 13
 Feb 2024 08:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210113924.1130448-1-alexs@kernel.org>
In-Reply-To: <20240210113924.1130448-1-alexs@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Feb 2024 17:45:37 +0100
Message-ID: <CAKfTPtAyHHD1_4sVzZgj4w7qnU7_eqnBDoMVr1D0Kd1_1t17mw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 12:36, <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> These flags are already documented in include/linux/sched/sd_flags.h.
> Also, add missing SD_CLUSTER and keep the comment on SD_ASYM_PACKING
> as it is a special case.
>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/topology.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..0b33f7b05d21 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1551,11 +1551,12 @@ static struct cpumask           ***sched_domains_numa_masks;
>   *
>   * These flags are purely descriptive of the topology and do not prescribe
>   * behaviour. Behaviour is artificial and mapped in the below sd_init()
> - * function:
> + * function. For details, see include/linux/sched/sd_flags.h.
>   *
> - *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> - *   SD_SHARE_PKG_RESOURCES - describes shared caches
> - *   SD_NUMA                - describes NUMA topologies
> + *   SD_SHARE_CPUCAPACITY
> + *   SD_SHARE_PKG_RESOURCES
> + *   SD_CLUSTER
> + *   SD_NUMA
>   *
>   * Odd one out, which beside describing the topology has a quirk also
>   * prescribes the desired behaviour that goes along with it:
> --
> 2.43.0
>

