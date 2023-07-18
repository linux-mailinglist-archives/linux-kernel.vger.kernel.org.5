Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623CF75819B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGRQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGRQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:02:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43161B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:02:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f122ff663eso9560983e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689696123; x=1692288123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zudn28SVkhjo+/hTVTGicBpmPmYpSTjnBiEPonss/wU=;
        b=ztTKSXO3U2qCS0jn/nLQOY/P12NxroJetwE5WJsOqcM6VNbazmP6VnV2WAewAB0zIR
         2xI5IGFBP652SVJ30P1iOhtljtVuIvvVoyZcGg3URgtfT6Swselgr5EFQ+jw2UAk+FQ1
         ENRvpCRGXfY1IEX+Og0tpWGm+wj11DcZLbIsIe+77uDyYrKaMBrAIoV4b3U5XVrCNVe/
         KtZAEjFjRJRf0PEcYGKHlSMdLmI5y6S6Ezhl/KmdLtMMdM+JzIYtNPIzmTwzciqihHUm
         1VM8AJXFIbUE7iyA3EeCZvam+huRrX7vpSArL7If1M1kYpe9hcCOJcjGr5zWSY+uoCgq
         yhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696123; x=1692288123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zudn28SVkhjo+/hTVTGicBpmPmYpSTjnBiEPonss/wU=;
        b=E058fR9QnkGaP1bWO0hhNOV4eYa9E4bSBlwFC+wCRtpe5SvDny9IqhbqZovaYuyatg
         2sEQGceYUBYFJPmmtfJtPtWJ+yIGuLFZhK/AdQ4kn3USI87QLE1MxYhJ4ED1q8+ajBwv
         3TDvqxVjFTGL+11y0xj6zcIW0Ub4PdDGGmMRdrmSwOeNKQVfR7jMkhE9A00bGwqkTKRr
         zS2GUA7FaqQhgZZHfJ99kvRZrN+ldThUQfgYMziE91Nw/fYtHCTLOuXSWPF7SJAgUD7U
         euIdpEK0tvW/fQUeooIT6dsDPORjLdcoVlNghBNRBWCmajfteW4EGxuxNxPowQh6ldTp
         D1Kg==
X-Gm-Message-State: ABy/qLbEqlXpD4GGbGcKKI+Isx3VruBGeAcZLUnkQ6cjHvfAWhLYaiVP
        v7ALyhSdw6qE+kMxXWO1M8b5IcCJDzxY6jeLvLpCZQ==
X-Google-Smtp-Source: APBJJlEaDhT+UeJWKznBI0lqWQXER6vKvHP2Po7+iAH4TYdht/HOyt/DdIO/J7Xvju3oM/qUrJY7Svte/z/kFxCrsbI=
X-Received: by 2002:a05:6512:3b7:b0:4fb:8987:734e with SMTP id
 v23-20020a05651203b700b004fb8987734emr8656470lfp.68.1689696122837; Tue, 18
 Jul 2023 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230718134120.81199-1-aaron.lu@intel.com> <20230718134120.81199-4-aaron.lu@intel.com>
In-Reply-To: <20230718134120.81199-4-aaron.lu@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Jul 2023 18:01:51 +0200
Message-ID: <CAKfTPtAu33AN6=X82T=yOgm40S8OXi+sPcF0QyD-bYRPV=xPEg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] sched/fair: delay update_tg_load_avg() for
 cfs_rq's removed load
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 15:41, Aaron Lu <aaron.lu@intel.com> wrote:
>
> When a workload involves many wake time task migrations, tg->load_avg
> can be heavily contended among CPUs because every migration involves
> removing the task's load from its src cfs_rq and attach that load to
> its new cfs_rq. Both the remove and attach requires an update to
> tg->load_avg as well as propagating the change up the hierarchy.
>
> E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> migration number is 11millions. Since the workload can trigger many
> wakeups and migrations, the access(both read and write) to tg->load_avg
> can be unbound. For the above said workload, the profile shows
> update_cfs_group() costs ~13% and update_load_avg() costs ~10%. With
> netperf/nr_client=3Dnr_cpu/UDP_RR, the wakeup number is 21millions and
> migration number is 14millions; update_cfs_group() costs ~25% and
> update_load_avg() costs ~16%.
>
> This patch is an attempt to reduce the cost of accessing tg->load_avg.

