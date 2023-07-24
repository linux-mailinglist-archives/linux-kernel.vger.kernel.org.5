Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32A175EA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGXDhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGXDhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:37:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255CE43;
        Sun, 23 Jul 2023 20:37:11 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9d68a7abaso3015596a34.3;
        Sun, 23 Jul 2023 20:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690169830; x=1690774630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQHL2SGVJ7k2P9/YyZnt/vjomA15yHiF+zeJH91WRBE=;
        b=G3e9tuo2ks08XKsS3Svv/HRzqsepcpbSaMzzqWcMupvwJfCjWQSkLrwmkQ6lEc9MAl
         hCPSI5nBNwzIgQIJVNfmdsN86kmkh+cMM8MbO/oiLrh5gOOqtKX4VizJtG1of+F77XZr
         lCvw7b2hX7xLd/FovyA6E+hiOdY1WZsQVSBq3CguswNuS0Z1qcJSn3Aq9OitQ0HPmvwb
         YsDRHVgOXK/m78OuQnjK+Rly/XJ5e1VA8mFbiEFnY44vM5UcPu3Tmee7uBY6iZmAb/tA
         SrUHguy/8I9/F3eRof5W9wpBjS6/YpVucyWrGx7sLbNyGlLcG9xezN/37bzxehk2qIPz
         2vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690169830; x=1690774630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQHL2SGVJ7k2P9/YyZnt/vjomA15yHiF+zeJH91WRBE=;
        b=gvwGYDMXGz7xn3APrLYvY5eXPkMd7GZ9BwO512okLis0zTCsGNByih/9lMTfCipeMv
         CQZ/e5OcrRJ4SF4cwwhx8WUVxirT8gWolwEmNguoufwAHZCcz61GiQB+wSCDhwH3Jfjb
         tvQcvifuxETtCgt+8nzVKnm1LJna/7uMkozH8TfeZnUkZFQIn3tJY85AGvuY+LLcDMyM
         jw5dBbbrGRqUXLrTatklNoo4Dj3eZZv99Z0bnwjAO6cf3x7hr9jIoVnZX7IsNDzbGTAr
         nMQjVUmz6jRx5smEKj4anH5/LNCvOGKU+txqnEJ2Os5K3ZDZR/MpmNQcra3A2RA6OptA
         bYKQ==
X-Gm-Message-State: ABy/qLZv6yCP7PLZKOm4mZG+F3vEEZBNJGhZSFLteK25UvMVLqPrSgHa
        LeD9GQK7B2MCTaZhtIafdGzCGi5Q3JNEeSWTWbIMxPJVJag=
X-Google-Smtp-Source: APBJJlEjSQhaxfMSgffmQNUcUgBf4zRlkKoy4qQ+/gj54doBwTXv3mBugbwocpbFRevQCOc5WwQp57t28pekVGuwuCk=
X-Received: by 2002:a05:6870:a411:b0:1b4:4935:653f with SMTP id
 m17-20020a056870a41100b001b44935653fmr10219406oal.49.1690169830393; Sun, 23
 Jul 2023 20:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230719130527.8074-1-xuewen.yan@unisoc.com> <20230721221944.dthg3tf25j4qgc2z@airbuntu>
In-Reply-To: <20230721221944.dthg3tf25j4qgc2z@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 24 Jul 2023 11:36:59 +0800
Message-ID: <CAB8ipk8b8ZfwXN7KK-zFVPQ-8i37h64v-wz2ErB3AANaZ9w7aA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, guohua.yan@unisoc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 7:02=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 07/19/23 21:05, Xuewen Yan wrote:
> > When cpufreq's policy is single, there is a scenario that will
> > cause sg_policy's next_freq to be unable to update.
> >
> > When the cpu's util is always max, the cpufreq will be max,
> > and then if we change the policy's scaling_max_freq to be a
> > lower freq, indeed, the sg_policy's next_freq need change to
> > be the lower freq, however, because the cpu_is_busy, the next_freq
> > would keep the max_freq.
> >
> > For example:
> > The cpu7 is single cpu:
> >
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
> > [1] 4737
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
> > pid 4737's current affinity mask: ff
> > pid 4737's new affinity mask: 80
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > 2301000
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
> > 2301000
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling=
_max_freq
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > 2171000
> >
> > At this time, the sg_policy's next_freq would keep 2301000.
> >
> > To prevent the case happen, add the judgment of the need_freq_update fl=
ag.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 4492608b7d7f..458d359f5991 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_=
util_data *hook, u64 time,
> >        * Except when the rq is capped by uclamp_max.
> >        */
> >       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> > -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> > +         !sg_policy->need_freq_update) {
>
> What about sugov_update_single_perf()? It seems to have the same problem,=
 no?

There is no problem in sugov_update_single_perf, because the next_freq
is updated by drivers, maybe the next_freq is not used when using
sugov_update_single_perf..

But  for the last_freq_update_time, I think there are some problems
when using sugov_update_single_perf:
Now, there is no judgment condition for the update of the
last_freq_update_time. That means the last_freq_update_time is always
updated in sugov_update_single_perf.
And in sugov_should_update_freq: it would judge the
freq_update_delay_ns. As a result, If we use the
sugov_update_single_perf, the cpu frequency would only be periodically
updated according to freq_update_delay_ns.
Maybe we should judge the cpufreq_driver_adjust_perf's return value,
if the freq is not updated, the last_freq_update_time also does not
have to update.

Just like:
---
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedu=
til.c
index 458d359f5991..10f18b054f01 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -381,6 +381,7 @@ static void sugov_update_single_perf(struct
update_util_data *hook, u64 time,
        struct sugov_cpu *sg_cpu =3D container_of(hook, struct
sugov_cpu, update_util);
        unsigned long prev_util =3D sg_cpu->util;
        unsigned long max_cap;
+       bool freq_updated;

        /*
         * Fall back to the "frequency" path if frequency invariance is not
@@ -407,10 +408,11 @@ static void sugov_update_single_perf(struct
update_util_data *hook, u64 time,
            sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
                sg_cpu->util =3D prev_util;

-       cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl=
),
+       freq_updated =3D cpufreq_driver_adjust_perf(sg_cpu->cpu,
map_util_perf(sg_cpu->bw_dl),
                                   map_util_perf(sg_cpu->util), max_cap);

-       sg_cpu->sg_policy->last_freq_update_time =3D time;
+       if (freq_updated)
+               sg_cpu->sg_policy->last_freq_update_time =3D time;
 }


BR
Thanks!

---
xuewen
>
> LGTM otherwise.
>
>
> Cheers
>
> --
> Qais Yousef
>
> >               next_f =3D sg_policy->next_freq;
> >
> >               /* Restore cached freq as next_freq has changed */
> > --
> > 2.25.1
> >
