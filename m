Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B79477F6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351000AbjHQM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350988AbjHQM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:56:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A7A2D70
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:56:12 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565f24a24c4so1569146a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692276972; x=1692881772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhlFHqCWd0Vm7mEj4Z62+6NBXifwwaKtpIAPoZOMQ8o=;
        b=NDWpw2C6IshLVt4oKOpsubqy7Jr9e5RXiGdistjd9ZSmgk2B3lr26oLGBTyrBKiLdv
         g6QEDYNZJLCaKfal6I3smUrnEI5cJPYed1CdttJf6wzWObmf6s+kPKp+AZMECzgmFYEJ
         cNdOhPbpEAeJmATbY0pRZ6eLwz9REaR3K2o405BCss7c0cNV5QO0Nx93BlPxcNrVsJ7z
         86gLBY3LqPFvTb585jYtJC7bU7TEN3KPPgR2fwDdEVcxC5O0lSn6H8Bol99xpjt33f/c
         OUG7fXFwhMjnBFngp1/Uiv8DIMBzlYrJyJnc51Z8aHqKMykUhe7/xUAj3/ZJTJ5AkNLf
         LJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276972; x=1692881772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhlFHqCWd0Vm7mEj4Z62+6NBXifwwaKtpIAPoZOMQ8o=;
        b=gKPnocpsLTQ5ZLI0AkOvt5JBuJ8v+DaOHouT1QJB/aCeXgjn+YTxlgJo36wLPmu508
         26JhNS76DFr9V2qHKfEThe7r9uaItTZbZc60/k4b1JJ22P3hDX4Z7RIWoDoRhLZ+YKKm
         mqn2Xejv7eMZG2hON+Uzi6K/1t9FZgSTVKrII6u6db0LGkroJx6BtnKcbwbOQd8nt2Az
         wQtiAxhMLRnKYz1gC78IO8jcE7AzxM26rFNWiuPKhCld/IcTEJ2DCOvEXRL9gEixAeDX
         5GY44HYCrtRewYURfb8PpjaeCfy1TrcgGGZNBSxnwgtefQRFypJFaao4Uf0vTsYNNeJf
         3Q4Q==
X-Gm-Message-State: AOJu0Yz+jWdIdVq/q28iZCcqVMftxewxNV5dtTX/0goJ39MUM1DXaLh4
        2PhaeFz/oUuuzEmVeWUSJENa8DB7IwOBg/wpE/AYFg==
X-Google-Smtp-Source: AGHT+IHltddlEiRmUEPzvWNFsh4mhR2tHvppPPdT4HDVISt+NRUsi1UFQnnKYq2wZhRWjBXxqz7/hK4ZBvVPUgVMHNg=
X-Received: by 2002:a17:90a:f0d1:b0:268:5620:cfc7 with SMTP id
 fa17-20020a17090af0d100b002685620cfc7mr4348867pjb.30.1692276971883; Thu, 17
 Aug 2023 05:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230816024831.682107-1-aaron.lu@intel.com> <20230816024831.682107-2-aaron.lu@intel.com>
