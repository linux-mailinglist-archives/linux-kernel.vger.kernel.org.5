Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8D7CA156
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjJPILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJPILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:11:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EDA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:11:43 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697443901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaUOwa3CLw10PPGpYaIq55wKGKjUTopcWrO70oVl0yA=;
        b=oNpc8qFA3q70ADOctDYl/8qDKu72Co7JjAsuCQOBOktvEaTXLrjwY4bM57lTMd1yoq461y
        cbTfaHkXkjRJTZ6i5U+1am/Gq3A8jjonphIKKpTjhMmPv98/+408bzsv6n5j+2nUoA5ZBN
        z+481ujz4zsDJSEEp6I8eUdwwT8x2hqyOQqp4Zuwya0kG36AWQ7Dl2sG+Da3qDKs2LiE12
        eV7kkYzE7jU729J58oMksfH4X+4P/aZIpE0QPY31TO89Xrc1ZFl+ttuXsbEFXrfJbYmDMS
        ApXlJEac8aih3RDrgtKC2Ox9KsbWijJirWHq9jAFWhCcwbFFDeGNdZsERweiVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697443901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uaUOwa3CLw10PPGpYaIq55wKGKjUTopcWrO70oVl0yA=;
        b=UcUATK6Ea2JFFtZI/InefUOuXmlM8gis09vo+JZ8vQ63anIIOQ3e+FBIjfNwoPlzr2PO6u
        r1Gi/xPmqaH53HAQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 05/25] timers: Clarify check in forward_timer_base()
In-Reply-To: <ZR6NVdfsb6+Hujy0@lothringen>
Message-ID: <dcbb9a48-5a71-d616-6614-0c14cdcd9e8f@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de> <20231004123454.15691-6-anna-maria@linutronix.de> <ZR6NVdfsb6+Hujy0@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023, Frederic Weisbecker wrote:

> On Wed, Oct 04, 2023 at 02:34:34PM +0200, Anna-Maria Behnsen wrote:
> > The current check whether a forward of the timer base is required can be
> > simplified by using an already existing comparison function which is easier
> > to read. The related comment is outdated and was not updated when the check
> > changed in commit 36cd28a4cdd0 ("timers: Lower base clock forwarding
> > threshold").
> > 
> > Use time_before_eq() for the check and replace the comment by copying the
> > comment from the same check inside get_next_timer_interrupt().
> > 
> > No functional change.
> > 
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > ---
> >  kernel/time/timer.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index 5e17244a9465..31aed8353db1 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -944,11 +944,10 @@ static inline void forward_timer_base(struct timer_base *base)
> >  	unsigned long jnow = READ_ONCE(jiffies);
> >  
> >  	/*
> > -	 * No need to forward if we are close enough below jiffies.
> > -	 * Also while executing timers, base->clk is 1 offset ahead
> > -	 * of jiffies to avoid endless requeuing to current jiffies.
> > +	 * Check whether we can forward the base. We can only do that when
> > +	 * @basej is past base->clk otherwise we might rewind base->clk.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Also can we keep the precious information in the comment and move it to
> the right place? Such as:
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 63a8ce7177dd..3e70ac818034 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2015,6 +2015,10 @@ static inline void __run_timers(struct timer_base *base)
>  		 */
>  		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
>  			     && base->timers_pending);
> +		/*
> +		 * While executing timers, base->clk is set 1 offset ahead of
> +		 * jiffies to avoid endless requeuing to current jiffies.
> +		 */
>  		base->clk++;
>  		base->next_expiry = __next_timer_interrupt(base);
>  
> 
> Thanks!
> 

Good point! I will do this.

Thanks,

	Anna-Maria

