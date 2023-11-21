Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7E57F3118
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjKUOhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjKUOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:37:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B2100;
        Tue, 21 Nov 2023 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d8HedOLE7HAb7DhrMWtkJj8KjFf9D0cLXb+qJps2r14=; b=nyovOm6ZBug1Y7ge9B0u8J2d7D
        T5S03HGyXdBBNDxQjvZxuo7n9VfkA/rPNY8D9GUSvJX8IYk5k3GftEBiFe7ImWRoC5mqUIBRNgktY
        uqY6HiYgCFWOFwO4bw27GHbKE9T3j2mJ2foJdB2Cm7YAkRDChV1aRR39YjlRVT71LoUiML5kB/Rvd
        LZYSMHQdWRNtWOxgj4ofrEfYQsCd2Yppm3ov/0lavScgQrtvbBbxzIaiu5z0PPDBbVCKU9Wm95A6V
        IvhCv8cLG1XH9+tl3F2vMOUqOYgBX97WFzGgdppAB7L0rQUE25Msfc9/q9JufvUwehMq6PtwTJFsT
        BtQSH6Xg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5Rrs-005fbL-Ia; Tue, 21 Nov 2023 14:36:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 233F8300338; Tue, 21 Nov 2023 15:36:47 +0100 (CET)
Date:   Tue, 21 Nov 2023 15:36:47 +0100
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
Message-ID: <20231121143647.GI8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:06:18AM -0500, Mathieu Desnoyers wrote:
> Task trace RCU fits a niche that has the following set of requirements/tradeoffs:
> 
> - Allow page faults within RCU read-side (like SRCU),
> - Has a low-overhead read lock-unlock (without the memory barrier overhead of SRCU),
> - The tradeoff: Has a rather slow synchronize_rcu(), but tracers should not care about
>   that. Hence, this is not meant to be a generic replacement for SRCU.
> 
> Based on my reading of https://lwn.net/Articles/253651/ , preemptible RCU is not a good
> fit for the following reasons:
> 
> - It disallows blocking within a RCU read-side on non-CONFIG_PREEMPT kernels,

Your counter points are confused, we simply don't build preemptible RCU
unless PREEMPT=y, but that could surely be fixed and exposed as a
separate flavour.

> - AFAIU the mmap_sem used within the page fault handler does not have priority inheritance.

What's that got to do with anything?

Still utterly confused about what task-tracing rcu is and how it is
different from preemptible rcu.

