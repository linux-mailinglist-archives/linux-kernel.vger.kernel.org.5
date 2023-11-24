Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0A7F7360
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjKXME7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:04:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD0D41
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:05:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1378426a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700827504; x=1701432304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wjNxGhDjeKHr8F+xhjRBHs3YO4GliXKBdRwWaSk3GKU=;
        b=MfE8dzLZQcG1CRnGxbR8zziMX2mT5XCZGDQgRQB3U/IylnJ+su4WeHQn9g/IYFjMoi
         BC6lb2rgAdCN09fU8Z9e6o34e0Pp0z7maYJIv4A0e1GN8tTzgKyThWSaSXieATG6BWo0
         W4b9B3hHjqgGvb0UcidkQBvSSZsfVc7FAM98GRVqxW98UyZxh/a9M+pbGbNgGOHvCVTe
         jCPIG5UZUPpggMXlSTs+Jdy7lYeh0vCfqMYPnHT/7d+HM9m5qSsp1JxSKxlX44lmy8gp
         rU7Y7MXR0KO2BluYpCJXHUZubcVPkq5/B5i0G29V8XjW074Ix2aEI4c3Wkb55q76YPeX
         nj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827504; x=1701432304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjNxGhDjeKHr8F+xhjRBHs3YO4GliXKBdRwWaSk3GKU=;
        b=jXx587WWzV1NcUWvlfyqv7z15kJyp+eWctuFW6MdCJVkJK4/vBtRLoXhHhfXdLafRu
         n3ztCSMeJNYo/a4n+sZiYyLnA+noC2oj4MfN2UQKAQOXrkSkHIPDSU3RLrmrlkpHBF3P
         f37LxpzyDZu4Taxgq3FPa+1ZNaLV3nLLjJhaB9/a+tpXPr1UlMu/88vazobm5cAJ9pHt
         q9eMex2XxXDBD3CP7ytJjmJMoveS2+cpgOi4Tf5tarpqzG76i5DrCexQmi57+VhE4FEC
         RGxjH2rDfi7JUrCN1EC8hN8jpVMy7oIeAA+RJBPT/efxNmhaBCMDyLnsRon3apQDpIaP
         kW4Q==
X-Gm-Message-State: AOJu0YwUbyF1nz00N04u0/rUklkurCl24Pm2dTrt9v79kGhKSWtntijh
        a86fGnPh1/SrKHduTj1QzQIcUiC1cs67gOwFHCvqDA==
X-Google-Smtp-Source: AGHT+IGfI00XUBg9W37CEeOxcztc7n4FsUxF8vdKml0nObvAljFCEHzKMeMA5CxV/dmnrjuRxI47Mlkt+955LYAWVOQ=
X-Received: by 2002:a17:90b:4f4d:b0:285:24bb:457c with SMTP id
 pj13-20020a17090b4f4d00b0028524bb457cmr2934120pjb.26.1700827504096; Fri, 24
 Nov 2023 04:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20231122140119.472110-1-vincent.guittot@linaro.org> <4a005396-46fd-443c-be15-6fe0e2a1dea5@arm.com>
In-Reply-To: <4a005396-46fd-443c-be15-6fe0e2a1dea5@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Nov 2023 13:04:51 +0100
Message-ID: <CAKfTPtCAZWp7tRgTpwJmyEAkyN65acmYrfu9naEUpBZVWNTcQA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     lukasz.luba@arm.com, mingo@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, bristot@redhat.com, peterz@infradead.org,
        rafael@kernel.org, vschneid@redhat.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, bsegall@google.com, qyousef@layalina.io,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 11:44, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>
> On 22/11/2023 14:01, Vincent Guittot wrote:
> > [...]
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 07f555857698..eeb505d28905 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4774,6 +4774,11 @@ static inline unsigned long task_util(struct task_struct *p)
> >       return READ_ONCE(p->se.avg.util_avg);
> >   }
> >
> > +static inline unsigned long task_runnable(struct task_struct *p)
> > +{
> > +     return READ_ONCE(p->se.avg.runnable_avg);
> > +}
> > +
> >   static inline unsigned long _task_util_est(struct task_struct *p)
> >   {
> >       struct util_est ue = READ_ONCE(p->se.avg.util_est);
> > @@ -4892,6 +4897,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >       if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> >               return;
> >
> > +     /*
> > +      * To avoid underestimate of task utilization, skip updates of ewma if
> > +      * we cannot grant that thread got all CPU time it wanted.
> > +      */
> > +     if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> > +             goto done;
> > +
> > +
>
> Actually, does this also skip util_est increases as well, assuming no
> FASTUP? When a task is ramping up, another task could join and then
> blocks this task from ramping up its util_est.
>
> Or do we think this is intended behavior for !FASTUP?

sched_feat(UTIL_EST_FASTUP) has been there to disable faster ramp up
in case of regression but I'm not aware of anybody having to disable
it during the last 3 year so we should just delete the sched_feat()
and make faster ramp up  permanent.

>
> >       /*
> >        * Update Task's estimated utilization
> >        *
