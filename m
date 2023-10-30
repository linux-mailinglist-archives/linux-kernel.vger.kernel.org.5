Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D477DBD68
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjJ3QEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJ3QEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:04:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BFDEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uAoarrbeEOi+ThvFg0exUiGAqfLtD6t4DohDctCATSQ=; b=XAMxg6SONejIbZYDLjmqQ4e/RG
        pdA5o0RYfETlyIi0zD2FyhT1wqg8ORb/7jfgqGnqWqxkAhdJiNf6G2HUZcJCDHFh6XjKI3CpwCQus
        +jP12vFCGCARNiVZ+wVW6kEobPQRRxD1yB5TI+Gk64pH8hDt8GVZSrV1yc8k3jBtdgqNELYp5PV0o
        IMrSeBA96BpfFm81e08nssZQqsIuaHcpfHX+WK25zTNUnRA5UKi6OJvzckiN/cMhERIjpXJ7rfbwI
        dTSQMKoabdWHKri9W95IxD2hEGiHsftzqCc+rNc1VjQBwjjBSGxccnvgOFZOlEfoTmOittasP3uHS
        rU40jwcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxUkY-0042jG-1B;
        Mon, 30 Oct 2023 16:04:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E837300478; Mon, 30 Oct 2023 17:04:22 +0100 (CET)
Date:   Mon, 30 Oct 2023 17:04:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        feng.tang@intel.com
Subject: Re: [PATCH] x86/tsc: Have tsc=recalibrate override things
Message-ID: <20231030160422.GB19106@noisy.programming.kicks-ass.net>
References: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160050.GA15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:00:50PM +0100, Peter Zijlstra wrote:
> ---
>  arch/x86/kernel/tsc.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 15f97c0abc9d..ebca304ecea0 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1430,14 +1430,13 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  			hpet ? "HPET" : "PM_TIMER",
>  			(unsigned long)freq / 1000,
>  			(unsigned long)freq % 1000);
> +	} else {
>  
> -		return;
> +		/* Make sure we're within 1% */
> +		if (abs(tsc_khz - freq) > tsc_khz/100)
> +			goto out;
>  	}
>  
> -	/* Make sure we're within 1% */
> -	if (abs(tsc_khz - freq) > tsc_khz/100)
> -		goto out;
> -
>  	tsc_khz = freq;
>  	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
>  		(unsigned long)tsc_khz / 1000,
> @@ -1475,18 +1474,19 @@ static int __init init_tsc_clocksource(void)
>  	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
>  		clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>  
> -	/*
> -	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
> -	 * the refined calibration and directly register it as a clocksource.
> -	 */
>  	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
>  		if (boot_cpu_has(X86_FEATURE_ART))
>  			art_related_clocksource = &clocksource_tsc;
> -		clocksource_register_khz(&clocksource_tsc, tsc_khz);
> -		clocksource_unregister(&clocksource_tsc_early);
>  
> -		if (!tsc_force_recalibrate)
> -			return 0;
> +		/*
> +		 * When TSC frequency is known (retrieved via MSR or CPUID), we
> +		 * skip the refined calibration and directly register it as a
> +		 * clocksource.
> +		 */
> +		if (!tsc_force_recalibrate) {
> +			clocksource_register_khz(&clocksource_tsc, tsc_khz);
> +			clocksource_unregister(&clocksource_tsc_early);

+			return 0;

Clearly I should step away from the keyboard now.

> +		}
>  	}
>  
>  	schedule_delayed_work(&tsc_irqwork, 0);
> 
