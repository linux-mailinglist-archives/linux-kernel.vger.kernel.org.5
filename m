Return-Path: <linux-kernel+bounces-154837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D908AE1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805CE1C20D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF71604D5;
	Tue, 23 Apr 2024 10:05:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EBB22F11;
	Tue, 23 Apr 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866757; cv=none; b=S9ZAbX28x4NpBKOlTQ22G/B1fGV45SadUoWyEoGcxz76A/oAn4lr/hia6jxrraf41TgxYT2IKUB/VMlI4WUqnl2EHkA8FEarm935tMvjyqA3pcp12jMrvz07FGI4e4JO0lJB/7H6KGggWJtjh4hG9y6t8+1UROA6hRn1oUImST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866757; c=relaxed/simple;
	bh=ksx5GILc+xmfeC9Tgn+bKUmmuj3WNfnkJowAv04MRLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFsggrERGKgEh0UBEkt0zC12XZEycUR3T7EA0/YPqerNudl50LqRIKyZQ0ZVzePlUQa+qdcJBplzFjDv2iNTkkJg5DuH7XYtdFlTmykwvUtiPiHrbo1MZP77xua3ozOuZ8CJ6eO6fnlOdNMP0Z+lyFVWtdS08u9SRoM4tXBbRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6547A339;
	Tue, 23 Apr 2024 03:06:19 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D2B23F7BD;
	Tue, 23 Apr 2024 03:05:49 -0700 (PDT)
Date: Tue, 23 Apr 2024 11:05:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: peterz@infradead.org, mingo@redhat.com, frederic@kernel.org,
	acme@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix missing wakeup when waiting for
 context reference
Message-ID: <ZieH-g8fWn60z-ev@FVFF77S0Q05N>
References: <20240418114209.22233-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418114209.22233-1-haifeng.xu@shopee.com>

On Thu, Apr 18, 2024 at 11:42:09AM +0000, Haifeng Xu wrote:
> In our production environment, we found many hung tasks which are
> blocked for more than 18 hours. Their call traces are like this:
> 
> [346278.191038] __schedule+0x2d8/0x890
> [346278.191046] schedule+0x4e/0xb0
> [346278.191049] perf_event_free_task+0x220/0x270
> [346278.191056] ? init_wait_var_entry+0x50/0x50
> [346278.191060] copy_process+0x663/0x18d0
> [346278.191068] kernel_clone+0x9d/0x3d0
> [346278.191072] __do_sys_clone+0x5d/0x80
> [346278.191076] __x64_sys_clone+0x25/0x30
> [346278.191079] do_syscall_64+0x5c/0xc0
> [346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
> [346278.191086] ? do_syscall_64+0x69/0xc0
> [346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
> [346278.191092] ? irqentry_exit+0x19/0x30
> [346278.191095] ? exc_page_fault+0x89/0x160
> [346278.191097] ? asm_exc_page_fault+0x8/0x30
> [346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The task was waiting for the refcount become to 1, but from the vmcore,
> we found the refcount has already been 1. It seems that the task didn't
> get woken up by perf_event_release_kernel() and got stuck forever. The
> below scenario may cause the problem.
> 
> Thread A					Thread B
> ...						...
> perf_event_free_task				perf_event_release_kernel
> 						   ...
> 						   acquire event->child_mutex
> 						   ...
> 						   get_ctx
>    ...						   release event->child_mutex
>    acquire ctx->mutex
>    ...
>    perf_free_event (acquire/release event->child_mutex)
>    ...
>    release ctx->mutex
>    wait_var_event
> 						   acquire ctx->mutex
> 						   acquire event->child_mutex
> 						   # move existing events to free_list
> 						   release event->child_mutex
> 						   release ctx->mutex
> 						   put_ctx
> ...						...
> 
> In this case, all events of the ctx have been freed, so we couldn't
> find the ctx in free_list and Thread A will miss the wakeup. It's thus
> necessary to add a wakeup after dropping the reference.
> 
> Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

FWIW, this looks good to me, but I haven't yet been able to write a test to
exercise this: perf_event_free_task() is only called if
perf_event_init_context() fails or of copy_process() fails partway through, and
while it should be possible to make the latter fail consistently by messing
with cgroups, I haven't had the time to work all that out.

So I think there's a reliable DoS here, but I haven't had the time to go write
that myself. It would be nice if we actually had a test for this.

I reckon that in addition to the Fixes tag, this needs:

Cc: stable@vger.kernel.org

> ---
> Changes since v1:
> - Add the fixed tag.
> - Simplify v1's patch. (Frederic)
> 
> Changes since v2:
> - Use Reviewed-by tag instead of Signed-off-by tag.
> ---
>  kernel/events/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4f0c45ab8d7d..15c35070db6a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5340,6 +5340,7 @@ int perf_event_release_kernel(struct perf_event *event)
>  again:
>  	mutex_lock(&event->child_mutex);
>  	list_for_each_entry(child, &event->child_list, child_list) {
> +		void *var = NULL;
>  
>  		/*
>  		 * Cannot change, child events are not migrated, see the
> @@ -5380,11 +5381,23 @@ int perf_event_release_kernel(struct perf_event *event)
>  			 * this can't be the last reference.
>  			 */
>  			put_event(event);
> +		} else {
> +			var = &ctx->refcount;
>  		}
>  
>  		mutex_unlock(&event->child_mutex);
>  		mutex_unlock(&ctx->mutex);
>  		put_ctx(ctx);
> +
> +		if (var) {
> +			/*
> +			 * If perf_event_free_task() has deleted all events from the
> +			 * ctx while the child_mutex got released above, make sure to
> +			 * notify about the preceding put_ctx().
> +			 */
> +			smp_mb(); /* pairs with wait_var_event() */
> +			wake_up_var(var);
> +		}
>  		goto again;
>  	}
>  	mutex_unlock(&event->child_mutex);

I was a bit worrited that we're doing the wakeup with the event->child_mutex
held; AFAICT that looks to be safe, but I'm not a scheduler expert.

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> -- 
> 2.25.1
> 

