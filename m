Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849479D324
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjILOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjILOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:05:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4710D1;
        Tue, 12 Sep 2023 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bz5HUQeC5qHCT1bKpsnwfOlGI85lpMISdJds+v8aDT8=; b=Damh5GcP5UQgBGLJL49ZARVjh4
        Z5fuwgyu4P/ZOEGVQPZp4T/DCUmZ/cXd2KhO8ez9yKIpeVbrvuKoyupZXYzYjan7Bxd6te2vdpQ/7
        kehcq7twAAbHV77GQZ23Q1J+EMLj3lN7+E3jtkCBHYyH4RfcnEwl6sKAT+n0sQ67yyB51NHm5fyUj
        /3luTygdq3HWld4x18I4mLcRDvljdGcxfMZFygCyhgM/aC2O1hTw4S2O9d5qUlUQjZ+ychzkBPP2Y
        DT+YRizWLT9SWkgaNfc58PeK+BK7xiluf5p7FVfVXV0d8bm/9r/c59OSWqSAlwqKkNDaV496+Cmt0
        F0x2rzNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg40H-0069ly-1U;
        Tue, 12 Sep 2023 14:04:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EE82300348; Tue, 12 Sep 2023 16:04:34 +0200 (CEST)
Date:   Tue, 12 Sep 2023 16:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     x86@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, irogers@google.com,
        mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
        hpa@zytor.com, mingo@redhat.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [RESEND PATCH 2/2] perf/core: Allow reading package events from
 perf_event_read_local
Message-ID: <20230912140434.GB22127@noisy.programming.kicks-ass.net>
References: <20230912124432.3616761-1-tero.kristo@linux.intel.com>
 <20230912124432.3616761-3-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912124432.3616761-3-tero.kristo@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:44:32PM +0300, Tero Kristo wrote:
> Per-package perf events are typically registered with a single CPU only,
> however they can be read across all the CPUs within the package.
> Currently perf_event_read maps the event CPU according to the topology
> information to avoid an unnecessary SMP call, however
> perf_event_read_local deals with hard values and rejects a read with a
> failure if the CPU is not the one exactly registered. Allow similar
> mapping within the perf_event_read_local if the perf event in question
> can support this.
> 
> This allows users like BPF code to read the package perf events properly
> across different CPUs within a package.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  kernel/events/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..780dde646e8a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4528,6 +4528,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  {
>  	unsigned long flags;
>  	int ret = 0;
> +	int event_cpu;
>  
>  	/*
>  	 * Disabling interrupts avoids all counter scheduling (context
> @@ -4551,15 +4552,18 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  		goto out;
>  	}
>  
> +	event_cpu = READ_ONCE(event->oncpu);
> +	event_cpu = __perf_event_read_cpu(event, event_cpu);

What happens with __perf_event_read_cpu() when event_cpu == -1 ?

> +
>  	/* If this is a per-CPU event, it must be for this CPU */
>  	if (!(event->attach_state & PERF_ATTACH_TASK) &&
> -	    event->cpu != smp_processor_id()) {
> +	    event_cpu != smp_processor_id()) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	/* If this is a pinned event it must be running on this CPU */
> -	if (event->attr.pinned && event->oncpu != smp_processor_id()) {
> +	if (event->attr.pinned && event_cpu != smp_processor_id()) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -4569,7 +4573,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>  	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
>  	 * oncpu == -1).
>  	 */
> -	if (event->oncpu == smp_processor_id())
> +	if (event_cpu == smp_processor_id())
>  		event->pmu->read(event);
>  
>  	*value = local64_read(&event->count);
> -- 
> 2.40.1
> 
