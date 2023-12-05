Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820DC805C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbjLERX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjLERXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:23:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 743331A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:23:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5C03139F;
        Tue,  5 Dec 2023 09:24:44 -0800 (PST)
Received: from [10.1.31.59] (e133649.arm.com [10.1.31.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768BF3F5A1;
        Tue,  5 Dec 2023 09:23:56 -0800 (PST)
Message-ID: <7f0bfaa5-22c3-4ed3-bf34-cb7ad6b4c335@arm.com>
Date:   Tue, 5 Dec 2023 17:23:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] sched: uclamp sum aggregation
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <20231203002544.d4zx3oyvjugohh22@airbuntu>
 <7f1f7dd0-e3b5-4e16-a44e-c08fca567f97@arm.com>
 <CAKfTPtBZ+7STLsRH7h+WeitcH1i4623J4xb0XQKTzsp=XNV_-w@mail.gmail.com>
 <cf221099-31f4-4de1-9418-a354f002e26e@arm.com>
 <CAKfTPtD10c4Uif6EATJ2SiAPdnEzXkC78nZE=q23dLM7fszvEQ@mail.gmail.com>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtD10c4Uif6EATJ2SiAPdnEzXkC78nZE=q23dLM7fszvEQ@mail.gmail.com>
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

On 05/12/2023 16:26, Vincent Guittot wrote:
> On Tue, 5 Dec 2023 at 16:19, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> On 04/12/2023 16:12, Vincent Guittot wrote:
>>> On Mon, 4 Dec 2023 at 02:48, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>>>
>>>> [...]
>>>>
>>>> Other shortcomings are not that critical, but the fact that uclamp_min's
>>>> effectiveness is divided by N under max aggregation I think is not
>>>> acceptable.
>>>
>>> Change EAS task placement policy in this case to take into account
>>> actual utilization and uclamp_min/max
>>
>> Thank you. I agree. I want to emphasize this specifically because this
>> is exactly what I'm trying to do. The whole series can be rephrased in a
>> different way:
>>
>> - The PELT signal is distorted when uclamp is active.
> 
> Sorry but no it's not >> - Let's consider the [PELT, uclamp_min, uclamp_max] tuple.
> 
> That's what we are already doing with effective_cpu_util. We might
> want to improve how we use them in EAS but that's another story than
> your proposal

It's different. We never catch how we *got* the PELT value. If we wake 
up a task, what we do now is to have the following:

[p->util_avg, p->uclamp_min, p->uclamp_max, target_rq->uclamp_min, 
target_rq->uclamp_max]

But to best understand how big this task really was, we want:

[p->util_avg, previous_rq->uclamp_min_back_then, 
previous_rq->uclamp_max_back_then]

Without such information, issues cannot be avoided because we have no 
idea how big the task really was. Frequency spikes is just one of the 
symptoms when we mis-interpret how big the task was.

>> - Always carrying all three variables is too much, but [PELT,
>> clamped(PELT)] is an approximation that works really well.
> 
> As said before. It's a no go for this mix

I see your concern. To rephrase this series again, I'm simply arguing that

[p->util_avg, previous_uclamp_min, previous_uclamp_max]

is better than

[p->util_avg, p->uclamp_min, p->uclamp_max, target_rq->uclamp_min, 
target_rq->uclamp_max] plus the code to mitigate the issues

in estimating how big the task is.

I anticipate this series to be significantly smaller than the current 
max aggregation approach plus future code to mitigate the problems, but 
I'll keep trying to improve it to hopefully address your concerns.

>>
>> Of course, I'll explore if there's a way to make things less messy. I
>> just realized why I didn't do things util_est way but instead directly
>> clamping on PELT, it's because util_est boosts util_avg and can't work
>> for uclamp_max. I'll keep exploring options.
>>
>>>> [...]
