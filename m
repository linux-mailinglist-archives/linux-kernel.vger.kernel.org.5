Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DEA7A8E02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjITUvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjITUvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:51:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C988B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:51:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695243071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8wH3xXptk2FaJacDdB38SCo/MZ0RCGy/rAMkir/m48=;
        b=1n8rvgbpA1zMkUhWgjZHoFQy61k0a96eow1oOnnXvxrzr/Y9EUx1/vQyCwU4m6U52x9wCB
        9pV6Ai3qTsH9qJWRurLdtmo97xLmamyaqZcTu5ILbTXR0IEVBoUqu3+X9l5gAt7N7imPd/
        GRiVhL4hxRWVK2muDGPdAulrAP9DExCFQ8ZdionPdaDCZnRt1i41Cfz7cuERLpK5w1Fop2
        zYkpVXtF27bAmymFZlVpUIWj9WeQ9wF42AA7KMYSBaJfnLA6ZRwHN+21oNTw0LK4f/lLhk
        panNSY1uU2H0Ph+UysgaZYH4Urv35Z8BxD2ZkIWybTkEpH/eG+Xryw2m8hisZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695243071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8wH3xXptk2FaJacDdB38SCo/MZ0RCGy/rAMkir/m48=;
        b=NaCa2jCnfgpxfOhrn9TpCEHpP+IS0cE5Y/7MBHlCNzs3fyea7v3XXFsVarBr6Qha+gjuv7
        X8R4m0Iyy4lWefCw==
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
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <878r90lyai.fsf@oracle.com>
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
 <87led2wdj0.ffs@tglx> <878r90lyai.fsf@oracle.com>
Date:   Wed, 20 Sep 2023 22:51:10 +0200
Message-ID: <875y44va9t.ffs@tglx>
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

On Wed, Sep 20 2023 at 07:22, Ankur Arora wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>
>> So the decision matrix would be:
>>
>>                 Ret2user        Ret2kernel      PreemptCnt=0
>>
>> NEED_RESCHED       Y                Y               Y
>> LAZY_RESCHED       Y                N               N
>>
>> That is completely independent of the preemption model and the
>> differentiation of the preemption models happens solely at the scheduler
>> level:
>
> This is relatively minor, but do we need two flags? Seems to me we
> can get to the same decision matrix by letting the scheduler fold
> into the preempt-count based on current preemption model.

You still need the TIF flags because there is no way to do remote
modification of preempt count.

The preempt count folding is an optimization which simplifies the
preempt_enable logic:

	if (--preempt_count && need_resched())
		schedule()
to
	if (--preempt_count)
		schedule()

i.e. a single conditional instead of two.

The lazy bit is only evaluated in:

    1) The return to user path

    2) need_reched()

In neither case preempt_count is involved.

So it does not buy us enything. We might revisit that later, but for
simplicity sake the extra TIF bit is way simpler.

Premature optimization is the enemy of correctness.

>> We should be able merge the PREEMPT_NONE/VOLUNTARY behaviour so that we
>> only end up with two variants or even subsume PREEMPT_FULL into that
>> model because that's what is closer to the RT LAZY preempt behaviour,
>> which has two goals:
>>
>>       1) Make low latency guarantees for RT workloads
>>
>>       2) Preserve the throughput for non-RT workloads
>>
>> But in any case this decision happens solely in the core scheduler code
>> and nothing outside of it needs to be changed.
>>
>> So we not only get rid of the cond/might_resched() muck, we also get rid
>> of the static_call/static_key machinery which drives PREEMPT_DYNAMIC.
>> The only place which still needs that runtime tweaking is the scheduler
>> itself.
>
> True. The dynamic preemption could just become a scheduler tunable.

That's the point.

>> But they support PREEMPT_COUNT, so we might get away with a reduced
>> preemption point coverage:
>>
>>                 Ret2user        Ret2kernel      PreemptCnt=0
>>
>> NEED_RESCHED       Y                N               Y
>> LAZY_RESCHED       Y                N               N
>
> So from the discussion in the other thread, for the ARCH_NO_PREEMPT
> configs that don't support preemption, we probably need a fourth
> preemption model, say PREEMPT_UNSAFE.

As discussed they wont really notice the latency issues because the
museum pieces are not used for anything crucial and for UM that's the
least of the correctness worries.

So no, we don't need yet another knob. We keep them chucking along and
if they really want they can adopt to the new world order. :)

Thanks,

        tglx
