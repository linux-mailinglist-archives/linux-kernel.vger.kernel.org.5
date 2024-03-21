Return-Path: <linux-kernel+bounces-110622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7743F886160
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D35C281EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302D134750;
	Thu, 21 Mar 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bswh3M17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAC134428;
	Thu, 21 Mar 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051101; cv=none; b=OrXKi/mC2AojAYcDJz9wqn4AQ9TY1TS6TP5e1dtN1rWuGXDw3+EqK0KsrBWxV7eFP4fj81fDYHNHtfLyEBjp5Oju576ARinqmxt/XHU/rFEBm+h4pj8Rrd6fx6HE/1c7NRi7fk4RW62Rk+FFmdP716WrrWMA2klcdbXdHh9VVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051101; c=relaxed/simple;
	bh=412A9G1xvc9KWN8uYFJK6xoGGzzP/mRkZgKkvJrAdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3nq50PjdGvxJrzMZPOsCJsK+EvFS+VP9QvSu460q2YP7vOiAaKPq9vhrSBjauiSxSlHT3O1nbWFbB/qGqHBx+Td/jECJQqoS1VYwYfi+2eTeL+NLL1izFGI4eoauTV/XId+972clobwEWv1RNX4NpwO6o2CB0nrnSc/VtHwiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bswh3M17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04026C433C7;
	Thu, 21 Mar 2024 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711051100;
	bh=412A9G1xvc9KWN8uYFJK6xoGGzzP/mRkZgKkvJrAdPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bswh3M17MUp9NQTSHevNoVHvLBea911+J3WRyO6SnDRPv4B8eJ3uiN9zMYDSKXehA
	 Tz4lZ6s0NbImA5YLC0fkP4atBLp8SPFvtmS4Lx/0iD0rzrnKUQKGoBnFtY5GXXxKCE
	 ifDxFRV9O5SW6lrortJjcYs9P4pykL/tEsP7JfGbWN4PdenQ0bbjEOEz956eQAiI1m
	 reXbU9812uUEb3QA2rnfFXPLRlhOLtGgeJaL5vfkwAASKWYY5evR7p82rjttz5Oh3S
	 XcmmuElVLQDzeZu8JeCv+FDJvW0TOhoAniYgY+TWrLCzn4vSLk1TEE0qD+yeXrE6Ln
	 6+yFqzk8Uq+/w==
Date: Thu, 21 Mar 2024 16:58:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anne Macedo <retpolanne@posteo.net>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf lock contention: skip traceiter functions
Message-ID: <ZfyRWZqxypTzdvQF@x1>
References: <20240319143629.3422590-1-retpolanne@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319143629.3422590-1-retpolanne@posteo.net>

Now lemme nitpick a bit, and I'll do it myself while processing the
patch, some are from my days sending patches to Ingo and from his
requests it become second nature, others I do to further clarify the
text:

And here is the reason for top posting, the first request is about the
subject line:

Subject: [PATCH v4] perf lock contention: skip traceiter functions

Becomes:

Subject: [PATCH v4] perf lock contention: Trim backtrace by skipping traceiter functions

Please make it so that after the component the one line summary starts
with a capital letter and packs as much info as possible.

On Tue, Mar 19, 2024 at 02:36:26PM +0000, Anne Macedo wrote:
> The perf lock contention program currently shows the caller of the locks

I try to make the sub (sub) command stand out by single quoting it:

  The 'perf lock contention' program currently shows the caller of the locks

What follows is great, nice description, before/after.

Thanks, testing it now on x86_64 and aarch64, will apply it then.

- Arnaldo

