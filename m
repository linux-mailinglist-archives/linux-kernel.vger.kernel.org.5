Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB107F3426
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjKUQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjKUQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:46:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD5E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:46:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA5BC433C7;
        Tue, 21 Nov 2023 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700585189;
        bh=LY9xRQ7JdmDXMRG582U6DyHNCMi3KaOSsQGtTke5vAo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IqCUOi35WWq2rNmviBVSnzbjGvfAO+tf3QCsWcTiQp4AZOHunoRJtfT7KvtCp23hI
         B6DV2bZzzN7+y6OakH7MB/Ih48KO23fGFEJjxbC6A4QsFLPuHYLrQvHJl8AmeCenSZ
         zUekNkAX3E5wdpEDeTqLCZTFoRkKM/ueCpL1q/zEqjt9UEap7idMRGsCTrGSna12fI
         E0hQpX2C+DC11lrCzN03OfE3jpqIehwfCJKPug7wgZ8WFd3keNkQBSgbceHu6k4WTb
         u1bbzMHVpxR3rCcep8tTlCFGLIkFNC8jgGzCWmvztbejvAAn/LQglXKeQ7L9g4J/qO
         Uv1vwOmAt8ciw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C678BCE04C0; Tue, 21 Nov 2023 08:46:28 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:46:28 -0800
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
Message-ID: <017aff1d-70cc-4c0c-a05c-aad4329068e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>
 <20231121160300.GK8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121160300.GK8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:03:00PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 21, 2023 at 07:58:40AM -0800, Paul E. McKenney wrote:
> 
> > Tasks Trace RCU allows general blocking in its readers, not just the
> > subject-to-priority-boosting blocking permitted within preemptible RCU
> > readers.  Restrictions on the use of Tasks Trace RCU are in place to allow
> > getting away with this general blocking.  Even systems generously endowed
> > with memory are not going to do well when the RCU grace period is blocked
> > on I/O, especially if that I/O is across a network to a slow file server.
> > 
> > Which means a separate RCU instance is needed.  Which is Tasks Trace RCU.
> 
> Separate instance not a problem, nor really the question.
> 
> What is the basic mechanism of task-tracing? Is it really the existing
> tasks-rcu extended with read-side critical sections and call_rcu ?
> 
> If so, then why not have it be tasks-rcu?
> 
> Or is it a variant of the preemptible/SRCU class of RCUs that are
> counter-array based? I suspect not.
> 
> So once again, what exactly is tasks-tracing ?

I think we covered this elsewhere in the thread, but if there are
lingering questions, you know where to find us.  ;-)

							Thanx, Paul
