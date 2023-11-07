Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8637E4184
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjKGOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjKGOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:07:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F8C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:06:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37FEC433C7;
        Tue,  7 Nov 2023 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699366017;
        bh=OIiarpj7RW5tn7gRtcWcf5i78tXtE+kGijAzVChJLjo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M08zOID5o814vaGUzrTcZl3BlxLT0juvm9fvzqnDCM11euvCQ24BIt6qqF/ad0lIc
         e6kje1JQ+zfvBEO7O1f1CiubdSY2sOVOg8Mqso2hqZHP8eP+9EoWhW8cY9BunkQAPh
         iC3ryzQ7wVKkx7g+PkEyl1Js1kijTlly76iHMInasQt7dFsNwDTRdYiKUFIJxfAnh4
         yMrhXzyqdnq5ENXRnB8OOfpUKrIjja1Wv9FP0pW2uYH8JZtSHUUUFpQTxmQKC7tLvk
         E4Y6wQ7eJ1pUlx1OiNxN+ekWX34b573/84gEjamoQLuTAMDZ/8tTWee127d+KIuP+z
         9C+e9u6usPBHQ==
Message-ID: <23bab6d8-9256-49d2-b6d2-ac344df925ae@kernel.org>
Date:   Tue, 7 Nov 2023 15:06:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US, pt-BR, it-IT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <20231106154042.GH3818@noisy.programming.kicks-ass.net>
 <9a7222ed-88f8-4a3f-9d83-09b7fb977c27@kernel.org>
 <20231107081602.GP8262@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231107081602.GP8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 09:16, Peter Zijlstra wrote:
> On Mon, Nov 06, 2023 at 05:29:49PM +0100, Daniel Bristot de Oliveira wrote:
>> On 11/6/23 16:40, Peter Zijlstra wrote:
>>> On Sat, Nov 04, 2023 at 11:59:24AM +0100, Daniel Bristot de Oliveira wrote:
>>>> Add an interface for fair server setup on debugfs.
>>>>
>>>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>>>
>>>>  - fair_server_runtime: set runtime in ns
>>>>  - fair_server_period: set period in ns
>>>>  - fair_server_defer: on/off for the defer mechanism
>>>>
>>>
>>> This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to be the
>>> total available bandwidth control, right?
>>
>> right, but thinking aloud... given that the per-cpu files are already allocating the
>> bandwidth on the dl_rq, the spare time for fair scheduler is granted.
>>
>> Still, we can have them there as a safeguard to not overloading the deadline
>> scheduler... (thinking aloud 2) as long as global is a thing... as we get away
>> from it, that global limitation will make less sense - still better to have a form
>> of limitation so people are aware of bandwidth until there.
> 
> Yeah, so having a limit on the deadline thing seems prudent as a way to
> model system overhead. I mean 100% sounds nice, but then all the models
> also assume no interrupts, no scheduler or migration overhead etc.. So
> setting a slightly lower max seems far more realistic to me.
> 
> That said, the period/bandwidth thing is now slightly odd, as we really
> only care about the utilization. But whatever. One thing at a time.

Yep, that is why I am mentioning the generalization as a second phase, it is
a harder problem... But having the rt throttling out of the default way is
already a good step.

> 
>>> But then shouldn've we also rip out the throttle thingy right quick?
>>>
>>
>> I was thinking about moving the entire throttling machinery inside CONFIG_RT_GROUP_SCHED
>> for now, because GROUP_SCHED depends on it, no?
> 
> Yes. Until we can delete all that code we'll have to keep some of that.
> 
>> With the next step on moving the dl server as the base for the
>> hierarchical scheduling...  That will rip out the
>> CONFIG_RT_GROUP_SCHED... with a thing with a per-cpu interface.
>>
>> Does it make sense?
> 
> I'm still not sure how to deal with affinities and deadline servers for
> RT.
> 
> There's a bunch of issues and I thing we've only got some of them solved.
> 
> The semi-partitioned thing (someone was working on that, I think you
> know the guy), solves DL 'entities' having affinities.

Yep, then having arbitrari affinities is another step towards mode flexible models...

> But the problem of FIFO is that they don't have inherent bandwidth. This
> in turn means that any server for FIFO needs to be minimally concurrent,
> otherwise you hand out bandwidth to lower priority tasks that the higher
> priority task might want etc.. (Andersson's group has papers here).
> 
> Specifically, imagine a server with U=1.5 and 3 tasks, a high prio task
> that requires .8 a medium prio task that requires .6 and a low prio task
> that soaks up whatever it can get its little grubby paws on.
> 
> Then with minimal concurreny this works out nicely, high gets .8, mid
> gets .6 and low gets the remaining .1.
> 
> If OTOH you don't limit concurrency and let them all run concurrently,
> you can end up with the situation where they each get .5. Which is
> obviously fail.
> 
> Add affinities here though and you're up a creek, how do you distribute
> utilization between the slices, what slices, etc.. You say given them a
> per-cpu cgroup interface, and have them configure it themselves, but
> that's a god-aweful thing to ask userspace to do.

and yep again... It is definitely a harder topic... but it gets simpler as we do
those other moves...

> Ideally, I'd delete all of FIFO, it's such a horrid trainwreck, a total
> and abysmal failure of a model -- thank you POSIX :-(

-- Daniel
