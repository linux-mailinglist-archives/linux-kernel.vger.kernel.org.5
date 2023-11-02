Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7C7DF21C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbjKBMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346548AbjKBMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:16:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A17BD198;
        Thu,  2 Nov 2023 05:03:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95CEC2F4;
        Thu,  2 Nov 2023 05:04:18 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 899CC3F67D;
        Thu,  2 Nov 2023 05:03:33 -0700 (PDT)
Message-ID: <c9e89355-9503-4623-9320-e4a4f57dcd98@arm.com>
Date:   Thu, 2 Nov 2023 13:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/schedutil: rework performance estimation
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
 <20231026170913.32605-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231026170913.32605-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 19:09, Vincent Guittot wrote:

[...]

> @@ -153,14 +152,38 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> +				 unsigned long min,
> +				 unsigned long max)
> +{
> +	unsigned long target;
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	if (rt_rq_is_runnable(&rq->rt))
> +		return max;
> +
> +	/* Provide at least enough capacity for DL + IRQ */
> +	target = min;
> +
> +	actual = map_util_perf(actual);
> +	/* Actually we don't need to target the max performance */
> +	if (actual < max)
> +		max = actual;
> +
> +	/*
> +	 * Ensure at least minimum performance while providing more compute
> +	 * capacity when possible.
> +	 */
> +	return max(target, max);

The superfluous `unsigned long target` is still there?

  return max(min, max) is much cleaer.

[...]
