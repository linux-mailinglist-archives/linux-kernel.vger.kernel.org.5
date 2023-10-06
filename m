Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFC7BB9BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjJFNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjJFNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:48:07 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1119B2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:56 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b5f0d658dso1203271eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696600016; x=1697204816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfUMpCb972x02fuc9xITgOLc26MysozXmGisOPR9cQQ=;
        b=GTDwGYfY6sE+7hKfpqP1cc85CFr2DXc3t2yoO4buRe36IHA/iRC8aS8Lv1LhiW6vXN
         1Ek2w7s31svRS0cqMj4+UkdF2abKc5y9lXYks6cqIwjVjVIc0GPTxdw9afSzFn0pwTqt
         UnyXBb2zb6hwzOLeUTfW8157YAY3C4fxYdSS/sbU1cNBN1Sf514rxgw1m0UuZLxdVUZ9
         Z0DfPQKDcjOFRvvtK73irf+9idgi1DCIgT0PO59KLutm6rhuwUtglj1B1uTEQBLJMEkh
         Sr4AuVsny9OjFhQK+Tt9Qnhc5fS8WcB0chGkvaZnH359tekVeRCunx82OZZk4AfY8Fj9
         2VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696600016; x=1697204816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfUMpCb972x02fuc9xITgOLc26MysozXmGisOPR9cQQ=;
        b=sx5DiZYNVdTvyMZ4v7xQXU4Npy3X+BtUeU279BGtiruanqta5QEQ8lnHGyA2xUZruA
         CmDakTDHghpD/NUHdQxxXQqdrgK3ooBMmEj+GIZf7SEu6MOqvFSOcnHffcypHmibzuGY
         UYyiJSOZSAZ7tlO6qc6JM/tz1KToPW4ha1aJpKyJy772M+Ssyyt17zP+Tdz1c2OSuG7B
         KflbmMfCoUCbEZPF/JPtEXG3Ed8Q4wEEdbYLHBu/G7fPmDQyd3Opm/ASR9QdsIGfwPBl
         v7xvErGd9hEzIN6tQSIXR3c2GKeMuuuRP7vYYbwUHNyqZIjIE9e80L6m7Qr7c4KtFP7m
         l1eQ==
X-Gm-Message-State: AOJu0YwnjdLqIl4XrjegPZD0HltfvlCybce6EmDNjf4THGsvtosT3sdj
        l4QOLBW0bj2IbKzX2BEQmhnZcr4CBGXVaMBrnctZDw==
X-Google-Smtp-Source: AGHT+IGy6zNajs68BWswIShmRu6tjYSL6FL5FSzQFBDm74lDgsrZUvWRJTCJGacLx5xdE5pGnKj0U2n4CwFXIB8zX78=
X-Received: by 2002:a05:6358:3407:b0:134:e3d2:1e50 with SMTP id
 h7-20020a056358340700b00134e3d21e50mr7278311rwd.18.1696600015719; Fri, 06 Oct
 2023 06:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231005161727.1855004-1-joel@joelfernandes.org>
