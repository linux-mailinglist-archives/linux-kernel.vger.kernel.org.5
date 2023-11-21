Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADE7F3311
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjKUQDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKUQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:03:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2C12E;
        Tue, 21 Nov 2023 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xrV8w2QzC0MyzNqKKokweVMq304wzVwsffOY7txoyDw=; b=pxLYa1yvNDM7PJ4z90aSWcYO8I
        l/UHXMGWJ1cglHpMgDCh0p2U9xJovVfw+drVFc7z2ve2C1zZ5bch4lBgGsmnBo7W1/1boh70Pa/il
        72JF7494XgFbRvJ95WfuzljmOM0xu6FPIhGWyxJOzIu1hHHvDv/cAQ7UolXdwBDXip+lzhPgDYrN5
        b5dFOOTkQhcDaAlszc2U8MgmrXNLe/w9EVT1OQt+EujAKRMboYeXqeoazUEapaarghC+k6LQAOQf0
        oNUqZB933q6t1Bp/q3rnkZCx9CfQD1SKeGTeyAj/1MywbiYJu7ZjqKAE6LbhXwBg200pMewLpmFl6
        IfJxLCGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5TDJ-00BUZT-2S;
        Tue, 21 Nov 2023 16:03:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64251300338; Tue, 21 Nov 2023 17:03:00 +0100 (CET)
Date:   Tue, 21 Nov 2023 17:03:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20231121160300.GK8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 07:58:40AM -0800, Paul E. McKenney wrote:

> Tasks Trace RCU allows general blocking in its readers, not just the
> subject-to-priority-boosting blocking permitted within preemptible RCU
> readers.  Restrictions on the use of Tasks Trace RCU are in place to allow
> getting away with this general blocking.  Even systems generously endowed
> with memory are not going to do well when the RCU grace period is blocked
> on I/O, especially if that I/O is across a network to a slow file server.
> 
> Which means a separate RCU instance is needed.  Which is Tasks Trace RCU.

Separate instance not a problem, nor really the question.

What is the basic mechanism of task-tracing? Is it really the existing
tasks-rcu extended with read-side critical sections and call_rcu ?

If so, then why not have it be tasks-rcu?

Or is it a variant of the preemptible/SRCU class of RCUs that are
counter-array based? I suspect not.

So once again, what exactly is tasks-tracing ?
