Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC914782EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjHUQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjHUQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:41:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93BBF125;
        Mon, 21 Aug 2023 09:41:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2BC2F4;
        Mon, 21 Aug 2023 09:41:48 -0700 (PDT)
Received: from [192.168.178.99] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3413F64C;
        Mon, 21 Aug 2023 09:41:05 -0700 (PDT)
Message-ID: <7fdfff24-80ed-acbf-810f-b641570141fd@arm.com>
Date:   Mon, 21 Aug 2023 18:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/4] sched: cpufreq: Apply DVFS headroom to CFS only
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-5-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230820210640.585311-5-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 23:06, Qais Yousef wrote:
> RT and Deadline have exact performance requirement when running. RT runs
> at max or a specific OPP defined by uclamp_min. Deadline's OPP is
> defined by its bandwidth. Both of which are known ahead of time and
> don't require a headroom to grow into.
> 
> IRQs on the other hand have no specific performance requirement and
> cruises along at whatever the current OPP happens to be when they occur.
> 
> Now they all have PELT pressure signals that does impact frequency
> selection and task placement. The question is do they need DVFS
> headroom?
> 
> I think the answer is no because when CFS is not running at all, these
> pressure signal has no real impact on performance for RT, DL or IRQ.
> 
> If CFS util is not zero, we already add their pressure as an
> *additional* headroom to account for the lost/stolen time. So I argue
> that the pressure are headroom themselves and shouldn't need an
> additional DVFS headroom applied on top.
> 
> In summary final outcome should be:
> 
> 	CFS + DVFS headroom + (RT, DT, IRQ) pressure headroom

I assume here you want to align the difference that EAS deals with
`util_cfs` vs `capacity` whereas power deals with `util` vs
`capacity_orig`? You want that power should only apply the 1.25 to util_cfs?

> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 441d433c83cd..602e369753a3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7438,10 +7438,11 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>  	 * When there are no CFS RUNNABLE tasks, clamps are released and
>  	 * frequency will be gracefully reduced with the utilization decay.
>  	 */
> -	util = util_cfs + cpu_util_rt(rq);
>  	if (type == FREQUENCY_UTIL) {
> -		util = apply_dvfs_headroom(util);
> +		util = apply_dvfs_headroom(util_cfs) + cpu_util_rt(rq);
>  		util = uclamp_rq_util_with(rq, util, p);
> +	} else {
> +		util = util_cfs + cpu_util_rt(rq);
>  	}
>  
>  	dl_util = cpu_util_dl(rq);
> @@ -7473,12 +7474,9 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>  	 *              max - irq
>  	 *   U' = irq + --------- * U
>  	 *                 max
> -	 *
> -	 * We only need to apply dvfs headroom to irq part since the util part
> -	 * already had it applied.
>  	 */
>  	util = scale_irq_capacity(util, irq, max);
> -	util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
> +	util += irq;
>  
>  	/*
>  	 * Bandwidth required by DEADLINE must always be granted while, for
> @@ -7491,7 +7489,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
>  	 * an interface. So, we only do the latter for now.
>  	 */
>  	if (type == FREQUENCY_UTIL)
> -		util += apply_dvfs_headroom(cpu_bw_dl(rq));
> +		util += cpu_bw_dl(rq);
>  
>  	return min(max, util);
>  }

