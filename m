Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01D7F3339
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjKUQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjKUQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E773126
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:07:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED2BC433C7;
        Tue, 21 Nov 2023 16:07:38 +0000 (UTC)
Date:   Tue, 21 Nov 2023 11:07:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20231121110753.41dc5603@gandalf.local.home>
In-Reply-To: <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
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
        <20231121155256.GN4779@noisy.programming.kicks-ass.net>
        <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 11:00:13 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > tasks-tracing-rcu:
> >    extention of tasks to have critical-sections ? Should this simply be
> >    tasks?  
> 
> tasks-trace-rcu is meant to allow tasks to block/take a page fault 
> within the read-side. It is specialized for tracing and has a single 
> domain. It does not need the smp_mb on the read-side, which makes it 
> lower-overhead than SRCU.

IOW, task-trace-rcu allows the call to schedule in its critical section,
whereas task-rcu does not?

-- Steve
