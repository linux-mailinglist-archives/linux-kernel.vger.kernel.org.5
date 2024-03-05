Return-Path: <linux-kernel+bounces-92179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B1871C57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F131D1F256B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16858206;
	Tue,  5 Mar 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQ55UMMo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10253803
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635840; cv=none; b=hcFvFGsbl7TBXCrZB8Xa4dLxfr9FsmvxpkhP+PE+OjG1IOnFMo19vEmmldm3GEC3S6ioRSVDKLM7tr03Ic362bAVwGWkxfHSe7vsIOJt3/msb1qcayUDYwAnWgFWhItfdvxaze3UJkBE02h5M4JRIa4nynLMvihWf5ZRUpk6oJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635840; c=relaxed/simple;
	bh=XRLKCbj+vl1PicLxaBWBcqGaDSx4R7orNJRDrG5K5Ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bE43cwWuiSZeNjWjDDFtbyGDdjckrnIxc6q4LQEfy3+WUMk5Z1yCUh/ulXSYmuks3ip/zgEERMyQcgk6xUEuc4PDbFo3xFAc2ZgaOczema6yp6wWgQ66oGf09mHyOpoXOtXXE20beaLbP/nhOTY+WS4O5E4Rk9HsP8W0BDfwJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQ55UMMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8W0U6q+MJYRhUv+Z1Y7vHZ72tu+F2YtfxqKt7E155NQ=;
	b=JQ55UMMoc2fNNg7G8p6u4R2AZR02eaOtZZcyS/JA42ijySzeljZrBb2vwCjorDwV7LqrA6
	K5PwsOxcgRgdWHKJb+WNEWbbA0n1llo0mBoxInERUR0ST2SNgbc3jSV+FfOboO5djao7ZN
	87PYPB/EKsmZjJiRRjLHGlwRpqTqWQE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Qg7GGAdnP6WAPyDWDsaIfw-1; Tue, 05 Mar 2024 05:50:36 -0500
X-MC-Unique: Qg7GGAdnP6WAPyDWDsaIfw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f5184049fso74700286d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635836; x=1710240636;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8W0U6q+MJYRhUv+Z1Y7vHZ72tu+F2YtfxqKt7E155NQ=;
        b=o+L6EQ+yTtoRE3ZDYoqWfz8SleObpXQvlzrc4H+Do6Rpmo4+8iLYkpgxVkeOBpwjDu
         bDssA3W85jxLECGsyukJ1uArrtSWMpj3F7HAU67VzlfVNfTp+E6t+IK60xCv1TUpeUrt
         WOTEc5IyYP5AZ26AkCEt5G0WvzU2NqYgoH6Hc9fU5/za+AhLIDGceazOlbGNbV9Al5QQ
         YuilZPqnBDMN4npnme7ErIbaWdZY/Tl0d5Od5LND7Xte1g8Aqrep1pMAcjqIAjSr/Fzi
         /EVUdOdIBJ88ENIqu1Ou8lo5s9LYYqC+gGdGuNBbVdwNZGOyHOeW8Au9CsYKzk9htwJI
         p1qw==
X-Forwarded-Encrypted: i=1; AJvYcCWsaZhbZMAs5UAjVrWMcWkPdoWhMtRxrzcqJVYeKzeUL5dU+L1pcHjBrmydAKlC7HJ57dDvKOb4n6MHbuzGc24ZZDshpA6adoS3sI3q
X-Gm-Message-State: AOJu0YyCSZLTIhR16gD9uEnREdjpbo6RJsIpq+XmgqFjGeHE3CEeZtgH
	Oy7qKix0OieWPMXgJSD+yKOced8vZfSefGOgNeJTMYRiWEeJQvpkkab0SD2Ixujf18u1/BraGos
	q/KWD6FRTKCq1aD09qpObHMIcu0x8ku7VvR3U9AFI+yBZtZUaW3V3bct5TceYng==
X-Received: by 2002:a0c:fd81:0:b0:690:530d:916d with SMTP id p1-20020a0cfd81000000b00690530d916dmr1528303qvr.49.1709635836173;
        Tue, 05 Mar 2024 02:50:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnL9hsrR0aOPUUxDJNm5Wh92OD9IjU0LPcyDuONcv+08ujVeqPjchqdLQ1KGFB+Rg2g2MNdA==
X-Received: by 2002:a0c:fd81:0:b0:690:530d:916d with SMTP id p1-20020a0cfd81000000b00690530d916dmr1528295qvr.49.1709635835851;
        Tue, 05 Mar 2024 02:50:35 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id pg7-20020a0562144a0700b0068d05b81fb2sm6093096qvb.15.2024.03.05.02.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:50:35 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/9] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
In-Reply-To: <20240304094831.3639338-2-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:50:33 +0100
Message-ID: <xhsmhh6hldkau.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> The 'balancing' spinlock added in:
>
>   08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")
>
> ... is taken when the SD_SERIALIZE flag is set in a domain, but in reality it
> is a glorified global atomic flag serializing the load-balancing of
> those domains.
>
> It doesn't have any explicit locking semantics per se: we just
> spin_trylock() it.
>
> Turn it into a ... global atomic flag. This makes it more
> clear what is going on here, and reduces overhead and code
> size a bit:
>
>   # kernel/sched/fair.o: [x86-64 defconfig]
>
>      text	   data	    bss	    dec	    hex	filename
>     60730	   2721	    104	  63555	   f843	fair.o.before
>     60718	   2721	    104	  63543	   f837	fair.o.after
>
> Also document the flag a bit.
>
> No change in functionality intended.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Few comment nits, otherwise:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/sched/fair.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..64ae3d8dc93b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11633,7 +11633,20 @@ static int active_load_balance_cpu_stop(void *data)
>       return 0;
>  }
>
> -static DEFINE_SPINLOCK(balancing);
> +/*
> + * This flag serializes load-balancing passes over large domains
> + * (such as SD_NUMA) - only once load-balancing instance may run
                               ^^^^
                           s/once/one/

Also, currently the flag is only set for domains above the NODE topology
level, sd_init() will reject an architecture that forces SD_SERIALIZE in a
topology level's ->sd_flags(), so what about:

s/(such as SD_NUMA)/(above the NODE topology level)

> + * at a time, to reduce overhead on very large systems with lots
> + * of CPUs and large NUMA distances.
> + *
> + * - Note that load-balancing passes triggered while another one
> + *   is executing are skipped and not re-tried.
> + *
> + * - Also note that this does not serialize sched_balance_domains()
                                               ^^^^^^^^^^^^^^^^^^^^^
Did you mean rebalance_domains()?

> + *   execution, as non-SD_SERIALIZE domains will still be
> + *   load-balanced in parallel.
> + */
> +static atomic_t sched_balance_running = ATOMIC_INIT(0);
>
>  /*
>   * Scale the max load_balance interval with the number of CPUs in the system.
> @@ -11711,7 +11724,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>
>               need_serialize = sd->flags & SD_SERIALIZE;
>               if (need_serialize) {
> -			if (!spin_trylock(&balancing))
> +			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>                               goto out;
>               }
>
> @@ -11729,7 +11742,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>                       interval = get_sd_balance_interval(sd, busy);
>               }
>               if (need_serialize)
> -			spin_unlock(&balancing);
> +			atomic_set_release(&sched_balance_running, 0);
>  out:
>               if (time_after(next_balance, sd->last_balance + interval)) {
>                       next_balance = sd->last_balance + interval;
> --
> 2.40.1


