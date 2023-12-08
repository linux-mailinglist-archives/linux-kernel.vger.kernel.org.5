Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EC80A15E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjLHKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:42:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3475EC3;
        Fri,  8 Dec 2023 02:42:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE8911FB;
        Fri,  8 Dec 2023 02:43:35 -0800 (PST)
Received: from [10.57.84.184] (unknown [10.57.84.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B363F762;
        Fri,  8 Dec 2023 02:42:48 -0800 (PST)
Message-ID: <f61a3329-4223-4995-8732-030430d19ea4@arm.com>
Date:   Fri, 8 Dec 2023 10:42:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] sched/schedutil: Ignore update requests for short
 running tasks
To:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-4-qyousef@layalina.io>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231208015242.385103-4-qyousef@layalina.io>
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

Hi Qais,

On 08/12/2023 01:52, Qais Yousef wrote:
> Ignore freq updates to honour uclamp requests if the task is short
> running. It won't run long enough to see the changes, so avoid the
> unnecessary work and noise.
> 
> Make sure SCHED_CPUFREQ_PERF_HINTS flag is set in task_tick_fair() so
> that we can do correction action if the task continued to run such that
> it is no longer considered a short task.
> 
> Should address the problem of noisy short running tasks unnecessary
> causing frequency spikes when waking up on a CPU that is running a busy
> task capped by UCLAMP_MAX.

Actually, an occasional spike is not a big problem to me.

What is a big concern is a normal task and a uclamp_max task running on 
the same rq. If the uclamp_max task is 1024 but capped by uclamp_max at 
the lowest OPP, and the normal task has no uclamp but a duty cycle, then 
when the normal task wakes up on the rq, it'll be the highest OPP. When 
it sleeps, the ulamp_max is back and at the lowest OPP. This square-wave 
problem to me is a much bigger concern than an infrequent spike. If 
CONFIG_HZ is 1000, this square wave's frequency is 500 switching between 
highest and lowest OPP, which is definitely unacceptable.

The problem I think with filtering is, under this condition, should we 
filter out the lowest OPP or the highest? Neither sounds like a good 
answer because neither is a short-running task and the correct answer 
might be somewhere in between.

Sorry to ramble on this again and again, but I think filtering is 
addressing the symptom, not the cause. The cause is we have no idea 
under what condition a util_avg was achieved. The 1024 task in the 
previous example would be much better if we extend it into

[1024, achieved at uclamp_min 0, achieved at uclamp_max 300]

If we know 1024 was done under uclamp_max of 300, then we know we don't 
need to raise to the max OPP. So far, we carry around a lot of different 
new variables but not these two which we really need.

> 
> Move helper functions to access task_util_est() and related attributes
> to sched.h to enable using it from cpufreq_schedutil.c
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>   kernel/sched/cpufreq_schedutil.c | 59 ++++++++++++++++++++++++++++++++
>   kernel/sched/fair.c              | 24 +------------
>   kernel/sched/sched.h             | 22 ++++++++++++
>   3 files changed, 82 insertions(+), 23 deletions(-)
> 
> [...]
