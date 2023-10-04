Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874E7B7C67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbjJDJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242068AbjJDJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:40:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD8E8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:39:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so3323067a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696412396; x=1697017196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oigu8aAhegucB1u9jLNtc55kOYYLgQuWD8KQg9b2gcI=;
        b=UZ5SV8SuguDyJ+aWRr6ew979bdHVgucYiOH7iAlKmgQnwK3UrQxqtsRQ0UiRRay7As
         UFiVU30SB58REX6YuLIl9lUY5ON7yRpJtJXKj8t1qtjXLWtHwb+a5ShkFa4bknxxsuD2
         ue0LY9d4n75CsYs7HtFJv1/yzF0XF8/UW/7imbwG339uPnYLJwsuV6FhXLjij1T02S+0
         57t6qMjgOIfTP5qRmzYapNLb+s0xbr3SiDhNMj0Yg/nKGRacmo0jYEUMNMXpX41VnWt6
         RXWLuSP6GttsF+sBcUJXCtwk4YgguIJEQx6bIEWbiYzibIkeh0GQ8L45geYPZKpaRDZE
         OntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412396; x=1697017196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oigu8aAhegucB1u9jLNtc55kOYYLgQuWD8KQg9b2gcI=;
        b=O9vmE1DPgjLI5OLLErsqmuiVjCvgqv23//KqR1tUvK5nCrLfBeAQt4R7cnv/gMT67b
         XMDVVlEJQJqGsaJAtNir0o0Qu3lGfYRHk+/mSaFsxwtBA8ldFeOktX/O3ZkYtfRg7HGf
         bfMyOsfjSkHNPW/lXYQkixIo4m41yf7VtSVrB2Or/eIHvIRaOOREDPJQXPxNsCJnOMh5
         Rsx4/SLyRBfzBoxFGsfDBQkDY+N0UstxY6kigTtDDRCjJZS6Hc3txf9NVPVRWHNNadXK
         VS1/Cyj+IRZ0br+7hbE8qWZaSCkF/mP/byA2ESx6Y8sttfovUeYTAFdI1eDZ58ToKpi3
         pw3w==
X-Gm-Message-State: AOJu0YyMb7S1pK+qil7tuoR4WFbwge4rZg89Ed6a2+0nyOOKxZVHAiiy
        2zOgZvgrdWb7+gAEN7GeDCZ4jG3G8Co=
X-Google-Smtp-Source: AGHT+IFLDp6RCsujrBUwP/nfa0Gza0pYjnt9xOIMYah1uoKblXun2OZkqTSZur2h8Qs04zFHyIvPVw==
X-Received: by 2002:a17:906:73d1:b0:9b6:4b5d:7758 with SMTP id n17-20020a17090673d100b009b64b5d7758mr1643793ejl.68.1696412395859;
        Wed, 04 Oct 2023 02:39:55 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906a40b00b009b64987e1absm2488023ejz.139.2023.10.04.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:39:55 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 11:39:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Update stale comment in try_to_wake_up()
Message-ID: <ZR0y6RJFnOrG2/Nw@gmail.com>
References: <20230731085759.11443-1-zhangqiao22@huawei.com>
 <ZR0w7vtVhiOVI4uD@gmail.com>
 <20231004093323.GK1539@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004093323.GK1539@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 04, 2023 at 11:31:26AM +0200, Ingo Molnar wrote:
> > 
> > * Zhang Qiao <zhangqiao22@huawei.com> wrote:
> > 
> > > Since commit 9b3c4ab3045e ("sched,rcu: Rework
> > > try_invoke_on_locked_down_task()") renamed
> > > try_invoke_on_locked_down_task() to task_call_func().
> > > Now, update some comment about it.
> > > 
> > > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > > ---
> > >  kernel/sched/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0d18c3969f90..540ac33ddb80 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4186,7 +4186,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> > >  	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
> > >  	 * __schedule().  See the comment for smp_mb__after_spinlock().
> > >  	 *
> > > -	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
> > > +	 * A similar smb_rmb() lives in task_call_func().
> > 
> > Except the matching smp_rmb() doesn't live in task_call_func() anymore, so 
> > you now turned a stale comment into a misleading one ...
> 
> It moved, *again*, it's now in __task_needs_rq_lock() :-)

Yeah, I know, see:

   bdf85bec2b1e ("sched/core: Update stale comment in try_to_wake_up()")

Thanks,

	Ingo

====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 4 Oct 2023 11:33:36 +0200
Subject: [PATCH] sched/core: Update stale comment in try_to_wake_up()

The following commit:

  9b3c4ab3045e ("sched,rcu: Rework try_invoke_on_locked_down_task()")

... renamed try_invoke_on_locked_down_task() to task_call_func(),
but forgot to update the comment in try_to_wake_up().

But it turns out that the smp_rmb() doesn't live in task_call_func()
either, it was moved to __task_needs_rq_lock() in:

  91dabf33ae5d ("sched: Fix race in task_call_func()")

Fix that now.

Also fix the s/smb/smp typo while at it.

Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230731085759.11443-1-zhangqiao22@huawei.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 65e10ac34660..f5783cb16791 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4237,7 +4237,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 		 * __schedule().  See the comment for smp_mb__after_spinlock().
 		 *
-		 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
+		 * A similar smp_rmb() lives in __task_needs_rq_lock().
 		 */
 		smp_rmb();
 		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))

