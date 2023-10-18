Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2467CE564
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJRRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjJRRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:55:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F7111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFEAC433C8;
        Wed, 18 Oct 2023 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697651703;
        bh=y11GmPUioTTsJkproZ9v5w2ZavV7U/e6HoyPkjTkXGk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B8PKYxWIDVi5wbmumEgOqxlemNvx24AxrJawiyQh8vo/kTyoTZjcxq+QytyeGp308
         zuoFkJpP2fYEgYvzRWTtxs/u1NQ2v/99hn22L9rl4P4eIfHmoufDrqVSD7bMfszSiR
         iMV2bFKwOFcA4y53W3ETa6jbMlbOje+kM0GHPdYpxyRwQDCMCvHQAf/nxEXPz86gPw
         TAMmVpRPY+wcbJm162nkhdtToKT9d79hlAp+Co4wQjDnPNbVzWByrXree/Nuey5IZV
         86GIuLPc6IvXX78hQHg//+dwLNR775j4GGS/6v/7PCmwQxgEvJ/w4FsnUdVzC1X/s8
         dfAB0aF5DQWTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F26CECE0DE3; Wed, 18 Oct 2023 10:55:02 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:55:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ff85b142-c833-4a79-970d-ff691f9b60b7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <20231018103146.4856caa8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018103146.4856caa8@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:31:46AM -0400, Steven Rostedt wrote:
> On Wed, 18 Oct 2023 15:16:12 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
> > > 	might need to do something for non-preemptible RCU to make
> > > 	up for the lack of cond_resched() calls.  Maybe just drop the
> > > 	"IS_ENABLED()" and execute the body of the current "if" statement
> > > 	unconditionally.  
> 
> Right.
> 
> I'm guessing you are talking about this code:
> 
>                 /*
>                  * In some cases, notably when running on a nohz_full CPU with
>                  * a stopped tick PREEMPT_RCU has no way to account for QSs.
>                  * This will eventually cause unwarranted noise as PREEMPT_RCU
>                  * will force preemption as the means of ending the current
>                  * grace period. We avoid this problem by calling
>                  * rcu_momentary_dyntick_idle(), which performs a zero duration
>                  * EQS allowing PREEMPT_RCU to end the current grace period.
>                  * This call shouldn't be wrapped inside an RCU critical
>                  * section.
>                  *
>                  * Note that in non PREEMPT_RCU kernels QSs are handled through
>                  * cond_resched()
>                  */
>                 if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
>                         if (!disable_irq)
>                                 local_irq_disable();
> 
>                         rcu_momentary_dyntick_idle();
> 
>                         if (!disable_irq)
>                                 local_irq_enable();
>                 }

That is indeed the place!

>                 /*
>                  * For the non-preemptive kernel config: let threads runs, if
>                  * they so wish, unless set not do to so.
>                  */
>                 if (!disable_irq && !disable_preemption)
>                         cond_resched();
> 
> 
> 
> If everything becomes PREEMPT_RCU, then the above should be able to be
> turned into just:
> 
>                 if (!disable_irq)
>                         local_irq_disable();
> 
>                 rcu_momentary_dyntick_idle();
> 
>                 if (!disable_irq)
>                         local_irq_enable();
> 
> And no cond_resched() is needed.

Even given that CONFIG_PREEMPT_RCU=n still exists, the fact that
run_osnoise() is running in kthread context with preemption and everything
else enabled (am I right?), then the change you suggest should work fine.

> > Again. There is no non-preemtible RCU with this model, unless I'm
> > missing something important here.
> 
> Daniel?

But very happy to defer to Daniel.  ;-)

							Thanx, Paul
