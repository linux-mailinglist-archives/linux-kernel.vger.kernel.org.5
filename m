Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627147A1A26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjIOJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:15:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA8DFCCD;
        Fri, 15 Sep 2023 02:15:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58BFF1FB;
        Fri, 15 Sep 2023 02:16:08 -0700 (PDT)
Received: from [10.57.35.82] (unknown [10.57.35.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7E583F67D;
        Fri, 15 Sep 2023 02:15:29 -0700 (PDT)
Message-ID: <3fc888d4-fc18-7947-0541-9dc42892c071@arm.com>
Date:   Fri, 15 Sep 2023 10:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 2/7] sched/pelt: Add a new function to approximate
 runtime to reach given util
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-3-qyousef@layalina.io>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20230827233203.1315953-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 00:31, Qais Yousef wrote:
> It is basically the ramp-up time from 0 to a given value. Will be used
> later to implement new tunable to control response time  for schedutil.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>   kernel/sched/pelt.c  | 21 +++++++++++++++++++++
>   kernel/sched/sched.h |  1 +
>   2 files changed, 22 insertions(+)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 50322005a0ae..f673b9ab92dc 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>   
>   	return sa.util_avg;
>   }
> +
> +/*
> + * Approximate the required amount of runtime in ms required to reach @util.
> + */
> +u64 approximate_runtime(unsigned long util)
> +{
> +	struct sched_avg sa = {};
> +	u64 delta = 1024; // period = 1024 = ~1ms
> +	u64 runtime = 0;
> +
> +	if (unlikely(!util))
> +		return runtime;
> +
> +	while (sa.util_avg < util) {
> +		accumulate_sum(delta, &sa, 0, 0, 1);

This looks a bit uncomfortable as the existing comment says that we assume:

	if (!load)
		runnable = running = 0;

I haven't looked at the math in detail, but if this is okay, maybe a 
comment saying why this is okay despite the existing comment says otherwise?

> +		___update_load_avg(&sa, 0);
> +		runtime++;
> +	}
> +
> +	return runtime;
> +} > [...]
