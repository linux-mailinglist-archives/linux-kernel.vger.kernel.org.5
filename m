Return-Path: <linux-kernel+bounces-149861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F0C8A96EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB30B1F21209
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AE15B572;
	Thu, 18 Apr 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDej8SDt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916715B544;
	Thu, 18 Apr 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434583; cv=none; b=OlcertYLWEAIRnsWmgyJAPyjXs6d1st6B46eg0qxqIcSq1V8eZ97hhLK3MVIzviT9NTCZrbqsSxTYZ8Qp+ofXJfN0SOYg8ZJs6PpmqqQeenL6ir/I5oAI298ePpU2sMmTFL8XzvMj7lZxPijPoM19UkCd3quMX4C/fNbCVn6cIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434583; c=relaxed/simple;
	bh=oJZpk3DWNO5wv+DUjDMVAC4Zkf2sFQ01Zacpn3wqjfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOL/6mm/sw4QC5HWB5QvnjlZVgcmXUhPIY3YA6Ltqp1b6886v9FDVi3IGB1/3OpTfEPLzeRVZ3YT++8UHk4MUw5QC04prKJ8JPSCuyOFg8IxSD3h8L+sALf1UyyCmyeHX9pq8hxFmw62+WCa0g8DsTrlTlD1VriQ9z7LxU7JgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDej8SDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA97AC113CC;
	Thu, 18 Apr 2024 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713434583;
	bh=oJZpk3DWNO5wv+DUjDMVAC4Zkf2sFQ01Zacpn3wqjfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDej8SDtUt5weJEfMTWMYDsk0C9grc5BIS0elzQp/JwJlpeUzU7OhaDdu7SGOq2Ld
	 Siay2liwSonD5dNuVeJPfVXpQoOKp5r94o7v+p5Y0Ql8YEWjzPBKqLSPR6MPeQDKrf
	 r3LmXvdnElMCi9OVwbHVHcQ5l/zezrgvHJ8k/8xMAzM4gRAlGF+Wrh6I3rc1QoCNnc
	 tObkRQiikDaPAn7EKXzkzgth0Zv/G9b/Af7RbulsAA/y6S7UhELChJoNtp2dRev+62
	 idljm85v4sib6f4CtBBO5bJxxnKdz5ISgUyv2HCoUz9EOdu03YbBOpKEGqNcgrn7Vu
	 SfV7qIM50+uTw==
Date: Thu, 18 Apr 2024 12:03:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Fix missing wakeup when waiting for
 context reference
Message-ID: <ZiDv1P5AHj7+E7cW@lothringen>
References: <20240418080356.21639-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418080356.21639-1-haifeng.xu@shopee.com>

On Thu, Apr 18, 2024 at 08:03:56AM +0000, Haifeng Xu wrote:
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
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Hint: always ask before putting someone else's Signed-off-by tag ;-)
And anyway you don't need it here.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
> Changes since v1
> - Add the fixed tag.
> - Simplify v1's patch. (Frederic)
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
> -- 
> 2.25.1
> 

