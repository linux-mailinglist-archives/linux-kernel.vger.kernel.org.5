Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62FB7BA382
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbjJEP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjJEP4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7C158F7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:57:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8A4C16ABD;
        Thu,  5 Oct 2023 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696501080;
        bh=c11wMeSi6YGSdSS3k/QlnBSkcnWEMqoCHdS2WvriOXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qS9fl7P505rUWJRl8/BhHaZ2S6v4rykk6cClVWFcLS7li/yjxrdWfDzCmsPdebCpv
         NmDUN2VwhqDWbCpv7Ks/SFaG0QXcCopnYiWKkKfnUkFng0xIOd9PKp91ytk1Jlr8Bo
         o76zVc1dpUyVCo76Gk5gmQiKJFsYgVfABCtO2jqHL7+duDF+K/SY97s750x5Rld2/Y
         ih+fTy/c939nYq55596zcXwi1KS1srfKfyVr+Tb6Q7klJd94tv1DYGlGcVKyqbPhUk
         svhx1XYebhWieOHxpwFRAsXs6MhwhRhp8pkzu2f4QrK8n0VHFsS+fCv5fiTB/cPGHs
         YTdoV8ndtmw0A==
Date:   Thu, 5 Oct 2023 12:17:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <ZR6NVdfsb6+Hujy0@lothringen>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-6-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004123454.15691-6-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:34:34PM +0200, Anna-Maria Behnsen wrote:
> The current check whether a forward of the timer base is required can be
> simplified by using an already existing comparison function which is easier
> to read. The related comment is outdated and was not updated when the check
> changed in commit 36cd28a4cdd0 ("timers: Lower base clock forwarding
> threshold").
> 
> Use time_before_eq() for the check and replace the comment by copying the
> comment from the same check inside get_next_timer_interrupt().
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 5e17244a9465..31aed8353db1 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -944,11 +944,10 @@ static inline void forward_timer_base(struct timer_base *base)
>  	unsigned long jnow = READ_ONCE(jiffies);
>  
>  	/*
> -	 * No need to forward if we are close enough below jiffies.
> -	 * Also while executing timers, base->clk is 1 offset ahead
> -	 * of jiffies to avoid endless requeuing to current jiffies.
> +	 * Check whether we can forward the base. We can only do that when
> +	 * @basej is past base->clk otherwise we might rewind base->clk.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Also can we keep the precious information in the comment and move it to
the right place? Such as:

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..3e70ac818034 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2015,6 +2015,10 @@ static inline void __run_timers(struct timer_base *base)
 		 */
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
+		/*
+		 * While executing timers, base->clk is set 1 offset ahead of
+		 * jiffies to avoid endless requeuing to current jiffies.
+		 */
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
 

Thanks!

>  	 */
> -	if ((long)(jnow - base->clk) < 1)
> +	if (time_before_eq(jnow, base->clk))
>  		return;
>  
>  	/*
> -- 
> 2.39.2
> 
