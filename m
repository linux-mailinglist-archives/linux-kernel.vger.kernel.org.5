Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF17B6ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjJCNoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjJCNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200EA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:44:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC2C433C8;
        Tue,  3 Oct 2023 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696340691;
        bh=aAH2goKSo92Tg7G8KsAwfY3FaO2dVx0hF4I/byTCcnc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AN+1dPKRLCVoxy97fSO5Ks+2VHfyfc2VxACUzs/UvVaJYJBF709jw70N3CmVokyHm
         1dEkUwIQz4KCawfSRC6Xla8Z6d95e3bqKzVo9Wm3P/8BrUMG+QhO7blcFfoCW9t/uO
         v8/PgpYfbZttbpKijoQNEQcyDZC5ariD3pt8GGO7iWjAsx5k8bkythBoSK2NXTEHYj
         d5h5Ya2C7JV3YYrLsiDc+3t8m9DGrzxMrNttEEs/Sblb1hDdCe2HtLIzdsRlpfHMhg
         KgbIS6Y8LkHNcn1tmMrBgx/xFwDBgtuKc1Ekqmy+ubqgrVxxWo27IAGrJJs68TGEVv
         rc3NwdQqJVgrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E5FFCE1143; Tue,  3 Oct 2023 06:44:50 -0700 (PDT)
Date:   Tue, 3 Oct 2023 06:44:50 -0700
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
Message-ID: <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
 <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
 <20231002191023.6175294d@gandalf.local.home>
 <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
 <20231002211936.5948253e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002211936.5948253e@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:19:36PM -0400, Steven Rostedt wrote:
> On Mon, 2 Oct 2023 17:14:39 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Mon, Oct 02, 2023 at 07:10:23PM -0400, Steven Rostedt wrote:
> > > On Mon,  2 Oct 2023 16:25:27 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >   
> > > > @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > >  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
> > > >  			return;						\
> > > >  									\
> > > > -		/* keep srcu and sched-rcu usage consistent */		\
> > > > -		preempt_disable_notrace();				\
> > > > +		if (mayfault) {						\
> > > > +			rcu_read_lock_trace();				\  
> > > 
> > > I thought rcu_trace was for the case that a task can not voluntarily call
> > > schedule. If this tracepoint tries to read user space memory that isn't
> > > paged in, and faults, can't the faulting logic call schedule and break this
> > > requirement?  
> > 
> > Well, additional new uses of rcu_read_lock_trace() do bear close scrutiny,
> > but RCU Tasks Trace readers are permitted to block for page faults.
> > The BPF folks already use it for this purpose, so this should be OK.
> > (If for some unknown-to-me reason it isn't, I am sure that Alexei,
> > who is on CC, will not suffer in silence.)
> > 
> > One way of thinking of RCU Tasks Trace is as a form of SRCU with
> > lightweight readers.  Except that, unlike SRCU, there is only one global
> > RCU Tasks Trace.  This means that all RCU Tasks Trace users need to keep
> > each other informed, because one users' unruly readers will affect all
> > RCU Tasks Trace users.
> > 
> > But given that the BPF folks already have page faults in RCU Tasks Trace
> > readers, this one should be OK.
> 
> Then I think we should update the documentation.
> 
> From: Documentation/RCU/checklist.rst:
> 
>         If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
>         then the readers must refrain from executing voluntary
>         context switches, that is, from blocking.  If the updater uses
>         call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
>         the corresponding readers must use rcu_read_lock_trace() and
>         rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
>         or synchronize_rcu_tasks_rude(), then the corresponding readers
>         must use anything that disables preemption, for example,
>         preempt_disable() and preempt_enable().
> 
> Because it's all one paragraph it's a bit confusing to know what uses what.
> Perhaps it should be broken up a bit more?
> 
>         If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
>         then the readers must refrain from executing voluntary
>         context switches, that is, from blocking.
> 
>         If the updater uses call_rcu_tasks_trace() or
>         synchronize_rcu_tasks_trace(), then the corresponding readers must
>         use rcu_read_lock_trace() and rcu_read_unlock_trace().
> 
>         If an updater uses call_rcu_tasks_rude() or synchronize_rcu_tasks_rude(),
>         then the corresponding readers must use anything that disables
>         preemption, for example, preempt_disable() and preempt_enable().
> 
> That way it is clear what uses what, as I read the original paragraph a
> couple of times and could have sworn that rcu_read_lock_trace() required
> tasks to not block.

That would work for me.  Would you like to send a patch, or would you
rather we made the adjustments?

							Thanx, Paul
