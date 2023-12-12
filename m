Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D580EAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjLLLnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:43:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DBC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:43:30 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702381408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0f0NLMhcX0Ji4stoXsgRQnnGmOpz8MKcblkO1WoOzEo=;
        b=40MlXI/D3H2TaKzrjasYs/fhgZ3KMPOMwzCR866j9UG2+uVEvSEUFAsPdC14wk+r2277pa
        r5jMitaudCevQK3D6Xy+V20YtDWw/OlrBEUg0f17ndHwofcmehIFYKZF0wXZOVwVX3DdRs
        nKYp5Lni1Z1KZFulOeWVYfVAXVOOXPPpyfowDdoPrHzznjLZPR5eQSnKOnP2N+pVSb60pV
        YuJLNtGqlgKGO5vHvmtfawn7GHZ5SPqOG2gLfK4M4jdhPr8gS/6Qy4oQP9sWyVG83U2Wcw
        3F5mHxzQEnVlRIQheqGb9xj9w10+iEhcAqBcD3Qt0ypHsZ95tdhbyZN3vLXdBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702381408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0f0NLMhcX0Ji4stoXsgRQnnGmOpz8MKcblkO1WoOzEo=;
        b=MHTCbyyQ20c/BMVu0vQjWEkmMjsM6+FRAGWyiydpbUhQET/ZC60zBu/ss6OolxE+EfP3oF
        EkoYTCcnNVdMHeBA==
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
Subject: Re: [PATCH v9 30/32] timers: Implement the hierarchical pull model
In-Reply-To: <87h6knmzco.fsf@somnus>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
 <20231211180417.XG9G3ryS@linutronix.de> <87h6knmzco.fsf@somnus>
Date:   Tue, 12 Dec 2023 12:43:27 +0100
Message-ID: <87a5qfmysg.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> Sebastian Siewior <bigeasy@linutronix.de> writes:
>
>> On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
>>
>> This whole thing confuses me.
>> If the CPU goes offline, it needs to get removed from the migration
>> hierarchy and this is it. Everything else is handled by the migrator. If
>> the migrator is going offline then it needs wake a random CPU and make
>> sure it takes the migrator role. I am confused by the whole ::wakeup and
>> ::wakeup_recalc thingy.
>>
>
> wakeup_recalc is required to indicate, that the CPU was chosen as the
> new migrator CPU when the last active CPU in timer migration hierarchy
> went offline.
>
> When a CPU goes idle and it is the last active CPU in the timer
> migration hierarchy, it has to make sure that it wakes up in time to
> handle the first event of the hierarchy. On the normal idle path this is
> not a problem as the value of the first event of the hierarchy is
> returned. But when an IRQ occurs on this idle CPU, the timers are
> revisited again. But then it is also required that the first event of
> the timer migration hierarchy is still considered, as the CPU cannot
> make sure another CPU will handle it. So the value is stored on idle
> path to tmc->wakeup. Otherwise every idle CPU has to walk the hierarchy
> again after an IRQ to make sure nothing is lost as the CPU doesn't know
> what happend in the meantime. I'm aware, that it is possible that
> several CPUs have the same wakeup value when there is no new first event
> and if the hierarchy is idle and some CPUs become active and go idle
> directly again. But if we want to cover this, we need a single point
> with the first event and with the last migrator information and I'm
> quite sure that it will not scale.
>

I forgot to explain one thing: A CPU does remote expiry and it is
possible that the CPU is idle in timer migration hierarchy. Therefore
the wakeup value is updated at the end of remote handling with the new
first event of the timer migration hierarchy unconditionally.

Thanks,
	Anna-Maria

