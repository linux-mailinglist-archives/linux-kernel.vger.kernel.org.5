Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F967DB79D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjJ3KPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjJ3KPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:15:08 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E89E387A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ODO51XdUw0hVUvsJtE3A7b0/mN0G8++f9rKwPpZbZQ=;
  b=kOjRrNbg3qNLOQNMT0nFZUIA24WxoS646GsoXsb4WiyNdYX1BzRHk3/F
   ST8F4+pskz2zmNlXjYM5gPxsWR4y9dZtphsMyQUtgqFUTnM5z0cgflm78
   J2VSXNtAEwgQ7yPDkXmVL1qTltxxWFqWvTCfrTXT0RCA+HQ8enFsV+c0p
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,263,1694728800"; 
   d="scan'208";a="70099723"
Received: from dt-aponte.paris.inria.fr (HELO [128.93.67.66]) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:02:15 +0100
Message-ID: <c78aa476-44c7-4691-ae6b-d4b5ebc83c25@inria.fr>
Date:   Mon, 30 Oct 2023 11:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
 <27d88cac-95d2-4861-b79c-410e3cfd96a9@linux.vnet.ibm.com>
 <CAKfTPtC=H4P_Hn7koJfWwfqVc7UyWNzzyrFWymnoYVK3pJkiDQ@mail.gmail.com>
From:   Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <CAKfTPtC=H4P_Hn7koJfWwfqVc7UyWNzzyrFWymnoYVK3pJkiDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2023 09:05, Vincent Guittot wrote:
> On Mon, 30 Oct 2023 at 05:03, Shrikanth Hegde
> <sshegde@linux.vnet.ibm.com> wrote:
>>
>>
>>
>> On 10/27/23 10:47 PM, Keisuke Nishimura wrote:
>>> should_we_balance is called for the decision to do load-balancing.
>>> When sched ticks invoke this function, only one CPU should return
>>> true. However, in the current code, two CPUs can return true. The
>>> following situation, where b means busy and i means idle, is an
>>> example because CPU 0 and CPU 2 return true.
>>>
>>>          [0, 1] [2, 3]
>>>           b  b   i  b
>>>
>>> This fix checks if there exists an idle CPU with busy sibling(s)
>>> after looking for a CPU on an idle core. If some idle CPUs with busy
>>> siblings are found, just the first one should do load-balancing.
>>>
>>
>>> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
>>> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
>>> ---
>>>   kernel/sched/fair.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 2048138ce54b..eff0316d6c7d 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
>>>                return cpu == env->dst_cpu;
>>>        }
>>>
>>
>>
>> There is comment above this /* Are we the first idle CPU? */
>> Maybe update that comment as /* Are we the first idle core */
> 
> I was about to say the same but it's not always true. If we are at SMT
> level, we look for an idle CPU in the core
> 

Maybe I should update the comment with the additional contexts:

/*
  * Are we the first idle core in a sched_domain not-sharing capacity,
  * or the first idle CPU in a sched_domain sharing capacity?
  */


>>
>>> -     if (idle_smt == env->dst_cpu)
>>> -             return true;
>>> +     /* Is there an idle CPU with busy siblings? */
>> nit: We can keep the comment style fixed in this function.
>> /* Are we the first idle CPU with busy siblings */
>>

OK, agreed. Should I create version 2?

thanks,
Keisuke

>>> +     if (idle_smt != -1)
>>> +             return idle_smt == env->dst_cpu;
>>>
>>>        /* Are we the first CPU of this group ? */
>>>        return group_balance_cpu(sg) == env->dst_cpu;
>>
>> code changes LGTM
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
