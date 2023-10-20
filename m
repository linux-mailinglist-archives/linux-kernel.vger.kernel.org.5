Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0195A7D0751
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376279AbjJTER6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjJTER4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:17:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F60C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:17:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-776f84c6cc7so22022185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697775473; x=1698380273; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p10QhJplTfVa9MZvqlveEBdFbDN5UaTTFg06B/Ul7pI=;
        b=vqWpM287eHkOwtOBfFon2VZmVzIyDaHQ+3hU9BqTsBbEvh+RAym5fwpvhTO2k18WSR
         gyzngBKkg50ErU7FNqEOIfZ6x4qP/jM9BqL7LjpWf8J3buWmn/10gfhDJ3q6oSql59yh
         JJuy76SuZSqQ447AdLYQ986axIGm6V9qMDjto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697775473; x=1698380273;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p10QhJplTfVa9MZvqlveEBdFbDN5UaTTFg06B/Ul7pI=;
        b=uTzjqiiFjtvJyg+ckBOjmvVUvaKsrTvKvk26TCAS3eln0ViQ+rPd5DUvM0L8H6XDAI
         h6mTNje0WTGC/8dE1L80lNmewPuc0Em3lBcT/iSp1WgMl1B1sCjd/VlkfZhDX3sFGX16
         6OYRxoHDV+aE4bHzwXdgofnzuJbhWBdnODEewh8kHEWRKZbIu17+CMTJVQpcm5XM2GFl
         rNliLbLCuNgJU+uMBvJSn6E3ukZg3bUCxUDm/nJiAew/DKdJmXK6hOPy9rQewWrYkSVc
         aNiKizTYJeRnyyGyb33Fr8U0aFni/DadZtSFgTo5whEqOrDv4nmVDacMQd2B4Sv4Ra2+
         JORA==
X-Gm-Message-State: AOJu0YxKqLju0nmtgY0sCIylUCmIgupDzaKlrDHpyLfYx00Co+qmheFI
        UzKC4dMb3TC3jGcio7WsUpj2cw==
X-Google-Smtp-Source: AGHT+IEJFd1kHdvUmHlRNYQ68o4TShHhfaUL5LVXE77CC8DwaR4QbRaCNhw07ESkvWTSBq21Ct1gsw==
X-Received: by 2002:a05:620a:4101:b0:778:8822:9a3f with SMTP id j1-20020a05620a410100b0077888229a3fmr754712qko.63.1697775473213;
        Thu, 19 Oct 2023 21:17:53 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.64])
        by smtp.gmail.com with ESMTPSA id 15-20020a05620a078f00b0077434d0f06esm326087qka.52.2023.10.19.21.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 21:17:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] sched/nohz: Update nohz.next_balance directly without IPIs (v2)
Date:   Fri, 20 Oct 2023 00:17:41 -0400
Message-Id: <13DD3CFC-BACE-41F6-831D-E927147A871A@joelfernandes.org>
References: <20231020014031.919742-1-joel@joelfernandes.org>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
In-Reply-To: <20231020014031.919742-1-joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2023, at 9:40 PM, Joel Fernandes (Google) <joel@joelfernandes.o=
rg> wrote:
>=20
> =EF=BB=BFWhenever a CPU stops its tick, it now requires another idle CPU t=
o handle the
> balancing for it because it can't perform its own periodic load balancing.=

