Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664EC7D10A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377423AbjJTNk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJTNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:40:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A91A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:40:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27dc1e4d8b6so720697a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697809226; x=1698414026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AT1Br+4645wEB5/HzxukaZG+ZkWVdG8KDMFjDfmpMR0=;
        b=qbRjv4WxxZWPGDr5BJXFP1Tap7CP+xxfPsuNaDkqO97idukHUqVa5G2Z9RhTtLE5aW
         50XpT9THgn+gkgGwDDN/G1vM/OUl2J7yxS3J2FdRsIQHIWmATr8/cPQtDBF+T/5dAT8o
         V7ZQZnVYKeWTcTGQGB5fR8h+sjaufc9wF7HwF8EWEcpwbbgaC+3FujHe9NYUsPlozV6G
         7cFY1zBc0kbVpGGHQ3em4KsnpMYnsZkN83+fqJi0mMKkH0CNGJMjYSU3l/qcLSdpq1P+
         MGj5VIsuxucCi6LUWl1tFX+WbW9ySJJ+f6dnlr2SuBA4P7+E9+pkuvN5wwMNDf8Ylj30
         0Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697809226; x=1698414026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT1Br+4645wEB5/HzxukaZG+ZkWVdG8KDMFjDfmpMR0=;
        b=sufVLcLpTnv5FXu457mzg9LDck7EskkfblO8Lz203fKlWVwffhdSyJ28tKwJxIBt78
         SxbDO3qIeb/NiRO/0ajidLo2LlGqwafZ1VXsHvhHLtWbhjktyufx3UXBX5nDkb6vC7Dj
         qfu0TamYzgD7LHaOMn/U1pq+Rcd6dMZn6P7HoybDViOr6ta4PNTJA0fmSJtnizDMn7LZ
         x38gXvivr4e5JiJonje2uMdyBemn59wJ5vmF37BpMg85wNujJ142mUzBUI2pD7HWSKY9
         xoj3W9O93HrYuunHOjXMfyaL4i7pRJn3wXRtygvX64Qwezj5VFzpFP2Y9ZIxrqtIoeTw
         WgIQ==
X-Gm-Message-State: AOJu0YwOj1AwoNe0rW7NrLpcsjgejwvCOZCSVxeNc3KzQrmwStLAmoQX
        xATvzuN/JryKVJCvmL6n+Xf9wBB1v49X+gxWv15jRA==
X-Google-Smtp-Source: AGHT+IECz/CVOb9yev+sghuyrhjeIz9jIXd/yZPfDbanPu/iz6U5KuCKzJ3ra8LiNpjSBdKvwxg2v3eM7W2UOt4dSq4=
X-Received: by 2002:a17:90a:31c:b0:27d:68e1:c3d6 with SMTP id
 28-20020a17090a031c00b0027d68e1c3d6mr1924087pje.28.1697809225932; Fri, 20 Oct
 2023 06:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231020014031.919742-1-joel@joelfernandes.org> <20231020014031.919742-3-joel@joelfernandes.org>
In-Reply-To: <20231020014031.919742-3-joel@joelfernandes.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Oct 2023 15:40:14 +0200
Message-ID: <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
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

On Fri, 20 Oct 2023 at 03:40, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
>
> When newidle balancing triggers, we see that it constantly clobbers
> rq->next_balance even when there is no newidle balance happening due to
> the cost estimates.  Due to this, we see that periodic load balance
> (rebalance_domains) may trigger way more often when the CPU is going in
> and out of idle at a high rate but is no really idle. Repeatedly
> triggering load balance there is a bad idea as it is a heavy operation.
> It also causes increases in softirq.

we have 2 balance intervals:
- one when idle based on the sd->balance_interval = sd_weight
- one when busy which increases the period by multiplying it with
busy_factor = 16

When becoming idle, the rq->next_balance can have been set using the
16*sd_weight period so load_balance can wait for a long time before
running idle load balance for this cpu.
As a typical example, instead of waiting at most 8ms, we will wait
128ms before we try to pull a task on the idle CPU.

That's the reason for updating rq->next_balance in newidle_balance()

>
> Another issue is ->last_balance is not updated after newidle balance
> causing mistakes in the ->next_balance calculations.

newly idle load balance is not equal to idle load balance. It's a
light load balance trying to pull one  task and you can't really
consider it to the normal load balance

>
> Fix by updating last_balance when a newidle load balance actually
> happens and then updating next_balance. This is also how it is done in
> other load balance paths.
>
> Testing shows a significant drop in softirqs when running:
> cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q
>
> Goes from ~6k to ~800.

Even if your figures look interesting, your patch adds regression in
the load balance and the fairness.

We can probably do improve the current behavior for decreasing number
of ILB but your proposal is not the right solution IMO

>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e276d12c3cb..b147ad09126a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12076,11 +12076,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>         if (!READ_ONCE(this_rq->rd->overload) ||
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> -
> -               if (sd)
> -                       update_next_balance(sd, &next_balance);
>                 rcu_read_unlock();
> -
>                 goto out;
>         }
>         rcu_read_unlock();
> @@ -12095,8 +12091,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                 int continue_balancing = 1;
>                 u64 domain_cost;
>
> -               update_next_balance(sd, &next_balance);
> -
>                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>                         break;
>
> @@ -12109,6 +12103,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                         t1 = sched_clock_cpu(this_cpu);
>                         domain_cost = t1 - t0;
>                         update_newidle_cost(sd, domain_cost);
> +                       sd->last_balance = jiffies;
> +                       update_next_balance(sd, &next_balance);
>
>                         curr_cost += domain_cost;
>                         t0 = t1;
> --
> 2.42.0.655.g421f12c284-goog
>
