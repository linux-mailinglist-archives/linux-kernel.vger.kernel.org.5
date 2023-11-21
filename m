Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC857F32C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjKUPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjKUPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:53:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67D185;
        Tue, 21 Nov 2023 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w97cVJb/aQInQREnjHpwi7QFE9oxzcwBFUlRXyXpLTM=; b=m93MnOeHJp3JuYMNkSzI0h+sh5
        z10+8KAVJ91/7rNYnQBsLhrTDLx1pyFHMrAJfaMKirCS4WjNaxwUJvyCrzY/NG0ig0b//FNRDdupH
        VyDa1SgQ7G53XY5K7EfMksqVhEdxhd2Yix8bmQ99JaiPJJWOBWOeOi15EslMK7oOFvwWZbr/IyqsU
        I1Oir5kkvhZDF9P3Bn4fT58qS+rf2UZj91HCtCjGpuAwOa6j8KdSniVISY8dE8GB8r9Ttezlnnvry
        N1ECNDQXgVkUrnkVr3O0Xn4RAm+o7ZO876ARb3WHUNomBPAqXcuPOqcfOPvUf7rSjUWG+1sukH7Jn
        HMqwGzZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5T3a-005icl-2G; Tue, 21 Nov 2023 15:52:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 242B6300338; Tue, 21 Nov 2023 16:52:56 +0100 (CET)
Date:   Tue, 21 Nov 2023 16:52:56 +0100
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
Message-ID: <20231121155256.GN4779@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 03:46:43PM +0100, Peter Zijlstra wrote:

> Why is this such a hard question?

Anyway, recapping from IRC:

preemptible, SRCU:
  counter-array based, GP advances by increasing array index
  and waiting for previous index to drop to 0.

  notably, a GP can pass while a task is preempted but not within a
  critical section.

  SRCU has smp_mb() in the critical sections to improve GP.

tasks:
  waits for every task to pass schedule()

  ensures that any pieces of text rendered unreachable before, is
  actually unused after.

tasks-rude:
  like tasks, but different? build to handle tracing while rcu-idle,
  even though that was already deemed bad?

tasks-tracing-rcu:
  extention of tasks to have critical-sections ? Should this simply be
  tasks?


Can someone complete, please?