> This means it might need to update 'nohz.next_balance' to 'rq->next_balanc=
e' if
> the upcoming nohz-idle load balancing is too distant in the future. This u=
pdate
> process is done by triggering an ILB, as the general ILB handler
> (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle=
 CPUs
> and selecting the smallest value.

Unfortunately this patch still has a subtle issue where we can miss a nohz b=
alance
when the tick is stopped.

Sorry we realized only after sending. Thanks for bearing with us. We have
a fix in the works.

Feel free review the other 2 patches though. Will keep working on it and tha=
nks!

- Joel & Vineeth


>=20
> Triggering this ILB is achieved in current mainline by setting the
> NOHZ_NEXT_KICK flag. This primarily results in the ILB handler updating
> 'nohz.next_balance' while possibly not doing any load balancing at all.
> However, sending an IPI merely to refresh 'nohz.next_balance' seems
> excessive. This patch therefore directly sets nohz.next_balance from the
> CPU stopping the tick.
>=20
> Testing shows a considerable reduction in IPIs when doing this:
>=20
> Running "cyclictest -i 100 -d 100 --latency=3D1000 -t -m" on a 4vcpu VM
> the IPI call count profiled over 10s period is as follows:
> without fix: ~10500
> with fix: ~1000
>=20
> Also just to note, without this patch we observe the following pattern:
>=20
> 1. A CPU is about to stop its tick.
> 2. It sets nohz.needs_update to 1.
> 3. It then stops its tick and goes idle.
> 4. The scheduler tick on another CPU checks this flag and decides an ILB k=
ick
>   is needed.
> 5. The ILB CPU ends up being the one that just stopped its tick!
> 6. This results in an IPI to the tick-stopped CPU which ends up waking it u=
p
>   and disturbing it!
>=20
> Finally, this patch also avoids having to go through all the idle CPUs
> just to update nohz.next_balance when the tick is stopped.
>=20
> Previous version of patch had some issues which are addressed now:
> https://lore.kernel.org/all/20231005161727.1855004-1-joel@joelfernandes.or=
g/
>=20
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a=
 CPU goes NOHZ-idle")
> Co-developed-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> kernel/sched/fair.c  | 44 +++++++++++++++++++++++++++++---------------
> kernel/sched/sched.h |  5 +----
> 2 files changed, 30 insertions(+), 19 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb225921bbca..965c30fbbe5c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6627,7 +6627,6 @@ static struct {
>    cpumask_var_t idle_cpus_mask;
>    atomic_t nr_cpus;
>    int has_blocked;        /* Idle CPUS has blocked load */
> -    int needs_update;        /* Newly idle CPUs need their next_balance c=
ollated */
>    unsigned long next_balance;     /* in jiffy units */
>    unsigned long next_blocked;    /* Next update of blocked load in jiffie=
s */
> } nohz ____cacheline_aligned;
> @@ -11687,9 +11686,6 @@ static void nohz_balancer_kick(struct rq *rq)
> unlock:
>    rcu_read_unlock();
> out:
> -    if (READ_ONCE(nohz.needs_update))
> -        flags |=3D NOHZ_NEXT_KICK;
> -
>    if (flags)
>        kick_ilb(flags);
> }
> @@ -11740,6 +11736,20 @@ static void set_cpu_sd_state_idle(int cpu)
>    rcu_read_unlock();
> }
>=20
> +static inline void
> +update_nohz_next_balance(unsigned long next_balance)
> +{
> +    unsigned long nohz_next_balance;
> +
> +    /* In event of a race, only update with the earliest next_balance. */=

> +    do {
> +        nohz_next_balance =3D READ_ONCE(nohz.next_balance);
> +        if (!time_after(nohz_next_balance, next_balance))
> +            break;
> +    } while (!try_cmpxchg(&nohz.next_balance, &nohz_next_balance,
> +                 next_balance));
> +}
> +
> /*
>  * This routine will record that the CPU is going idle with tick stopped.
>  * This info will be used in performing idle load balancing in the future.=

> @@ -11786,13 +11796,13 @@ void nohz_balance_enter_idle(int cpu)
>    /*
>     * Ensures that if nohz_idle_balance() fails to observe our
>     * @idle_cpus_mask store, it must observe the @has_blocked
> -     * and @needs_update stores.
> +     * store.
>     */
>    smp_mb__after_atomic();
>=20
>    set_cpu_sd_state_idle(cpu);
>=20
> -    WRITE_ONCE(nohz.needs_update, 1);
> +    update_nohz_next_balance(rq->next_balance);
> out:
>    /*
>     * Each time a cpu enter idle, we assume that it has blocked load and
> @@ -11829,6 +11839,7 @@ static void _nohz_idle_balance(struct rq *this_rq,=
 unsigned int flags)
>    /* Earliest time when we have to do rebalance again */
>    unsigned long now =3D jiffies;
>    unsigned long next_balance =3D now + 60*HZ;
> +    unsigned long old_nohz_next_balance;
>    bool has_blocked_load =3D false;
>    int update_next_balance =3D 0;
>    int this_cpu =3D this_rq->cpu;
> @@ -11837,6 +11848,8 @@ static void _nohz_idle_balance(struct rq *this_rq,=
 unsigned int flags)
