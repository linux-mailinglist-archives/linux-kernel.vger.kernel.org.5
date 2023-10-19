Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51A7D0137
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbjJSSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjJSSOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:14:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE2124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TXsCKxfdxmoEXSGuHkDPpPh+eCleK5x9qBmZaUqjdHg=; b=je69cUvsmCeF22HS0i5OMiM/89
        WdGt5UgdNtN2ipMqDbfE5DKyAj+gTCvEI9LIJTlKKL3Dov63iUFjr/jZhgpBBOA4Kfx40dQ0FaRND
        EEKsENUSpijO1hAxSTlFBkreZGUQPeLVBdJbL7jIecFFo/CIFJLgJemgnCLtX1NwX1fjV+3lGWnnd
        LyOCwuO7C9A/aLp0ENKvj841m27ST0zfZjkHH/QmEn07XKbCdYwaWRRSVmvkqHOnjLw2hNENfFwY+
        vYzjrd9+JtQXvGNbq1+oNtdRoYnx5BBlT+GMus0/cjyPSUAhADDqtyo1KepcY82jY89+oanwMHaEF
        ESyf9Ocw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtXWy-008UjP-Ky; Thu, 19 Oct 2023 18:14:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10AF5300392; Thu, 19 Oct 2023 20:14:00 +0200 (CEST)
Date:   Thu, 19 Oct 2023 20:13:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Message-ID: <20231019181359.GA35308@noisy.programming.kicks-ass.net>
References: <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <20231019085432.GQ33217@noisy.programming.kicks-ass.net>
 <CAHk-=wg98L2qaw1U-7NDFQi6dOK=CRO6H-1q1LXuEh348Dk=2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg98L2qaw1U-7NDFQi6dOK=CRO6H-1q1LXuEh348Dk=2Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:04:56AM -0700, Linus Torvalds wrote:

> So if you do
> 
>         seq = load_acquire(orig_seq);
>         load-data
> 
> then that acquire actually makes that first 'rmb' pointless. Acquire
> already guarantees that all subsequent memory operations are ordered
> wrt that read.
> 
> And 'acquire' is likely faster than 'rmb' on sane modern architectures.
> 
> On x86 it doesn't matter (rmb is a no-op, and all loads are acquires).
> 
> But on arm64, for example, you can do a 'ld.acq' in one instruction
> and you're done - while a rmb then ends up being a barrier (ok, the
> asm mnemonics are horrible: it's not "ld.acq", it's "ldar", but
> whatever - I like arm64 as an architecture, but I think they made the
> standard assembly syntax pointlessly and actively hostile to humans).
> 
> Of course then microarchitectures may end up doing basically the same
> thing, but at least technically the 'load acquire' is likely more
> targeted and more optimized.

Sure, acquire should work fine here.

> The second rmb is then harder to change, and that is going to stay an
> rmb ( you could say "do an acquire on the last data load, but that
> doesn't fit the sane locking semantics of a sequence lock).

Wouldn't even work, acquire allows an earlier load to pass it. It only
constraints later loads to not happen before.

> Of course, then the percpu case doesn't care about the SMP ordering,
> but it should still use an UP barrier to make sure things don't get
> re-ordered. Relying on our "percpu_read()" ordering other reads around
> it is *wrong*.

I'm happy to put barrier() in there if it makes you feel better.

But are you really saying this_cpu_read() should not imply READ_ONCE()?

If so, we should probably go audit a ton of code :/
