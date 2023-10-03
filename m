Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162567B5E85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbjJCBSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbjJCBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:18:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33F2B8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:18:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0339C433C7;
        Tue,  3 Oct 2023 01:18:35 +0000 (UTC)
Date:   Mon, 2 Oct 2023 21:19:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints
 (v3)
Message-ID: <20231002211936.5948253e@gandalf.local.home>
In-Reply-To: <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
        <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
        <20231002191023.6175294d@gandalf.local.home>
        <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 17:14:39 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Oct 02, 2023 at 07:10:23PM -0400, Steven Rostedt wrote:
> > On Mon,  2 Oct 2023 16:25:27 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> > > @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> > >  			return;						\
> > >  									\
> > > -		/* keep srcu and sched-rcu usage consistent */		\
> > > -		preempt_disable_notrace();				\
> > > +		if (mayfault) {						\
> > > +			rcu_read_lock_trace();				\  
> > 
> > I thought rcu_trace was for the case that a task can not voluntarily call
> > schedule. If this tracepoint tries to read user space memory that isn't
> > paged in, and faults, can't the faulting logic call schedule and break this
> > requirement?  
> 
> Well, additional new uses of rcu_read_lock_trace() do bear close scrutiny,
> but RCU Tasks Trace readers are permitted to block for page faults.
> The BPF folks already use it for this purpose, so this should be OK.
> (If for some unknown-to-me reason it isn't, I am sure that Alexei,
> who is on CC, will not suffer in silence.)
> 
> One way of thinking of RCU Tasks Trace is as a form of SRCU with
> lightweight readers.  Except that, unlike SRCU, there is only one global
> RCU Tasks Trace.  This means that all RCU Tasks Trace users need to keep
> each other informed, because one users' unruly readers will affect all
> RCU Tasks Trace users.
> 
> But given that the BPF folks already have page faults in RCU Tasks Trace
> readers, this one should be OK.

Then I think we should update the documentation.

From: Documentation/RCU/checklist.rst:

        If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
        then the readers must refrain from executing voluntary
        context switches, that is, from blocking.  If the updater uses
        call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
        the corresponding readers must use rcu_read_lock_trace() and
        rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
        or synchronize_rcu_tasks_rude(), then the corresponding readers
        must use anything that disables preemption, for example,
        preempt_disable() and preempt_enable().

Because it's all one paragraph it's a bit confusing to know what uses what.
Perhaps it should be broken up a bit more?

        If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
        then the readers must refrain from executing voluntary
        context switches, that is, from blocking.

        If the updater uses call_rcu_tasks_trace() or
        synchronize_rcu_tasks_trace(), then the corresponding readers must
        use rcu_read_lock_trace() and rcu_read_unlock_trace().

        If an updater uses call_rcu_tasks_rude() or synchronize_rcu_tasks_rude(),
        then the corresponding readers must use anything that disables
        preemption, for example, preempt_disable() and preempt_enable().

That way it is clear what uses what, as I read the original paragraph a
couple of times and could have sworn that rcu_read_lock_trace() required
tasks to not block.

-- Steve
