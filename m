Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78B87A26C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjIOTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjIOS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:59:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80AD98
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:59:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694804385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EepSFHCMYZW3HHl5l7+iK7+nAfFDmswP137z9WEz90s=;
        b=S9/HzAQOidxN9pRaf1uOk5lpHKA57YPJxEk2hnHGPah/eiRocG6JLckSuzD8XliL6zEoEU
        MvJ0AvUe+uZfBX3LBhq7WXy+KXUTH77Bmn28AWj8cviMstEJJFIM2mRf8uy+sC9+5VJMrm
        fKYPNCCYfmZewuz41h6qk0H5OfrWz7zXwUocuV2hweG/TQacspWMJw6SEJs64yj52kEA+8
        LJByV20lRCPgc+IY/2yugCDYS1sZOqwT0UVyFBsSlqoL4tdJgkJ2I5iSdksVkmegXjj3GT
        xWVifckA/oGn7mb0NnBNuDp9DEJKDGU+R2Ua+8bx8cmIhaYBRMLFLNGq7/tmvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694804385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EepSFHCMYZW3HHl5l7+iK7+nAfFDmswP137z9WEz90s=;
        b=JHNRSkDmPjMUVSBdvACZnUJYDTMoCwqcNb+u6exVB1QeiNywewrKaoS0AEeNUiQMt872gI
        v1/NrhgIheFMGXBw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
In-Reply-To: <20230915151943.GD6743@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
Date:   Fri, 15 Sep 2023 20:59:44 +0200
Message-ID: <877cor1cv3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15 2023 at 17:19, Peter Zijlstra wrote:
> On Fri, Sep 15, 2023 at 02:58:35PM +0200, Thomas Gleixner wrote:
> *However* the case at hand is where a waiter is leaving, in this case the race
> means a waiter that is going away is not observed -- which is harmless,
> provided this race is explicitly handled.
>
> This is a somewhat dangerous proposition because the converse race is not
> observing a new waiter, which must absolutely not happen. But since the race is
> valid this cannot be asserted.

Correct. But adding a new waiter requires to hold hb::lock which _IS_
held by the unlocking code when it deals with the outgoing race.

So I'm not too worried about it. 

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>  	/*
>  	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
> -	 * first acquire the hb->lock before removing the lock from the
> -	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
> -	 * lists consistent.
> +	 * must unwind the above, however we canont lock hb->lock because
> +	 * rt_mutex already has a waiter enqueued and hb->lock can itself try
> +	 * and enqueue an rt_waiter through rtlock.
> +	 *
> +	 * Doing the cleanup without holding hb->lock can cause inconsistent
> +	 * state between hb and pi_state, but only in the direction of not
> +	 * seeing a waiter that is leaving.
> +	 *
> +	 * See futex_unlock_pi(), it deals with this inconsistency.
> +	 *
> +	 * There be dragons here, since we must deal with the inconsistency on
> +	 * the way out (here), it is impossible to detect/warn about the race
> +	 * the other way around (missing an incoming waiter).
>  	 *
> -	 * In particular; it is important that futex_unlock_pi() can not
> -	 * observe this inconsistency.
> +	 * What could possibly go wrong...

If some code in the future tries to enqueue a waiter w/o holding
hb::lock then this corner case will be the least of our worries. There
are tons of other things which will insta go south.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
