Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B697E2CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjKFTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:32:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DC8C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:32:15 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5629fdbf8so60728551fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699299134; x=1699903934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7OTagdrCYJNoUUZ8+xdC4tMP9kaJwYxqUqoXu3+oM0=;
        b=UnbJzX/JmQ0838ZNsdTCBLd962vTmfRHpiV9X2nvtdfo/Z86hNRBCf8yROwieKu3C0
         x5yQkz84fntQjBeGf5XR6eKLH4i6AVzA3YZ/XHjlgWDB+8ozK30huKv0LqfMfQfPfUxF
         GouIEfuKmK2zRuYkO2FHStmDaQNkvabSVmuR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299134; x=1699903934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7OTagdrCYJNoUUZ8+xdC4tMP9kaJwYxqUqoXu3+oM0=;
        b=tMwW4WhzZVAoIRb1kH5nNwfLI/jYSggfr7jRz57fSMcd6L07zaFHsyHIeATEMB9WRg
         cghgcSFdSN2kRzqrl2Id+kOW+nt39gmqa18d089/83UfZ9zLl7l/rbXdhPu3IRFcrghc
         UMqhJIemBh89/tXpZofymw939TxhyKhfUzarOM0zjGsO6SKzVtIBdYApBwvtIwrmZ8H+
         vcnX/coAdIwHqsmx9ZxsnmtY5pcHd8dsZ/7pPiJu7Kjps92f6M+72YVySd3HJyLufPSr
         8YACZCEbfb4DIRYEHYUgv59RKoC0dCKjmv0qgACSZx6fZ0XNmxYtQog184iYzazahZ6l
         kkLg==
X-Gm-Message-State: AOJu0YwjkHsVRhfQxp/9bVvtOoIknQDoTkdKJebCBHEsmhbxlKaL9AS5
        BqgRzmySw7GnZ76sRlUYfU1Qlv5v/0sYnAZt2JxGnA==
X-Google-Smtp-Source: AGHT+IEPrzt2aa2AZKmaV6oLkph7YC5hYNdl5HwCIHcbBgdQSJ/iSYfjTK0/C9NyT1XmFMnFslPQetBhi9GNC3Tmnpk=
X-Received: by 2002:a2e:9d47:0:b0:2c2:c450:c2d0 with SMTP id
 y7-20020a2e9d47000000b002c2c450c2d0mr21907921ljj.24.1699299133540; Mon, 06
 Nov 2023 11:32:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699095159.git.bristot@kernel.org> <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
