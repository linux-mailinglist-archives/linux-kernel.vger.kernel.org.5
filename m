Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAE7973BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjIGPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbjIGP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC41FE4;
        Thu,  7 Sep 2023 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=30UDpD7H6mzYmx8jrLZsBdMp0E/iK+IE4ikawwxJ9Kw=; b=daUMIbD5H1kGLmZNJbo0BRV+Hk
        x3CHasEN0NaoOrlckQh5evtcsD4LZFlymfiOjnTvHYLiKklebt+AkSUTNq5CRcLVjXvfTU4gZuia3
        dZcazUXEHV4vpem8101/o5mhWVG2RNVKX5pDq0AEJ1TTlQPTmoiG1DmSCwHVCYx2Pu9YXLxGj15UE
        yqRSGNkPrTV47a5cw8FG5tpHXA2JT3T2az+HBRNQxFJdsWahIhthVMPn7DWpBRzYvuwrKiq8ktbWB
        ukq+nce/1o7uPKIXg5OlWeyukW07bTQqa0pycqvXhA62YhxwInoIXoNMATb070p9rjuvz2YF59pY4
        nvD/9DKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeBb8-001jrG-0q;
        Thu, 07 Sep 2023 09:46:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D863300687; Thu,  7 Sep 2023 11:46:51 +0200 (CEST)
Date:   Thu, 7 Sep 2023 11:46:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some
 spurious wakeups
Message-ID: <20230907094651.GB16872@noisy.programming.kicks-ass.net>
References: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
 <20230904212324.GA2568@noisy.programming.kicks-ass.net>
 <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:59:03PM -0700, Elliot Berman wrote:
> 
> 
> On 9/4/2023 2:23 PM, Peter Zijlstra wrote:
> > On Wed, Aug 30, 2023 at 10:42:39AM -0700, Elliot Berman wrote:
> > 
> > > Avoid the spurious wakeups by saving the state of TASK_FREEZABLE tasks.
> > > If the task was running before entering TASK_FROZEN state
> > > (__refrigerator()) or if the task received a wake up for the saved
> > > state, then the task is woken on thaw. saved_state from PREEMPT_RT locks
> > > can be re-used because freezer would not stomp on the rtlock wait flow:
> > > TASK_RTLOCK_WAIT isn't considered freezable.
> > 
> > You don't actually assert that anywhere I think, so the moment someone
> > makes that happen you crash and burn.
> > 
> 
> I can certainly add an assertion on the freezer side.

I think the assertion we have in ttwu_state_match() might be sufficient.

> > Also:
> > 
> > > -#ifdef CONFIG_PREEMPT_RT
> > > +#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
> > 
> > That makes wakeup more horrible for everyone :/
> 
> I don't think the hot wakeup path is significantly impacted because the
> added checks come after the hot path is already not taken.

Perhaps we should start off by doing the below, instead of making it
more complicated instead. I suppose you're right about the overhead, but
run a hackbench just to make sure or something.


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..649ddb9adf0d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -749,11 +749,7 @@ struct task_struct {
 	struct thread_info		thread_info;
 #endif
 	unsigned int			__state;
-
-#ifdef CONFIG_PREEMPT_RT
-	/* saved state for "spinlock sleepers" */
 	unsigned int			saved_state;
-#endif
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..b566821614e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2239,31 +2239,21 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 	if (READ_ONCE(p->__state) & state)
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT
 	if (READ_ONCE(p->saved_state) & state)
 		return -1;
-#endif
+
 	return 0;
 }
 
 static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
-#ifdef CONFIG_PREEMPT_RT
-	int match;
-
 	/*
 	 * Serialize against current_save_and_set_rtlock_wait_state() and
 	 * current_restore_rtlock_saved_state().
 	 */
-	raw_spin_lock_irq(&p->pi_lock);
-	match = __task_state_match(p, state);
-	raw_spin_unlock_irq(&p->pi_lock);
-
-	return match;
-#else
+	guard(spin_lock_irq)(&p->pi_lock);
 	return __task_state_match(p, state);
-#endif
 }
 
 /*
@@ -4056,7 +4046,6 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	*success = !!(match = __task_state_match(p, state));
 
-#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Saved state preserves the task state across blocking on
 	 * an RT lock.  If the state matches, set p::saved_state to
@@ -4072,7 +4061,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 */
 	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-#endif
+
 	return match > 0;
 }
 
