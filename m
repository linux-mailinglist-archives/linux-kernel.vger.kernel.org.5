Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397C7F2011
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjKTWSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:18:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F61191
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:18:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001D1C433C8;
        Mon, 20 Nov 2023 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700518710;
        bh=v2fsGHVEGuyqEdKhN4nMdFZDEWOtc3k1ozVbwEQWDag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FXHw+2jf2R1fAf8voab217Rs0FGaYJj5HJ7K8DPo3f8+VyEt2cCONWErgAW9tQRka
         01ccqAvjrCvjJtvPgYCAOsjoV8Fp/JJBAzA7nVE6XnG7ZVKwLc1+vQmg5Z+Mi9GQ1a
         hmBrzVzp/gHL1cuOHUg/MtInbqHDXBdaI8dqzREErwqSs/62KiefWliLTbTsDOH8nC
         SS7/F/188D7bnjj/IXhPzQXORuIUBD1SH/VUYlhhFQzmjBGA6oXPWdMx9GD+j2Aqmv
         Sv555YamQ7o9wef+VMT3WyuuOQJ/KZjpGsRirw2dh+5JN/NeHq75BKnJPTvwcVGQ5T
         2hSmucLiMNBig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 71A8BCE1ABD; Mon, 20 Nov 2023 14:18:29 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:18:29 -0800
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
Message-ID: <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120214742.GC8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:47:42PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 03:54:14PM -0500, Mathieu Desnoyers wrote:
> > When invoked from system call enter/exit instrumentation, accessing
> > user-space data is a common use-case for tracers. However, tracepoints
> > currently disable preemption around iteration on the registered
> > tracepoint probes and invocation of the probe callbacks, which prevents
> > tracers from handling page faults.
> > 
> > Extend the tracepoint and trace event APIs to allow defining a faultable
> > tracepoint which invokes its callback with preemption enabled.
> > 
> > Also extend the tracepoint API to allow tracers to request specific
> > probes to be connected to those faultable tracepoints. When the
> > TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
> > callback will be called with preemption enabled, and is allowed to take
> > page faults. Faultable probes can only be registered on faultable
> > tracepoints and non-faultable probes on non-faultable tracepoints.
> > 
> > The tasks trace rcu mechanism is used to synchronize read-side
> > marshalling of the registered probes with respect to faultable probes
> > unregistration and teardown.
> 
> What is trace-trace rcu and why is it needed here? What's wrong with
> SRCU ?

Tasks Trace RCU avoids SRCU's full barriers and the array accesses in the
read-side primitives.  This can be important when tracing low-overhead
components of fast paths.

							Thanx, Paul
