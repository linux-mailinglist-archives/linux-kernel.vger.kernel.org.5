Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B451A80B83B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 01:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjLJAfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 19:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJAfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 19:35:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9BBE7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 16:35:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1704C433C7;
        Sun, 10 Dec 2023 00:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702168512;
        bh=u+cXPj/slh1aFMEJSuOOp1f8U3gz4OU5Qb61R98fQFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO75rSnL2pN+RxPsPFQQcEUYG/FfbjHIWrG72uV21BCtrU5nfycNAOkx7M+DDVUzU
         e4aNBYcs4b/0/8qplP2newjAx+vT6T8nv2BuBy8zWH+korOcWD6WS0fwdXRxF4H+Xw
         ahkv/gQqc1nymrWWu6bHl2KOf2QBTbBcGNprM5lnzmxSyxa/R41dDtmVSuvLkrG04B
         mm6WtQWXBRWAV7lcKtIdXUqOC3j4xrSwqMX1y7ds40OrYZbbNM84OnWIVj/wtD6AY8
         iTXHiNVqWiw8EyX9EgUy6D1YVmSofhHULtMZafQiNFwM4abwCtnwkCORRNd6A/X0qo
         v3ZvwYmjpkW3w==
Date:   Sun, 10 Dec 2023 01:35:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers
 are pending
Message-ID: <ZXUHu6Xqdg8NNcPC@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-13-anna-maria@linutronix.de>
 <20231204160350.OTCnqCJf@linutronix.de>
 <87zfyodfxc.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfyodfxc.fsf@somnus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Dec 05, 2023 at 12:53:03PM +0100, Anna-Maria Behnsen a écrit :
> Sebastian Siewior <bigeasy@linutronix.de> writes:
> >> Use only base->next_expiry value as nextevt when timers are
> >> pending. Otherwise nextevt will be jiffies + NEXT_TIMER_MAX_DELTA. As all
> >> information is in place, update base->next_expiry value of the empty timer
> >> base as well.
> >
> > or consider timers_pending in run_local_timers()? An additional read vs
> > write?
> 
> This would also be a possibility to add the check in run_local_timers()
> with timers_pending.

We could but do we really care about avoiding a potential softirq every 12 days
(on 1000 Hz...)

> And we also have to make the is_idle marking in
> get_next_timer_interrupt() dependant on base::timers_pending bit.

Yes that, on the other hand, looks mandatory! Because if the CPU sleeps for 12
days and then gets an interrupt and then go back to sleep, base->is_idle will be
set as false and remote enqueues won't be notified.

> But this also means, we cannot rely on next_expiry when no timer is pending.

But note that this patch only fixes that partially anyway. Suppose the tick is
stopped entirely and the CPU sleeps for 13 days without any interruption.
Then it's woken up with TIF_RESCHED without any timer queued,
get_next_timer_interrupt() won't be called upon tick restart to fix
->next_expiry.

> 
> Frederic, what do you think?

So it looks like is_idle must be fixed.

As for the timer softirq, ->next_expiry is already unreliable because when
a timer is removed, ->next_expiry is not updated (even though that removed
timer might have been the earliest). So ->next_expiry can already carry a
"too early" value. The only constraint is that ->next_expiry can't be later
than the first timer.

So I'd rather put a comment somewhere about the fact that wrapping is expected
to behave ok. But it's your call.

Thanks.
