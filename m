Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4D792B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbjIEQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354405AbjIELZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:25:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E91AB;
        Tue,  5 Sep 2023 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jPdY00euY8J+TZ+gfMJOomJioLJ2A7fsibzKqzqSliw=; b=S8qjyM1AKzFNJQWjk8hguQd6AR
        9Sc6ZcYYLGctPBhpFl6oyPYCVXcm5P3A5PQoVecUlntjO+Vjm3ZVB0KCkIhnvW1ZU9PRlppQUNJ/3
        fxAxBaRKBEW7YVIC7xCW1AHK5krY06krL1X58jJnpPLS0KhzTJUHmLPWXAKDY3flMkNZ4UhurEspC
        uSFBmJj4bCiA6sePSK291Nn7S/hvMxiSJW7ohZPyfKC4tXQXrMyV9j0cU4zYHvR58njDSkbN3eLpD
        F7UN27WEZ6HZjWpIXKc1Ust8Ov9ua6K9NDyJHjByBK2iyQn0n9sPTJp9qGcdQ+RTTf3ngPWu/2m29
        sGFFfK5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdUAy-0097Sa-2K; Tue, 05 Sep 2023 11:24:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B53A3300687; Tue,  5 Sep 2023 13:24:55 +0200 (CEST)
Date:   Tue, 5 Sep 2023 13:24:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
Message-ID: <20230905112455.GD28319@noisy.programming.kicks-ass.net>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901130312.247719-4-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 03:03:11PM +0200, Vincent Guittot wrote:

> +#ifdef arch_scale_freq_ref
> +/**
> + * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
> + * has been used to correlate frequency and compute capacity.
> + * @cpu: the CPU in question.
> + *
> + * Return: the reference CPU frequency.
> + */
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
> +{
> +	return arch_scale_freq_ref(policy->cpu);
> +}
> +#else
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)

double space    ^^

> +{
> +	if (arch_scale_freq_invariant())
> +		return policy->cpuinfo.max_freq;
> +
> +

superfluous whitespace there.

> +	return policy->cur;
> +}
> +#endif

static __always_inline
unsigned long arch_scale_freq_ref_policy(struct cpufreq_policy *policy)
{
#ifdef arch_scale_freq_ref
	return arch_scale_freq_ref(policy->cpu);
#endif

	if (arch_scale_freq_invariant())
		return policy->cpuinfo.max_freq;

	return policy->cur;
}

Would have the lot in a single function and possibly easier to read?

> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -139,11 +164,11 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
>  static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  				  unsigned long util, unsigned long max)
>  {
> +	unsigned int freq;
>  	struct cpufreq_policy *policy = sg_policy->policy;
> -	unsigned int freq = arch_scale_freq_invariant() ?
> -				policy->cpuinfo.max_freq : policy->cur;

Leave the variable below per the inverse christmas thing.

>  
>  	util = map_util_perf(util);
> +	freq = arch_scale_freq_ref_policy(policy);
>  	freq = map_util_freq(util, freq, max);
>  
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> -- 
> 2.34.1
> 
