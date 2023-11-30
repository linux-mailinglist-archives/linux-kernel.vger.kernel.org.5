Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18BA7FFC77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjK3UaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjK3UaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:30:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD73E1703;
        Thu, 30 Nov 2023 12:30:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30A2C1042;
        Thu, 30 Nov 2023 12:30:52 -0800 (PST)
Received: from [10.57.82.136] (unknown [10.57.82.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D6A03F73F;
        Thu, 30 Nov 2023 12:30:02 -0800 (PST)
Message-ID: <8009d5c4-4012-44a2-883c-0d7f74c4a2c1@arm.com>
Date:   Thu, 30 Nov 2023 20:30:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
 <20231127143238.1216582-2-vincent.guittot@linaro.org>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231127143238.1216582-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 14:32, Vincent Guittot wrote:
> sched_feat(UTIL_EST_FASTUP) has been added to easily disable the feature
> in order to check for possibly related regressions. After 3 years, it has
> never been used and no regression has been reported. Let remove it
> and make fast increase a permanent behavior.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> I haven't updated the chinese documentation which also refers to
> UTIL_EST_FASTUP. IIUC, this will be updated afterward by the
> Translations' maintainers.

Here it is in case you have to provide the translation:

diff --git a/Documentation/translations/zh_CN/scheduler/schedutil.rst 
b/Documentation/translations/zh_CN/scheduler/schedutil.rst
index d1ea68007520..7c8d87f21c42 100644
--- a/Documentation/translations/zh_CN/scheduler/schedutil.rst
+++ b/Documentation/translations/zh_CN/scheduler/schedutil.rst
@@ -89,16 +89,15 @@ 
r_cpu被定义为当前CPU的最高性能水平与系统中任何其它CPU的最
   - Documentation/translations/zh_CN/scheduler/sched-capacity.rst:"1. 
CPU Capacity + 2. Task utilization"


-UTIL_EST / UTIL_EST_FASTUP
-==========================
+UTIL_EST
+========

 
由于周期性任务的平均数在睡眠时会衰减，而在运行时其预期利用率会和睡眠前相同，
  因此它们在再次运行后会面临（DVFS）的上涨。

  为了缓解这个问题，（一个默认使能的编译选项）UTIL_EST驱动一个无限脉冲响应
  （Infinite Impulse Response，IIR）的EWMA，“运行”值在出队时是最高的。
-另一个默认使能的编译选项UTIL_EST_FASTUP修改了IIR滤波器，使其允许立即增加，
-仅在利用率下降时衰减。
+UTIL_EST滤波使其在遇到更高值时立刻增加，而遇到低值时会缓慢衰减。

  进一步，运行队列的（可运行任务的）利用率之和由下式计算：

> 
>   Documentation/scheduler/schedutil.rst | 7 +++----
>   kernel/sched/fair.c                   | 8 +++-----
>   kernel/sched/features.h               | 1 -
>   3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/scheduler/schedutil.rst b/Documentation/scheduler/schedutil.rst
> index 32c7d69fc86c..803fba8fc714 100644
> --- a/Documentation/scheduler/schedutil.rst
> +++ b/Documentation/scheduler/schedutil.rst
> @@ -90,8 +90,8 @@ For more detail see:
>    - Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task utilization"
>   
>   
> -UTIL_EST / UTIL_EST_FASTUP
> -==========================
> +UTIL_EST
> +========
>   
>   Because periodic tasks have their averages decayed while they sleep, even
>   though when running their expected utilization will be the same, they suffer a
> @@ -99,8 +99,7 @@ though when running their expected utilization will be the same, they suffer a
>   
>   To alleviate this (a default enabled option) UTIL_EST drives an Infinite
>   Impulse Response (IIR) EWMA with the 'running' value on dequeue -- when it is
> -highest. A further default enabled option UTIL_EST_FASTUP modifies the IIR
> -filter to instantly increase and only decay on decrease.
> +highest. UTIL_EST filters to instantly increase and only decay on decrease.
>   
>   A further runqueue wide sum (of runnable tasks) is maintained of:
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 34fe6e9490c2..146329678cb8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4870,11 +4870,9 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	 * to smooth utilization decreases.
>   	 */
>   	ue.enqueued = task_util(p);
> -	if (sched_feat(UTIL_EST_FASTUP)) {
> -		if (ue.ewma < ue.enqueued) {
> -			ue.ewma = ue.enqueued;
> -			goto done;
> -		}
> +	if (ue.ewma < ue.enqueued) {
> +		ue.ewma = ue.enqueued;
> +		goto done;
>   	}
>   
>   	/*
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index a3ddf84de430..143f55df890b 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -83,7 +83,6 @@ SCHED_FEAT(WA_BIAS, true)
>    * UtilEstimation. Use estimated CPU utilization.
>    */
>   SCHED_FEAT(UTIL_EST, true)
> -SCHED_FEAT(UTIL_EST_FASTUP, true)
>   
>   SCHED_FEAT(LATENCY_WARN, false)
>   

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
