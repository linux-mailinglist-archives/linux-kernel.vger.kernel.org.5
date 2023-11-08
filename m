Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B910A7E5191
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjKHIBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjKHIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:01:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570E171C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:01:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CABC433C7;
        Wed,  8 Nov 2023 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699430485;
        bh=2Ar5lwZ3jRVtbJoyQHH2BdyH1s8Wjtev0WxE6Qz6fPs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N0Stv+RZZDpfRwJciq2L6ecGlaWd5NDrxceUAHJd9//HLZ1wudPbnMP1lGlNeLW2A
         EHLFQvOMnNpzAIY10AOQvDbH/O7v1tRKcJipkvzch8V1sq0ge4Orb7yPaNgmAU9NU/
         rMAvC+ZSpnZo7Dd/b/ynAeQmiI6v6P4AL7NGaBl15VB4lxN4kCb0e0m9Uumr5ZlDbS
         CrbVGR/0XXBiINztr9fJ7NNUmH0qWuFplEPI8yiUSDE8ijHq63z52KUMCTc4dWZWYI
         Xg2s/4LFy4PrDP3ZePIBX6tpdp6Ndn6kxmfj2ef7evnmz8kWAVggoD5IJJPmNCJTVI
         N3zCp7gRIiPdQ==
Message-ID: <cc7d1140-1190-4f04-b6e6-9754aba96218@kernel.org>
Date:   Wed, 8 Nov 2023 09:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
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
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <CAEXW_YT-d4uNr4eyfXeCdUCmYu8LgYtMXTQVN=RXkjmxPz9d0g@mail.gmail.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAEXW_YT-d4uNr4eyfXeCdUCmYu8LgYtMXTQVN=RXkjmxPz9d0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 04:20, Joel Fernandes wrote:
> Hi Daniel,
> 
> On Tue, Nov 7, 2023 at 1:50 PM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
>>
>>> The code is not doing what I intended because I thought it was doing overload
>>> control on the replenishment, but it is not (my bad).
>>>
>>
>> I am still testing but... it is missing something like this (famous last words).
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 1092ca8892e0..6e2d21c47a04 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -842,6 +842,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>>   * runtime, or it just underestimated it during sched_setattr().
>>   */
>>  static int start_dl_timer(struct sched_dl_entity *dl_se);
>> +static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
>> +
>>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>  {
>>         struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>> @@ -852,9 +854,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>         /*
>>          * This could be the case for a !-dl task that is boosted.
>>          * Just go with full inherited parameters.
>> +        *
>> +        * Or, it could be the case of a zerolax reservation that
>> +        * was not able to consume its runtime in background and
>> +        * reached this point with current u > U.
>> +        *
>> +        * In both cases, set a new period.
>>          */
>> -       if (dl_se->dl_deadline == 0)
>> -               replenish_dl_new_period(dl_se, rq);
>> +       if (dl_se->dl_deadline == 0 ||
>> +               (dl_se->dl_zerolax_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
>> +                       dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
>> +                       dl_se->runtime = pi_of(dl_se)->dl_runtime;
>> +       }
>>
>>         if (dl_se->dl_yielded && dl_se->runtime > 0)
>>                 dl_se->runtime = 0;
> 
> I was wondering does this mean GRUB needs to be enabled? Otherwise I
> can see that "runtime / (deadline - t) > dl_runtime / dl_deadline"
> will be true almost all the time due to the constraint of executing at
> the 0-lax time.

No grub needed. It will only happen if the fair server did not have any chance to run.

If it happens, it is not a problem, see that timeline I replied in the previous
email.

We do not want a zerolax scheduler, because it breaks everything else. It is
a deferred EDF, that looking from wall clock, composes an "zerolaxish" timeline.

> Because at the 0-lax time, AFAICS this will be 100% > 30% (say if CFS
> has a 30% reservation).
> 
> And I think even if GRUB is enabled, it is possible other DL task may
> have reserved bandwidth.
> 
> Or is there a subtlety that makes that not possible?
> 
> thanks,
> 
>  - Joel

