Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5264B7F34F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjKURcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjKURcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:32:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17919E;
        Tue, 21 Nov 2023 09:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HsRKL7oJPeTSKmfazEgvxbiEjBhhBtyUd3QT8UX3zvI=; b=EQsRtLAHV3P4RtP7U88x97d4t5
        C6nQkrCGo7FTm+zzeiPpnuLQjxk0WcYtW9mRg0W6S64NgrqTt5nKv/8efRLyl7r1ZG1WpRuAf/9x1
        i7k8HW/4sswY5d746+Ap+38pZsi4mGGHJPx0jkbjH+jINICwg2orhCgzwn4XEM2egvdLRMXAjWOM1
        Ch5ag11bq5m/+cktSzw47ysiiihDTx/6/8QXSX2OQQPMys8ffCJesm51nNlsFEjbhchFE7ikQ3vU9
        OUe+o3J/+eJtTFfA8jA28dmyBatOcfL8tabjq/ULMTDwKiEgudgoiR1iEl61oNshBofiw/jignIJ4
        cUadN58g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5Ub7-005mh6-KM; Tue, 21 Nov 2023 17:31:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DC72300338; Tue, 21 Nov 2023 18:31:40 +0100 (CET)
Date:   Tue, 21 Nov 2023 18:31:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <20231121173140.GO4779@noisy.programming.kicks-ass.net>
References: <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
 <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
 <20231121165029.GL8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121165029.GL8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:50:29PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 11:00:13AM -0500, Mathieu Desnoyers wrote:
> > On 2023-11-21 10:52, Peter Zijlstra wrote:
> > > On Tue, Nov 21, 2023 at 03:46:43PM +0100, Peter Zijlstra wrote:
> > > 
> > > > Why is this such a hard question?
> > > 
> > > Anyway, recapping from IRC:
> > > 
> > > preemptible, SRCU:
> > >    counter-array based, GP advances by increasing array index
> > >    and waiting for previous index to drop to 0.
> > > 
> > >    notably, a GP can pass while a task is preempted but not within a
> > >    critical section.
> > > 
> > >    SRCU has smp_mb() in the critical sections to improve GP.
> > 
> > Also:
> > 
> > preemptible only allows blocking when priority inheritance is
> > guarantees, which excludes doing I/O, and thus page faults.
> > Otherwise a long I/O could cause the system to OOM.
> > 
> > SRCU allows all kind of blocking, as long as the entire SRCU
> > domain does not mind waiting for a while before readers complete.
> 
> Well, no. Fundamentally both SRCU and preemptible (and many other
> flavours) are just a counter-array. The non-blocking for preempt comes
> from the fact that it is the main global rcu instance and allowing all
> that would make GPs too rare and cause you memory trouble.
> 
> But that's not because of how it's implemented, but because of it being
> the main global instance.
> 
> > > tasks:
> > >    waits for every task to pass schedule()
> > > 
> > >    ensures that any pieces of text rendered unreachable before, is
> > >    actually unused after.
> > > 
> > > tasks-rude:
> > >    like tasks, but different? build to handle tracing while rcu-idle,
> > >    even though that was already deemed bad?
> > > 
> > > tasks-tracing-rcu:
> > >    extention of tasks to have critical-sections ? Should this simply be
> > >    tasks?
> > 
> > tasks-trace-rcu is meant to allow tasks to block/take a page fault within
> > the read-side. It is specialized for tracing and has a single domain. It
> > does not need the smp_mb on the read-side, which makes it lower-overhead
> > than SRCU.
> 
> That's what it's meant for, not what it is.
> 
> Turns out that tasks-tracing is a per-task counter based thing, and as
> such does not require all tasks to pass through schedule() and does not
> imply the tasks flavour (nor the tasks-rude) despite the similarity in
> naming.
> 
> But now I am again left wondering what the fundamental difference is
> between a per-task counter and a per-cpu counter.
> 
> At the end of the day, you still have to wait for the thing to hit 0.
> 
> So I'm once again confused, ...

Updating myself.. so task-tracing-rcu is in fact *very* similar to
regular preemptible-rcu but is slightly different mostly because it is
*not* the main global instance.

Both are a single per-task counter (and not the per-cpu summing that I
remember from many many *many* years ago; OLS'07), mostly because this
helps identify which task is to blame when things go sideways.


