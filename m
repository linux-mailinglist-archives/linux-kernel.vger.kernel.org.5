Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF07CB6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjJPXDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjJPXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:03:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB309B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:03:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77869C433C7;
        Mon, 16 Oct 2023 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697497427;
        bh=b8xKj753lfZd+cD8vncLLLlX6EQ1e8JPWBiJsHZJ/FU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XiEoN46ehPaHXLfmpPJ1G5yNY90m/L1rUh5e2hPEfQwpGfOIoYRfwcEeaiOKBOOOg
         mWKX7ws+oyW/2ETte+u66L33X/3XrX89FnwfwinYO2xazsqklmYeXoYY4CeVWYA+OS
         /7XCBVP2ZGD2SaX3M3OFBa0KLSSQA5lABW5CGK84D5+N4dzXnTR4YmvyK+dByJvvZw
         EJ7h5VEa9sa16fxj0F4dytsnXxejd2rVy+DrKCBkAstYO9OZEPyrTftkNLPW2n3rqc
         3D43ZBWHQ7pdxoRktFiKx0zHvPpswuFk8Qd1G6xQW+yf949sbn8Gj6bJAv9oeCs5Co
         d9zVOiN82VJdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0EC32CE126C; Mon, 16 Oct 2023 16:03:47 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:03:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Message-ID: <ae4e5836-bc42-42fa-bd41-2a2fd483acb5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r826xys.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:47:55PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 16 2023 at 10:46, John Stultz wrote:
> > On Fri, Oct 13, 2023 at 7:51 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Lockdep found that spin_lock(&watchdog_lock) from call_timer_fn()
> >> is not safe. Use spin_lock_irqsave(&watchdog_lock, flags) instead.
> >>
> >> [    0.378387] TSC synchronization [CPU#0 -> CPU#1]:
> >> [    0.378387] Measured 55060 cycles TSC warp between CPUs, turning off TSC clock.

[ . . . ]

> Something like the uncompiled/untested below should cure it for real. It
> really does not matter whether the TSC unstable event happens a bit
> later. The system is unhappy no matter what.

This does pass my acceptance tests:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> That said, this whole clocksource watchdog mess wants a proper
> overhaul. It has become a pile of warts and duct tape by now and after
> staring at it long enough there is no real reason to run it in a timer
> callback anymore. It just can move into delayed work and the whole
> locking problem can be reduced to the clocksource_mutex and some well
> thought out atomic operations to handle the mark unstable case. But
> that's a different story and not relevant for curing the problem at
> hand.

Moving the code to delayed work seems quite reasonable.

But Thomas, you do understand that the way things have been going for
the clocksource watchdog, pushing it out to delayed work will no doubt
add yet more hair on large busy systems, right?  Yeah, yeah, I know,
delayed work shouldn't be any worse than ksoftirqd.  The key word of
course being "shouldn't".  ;-)

							Thanx, Paul

> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/tsc_sync.c
> +++ b/arch/x86/kernel/tsc_sync.c
> @@ -15,6 +15,7 @@
>   * ( The serial nature of the boot logic and the CPU hotplug lock
>   *   protects against more than 2 CPUs entering this code. )
>   */
> +#include <linux/workqueue.h>
>  #include <linux/topology.h>
>  #include <linux/spinlock.h>
>  #include <linux/kernel.h>
> @@ -342,6 +343,13 @@ static inline unsigned int loop_timeout(
>  	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
>  }
>  
> +static void tsc_sync_mark_tsc_unstable(struct work_struct *work)
> +{
> +	mark_tsc_unstable("check_tsc_sync_source failed");
> +}
> +
> +static DECLARE_WORK(tsc_sync_work, tsc_sync_mark_tsc_unstable);
> +
>  /*
>   * The freshly booted CPU initiates this via an async SMP function call.
>   */
> @@ -395,7 +403,7 @@ static void check_tsc_sync_source(void *
>  			"turning off TSC clock.\n", max_warp);
>  		if (random_warps)
>  			pr_warn("TSC warped randomly between CPUs\n");
> -		mark_tsc_unstable("check_tsc_sync_source failed");
> +		schedule_work(&tsc_sync_work);
>  	}
>  
>  	/*
