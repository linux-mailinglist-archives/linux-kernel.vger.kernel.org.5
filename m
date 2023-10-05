Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D07B9FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjJEO0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjJEOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:24:29 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148E24EA3;
        Thu,  5 Oct 2023 04:35:26 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57b83ff7654so32948eaf.1;
        Thu, 05 Oct 2023 04:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696505724; x=1697110524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tygO0/Unj1OPWc8Mz0QglmIWnjA9+0+dmFzmqyz1J+o=;
        b=k/enZevEUmbB4KETX4y2nKZlitP+O/fGXGJjy+2M4ZrlH+DkeA/aIT/Wlcm4u0ctaP
         k6SBQN2waCKH4WtoCCUwbRZCQCtQcQjujrgRQbOviLrv3ouN4FuHTh4jHQIAx0xtUYrg
         lJ6R8fegRX+dFLWkqcSrC3P7AesLw4iGQD7biSoFEKVzAjohHD/nWQi/scQiErt59xcT
         UHadDnSVjRhCpEOO2N6xxGdggfeyQ3GtUno9SOWPiwTSNakJb9yGqoaXA8eRtesto89s
         vqykgZb81vzcPrYn/G7xuyNBcYZsMnkrBrhE94M+Nng5ZQtOS5evOEMx0nbtqYF7dkuf
         HW8g==
X-Gm-Message-State: AOJu0YzrqiBB3Rdr2s77SB9WmHez5Ybcbh+dAU9MfuyYF7XsDvqJWQ4o
        aUfsYQ4SK9Bz78XN2jofQpvhs0mW58lbAvYiM78=
X-Google-Smtp-Source: AGHT+IEYjTOMTdyxnqxj8++Rbg9c/07xqvdW1Ngb7KJt8os3DU9DAtMjQX4r0q8c449LjmjX2HeX3sAq0hcssOVDRFQ=
X-Received: by 2002:a05:6820:390:b0:57c:6e35:251e with SMTP id
 r16-20020a056820039000b0057c6e35251emr4712190ooj.1.1696505724466; Thu, 05 Oct
 2023 04:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230719130527.8074-1-xuewen.yan@unisoc.com> <ZR6delkbZxl31zuY@gmail.com>
In-Reply-To: <ZR6delkbZxl31zuY@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Oct 2023 13:35:13 +0200
Message-ID: <CAJZ5v0j8T0KUjLzS=MCF1M33KMhf-EVrT1W5Tncr6wnOXUMgwQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, guohua.yan@unisoc.com,
        qyousef@layalina.io, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 1:26 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
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
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
> > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > 2171000
> >
> > At this time, the sg_policy's next_freq would keep 2301000.
> >
> > To prevent the case happen, add the judgment of the need_freq_update flag.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 4492608b7d7f..458d359f5991 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> >        * Except when the rq is capped by uclamp_max.
> >        */
> >       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> > -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> > +         !sg_policy->need_freq_update) {
> >               next_f = sg_policy->next_freq;
> >
> >               /* Restore cached freq as next_freq has changed */
>
> Just wondering about the status of this fix - is it pending in
> some tree, or should we apply it to the scheduler tree?

I have not queued it up yet, so it can be applied to the scheduler tree.

Thanks!