In-Reply-To: <20230816024831.682107-2-aaron.lu@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Aug 2023 14:56:00 +0200
Message-ID: <CAKfTPtB6sGva9eZPo2RjW1ZuzUxmKcO-9wBBJ3PJuGT9WtqwsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
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
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 04:48, Aaron Lu <aaron.lu@intel.com> wrote:
>
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
>
>     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
>     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
>
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side. tg->load_avg is per task group and when different tasks
> of the same taskgroup running on different CPUs frequently access
> tg->load_avg, it can be heavily contended.
>
> The frequent access to tg->load_avg is due to task migration on wakeup
> path, e.g. when running postgres_sysbench on a 2sockets/112cores/224cpus
> Intel Sappire Rapids, during a 5s window, the wakeup number is 14millions
> and migration number is 11millions and with each migration, the task's
> load will transfer from src cfs_rq to target cfs_rq and each change
> involves an update to tg->load_avg. Since the workload can trigger as man=
y
> wakeups and migrations, the access(both read and write) to tg->load_avg
> can be unbound. As a result, the two mentioned functions showed noticeabl=
e
> overhead. With netperf/nr_client=3Dnr_cpu/UDP_RR, the problem is worse:
> during a 5s window, wakeup number is 21millions and migration number is
> 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16=
%.
>
> Reduce the overhead by limiting updates to tg->load_avg to at most once
> per ms. After this change, the cost of accessing tg->load_avg is greatly
> reduced and performance improved. Detailed test results below.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> postgres_sysbench on SPR:
> 25%
> base:   42382=C2=B119.8%
> patch:  50174=C2=B19.5%  (noise)
>
> 50%
> base:   67626=C2=B11.3%
> patch:  67365=C2=B13.1%  (noise)
>
> 75%
> base:   100216=C2=B11.2%
> patch:  112470=C2=B10.1% +12.2%
>
> 100%
> base:    93671=C2=B10.4%
> patch:  113563=C2=B10.2% +21.2%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> hackbench on ICL:
> group=3D1
> base:    114912=C2=B15.2%
> patch:   117857=C2=B12.5%  (noise)
>
> group=3D4
> base:    359902=C2=B11.6%
> patch:   361685=C2=B12.7%  (noise)
>
> group=3D8
> base:    461070=C2=B10.8%
> patch:   491713=C2=B10.3% +6.6%
>
> group=3D16
> base:    309032=C2=B15.0%
> patch:   378337=C2=B11.3% +22.4%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> hackbench on SPR:
> group=3D1
> base:    100768=C2=B12.9%
> patch:   103134=C2=B12.9%  (noise)
>
> group=3D4
> base:    413830=C2=B112.5%
> patch:   378660=C2=B116.6% (noise)
>
> group=3D8
> base:    436124=C2=B10.6%
> patch:   490787=C2=B13.2% +12.5%
>
> group=3D16
> base:    457730=C2=B13.2%
> patch:   680452=C2=B11.3% +48.8%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> netperf/udp_rr on ICL
> 25%
> base:    114413=C2=B10.1%
> patch:   115111=C2=B10.0% +0.6%
>
> 50%
> base:    86803=C2=B10.5%
> patch:   86611=C2=B10.0%  (noise)
>
> 75%
> base:    35959=C2=B15.3%
> patch:   49801=C2=B10.6% +38.5%
>
> 100%
> base:    61951=C2=B16.4%
> patch:   70224=C2=B10.8% +13.4%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> netperf/udp_rr on SPR
> 25%
> base:   104954=C2=B11.3%
> patch:  107312=C2=B12.8%  (noise)
>
> 50%
> base:    55394=C2=B14.6%
> patch:   54940=C2=B17.4%  (noise)
>
> 75%
> base:    13779=C2=B13.1%
> patch:   36105=C2=B11.1% +162%
>
> 100%
> base:     9703=C2=B13.7%
> patch:   28011=C2=B10.2% +189%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> netperf/tcp_stream on ICL (all in noise range)
> 25%
> base:    43092=C2=B10.1%
> patch:   42891=C2=B10.5%
>
> 50%
> base:    19278=C2=B114.9%
> patch:   22369=C2=B17.2%
>
> 75%
> base:    16822=C2=B13.0%
> patch:   17086=C2=B12.3%
>
> 100%
> base:    18216=C2=B10.6%
> patch:   18078=C2=B12.9%
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> netperf/tcp_stream on SPR (all in noise range)
> 25%
> base:    34491=C2=B10.3%
> patch:   34886=C2=B10.5%
>
> 50%
> base:    19278=C2=B114.9%
> patch:   22369=C2=B17.2%
>
> 75%
> base:    16822=C2=B13.0%
> patch:   17086=C2=B12.3%
>
> 100%
> base:    18216=C2=B10.6%
> patch:   18078=C2=B12.9%
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  kernel/sched/fair.c  | 13 ++++++++++++-
>  kernel/sched/sched.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e79de26a25d..ab055c72cc64 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3664,7 +3664,8 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq =
*cfs_rq)
>   */
>  static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  {
> -       long delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib=
;
> +       long delta;
> +       u64 now;
>
>         /*
>          * No need to update load_avg for root_task_group as it is not us=
ed.
> @@ -3672,9 +3673,19 @@ static inline void update_tg_load_avg(struct cfs_r=
q *cfs_rq)
>         if (cfs_rq->tg =3D=3D &root_task_group)
>                 return;
>
> +       /*
> +        * For migration heavy workload, access to tg->load_avg can be
> +        * unbound. Limit the update rate to at most once per ms.
> +        */
> +       now =3D sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
> +       if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
> +               return;
> +
> +       delta =3D cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
>         if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
>                 atomic_long_add(delta, &cfs_rq->tg->load_avg);
>                 cfs_rq->tg_load_avg_contrib =3D cfs_rq->avg.load_avg;
> +               cfs_rq->last_update_tg_load_avg =3D now;
>         }
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 19af1766df2d..228a298bf3b5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -594,6 +594,7 @@ struct cfs_rq {
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         unsigned long           tg_load_avg_contrib;
> +       u64                     last_update_tg_load_avg;

Moving last_update_tg_load_avg before tg_load_avg_contrib should
minimize the padding on 32bits arch as long is only 4 Bytes

Apart from this, looks good to me

>         long                    propagate;
>         long                    prop_runnable_sum;
>
> --
> 2.41.0
>
