Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F07E26C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjKFO1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjKFO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:27:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3898184
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:26:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AB9C433CA;
        Mon,  6 Nov 2023 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699280818;
        bh=mA1LhY1QNKSMIHIzpniKfSDIhyBdqrkTOBTwMlQ+F60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GGvtBe/mJPzBZrsXtD13r/LBh+W/LNiJ6X99xlvAp0Y9hViaKyz2zMNZbyly7nEyG
         Ok3vr5aXW8KlwCU/N9pLps4MFR5omiQOfIunngHS40fjI5tgtwhr2TnUWTyu5z4alr
         G3l0sfbw0BBil7jB1/6pKlCIPdEnEvOe8+09Na9+FyT2xwzwkyRxMl27M4J6iWuh6C
         nx6NlCljt/eOgFwZQ+ktQJXxm38rUopywGAI4xquO+zYLVql1+nL8XShKF5xo8MZzu
         eqX1t128vHZ1Yj3k5p+tzsjY78DIMgnCB4o3KDar4pk6K9g69IXcUP5dzvxby5Yajm
         fyzCLlPjI+fnQ==
Message-ID: <59203a63-f759-431c-a035-d3cbc433dcfb@kernel.org>
Date:   Mon, 6 Nov 2023 15:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] sched/fair: Add trivial fair server
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <4e0d14eb6e0ec33055197ac7ddb57ef7ab3894a5.1699095159.git.bristot@kernel.org>
 <20231106142430.GF3818@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231106142430.GF3818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 15:24, Peter Zijlstra wrote:
> On Sat, Nov 04, 2023 at 11:59:22AM +0100, Daniel Bristot de Oliveira wrote:
> 
>> [ dl_server do not account for rt ]
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 541d547e1019..1d7b96ca9011 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -1382,6 +1382,13 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>>  			resched_curr(rq);
>>  	}
>>  
>> +	/*
>> +	 * The fair server (sole dl_server) does not account for real-time
>> +	 * workload because it is running fair work.
>> +	 */
>> +	if (dl_server(dl_se))
>> +		return;
>> +
>>  	/*
>>  	 * Because -- for now -- we share the rt bandwidth, we need to
>>  	 * account our runtime there too, otherwise actual rt tasks
> Should we perhaps write this like so?
> 
> 	if (dl_se == &rq->fair_server)
> 		return;

right, it is better for the next step (making it generic).

-- Daniel