In-Reply-To: <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 6 Nov 2023 14:32:02 -0500
Message-ID: <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sat, Nov 4, 2023 at 6:59=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> Among the motivations for the DL servers is the real-time throttling
> mechanism. This mechanism works by throttling the rt_rq after
> running for a long period without leaving space for fair tasks.
>
> The base dl server avoids this problem by boosting fair tasks instead
> of throttling the rt_rq. The point is that it boosts without waiting
> for potential starvation, causing some non-intuitive cases.
>
> For example, an IRQ dispatches two tasks on an idle system, a fair
> and an RT. The DL server will be activated, running the fair task
> before the RT one. This problem can be avoided by deferring the
> dl server activation.
>
> By setting the zerolax option, the dl_server will dispatch an
> SCHED_DEADLINE reservation with replenished runtime, but throttled.
>
> The dl_timer will be set for (period - runtime) ns from start time.
> Thus boosting the fair rq on its 0-laxity time with respect to
> rt_rq.
>
> If the fair scheduler has the opportunity to run while waiting
> for zerolax time, the dl server runtime will be consumed. If
> the runtime is completely consumed before the zerolax time, the
> server will be replenished while still in a throttled state. Then,
> the dl_timer will be reset to the new zerolax time
>
> If the fair server reaches the zerolax time without consuming
> its runtime, the server will be boosted, following CBS rules
> (thus without breaking SCHED_DEADLINE).
>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  include/linux/sched.h   |   2 +
>  kernel/sched/deadline.c | 100 +++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/fair.c     |   3 ++
>  3 files changed, 103 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5ac1f252e136..56e53e6fd5a0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -660,6 +660,8 @@ struct sched_dl_entity {
>         unsigned int                    dl_non_contending : 1;
>         unsigned int                    dl_overrun        : 1;
>         unsigned int                    dl_server         : 1;
> +       unsigned int                    dl_zerolax        : 1;
> +       unsigned int                    dl_zerolax_armed  : 1;
>
>         /*
>          * Bandwidth enforcement timer. Each -deadline task has its
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1d7b96ca9011..69ee1fbd60e4 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -772,6 +772,14 @@ static inline void replenish_dl_new_period(struct sc=
hed_dl_entity *dl_se,
>         /* for non-boosted task, pi_of(dl_se) =3D=3D dl_se */
>         dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
>         dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
> +
> +       /*
> +        * If it is a zerolax reservation, throttle it.
> +        */
> +       if (dl_se->dl_zerolax) {
> +               dl_se->dl_throttled =3D 1;
> +               dl_se->dl_zerolax_armed =3D 1;
> +       }
>  }
>
>  /*
> @@ -828,6 +836,7 @@ static inline void setup_new_dl_entity(struct sched_d=
l_entity *dl_se)
>   * could happen are, typically, a entity voluntarily trying to overcome =
its
>   * runtime, or it just underestimated it during sched_setattr().
>   */
> +static int start_dl_timer(struct sched_dl_entity *dl_se);
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  {
>         struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> @@ -874,6 +883,28 @@ static void replenish_dl_entity(struct sched_dl_enti=
ty *dl_se)
>                 dl_se->dl_yielded =3D 0;
>         if (dl_se->dl_throttled)
>                 dl_se->dl_throttled =3D 0;
> +
> +       /*
> +        * If this is the replenishment of a zerolax reservation,
> +        * clear the flag and return.
> +        */
> +       if (dl_se->dl_zerolax_armed) {
> +               dl_se->dl_zerolax_armed =3D 0;
> +               return;
> +       }
> +
> +       /*
> +        * A this point, if the zerolax server is not armed, and the dead=
line
> +        * is in the future, throttle the server and arm the zerolax time=
r.
> +        */
> +       if (dl_se->dl_zerolax &&
> +           dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq)=
)) {
> +               if (!is_dl_boosted(dl_se)) {
> +                       dl_se->dl_zerolax_armed =3D 1;
> +                       dl_se->dl_throttled =3D 1;
> +                       start_dl_timer(dl_se);
> +               }
> +       }
>  }
>
>  /*
> @@ -1024,6 +1055,13 @@ static void update_dl_entity(struct sched_dl_entit=
y *dl_se)
>                 }
>
>                 replenish_dl_new_period(dl_se, rq);
> +       } else if (dl_server(dl_se) && dl_se->dl_zerolax) {
> +               /*
> +                * The server can still use its previous deadline, so thr=
ottle
> +                * and arm the zero-laxity timer.
> +                */
> +               dl_se->dl_zerolax_armed =3D 1;
> +               dl_se->dl_throttled =3D 1;
>         }
>  }
>
> @@ -1056,8 +1094,20 @@ static int start_dl_timer(struct sched_dl_entity *=
dl_se)
>          * We want the timer to fire at the deadline, but considering
>          * that it is actually coming from rq->clock and not from
>          * hrtimer's time base reading.
> +        *
> +        * The zerolax reservation will have its timer set to the
> +        * deadline - runtime. At that point, the CBS rule will decide
> +        * if the current deadline can be used, or if a replenishment
> +        * is required to avoid add too much pressure on the system
> +        * (current u > U).
>          */
> -       act =3D ns_to_ktime(dl_next_period(dl_se));
> +       if (dl_se->dl_zerolax_armed) {
> +               WARN_ON_ONCE(!dl_se->dl_throttled);
> +               act =3D ns_to_ktime(dl_se->deadline - dl_se->runtime);

Just a question, here if dl_se->deadline - dl_se->runtime is large,
then does that mean that server activation will be much more into the
future? So say I want to give CFS 30%, then it will take 70% of the
period before CFS preempts RT thus "starving" CFS for this duration. I
think that's Ok for smaller periods and runtimes, though.

I think it does reserve the amount of required CFS bandwidth so it is
probably OK, though it is perhaps letting RT run more initially (say
if CFS tasks are not CPU bound and occasionally wake up, they will
always be hit by the 70% latency AFAICS which may be large for large
periods and small runtimes).

I/we're currently trying these patches on ChromeOS as well.

Just started going over it to understand the patch. Looking nice so
far and thanks,

 - Joel
