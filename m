Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0371A79741F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbjIGPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbjIGPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:33:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75D7E47;
        Thu,  7 Sep 2023 08:32:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30655152B;
        Thu,  7 Sep 2023 06:06:19 -0700 (PDT)
Received: from [10.57.92.126] (unknown [10.57.92.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB333F7B4;
        Thu,  7 Sep 2023 06:05:39 -0700 (PDT)
Message-ID: <89067f71-9b83-e647-053e-07f7d55b6529@arm.com>
Date:   Thu, 7 Sep 2023 14:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qyousef@layalina.io>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
 <20230907115307.GD10955@noisy.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230907115307.GD10955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 12:53, Peter Zijlstra wrote:
> On Thu, Sep 07, 2023 at 08:48:08AM +0100, Lukasz Luba wrote:
> 
>>> Hehe. That's because they're not really periodic ;-)
>>
>> They are periodic in a sense, they wake up every 16ms, but sometimes
>> they have more work. It depends what is currently going in the game
>> and/or sometimes the data locality (might not be in cache).
>>
>> Although, that's for games, other workloads like youtube play or this
>> one 'Yahoo browser' (from your example) are more 'predictable' (after
>> the start up period). And I really like the potential energy saving
>> there :)
> 
> So everything media is fundamentally periodic, you're hard tied to the
> framerate / audio-buffer size etc..

Agree

> 
> Also note that the traditional periodic task model from the real-time
> community has the notion of WCET, which completely covers this
> fluctuation in frame-to-frame work, it only considers the absolute worst
> case.

That's good point, the WCET here. IMO shorter PELT e.g. 8ms allows us
to 'see' a bit more that information: the worst case in fluctuation of
a particular task. Then this 'seen' value is maintained in util_est
for a while. That's why (probably) I see a better 95-, 99-percentile
numbers for frames rendering time.

> 
> Now, practically, that stinks, esp. when you care about batteries, but
> it does not mean these tasks are not periodic.

Totally agree they are periodic.

> 
> Many extentions to the periodic task model are possible, including
> things like average runtime with bursts etc.. all have their trade-offs.

Was that maybe proposed somewhere on LKML (the other models)?

I can recall one idea - WALT.
IIRC ~2016/2017 the WALT proposal and some discussion/conferences, it
didn't get positive feedback [2].

I don't know if you remember those numbers back than, e.g. video 1080p
playback was using ~10% less energy... Those 10%-15% are still important
for us ;)

Regards,
Lukasz

[1] 
https://lore.kernel.org/all/1477638642-17428-1-git-send-email-markivx@codeaurora.org/
