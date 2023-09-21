Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EFA7A90C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjIUCCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjIUCCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:02:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3F7BB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:02:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695261721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R7vVBda9gvcvqlzUBjjzT9jNAI4rEfJOwwmk972/3PU=;
        b=ogBI4O6fwkuLRnY+Vzhprbc+qTFmU7x2aYzM0yF/sKa4gViHGhx49AY7phU642gLDd1h2I
        5qz/YI5PD/nxfpxSf+9SMeEZ6A4eYzAEU7B5AhhfgoFFzATcI/8jWvIQq33qcRggw0wqQi
        +bQmdW5wBu1TqNNcZt6u5AAy9Z4BdnkdeOzufnAem+7DU8m9Kf9olgXg3pvOiGo2iqnn+T
        wGXAIcg4dxUOgliIYCqiW+xk+Ki0lNtAZkUzP8Zwsd+v3vQChbjDCvYq2JoOyPp0rRDnBa
        FER4gxKUe8wHFMaod9ZbDEbEVqdwmKiZs2KdeBibFhF0AEjHJrEQGtnZpEX5YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695261721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R7vVBda9gvcvqlzUBjjzT9jNAI4rEfJOwwmk972/3PU=;
        b=jJA0HmiXaG/8raS9gLO+e4rwncohcsaxDM4qlc7rLUqH8+znF5rGDEYPg+mVzYbcdPbczr
        Nrm8Tzp5j2TWLvCg==
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <87edisibrp.fsf@oracle.com>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <8734z8v1lo.ffs@tglx> <87edisibrp.fsf@oracle.com>
Date:   Thu, 21 Sep 2023 04:02:00 +0200
Message-ID: <87ttrothbb.ffs@tglx>
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

On Wed, Sep 20 2023 at 17:57, Ankur Arora wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Find below a PoC which implements that scheme. It's not even close to
>> correct, but it builds, boots and survives lightweight testing.
>
> Whew, that was electric. I had barely managed to sort through some of
> the config maze.
> From a quick look this is pretty much how you described it.

Unsurpringly I spent at least 10x the time to describe it than to hack
it up.

IOW, I had done the analysis before I offered the idea and before I
changed a single line of code. The tools I used for that are git-grep,
tags, paper, pencil, accrued knowledge and patience, i.e. nothing even
close to rocket science.

Converting the analysis into code was mostly a matter of brain dumping
the analysis and adherence to accrued methodology.

What's electric about that?

I might be missing some meaning of 'electric' which is not covered by my
mostly Webster restricted old-school understanding of the english language :)

>> I did not even try to look into time-slice enforcement, but I really want
>> to share this for illustration and for others to experiment.
>>
>> This keeps all the existing mechanisms in place and introduces a new
>> config knob in the preemption model Kconfig switch: PREEMPT_AUTO
>>
>> If selected it builds a CONFIG_PREEMPT kernel, which disables the
>> cond_resched() machinery and switches the fair scheduler class to use
>> the NEED_PREEMPT_LAZY bit by default, i.e. it should be pretty close to
>> the preempt NONE model except that cond_resched() is a NOOP and I did
>> not validate the time-slice enforcement. The latter should be a
>> no-brainer to figure out and fix if required.
>
> Yeah, let me try this out.

That's what I hoped for :)

Thanks,

        tglx
