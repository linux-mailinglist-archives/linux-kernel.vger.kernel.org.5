Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC67D84D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjJZOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:34:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C3B1A2;
        Thu, 26 Oct 2023 07:34:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E81C433C7;
        Thu, 26 Oct 2023 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698330871;
        bh=rKDtDZQL7IF9MPNckBpYcUD5NDFOua3I/T1b8Be9sxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiZqL9LeNrTScCl6FAaz9v8ysyES8KP4YtIPM7CSNn90UciwCG0q+ticfFl6GV24b
         FqFLTSHUjaf8luzv56MNL541GlmMLsfNzrHGDXS1Z9yB6APSdrVN0kNv67HKkZEKB+
         Mroz1RcEYusxO65SMoY+bvXOpFXw4zEOcqWlYuWMCPII71bd2qFHfBqJPqT8se415k
         T55W72cY4WdWX5iySJhqy+jBrDNTSSyLfP/A7TGDcdJ9BNRVCHyJnHwYMZUJVTXnCc
         eMdzivwdlNa/X8XE7MOTzgn3MqgbmSYneDUUuYGHPEeLN+USmK8uG/k8JWLH1rEF1Q
         NVDiqzxxd6BhA==
Date:   Thu, 26 Oct 2023 16:34:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <ZTp49M8EskD5JJwA@lothringen>
References: <20231024214625.6483-1-frederic@kernel.org>
 <20231024214625.6483-3-frederic@kernel.org>
 <20231025084008.GD37471@noisy.programming.kicks-ass.net>
 <ZTjudk5mV8PVYsS-@localhost.localdomain>
 <CALm+0cW0ZEX_G9WcJx-i3b5SCLECWfeKG+ikdXfXzNsM-XSM8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cW0ZEX_G9WcJx-i3b5SCLECWfeKG+ikdXfXzNsM-XSM8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 08:15:33PM +0800, Z qiang wrote:
> >
> > Le Wed, Oct 25, 2023 at 10:40:08AM +0200, Peter Zijlstra a écrit :
> > > On Tue, Oct 24, 2023 at 11:46:23PM +0200, Frederic Weisbecker wrote:
> > >
> > > > +/* Check for quiescent states since the pregp's synchronize_rcu() */
> > > > +static bool rcu_tasks_is_holdout(struct task_struct *t)
> > > > +{
> > > > +   int cpu;
> > > > +
> > > > +   /* Has the task been seen voluntarily sleeping? */
> > > > +   if (!READ_ONCE(t->on_rq))
> > > > +           return false;
> > > > +
> > > > +   cpu = task_cpu(t);
> > > > +
> > > > +   /*
> > > > +    * Idle tasks within the idle loop or offline CPUs are RCU-tasks
> > > > +    * quiescent states. But CPU boot code performed by the idle task
> > > > +    * isn't a quiescent state.
> > > > +    */
> > > > +   if (t == idle_task(cpu)) {
> > > > +           if (is_idle_task(t))
> > > > +                   return false;
> > > > +
> > > > +           if (!rcu_cpu_online(cpu))
> > > > +                   return false;
> > > > +   }
> > >
> > > Hmm, why is this guarded by t == idle_task() ?
> > >
> > > Notably, there is the idle-injection thing that uses FIFO tasks to run
> > > 'idle', see play_idle_precise(). This will (temporarily) get PF_IDLE on
> > > tasks that are not idle_task().
> >
> > Ah good point. So indeed the is_idle_task() test doesn't musn't be
> > guarded by t == idle_task(cpu). But rcu_cpu_online() has to, otherwise
> > if it's not an idle task, there is a risk that the task gets migrated out
> > by the time we observe the old CPU offline.
> >
> 
> If a fifo-tasks use play_idle_precise() to run idle and invoke
> do_idle(), may cause
> rcu-tasks to falsely report a rcu-tasks QS

Well, there can be a debate here: should we consider an idle injector as a real
task that we must wait for a voluntary schedule or should we treat it just like
an idle task?

Having that whole idle task quiescent state in RCU-tasks is quite a strange
semantic anyway. And in the long run, the purpose is to unify RCU-tasks and
RCU-tasks-RUDE with relying on ct_dynticks for idle quiescent states.

> , when rcu_is_cpu_rrupt_from_idle()
> return true in rcu_sched_clock_irq(), so should we also add a check for
> "current == idle_task(task_cpu(current))" in the rcu_is_cpu_rrupt_from_idle()
> ?

That looks fine OTOH. Whether idle injection or real idle,
rcu_is_cpu_rrupt_from_idle() is always a quiescent state in real RCU. Because
we know we have no RCU reader between ct_idle_enter() and ct_idle_exit().

Thanks.
