Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3280F410
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjLLRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:08:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4868999
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:08:59 -0800 (PST)
Date:   Tue, 12 Dec 2023 18:08:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702400937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHd/GIvEuAFn2fDqEH8KZE4ZeOg4egPJvYnz2DkhrGo=;
        b=A2snbrL/6oD6Pi26QkpMcd3c/txTX8r0SXA9vlJNAH/E2XeywD2Kb81NjIVJdWVzPBYukG
        XopQcBKbQZpNqsYAX1n/9U4z/8dSHTEVBaqDLk9Ms+kSn/hLuFgtv9KF3HLbvn3hcopY6C
        ovowidBdsPT+swOir25Iu6wX5RZRhJQLipK22UPHEjyB5KWxQJhvRv5X/6R7IxXZE3ui68
        PRnRnoUWOZuDKZyWpuTdxgLAe6t2nAb+Nw8urVn+xSTahv5ier/Wvvwi+uznGNehsk5FH4
        lcnoGlELWOlZdpGY6ZxW24g7SJlOi9XM6WLNHbNyscgUBsDxVgrkZ+xagpxsjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702400937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHd/GIvEuAFn2fDqEH8KZE4ZeOg4egPJvYnz2DkhrGo=;
        b=yjWflIRjqjIJkfSn94KCNfw18uIE9J/UKGXjOXaIBqLVg0R/VVQs83RwX22bSgzMp/8ns/
        9yGDhvQ+vGD37IAw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
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
Message-ID: <20231212170855.pxX3SZdS@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
 <20231212121404.C2R9VWj1@linutronix.de>
 <87y1dzlbh8.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1dzlbh8.fsf@somnus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-12 15:52:19 [+0100], Anna-Maria Behnsen wrote:
> Sebastian Siewior <bigeasy@linutronix.de> writes:
> 
> >> +/* Per group capacity. Must be a power of 2! */
> >> +#define TMIGR_CHILDREN_PER_GROUP 8
> >
> > BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP)
> >
> > Maybe in the .c file.
> >
> 
> in tmigr_init() ?

Yeah why not. It is used there for the init of the structs.

> >> +/**
> >> + * struct tmigr_group - timer migration hierarchy group
> >> + * @lock:		Lock protecting the event information and group hierarchy
> >> + *			information during setup
> >> + * @migr_state:		State of the group (see union tmigr_state)
> >
> > So the lock does not protect migr_state?
> 
> Right - this is not required due to the atomic cmpxchg and seqence
> counter.
> 
> > Mind moving it a little down the road? Not only would it be more
> > obvious what is protected by the lock but it would also move
> > migr_state in another/ later cache line.
> >
> 
> Where do you want me to move it? Switch places of lock and migr_state?
> When I put it to another place, I would generate holes. A general
> question: Is it required to have a look at the struct with pahole also
> with LOCKDEP enabled? If yes, lock should stay at the first position.

Maybe something like:
| struct tmigr_group {
|         raw_spinlock_t             lock;                 /*     0     4 */
| 
|         /* XXX 4 bytes hole, try to pack */
| 
|         struct tmigr_group *       parent;               /*     8     8 */
|         struct tmigr_event         groupevt __attribute__((__aligned__(8))); /*    16    40 */
| 
|         /* XXX last struct has 3 bytes of padding */
| 
|         u64                        next_expiry;          /*    56     8 */
|         /* --- cacheline 1 boundary (64 bytes) --- */
|         struct timerqueue_head     events;               /*    64    16 */
|         atomic_t                   migr_state;           /*    80     4 */
|         unsigned int               level;                /*    84     4 */
|         int                        numa_node;            /*    88     4 */
|         unsigned int               num_children;         /*    92     4 */
|         u8                         childmask;            /*    96     1 */
| 
|         /* XXX 7 bytes hole, try to pack */
| 
|         struct list_head           list;                 /*   104    16 */


Starting with lock isn't bad as you see everything from here is
protected by lock. If it makes sense you could start with list so that
the container_of() becomes a NOP.
I wouldn't make lockdep a thing and assume it is off. Also, I would
assume the architecture is 64bit.

However with lockdep enabled it becomes:

| struct tmigr_group {
|         raw_spinlock_t             lock;                 /*     0    64 */
|         /* --- cacheline 1 boundary (64 bytes) --- */
|         struct tmigr_group *       parent;               /*    64     8 */
|         struct tmigr_event         groupevt __attribute__((__aligned__(8))); /*    72    40 */
| 
|         /* XXX last struct has 3 bytes of padding */
| 
|         u64                        next_expiry;          /*   112     8 */
|         struct timerqueue_head     events;               /*   120    16 */
|         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
|         atomic_t                   migr_state;           /*   136     4 */
|         unsigned int               level;                /*   140     4 */
|         int                        numa_node;            /*   144     4 */
|         unsigned int               num_children;         /*   148     4 */
|         u8                         childmask;            /*   152     1 */
| 
|         /* XXX 7 bytes hole, try to pack */
| 
|         struct list_head           list;                 /*   160    16 */
| } __attribute__((__aligned__(8)));

so it didn't change much.

I shuffled it a bit and everything after migr_state is read only.
I don't think looking at pahole is required but in your case it makes
sense to put the locked section into a separate cache line vs migr_state
variable. It doesn't cost much.
You can decide if it is worth to move childmask after the lock so you so
you avoid the 7 byte hole at the end. I wouldn't do it to satisfy pahole
here. If it makes sense, doesn't hurt/ confuse why not.

You would consider the pahole output more on a structure like dentry
which is used a _lot_. So saving 4 bytes would mean save a megabyte or
ten in the end.

> Thanks,
> 
>         Anna-Maria
> 

Sebastian