here you mention tg->load_avg which is updated with update_tg_load_avg()

but your patch below modifies the local update of cfs's util_avg,
runnable_avg  and load_avg which need to be maintained up to date

You should be better to delay or rate limit the call to
update_tg_load_avg() or calc_group_shares()/update_cfs_group() which
access tg->load_avg and are the culprit instead of modifying other
place.

Have you tried to remove update_cfs_group() from enqueue/dequeue and
only let the tick update the share periodically ?

Have you tried to make update_tg_load_avg() return early ? the change
of cfs' load_avg is written in the tg->load_avg only when the change
is bigger than 1.5%. maybe increase it to 6% ?

Or like for update_cfs_group, remove it from attach/detach entity and
let the periodic update to propagate the change

But please don't touch local update of *_avg

>
> Current logic will immediately do a update_tg_load_avg() if cfs_rq has
> removed load; this patch changes this behavior: if this cfs_rq has
> removed load as discovered by update_cfs_rq_load_avg(), it didn't call
> update_tg_load_avg() or propagate the removed load immediately, instead,
> the update to tg->load_avg and propagated load can be dealed with by a
> following event like task attached to this cfs_rq or in
> update_blocked_averages(). This way, the call to update_tg_load_avg()
> for this cfs_rq and its ancestors can be reduced by about half.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> postgres_sysbench(transaction, higher is better)
> nr_thread=3D100%/75%/50% were tested on 2 sockets SPR and Icelake and
> results that have a measuable difference are:
>
> nr_thread=3D100% on SPR:
> base:   90569.11=C2=B11.15%
> node:  104152.26=C2=B10.34%  +15.0%
> delay: 127309.46=C2=B14.25%  +40.6%
>
> nr_thread=3D75% on SPR:
> base:  100803.96=C2=B10.57%
> node:  107333.58=C2=B10.44%   +6.5%
> delay: 124332.39=C2=B10.51%  +23.3%
>
> nr_thread=3D75% on ICL:
> base:  61961.26=C2=B10.41%
> node:  61585.45=C2=B10.50%
> delay: 72420.52=C2=B10.14%  +16.9%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> hackbench/pipe/threads/fd=3D20/loop=3D1000000 (throughput, higher is bett=
er)
> group=3D1/4/8/16 were tested on 2 sockets SPR and Cascade lake and the
> results that have a measuable difference are:
>
> group=3D8 on SPR:
> base:  437163=C2=B12.6%
> node:  471203=C2=B11.2%   +7.8%
> delay: 490780=C2=B10.9%  +12.3%
>
> group=3D16 on SPR:
> base:  468279=C2=B11.9%
> node:  580385=C2=B11.7%  +23.9%
> delay: 664422=C2=B10.2%  +41.9%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> netperf/TCP_STRAM (throughput, higher is better)
> nr_thread=3D1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
> Lake and results that have a measuable difference are:
>
> nr_thread=3D50% on CSL:
> base:  16258=C2=B10.7%
> node:  16172=C2=B12.9%
> delay: 17729=C2=B10.7%  +9.0%
>
> nr_thread=3D75% on CSL:
> base:  12923=C2=B11.2%
> node:  13011=C2=B12.2%
> delay: 15452=C2=B11.6%  +19.6%
>
> nr_thread=3D75% on SPR:
> base:  16232=C2=B111.9%
> node:  13962=C2=B15.1%
> delay: 21089=C2=B10.8%  +29.9%
>
> nr_thread=3D100% on SPR:
> base:  13220=C2=B10.6%
> node:  13113=C2=B10.0%
> delay: 18258=C2=B111.3% +38.1%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> netperf/UDP_RR (throughput, higher is better)
> nr_thread=3D1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
> Lake and results that have measuable difference are:
>
> nr_thread=3D1 on CSL:
> base:  128521=C2=B10.5%
> node:  127935=C2=B10.6%
> delay: 126317=C2=B10.4%  -1.7%
>
> nr_thread=3D75% on CSL:
> base:  36701=C2=B11.7%
> node:  39949=C2=B11.4%   +8.8%
> delay: 42516=C2=B10.3%  +15.8%
>
> nr_thread=3D75% on SPR:
> base:  14249=C2=B13.8%
> node:  19890=C2=B12.0%   +39.6%
> delay: 31331=C2=B10.5%  +119.9%
>
> nr_thread=3D100% on CSL:
> base:  52275=C2=B10.6%
> node:  53827=C2=B10.4%   +3.0%
> delay: 78386=C2=B10.7%  +49.9%
>
> nr_thread=3D100% on SPR:
> base:   9560=C2=B11.6%
> node:  14186=C2=B13.9%   +48.4%
> delay: 20779=C2=B12.8%  +117.4%
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  kernel/sched/fair.c  | 23 ++++++++++++++++++-----
>  kernel/sched/sched.h |  1 +
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aceb8f5922cb..564ffe3e59c1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3645,6 +3645,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq =
*cfs_rq)
>         if (child_cfs_rq_on_list(cfs_rq))
>                 return false;
>
> +       if (cfs_rq->prop_removed_sum)
> +               return false;
> +
>         return true;
>  }
>
> @@ -3911,6 +3914,11 @@ static inline void add_tg_cfs_propagate(struct cfs=
_rq *cfs_rq, long runnable_sum
>  {
>         cfs_rq->propagate =3D 1;
>         cfs_rq->prop_runnable_sum +=3D runnable_sum;
> +
> +       if (cfs_rq->prop_removed_sum) {
> +               cfs_rq->prop_runnable_sum +=3D cfs_rq->prop_removed_sum;
> +               cfs_rq->prop_removed_sum =3D 0;
> +       }
>  }
>
>  /* Update task and its cfs_rq load average */
> @@ -4133,13 +4141,11 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cf=
s_rq)
>                  * removed_runnable is the unweighted version of removed_=
load so we
>                  * can use it to estimate removed_load_sum.
>                  */
> -               add_tg_cfs_propagate(cfs_rq,
> -                       -(long)(removed_runnable * divider) >> SCHED_CAPA=
CITY_SHIFT);
> -
> -               decayed =3D 1;
> +               cfs_rq->prop_removed_sum +=3D
> +                       -(long)(removed_runnable * divider) >> SCHED_CAPA=
CITY_SHIFT;
>         }
>
> -       decayed |=3D __update_load_avg_cfs_rq(now, cfs_rq);
> +       decayed =3D __update_load_avg_cfs_rq(now, cfs_rq);
>         u64_u32_store_copy(sa->last_update_time,
>                            cfs_rq->last_update_time_copy,
>                            sa->last_update_time);
> @@ -9001,6 +9007,13 @@ static bool __update_blocked_fair(struct rq *rq, b=
ool *done)
>
>                         if (cfs_rq =3D=3D &rq->cfs)
>                                 decayed =3D true;
> +
> +                       /*
> +                        * If the aggregated removed_sum hasn't been take=
n care of,
> +                        * deal with it now before this cfs_rq is removed=
 from the list.
> +                        */
> +                       if (cfs_rq->prop_removed_sum)
> +                               add_tg_cfs_propagate(cfs_rq, 0);
>                 }
>
>                 /* Propagate pending load changes to the parent, if any: =
*/
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9cece2dbc95b..ab540b21d071 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -619,6 +619,7 @@ struct cfs_rq {
>         unsigned long           tg_load_avg_contrib;
>         long                    propagate;
>         long                    prop_runnable_sum;
> +       long                    prop_removed_sum;
>
>         /*
>          *   h_load =3D weight * f(tg)
> --
> 2.41.0
>
