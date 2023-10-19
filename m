Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CE7CF31D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJSIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjJSIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:45:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668C210F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2OvDv6KjjjkV7XKCQZRcKD2cr4pcyB4jYdJMvx56mP8=; b=Xq6iV1680szqGtsstE6IYiRZCq
        T63TX8lnxdJJYSj/o54VFyj8ujUaE+DTJG5mP1gteshyxDppuT+4CIy3y7pMEOQdU18QU/+LXNc1C
        jwWBavyk/Ebl9lw1kv2/vrPJaF1bnzvJTfOysScOmFb0JcXDS0U+8pjeMlOkrwJQojmPdpTtqgaS9
        Lragrs853Ys0UVzseD1wUF2D9oWpo4jPU0ZjC53Uc/2iUqQMJgfOC4fsfrbPSy3kXu4svFfGsGn8x
        FimE5dMnFGPkyyYnN46rxsramsw6mQ0V1VVzkeczg5tp9lbeib/mAVVHHPt21bxt6mXd/Vp7LsVTw
        HVk+Xidw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtOeK-00648M-9p; Thu, 19 Oct 2023 08:45:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECD4C300392; Thu, 19 Oct 2023 10:44:59 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:44:59 +0200
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
Message-ID: <20231019084459.GP33217@noisy.programming.kicks-ass.net>
References: <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:40:05PM -0700, Linus Torvalds wrote:

> Side note: the code that caused that problem is this:
> 
>   __always_inline void __cyc2ns_read(struct cyc2ns_data *data)
>   {
>         int seq, idx;
> 
>         do {
>                 seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
>                 ...
>         } while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
>   }
> 
> where the issue is that the this_cpu_read() of that sequence number
> needs to be ordered.

I have very vague memories of other code also relying on this_cpu_read()
implying READ_ONCE().

And that code really only is buggy if you do not have that. Since it is
cpu local, the smp_rmb() would be confusing, as would smp_load_acquire()
be -- there is no cross-cpu data ordering.

The other option is of couse adding explicit barrier(), but that's
entirely superfluous when all the loads are READ_ONCE().


If you want to make this_cpu_read() not imply READ_ONCE(), then we
should go audit all users :/ Can be done ofc.
