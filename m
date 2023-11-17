Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6B57EF08E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjKQKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbjKQKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:33:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B5129;
        Fri, 17 Nov 2023 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esOzA9VVK9bUu3e2cxLHY6AuD1sva62ndBB8LGOwhgA=; b=Na2Yx3OL2X/FAh6FULgf3IRx5J
        BS5WYPaXqDE8y/ejczxsKfF45a94a0j6oUoqV4K26rR10+PXIeohx3BSzR1LU0whkvO+O0MkKIxYi
        kC4b65tfrTAO2tJxVE1EAUvQurWxDCZYOOQ4Vi/KsMy2PogrWyOIR6gPPgBeFSSwZ8WnIz0CyHM7z
        vVL7sIqe8JkMtWYi+O1NPE+jWkieuE7HHT9kSAyniVG0B3EvYbGAkGZBVlmdyxnB6MmJo/Ke4i2WC
        leaXXhpNYu4QMZwXxzJTr+vQsxwc8tnYJqJKrrc/6eo33Y6nULqqDEBbfIYIt0RtcB3tD+azYB935
        ZQTI6fLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3w9M-008qar-KX; Fri, 17 Nov 2023 10:32:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B5F6300478; Fri, 17 Nov 2023 11:32:36 +0100 (CET)
Date:   Fri, 17 Nov 2023 11:32:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM
 guest-only events
Message-ID: <20231117103236.GI3818@noisy.programming.kicks-ass.net>
References: <20231107183605.409588-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107183605.409588-1-seanjc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:36:05AM -0800, Sean Christopherson wrote:
> Don't apply minimum period workarounds/requirements to events that are
> being created by KVM to virtualize PMCs for guests, i.e. skip limit
> enforcement for events that exclude the host.  Perf's somewhat arbitrary
> limits prevents KVM from correctly virtualizing counter overflow, e.g. if
> the guest sets a counter to have an effective period of '1', forcing a
> minimum period of '2' results in overflow occurring at the incorrect time.
> 
> Whether or not a "real" profiling use case is affected is debatable, but
> the incorrect behavior is trivially easy to observe and reproduce, and is
> deterministic enough to make the PMU appear to be broken from the guest's
> perspective.
> 
> Furthermore, the "period" set by KVM isn't actually a period, as KVM won't
> automatically reprogram the event with the same period on overflow.  KVM
> will synthesize a PMI into the guest when appropriate, but what the guest
> does in response to the PMI is purely a guest decision.  In other words,
> KVM effectively operates in a one-shot mode, not a periodic mode.
> 
> Letting KVM and/or the guest program "too small" periods is safe for the
> host, as events that exclude the host are atomically disabled with respect
> to VM-Exit, i.e. are guaranteed to stop counting upon transitioning to the
> host.  And whether or not *explicitly* programming a short period is safe
> is somewhat of a moot point, as transitions to/from the guest effectively
> yield the same effect, e.g. an unrelated VM-Exit => VM-Enter transition
> will re-enable guest PMCs with whatever count happened to be in the PMC at
> the time of VM-Exit.
> 
> Cc: Like Xu <likexu@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Disclaimer: I've only tested this from KVM's side of things.
> 
>  arch/x86/events/core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 40ad1425ffa2..f8a8a4ea4d47 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_event *event)
>  		hwc->last_period = period;
>  		ret = 1;
>  	}
> -	/*
> -	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> -	 */
> -	if (unlikely(left < 2))
> -		left = 2;
>  
>  	if (left > x86_pmu.max_period)
>  		left = x86_pmu.max_period;
>  
> -	static_call_cond(x86_pmu_limit_period)(event, &left);
> +	/*
> +	 * Exempt KVM guest events from the minimum period requirements.  It's
> +	 * the guest's responsibility to ensure it can make forward progress,
> +	 * and it's KVM's responsibility to configure an appropriate "period"
> +	 * to correctly virtualize overflow for the guest's PMCs.
> +	 */
> +	if (!event->attr.exclude_host) {
> +		/*
> +		 * Quirk: certain CPUs dont like it if just 1 event is left:
> +		 */
> +		if (unlikely(left < 2))
> +			left = 2;
> +
> +		static_call_cond(x86_pmu_limit_period)(event, &left);
> +	}

Hmm, IIRC we can disable that left < 2 thing for anything that doesn't
have x86_pmu.pebs_no_isolation IIRC.

I'm not sure about taking out the limit_period call, why does it make
sense to allow the guest to program obviously invalid settings?

That is, would something like the below work for you?

---
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 40ad1425ffa2..5543a0bab1f8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -152,6 +152,14 @@ u64 x86_perf_event_update(struct perf_event *event)
 	return new_raw_count;
 }
 
+static void x86_perf_limit_period(struct perf_event *event, s64 *left)
+{
+	/*
+	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
+	 */
+	*left = max(*left, 2);
+}
+
 /*
  * Find and validate any extra registers to set up.
  */
@@ -1388,11 +1396,6 @@ int x86_perf_event_set_period(struct perf_event *event)
 		hwc->last_period = period;
 		ret = 1;
 	}
-	/*
-	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
-	 */
-	if (unlikely(left < 2))
-		left = 2;
 
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
@@ -2130,6 +2133,10 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.update)
 		x86_pmu.update = x86_perf_event_update;
 
+	// XXX check non-Intel
+	if (!x86_pmu.limit_period && x86_pmu.pebs_no_isolation)
+		x86_pmu.limit_update = x86_perf_limit_period;
+
 	x86_pmu_static_call_update();
 
 	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a08f794a0e79..9fe0f241779e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4471,7 +4471,10 @@ static void bdw_limit_period(struct perf_event *event, s64 *left)
 		if (*left < 128)
 			*left = 128;
 		*left &= ~0x3fULL;
+		return;
 	}
+	if (unlikely(x86_pmu.pebs_no_isolation))
+		*left = max(*left, 2);
 }
 
 static void nhm_limit_period(struct perf_event *event, s64 *left)
