Return-Path: <linux-kernel+bounces-135128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E289BB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B173B2364A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8739FC3;
	Mon,  8 Apr 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbIXDCb+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A54F5EC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567777; cv=none; b=SX6N51ucXy09+z0JEv0+qgJ+DQ3SiOWL15/hIT7bzRH8pKMCGqOaNCy3CTmWhwaKtNDW9avrwEap8ycaJNS6FJrHy99WoxY+iUt6y9c/MuTMp67G76A2CzSJC5CVrDDYed+onRbtjUEXH7fhTPxtKIrlcif/W1GLSa+ypoOsK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567777; c=relaxed/simple;
	bh=RcF5b+pWVnXy171fFdlh0P//rNSn0NhuAptCsv6unGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tds5w1BN+LRGFW/xvhLjFJGc+x0HaVBYsNxp14srMMDhyKZEd3+Ew4Yi/Ag6gQURXQL+vsb5dqozhuSTh24WFQNFh5LOEBbbLKCDMoRgM5D/9dyycmHR2e7kDoz6Dlhwjcvg+/Al1ClxziDYEhE+tadQN/vsUZhymJoMhzcrlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cbIXDCb+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KJfVH9LBCImx01OlujvNZgANIUnI1d6+NPWDI/wmv/M=; b=cbIXDCb+TFrPMIAPCv86wkJW4x
	EK022BOrl4n4FjF+xU2zC7EzySQs3M8JUn/vqz8XG07WbBUCxXYBQEkJe8rclnIxZmXDo2ZdKQaDj
	NfGaaECPuwJq0Ic6iiRsTIYqgwYQoKrykq5zglrqhtnDyC1Ot150MK87tNoTUGPiyloe+I4UJHCsS
	GLBTcE+4ZLaRf5OBGKiXiSauTvu3W+8W8XTr6YLBMCoMl62qPLnEG0r7Bgkwt6LtDD3fJPRRRR+ko
	b1JQMI/HMQ963Us2kYLEJCxN4h3USBdeNI/tm7E1qAHra4yryoM73kggmWdpbihGf5QbjPLmTVW6+
	Dn6oAqKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtl6j-000000074BU-39VK;
	Mon, 08 Apr 2024 09:16:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6B7DF30243A; Mon,  8 Apr 2024 11:16:05 +0200 (CEST)
Date: Mon, 8 Apr 2024 11:16:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/5] sched/fair: Rename set_next_buddy() to
 set_next_pick()
Message-ID: <20240408091605.GE21904@noisy.programming.kicks-ass.net>
References: <20240407084319.1462211-1-mingo@kernel.org>
 <20240407084319.1462211-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407084319.1462211-6-mingo@kernel.org>

On Sun, Apr 07, 2024 at 10:43:19AM +0200, Ingo Molnar wrote:
> This is a mechanism to set the next task_pick target,
> 'buddy' is too ambiguous and refers to a historic feature we
> don't have anymore.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/fair.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 93ea653065f5..fe730f232ffd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3200,7 +3200,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	hrtick_update(rq);
>  }
>  
> -static void set_next_buddy(struct sched_entity *se);
> +static void set_next_pick(struct sched_entity *se)
> +{
> +	for_each_sched_entity(se) {
> +		if (SCHED_WARN_ON(!se->on_rq))
> +			return;
> +		if (se_is_idle(se))
> +			return;
> +		cfs_rq_of(se)->next = se;
> +	}
> +}
>  
>  /*
>   * The dequeue_task method is called before nr_running is
> @@ -3240,7 +3249,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  			 * p is sleeping when it is within its sched_slice.
>  			 */
>  			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
> -				set_next_buddy(se);
> +				set_next_pick(se);
>  			break;
>  		}
>  		flags |= DEQUEUE_SLEEP;
> @@ -4631,17 +4640,6 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
>  #endif /* CONFIG_SMP */
>  
> -static void set_next_buddy(struct sched_entity *se)
> -{
> -	for_each_sched_entity(se) {
> -		if (SCHED_WARN_ON(!se->on_rq))
> -			return;
> -		if (se_is_idle(se))
> -			return;
> -		cfs_rq_of(se)->next = se;
> -	}
> -}
> -

Hurmmm.. afaict the only actual user of cfs_rq->next left is task_hot(),
no? Is that thing worth it?

That is, should we not totally nuke the thing?

>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -4769,7 +4767,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  		goto simple;
>  
>  	/*
> -	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
> +	 * Because of the set_next_pick() in dequeue_task_fair() it is rather
>  	 * likely that a next task is from the same cgroup as the current.
>  	 *

So, given you killed the ->next consideration in pick, isn't this
comment 'misleading' at best?

