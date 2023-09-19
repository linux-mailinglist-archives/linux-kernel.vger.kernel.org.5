Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE17A69AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjISReK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjISReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:34:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B82CC6;
        Tue, 19 Sep 2023 10:34:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695144838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5XoD2rR1P7xfyZ4vS5WECNooPW5RHsWgoNmWq+2hMo=;
        b=UJuEQFI+fVdHak0lB8fNvstykL9kpTeNJD+gjygB9iKFIoN1n7qL5fa8q1zibRy2IPQ6Qe
        NyukDnTgIGP7wS4FzYHD5OGCHF62//LTFHZZ8yP9IQToCNuSqQ1GH+7YaaGPaBI/CX6Z8V
        8Vzbr2wmmB33ZJMWTR30JR513dx/C+zEch08e6QwhmiWdN2hx57bNIhu4sFxTiAQXh1Xn1
        G7Uqydw7R+LQiZU2Twrng6XRlmrm/mXOIsAXYOgo5eW8rhYLGVEvA9DBjj6ZiIG4ffl66+
        NOsgtS0rfYpuBXj0rw8P+dSYdXzP2sFea+0Hqq+BkBT6knNGfVPF/+sEjn1HEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695144838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5XoD2rR1P7xfyZ4vS5WECNooPW5RHsWgoNmWq+2hMo=;
        b=FC96a8Jt867By47LPHSnv602OXYh1+2tD7k+Vqqy6gx0P6BeLouKDBbYI0Ubu/ALeBPwSe
        ofg019sZqzn6gQAQ==
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, bp <bp@alien8.de>,
        dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>,
        mingo <mingo@redhat.com>, juri lelli <juri.lelli@redhat.com>,
        vincent guittot <vincent.guittot@linaro.org>, mgorman@suse.de,
        Steven Rostedt <rostedt@goodmis.org>,
        jon grimm <jon.grimm@amd.com>, bharata@amd.com,
        raghavendra kt <raghavendra.kt@amd.com>,
        boris ostrovsky <boris.ostrovsky@oracle.com>,
        konrad wilk <konrad.wilk@oracle.com>, jgross <jgross@suse.com>,
        andrew cooper3 <andrew.cooper3@citrix.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        linux-alpha <linux-alpha@vger.kernel.org>
Subject: Re: Arches that don't support PREEMPT
In-Reply-To: <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
 <87y1h2ur98.ffs@tglx>
 <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
 <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
 <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
Date:   Tue, 19 Sep 2023 19:33:57 +0200
Message-ID: <87v8c6ukxm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 17:41, Anton Ivanov wrote:
> On 19/09/2023 17:22, Richard Weinberger wrote:
>> ----- Urspr=C3=BCngliche Mail -----
>>> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
>>> It's been a while. I remember that I dropped it at the time, but do not=
 remember
>>> the full details.
>>>
>>> There was some stuff related to FP state and a few other issues I ran i=
nto while
>>> rewriting the interrupt controller. Some of it may be resolved by now a=
s we are
>>> using host cpu flags, etc.
>>=20
>> I remember also having a hacky but working version almost 10 years ago.
>> It was horrible slow because of the extra scheduler rounds.

Which can be completely avoided as the proposed change will have the
preemption points, but they are only utilized when preempt FULL is
enabled (at boot or runtime). So the behaviour can still be like preempt
NONE, but with a twist to get rid of the cond_resched()/might_resched()
and other heuristic approaches to prevent starvation by long running
functions. That twist needs the preemption points.

See https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx

>> But yes, if PREEMPT will be a must-have feature we'll have to try again.
>
> We will need proper fpu primitives for starters that's for
> sure. fpu_star/end in UML are presently NOOP.
>
> Some of the default spinlocks and other stuff which we pick up from
> generic may need to change as well.
>
> This is off the top of my head and something which we can fix straight
> away. I will send some patches to the mailing list tomorrow or on Thu.

I think it does not have to be perfect. UM is far from perfect in
mimicing a real kernel. The main point is that it provides the preempt
counter in the first place and some minimal amount of preemption points
aside of those which come with the preempt_enable() machinery for free.

Thanks,

        tglx
