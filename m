Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B907A6ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjISScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:31:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE05997;
        Tue, 19 Sep 2023 11:31:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695148311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKyOmmSSJD2Ws4VR+XqPS/XNP5VPNOwNw6yDdf2ZDQU=;
        b=xXqJqYUZla9VpgC4S4ShTGkMIL3gkkhNvGjlWhi5L1gkuz5icUdocjTZfEjeUV9x1XfF1d
        9gCf9onnbE0u4V9GNNs47U9xjPBMw2DWytTSoQsodttKIzqkL+7HlaYEWW4FSVqwFkxP9b
        m3N7cld1jgwk+v3jf2F2vowyOYzbp0oeTYfBdyMg3skppXJK7mZs9rhgY8B0yUaEjzj5rv
        eNPjV+ty7EkQisVX1wCgp5HdgxQTcki84SeKDSqMlKMRQ4Dwk5yJNMqTIIkjzdPuUEmZXw
        ZLXZiD6XCNIDxdM95XJgYydUDvKFSGuDWDp3q+ZqWzDj1uSibW0RuXplJpLfmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695148311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKyOmmSSJD2Ws4VR+XqPS/XNP5VPNOwNw6yDdf2ZDQU=;
        b=HSw+FE/2ECBsn8P+jBW//lrHd8c9W9Bxp5rJpQcF0U/qlJOFxqfRtQIDeqJGdvK2cG7ELT
        v2DdyOFXFBXeLSDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
In-Reply-To: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Date:   Tue, 19 Sep 2023 20:31:50 +0200
Message-ID: <87pm2eui95.ffs@tglx>
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

On Tue, Sep 19 2023 at 10:25, Linus Torvalds wrote:
> On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>>
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
>
> It can definitely be problematic.
>
> Not the Kconfig file part, and not the preempt count part itself.
>
> But the fact that it has never been used and tested means that there
> might be tons of "this architecture code knows it's not preemptible,
> because this architecture doesn't support preemption".
>
> So you may have basic architecture code that simply doesn't have the
> "preempt_disable()/enable()" pairs that it needs.
>
> PeterZ mentioned the generic entry code, which does this for the entry
> path. But it actually goes much deeper: just do a
>
>     git grep preempt_disable arch/x86/kernel
>
> and then do the same for some other architectures.
>
> Looking at alpha, for example, there *are* hits for it, so at least
> some of the code there clearly *tries* to do it. But does it cover all
> the required parts? If it's never been tested, I'd be surprised if
> it's all just ready to go.
>
> I do think we'd need to basically continue to support ARCH_NO_PREEMPT
> - and such architectures migth end up with the worst-cast latencies of
> only scheduling at return to user space.

The only thing these architectures should gain is the preempt counter
itself, but yes the extra preemption points are not mandatory to
have, i.e. we simply do not enable them for the nostalgia club.

The removal of cond_resched() might cause latencies, but then I doubt
that these museus pieces are used for real work :)

Thanks,

        tglx
