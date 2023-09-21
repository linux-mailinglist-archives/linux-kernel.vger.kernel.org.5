Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB487A90CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjIUCMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjIUCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:12:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA23CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:12:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695262347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGsXb59mheAvf0K/E0GO3/Bp/8mZXCu36PHW8K2vlxI=;
        b=4aQW4w2uUjAKLLA6iOdyat5+SCt1rP/XPruRshfBLZMyyz/uU/1fO/sKn0Irl5vexExvji
        zJJnqqH3YsCaEuZqb+q4bEntoeYsp1xYDng9TUXHuMJgMTMfwFRQYr0orDJoR/wOxaSCxQ
        AoDXS9VVwYTCAVBkgzHC0oscSF1EkN3gTvrI4IJ5spFelSSCtqKBiE5aHioWUV3rbdsMim
        G8Hx+AX1upPFu9TC+vKCdRnyGBt1uygWDZWvmXuu3U+Sw6gdkfvXBk9/i/hKEXRqaJwwRL
        rQsdgaoFwC32fuD3aCS+8tMgnfJoOEeDaciNMMoH451sm8mhVNiwwuxsXfiCyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695262347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGsXb59mheAvf0K/E0GO3/Bp/8mZXCu36PHW8K2vlxI=;
        b=sO/9/fISUk77aPbQ2sgJ2s84yiEHYYsGdaG620hmsx1tZu4FTAjI7ObUu0kwFasGSwfcVv
        212YTsmnxSsObHAg==
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
In-Reply-To: <875y44ibow.fsf@oracle.com>
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
 <87led2wdj0.ffs@tglx> <878r90lyai.fsf@oracle.com> <875y44va9t.ffs@tglx>
 <875y44ibow.fsf@oracle.com>
Date:   Thu, 21 Sep 2023 04:12:27 +0200
Message-ID: <87r0mstgtw.ffs@tglx>
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

On Wed, Sep 20 2023 at 17:58, Ankur Arora wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> So no, we don't need yet another knob. We keep them chucking along and
>> if they really want they can adopt to the new world order. :)
>
> Will they chuckle along, or die trying ;)?

Either way is fine :)

> I grepped for "preempt_enable|preempt_disable" for all the archs and
> hexagon and m68k don't seem to do any explicit accounting at all.
> (Though, neither do nios2 and openrisc, and both csky and microblaze
> only do it in the tlbflush path.)
>
>         arch/hexagon      0
>         arch/m68k         0
...
>         arch/s390        91
>         arch/mips       115
>         arch/x86        146
>         arch/powerpc    201
>
> My concern is given that we preempt on timeslice expiration for all
> three preemption models, we could end up preempting at an unsafe
> location.

As I said in my reply to Linus, that count is not really conclusive.

arch/m68k has a count of 0 and supports PREEMPT for the COLDFIRE
sub-architecture and I know for sure that at some point in the past
PREEMPT_RT was supported on COLDFIRE with minimal changes to the
architecture code.

That said, I'm pretty sure that quite some of these
preempt_disable/enable pairs in arch/* are subject to voodoo
programming, but that's a different problem to analyze.

> Still, not the most pressing of problems.

Exactly :)

Thanks,

        tglx
 
