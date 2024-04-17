Return-Path: <linux-kernel+bounces-148926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA38A8914
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0172846A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636B16FF54;
	Wed, 17 Apr 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc7mAjfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AC12C819;
	Wed, 17 Apr 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372185; cv=none; b=Qnx1IIx0a+/V6zMRV2jBxFsZaflVaLA9uCh5UfA0i3AHVcbGztX5mIe3fGNnIjSkPQjI4uXLDW7yTkopZCH7VQL9FMifg5nAX1sNUnC6rfvk3ILRtjpBnc/XYVoqpeNB3uzIKqQhbFkTJWm0WI0hu2TL4Z9xAUMizGngjjVcsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372185; c=relaxed/simple;
	bh=udOQU6qULd9iH68Y7LxBN420UgVde/T/XE/CJPLv1aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGOxuprlCdmzVxrFuCGPA2HFBYly1T2sBjrwjfdrd8KHxgOdPf4I4Bay2TIl2EhUVVGkyryRkfffND0R6+7D5PP2WJOkStR0OiHSFVNoIjSjeVajl5Ko4rqt4WHz1HMNKA0JXpFqQUfYv/EVuDgwHdJOLDurbU7L+VAhU0lHUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc7mAjfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091BCC072AA;
	Wed, 17 Apr 2024 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713372185;
	bh=udOQU6qULd9iH68Y7LxBN420UgVde/T/XE/CJPLv1aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc7mAjfIMDNv6CRsI5j5NBcr+0DZz21dcQyxwYhTczkvcuKa9DqunhzQ8XZ/GhvIU
	 ZnZ6Id7Q19m77VrqvhVDWiXVSiuyGnVg89XSSwpWU3bbBbj5Mx+MqrQiJrqKkw037y
	 gRG6X6LvwSmwHOx5yZuaW9B+dA/NtXu1JzzLxxlasJJeBr0M1C5Z8OfTbDIeHCal70
	 V98PTyFthagHW7JcAMimSAM57HDJ9RnbO7rPqFtC7R6AjHDBvtwNlyep6Hs5I/n7I5
	 ch93ZCjgt/cKJEAkpD694TT29ujs7pkdMWybh2N7n8Ckop0FOoOFUXJxjkJw2o7Q+9
	 cna49ChWcBxlQ==
Date: Wed, 17 Apr 2024 18:43:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix missing wakeup when waiting for context
 reference
Message-ID: <Zh_8FpT10qoE-x1u@localhost.localdomain>
References: <20240410035506.599192-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410035506.599192-1-haifeng.xu@shopee.com>

Le Wed, Apr 10, 2024 at 03:55:06AM +0000, Haifeng Xu a écrit :
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
> 						   acquire event->mutex
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
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  kernel/events/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4f0c45ab8d7d..01dfe715f09e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5340,6 +5340,8 @@ int perf_event_release_kernel(struct perf_event *event)
>  again:
>  	mutex_lock(&event->child_mutex);
>  	list_for_each_entry(child, &event->child_list, child_list) {
> +		void *var;
> +		bool freed = false;
>  
>  		/*
>  		 * Cannot change, child events are not migrated, see the
> @@ -5380,11 +5382,25 @@ int perf_event_release_kernel(struct perf_event *event)
>  			 * this can't be the last reference.
>  			 */
>  			put_event(event);
> +		} else {
> +			freed = true;
> +			var = &ctx->refcount;
>  		}
>  
>  		mutex_unlock(&event->child_mutex);
>  		mutex_unlock(&ctx->mutex);
>  		put_ctx(ctx);
> +
> +		if (freed) {
> +			/*
> +			 * perf_event_free_task() delete all events of the ctx and
> +			 * there is no event of the ctx in free_list. It may step
> +			 * into wait_var_event() before decrement the refcount. So
> +			 * we should add a wakeup here.
> +			 */
> +			smp_mb(); /* pairs with wait_var_event() */
> +			wake_up_var(var);
> +		}
>  		goto again;

Good catch!

How about the following slightly simplified version?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..4082d0161b2b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5365,6 +5365,7 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
+		void *var = NULL;
 
 		/*
 		 * Cannot change, child events are not migrated, see the
@@ -5405,11 +5406,23 @@ int perf_event_release_kernel(struct perf_event *event)
 			 * this can't be the last reference.
 			 */
 			put_event(event);
+		} else {
+			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
+
+		if (var) {
+			/*
+			 * If perf_event_free_task() has deleted all events from the
+			 * ctx while the child_mutex got released above, make sure to
+			 * notify about the preceding put_ctx().
+			 */
+			smp_mb(); /* pairs with wait_var_event() */
+			wake_up_var(var);
+		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);



>  	}
>  	mutex_unlock(&event->child_mutex);
> -- 
> 2.25.1
> 
> 

