Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B67F32F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjKUP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjKUP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:58:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E230B139
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:58:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EF2C433C7;
        Tue, 21 Nov 2023 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700582320;
        bh=d5Aj4Buof5eNGJh4K2/7E6BTN250mT/g89jqpnNzlS0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XwEh3bnGEdPycwff/22Zo3at5MZZBSaRj9QWw6hOo+C8KoMrEx3D7/6M0K9aZo/5F
         7mr0zay6Yw+TbuTj76ZAo6IhUw2KlKvUv+lUOfJFKmc80VBpW3vj+pTYNXS2BgJoZx
         kViTExzyIjGNaAbJyDO9pgFcVvc0AOkdNbc95gF33PR5lqQQUORn1z9QnTmUVOAl4G
         L87vtfMILIXO20bnJ8RPTG3JLOt9PqKswegL330YqwJP+eIgmOozKkcMYgLwIlrt2A
         Ky3J4rOXkWV0sUxXPOMl7roVi3C4b3Z2s0CFMv34rNBg0pCFeYkFa6IntpDFbygMvn
         JdLet19vofpMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0CDE4CE04BD; Tue, 21 Nov 2023 07:58:40 -0800 (PST)
Date:   Tue, 21 Nov 2023 07:58:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121143647.GI8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:36:47PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 09:06:18AM -0500, Mathieu Desnoyers wrote:
> > Task trace RCU fits a niche that has the following set of requirements/tradeoffs:
> > 
> > - Allow page faults within RCU read-side (like SRCU),
> > - Has a low-overhead read lock-unlock (without the memory barrier overhead of SRCU),
> > - The tradeoff: Has a rather slow synchronize_rcu(), but tracers should not care about
> >   that. Hence, this is not meant to be a generic replacement for SRCU.
> > 
> > Based on my reading of https://lwn.net/Articles/253651/ , preemptible RCU is not a good
> > fit for the following reasons:
> > 
> > - It disallows blocking within a RCU read-side on non-CONFIG_PREEMPT kernels,
> 
> Your counter points are confused, we simply don't build preemptible RCU
> unless PREEMPT=y, but that could surely be fixed and exposed as a
> separate flavour.

It certainly used to be available as a separate flavor, but only in
CONFIG_PREEMPT=y kernels.  In CONFIG_PREEMPT=n kernels, the API mapped
to the non-preemptible flavor, as in synchronize_sched() and friends.
And we need tracing in the full set of kernels.

> > - AFAIU the mmap_sem used within the page fault handler does not have priority inheritance.
> 
> What's that got to do with anything?
> 
> Still utterly confused about what task-tracing rcu is and how it is
> different from preemptible rcu.

Tasks Trace RCU allows general blocking in its readers, not just the
subject-to-priority-boosting blocking permitted within preemptible RCU
readers.  Restrictions on the use of Tasks Trace RCU are in place to allow
getting away with this general blocking.  Even systems generously endowed
with memory are not going to do well when the RCU grace period is blocked
on I/O, especially if that I/O is across a network to a slow file server.

Which means a separate RCU instance is needed.  Which is Tasks Trace RCU.

							Thanx, Paul
