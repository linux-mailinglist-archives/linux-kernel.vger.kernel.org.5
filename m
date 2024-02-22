Return-Path: <linux-kernel+bounces-76867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6986385FDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42FBB2C39B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB7150996;
	Thu, 22 Feb 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9lCqsPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6914C5AB;
	Thu, 22 Feb 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618868; cv=none; b=l4KN9E1TuuFiulihs1Joy9oIftSUGaAbm5CYJQfMPvPAmwkdz1BBOJI1ifEMarp9/e0uHnFGZoTNpRjc8JYOBtzFksSM6E34TBqbfWiXNDZPFhOnpXh0sL6yymLiCfnP9titqC+DAtQEhIr6P/YLm0U/Te7aazjDmlMfrgTwEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618868; c=relaxed/simple;
	bh=bs5C7QHQNhusfSUEd8g3UVKnE1r4dOaxL2lEYHV1D4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYpMOpSryiPSI3vGipMgfHMmMtJymfKEAclZKAf7oj/m9opQDJU40yBHR3CcGnwWNRCe/dwGHIIGLBfNDvDZgq7knQ3+kEfLS53orABFtqUpXOb/EvzdZlQM60mhVNakpDwFXZMLs5ikJaYBmDLuXvL48mriIymPyPKzbq7VHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9lCqsPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B0C433C7;
	Thu, 22 Feb 2024 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708618866;
	bh=bs5C7QHQNhusfSUEd8g3UVKnE1r4dOaxL2lEYHV1D4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9lCqsPi5wOhRFABQJVZU554cRkVEyRm0Y8LaLFq4SbB6HNVD3LBR295U2CA6EsET
	 0ve7HDRX3SFFOi/sWEjcsKCoU+1Nl4FISfbARrT0trvQjZHIXqX0Hcja09awyU/Zq4
	 70E7Rm3Vhay893YvYkCuCE9pdRhTMkq+cI4tnXfZc2SqnNWmz+5EvsdWHGpVPRYHDe
	 e1NNOQfsNIRlmYCE9SGKnmFMfGdxAbYmMalovf5OCW1x1VUPyAlG8aZOCPuB/1dkte
	 +3xDgHddZcxY78AWTVpQOjcs1o0ZAcFX9CybBPJOJoROMFb3/4HNTlcG04rKkX/87p
	 UUs8/VWwL49Vw==
Date: Thu, 22 Feb 2024 17:21:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v2 3/6] rcu-tasks: Initialize data to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <Zdd0b3HI4uNAoc2P@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-4-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217012745.3446231-4-boqun.feng@gmail.com>

Le Fri, Feb 16, 2024 at 05:27:38PM -0800, Boqun Feng a écrit :
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
> This commit therefore initializes the data structures that will be needed
> to rely on these quiescent states and to eliminate these deadlocks.
> 
> Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> 
> Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Reported-by: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  init/init_task.c   | 1 +
>  kernel/fork.c      | 1 +
>  kernel/rcu/tasks.h | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 7ecb458eb3da..4daee6d761c8 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -147,6 +147,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
>  	.rcu_tasks_holdout = false,
>  	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
>  	.rcu_tasks_idle_cpu = -1,
> +	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
>  #endif
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	.trc_reader_nesting = 0,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0d944e92a43f..af7203be1d2d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1976,6 +1976,7 @@ static inline void rcu_copy_process(struct task_struct *p)
>  	p->rcu_tasks_holdout = false;
>  	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
>  	p->rcu_tasks_idle_cpu = -1;
> +	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
>  #endif /* #ifdef CONFIG_TASKS_RCU */
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	p->trc_reader_nesting = 0;
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index b7d5f2757053..4a5d562e3189 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -277,6 +277,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  		rtpcp->rtpp = rtp;
>  		if (!rtpcp->rtp_blkd_tasks.next)
>  			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
> +		if (!rtpcp->rtp_exit_list.next)

I assume there can't be an exiting task concurrently at this point on
boot. Because kthreadd just got created and workqueues as well but that's it,
right? Or workqueues can die that early? Probably not.

> +			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);

Because if tasks can exit concurrently, then we are in trouble :-)

Thanks.

>  	}
>  
>  	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
> -- 
> 2.43.0
> 

