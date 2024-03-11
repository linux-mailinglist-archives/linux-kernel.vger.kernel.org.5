Return-Path: <linux-kernel+bounces-99160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F387844F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3787C282FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA247F7D;
	Mon, 11 Mar 2024 15:58:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639944C9B;
	Mon, 11 Mar 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172706; cv=none; b=OUV03hwlRrlq0pV7USG3yEWpqNyt8gP3ZNZjMw5QvDJZKNrKL5nFn7WcXvxQYR6XJXO3u18ITDRZAdr0qzb9qCfjYjFrRNE2uFN8DMUpXCPJ9921LXt0csYrPWXWx8pnDtyX1tgehBWgNidXjGSzidG/8Rf0cmhSnjxiwKgd//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172706; c=relaxed/simple;
	bh=OrzdstX60YGyWu/xA75nxftBoTukeg0HRk4dLur9uJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSeGlDYJXeXvoR5zMkjw4Eq4FjNLemF5x5mVwzq2EtXlp02XC7tF8bmr0QjHCGrt7XzNWldI3/TcUswDdbK2J9aGk+SgcQfvylZ05n9YzqneZYpOLdkj9m8BvCMLMldrYcGBnn0mrYZ6wVeK5wWOpdG9fV1P8Zr9FLbTJyq8Xow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD91FEC;
	Mon, 11 Mar 2024 08:58:59 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 948703F762;
	Mon, 11 Mar 2024 08:58:20 -0700 (PDT)
Message-ID: <3461a0dc-b163-31ed-a96e-f503ade74260@arm.com>
Date: Mon, 11 Mar 2024 15:58:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Content-Language: en-US
To: Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
References: <20240208131050.2406183-1-ben.gainey@arm.com>
 <20240208131050.2406183-2-ben.gainey@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240208131050.2406183-2-ben.gainey@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/02/2024 13:10, Ben Gainey wrote:
> This change allows events to use PERF_SAMPLE READ with inherit
> so long as both inherit_stat and PERF_SAMPLE_TID are set.

I saw there was a discussion on V1 about adding a new flag because this
is an ABI break. Personally I'm not sure if it is required given that it
wasn't allowed before, so there wouldn't be any users to experience it.
I suppose there _could_ be a new user if they stumbled across this now,
but it's not like they would see that as a regression because it wasn't
allowed before anyway. Maybe it's cleaner to just use the existing flags
rather than adding a new one.

Perf even guarded the condition in userspace as far as I can see, so
nobody using Perf would hit this either.

> 
> In this configuration, and event will be inherited into any

and -> any/an?

> child processes / threads, allowing convenient profiling of a
> multiprocess or multithreaded application, whilst allowing
> profiling tools to collect per-thread samples, in particular
> of groups of counters.
> 
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 53 ++++++++++++++++++++++++++------------
>  2 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..7d405dff6694 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -932,6 +932,7 @@ struct perf_event_context {
>  
>  	int				nr_task_data;
>  	int				nr_stat;
> +	int				nr_stat_read;
>  	int				nr_freq;
>  	int				rotate_disable;
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0f0f71213a1..dac7093b3608 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1795,8 +1795,11 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
>  	ctx->nr_events++;
>  	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
>  		ctx->nr_user++;
> -	if (event->attr.inherit_stat)
> +	if (event->attr.inherit_stat) {
>  		ctx->nr_stat++;
> +		if (event->attr.inherit && (event->attr.sample_type & PERF_SAMPLE_READ))
> +			ctx->nr_stat_read++;
> +	}
>  
>  	if (event->state > PERF_EVENT_STATE_OFF)
>  		perf_cgroup_event_enable(event, ctx);
> @@ -2019,8 +2022,11 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
>  	ctx->nr_events--;
>  	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
>  		ctx->nr_user--;
> -	if (event->attr.inherit_stat)
> +	if (event->attr.inherit_stat) {
>  		ctx->nr_stat--;
> +		if (event->attr.inherit && (event->attr.sample_type & PERF_SAMPLE_READ))

This condition is repeated a few times, maybe we could add a macro like
"has_sample_read_thread()" or something or whatever we're calling it
exactly.

It might have prevented the mistake in copying the condition below in
perf_event_count()...

> +			ctx->nr_stat_read--;
> +	}
>  
>  	list_del_rcu(&event->event_entry);
>  
> @@ -3529,11 +3535,17 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>  			perf_ctx_disable(ctx, false);
>  
>  			/* PMIs are disabled; ctx->nr_pending is stable. */
> -			if (local_read(&ctx->nr_pending) ||
> +			if (ctx->nr_stat_read ||
> +			    next_ctx->nr_stat_read ||
> +			    local_read(&ctx->nr_pending) ||
>  			    local_read(&next_ctx->nr_pending)) {
>  				/*
>  				 * Must not swap out ctx when there's pending
>  				 * events that rely on the ctx->task relation.
> +				 *
> +				 * Likewise, when a context contains inherit+inherit_stat+SAMPLE_READ
> +				 * events they should be switched out using the slow path
> +				 * so that they are treated as if they were distinct contexts.
>  				 */
>  				raw_spin_unlock(&next_ctx->lock);
>  				rcu_read_unlock();
> @@ -3545,6 +3557,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>  
>  			perf_ctx_sched_task_cb(ctx, false);
>  			perf_event_swap_task_ctx_data(ctx, next_ctx);
> +			perf_event_sync_stat(ctx, next_ctx);
>  
>  			perf_ctx_enable(ctx, false);
>  
> @@ -3559,8 +3572,6 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>  			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
>  
>  			do_switch = 0;
> -
> -			perf_event_sync_stat(ctx, next_ctx);

The commit message gives a very high level summary of the user visible
changes, but it doesn't say what changes have been made to the code to
accomplish it.

I wasn't sure what this move of perf_even_sync_stat() is for, because
it's actually skipped over when nr_stat_read != 0, which is in this new
case?

>  		}
>  		raw_spin_unlock(&next_ctx->lock);
>  		raw_spin_unlock(&ctx->lock);
> @@ -4533,8 +4544,13 @@ static void __perf_event_read(void *info)
>  	raw_spin_unlock(&ctx->lock);
>  }
>  
> -static inline u64 perf_event_count(struct perf_event *event)
> +static inline u64 perf_event_count(struct perf_event *event, bool from_sample)

There are only two trues, and 7 existing falses, so you could just add a
new function like perf_event_count_sample(). But I suppose that's a
style thing.

>  {
> +	if (from_sample && event->attr.inherit &&
> +       event->attr.inherit &&
> +       (event->attr.sample_type & PERF_SAMPLE_TID)) {

There's something suspicious about this condition with the
event->attr.inherit twice. Should it be && inherit_stat? I don't know if
there's any test that could have caught this, if it's affecting the
existing inherit but not inherit_stat case?

And it's also probably not very helpful at this stage, but if you run
checkpatch.pl on your patches it will point out some of the style issues.

