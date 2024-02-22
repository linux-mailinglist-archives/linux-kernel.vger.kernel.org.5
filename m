Return-Path: <linux-kernel+bounces-77011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D5860000
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8128251F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DE156961;
	Thu, 22 Feb 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMI8d7/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C139FC7;
	Thu, 22 Feb 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624130; cv=none; b=fb17GpZshnVbsD8cCP2pPy59PAZV+LGuwrDnNEhoB1iQvmz0ia6ar3VNP5sTqOHGg/MA9PAr0MbJ+sypzl2SKYH2D2RTnAwsutDWrTwQlGvMKEXxuBx9j6oX3i949vUp4G9QapSWF3xgHKwwHtNEL0IsCTsp30XAk9Z28jwu94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624130; c=relaxed/simple;
	bh=VaYP6prNoc9FGNPgfUDauZ6oNrpCjfN/XE/V0iZoggA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmoeAFpW4AT3o8uWUsPhKn8P9SqzdwQWrXj33tU4JKo5jIQM1hFyTpRpNf09Wr4Reh8AFg+grK03S4GsDCzs+JIvwF/jlgYtQBg+VhWkFKNVB27KJ9igjGwHIENgcz/JmpXPhR5c363Nyb29+ct8XFoukl36/1JcEJsELbIiLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMI8d7/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB90C433C7;
	Thu, 22 Feb 2024 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708624129;
	bh=VaYP6prNoc9FGNPgfUDauZ6oNrpCjfN/XE/V0iZoggA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMI8d7/gKj+aq14WTLhD0CaFPDaGrRCxGn661YNkBhxUX8ZPnnClPxryEap7XYA4k
	 7+MDi6l6vrtPVXBs41Ml3kPxtgreuIuxVMvFDE92uGFlnaA8i4WGbSJDAx3BEFdyNm
	 p7JKSo1lz/jg9EA+uWF8c+KKQh2h+TEsk8CyxuaB5ye48yu9q5LXuIbYG6tsnUm23C
	 RqKD9MeiihZ3gbrCASUQjakHHwltutqGYqtCk+WKDRDAL6o91guivBJdRgaty3HW+e
	 J8Jq/9gkP3buDHOTDi10r+6EmEZi6YZ3iuo1axn+iqB0LTH2YL73GBOU0cfGgyOEvL
	 vQwZUhej5KuLQ==
Date: Thu, 22 Feb 2024 18:48:47 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 6/6] rcu-tasks: Maintain real-time response in
 rcu_tasks_postscan()
Message-ID: <ZdeI_-RfdLR8jlsm@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-7-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217012745.3446231-7-boqun.feng@gmail.com>

Le Fri, Feb 16, 2024 at 05:27:41PM -0800, Boqun Feng a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The current code will scan the entirety of each per-CPU list of exiting
> tasks in ->rtp_exit_list with interrupts disabled.  This is normally just
> fine, because each CPU typically won't have very many tasks in this state.
> However, if a large number of tasks block late in do_exit(), these lists
> could be arbitrarily long.  Low probability, perhaps, but it really
> could happen.
> 
> This commit therefore occasionally re-enables interrupts while traversing
> these lists, inserting a dummy element to hold the current place in the
> list.  In kernels built with CONFIG_PREEMPT_RT=y, this re-enabling happens
> after each list element is processed, otherwise every one-to-two jiffies.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/tasks.h | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 4dc355b2ac22..866743e0796f 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -971,13 +971,32 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  	 */
>  
>  	for_each_possible_cpu(cpu) {
> +		unsigned long j = jiffies + 1;
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
>  		struct task_struct *t;
> +		struct task_struct *t1;
> +		struct list_head tmp;
>  
>  		raw_spin_lock_irq_rcu_node(rtpcp);
> -		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
> +		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
>  			if (list_empty(&t->rcu_tasks_holdout_list))
>  				rcu_tasks_pertask(t, hop);
> +
> +			// RT kernels need frequent pauses, otherwise
> +			// pause at least once per pair of jiffies.
> +			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
> +				continue;
> +
> +			// Keep our place in the list while pausing.
> +			// Nothing else traverses this list, so adding a
> +			// bare list_head is OK.
> +			list_add(&tmp, &t->rcu_tasks_exit_list);

I'm a bit confused about what this does...

> +			raw_spin_unlock_irq_rcu_node(rtpcp);
> +			cond_resched(); // For CONFIG_PREEMPT=n kernels
> +			raw_spin_lock_irq_rcu_node(rtpcp);
> +			list_del(&tmp);

Isn't there a risk that t is reaped by then? If it was not observed on_rq
while calling rcu_tasks_pertask() then there is no get_task_struct.

And what about t1? Can't it be reaped as well?

Thanks.


> +			j = jiffies + 1;
> +		}
>  		raw_spin_unlock_irq_rcu_node(rtpcp);
>  	}
>  
> -- 
> 2.43.0
> 

