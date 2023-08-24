Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050D7874C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbjHXQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242418AbjHXQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:00:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CDF1BDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:00:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qZCkr-0001xr-EP; Thu, 24 Aug 2023 18:00:17 +0200
Message-ID: <52c68762-e09f-339b-0a21-7c461b86788a@pengutronix.de>
Date:   Thu, 24 Aug 2023 18:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tick/rcu: fix false positive "softirq work is pending"
 messages on RT
Content-Language: en-US
To:     paul.gortmaker@windriver.com, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.23 22:07, paul.gortmaker@windriver.com wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
> the new function report_idle_softirq() was created by breaking code out
> of the existing can_stop_idle_tick() for kernels v5.18 and newer.
> 
> In doing so, the code essentially went from a one conditional:
> 
> 	if (a && b && c)
> 		warn();
> 
> to a three conditional:
> 
> 	if (!a)
> 		return;
> 	if (!b)
> 		return;
> 	if (!c)
> 		return;
> 	warn();
> 
> However, it seems one of the conditionals didn't get a "!" removed.
> Compare the instance of local_bh_blocked() in the old code:
> 
> -               if (ratelimit < 10 && !local_bh_blocked() &&
> -                   (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
> -                       pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
> -                               (unsigned int) local_softirq_pending());
> -                       ratelimit++;
> -               }
> 
> ...to the usage in the new (5.18+) code:
> 
> +       /* On RT, softirqs handling may be waiting on some lock */
> +       if (!local_bh_blocked())
> +               return false;
> 
> It seems apparent that the "!" should be removed from the new code.
> 
> This issue lay dormant until another fixup for the same commit was added
> in commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition").
> This commit realized the ratelimit was essentially set to zero instead
> of ten, and hence *no* softirq pending messages would ever be issued.
> 
> Once this commit was backported via linux-stable, both the v6.1 and v6.4
> preempt-rt kernels started printing out 10 instances of this at boot:
> 
>   NOHZ tick-stop error: local softirq work is pending, handler #80!!!
> 
> Just to double check my understanding of things, I confirmed that the
> v5.18-rt did print the pending-80 messages with a cherry pick of the
> ratelimit fix, and then confirmed no pending softirq messages were
> printed with a revert of mainline's 034569 on a v5.18-rt baseline.
> 
> Finally I confirmed it fixed the issue on v6.1-rt and v6.4-rt, and
> also didn't break anything on a defconfig of mainline master of today.
> 
> Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
> Cc: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Thanks,
Ahmad

> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 2b865cb77feb..b52e1861b913 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1050,7 +1050,7 @@ static bool report_idle_softirq(void)
>  		return false;
>  
>  	/* On RT, softirqs handling may be waiting on some lock */
> -	if (!local_bh_blocked())
> +	if (local_bh_blocked())
>  		return false;
>  
>  	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

