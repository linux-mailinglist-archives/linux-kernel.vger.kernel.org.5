Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4D78C8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbjH2Pf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbjH2Pfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:35:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C966193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:35:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c73c21113so4055432f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693323326; x=1693928126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5YHlIj/spIGb25WgPmboHd51WFVfkAnsjfYjRsL8cM=;
        b=l3M6fZpbTGAbAZcEjeRJu675DdzO4coz0X+aEgALXm0YSzZoaIAtnDOtQmVUJsFqz1
         Ktd45WILOda4MVVxqJocGRUO/wVAfgmK9bDpPqvo392kqvYNdOOYCTQ90sqJxIHp4rYt
         No/ca8BKD8YtE+7VZvKbvHTFMi32V21fcwW6akmiawgGtEQdx4wsPSMLCFE0McatRCSm
         w3qVeL4pQL85D8hM1V9IpY0lnIC6FchShUuyu2di+JV21aFJ3gi/yqulfQnCToApx+O1
         pPeWvjal1Sfpe/SXVbg0M5KtO8bTPa/xO8n0tQNBkbzcO7Jg/+klxLQvW9zB7sNbCP2p
         wPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323326; x=1693928126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5YHlIj/spIGb25WgPmboHd51WFVfkAnsjfYjRsL8cM=;
        b=gLX8XnHiwIxkTCmkxypt5iNO9T47dM1ioRFrgV7knAaeK90u2pymuZVg13VKGa7Vqw
         zVAPpyAE0QLa5toBwqAnkT9DflIkndjCX4jN/6WI2Pa1FzG8f+/lkBMHSrNUN38oZ5Rw
         UHIYXSrPJ7OZBpGhxeaLonPrlJ8Is4VqJ9Bi/0hXqNj+ouiWSGgsBTXAsT6UTK00OEAQ
         e4/tAFgTMPeZycOMjCl47puiZaYRMp0fZ9ZKH8ojuRHu5T0o25xqzWA423xgibcK8F0V
         JdAEnnD5LE2uQ/lKmvFtMduJOCmjBzRJ6AV3ECqORPGFnaCL2D76SOOrI8saM+cEw6GW
         w5QA==
X-Gm-Message-State: AOJu0YyOLojXVhwkftAJ56aFXRsoJsqN+BgodAaBQwhVItEB/Tf2qx8R
        9FL9kXMv7SLdpkVeSI8DOBF4vQ==
X-Google-Smtp-Source: AGHT+IHmcxRL2ArpeMHspJ55iW5xs3rMi/dbg23nZB23ux8wnZDfcVHfTEYTbr+n0E6pWbiKAKvBBw==
X-Received: by 2002:a5d:4f91:0:b0:319:664a:aff5 with SMTP id d17-20020a5d4f91000000b00319664aaff5mr22023183wru.37.1693323325918;
        Tue, 29 Aug 2023 08:35:25 -0700 (PDT)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b003143add4396sm14077829wri.22.2023.08.29.08.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 08:35:25 -0700 (PDT)
Date:   Tue, 29 Aug 2023 16:35:24 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/fair: Check a task has a fitting cpu when updating
 misfit
Message-ID: <20230829153524.iswwflqd3iw3uybx@airbuntu>
References: <20230820203429.568884-1-qyousef@layalina.io>
 <CAKfTPtCq+-U34WSUHjs3CkqQM769_Q+FN-5Y+uK=AzdB0YNiLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCq+-U34WSUHjs3CkqQM769_Q+FN-5Y+uK=AzdB0YNiLQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 16:10, Vincent Guittot wrote:
> On Sun, 20 Aug 2023 at 22:34, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > From: Qais Yousef <qais.yousef@arm.com>
> >
> > If a misfit task is affined to a subset of the possible cpus, we need to
> > verify that one of these cpus can fit it. Otherwise the load balancer
> > code will continuously trigger needlessly leading the balance_interval
> > to increase in return and eventually end up with a situation where real
> > imbalances take a long time to address because of this impossible
> > imbalance situation.
> >
> > This can happen in Android world where it's common for background tasks
> > to be restricted to little cores.
> >
> > Similarly if we can't fit the biggest core, triggering misfit is
> > pointless as it is the best we can ever get on this system.
> >
> > To speed the search up, don't call task_fits_cpu() which will repeatedly
> > call uclamp_eff_value() for the same task. Call util_fits_cpu() instead.
> > And only do so when we see a cpu with higher capacity level than
> > passed cpu_of(rq).
> >
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 43 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0b7445cd5af9..f08c5f3bf895 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4853,17 +4853,50 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >  {
> > +       unsigned long uclamp_min, uclamp_max;
> > +       unsigned long util, cap_level;
> > +       bool has_fitting_cpu = false;
> > +       int cpu = cpu_of(rq);
> > +
> >         if (!sched_asym_cpucap_active())
> >                 return;
> >
> > -       if (!p || p->nr_cpus_allowed == 1) {
> > -               rq->misfit_task_load = 0;
> > -               return;
> > -       }
> > +       if (!p || p->nr_cpus_allowed == 1)
> > +               goto out;
> >
> > -       if (task_fits_cpu(p, cpu_of(rq))) {
> > -               rq->misfit_task_load = 0;
> > -               return;
> > +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> > +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> > +       util = task_util_est(p);
> > +
> > +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> > +               goto out;
> > +
> > +       cap_level = capacity_orig_of(cpu);
> > +
> > +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> > +       if (cap_level == SCHED_CAPACITY_SCALE)
> > +               goto out;
> > +
> > +       /*
> > +        * If the task affinity is not set to default, make sure it is not
> > +        * restricted to a subset where no CPU can ever fit it. Triggering
> > +        * misfit in this case is pointless as it has no where better to move
> > +        * to. And it can lead to balance_interval to grow too high as we'll
> > +        * continuously fail to move it anywhere.
> > +        */
> > +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> > +               for_each_cpu(cpu, p->cpus_ptr) {
> 
> I haven't looked at the problem in detail and at other possibilities
> so far but for_each_cpu doesn't scale and update_misfit_status() being
> called in pick_next_task_fair() so you must find another way to detect
> this

Okay, will do.


Thanks

--
Qais Yousef

> 
> 
> > +                       if (cap_level < capacity_orig_of(cpu)) {
> > +                               cap_level = capacity_orig_of(cpu);
> > +                               if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0) {
> > +                                       has_fitting_cpu = true;
> > +                                       break;
> > +                               }
> > +                       }
> > +               }
> > +
> > +               if (!has_fitting_cpu)
> > +                       goto out;
> >         }
> >
> >         /*
> > @@ -4871,6 +4904,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> >          * task_h_load() returns 0.
> >          */
> >         rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> > +       return;
> > +out:
> > +       rq->misfit_task_load = 0;
> >  }
> >
> >  #else /* CONFIG_SMP */
> > --
> > 2.34.1
> >
