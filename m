Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC9784A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHVT2y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 15:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHVT2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:28:53 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E1110D;
        Tue, 22 Aug 2023 12:28:51 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so444336b3a.0;
        Tue, 22 Aug 2023 12:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732531; x=1693337331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUOTEpYouPiI3er3W6uP/bJHtOiZZQik2GTUe+jS9ls=;
        b=iLRcurrDvnWIQUxP+hOmWqb1zKaJqHHIhuYYVipM6tOaqOY0OX79vVHmAu/iNnYLWE
         3D4vtOP03myQcf+tj5fYUrqOAHA3Hjkd7Jyonvvk6e4yUJ+qXZnxBt6ZtCRFBq3Iz02x
         x5loKjJA1HMRST62almteTI6lSaClQiY8qKTjif/u+EhJzV56RnpXTOMXzJbc68q8Nk0
         ytpLE4rs3rRrg3MPTdhDJwsfmtOPtC+Kn5waFKAjmAkKlkOAszhSCfMMAkAOWWCyDVWv
         cklhFyB5TO37sEz5naPHTc2vcIAbAj9GODe1//s6EtLMJai9Qna+t41JUA2bz6Q2myN6
         aFEA==
X-Gm-Message-State: AOJu0YxOtMea1/vBAl954xImcoZMu4ruR1dJ6LgRTw8lSsGpuapU3wMl
        Mokk8WU+L/9NFZ3M/rPz4STDwdGBhFVqx3bPzVA=
X-Google-Smtp-Source: AGHT+IGwvr6LYscPtF6NdLVdbNpxAgF+p1Ak/HskvZqtoetpy1Q5WSMGjR8kBH+18O4q27t2OdyUTx87dMOnveGBtLE=
X-Received: by 2002:a05:6a20:6a05:b0:134:d4d3:f0a5 with SMTP id
 p5-20020a056a206a0500b00134d4d3f0a5mr13624476pzk.2.1692732531185; Tue, 22 Aug
 2023 12:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230719130527.8074-1-xuewen.yan@unisoc.com> <20230721221944.dthg3tf25j4qgc2z@airbuntu>
 <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
 <20230724155328.7odez6dcoafksr3i@airbuntu> <CAB8ipk-VuD2oMDaV6B6i-eoKE+JZ0FpsUZAdT0R5S3to07JkFw@mail.gmail.com>
 <CAJZ5v0gGXyURiqcspDdLf99dKjoFKDRZ=nc55b9OHXRdat8T_w@mail.gmail.com> <CAB8ipk9NBQKjOLurtzTQO8KwQAKLPJ8YGjnLwSo5q1BrPeLSbA@mail.gmail.com>
