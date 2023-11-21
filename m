Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648D07F27E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjKUIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjKUIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:47:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACEFA;
        Tue, 21 Nov 2023 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hhIFmglu/0fpqKkrzBroixh2PqCL29HzySd71uSn2AQ=; b=Btsk4SRKjcFPnTCxdpZd5Qo+Uo
        9EVDEk/ALQJXF4Rj+e4+9sysr0RIy7syNjT+hhHA9nFjB9NM4nMPzGoSVSTZ1j2BRtI6QzVQX5ELE
        jVdyJ/f4tSGroIpdflsOWJ/lXWh748ZKaqoHWhwN/zDY8+x5BQGJvcwTzpu/FGa9mZr+UYKNAY1Bu
        2+FewHujQiC4XnKaKntKB/6iT2EDILFuls6CVOASeRspYWl2yGgyKsOjWSTPcUDltWaCTH6az2pOy
        nmb6bcsdQ9LkuL3muaM7PSEppkAgECmk9X95wQjlGCwly6PM1k1Tpqmb27V+UNm/xdP9+NZGxZ3Sn
        bK8Kddwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r5MPU-00BNDn-1c;
        Tue, 21 Nov 2023 08:47:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8304B3006F6; Tue, 21 Nov 2023 09:47:06 +0100 (CET)
Date:   Tue, 21 Nov 2023 09:47:06 +0100
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
Message-ID: <20231121084706.GF8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:56:30PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 20, 2023 at 11:23:11PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 20, 2023 at 02:18:29PM -0800, Paul E. McKenney wrote:
> > > On Mon, Nov 20, 2023 at 10:47:42PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Nov 20, 2023 at 03:54:14PM -0500, Mathieu Desnoyers wrote:
> > > > > When invoked from system call enter/exit instrumentation, accessing
> > > > > user-space data is a common use-case for tracers. However, tracepoints
> > > > > currently disable preemption around iteration on the registered
> > > > > tracepoint probes and invocation of the probe callbacks, which prevents
> > > > > tracers from handling page faults.
> > > > > 
> > > > > Extend the tracepoint and trace event APIs to allow defining a faultable
> > > > > tracepoint which invokes its callback with preemption enabled.
> > > > > 
> > > > > Also extend the tracepoint API to allow tracers to request specific
> > > > > probes to be connected to those faultable tracepoints. When the
> > > > > TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
> > > > > callback will be called with preemption enabled, and is allowed to take
> > > > > page faults. Faultable probes can only be registered on faultable
> > > > > tracepoints and non-faultable probes on non-faultable tracepoints.
> > > > > 
> > > > > The tasks trace rcu mechanism is used to synchronize read-side
> > > > > marshalling of the registered probes with respect to faultable probes
> > > > > unregistration and teardown.
> > > > 
> > > > What is trace-trace rcu and why is it needed here? What's wrong with
> > > > SRCU ?
> > > 
> > > Tasks Trace RCU avoids SRCU's full barriers and the array accesses in the
> > > read-side primitives.  This can be important when tracing low-overhead
> > > components of fast paths.
> > 
> > So why wasn't SRCU improved? That is, the above doesn't much explain.
> > 
> > What is the trade-off made to justify adding yet another RCU flavour?
> 
> We didn't think you would be all that happy about having each and
> every context switch iterating through many tens or even hundreds of
> srcu_struct structures.  For that matter, we didn't think that anyone
> else would be all that happy either.  Us included.

So again, what is task-trace RCU ? How does it differ from say
preemptible rcu, which AFAICT could be used here too, no?
