Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F827D655C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjJYIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:40:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174C9C;
        Wed, 25 Oct 2023 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cmhzrcr2aexRDjzc8+5eXPBKn4AD9mODxCPylln8cA0=; b=mns5c3NoOnkS1gg2eE5RNVE/61
        +Ph6EQnBrGVGKlvxFgwIfKZtWvzk3fUem5fnCUECH1qdFPmJicVrDjNO/KeIj+0rGCFpxE9f+489K
        pn0yPAtw2+Ykq4LWkveMIkXu3ratPbqjZn1hJCl2B3A/eFoPfLmOHxtzBMp0RS6Fp/yI+GUaQNg+/
        8VlmoeLa+nMTSuB9yzBMh1iWmKwWoXhg6AfcEXoVHEy19HeQ47UOAuVdEfXZM4txjujZlNrG0u5S7
        nJcGh0wZuYv5NUh7xF7ktIQ6x4NoxTlEahsGjywsc1Dail7cFAKNrydFutWEi8G4l+czGg1EKQX4N
        8PdPzSiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvZQu-007i90-Vz; Wed, 25 Oct 2023 08:40:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6BFB30047C; Wed, 25 Oct 2023 10:40:08 +0200 (CEST)
Date:   Wed, 25 Oct 2023 10:40:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <20231025084008.GD37471@noisy.programming.kicks-ass.net>
References: <20231024214625.6483-1-frederic@kernel.org>
 <20231024214625.6483-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024214625.6483-3-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:46:23PM +0200, Frederic Weisbecker wrote:

> +/* Check for quiescent states since the pregp's synchronize_rcu() */
> +static bool rcu_tasks_is_holdout(struct task_struct *t)
> +{
> +	int cpu;
> +
> +	/* Has the task been seen voluntarily sleeping? */
> +	if (!READ_ONCE(t->on_rq))
> +		return false;
> +
> +	cpu = task_cpu(t);
> +
> +	/*
> +	 * Idle tasks within the idle loop or offline CPUs are RCU-tasks
> +	 * quiescent states. But CPU boot code performed by the idle task
> +	 * isn't a quiescent state.
> +	 */
> +	if (t == idle_task(cpu)) {
> +		if (is_idle_task(t))
> +			return false;
> +
> +		if (!rcu_cpu_online(cpu))
> +			return false;
> +	}

Hmm, why is this guarded by t == idle_task() ?

Notably, there is the idle-injection thing that uses FIFO tasks to run
'idle', see play_idle_precise(). This will (temporarily) get PF_IDLE on
tasks that are not idle_task().

> +
> +	return true;
> +}
> +
>  /* Per-task initial processing. */
>  static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
>  {
> -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> +	if (t != current && rcu_tasks_is_holdout(t)) {


