Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA50C7F341C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjKUQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjKUQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:43:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964A19E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:43:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF75C433C8;
        Tue, 21 Nov 2023 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700585008;
        bh=/U3kd7ywcCF+XCjlFdnVgAtFdH2pvC95gZA5CdP+R7A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d8hC5oXZovua02aR+GsRCPNBnBonyFe9VF180GnOg9JdJ7SPSAxI0bQ4fwEhCWh72
         xhpksKXbcEDH4xLBvzqM1z5IQEdfUP76yHcYFcltbYMwznAdnbEueOnp4XWsQlWXuK
         /SYSb1/i8vhF7DjpEbzgiEdjorLBkdhqQFyGThfhxAJjelB36jmWYTi0vf6kv8E6Jd
         7K4FZWR5nKax6ZkunDuHjTEZiIZ5OucROcypM0s6NaSSGpB79TwLfT/z8lCqWAy8Ks
         B9lH/tuSnVCrwEan4oHH4YyOLgzlJ8Zvt1YTCsee6jvaXllE0/M3iCWiHYIjBYI9oy
         Tdej5ktkV7eew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 83BCBCE04C0; Tue, 21 Nov 2023 08:43:27 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:43:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <045efa69-f0a4-4f04-b092-96b317865cf3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
 <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
 <20231121110753.41dc5603@gandalf.local.home>
 <e1d33ff6-bf8d-465f-8626-f692ce4debe5@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d33ff6-bf8d-465f-8626-f692ce4debe5@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:11:57AM -0500, Mathieu Desnoyers wrote:
> On 2023-11-21 11:07, Steven Rostedt wrote:
> > On Tue, 21 Nov 2023 11:00:13 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > > tasks-tracing-rcu:
> > > >     extention of tasks to have critical-sections ? Should this simply be
> > > >     tasks?
> > > 
> > > tasks-trace-rcu is meant to allow tasks to block/take a page fault
> > > within the read-side. It is specialized for tracing and has a single
> > > domain. It does not need the smp_mb on the read-side, which makes it
> > > lower-overhead than SRCU.
> > 
> > IOW, task-trace-rcu allows the call to schedule in its critical section,
> > whereas task-rcu does not?
> 
> Correct.
> 
> And unlike preemptible rcu, tasks-trace-rcu allows calls to schedule which
> do not provide priority inheritance guarantees (such as I/O triggered by
> page faults).

But please keep it to things allowed in vanilla RCU read-side critical
sections and I/O triggered by page faults.  If you need something else,
that is a discussion between all the current users of RCU Tasks Trace.

							Thanx, Paul
