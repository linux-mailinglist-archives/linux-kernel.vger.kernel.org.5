Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D767B5E04
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbjJCAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJCAOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:14:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB37A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:14:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA786C433C7;
        Tue,  3 Oct 2023 00:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696292080;
        bh=q1MBaMUELwCBG5jdmdvbG7aW24fu4ICBu0JhJ4Wa7Kk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G9sAs9ryEXpRgW3lD1+uOjxvV9o4z0Sz49ZGn5zsl5CK3lc1bqH0chCCQ1wRGRyrn
         GjgACnglfZ4qpNDykToOyb0CYbGh18gFwkJtqgOh6ErnSvU5VgtRA5oMslGsBB9g4Y
         fIHSKTM+bxjDki9ryZH8jWKa2SM7FTV3sUVyfpRm0jWVURvyeUuu9YQdAmz8lH29B8
         oFZU+0uSVK5IEC9CxNt7Z12TY0AZpwFoY87ErRlFqxxnITxc4rgQS0TtouzTN+wvuD
         OtgxNkLriQgvRFOn4/zcdJ+fo0vMtNEsS4s2kTipWmqrduevPylx5mvZ+nnAHldRKk
         W++Q0m6uNWhTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81D86CE13B5; Mon,  2 Oct 2023 17:14:39 -0700 (PDT)
Date:   Mon, 2 Oct 2023 17:14:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints (v3)
Message-ID: <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
 <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
 <20231002191023.6175294d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002191023.6175294d@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 07:10:23PM -0400, Steven Rostedt wrote:
> On Mon,  2 Oct 2023 16:25:27 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> >  			return;						\
> >  									\
> > -		/* keep srcu and sched-rcu usage consistent */		\
> > -		preempt_disable_notrace();				\
> > +		if (mayfault) {						\
> > +			rcu_read_lock_trace();				\
> 
> I thought rcu_trace was for the case that a task can not voluntarily call
> schedule. If this tracepoint tries to read user space memory that isn't
> paged in, and faults, can't the faulting logic call schedule and break this
> requirement?

Well, additional new uses of rcu_read_lock_trace() do bear close scrutiny,
but RCU Tasks Trace readers are permitted to block for page faults.
The BPF folks already use it for this purpose, so this should be OK.
(If for some unknown-to-me reason it isn't, I am sure that Alexei,
who is on CC, will not suffer in silence.)

One way of thinking of RCU Tasks Trace is as a form of SRCU with
lightweight readers.  Except that, unlike SRCU, there is only one global
RCU Tasks Trace.  This means that all RCU Tasks Trace users need to keep
each other informed, because one users' unruly readers will affect all
RCU Tasks Trace users.

But given that the BPF folks already have page faults in RCU Tasks Trace
readers, this one should be OK.

							Thanx, Paul

> -- Steve
> 
> 
> > +		} else {						\
> > +			/* keep srcu and sched-rcu usage consistent */	\
> > +			preempt_disable_notrace();			\
> > +		}							\
> >  									\
> >  		/*							\
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
