Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589997BEE28
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbjJIWPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJIWPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:15:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA39D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:15:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696889709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8duCKySqvMrtmJX+zRzsuIJlhWASsuF/Gb96xrFA4to=;
        b=BJDdTtm0XvK8HMtDOQBirllFeqYTuJ/mLu9Pd4tMdl0rmkF0iUfAild4rNg+oB7y7vgqMG
        SEfrxswfWPAucV+/BgExsOKINR5HiLWs/fK+4SCDTnxxCEl7KCE7dcLoqHesx2tgQYX8pO
        MSCX3XAYQTaPcDRBwuAIoP5pz4Utoa4sgUIpMMHYmv8WB7ZDHU1Jg8qGIi9DcZUFHaHQ8S
        oeEN/ellgRAcqoIvozamwgJtSj0kozEH8XhI5uSCUrNZ8FzLSYXCr4TnZSSXN1bz8/Ls6k
        sVizO4P3Ldtwzb8iYDasbAnQafT6E4aB+96ghAxHJRvyfuofSuz8ld/T61w55A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696889709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8duCKySqvMrtmJX+zRzsuIJlhWASsuF/Gb96xrFA4to=;
        b=6zi6ThfIjwAcJrEvMgtuHsF4+mB3jNC0kIIAscu885Q9k4heCKY1Fr8Iv5TON7jaDZYnxM
        EWdX1wcUj7YLjqBA==
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
Subject: Re: [PATCH v8 08/25] timer: Rework idle logic
In-Reply-To: <20231004123454.15691-9-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-9-anna-maria@linutronix.de>
Date:   Tue, 10 Oct 2023 00:15:09 +0200
Message-ID: <878r8bphn6.ffs@tglx>
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

On Wed, Oct 04 2023 at 14:34, Anna-Maria Behnsen wrote:
>  
> -	if (time_before_eq(nextevt, basej)) {
> -		expires = basem;
> -		base->is_idle = false;
> -	} else {
> -		if (base->timers_pending)
> -			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> -		/*
> -		 * If we expect to sleep more than a tick, mark the base idle.
> -		 * Also the tick is stopped so any added timer must forward
> -		 * the base clk itself to keep granularity small. This idle
> -		 * logic is only maintained for the BASE_STD base, deferrable
> -		 * timers may still see large granularity skew (by design).
> -		 */
> -		if ((expires - basem) > TICK_NSEC)
> -			base->is_idle = true;
> +	/*
> +	 * Base is idle if the next event is more than a tick away. Also
> +	 * the tick is stopped so any added timer must forward the base clk
> +	 * itself to keep granularity small. This idle logic is only
> +	 * maintained for the BASE_STD base, deferrable timers may still
> +	 * see large granularity skew (by design).
> +	 */
> +	base->is_idle = time_after(nextevt, basej + 1);

This is wrongly ordered. base->is_idle must be updated _after_
evaluating base->timers_pending because the below can change nextevt,
no?

> +	if (base->timers_pending) {
> +		/* If we missed a tick already, force 0 delta */
> +		if (time_before(nextevt, basej))
> +			nextevt = basej;
> +		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;

Thanks,

        tglx
