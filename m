Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6965A7E5980
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjKHOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjKHOw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:52:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E871BDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:52:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05D2C433C8;
        Wed,  8 Nov 2023 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699455146;
        bh=j989FgFLHgGN2FNqciA/2ftNaAdadTtrWC6AukFS7sQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MNBmnWWgjKRjMMVLUhfu/2CPzi5eU9JvZBftXYrLivm5Zax5YKexc6vdxbMZJZGMc
         8cM9jjNBuc7+AueKo/YE2sDf2LXqc832VvKCraIhCOVyfmNqYA/rUYeYSygkFoEZtk
         64vRFNHXvW4k2EH4GWhRN8KnF9UnYvr4UJWgLIstJj1Z1rmPRkkcrCpbS/4MlQ38GE
         dboCQoLPTbGYTVNFsvhEGgMCW3AxzjKvjdjT7pw4GCicjTDVwbRwiGw5wlCnySWYlt
         qAbGt/LYumES9u5hJimwpv/7x+PORnt+s7Sd18xFRWqoQdKUOUDUmTPVtVhhtwkOGP
         Jo7F+E/XR6cuA==
Message-ID: <19cae09c-c169-42da-8011-a8f85936e7b7@kernel.org>
Date:   Wed, 8 Nov 2023 15:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
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
 <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
 <20231108125036.GD4779@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231108125036.GD4779@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 13:50, Peter Zijlstra wrote:
>> ---
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 58b542bf2893..1453a2cd0680 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -829,10 +829,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>>   */
>>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)>>  {

assuming starting rt, 3/10 params:

it arrives here with:

	runtime = 3
	laxity = 10 - 7 = 3
	u = 1

>> +	struct sched_dl_entity *pi_se = pi_of(dl_se);
>>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>>  	struct rq *rq = rq_of_dl_rq(dl_rq);
>> +	u64 dl_runtime = pi_se->dl_runtime;
>>  
>> -	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <= 0);
>> +	WARN_ON_ONCE(dl_runtime <= 0);
>>  
>>  	/*
>>  	 * This could be the case for a !-dl task that is boosted.
>> @@ -851,10 +853,13 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>  	 * arbitrary large.
>>  	 */

skip the while because runtime = 3 > 0

>>  	while (dl_se->runtime <= 0) {
>> -		dl_se->deadline += pi_of(dl_se)->dl_period;
>> -		dl_se->runtime += pi_of(dl_se)->dl_runtime;
>> +		dl_se->deadline += pi_se->dl_period;
>> +		dl_se->runtime += dl_runtime;
>>  	}

runtime is already = dl_runtime...

>> +	if (dl_se->zerolax && dl_se->runtime > dl_runtime)
>> +		dl_se->runtime = dl_runtime;
>> +

There is a way to cap it: it is doing the revised wakeup rule...
the runtime will become 1. That is not what we want...

and we would have to keep arming the server... while shifting the
(internal) period puts the scheduler in the regular case :-)

Externally, e.g., the user with the mouse his laptop, sees the
"zerolax" timeline... :-)

i.e., after at most 7, they get 3, before 10.

it is simpler...

and breaking the U thing is breaking GRUB, admission control.. and so on...
by default - not in a overload DL overload scenario... it is by default :-/.

> This should ofcourse go in the if (dl_se->dl_zerolax_armed) branch a
> little down from here.

