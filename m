Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2357F1FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjKTVt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKTVtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:49:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12610FC;
        Mon, 20 Nov 2023 13:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hzOe2enBknKNcyvCj309YPBAk627Y0xGtmve14rms6k=; b=NQE4sGwXqrKvpQE0PUfdGJYOxk
        QoVIQqphWu14PC11GFCxMatjak1imrI/sBvCezt47WIfkxno/elH7UJOtPovP3vyzVghB/uNNgl+s
        Dmnz6OrEVNu/mQBBgDrA4o6D7u4ZrECl9RmDtl+Q/ix+8wBRUaj6sT1+uBu/YhKAuEVae+yZkp766
        nCNCLLvIXFWbJPnGMATM1nAdTgEhPFJ7rjbDx+NYnIpbuLSpxwAK0J6KnbO4mZxcFd3R3J9fI4yKK
        v4LqNKuvxWwJjlGFE14+dQSr8eqYA6Eqd+u6FDvhVLQUNVAaZJB2RCocu/VMV0an7mvx+katTgblo
        PicpdKOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5C7L-00B8c0-15;
        Mon, 20 Nov 2023 21:47:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0404D3002A6; Mon, 20 Nov 2023 22:47:43 +0100 (CET)
Date:   Mon, 20 Nov 2023 22:47:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <20231120214742.GC8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:54:14PM -0500, Mathieu Desnoyers wrote:
> When invoked from system call enter/exit instrumentation, accessing
> user-space data is a common use-case for tracers. However, tracepoints
> currently disable preemption around iteration on the registered
> tracepoint probes and invocation of the probe callbacks, which prevents
> tracers from handling page faults.
> 
> Extend the tracepoint and trace event APIs to allow defining a faultable
> tracepoint which invokes its callback with preemption enabled.
> 
> Also extend the tracepoint API to allow tracers to request specific
> probes to be connected to those faultable tracepoints. When the
> TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
> callback will be called with preemption enabled, and is allowed to take
> page faults. Faultable probes can only be registered on faultable
> tracepoints and non-faultable probes on non-faultable tracepoints.
> 
> The tasks trace rcu mechanism is used to synchronize read-side
> marshalling of the registered probes with respect to faultable probes
> unregistration and teardown.

What is trace-trace rcu and why is it needed here? What's wrong with
SRCU ?
