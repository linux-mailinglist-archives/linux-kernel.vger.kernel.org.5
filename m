Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5D7C4BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjJKHat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjJKHar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:30:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE978D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XxvTBcvRjfLauUJMvX0rv6rXasZpfykJyoESqp8dDTY=; b=HWpoIUdWoiOW3zB5+n1nuu7tfB
        0Yv45lVixCmLgcjJW4kkzqyGxvhZDz+rg9tKfBxXs2UR89i8p4rGfhLC6z5Xo6DKeGUtKZHmfdual
        CfqFjlxAl4VY/tPeRjppEMaA8j7RHk75xj3ZJP1W2ySs7nnFg6hk8jgefLn7wxjqjbHGvx2ChBV7Y
        7G36nr/T5qyG8a82SeU34sLFo6t1ErYdWyARkdURBEmc1Yy8Tn/vgf77EGLQd0Zp6n4yWOXh7nbAs
        05sTp2YqizhkSJMV9va6jZZ1MdlRHfqTQlqfnIUQUkSpBEpHSFgMQ1doygn255zapu9P/d73WVZcl
        KqQMAHlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqTfN-009S2G-OE; Wed, 11 Oct 2023 07:30:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6877730026F; Wed, 11 Oct 2023 09:30:01 +0200 (CEST)
Date:   Wed, 11 Oct 2023 09:30:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
Message-ID: <20231011073001.GI14330@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.654144274@infradead.org>
 <75adcb1a-c02f-4d7c-bd9c-ab4f403af3e8@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75adcb1a-c02f-4d7c-bd9c-ab4f403af3e8@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:15:28PM +0800, Abel Wu wrote:
> On 5/31/23 7:58 PM, Peter Zijlstra wrote:
> > +/*
> > + * Compute virtual time from the per-task service numbers:
> > + *
> > + * Fair schedulers conserve lag:
> > + *
> > + *   \Sum lag_i = 0
> > + *
> > + * Where lag_i is given by:
> > + *
> > + *   lag_i = S - s_i = w_i * (V - v_i)
> 
> Since the ideal service time S is task-specific, should this be:
> 
> 	lag_i = S_i - s_i = w_i * (V - v_i)

It is not, S is the same for all tasks. Remember, the base form is a
differential equation and all tasks progress at the same time at dt/w_i
while S progresses at dt/W.

Infinitesimals are awesome, just not feasible in a discrete system like
a time-sharing computer.

> > + *
> > + * Where S is the ideal service time and V is it's virtual time counterpart.
> > + * Therefore:
> > + *
> > + *   \Sum lag_i = 0
> > + *   \Sum w_i * (V - v_i) = 0
> > + *   \Sum w_i * V - w_i * v_i = 0
> > + *
> > + * From which we can solve an expression for V in v_i (which we have in
> > + * se->vruntime):
> > + *
> > + *       \Sum v_i * w_i   \Sum v_i * w_i
> > + *   V = -------------- = --------------
> > + *          \Sum w_i            W
> > + *
> > + * Specifically, this is the weighted average of all entity virtual runtimes.
> > + *
> > + * [[ NOTE: this is only equal to the ideal scheduler under the condition
> > + *          that join/leave operations happen at lag_i = 0, otherwise the
> > + *          virtual time has non-continguous motion equivalent to:
> > + *
> > + *	      V +-= lag_i / W
> > + *
> > + *	    Also see the comment in place_entity() that deals with this. ]]
> > + *
> > + * However, since v_i is u64, and the multiplcation could easily overflow
> > + * transform it into a relative form that uses smaller quantities:
> > + *
> > + * Substitute: v_i == (v_i - v0) + v0
> > + *
> > + *     \Sum ((v_i - v0) + v0) * w_i   \Sum (v_i - v0) * w_i
> > + * V = ---------------------------- = --------------------- + v0
> > + *                  W                            W
> > + *
> > + * Which we track using:
> > + *
> > + *                    v0 := cfs_rq->min_vruntime
> > + * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime
> 
> IMHO 'sum_runtime' would be more appropriate? Since it actually is
> the summed real time rather than virtual time. And also 'sum_load'
> instead of 'avg_load'.

Given we subtract v0 (min_vruntime) and play games with fixed point
math, I don't think it makes sense to change this name. The purpose is
to compute the weighted average of things, lets keep the current name.

