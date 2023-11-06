Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188C37E2A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjKFRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjKFRFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:05:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC7191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:05:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF95FC433C8;
        Mon,  6 Nov 2023 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699290352;
        bh=6Eq+YatJG0VvqdrxwV51hQ2WRfosTf/8anuMEfSdnh8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s23V+aEJl9t9k/evyNTlaMGYiqKJZd9hSQ67QZ9jOLYu0D4p0cRlyqinpBnkHwUua
         xza9rXOqvMUx8mVCbOI7pR14ooVZzp99rU0sVeHeGyFr6IYmMahNtB/kOvZkY5oruL
         76uQH/XTN768/uEb8EoU3v2s1megidfT86BLEvRXBjnBP0taQn0eakIYnmcTXIJZ84
         skSLaIHwePLGGTtOstbJ8mR3T3aaA9PNoTQeBb5BB12yWoHBwwCSG2pwTEb/EIMN0x
         I4RW9raCnLSB8sW0oWzbP/qMPxPBuz1fadQdHyIb9eWq7qegyO2y1Zj28I2MCVnvF8
         jpeDER+GWVgFg==
Message-ID: <57aa0315-0485-4ff7-830b-4dccc4df2eb7@kernel.org>
Date:   Mon, 6 Nov 2023 18:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
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
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <20231106145519.GG3818@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231106145519.GG3818@noisy.programming.kicks-ass.net>
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

On 11/6/23 15:55, Peter Zijlstra wrote:
> On Sat, Nov 04, 2023 at 11:59:23AM +0100, Daniel Bristot de Oliveira wrote:
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b15f7f376a67..399237cd9f59 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1201,6 +1201,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>  		account_group_exec_runtime(curtask, delta_exec);
>>  		if (curtask->server)
>>  			dl_server_update(curtask->server, delta_exec);
>> +		else
>> +			dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);
>>  	}
>>  
>>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>  
> @@ -1195,8 +1196,17 @@ static void update_curr(struct cfs_rq *c
>  	update_deadline(cfs_rq, curr);
>  	update_min_vruntime(cfs_rq);
>  
> -	if (entity_is_task(curr))
> -		update_curr_task(task_of(curr), delta_exec);
> +	if (entity_is_task(curr)) {
> +		struct task_struct *p = task_of(curr);
> +		update_curr_task(p, delta_exec);
> +		/*
> +		 * Any fair task that runs outside of fair_server should
> +		 * account against fair_server such that it can account for
> +		 * this time and possible avoid running this period.
> +		 */
> +		if (p->dl_server != &rq->fair_server)
> +			dl_server_update(&rq->fair_server, delta_exec);
aren't we missing:
		   else
			dl_server_update(&rq_of(cfs_rq)->fair_server, delta_exec);

or am I missing something? :-)

> +	}
>  
>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>  }

