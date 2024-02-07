Return-Path: <linux-kernel+bounces-57273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A484D609
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E8C1F24AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7A1D691;
	Wed,  7 Feb 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSP9qAyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138821CF95;
	Wed,  7 Feb 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346397; cv=none; b=cbbS5OF7MF6e26EyeAlUKkKRbq4lbdsb30h6X3niXq0FLTZSdcmtD/5mi1cyQyyP9OYloWgpz18PB5pzfJ6Rm5cXL49fxCNHH3wPqlobQiME5k+eLJJnzwa76Dn2SeMACCkvzA3LA3M8mHOH2mDhNNlGQCyOLX/ZKBjxFeBqqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346397; c=relaxed/simple;
	bh=rP4JcaMQDvEMYdZZT3B3rq2quv1kyXqyFd0xfhCJ6O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvO6vcII7/y0G0/Xawoq5N3xzcCm/rSaovyrVn+km7yh2Oo6edUWWCn8TxKBxcQTBUdwuajbLd4ECi9gSBR7lEZABpxrFhjfFRxtsg56FBnIi+juSOJkIFdp7HWkBD8REBx882kIciSDndH/gUge/WG0pJsboqenU3T/D9yetgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSP9qAyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E834BC433C7;
	Wed,  7 Feb 2024 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707346396;
	bh=rP4JcaMQDvEMYdZZT3B3rq2quv1kyXqyFd0xfhCJ6O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSP9qAytXk5I+VJJ+/D10LMsrO7jWkOfGTT0vjK9NKYdzznet0UiMF8hU5l3jU3M/
	 HwA6oqKDA6UCspCvv57rLttajuxe0uySipZ2rZ3GGnK1+v/k6ZHzyjr7j7d8Gg6OCV
	 qroXLIbnGBPeaOktqpA15je2gQrKPCzsNDTiB19E4visd51oR0cfbQGfPoH6Ttex8u
	 de5L92gghArYaYA/gmziHBKmptTuytviOxLkZTO7kY4x7mgQftpPB/mIn6JC3n1hNd
	 nK8PpZJ/UIA7gMYRhK636jpxK0YTUWQZBDns1Zg2c7Wnl7DYqbVPWecFVn3dhJ8gsE
	 e9pNR+gIlz8rg==
Date: Wed, 7 Feb 2024 23:53:13 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH 2/2] rcu-tasks: Eliminate deadlocks involving do_exit()
 and RCU tasks
Message-ID: <ZcQJ2Vec1_b5ooS_@pavilion.home>
References: <20240129225730.3168681-1-boqun.feng@gmail.com>
 <20240129225730.3168681-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129225730.3168681-3-boqun.feng@gmail.com>

Le Mon, Jan 29, 2024 at 02:57:27PM -0800, Boqun Feng a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Holding a mutex across synchronize_rcu_tasks() and acquiring
> that same mutex in code called from do_exit() after its call to
> exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> results in deadlock.  This is by design, because tasks that are far
> enough into do_exit() are no longer present on the tasks list, making
> it a bit difficult for RCU Tasks to find them, let alone wait on them
> to do a voluntary context switch.  However, such deadlocks are becoming
> more frequent.  In addition, lockdep currently does not detect such
> deadlocks and they can be difficult to reproduce.
> 
> In addition, if a task voluntarily context switches during that time
> (for example, if it blocks acquiring a mutex), then this task is in an
> RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> just as well take advantage of that fact.
> 
> This commit therefore eliminates these deadlock by replacing the
> SRCU-based wait for do_exit() completion with per-CPU lists of tasks
> currently exiting.  A given task will be on one of these per-CPU lists for
> the same period of time that this task would previously have been in the
> previous SRCU read-side critical section.  These lists enable RCU Tasks
> to find the tasks that have already been removed from the tasks list,
> but that must nevertheless be waited upon.
> 
> The RCU Tasks grace period gathers any of these do_exit() tasks that it
> must wait on, and adds them to the list of holdouts.  Per-CPU locking
> and get_task_struct() are used to synchronize addition to and removal
> from these lists.
> 
> Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> 
> Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

With that, I think we can now revert 28319d6dc5e2 (rcu-tasks: Fix
synchronize_rcu_tasks() VS zap_pid_ns_processes()). Because if the task
is in rcu_tasks_exit_list, it's treated just like the others and must go
through check_holdout_task(). Therefore and unlike with the previous srcu thing,
a task sleeping between exit_tasks_rcu_start() and exit_tasks_rcu_finish() is
now a quiescent state. And that kills the possible deadlock.

> -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_start(void)
>  {
> -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> +	unsigned long flags;
> +	struct rcu_tasks_percpu *rtpcp;
> +	struct task_struct *t = current;
> +
> +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> +	get_task_struct(t);

Is this get_task_struct() necessary?

> +	preempt_disable();
> +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> +	t->rcu_tasks_exit_cpu = smp_processor_id();
> +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);

Do we really need smp_mb__after_unlock_lock() ?

> +	if (!rtpcp->rtp_exit_list.next)
> +		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	preempt_enable();
>  }
>  
>  /*
> - * Contribute to protect against tasklist scan blind spot while the
> - * task is exiting and may be removed from the tasklist. See
> - * corresponding synchronize_srcu() for further details.
> + * Remove the task from the "yet another list" because do_exit() is now
> + * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
>   */
> -void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_stop(void)
>  {
> +	unsigned long flags;
> +	struct rcu_tasks_percpu *rtpcp;
>  	struct task_struct *t = current;
>  
> -	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
> +	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
> +	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
> +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> +	list_del_init(&t->rcu_tasks_exit_list);
> +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	put_task_struct(t);

And conversely this put_task_struct()?

Thanks.

>  }
>  
>  /*
> -- 
> 2.43.0
> 

