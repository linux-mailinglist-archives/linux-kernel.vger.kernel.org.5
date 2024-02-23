Return-Path: <linux-kernel+bounces-78580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184E861551
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05192866B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1CC81AD4;
	Fri, 23 Feb 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvLF4unx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7035EF1;
	Fri, 23 Feb 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701292; cv=none; b=REPWMvWb3EfBGybtOfax8LDTHsBCyVfwl5k0p/7hai8MmOif3mLdRPGq8f7qLNOygm7n/Ud/88h8pZZ+9j7FzYe/ejZrU7aX8XVH1FGaes+zMeqIcIiqrM0Wq1NU2gckw53Sqy8weE5L5b0BpYw3nWnc8M6RtAFgCP0/XAfkIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701292; c=relaxed/simple;
	bh=7W8+QYtt2grKoqRx/oAyb0v655L0Xcbk0QRleTescoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evzq2ZI9pF3xAyjXRuboVI8/9C2JnDQQEaPiRTL/MKDzOzaW1zII0DTLcB6FdO7IQTy2AC20hovctZYCl5GQNQSs/zdiIiyBwoAquG+dka5sYIjQ8MGotggLx1mBz15wOEG9X0un7n4HFiB96nptctDxf3zsJtkEgXoq7sr3los=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvLF4unx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C7FC433C7;
	Fri, 23 Feb 2024 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701292;
	bh=7W8+QYtt2grKoqRx/oAyb0v655L0Xcbk0QRleTescoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvLF4unxDB0rNIL0JXp0Hn4oDAPmbkGVzyPv3iUfoOeZJtZzBl7GOF6ksN0FJuxHr
	 NrcysBwlpekCR5yYcYL61aQP2GiHY9A8lx4oA1O60976Ro7Wuhgo5otJqsQqykF1De
	 b+bl6zWjMAxlhhUg8KdkjPEzFDop5x9AQ7x+jDq5fIilm6AaSXLMPOFocrxz3LZIz3
	 Y+/WU7aweJAUHkMzgMWQaeDFEZxGipIxG8mTPsT7DiqSrS97lYDAvrEZu9WrZOLQwm
	 ue6ioQIgjLQ5oJTvKGV2a7RE1apuaaNMkbCetf4FLMrc0zEOFDfFu2DtCr6JpKmsJI
	 eNQ9x1LvGbKKQ==
Date: Fri, 23 Feb 2024 16:14:49 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
Message-ID: <Zdi2aXbgKdsmP/1O@lothringen>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-7-boqun.feng@gmail.com>
 <ZdeI_-RfdLR8jlsm@localhost.localdomain>
 <e0472956-1b18-4a22-be6e-5dbbc11141eb@paulmck-laptop>
 <9a27f638-4eb0-42b3-b8a3-201d6ed9406b@paulmck-laptop>
 <ZdiMympnNOo6e+5T@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdiMympnNOo6e+5T@lothringen>

On Fri, Feb 23, 2024 at 01:17:14PM +0100, Frederic Weisbecker wrote:
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 866743e0796f..0ff2b554f5b5 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -973,12 +973,13 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  	for_each_possible_cpu(cpu) {
>  		unsigned long j = jiffies + 1;
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> -		struct task_struct *t;
> -		struct task_struct *t1;
> -		struct list_head tmp;
>  
>  		raw_spin_lock_irq_rcu_node(rtpcp);
> -		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
> +		while (!list_empty(&rtpcp->rtp_exit_list)) {
> +			struct task_struct *t;
> +			t = list_first_entry(&rtpcp->rtp_exit_list, typeof(*t), rcu_tasks_exit_list);
> +			list_del_init(&t->rcu_tasks_exit_list);

Oh no! The task has to stay in the list for subsequent grace periods! Please
forget that suggestion... Yours looks good!

Thanks.

> +
>  			if (list_empty(&t->rcu_tasks_holdout_list))
>  				rcu_tasks_pertask(t, hop);
>  
> @@ -987,14 +988,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
>  				continue;
>  
> -			// Keep our place in the list while pausing.
> -			// Nothing else traverses this list, so adding a
> -			// bare list_head is OK.
> -			list_add(&tmp, &t->rcu_tasks_exit_list);
>  			raw_spin_unlock_irq_rcu_node(rtpcp);
>  			cond_resched(); // For CONFIG_PREEMPT=n kernels
>  			raw_spin_lock_irq_rcu_node(rtpcp);
> -			list_del(&tmp);
>  			j = jiffies + 1;
>  		}
>  		raw_spin_unlock_irq_rcu_node(rtpcp);
> @@ -1219,7 +1215,6 @@ void exit_tasks_rcu_stop(void)
>  	struct rcu_tasks_percpu *rtpcp;
>  	struct task_struct *t = current;
>  
> -	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
>  	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
>  	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>  	list_del_init(&t->rcu_tasks_exit_list);
> 

