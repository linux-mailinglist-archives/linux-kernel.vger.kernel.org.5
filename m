Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6122B8014D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379620AbjLAUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E810D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:49:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECFFC433C7;
        Fri,  1 Dec 2023 20:49:10 +0000 (UTC)
Date:   Fri, 1 Dec 2023 15:49:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <20231201154932.468d088b@gandalf.local.home>
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

Paul,

I just started running my branch tracer (that checks all branches and also
gives likely and unlikely correctness). And I found this:

 correct incorrect  %        Function                  File              Line
 ------- ---------  -        --------                  ----              ----
       0  1217713 100 rcu_softirq_qs                 tree.c               247

Which comes down to this:


# define rcu_tasks_trace_qs(t)							\
	do {									\
		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
										\
		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
		    likely(!___rttq_nesting)) {					\
			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
			rcu_tasks_trace_qs_blkd(t);				\
		}								\
	} while (0)


I added just before the likely/unlikely to my test box and I see this:

		trace_printk("need qs? %d %d\n", READ_ONCE((t)->trc_reader_special.b.need_qs), ___rttq_nesting); \

          <idle>-0       [005] d.h1.     2.482412: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.482464: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.482766: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.482951: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.482958: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.483600: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.483624: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.483927: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.484068: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.484127: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.484723: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.484745: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.485015: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.485202: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.485258: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.485818: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.485929: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.486224: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.486370: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.486399: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.486895: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.487049: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [000] d.h1.     2.487318: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [007] d.h1.     2.487472: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [001] d.h1.     2.487522: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [002] d.h1.     2.488034: rcu_sched_clock_irq: need qs? 2 0
          <idle>-0       [005] d.h1.     2.488220: rcu_sched_clock_irq: need qs? 2 0


Note, that "2" is the READ_ONCE() without the "!" to it. Thus:

		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\

Is unlikely to be true.

Was this supposed to be:

		if (!likely(READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\

Or could it be converted to:

		if (unlikely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\

?

Note, the unlikely tracing is running on my production server v6.6.3.

The above trace is from my test box with latest Linus's tree.

-- Steve
