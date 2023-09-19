Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8A7A64D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjISNZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjISNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:25:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA4EC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:25:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695129920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBxxm4ru3/VDC+4Jdk17s0visMQQa1pK33oOFPmvJJ4=;
        b=wzxUu24gogAAAj4c9kQnjebK37Y9s99q7EQDwun6AAnJ1T6yZo4QZ32YKt9XxBlw9Ujh5m
        UgmeY6XjPOWljLTVz8hascxWgGje/hhJ9pcZw/QfnJo6GaDht7S3kGbk8oLMOyGJWeitwR
        +eeV33aqvXx/xMj2vJa6inCUcfkDkLURf8Hwh/j6dGWaxfmJqI74cI5IsBpsH9ED0lr9H7
        3orm9hhmWotGOhpsSFdfFShrHn3p5oO7/U6A8I7OQ4rL8ksSw17Zb2W5tRrh3yINkaZk/7
        MvVeeIagYaHu0S7oRe4aFZkp8Ov5kI+mEo+sgBGEM+Vz+Tfw62RAnFzrlaZpcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695129920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBxxm4ru3/VDC+4Jdk17s0visMQQa1pK33oOFPmvJJ4=;
        b=Jc8zgpLP8A7UB29/YZIxhWwatrV4iyHXB1ZeDZr7CsNwIiuNl3xpqXT0OHBUKb/yBblClE
        +l9HZQ76ox1GVnDg==
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <ZQlV5l4pbKunQJug@gmail.com>
References: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <ZQlV5l4pbKunQJug@gmail.com>
Date:   Tue, 19 Sep 2023 15:25:19 +0200
Message-ID: <87il86wb0g.ffs@tglx>
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

Ingo!

On Tue, Sep 19 2023 at 10:03, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> Then the question becomes whether we'd want to introduce a *new* concept, 
>> which is a "if you are going to schedule, do it now rather than later, 
>> because I'm taking a lock, and while it's a preemptible lock, I'd rather 
>> not sleep while holding this resource".
>
> Something close to this concept is naturally available on PREEMPT_RT 
> kernels, which only use a single central lock primitive (rt_mutex), but it 
> would have be added explicitly for regular kernels.
>
> We could do the following intermediate step:
>
>  - Remove all the random cond_resched() points such as might_sleep()
>  - Turn all explicit cond_resched() points into 'ideal point to reschedule'.
>
>  - Maybe even rename it from cond_resched() to resched_point(), to signal 
>    the somewhat different role.
>
> While cond_resched() and resched_point() are not 100% matches, they are 
> close enough, as most existing cond_resched() points were added to places 
> that cause the least amount of disruption with held resources.
>
> But I think it would be better to add resched_point() as a new API, and add 
> it to places where there's a performance benefit. Clean slate, 
> documentation, and all that.

Lets not go there. You just replace one magic mushroom with a different
flavour. We want to get rid of them completely.

The whole point is to let the scheduler decide and give it enough
information to make informed decisions.

So with the LAZY scheme in effect, there is no real reason to have these
extra points and I rather add task::sleepable_locks_held and do that
accounting in the relevant lock/unlock paths. Based on that the
scheduler can decide whether it grants a time slice expansion or just
says no.

That's extremly cheap and well defined.

You can document the hell out of resched_point(), but it won't be any
different from the existing ones and always subject to personal
preference and goals and its going to be sprinkled all over the place
just like the existing ones. So where is the gain?

Thanks,

        tglx