>=20
>    SCHED_WARN_ON((flags & NOHZ_KICK_MASK) =3D=3D NOHZ_BALANCE_KICK);
>=20
> +    old_nohz_next_balance =3D READ_ONCE(nohz.next_balance);
> +
>    /*
>     * We assume there will be no idle load after this update and clear
>     * the has_blocked flag. If a cpu enters idle in the mean time, it will=

> @@ -11844,13 +11857,9 @@ static void _nohz_idle_balance(struct rq *this_rq=
, unsigned int flags)
>     * Because a cpu that becomes idle, is added to idle_cpus_mask before
>     * setting the flag, we are sure to not clear the state and not
>     * check the load of an idle cpu.
> -     *
> -     * Same applies to idle_cpus_mask vs needs_update.
>     */
>    if (flags & NOHZ_STATS_KICK)
>        WRITE_ONCE(nohz.has_blocked, 0);
> -    if (flags & NOHZ_NEXT_KICK)
> -        WRITE_ONCE(nohz.needs_update, 0);
>=20
>    /*
>     * Ensures that if we miss the CPU, we must see the has_blocked
> @@ -11874,8 +11883,6 @@ static void _nohz_idle_balance(struct rq *this_rq,=
 unsigned int flags)
>        if (need_resched()) {
>            if (flags & NOHZ_STATS_KICK)
>                has_blocked_load =3D true;
> -            if (flags & NOHZ_NEXT_KICK)
> -                WRITE_ONCE(nohz.needs_update, 1);
>            goto abort;
>        }
>=20
> @@ -11906,12 +11913,19 @@ static void _nohz_idle_balance(struct rq *this_r=
q, unsigned int flags)
>    }
>=20
>    /*
> -     * next_balance will be updated only when there is a need.
> +     * nohz.next_balance will be updated only when there is a need.
>     * When the CPU is attached to null domain for ex, it will not be
>     * updated.
> +     *
> +     * Also, if it changed since we scanned the nohz CPUs above, do nothi=
ng as:
> +     * 1. A concurrent call to _nohz_idle_balance() moved nohz.next_balan=
ce forward.
> +     * 2. nohz_balance_enter_idle moved it backward.
>     */
> -    if (likely(update_next_balance))
> -        nohz.next_balance =3D next_balance;
> +    if (likely(update_next_balance)) {
> +        /* Pairs with the smp_mb() above. */
> +        cmpxchg_release(&nohz.next_balance, old_nohz_next_balance,
> +                next_balance);
> +    }
>=20
>    if (flags & NOHZ_STATS_KICK)
>        WRITE_ONCE(nohz.next_blocked,
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 04846272409c..cf3597d91977 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2874,7 +2874,6 @@ extern void cfs_bandwidth_usage_dec(void);
> #define NOHZ_BALANCE_KICK_BIT    0
> #define NOHZ_STATS_KICK_BIT    1
> #define NOHZ_NEWILB_KICK_BIT    2
> -#define NOHZ_NEXT_KICK_BIT    3
>=20
> /* Run rebalance_domains() */
> #define NOHZ_BALANCE_KICK    BIT(NOHZ_BALANCE_KICK_BIT)
> @@ -2882,10 +2881,8 @@ extern void cfs_bandwidth_usage_dec(void);
> #define NOHZ_STATS_KICK        BIT(NOHZ_STATS_KICK_BIT)
> /* Update blocked load when entering idle */
> #define NOHZ_NEWILB_KICK    BIT(NOHZ_NEWILB_KICK_BIT)
> -/* Update nohz.next_balance */
> -#define NOHZ_NEXT_KICK        BIT(NOHZ_NEXT_KICK_BIT)
>=20
> -#define NOHZ_KICK_MASK    (NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEX=
T_KICK)
> +#define NOHZ_KICK_MASK    (NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
>=20
> #define nohz_flags(cpu)    (&cpu_rq(cpu)->nohz_flags)
>=20
> --=20
> 2.42.0.655.g421f12c284-goog
>=20
