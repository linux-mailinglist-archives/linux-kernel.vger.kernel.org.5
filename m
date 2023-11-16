Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B27EE169
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKPNTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKPNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:19:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D78C81A5;
        Thu, 16 Nov 2023 05:19:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA3591595;
        Thu, 16 Nov 2023 05:19:51 -0800 (PST)
Received: from [10.57.3.57] (unknown [10.57.3.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCA963F73F;
        Thu, 16 Nov 2023 05:19:02 -0800 (PST)
Message-ID: <90c9d5b5-fbb1-437d-a961-efd0da61d6f7@arm.com>
Date:   Thu, 16 Nov 2023 13:19:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     wyes.karny@amd.com, beata.michalska@arm.com, juri.lelli@redhat.com,
        mingo@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org, vschneid@redhat.com, bristot@redhat.com,
        mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, peterz@infradead.org, qyousef@layalina.io
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231103131821.1176294-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 11/3/23 13:18, Vincent Guittot wrote:
> The current method to take into account uclamp hints when estimating the
> target frequency can end into situation where the selected target
> frequency is finally higher than uclamp hints whereas there are no real
> needs. Such cases mainly happen because we are currently mixing the
> traditional scheduler utilization signal with the uclamp performance
> hints. By adding these 2 metrics, we loose an important information when
> it comes to select the target frequency and we have to make some
> assumptions which can't fit all cases.
> 
> Rework the interface between the scheduler and schedutil governor in order
> to propagate all information down to the cpufreq governor.
> 
> effective_cpu_util() interface changes and now returns the actual
> utilization of the CPU with 2 optional inputs:
> - The minimum performance for this CPU; typically the capacity to handle
>    the deadline task and the interrupt pressure. But also uclamp_min
>    request when available.
> - The maximum targeting performance for this CPU which reflects the
>    maximum level that we would like to not exceed. By default it will be
>    the CPU capacity but can be reduced because of some performance hints
>    set with uclamp. The value can be lower than actual utilization and/or
>    min performance level.
> 
> A new sugov_effective_cpu_perf() interface is also available to compute
> the final performance level that is targeted for the CPU after applying
> some cpufreq headroom and taking into account all inputs.
> 
> With these 2 functions, schedutil is now able to decide when it must go
> above uclamp hints. It now also have a generic way to get the min
> perfromance level.
> 
> The dependency between energy model and cpufreq governor and its headroom
> policy doesn't exist anymore.
> 
> eenv_pd_max_util asks schedutil for the targeted performance after
> applying the impact of the waking task.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Just in case you are waiting for me. The patch should be OK as
you explained to me in v2. I'm not able to test it right now
on my pixel6 downstream-tracking-mainline kernel, so please
go forward not waiting for me. (the pixel6 is the only platform
that I have now which is normally using the uclamp).

Regards,
Lukasz