In-Reply-To: <CAB8ipk9NBQKjOLurtzTQO8KwQAKLPJ8YGjnLwSo5q1BrPeLSbA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 21:28:39 +0200
Message-ID: <CAJZ5v0iPdQZBf0tBCtguP-1H2h4h8umyQ1BebuyAA4u5n2uEfA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Xuewen Yan <xuewen.yan@unisoc.com>, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        guohua.yan@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 2:09 PM Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> Hi Rafael
>
> On Tue, Jul 25, 2023 at 4:51 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 4:21 AM Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> > >
> > > On Mon, Jul 24, 2023 at 11:53 PM Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 07/24/23 11:36, Xuewen Yan wrote:
> > > > > On Sat, Jul 22, 2023 at 7:02 AM Qais Yousef <qyousef@layalina.io> wrote:
> > > > > >
> > > > > > On 07/19/23 21:05, Xuewen Yan wrote:
> > > > > > > When cpufreq's policy is single, there is a scenario that will
> > > > > > > cause sg_policy's next_freq to be unable to update.
> > > > > > >
> > > > > > > When the cpu's util is always max, the cpufreq will be max,
> > > > > > > and then if we change the policy's scaling_max_freq to be a
> > > > > > > lower freq, indeed, the sg_policy's next_freq need change to
> > > > > > > be the lower freq, however, because the cpu_is_busy, the next_freq
> > > > > > > would keep the max_freq.
> > > > > > >
> > > > > > > For example:
> > > > > > > The cpu7 is single cpu:
> > > > > > >
> > > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
> > > > > > > [1] 4737
> > > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
> > > > > > > pid 4737's current affinity mask: ff
> > > > > > > pid 4737's new affinity mask: 80
> > > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > > > > > > 2301000
> > > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
> > > > > > > 2301000
> > > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
> > > > > > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > > > > > > 2171000
> > > > > > >
> > > > > > > At this time, the sg_policy's next_freq would keep 2301000.
> > > > > > >
> > > > > > > To prevent the case happen, add the judgment of the need_freq_update flag.
> > > > > > >
> > > > > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > > > > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > > > > > > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > > > > > > ---
> > > > > > >  kernel/sched/cpufreq_schedutil.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > > > > index 4492608b7d7f..458d359f5991 100644
> > > > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > > > @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> > > > > > >        * Except when the rq is capped by uclamp_max.
> > > > > > >        */
> > > > > > >       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> > > > > > > -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > > > > > +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> > > > > > > +         !sg_policy->need_freq_update) {
> > > > > >
> > > > > > What about sugov_update_single_perf()? It seems to have the same problem, no?
> > > > >
> > > > > There is no problem in sugov_update_single_perf, because the next_freq
> > > > > is updated by drivers, maybe the next_freq is not used when using
> > > > > sugov_update_single_perf..
> > > >
> > > > Ah I see; we just use prev_util but the request will go through and the driver
> > > > should observe the new limit regardless of what util value we pass to it. Got
> > > > ya.
> > > >
> > > > >
> > > > > But  for the last_freq_update_time, I think there are some problems
> > > > > when using sugov_update_single_perf:
> > > > > Now, there is no judgment condition for the update of the
> > > > > last_freq_update_time. That means the last_freq_update_time is always
> > > > > updated in sugov_update_single_perf.
> > > > > And in sugov_should_update_freq: it would judge the
> > > > > freq_update_delay_ns. As a result, If we use the
> > > > > sugov_update_single_perf, the cpu frequency would only be periodically
> > > > > updated according to freq_update_delay_ns.
> > > > > Maybe we should judge the cpufreq_driver_adjust_perf's return value,
> > > > > if the freq is not updated, the last_freq_update_time also does not
> > > > > have to update.
> > > > >
> > > > > Just like:
> > > > > ---
> > > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > > index 458d359f5991..10f18b054f01 100644
> > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > @@ -381,6 +381,7 @@ static void sugov_update_single_perf(struct
> > > > > update_util_data *hook, u64 time,
> > > > >         struct sugov_cpu *sg_cpu = container_of(hook, struct
> > > > > sugov_cpu, update_util);
> > > > >         unsigned long prev_util = sg_cpu->util;
> > > > >         unsigned long max_cap;
> > > > > +       bool freq_updated;
> > > > >
> > > > >         /*
> > > > >          * Fall back to the "frequency" path if frequency invariance is not
> > > > > @@ -407,10 +408,11 @@ static void sugov_update_single_perf(struct
> > > > > update_util_data *hook, u64 time,
> > > > >             sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> > > > >                 sg_cpu->util = prev_util;
> > > > >
> > > > > -       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> > > > > +       freq_updated = cpufreq_driver_adjust_perf(sg_cpu->cpu,
> > > > > map_util_perf(sg_cpu->bw_dl),
> > > > >                                    map_util_perf(sg_cpu->util), max_cap);
> > > > >
> > > > > -       sg_cpu->sg_policy->last_freq_update_time = time;
> > > > > +       if (freq_updated)
> > > > > +               sg_cpu->sg_policy->last_freq_update_time = time;
> > > > >  }
> > > >
> > > > Sound reasonable in principle, but it could lead to overhead; for example when
> > > > the system is busy and maxed out, the last_freq_update_time will never be
> > > > updated and will end up continuously calling to the driver to change frequency
> > > > without any rate limit AFAICS. Which might not be an acceptable overhead,
> > > > I don't know. Logically this is wasted cycles preventing the tasks from doing
> > > > useful work. I think we need to look at such corner cases and treat them
> > > > appropriately to not call the driver if we go with this approach.
> > >
> > > Hi Qais,
> > >
> > > I can understand what you mean, but I don't think this is a problem.
> > > For the driver, the calculation of whether to update the frequency may
> > > not be the main time-consuming, but the main time-consuming may be the
> > > frequency conversion time of the hardware. If the hardware does not
> > > need frequency conversion, the operation of calculating the frequency
> > > takes a very short time.
> > > If the operation of calling the driver frequently is unacceptable, can
> > > prev_util be used?
> >
> > No, it's better to pass the data to the driver directly and let it
> > sort that out in this particular case.
>
> Yes, I know. we should not interfere with the driver's behavior.
>
> By the way, What do you think of the patch fixing the sugov_update_single_freq?

IIUC, you have found a genuine issue and the patch should address it.