> as __traceiter_contention_begin+0x??. This caller can be ignored, as it is
> from the traceiter itself. Instead, it should show the real callers for
> the locks.
> 
> When fiddling with the --stack-skip parameter, the actual callers for
> the locks start to show up. However, just ignore the
> __traceiter_contention_begin and the __traceiter_contention_end symbols
> so the actual callers will show up.
> 
> Before this patch is applied:
> 
> sudo perf lock con -a -b -- sleep 3
>  contended   total wait     max wait     avg wait         type   caller
> 
>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __traceiter_contention_begin+0x44
>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __traceiter_contention_begin+0x44
>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __traceiter_contention_begin+0x44
>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_contention_begin+0x84
>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __traceiter_contention_begin+0x44
>          1     13.54 us     13.54 us     13.54 us        mutex   trace_contention_begin+0x84
>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __traceiter_contention_begin+0x44
> 
> Before this patch is applied - using --stack-skip 5
> 
> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
>  contended   total wait     max wait     avg wait         type   caller
> 
>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epoll_wait+0x5a0
>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exit+0x338
>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_signal+0x108
>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   release_task+0x68
>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup_kn_lock_live+0x58
>          1     24.71 us     24.71 us     24.71 us     spinlock   do_exit+0x44
>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_mm_and_find_vma+0xb0
> 
> After this patch is applied:
> 
> sudo ./perf lock con -a -b -- sleep 3
>  contended   total wait     max wait     avg wait         type   caller
> 
>          4      4.13 s       2.07 s       1.03 s      rwlock:W   release_task+0x68
>          2      2.07 s       2.07 s       1.03 s      rwlock:R   mm_update_next_owner+0x50
>          2      2.07 s       2.07 s       1.03 s      rwlock:W   do_exit+0x338
>          1     41.56 ms     41.56 ms     41.56 ms        mutex   cgroup_kn_lock_live+0x58
>          2     36.12 us     18.83 us     18.06 us     rwlock:W   do_exit+0x338
> 
> changes since v3:
> 
> - remove dummy value and assume machine->traceiter and machine->trace
> have zero address
> 
> changes since v2:
> 
> - add dummy value to machine->traceiter and machine->trace to make
> necessary checks, fixing possible null pointer access
> 
> changes since v1:
> 
> - consider trace_contention and __traceiter_contention functions as
> optional (i.e. check if sym is null to avoid segfault)
> 
> changes since v0:
> 
> - skip trace_contention functions
> - use sym->end instead of __traceiter_contention_end for text_end
> 
> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
> ---
>  tools/perf/util/machine.c | 24 ++++++++++++++++++++++++
>  tools/perf/util/machine.h |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 527517db3182..5eb9044bc223 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3266,6 +3266,17 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
>  
>  		sym = machine__find_kernel_symbol_by_name(machine, "__lock_text_end", &kmap);
>  		machine->lock.text_end = map__unmap_ip(kmap, sym->start);
> +
> +		sym = machine__find_kernel_symbol_by_name(machine, "__traceiter_contention_begin", &kmap);
> +		if (sym) {
> +			machine->traceiter.text_start = map__unmap_ip(kmap, sym->start);
> +			machine->traceiter.text_end = map__unmap_ip(kmap, sym->end);
> +		}
> +		sym = machine__find_kernel_symbol_by_name(machine, "trace_contention_begin", &kmap);
> +		if (sym) {
> +			machine->trace.text_start = map__unmap_ip(kmap, sym->start);
> +			machine->trace.text_end = map__unmap_ip(kmap, sym->end);
> +		}
>  	}
>  
>  	/* failed to get kernel symbols */
> @@ -3280,5 +3291,18 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
>  	if (machine->lock.text_start <= addr && addr < machine->lock.text_end)
>  		return true;
>  
> +	/* traceiter functions currently don't have their own section
> +	 * but we consider them lock functions
> +	 */
> +	if (machine->traceiter.text_start != 0) {
> +		if (machine->traceiter.text_start <= addr && addr < machine->traceiter.text_end)
> +			return true;
> +	}
> +
> +	if (machine->trace.text_start != 0) {
> +		if (machine->trace.text_start <= addr && addr < machine->trace.text_end)
> +			return true;
> +	}
> +
>  	return false;
>  }
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index e28c787616fe..4312f6db6de0 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -49,7 +49,7 @@ struct machine {
>  	struct {
>  		u64	  text_start;
>  		u64	  text_end;
> -	} sched, lock;
> +	} sched, lock, traceiter, trace;
>  	pid_t		  *current_tid;
>  	size_t		  current_tid_sz;
>  	union { /* Tool specific area */
> -- 
> 2.39.2
> 

