Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339937AA55D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjIUW4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIUW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048DCD5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 15:55:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695336951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mf4C1LU7+NOwV8ar7ATsCLbsn9zDQYOdXhqIOKCBaIw=;
        b=l99t0G+VKAU9ivFYPA6aSvBhcKOMu9TAAMi68vy8kXnGZL3VMxglO5mEL/MuEJjW6aA9bk
        AJ8hQZNFODr14SUBVE8uU8GkQarCoznkOmdQnf8Zb7DvCvzIPLvrJgvy8OzrRwq2/C3H7Z
        sXeoDjaGVStm8cCLH/LbGe5066x/u6soUijfKG5laKOV0FoiTeTwmkvzjiCOH9jCZ15GNn
        nRarB3wm4l0D+N3qHGUkM3aOPTmVKIBc5ecVIaVATRnYXypJSEjIzH9gCPjLyFB7bZ9B1k
        Zic93EIXMQzjiOXgEYCDTpcWddAlPdGvsWjWHgiAeD38Yaxw0KbJli2CAMB6wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695336951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=mf4C1LU7+NOwV8ar7ATsCLbsn9zDQYOdXhqIOKCBaIw=;
        b=TwM2g/ZZ7PN5b1/ci2RZ0K5evNFZ/JV9R27VV/+x5aZnAAIzj8DPCY9Okr4wz/A9PtvyJ9
        GD6tTjiISY6VwdAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <CAHk-=wix=nrfi2LkSXBvBSrTHgEAMYQebUfWXq8Q-PtH0x_SdQ@mail.gmail.com>
Date:   Fri, 22 Sep 2023 00:55:51 +0200
Message-ID: <87ttrngmq0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus!

On Thu, Sep 21 2023 at 09:00, Linus Torvalds wrote:
> Ok, I like this.

Thanks!

> That said, this part of it:

> On Wed, 20 Sept 2023 at 16:58, Thomas Gleixner <tglx@linutronix.de> wrote:

> Because honestly, without having been part of this thread, I would look at that
>
>         if (nr_bit == TIF_NEED_RESCHED)
>                 set_preempt_need_resched();
>
> and I'd be completely lost. It doesn't make conceptual sense, I feel.
>
> So I'd really like the source code to be more directly expressing the
> *intent* of the code, not be so centered around the implementation
> detail.
>
> Put another way: I think we can make the compiler turn the intent into
> the implementation, and I'd rather *not* have us humans have to infer
> the intent from the implementation.

No argument about that. I didn't like it either, but at 10PM ...

> That said - I think as a proof of concept and "look, with this we get
> the expected scheduling event counts", that patch is perfect. I think
> you more than proved the concept.

There is certainly quite some analyis work to do to make this a one to
one replacement.

With a handful of benchmarks the PoC (tweaked with some obvious fixes)
is pretty much on par with the current mainline variants (NONE/FULL),
but the memtier benchmark makes a massive dent.

It sports a whopping 10% regression with the LAZY mode versus the mainline
NONE model. Non-LAZY and FULL behave unsurprisingly in the same way.

That benchmark is really sensitive to the preemption model. With current
mainline (DYNAMIC_PREEMPT enabled) the preempt=FULL model has ~20%
performance drop versus preempt=NONE.

I have no clue what's going on there yet, but that shows that there is
obviously quite some work ahead to get this sorted.

Though I'm pretty convinced by now that this is the right direction and
well worth the effort which needs to be put into that.

Thanks,

        tglx
