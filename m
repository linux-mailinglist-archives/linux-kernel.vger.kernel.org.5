Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334FA79E920
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbjIMNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbjIMNXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:23:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC8B1BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VQJLS1YBl9bl9ZVJkCFcaMDa8QCfLuppZ1atPmQU/uQ=; b=D774AVEkIf5lLFpweRbT6aHJVa
        W/Ap70X6h2+C6TB0P2ff0YX1e4dK8V05DoLXMA4T8qOlYkMrxpg0/K1nVi4P8JMZvreJcxWRN5uyD
        BWmgyXUX037/NoKviBe8A6AxyZlG0S58UnTCk7qi7CNthvnWl53z0gdYxT14CkhXeWaxn3clv329p
        eQIaTrgD5XchhrOEm1gN8eSgwxd9PM2TGNqzRZPIvbt2/88v2SkFnrs9Iz+ldxAk731Eq+yqY/Ml0
        R4fsXMhsKbOukIONL/XFY6jkoFJ0cJzE4VFRm0/pyHRRSgGgLF4s9ZRse9wRiVJPtX57AkPAs+qkQ
        bb+czVQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgPpT-00E5YD-LU; Wed, 13 Sep 2023 13:22:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C454300348; Wed, 13 Sep 2023 15:22:51 +0200 (CEST)
Date:   Wed, 13 Sep 2023 15:22:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH,RFC] smp,csd: throw an error if a CSD lock is stuck for
 too long
Message-ID: <20230913132251.GE22758@noisy.programming.kicks-ass.net>
References: <20230821160409.663b8ba9@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821160409.663b8ba9@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:04:09PM -0400, Rik van Riel wrote:
> The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> temporarily, it usually gets released in a few seconds, and sometimes
> up to one or two minutes.
> 
> If the CSD lock stays stuck for more than several minutes, it never
> seems to get unstuck, and gradually more and more things in the system
> end up also getting stuck.
> 
> In the latter case, we should just give up, so the system can dump out
> a little more information about what went wrong, and, with panic_on_oops
> and a kdump kernel loaded, dump a whole bunch more information about
> what might have gone wrong.
> 
> Question: should this have its own panic_on_ipistall switch in
> /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> way than via BUG_ON?
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/smp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 385179dae360..8b808bff15e6 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -228,6 +228,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	}
>  
>  	ts2 = sched_clock();
> +	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>  		return false;
> @@ -241,9 +242,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	else
>  		cpux = cpu;
>  	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/* How long since this CSD lock was stuck. */
> +	ts_delta = ts2 - ts0;
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
>  		 cpu, csd->func, csd->info);
> +	/*
> +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> +	 * to become unstuck. Use a signed comparison to avoid triggering
> +	 * on underflows when the TSC is out of sync between sockets.
> +	 */
> +	BUG_ON((s64)ts_delta > 300000000000LL);
>  	if (cpu_cur_csd && csd != cpu_cur_csd) {
>  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),

How are you guys still seeing this? I thought the KVM APIC thing was
fixed a while ago?
