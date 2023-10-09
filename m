Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA27BEE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378876AbjJIWRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378741AbjJIWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:17:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75699
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:17:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696889829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsSglHohh3swZvjeqZ0qRY1X0hi1DEGfEscLx4fDueI=;
        b=0xjrOSv9NY8Mh7JJUhV48mjA3QBwt+sPP18AOafniYZ8sJXEYh74glnP6+2jyfwBAJTb93
        QNHxIz+ar90z1W+yTY0mHgzTON/Fd1an0HYTTkWZv/ahoVmM0tCW0F4xqgXASWHkHShmWz
        1h/8ap/k9QQDM+ohYrJ+he9M/PKFb3xM7Qnviw0YFHp9O1e1pn0rJhFbuc+2kLU/gM+ZlY
        rg6TyQsLxrUqRZU2fqzzMyH31WNd/LknCriGTnD70HwQ08fAuVRwk5jCqPi8U2JbtENnVz
        Dr/aF+bJ352ljRSBiz1EDXc/xkxkQKY+RJyAuVcdXYyjK+Z4FKg0Ai++YQhbtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696889829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsSglHohh3swZvjeqZ0qRY1X0hi1DEGfEscLx4fDueI=;
        b=TrMhNzu7/DHvFSmtddDFD9aAaHp/lHzmFO1EiXskC+EtdcHw2UvCowd41l16/eex6Tkgdk
        wy8JQY8K4toZMKAQ==
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH v8 09/25] timer: Split out get next timer functionality
In-Reply-To: <20231004123454.15691-10-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-10-anna-maria@linutronix.de>
Date:   Tue, 10 Oct 2023 00:17:09 +0200
Message-ID: <875y3fphju.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04 2023 at 14:34, Anna-Maria Behnsen wrote:
> Split out get next timer functionality to make it reusable in other
> places. Thereby the order of getting the next expiry, forwarding the base
> clock and mark timer bases as idle, is changed. This change of order
> shouldn't have any impact, as nothing inside the function relies on the
> idle value or the updated timer base clock.

This interestingly corrects the issue of patch 8/25 because

> +	nextevt = __get_next_timer_interrupt(basej, base);
>  
>  	/*
>  	 * We have a fresh next event. Check whether we can forward the
> @@ -1952,14 +1968,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  	 */
>  	base->is_idle = time_after(nextevt, basej + 1);

base->is_idle is now handled in the correct order vs. the nextevt evaluation.
  
> -	if (base->timers_pending) {
> -		/* If we missed a tick already, force 0 delta */
> -		if (time_before(nextevt, basej))
> -			nextevt = basej;
> -		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> -	}
>  	raw_spin_unlock(&base->lock);

Thanks,

        tglx
