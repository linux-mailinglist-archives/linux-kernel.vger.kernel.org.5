Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA07581EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGRQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGRQSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:18:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D311B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:18:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso59164805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689697112; x=1692289112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z43wO3lAuv7Ej8JmdU3xAafMT/Buibeps2tSW7b8N1o=;
        b=Ee0LxE0Bdpbd1B94J3qJEvro+18zFFWdsNtiDwePza2hsxKCtrtUd80UETvDpZiddE
         nVzcG570J0PvnZ6Z2ok3oJXHgBKmPXFy/Je4Mt5mFY6CQbWpy2yFqVG45duqi1wa4Xjf
         QkopK+ZzhFcqQS9JIvsTxlEjhXRuUgyuYMOg9j4ssoAvIfmhFWcVyc4GwOPUbsE48g5j
         spQLKNjxmRBVgAhBotcxoNGkICciS3/ig0QOSs7kifWUokTW2mkr4/g8/zswIknxxomo
         9tCe48CGA1iPkfY0MHrMBghYYTTWXfKtITQSh+6Lyoj6EEaTO70GMmSEZex3zz0Aue3V
         veZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689697112; x=1692289112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z43wO3lAuv7Ej8JmdU3xAafMT/Buibeps2tSW7b8N1o=;
        b=ERkgEB9F7dE5AjRGLMucDUYJKw9a2BOx+r6sMax06+FRW86GFAryr614Hu9FvBJK2S
         Pmi8gjjGGnafk4Kwhew+ouXAJdPXEH3gvIgkYHW4lrPSAI969AhaUf6858Xnjhoimhqs
         05UAo+ZWUR5PwXy9zh4gNSVf78vHmsvQgIsAF7vSJua3OvZOZOTK5WLsev6HrCY0gXYZ
         zEupR+7F+VNdvkngmDtZct8pk0QIUpRaoviSpR04AF5veIABdR0d36aIbohhoEbaMdP+
         ugePXzrNBVY/FuMJy6YZyhehvzoAmGxJr1DTonWTLCSxPNlnrQ4+AJlmaGH0V+8F2X0v
         zGYw==
X-Gm-Message-State: ABy/qLbGc210fHTG3FpEVe9x6AZKbDThZbK8rImnZVjuoypH8aYi2818
        +iwTEPbcH5O4wHEmYRwMcrTCow==
X-Google-Smtp-Source: APBJJlGqWxX+9CcE1E5wEmSUEfzM5kNAsDwlu6qqmAKOJF9/OhwcR7dGFCQevKXEaGXif2coI3oOhA==
X-Received: by 2002:a7b:cd91:0:b0:3fb:b530:a4e4 with SMTP id y17-20020a7bcd91000000b003fbb530a4e4mr2319537wmj.8.1689697111633;
        Tue, 18 Jul 2023 09:18:31 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id y20-20020a05600c365400b003fbfc61d36asm2562025wmq.5.2023.07.18.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:18:30 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:29 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLaKFFjY6NWaJdOq@vingu-book>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/23 14:48, Vincent Guittot wrote:
> Le dimanche 16 juil. 2023 à 02:41:25 (+0100), Qais Yousef a écrit :
> > We've seen cases while running geekbench that an idle little core never
> > pulls a task from a bigger overloaded cluster for 100s of ms and
> > sometimes over a second.
> > 
> > It turned out that the load balance identifies this as a migrate_util
> > type since the local group (little cluster) has a spare capacity and
> > will try to pull a task. But the little cluster capacity is very small
> > nowadays (around 200 or less) and if two busy tasks are stuck on a mid
> > core which has a capacity of over 700, this means the util of each tasks
> > will be around 350+ range. Which is always bigger than the spare
> > capacity of the little group with a single idle core.
> > 
> > When trying to detach_tasks() we bail out then because of the comparison
> > of:
> > 
> > 	if (util > env->imbalance)
> > 		goto next;
> > 
> > In calculate_imbalance() we convert a migrate_util into migrate_task
> > type if the CPU trying to do the pull is idle. But we only do this if
> > env->imbalance is 0; which I can't understand. AFAICT env->imbalance
> > contains the local group's spare capacity. If it is 0, this means it's
> > fully busy.
> > 
> > Removing this condition fixes the problem, but since I can't fully
> > understand why it checks for 0, sending this as RFC. It could be a typo
> > and meant to check for
> > 
> > 	env->imbalance != 0
> > 
> > instead?
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a80a73909dc2..682d9d6a8691 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10288,7 +10288,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >  			 * waiting task in this overloaded busiest group. Let's
> >  			 * try to pull it.
> >  			 */
> > -			if (env->idle != CPU_NOT_IDLE && env->imbalance == 0) {
> > +			if (env->idle != CPU_NOT_IDLE) {
> 
> With this change you completely skip migrate_util for idle and newly idle case
> and this would be too aggressive.

Yeah I didn't have great confidence in it to be honest.

Could you help me understand the meaning of env->imbalance == 0 though? At this
stage its value is

	env->imbalance = max(local->group_capacity, local->group_util) - local->group_util;

which AFAICT is calculating the _spare_ capacity, right? So when we check
env->imbalance == 0 we say if this_cpu is (idle OR newly idle) AND the local
group is fully utilized? Why it must be fully utilized to do the pull? It's
counter intuitive to me. I'm probably misinterpreting something but can't see
it.

> 
> We can do something similar to migrate_load in detach_tasks():
> 
> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d3df5b1642a6..64111ac7e137 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8834,7 +8834,13 @@ static int detach_tasks(struct lb_env *env)
>  		case migrate_util:
>  			util = task_util_est(p);
> 
> -			if (util > env->imbalance)
> +			/*
> +			 * Make sure that we don't migrate too much utilization.
> +			 * Nevertheless, let relax the constraint if
> +			 * scheduler fails to find a good waiting task to
> +			 * migrate.
> +			 */
> +			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
>  				goto next;

Thanks! This looks better but I still see a 100 or 200 ms delay sometimes.
Still debugging it but I _think_ it's a combination of two things:

	1. nr_balance_failed doesn't increment as fast - I see a lot of 0s with
	   occasional 1s and less frequent 2s
	2. something might wake up briefly on that cpu in between load balance,
	   and given how small the littles are they make the required
	   nr_balance_failed to tip the scale even higher


Thanks

--
Qais Yousef

> 
>  			env->imbalance -= util;
> --
> 
> 
> 
> >  				env->migration_type = migrate_task;
> >  				env->imbalance = 1;
> >  			}
> > -- 
> > 2.25.1
> > 
