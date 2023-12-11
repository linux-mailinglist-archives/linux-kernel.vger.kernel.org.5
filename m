Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F080C26C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjLKHzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLKHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:55:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63BF4F4;
        Sun, 10 Dec 2023 23:55:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C14B1007;
        Sun, 10 Dec 2023 23:55:54 -0800 (PST)
Received: from [10.57.84.143] (unknown [10.57.84.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EC273F5A1;
        Sun, 10 Dec 2023 23:55:05 -0800 (PST)
Message-ID: <8ee6425a-0a0e-4391-9fd3-8fe74c809772@arm.com>
Date:   Mon, 11 Dec 2023 07:56:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <bc525124-da79-45af-a99b-ec4616b3fa6b@arm.com>
 <20231210205156.kausxdcwsydggwie@airbuntu>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231210205156.kausxdcwsydggwie@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/23 20:51, Qais Yousef wrote:
> On 12/08/23 10:05, Lukasz Luba wrote:
>> Hi Qais,
>>
>> On 12/8/23 01:52, Qais Yousef wrote:
>>
>> [snip]
>>
>>> @@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>    	 */
>>>    	util_est_enqueue(&rq->cfs, p);
>>> -	/*
>>> -	 * If in_iowait is set, the code below may not trigger any cpufreq
>>> -	 * utilization updates, so do it here explicitly with the IOWAIT flag
>>> -	 * passed.
>>> -	 */
>>> -	if (p->in_iowait)
>>> -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>> -
>>
>> Why this io wait boost is considered as the $subject says 'aggressive'
>> calling?
> 
> This will trigger a frequency update along with the iowait boost. Did I miss
> something?

Yes, it will change CPU freq and it was the main goal for this code
path. We have tests which check how that works on different memory
types.

Why do you want to remove it?

Did you run some tests (e.g. fio, gallery, etc) to check if you still
have a decent performance out some new ufs/nvme memories?

Beata & Dietmar have presented at LPC2021 a proposal to have a per-task
io boost, with a bit more controllable way of the trade off power vs.
performance [1]. IMO the io wait boost could evolve, not simply die.

Regards,
Lukasz

[1] https://lpc.events/event/11/contributions/1042/