In-Reply-To: <20231005161727.1855004-1-joel@joelfernandes.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Oct 2023 15:46:44 +0200
Message-ID: <CAKfTPtC8Qhr+jjXmwdxCNE5f3etuqg=WpZ6icUFpT9Lg+-pwmg@mail.gmail.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 18:17, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: Vineeth Pillai <vineethrp@google.com>
>
> Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> balancing for it because it can't perform its own periodic load balancing.
> This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> the upcoming nohz-idle load balancing is too distant in the future. This update
> process is done by triggering an ILB, as the general ILB handler
> (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> and selecting the smallest value.
>
> Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
> primarily results in the ILB handler updating 'nohz.next_balance' while
> possibly not doing any load balancing at all. However, sending an IPI merely to
> refresh 'nohz.next_balance' seems excessive, and there ought to be a more
> efficient method to update 'nohz.next_balance' from the local CPU.
>
> Fortunately, there already exists a mechanism to directly invoke the ILB
> handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
> setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
> balancing and solely exists to update a CPU's blocked load if it couldn't pull
> more tasks during regular "newly idle balancing" - and it does so without
> having to send any IPIs. Once the flag is set, the ILB handler is called
> directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
> the blocked load without an IPI, in our situation, we aim to refresh
> 'nohz.next_balance' without an IPI but we can piggy back on this.
>
> So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
> indicate nohz.next_balance needs an update via this direct call shortcut. Note
> that we set this flag without knowledge that the tick is about to be stopped,
> because at the point we do it, we have no way of knowing that. However we do
> know that the CPU is about to enter idle. In our testing, the reduction in IPIs
> is well worth updating nohz.next_balance a few more times.
>
> Also just to note, without this patch we observe the following pattern:
>
> 1. A CPU is about to stop its tick.
> 2. It sets nohz.needs_update to 1.
> 3. It then stops its tick and goes idle.
> 4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
> 5. The ILB CPU ends up being the one that just stopped its tick!
> 6. This results in an IPI to the tick-stopped CPU which ends up waking it up
>    and disturbing it!
>
> Testing shows a considerable reduction in IPIs when doing this:
>
> Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
> the IPI call count profiled over 10s period is as follows:
> without fix: ~10500
> with fix: ~1000
>
> Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
>
> [ Joel: wrote commit messages, collaborated on fix, helped reproduce issue etc. ]
>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Hsin Yi <hsinyi@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Vineeth Pillai <vineethrp@google.com>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb225921bbca..2ece55f32782 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
>         /*
>          * Ensures that if nohz_idle_balance() fails to observe our
>          * @idle_cpus_mask store, it must observe the @has_blocked
> -        * and @needs_update stores.
> +        * stores.
>          */
>         smp_mb__after_atomic();
>
>         set_cpu_sd_state_idle(cpu);
>
> -       WRITE_ONCE(nohz.needs_update, 1);

the set of needs_updat here is the main way to set nohz.needs_update
and trigger an update of next_balance so it would be good to explain
why we still need to keep it instead r removing it entirely

>  out:
>         /*
>          * Each time a cpu enter idle, we assume that it has blocked load and
> @@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  }
>
>  /*
> - * Check if we need to run the ILB for updating blocked load before entering
> - * idle state.
> + * Check if we need to run the ILB for updating blocked load and/or updating
> + * nohz.next_balance before entering idle state.
>   */
>  void nohz_run_idle_balance(int cpu)
>  {
>         unsigned int flags;
>
> -       flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> +       flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
> +
> +       if (!flags)
> +               return;
>
>         /*
>          * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
>          * (ie NOHZ_STATS_KICK set) and will do the same.
>          */
> -       if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> -               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> +       if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
> +           !need_resched())
> +               _nohz_idle_balance(cpu_rq(cpu), flags);

This breaks the update of the blocked load.
nohz_newidle_balance() only sets NOHZ_NEWILB_KICK (and not
NOHZ_STATS_KICK) when it wants to update blocked load before going
idle but it then sets NOHZ_STATS_KICK when calling_nohz_idle_balance()
. We only clear NOHZ_NEWILB_KICK  when fetching flags but we test if
other bits have been set by a pending softirq which will do the same.
That's why we use NOHZ_NEWILB_KICK and not NOHZ_STATS_KICK directly.
Similarly you can't directly use NOHZ_NEXT_KICK.

Also note that _nohz_idle_balance() is not robust against parallel run

>  }
>
>  static void nohz_newidle_balance(struct rq *this_rq)
> @@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
>         if (this_rq->avg_idle < sysctl_sched_migration_cost)
>                 return;
>
> +       /* If rq->next_balance before nohz.next_balance, trigger ILB */
> +       if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
> +               atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
> +
>         /* Don't need to update blocked load of idle CPUs*/
>         if (!READ_ONCE(nohz.has_blocked) ||
>             time_before(jiffies, READ_ONCE(nohz.next_blocked)))
> --
> 2.42.0.609.gbb76f46606-goog
>
