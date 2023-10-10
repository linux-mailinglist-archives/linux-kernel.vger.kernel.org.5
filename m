Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB17BFA46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJJLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjJJLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:48:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8553AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:48:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696938530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfxZBEaYn9pBAe6XWAS9KebgnYIvRu1sv+X/+uTWueg=;
        b=ZWNv7GZKzbYXdt6lssHdKCH5piVwvUymFVtkFKCxg9rji7zYA307pKVfr+nEiEiGuBBqkH
        oRvS7zWK0ORN2NW7CgP6X3TBvyx2cwwpEg9OpcoUiLV7c1AZE2v1paBhJrwjK8a6bx0ZtX
        b+iC1CdEOMT+1nNEzJSTg9g5Fy560dsqOp1u+7VZQH+5ZNPzY1+JEDB8+gY+iKx9hl3Eo2
        wJAel8dnCe5lkYjpztD1uYsw2EbWj6QJjwGiSJSI2+jFQuGt9FjUUEYVfuoN28+pHCrTNr
        rIYN0NtLAmb52P1mZjMurrk3h8t+SRPmsXu02qs9FWQCph6O+k3j+pqmmDFgBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696938530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfxZBEaYn9pBAe6XWAS9KebgnYIvRu1sv+X/+uTWueg=;
        b=L0aokBJ43Oe/L8fp8CFXJrEYOuX6XUYP9GNtPuncRWwxZgVHpn785SsTe7vJq1k9elQLtz
        28ELNrTO29KYegAQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
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
Subject: Re: [PATCH v8 08/25] timer: Rework idle logic
In-Reply-To: <ZSUzJpeT86pQ8YcY@lothringen>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-9-anna-maria@linutronix.de> <878r8bphn6.ffs@tglx>
 <ZSUzJpeT86pQ8YcY@lothringen>
Date:   Tue, 10 Oct 2023 13:48:50 +0200
Message-ID: <87ttqyofz1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10 2023 at 13:19, Frederic Weisbecker wrote:
> On Tue, Oct 10, 2023 at 12:15:09AM +0200, Thomas Gleixner wrote:
>> > +	base->is_idle = time_after(nextevt, basej + 1);
>> 
>> This is wrongly ordered. base->is_idle must be updated _after_
>> evaluating base->timers_pending because the below can change nextevt,
>> no?
>> 
>> > +	if (base->timers_pending) {
>> > +		/* If we missed a tick already, force 0 delta */
>> > +		if (time_before(nextevt, basej))
>> > +			nextevt = basej;
>> > +		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
>
> I suspect it doesn't matter in pratice: base->is_idle will remain false
> if it's before/equal jiffies.
>
> Still it hurts the eyes so I agree the re-ordering should happen here and
> this will even simplify a bit the next patch.

Right. Anna-Maria just pointed that out to me before, but we are all in
violent agreement that it sucks :)
