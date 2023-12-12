Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB880EF55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376941AbjLLOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbjLLOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:52:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F42D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:52:22 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jl2CgwKBV0Qktq6WkukabpmaDXPHyrDvhtR3X2AQME=;
        b=lhwM+Gg1Nzt7GRTvWQg+PkHUb32pRcGVq5OpIMhm3PRXPHPi44Lsc+8xW4MyOlCNBH8MQ6
        6dukKBEc41ZMlUHd3ekc32ccFLqyxb21ydGdizM864V39Uq95+eO0X+GyAjzMwhCqUnFSW
        OfHAh20FpPfd44Xng1zXxFAIcTabWaJgbtelAzTUZLF8cSw/7t3OImwnoMhLjc3DcWv+3i
        lTxQBUWYhtyywK/NAy3G9Yi9tOStCbsJGoTR9gPz+JVxZNyX1SKWuKEGCL6dz2JQQnEzvB
        rX7heWj1vcf9CIHPx95b3h0HeRQu8VqJpW9szSk9JFf6vzpjV3ll6lBneUSCIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jl2CgwKBV0Qktq6WkukabpmaDXPHyrDvhtR3X2AQME=;
        b=RbhaudChB16gmCKyWqTxvZjfI8vjVZyf/Y9yzGGeMvm9aEGb6Z/wCXHvkTZRWhZJlFEhuO
        +15dqCRqujqEKNAw==
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
In-Reply-To: <20231212121404.C2R9VWj1@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
 <20231212121404.C2R9VWj1@linutronix.de>
Date:   Tue, 12 Dec 2023 15:52:19 +0100
Message-ID: <87y1dzlbh8.fsf@somnus>
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

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:

[...]

>> diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
>> new file mode 100644
>> index 000000000000..260b87e5708d
>> --- /dev/null
>> +++ b/kernel/time/timer_migration.h
>> @@ -0,0 +1,144 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _KERNEL_TIME_MIGRATION_H
>> +#define _KERNEL_TIME_MIGRATION_H
>> +
>> +/* Per group capacity. Must be a power of 2! */
>> +#define TMIGR_CHILDREN_PER_GROUP 8
>
> BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP)
>
> Maybe in the .c file.
>

in tmigr_init() ?

>> +/**
>> + * struct tmigr_event - a timer event associated to a CPU
>> + * @nextevt:	The node to enqueue an event in the parent group queue
>> + * @cpu:	The CPU to which this event belongs
>> + * @ignore:	Hint whether the event could be ignored; it is set when
>> + *		CPU or group is active;
>> + */
>> +struct tmigr_event {
>> +	struct timerqueue_node	nextevt;
>> +	unsigned int		cpu;
>> +	bool			ignore;
>> +};
>> +
>> +/**
>> + * struct tmigr_group - timer migration hierarchy group
>> + * @lock:		Lock protecting the event information and group hierarchy
>> + *			information during setup
>> + * @migr_state:		State of the group (see union tmigr_state)
>
> So the lock does not protect migr_state?

Right - this is not required due to the atomic cmpxchg and seqence
counter.

> Mind moving it a little down the road? Not only would it be more
> obvious what is protected by the lock but it would also move
> migr_state in another/ later cache line.
>

Where do you want me to move it? Switch places of lock and migr_state?
When I put it to another place, I would generate holes. A general
question: Is it required to have a look at the struct with pahole also
with LOCKDEP enabled? If yes, lock should stay at the first position.

[...]

>> + * @cpuevt:		CPU event which could be queued into the parent group
>
> I don't know why but it feels like s/queued/enqueued/g
> But it might be a British vs American thing.

I think this queued/enqueued is not used consistent all over the place
(in my patchset). But I'm also not a native speaker and not sure which
is the proper one :). Nevertheless, I'll change it.

Thanks,

        Anna-Maria

