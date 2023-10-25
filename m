Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0687D6886
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJYKb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJYKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:31:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D48DD;
        Wed, 25 Oct 2023 03:31:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9DAC433C7;
        Wed, 25 Oct 2023 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698229884;
        bh=ktyjSOfOy84unE9g8h9qhxF+s92i7rfaj74PUcCQn+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZO4TWTkEfsZWrQQqCe8G1cDNhWa8MLeNEEXXleaM6vunTr1kyPJQyUio08XSsp6U
         YwRs7DSimAj297a/fa6tuqv2EEEES1224I8292TPYQpluDViR/zd5G49SthvRLE+Jb
         tqWovsGRTgdSx18x4rM65jjuVUrrKmbNfaLg1buKIcdAq61WlLvrcG6sDJvXVAW4X+
         HanuYOJynCWYaNTkXDTZVSNGREgzUteY4AcNpH3kyvBfy7oIKkHa5ytZCgiuABCYXA
         Re5OWdwpycNVWxgWb7kJ5J9geWy82cYPTV2ZTpMY772O6muPwY82X9KcxiORd0BnAO
         /kEfHWprkLSoA==
Date:   Wed, 25 Oct 2023 12:31:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZTjudk5mV8PVYsS-@localhost.localdomain>
References: <20231024214625.6483-1-frederic@kernel.org>
 <20231024214625.6483-3-frederic@kernel.org>
 <20231025084008.GD37471@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025084008.GD37471@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Oct 25, 2023 at 10:40:08AM +0200, Peter Zijlstra a écrit :
> On Tue, Oct 24, 2023 at 11:46:23PM +0200, Frederic Weisbecker wrote:
> 
> > +/* Check for quiescent states since the pregp's synchronize_rcu() */
> > +static bool rcu_tasks_is_holdout(struct task_struct *t)
> > +{
> > +	int cpu;
> > +
> > +	/* Has the task been seen voluntarily sleeping? */
> > +	if (!READ_ONCE(t->on_rq))
> > +		return false;
> > +
> > +	cpu = task_cpu(t);
> > +
> > +	/*
> > +	 * Idle tasks within the idle loop or offline CPUs are RCU-tasks
> > +	 * quiescent states. But CPU boot code performed by the idle task
> > +	 * isn't a quiescent state.
> > +	 */
> > +	if (t == idle_task(cpu)) {
> > +		if (is_idle_task(t))
> > +			return false;
> > +
> > +		if (!rcu_cpu_online(cpu))
> > +			return false;
> > +	}
> 
> Hmm, why is this guarded by t == idle_task() ?
> 
> Notably, there is the idle-injection thing that uses FIFO tasks to run
> 'idle', see play_idle_precise(). This will (temporarily) get PF_IDLE on
> tasks that are not idle_task().

Ah good point. So indeed the is_idle_task() test doesn't musn't be
guarded by t == idle_task(cpu). But rcu_cpu_online() has to, otherwise
if it's not an idle task, there is a risk that the task gets migrated out
by the time we observe the old CPU offline.

Thanks.

> 
> > +
> > +	return true;
> > +}
> > +
> >  /* Per-task initial processing. */
> >  static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
> >  {
> > -	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> > +	if (t != current && rcu_tasks_is_holdout(t)) {
> 
> 
