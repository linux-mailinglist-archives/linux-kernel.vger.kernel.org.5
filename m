Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7A7E3B62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjKGL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjKGL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:59:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612B10A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:59:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC5AC433C8;
        Tue,  7 Nov 2023 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358340;
        bh=hru7SqaljxjJQ2Z7l0e/UMeTPje7tHCbfMGysXSXcYk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SWQlN3C3kLv3o6MX4KOMeyvRWX8q8/YSp976siNCHqBe7fcz5XQoQ7AGWQNHJ8HEV
         iratbJpM4vZv7KAGkMP35Bz5qwr9LRJ+XekNTflJZShRq9qnf2e/WdDP2cMRJvYWyv
         2pb1YF5y1VfEnIZ+nuG0vjrG9D4tUwrf7foLK0Hh9bhqujmJO2sBfkVCuBDCEBDthW
         Y/HxjI0YjBiITZV1idxh+DOyjGH9zE0kOZyogc0OD/UC5x+CNg+sCrJctcAL9CDt2+
         psFPe5PmoZZbmm+rBQFeLOjsU1xHubo0VSbd6+agsoz3svF7CfQMoui6GKwbpxM8ta
         EAo3ZKbgEJAsA==
Message-ID: <d6811957-1cb7-489d-a3da-f38622d7f515@kernel.org>
Date:   Tue, 7 Nov 2023 12:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 22:37, Joel Fernandes wrote:
> On Mon, Nov 6, 2023 at 4:32 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> On Mon, Nov 6, 2023 at 2:32 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> Hi Daniel,
>>>
>>> On Sat, Nov 4, 2023 at 6:59 AM Daniel Bristot de Oliveira
>>> <bristot@kernel.org> wrote:
>>>>
>>>> Among the motivations for the DL servers is the real-time throttling
>>>> mechanism. This mechanism works by throttling the rt_rq after
>>>> running for a long period without leaving space for fair tasks.
>>>>
>>>> The base dl server avoids this problem by boosting fair tasks instead
>>>> of throttling the rt_rq. The point is that it boosts without waiting
>>>> for potential starvation, causing some non-intuitive cases.
>>>>
>>>> For example, an IRQ dispatches two tasks on an idle system, a fair
>>>> and an RT. The DL server will be activated, running the fair task
>>>> before the RT one. This problem can be avoided by deferring the
>>>> dl server activation.
>>>>
>>>> By setting the zerolax option, the dl_server will dispatch an
>>>> SCHED_DEADLINE reservation with replenished runtime, but throttled.
>>>>
>>>> The dl_timer will be set for (period - runtime) ns from start time.
>>>> Thus boosting the fair rq on its 0-laxity time with respect to
>>>> rt_rq.
>>>>
>>>> If the fair scheduler has the opportunity to run while waiting
>>>> for zerolax time, the dl server runtime will be consumed. If
>>>> the runtime is completely consumed before the zerolax time, the
>>>> server will be replenished while still in a throttled state. Then,
>>>> the dl_timer will be reset to the new zerolax time
>>>>
>>>> If the fair server reaches the zerolax time without consuming
>>>> its runtime, the server will be boosted, following CBS rules
>>>> (thus without breaking SCHED_DEADLINE).
>>>>
>>>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>>>> ---
>>>>  include/linux/sched.h   |   2 +
>>>>  kernel/sched/deadline.c | 100 +++++++++++++++++++++++++++++++++++++++-
>>>>  kernel/sched/fair.c     |   3 ++
>>>>  3 files changed, 103 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>> index 5ac1f252e136..56e53e6fd5a0 100644
>>>> --- a/include/linux/sched.h
>>>> +++ b/include/linux/sched.h
>>>> @@ -660,6 +660,8 @@ struct sched_dl_entity {
>>>>         unsigned int                    dl_non_contending : 1;
>>>>         unsigned int                    dl_overrun        : 1;
>>>>         unsigned int                    dl_server         : 1;
>>>> +       unsigned int                    dl_zerolax        : 1;
>>>> +       unsigned int                    dl_zerolax_armed  : 1;
>>>>
>>>>         /*
>>>>          * Bandwidth enforcement timer. Each -deadline task has its
>>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>>> index 1d7b96ca9011..69ee1fbd60e4 100644
>>>> --- a/kernel/sched/deadline.c
>>>> +++ b/kernel/sched/deadline.c
>>>> @@ -772,6 +772,14 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
>>>>         /* for non-boosted task, pi_of(dl_se) == dl_se */
>>>>         dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
>>>>         dl_se->runtime = pi_of(dl_se)->dl_runtime;
>>>> +
>>>> +       /*
>>>> +        * If it is a zerolax reservation, throttle it.
>>>> +        */
>>>> +       if (dl_se->dl_zerolax) {
>>>> +               dl_se->dl_throttled = 1;
>>>> +               dl_se->dl_zerolax_armed = 1;
>>>> +       }
>>>>  }
>>>>
>>>>  /*
>>>> @@ -828,6 +836,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>>>>   * could happen are, typically, a entity voluntarily trying to overcome its
>>>>   * runtime, or it just underestimated it during sched_setattr().
>>>>   */
>>>> +static int start_dl_timer(struct sched_dl_entity *dl_se);
>>>>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>>>  {
>>>>         struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>>>> @@ -874,6 +883,28 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>>>                 dl_se->dl_yielded = 0;
>>>>         if (dl_se->dl_throttled)
>>>>                 dl_se->dl_throttled = 0;
>>>> +
>>>> +       /*
>>>> +        * If this is the replenishment of a zerolax reservation,
>>>> +        * clear the flag and return.
>>>> +        */
>>>> +       if (dl_se->dl_zerolax_armed) {
>>>> +               dl_se->dl_zerolax_armed = 0;
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * A this point, if the zerolax server is not armed, and the deadline
>>>> +        * is in the future, throttle the server and arm the zerolax timer.
>>>> +        */
>>>> +       if (dl_se->dl_zerolax &&
>>>> +           dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq))) {
>>>> +               if (!is_dl_boosted(dl_se)) {
>>>> +                       dl_se->dl_zerolax_armed = 1;
>>>> +                       dl_se->dl_throttled = 1;
>>>> +                       start_dl_timer(dl_se);
>>>> +               }
>>>> +       }
>>>>  }
>>>>
>>>>  /*
>>>> @@ -1024,6 +1055,13 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
>>>>                 }
>>>>
>>>>                 replenish_dl_new_period(dl_se, rq);
>>>> +       } else if (dl_server(dl_se) && dl_se->dl_zerolax) {
>>>> +               /*
>>>> +                * The server can still use its previous deadline, so throttle
>>>> +                * and arm the zero-laxity timer.
>>>> +                */
>>>> +               dl_se->dl_zerolax_armed = 1;
>>>> +               dl_se->dl_throttled = 1;
>>>>         }
>>>>  }
>>>>
>>>> @@ -1056,8 +1094,20 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
>>>>          * We want the timer to fire at the deadline, but considering
>>>>          * that it is actually coming from rq->clock and not from
>>>>          * hrtimer's time base reading.
>>>> +        *
>>>> +        * The zerolax reservation will have its timer set to the
>>>> +        * deadline - runtime. At that point, the CBS rule will decide
>>>> +        * if the current deadline can be used, or if a replenishment
>>>> +        * is required to avoid add too much pressure on the system
>>>> +        * (current u > U).
>>>>          */
>>>> -       act = ns_to_ktime(dl_next_period(dl_se));
>>>> +       if (dl_se->dl_zerolax_armed) {
>>>> +               WARN_ON_ONCE(!dl_se->dl_throttled);
>>>> +               act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
>>>
>>> Just a question, here if dl_se->deadline - dl_se->runtime is large,
>>> then does that mean that server activation will be much more into the
>>> future? So say I want to give CFS 30%, then it will take 70% of the
>>> period before CFS preempts RT thus "starving" CFS for this duration. I
>>> think that's Ok for smaller periods and runtimes, though.
>>>
>>> I think it does reserve the amount of required CFS bandwidth so it is
>>> probably OK, though it is perhaps letting RT run more initially (say
>>> if CFS tasks are not CPU bound and occasionally wake up, they will
>>> always be hit by the 70% latency AFAICS which may be large for large
>>> periods and small runtimes).
>>>
>>
>> One more consideration I guess is, because the server is throttled
>> till 0-laxity time, it is possible that if CFS sleeps even a bit
>> (after the DL-server is unthrottled), then it will be pushed out to a
>> full current deadline + period due to CBS. In such a situation,  if
>> CFS-server is the only DL task running, it might starve RT for a bit
>> more time.
>>
>> Example, say CFS runtime is 0.3s and period is 1s. At 0.7s, 0-laxity
>> timer fires. CFS runs for 0.29s, then sleeps for 0.005s and wakes up
>> at 0.295s (its remaining runtime is 0.01s at this point which is < the
>> "time till deadline" of 0.005s). Now the runtime of the CFS-server
>> will be replenished to the full 3s (due to CBS) and the deadline
>> pushed out. The end result is the total runtime that the CFS-server
>> actually gets is 0.0595s (though yes it did sleep for 5ms in between,
>> still that's tiny -- say if it briefly blocked on a kernel mutex).
> 
> Blah, I got lost in decimal points. Here's the example again:
> 
> Say CFS-server runtime is 0.3s and period is 1s.
> 
> At 0.7s, 0-laxity timer fires. CFS runs for 0.29s, then sleeps for
> 0.005s and wakes up at 0.295s (its remaining runtime is 0.01s at this
> point which is < the "time till deadline" of 0.005s)
> 
> Now the runtime of the CFS-server will be replenished to the full 0.3s
> (due to CBS) and the deadline
> pushed out.
> 
> The end result is, the total runtime that the CFS-server actually gets
> is 0.595s (though yes it did sleep for 5ms in between, still that's
> tiny -- say if it briefly blocked on a kernel mutex). That's almost
> double the allocated runtime.

I think I got what you mean, and I think I took for granted that we were
doing overload control on the replenishment, but it seems that we are not..

I just got back from a doct appt, I will do a proper reply later today.

Thanks Joel!
-- Daniel


> This is just theoretical and I have yet to see if it is actually an
> issue in practice.
> 
> Thanks.

