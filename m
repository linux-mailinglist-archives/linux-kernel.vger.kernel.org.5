Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96E7A572C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjISB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISB6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:58:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A294
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:58:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9adb9fa7200so1049358266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695088690; x=1695693490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ncQzUM1Efo12FAQWJZLqWp6KtQXhuyYpzpYvTO5Tk8M=;
        b=E2UKdk2h5axmrS5WiBzWUfD9NUo5j5RQly/l34E3tc5sBxe8wTeXsS5RSr9QgazDk2
         gr16GITWaDfb43cNaklmVttJ5T2egzxlbcAosBWe6phYhCLhIfs5DAFPOHaGlDs1J2ZH
         qRsi3IrrFm2z9B89kawnk9tnUmpnWlijHk2Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695088690; x=1695693490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncQzUM1Efo12FAQWJZLqWp6KtQXhuyYpzpYvTO5Tk8M=;
        b=YQadvSUWsIZo65LEip7Weugeh0GuvO6789e0Tq/bWEVkyQJC6jxngYbWar9fDpIurE
         rovr+exy9amTBv+780wdqVjlwNg2zbr06h1ke6VgQvQLWWrqS43tc7kc101rGkE9cbez
         JDSgqX0ChDAO/8UzM7Hk9hkKYZ6YbF9P2ogNBFz87lyOweRPQgLj7PEpiNzwzgbaPj0z
         Y9nRbxjYMfL5DhvCYckXF+1rpB/dQ13OfcZp1rbOI0KbSmt0agnf1kAcaAwb6A404oIa
         o1bj+4rZkwHmQMuWZN3TKRxvBuVITeIz4OEN/yIC9fTklfkBzDrb09NY/vFvYwkK5KSF
         aJJw==
X-Gm-Message-State: AOJu0YyW0Mb4UtGNhWHEQSWYIFa917tqjNk0h/EsabBKdWwb5bdtbKdq
        d73cEGoYq9JRUpcD5Cm8z0v+rP62GeUL0ErnkaXKD2Od
X-Google-Smtp-Source: AGHT+IFlAGiAmaQHOh9S/CXKJKBqnqsQbISRLVi6wCezttgtZk+QJdhFCHDAwD8EecMnLiunuv6Qmw==
X-Received: by 2002:a17:907:e8c:b0:9a5:794f:f3c5 with SMTP id ho12-20020a1709070e8c00b009a5794ff3c5mr1901738ejc.6.1695088690471;
        Mon, 18 Sep 2023 18:58:10 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066b1500b0098921e1b064sm7078752ejr.181.2023.09.18.18.58.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 18:58:08 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-532addba879so1046815a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:58:08 -0700 (PDT)
X-Received: by 2002:a05:6402:1762:b0:52a:38c3:1b4b with SMTP id
 da2-20020a056402176200b0052a38c31b4bmr1603271edb.15.1695088688232; Mon, 18
 Sep 2023 18:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net> <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
In-Reply-To: <87cyyfxd4k.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 18:57:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
Message-ID: <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 16:42, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> What about the following:
>
>    1) Keep preemption count and the real preemption points enabled
>       unconditionally.

Well, it's certainly the simplest solution, and gets rid of not just
the 'rep string' issue, but gets rid of all the cond_resched() hackery
entirely.

>       20 years ago this was a real issue because we did not have:
>
>        - the folding of NEED_RESCHED into the preempt count
>
>        - the cacheline optimizations which make the preempt count cache
>          pretty much always cache hot
>
>        - the hardware was way less capable
>
>       I'm not saying that preempt_count is completely free today as it
>       obviously adds more text and affects branch predictors, but as the
>       major distros ship with DYNAMIC_PREEMPT enabled it is obviously an
>       acceptable and tolerable tradeoff.

Yeah, the fact that we do presumably have PREEMPT_COUNT enabled in
most distros does speak for just admitting that the PREEMPT_NONE /
VOLUNTARY approach isn't actually used, and is only causing pain.

>    2) When the scheduler wants to set NEED_RESCHED due it sets
>       NEED_RESCHED_LAZY instead which is only evaluated in the return to
>       user space preemption points.

Is this just to try to emulate the existing PREEMPT_NONE behavior?

If the new world order is that the time slice is always honored, then
the "this might be a latency issue" goes away. Good.

And we'd also get better coverage for the *debug* aim of
"might_sleep()" and CONFIG_DEBUG_ATOMIC_SLEEP, since we'd rely on
PREEMPT_COUNT always existing.

But because the latency argument is gone, the "might_resched()" should
then just be removed entirely from "might_sleep()", so that
might_sleep() would *only* be that DEBUG_ATOMIC_SLEEP thing.

That argues for your suggestion too, since we had a performance issue
due to "might_sleep()" _not_ being just a debug thing, and pointlessly
causing a reschedule in a place where reschedules were _allowed_, but
certainly much less than optimal.

Which then caused that fairly recent commit 4542057e18ca ("mm: avoid
'might_sleep()' in get_mmap_lock_carefully()").

However, that does bring up an issue: even with full preemption, there
are certainly places where we are *allowed* to schedule (when the
preempt count is zero), but there are also some places that are
*better* than other places to schedule (for example, when we don't
hold any other locks).

So, I do think that if we just decide to go "let's just always be
preemptible", we might still have points in the kernel where
preemption might be *better* than in others points.

But none of might_resched(), might_sleep() _or_ cond_resched() are
necessarily that kind of "this is a good point" thing. They come from
a different background.

So what I think what you are saying is that we'd have the following situation:

 - scheduling at "return to user space" is presumably always a good thing.

A non-preempt-count bit NEED_RESCHED_LAZY (or TIF_RESCHED, or
whatever) would cover that, and would give us basically the existing
CONFIG_PREEMPT_NONE behavior.

So a config variable (either compile-time with PREEMPT_NONE or a
dynamic one with DYNAMIC_PREEMPT set to none) would make any external
wakeup only set that bit.

And then a "fully preemptible low-latency desktop" would set the
preempt-count bit too.

 - but the "timeslice over" case would always set the
preempt-count-bit, regardless of any config, and would guarantee that
we have reasonable latencies.

This all makes cond_resched() (and might_resched()) pointless, and
they can just go away.

Then the question becomes whether we'd want to introduce a *new*
concept, which is a "if you are going to schedule, do it now rather
than later, because I'm taking a lock, and while it's a preemptible
lock, I'd rather not sleep while holding this resource".

I suspect we want to avoid that for now, on the assumption that it's
hopefully not a problem in practice (the recently addressed problem
with might_sleep() was that it actively *moved* the scheduling point
to a bad place, not that scheduling could happen there, so instead of
optimizing scheduling, it actively pessimized it). But I thought I'd
mention it.

Anyway, I'm definitely not opposed. We'd get rid of a config option
that is presumably not very widely used, and we'd simplify a lot of
issues, and get rid of all these badly defined "cond_preempt()"
things.

                Linus
