Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A107989FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbjIHP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjIHP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:28:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E9D1FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:28:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BE2C433C9;
        Fri,  8 Sep 2023 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694186933;
        bh=vRlB/5Xg5ni0NcsQvZ9t0ajGq3sYV4nl6LLKbzOc54Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lGNFkraB9RbVvVxdY6qPwqMNdBun0W5IbI/PG4d/mZlcEQ7B0lN/d9HTtJJ6nt4Xg
         mmyqfQwYJexFEEjwyBS2GnsDC/a10zbgSEbsOpZqyJCDr7tczfMJloD7593hwi7ydu
         lhWnjoH4tSo3XIpWqqEjGz6Rn+bQpINvv66XsUDbw/IllI8aLjRYx0r4/mMW8JI2NF
         k5V6+szHOoMZHTQA7G/YmyjjT96Ow2SHKPzvPcGv8Kq5VpCd9x42/1g6+XNBGiVRzk
         TGs+wv7ZuZdKnkgtslHZh3KCDilFXE+pfPmHldwy1O8+7lQh9v9X9TLu1zfaMGmRfE
         jvuLSlqPidypA==
Message-ID: <658f807e-7f7a-e6d2-25e7-00eb2187af2a@kernel.org>
Date:   Fri, 8 Sep 2023 17:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
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
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
 <20230906082952.GB38741@noisy.programming.kicks-ass.net>
 <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
 <20230907080729.GA16872@noisy.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230907080729.GA16872@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 10:07, Peter Zijlstra wrote:
> On Wed, Sep 06, 2023 at 04:58:11PM +0200, Daniel Bristot de Oliveira wrote:
> 
>>> Yeah, it's a wee hack to move it to the zero-laxity point. I was
>>> considering if it makes sense to push that down and make it available
>>> for all DL tasks, but I'm not sure..
>>
>> It might be useful in the future, like when DL dominates all other schedulers, so
>> we can have a way to schedule a deferred work, like kworkers... :-) But it might be
>> too early for that..
> 
> So... that scheme I was pushing where we unconditionally decrement
> fair_server.dl_runtime from update_curr_fair(), that relies on it being
> a proper zero-laxity scheduler, and doesn't work with the proposed defer
> hack.
> 
> That is, it relies on dl_runtime > 0 during throttle, and you explicitly
> set it 0.
> 
> Now, I've not looked at all this code in detail in a minute, but would
> not something like the below work?
> 
> AFAICT the regular dl_task_timer() callback works to make it go, because
> replenish will see positive runtime (or not, when already consumed) and
> DTRT.
> 
> 
> Index: linux-2.6/include/linux/sched.h
> ===================================================================
> --- linux-2.6.orig/include/linux/sched.h
> +++ linux-2.6/include/linux/sched.h
> @@ -657,6 +657,7 @@ struct sched_dl_entity {
>  	unsigned int			dl_non_contending : 1;
>  	unsigned int			dl_overrun	  : 1;
>  	unsigned int			dl_server         : 1;
> +	unsigned int			dl_zerolax        : 1;
>  
>  	/*
>  	 * Bandwidth enforcement timer. Each -deadline task has its
> Index: linux-2.6/kernel/sched/deadline.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/deadline.c
> +++ linux-2.6/kernel/sched/deadline.c
> @@ -895,6 +895,16 @@ static void replenish_dl_entity(struct s
>  		dl_se->dl_yielded = 0;
>  	if (dl_se->dl_throttled)
>  		dl_se->dl_throttled = 0;
> +
> +	/*
> +	 * If this is a zero-laxity task, and we're before the zero-laxity
> +	 * point, throttle it.
> +	 */
> +	if (dl_se->dl_zerolax &&
> +	    dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq))) {
> +		if (!is_dl_boosted(dl_se) && start_dl_timer(dl_se))
> +			dl_se->dl_throttled = 1;
> +	}
>  }
>  
>  /*
> @@ -1078,7 +1088,12 @@ static int start_dl_timer(struct sched_d
>  	 * that it is actually coming from rq->clock and not from
>  	 * hrtimer's time base reading.
>  	 */
> -	act = ns_to_ktime(dl_next_period(dl_se));
> +	if (dl_se->dl_zerolax && !dl_se->dl_throttled) {
> +		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
> +	} else {
> +		act = ns_to_ktime(dl_next_period(dl_se));
> +	}
> +
>  	now = hrtimer_cb_get_time(timer);
>  	delta = ktime_to_ns(now) - rq_clock(rq);
>  	act = ktime_add_ns(act, delta);
> @@ -1794,6 +1809,13 @@ enqueue_dl_entity(struct sched_dl_entity
>  		setup_new_dl_entity(dl_se);
>  	}
>  
> +	/*
> +	 * If we are still throttled, eg. we got replenished but are a
> +	 * zero-laxity task and still got to wait, don't enqueue.
> +	 */
> +	if (dl_se->dl_throttled)
> +		return;
> +
>  	__enqueue_dl_entity(dl_se);
>  }

Let me see if I got it:

	- Always start the server, but throttled with full runtime...
	- Unconditionally decrement fair_server.dl_runtime from update_curr_fair()
		(check if it is not decremented twice as it runs)
	- When the dl timer fire, replenish or throttle for the next period?

is that the base for it?

-- Daniel
