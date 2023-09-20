Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1447A8914
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjITP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjITP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:58:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC8C6;
        Wed, 20 Sep 2023 08:57:57 -0700 (PDT)
Date:   Wed, 20 Sep 2023 17:57:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695225475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpJgK3AoeiL0qj/8hSRWzm5J6WB7MCZiwbQ65O5g5hE=;
        b=HoVeYs+Fzkh4C3WRSaDVyKTi7I2akLKNQqMscfyApQI2XrdYmjd8ckESHwBYByCH/J0ejO
        LJcDH5QZl08p3I5rBaO9y4WS6XfaOrBETJzWcWupGyDH3vTse6b9oXJQGBXQ6FSnG7kjz8
        BufhIGn5JvWFFzfLdbdc69Tn1qUAOY5E9UXh9ejZckIH+vp8MbD2PvbrkTEX+LyLZvoDA/
        4vUEP1cP8ldVwfltw4l8ny9Dq7Qxfs9j/8AOFHz0FYbqDA+Tf3YVBTp/nN6zX6+tCrDTXN
        xhEXFXXfOydt4+MsPosxo9KSnwGyfEq6P6RqbtSa2cEAxTHeBcd+1GaAS4yQXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695225475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpJgK3AoeiL0qj/8hSRWzm5J6WB7MCZiwbQ65O5g5hE=;
        b=AgatWMwCIEwvEz7hCBga346W0evtLm84oXwufeiosrpS5dp02LijPUYp/zDPRKriM4tgfd
        xcEa+JV7TLddAyCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230920155754.KzYGXMWh@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-2-bigeasy@linutronix.de>
 <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-23 15:35:41 [+0200], Paolo Abeni wrote:
> On Mon, 2023-08-14 at 11:35 +0200, Sebastian Andrzej Siewior wrote:
> > @@ -4781,7 +4733,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
> >  		 * We can use non atomic operation since we own the queue lock
> >  		 */
> >  		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
> > -			napi_schedule_rps(sd);
> > +			__napi_schedule_irqoff(&sd->backlog);
> >  		goto enqueue;
> >  	}
> >  	reason = SKB_DROP_REASON_CPU_BACKLOG;
> 
> I *think* that the above could be quite dangerous when cpu ==
> smp_processor_id() - that is, with plain veth usage.
> 
> Currently, each packet runs into the rx path just after
> enqueue_to_backlog()/tx completes.
> 
> With this patch there will be a burst effect, where the backlog thread
> will run after a few (several) packets will be enqueued, when the
> process scheduler will decide - note that the current CPU is already
> hosting a running process, the tx thread.
> 
> The above can cause packet drops (due to limited buffering) or very
> high latency (due to long burst), even in non overload situation, quite
> hard to debug.
> 
> I think the above needs to be an opt-in, but I guess that even RT
> deployments doing some packet forwarding will not be happy with this
> on.

I've been looking at this again and have been thinking what you said
here. I think part of the problem is that we lack a policy/ mechanism
when a DoS is happening and what to do.

Before commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its
job"") when a lot of network packets are processed then processing is
moved to ksoftirqd and continues based on how the scheduler schedules
the SCHED_OTHER ksoftirqd task. This avoids lock-ups of the system and
it can do something else in between. Any interrupt will not continue the
outstanding softirq backlog but wait for ksoftirqd. So it basically
avoids the networking overload. It throttles the throughput if needed.

This isn't the case after that commit. Now, the CPU can be stuck with
processing networking packets if the packets come in fast enough. Even
if ksoftirqd is woken up, the next interrupt (say the timer) will
continue with at least one round.
By using NAPI-threads it is possible to give the control back to the
scheduler which can throttle the NAPI processing in favour of other
threads that ask for CPU. As you pointed out, waking the thread does not
guarantee that it will immediately do the NAPI work. It can be delayed
based on current load on the system.

This could be influenced by assigning the NAPI-thread a SCHED_FIFO
priority. Based on the priority it could be ensured that the thread
starts right away or "later" if something else is more important.
However, this opens the DoS window again: The scheduler will put the
NAPI thread on CPU as long as it asks for it with no throttling.

If we could somehow define a DoS condition once we are overwhelmed with
packets, then we could act on it and throttle it. This in turn would
allow a SCHED_FIFO priority without the fear of a lockup if the system
is flooded with packets.

> Cheers,
> 
> Paolo

Sebastian
