Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52C7D10C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377474AbjJTNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377497AbjJTNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:48:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4C1BF;
        Fri, 20 Oct 2023 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpdQvX62vrGzB5mMaNjp6jXA2kzttVSPTh1BbmBsa6U=; b=DkBUNzQj4oRMt4w9BQGLe2yWqj
        GsuLmxMoir9nlzUFyNVeTbe5BM9K8Pqpz/kWLx6E1Dm4al+VCP+HCP2IoY9w7tPRiH8tP2GZnQtyI
        t2d6aMxEUVlZQEJ8i0371kXoSzwNDmXfHRfNGgOnsnlvCd6tmxCx2B8Ke9mAhqSLTDl5/tZAyESOP
        D0mhdBlNLxbozCFwr1NmFRXWNRn720ux7LDJ9XxYiV6MKxcRk1IOcD9Uni/dTzVX5WfadIkQsYTNI
        ttU8wCTlfnCKLK9vr/xFkzydXQzvMIFT5V3uh3boo78U0tqK8LSEU2jARDlSz/nlrFH+8RP+dD7Vi
        +R8/3RiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtprh-00DQgw-EG; Fri, 20 Oct 2023 13:48:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AF32300392; Fri, 20 Oct 2023 15:48:37 +0200 (CEST)
Date:   Fri, 20 Oct 2023 15:48:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/4] Revert "kernel/sched: Modify initial boot task idle
 setup"
Message-ID: <20231020134836.GE33965@noisy.programming.kicks-ass.net>
References: <20231019233543.1243121-1-frederic@kernel.org>
 <20231019233543.1243121-5-frederic@kernel.org>
 <20231020082531.GS33217@noisy.programming.kicks-ass.net>
 <ZTJzEVkVfSMGumWU@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJzEVkVfSMGumWU@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 02:31:13PM +0200, Frederic Weisbecker wrote:

> Yeah I can't say I really like the old coverage of PF_IDLE either. The new one
> (after Liam's patch) is only halfway better defined though: it makes the boot
> CPU's idle behave quite well: PF_IDLE is set on idle entry. And secondary
> CPU's idle behave quite well also except when they go offline and then online
> again. And then the secondary boot code becomes PF_IDLE.

Bah offline, yeah, we should just not do that :-)

> We probably need something like this:
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3b9d5c7eb4a2..b24d7937b989 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  
> +	current->flags &= ~PF_IDLE;
>  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> +
>  	rcutree_report_cpu_dead();
>  	st->state = CPUHP_AP_IDLE_DEAD;
>  	/*
> @@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  
> +	current->flags |= PF_IDLE;
> +
>  	/* Happens for the boot cpu */
>  	if (state != CPUHP_AP_ONLINE_IDLE)
>  		return;

Yeah that works I suppose.
