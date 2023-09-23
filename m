Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905267AC051
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjIWKP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjIWKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:15:31 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05649D2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:13:49 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34fe2814b0dso11731765ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1695464022; x=1696068822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUlZCtFTFaUMAp/xTpZ5qPDOY8dQPvRsRwT1ilDrXWM=;
        b=edvEjotEzz3hfnXLblP6hHgKW2AYJyuUapHd4KJ5vGWVKZjeAG8AHcBrBouiwxgLJk
         csoL2KwTpaHYraJHzBt3juYIUSodbrfwwDxG4ObQOV+p1gdaDnbfz8fYdNohDbSbeDlu
         X/tlt132EJjlBOSYYNiNg1RBlqdo8kPW1deBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695464022; x=1696068822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUlZCtFTFaUMAp/xTpZ5qPDOY8dQPvRsRwT1ilDrXWM=;
        b=MdGSOzs+Ds7O/AhXiqjq1xmy3NCuQHeAXWP9R0yJFdzPzLw449nWULHzUKuUb0REBE
         o5aOYxG9Dzr0OEoQcHMou5QyxY254yqd8mPegLjHcwicJ1G5dN7H/p8oVPRLO4kgSidA
         NblpThasaqBkFifI8t6ePLWXD+Mx8pkzoMLRhg2PwY9Eq3s0ZiYNIAaY0dP5fFaDPUpG
         dGhclE1p3ht0OtvqHH6bq2wz53XJYoZkDp3WUQZ4raK5krnUnVMpMCxBET2YVFuV3b0A
         VQm/yZulmH/b38hVdZI+opWBIDxqulwFk4aBN3QqhjRIpkpJh+kTVRvsaRN++ajquyjh
         lcVA==
X-Gm-Message-State: AOJu0Yw0EQVdqJEliOmrbo3Hm2goxxO/UD+2+1rJH4qtcuOOmwlC6fwL
        HW+NVLmzpUQbAD0V6VmcXdgzjw==
X-Google-Smtp-Source: AGHT+IHHCP+E9+z/kkdmvhDa5gOPd1Cuk+81kxCb0+cTNJHDEBGx8NLQ+ABB0VpkMmUcFKJtZBAxTg==
X-Received: by 2002:a05:6e02:1b0d:b0:34f:d665:4c2e with SMTP id i13-20020a056e021b0d00b0034fd6654c2emr2252379ilv.30.1695464021895;
        Sat, 23 Sep 2023 03:13:41 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id j15-20020a02cc6f000000b0043167542398sm1538551jaq.141.2023.09.23.03.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 03:13:41 -0700 (PDT)
Date:   Sat, 23 Sep 2023 10:13:40 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Fix live lock between select_fallback_rq() and
 RT push
Message-ID: <20230923101340.GA3521658@google.com>
References: <20230923011409.3522762-1-joel@joelfernandes.org>
 <20230922214539.4e282609@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922214539.4e282609@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Sep 22, 2023 at 09:45:39PM -0400, Steven Rostedt wrote:
> On Sat, 23 Sep 2023 01:14:08 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > During RCU-boost testing with the TREE03 rcutorture config, I found that
> > after a few hours, the machine locks up.
> > 
> > On tracing, I found that there is a live lock happening between 2 CPUs.
> > One CPU has an RT task running, while another CPU is being offlined
> > which also has an RT task running.  During this offlining, all threads
> > are migrated. The migration thread is repeatedly scheduled to migrate
> > actively running tasks on the CPU being offlined. This results in a live
> > lock because select_fallback_rq() keeps picking the CPU that an RT task
> > is already running on only to get pushed back to the CPU being offlined.
> > 
> > It is anyway pointless to pick CPUs for pushing tasks to if they are
> > being offlined only to get migrated away to somewhere else. This could
> > also add unwanted latency to this task.
> > 
> > Fix these issues by not selecting CPUs in RT if they are not 'active'
> > for scheduling, using the cpu_active_mask. Other parts in core.c already
> > use cpu_active_mask to prevent tasks from being put on CPUs going
> > offline.
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/sched/cpupri.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> > index a286e726eb4b..42c40cfdf836 100644
> > --- a/kernel/sched/cpupri.c
> > +++ b/kernel/sched/cpupri.c
> > @@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
> >  
> >  	if (lowest_mask) {
> >  		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
> > +		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
> 
> What happens if the cpu_active_mask changes right here?
> 
> Is this just making the race window smaller?

It should not be an issue for fixing the live lock because at most that would
cause a few more bounces between the 2 CPUs but eventually once
cpu_active_mask is stable, the CPU being offlined will not be selected for
the push. That's nothing compared to the multi-second live lock that happens
right now.

Also, with this patch I ran the tests for days and could not reproduce the
issue. Without the patch, I hit it in a few hours.

> Something tells me the fix is going to be something a bit more involved.
> But as I'm getting ready for Paris, I can't look at it at the moment.

Thanks for taking a look and safe travels!

 - Joel

