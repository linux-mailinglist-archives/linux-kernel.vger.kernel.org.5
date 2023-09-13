Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853179F056
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjIMRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjIMRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:22:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 370309B;
        Wed, 13 Sep 2023 10:22:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EF9C1FB;
        Wed, 13 Sep 2023 10:22:58 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B50B3F5A1;
        Wed, 13 Sep 2023 10:22:19 -0700 (PDT)
Message-ID: <45548b21-280e-7f94-0b53-f2dcab6ccb5e@arm.com>
Date:   Wed, 13 Sep 2023 19:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/7] sched/pelt: Add a new function to approximate the
 future util_avg value
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-2-qyousef@layalina.io>
 <8f63efa6-f9d1-9b1c-7737-4094f6acfc62@arm.com>
 <20230906211936.yqejc25czc6tddm6@airbuntu>
 <47a11e4e-d349-7d98-7006-4bf08a53c0cf@arm.com>
 <20230910195832.pncjsqmkepichly6@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230910195832.pncjsqmkepichly6@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2023 21:58, Qais Yousef wrote:
> On 09/07/23 13:12, Dietmar Eggemann wrote:
>> On 06/09/2023 23:19, Qais Yousef wrote:
>>> On 09/06/23 14:56, Dietmar Eggemann wrote:
>>>> On 28/08/2023 01:31, Qais Yousef wrote:

[...]

>> Another thing ... I guess if you call accumulate_sum with delta the PELT
>> machinery assumes `delta = now - sa->last_update_time` which means you
>> would have to use `clock_pelt + TICK_USEC` as delta.
> 
> Right.
> 
> The way I understood it is that at TICK we should do update_load_avg() which
> would call __update_load_sum() which uses
> 
> 	delta = now - sa->last_update_time
> 
> which passes this delta to accumulate_sum()
> 
> I can see we are not very accurate since there will be a small additional time
> besides TICK_USEC that we are not accounting for. But I can't see how this can
> cause a big error.
> 
> 	predicted (assumed) tick time/delta
> 
> 		sa->last_update_time = now
> 		tick_time = TICK_USEC + now
> 
> 		delta = tick_time - sa->last_update_time
> 		delta = TICK_USEC + now - now
> 		delta = TICK_USEC
> 
> 	but actual tick time/delta
> 
> 		sa->last_update_time = now - x
> 		tick_time = TICK_USEC + now
> 
> 		delta = tick_time - sa->last_update_time
> 		delta = TICK_USEC + now - (now - x)
> 		delta = TICK_USEC + x
> 
> So the delta I am using might be slightly shorter than it should be.
> 
> IIUC, what you're saying that the `x` in my equation above is clock_pelt,
> right?

No, I was wrong here. Calling accumulate_sum with `delta = TICK_USEC` is
fine.

accumulate_sum() will accrue `sa->util.sum` and ___update_load_avg()
will then adjust `sa->util_avg` accordingly.

delta should be 4000 on Arm64 boards so you will cross period
boundaries. In case `delta < 1024` you might want to not call
___update_load_avg() to be in pair with __update_load_avg_cfs_rq().














