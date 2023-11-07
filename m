Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0F7E35F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKGHaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKGHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:30:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C769C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:30:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865C7C433C8;
        Tue,  7 Nov 2023 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699342214;
        bh=hjDvQUTop7NyWWazze5QWPyGZ/OWLEbXaDZXlgkkNdY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N5mzIYyZOc+WPvX85IxkaF9m7qcVR72y35MHUSncA30GalSk7MTBvhIky1XWQocVw
         XauT/FillqV9pGTiFZwObACoz6b3ChQ7AoPHwqAiVvbM3TDCSepnMjr4OS1NMcnU4j
         s7seXE+A0UALKHRds7F+LmAE+DscIgs8yqFNSdVM5b4/L1TcVssr1/RaH+3m8jkPN2
         b89bxTRB659gwqT64c36BZdaJEQ7fQDL8glcSkGctJ7+bxqBi75odnrvo5NSJDR6V4
         Ar/8T0rkNuMhkFne59BixrHq4OSJEml8sd/eEtShlmsmnNIcURUtEoNxZCBbhqDgwg
         Da8SSYHkft7fw==
Message-ID: <2359b646-a4a7-460a-b240-4becfc0551d4@kernel.org>
Date:   Tue, 7 Nov 2023 08:30:08 +0100
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
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
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

On 11/6/23 20:32, Joel Fernandes wrote:
> Hi Daniel,
> 
> On Sat, Nov 4, 2023 at 6:59 AM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
>>
>> Among the motivations for the DL servers is the real-time throttling
>> mechanism. This mechanism works by throttling the rt_rq after
>> running for a long period without leaving space for fair tasks.
>>
>> The base dl server avoids this problem by boosting fair tasks instead
>> of throttling the rt_rq. The point is that it boosts without waiting
>> for potential starvation, causing some non-intuitive cases.
>>
>> For example, an IRQ dispatches two tasks on an idle system, a fair
>> and an RT. The DL server will be activated, running the fair task
>> before the RT one. This problem can be avoided by deferring the
>> dl server activation.
>>
>> By setting the zerolax option, the dl_server will dispatch an
>> SCHED_DEADLINE reservation with replenished runtime, but throttled.
>>
>> The dl_timer will be set for (period - runtime) ns from start time.
>> Thus boosting the fair rq on its 0-laxity time with respect to
>> rt_rq.
>>
>> If the fair scheduler has the opportunity to run while waiting
>> for zerolax time, the dl server runtime will be consumed. If
>> the runtime is completely consumed before the zerolax time, the
>> server will be replenished while still in a throttled state. Then,
>> the dl_timer will be reset to the new zerolax time
>>
>> If the fair server reaches the zerolax time without consuming
>> its runtime, the server will be boosted, following CBS rules
>> (thus without breaking SCHED_DEADLINE).
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>  include/linux/sched.h   |   2 +
>>  kernel/sched/deadline.c | 100 +++++++++++++++++++++++++++++++++++++++-
>>  kernel/sched/fair.c     |   3 ++
>>  3 files changed, 103 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 5ac1f252e136..56e53e6fd5a0 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -660,6 +660,8 @@ struct sched_dl_entity {
>>         unsigned int                    dl_non_contending : 1;
>>         unsigned int                    dl_overrun        : 1;
>>         unsigned int                    dl_server         : 1;
>> +       unsigned int                    dl_zerolax        : 1;
>> +       unsigned int                    dl_zerolax_armed  : 1;
>>
>>         /*
>>          * Bandwidth enforcement timer. Each -deadline task has its
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 1d7b96ca9011..69ee1fbd60e4 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -772,6 +772,14 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
>>         /* for non-boosted task, pi_of(dl_se) == dl_se */
>>         dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
>>         dl_se->runtime = pi_of(dl_se)->dl_runtime;
>> +
>> +       /*
>> +        * If it is a zerolax reservation, throttle it.
>> +        */
>> +       if (dl_se->dl_zerolax) {
>> +               dl_se->dl_throttled = 1;
>> +               dl_se->dl_zerolax_armed = 1;
>> +       }
>>  }
>>
>>  /*
>> @@ -828,6 +836,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>>   * could happen are, typically, a entity voluntarily trying to overcome its
>>   * runtime, or it just underestimated it during sched_setattr().
>>   */
>> +static int start_dl_timer(struct sched_dl_entity *dl_se);
>>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>  {
>>         struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>> @@ -874,6 +883,28 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>                 dl_se->dl_yielded = 0;
>>         if (dl_se->dl_throttled)
>>                 dl_se->dl_throttled = 0;
>> +
>> +       /*
>> +        * If this is the replenishment of a zerolax reservation,
>> +        * clear the flag and return.
>> +        */
>> +       if (dl_se->dl_zerolax_armed) {
>> +               dl_se->dl_zerolax_armed = 0;
>> +               return;
>> +       }
>> +
>> +       /*
>> +        * A this point, if the zerolax server is not armed, and the deadline
>> +        * is in the future, throttle the server and arm the zerolax timer.
>> +        */
>> +       if (dl_se->dl_zerolax &&
>> +           dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq))) {
>> +               if (!is_dl_boosted(dl_se)) {
>> +                       dl_se->dl_zerolax_armed = 1;
>> +                       dl_se->dl_throttled = 1;
>> +                       start_dl_timer(dl_se);
>> +               }
>> +       }
>>  }
>>
>>  /*
>> @@ -1024,6 +1055,13 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
>>                 }
>>
>>                 replenish_dl_new_period(dl_se, rq);
>> +       } else if (dl_server(dl_se) && dl_se->dl_zerolax) {
>> +               /*
>> +                * The server can still use its previous deadline, so throttle
>> +                * and arm the zero-laxity timer.
>> +                */
>> +               dl_se->dl_zerolax_armed = 1;
>> +               dl_se->dl_throttled = 1;
>>         }
>>  }
>>
>> @@ -1056,8 +1094,20 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
>>          * We want the timer to fire at the deadline, but considering
>>          * that it is actually coming from rq->clock and not from
>>          * hrtimer's time base reading.
>> +        *
>> +        * The zerolax reservation will have its timer set to the
>> +        * deadline - runtime. At that point, the CBS rule will decide
>> +        * if the current deadline can be used, or if a replenishment
>> +        * is required to avoid add too much pressure on the system
>> +        * (current u > U).
>>          */
>> -       act = ns_to_ktime(dl_next_period(dl_se));
>> +       if (dl_se->dl_zerolax_armed) {
>> +               WARN_ON_ONCE(!dl_se->dl_throttled);
>> +               act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
> 
> Just a question, here if dl_se->deadline - dl_se->runtime is large,
> then does that mean that server activation will be much more into the
> future? So say I want to give CFS 30%, then it will take 70% of the
> period before CFS preempts RT thus "starving" CFS for this duration. I
> think that's Ok for smaller periods and runtimes, though.

I think you are answering yourself here :-)

If the default values are not good, change them o/

The current interface allows you to have more responsive/small chuck of CPU
or less responsive/large chucks of CPU... you can even place RT bellow CFS
for a "bounded amount of time" by disabling the defer option... per CPU.
All at once with different periods patterns on CPUs to increase the
changes of having a cfs rq ready on another CPU... like...

[3/10 - 2/6 - 1.5/5 - 1/3 no defer] in a 4 cpus system :-).

The default setup is based on the throttling to avoid changing
the historical behavior for those that... are happy with them.

-- Daniel
>  - Joel

