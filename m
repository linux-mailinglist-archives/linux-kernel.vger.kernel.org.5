Return-Path: <linux-kernel+bounces-98774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB60877F36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B874CB219B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7B3B796;
	Mon, 11 Mar 2024 11:42:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E62C69A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157363; cv=none; b=HWqejbFQXJXwoiPxr3HOKlFcMZdvH2AsAq1f30+OzbcjBdF3swRBlgGHVAWn3roVS7RMhKHERwjbeAVdO4cmyz0kObw4R9Otzd83tyKRR/8668fZCeNQUY6FEuUkX+kpw6FlZTh/mi4FFIXoU3Ee62eDK+GN4urmD+D/q49SMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157363; c=relaxed/simple;
	bh=QJ8mCU78FrXZ6n5IJs2I64RMXveWUU9Gf3SWRWrxCv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz3oFwWFjezlDX/GY/m+2b1s9zJPS7PoyyqEuMz1Zl3TftdDygPU/F59Yy1DVbMcwazWYpPjp5OoEolrAvWfFU9TRCztSS9e3XBV0Rl8SaWwfIeUA1M524s8KjXnKLntS90TciLZjnsR03x5ulzcLIe04V2KSloArjz4vKzC+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42127FEC;
	Mon, 11 Mar 2024 04:43:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF2E3F64C;
	Mon, 11 Mar 2024 04:42:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:42:29 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: kmsan: fix instrumentation recursion on preempt_count
Message-ID: <Ze7uJUynNXDjLmmn@FVFF77S0Q05N>
References: <20240311112330.372158-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311112330.372158-1-changbin.du@huawei.com>

On Mon, Mar 11, 2024 at 07:23:30PM +0800, Changbin Du wrote:
> This disables msan check for preempt_count_{add,sub} to fix a
> instrumentation recursion issue on preempt_count:
> 
>   __msan_metadata_ptr_for_load_4() -> kmsan_virt_addr_valid() ->
> 	preempt_disable() -> __msan_metadata_ptr_for_load_4()
> 
> With this fix, I was able to run kmsan kernel with:
>   o CONFIG_DEBUG_KMEMLEAK=n
>   o CONFIG_KFENCE=n
>   o CONFIG_LOCKDEP=n
> 
> KMEMLEAK and KFENCE generate too many false positives in unwinding code.
> LOCKDEP still introduces instrumenting recursions issue. But these are
> other issues expected to be fixed.
> 
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..5b63bb98e60a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5848,7 +5848,7 @@ static inline void preempt_latency_start(int val)
>  	}
>  }
>  
> -void preempt_count_add(int val)
> +void __no_kmsan_checks preempt_count_add(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>  	/*
> @@ -5880,7 +5880,7 @@ static inline void preempt_latency_stop(int val)
>  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
>  }

What prevents a larger loop via one of the calles of preempt_count_{add,sub}()

For example, via preempt_latency_{start,stop}() ?

.. or via some *other* instrumentation that might be placed in those?

I suspect we should be using noinstr or __always_inline in a bunch of places to
clean this up properly.

Mark.

