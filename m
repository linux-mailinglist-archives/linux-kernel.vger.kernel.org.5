Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D07805389
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442238AbjLELxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjLELxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:53:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A019F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:53:06 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701777184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpwcUJUhNeWtCBatU+tgVe3nUzZLjauuSSOu3dLjEkA=;
        b=Clk6PjABvXj315VoDPdWp+X8kS8Vgi/wb/l2AXTJ/biubHBku41B5ymIs1P63xnqfBW89i
        0b3nty/Q/+NgNYtb31V1VswMf0Qc2o+beXuExtVn+N0bAuzyarwlxQNtpHcVTWsemK1OAv
        QUEiwQ5RnRvZiVJpU5IbM1kt7gMNjM+5iTFM07Cs+GhEmAfXeAd+lH5tUdElhNruZZUGNL
        dm9XXOLPRaePTtR/rRwYbJ3/immp+a2eVgHLdnQHw8AVrqexiPA4xLo6TFaoAYy7jsSJVE
        RozZr0xhVE305O0s8Wcwh9RNHwMnODYcxstHuawQCray7JPc9HSXaR3laj/PFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701777184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpwcUJUhNeWtCBatU+tgVe3nUzZLjauuSSOu3dLjEkA=;
        b=9eczm+iq/+AkqOdt7s9W4AhgqeLrK11YpF1SQRZYE6Wxo8qmHydhLRjKYBEboT/D3y5hNu
        Bz/UME4rngd483AQ==
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers
 are pending
In-Reply-To: <20231204160350.OTCnqCJf@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-13-anna-maria@linutronix.de>
 <20231204160350.OTCnqCJf@linutronix.de>
Date:   Tue, 05 Dec 2023 12:53:03 +0100
Message-ID: <87zfyodfxc.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:34 [+0100], Anna-Maria Behnsen wrote:
>> When no timer is queued into an empty timer base, the next_expiry will not
>> be updated. It was originally calculated as
>> 
>>   base->clk + NEXT_TIMER_MAX_DELTA
>> 
>> When the timer base stays empty long enough (> NEXT_TIMER_MAX_DELTA), the
>> next_expiry value of the empty base suggests that there is a timer pending
>> soon. This might be more a kind of a theoretical problem, but the fix
>> doesn't hurt.
>
> So __run_timers() sets base::next_expiry to base->clk +
> NEXT_TIMER_MAX_DELTA and then we have no more timers enqueued.
>
> But wouldn't base->timers_pending remain false? Therefore it would use
> "expires = KTIME_MAX" as return value (well cmp_next_hrtimer_event())?

Jupp.

> Based on the code as of #11, it would only set timer_base::is_idle
> wrongly false if it wraps around. Other than that, I don't see an issue.
> What do I miss?

And it will raise an unnecessary softirq when it wraps around as you
also mentioned on the next paragraph.

> If you update it regardless here then it would make a difference to
> run_local_timers() assuming we have still hrtimer which expire and this
> next_expiry check might raise a softirq since it does not consider the
> timers_pending value.

The only difference with this change would be that the softirq will not
be raised when it wraps around.

>> Use only base->next_expiry value as nextevt when timers are
>> pending. Otherwise nextevt will be jiffies + NEXT_TIMER_MAX_DELTA. As all
>> information is in place, update base->next_expiry value of the empty timer
>> base as well.
>
> or consider timers_pending in run_local_timers()? An additional read vs
> write?

This would also be a possibility to add the check in run_local_timers()
with timers_pending. And we also have to make the is_idle marking in
get_next_timer_interrupt() dependant on base::timers_pending bit. But
this also means, we cannot rely on next_expiry when no timer is pending.

Frederic, what do you think?

Thanks,

	Anna-Maria

