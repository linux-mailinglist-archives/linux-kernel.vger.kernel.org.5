Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633B812ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443427AbjLNIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:53:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1902C95;
        Thu, 14 Dec 2023 00:53:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65585C15;
        Thu, 14 Dec 2023 00:53:57 -0800 (PST)
Received: from [10.57.85.242] (unknown [10.57.85.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653083F762;
        Thu, 14 Dec 2023 00:53:07 -0800 (PST)
Message-ID: <e0b1a6a8-0163-4f7d-b876-b7a3e6c74b2e@arm.com>
Date:   Thu, 14 Dec 2023 08:54:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched: Rename arch_update_thermal_pressure into
 arch_update_hw_pressure
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     catalin.marinas@arm.com, bristot@redhat.com,
        linux-pm@vger.kernel.org, juri.lelli@redhat.com, agross@kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-trace-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, konrad.dybcio@linaro.org,
        andersson@kernel.org, rostedt@goodmis.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bsegall@google.com,
        vschneid@redhat.com, will@kernel.org, sudeep.holla@arm.com,
        daniel.lezcano@linaro.org, mhiramat@kernel.org,
        amit.kachhap@gmail.com
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-5-vincent.guittot@linaro.org>
 <274a6562-46c9-4b03-9295-c24e5eb9e6cd@arm.com>
 <CAKfTPtDKRfF7QzwoDwkGKZ_DJS3ewBncifC37LADfNJwtQfiYA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtDKRfF7QzwoDwkGKZ_DJS3ewBncifC37LADfNJwtQfiYA@mail.gmail.com>
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



On 12/14/23 08:36, Vincent Guittot wrote:
> On Thu, 14 Dec 2023 at 09:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>> On 12/12/23 14:27, Vincent Guittot wrote:

[snip]

>>>        update_rq_clock(rq);
>>> -     thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
>>> -     update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
>>> +     hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>>> +     update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
>>
>> We switch to task clock here, could you tell me why?
>> Don't we have to maintain the boot command parameter for the shift?
> 
> This should have been part of the patch5 that I finally removed. IMO,
> the additional time shift with rq_clock_thermal is no more needed now
> that we have 2 separates signals
> 

I didn't like the left-shift which causes the signal to converge slowly.
I rather wanted right-shift to converge (react faster), so you have my
vote for this change. Also, I agree that with the two-signal approach
this shift trick can go away now. I just worry about the dropped boot
parameter.

So, are going to send that patach5 which removes the
'sched_thermal_decay_shift' and documentation bit?
