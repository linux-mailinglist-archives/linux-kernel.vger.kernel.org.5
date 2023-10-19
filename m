Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615837CF358
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjJSIzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjJSIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:54:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22CE10F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rBlcqozqb9PEqqWS5+27nL/e6vnrwo7p0Rz9TLGfws8=; b=QQaLURf7X9dzo6EYuq47jY3PSS
        rqMw+Xltl3zrtwNCUOa1mnELoQvSQ5h7JK+08foOa6nC0jisHy0lEAU+4+J6VgFFbGpsddAZP97Nu
        fZFMpG918bwkg5IfSu510rmS/X9kKo5ZDSi71lRD952SXJKQ5iCDnzpkxe75yGi5k5Pb6wjxMVgjH
        Kgs9k/tH5z+mfZrzQkVvD4cF+AjeCzEMX89RbwTFhJw7Y8E/WPxVJvJVlgW6JVkfGQ6FHzO5RoBcR
        JweOeREPZEQt0eDu6LZQ0OrT0UcIlJO9mfTcdI8MfMVE8XuEn7FaYoV06WeK7x0v2jXBBjwq580Q7
        odE6jlFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtOnY-009j1Y-2C;
        Thu, 19 Oct 2023 08:54:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59493300392; Thu, 19 Oct 2023 10:54:32 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:54:32 +0200
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
Message-ID: <20231019085432.GQ33217@noisy.programming.kicks-ass.net>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:40:05PM -0700, Linus Torvalds wrote:

> Look at the *REAL* sequence counter code in <linux/seqlock.h>. Notice
> how in raw_read_seqcount_begin() we have
> 
>         unsigned _seq = __read_seqcount_begin(s);
>         smp_rmb();
> 
> because it actually does the proper barriers. Notice how the garbage
> code in __cyc2ns_read() doesn't have them - and how it was buggy as a
> result.
> 
> (Also notice how this all predates our "we should use load_acquire()
> instead of smb_rmb()", but whatever).

seqlock actually wants rmb even today, the pattern is:

    do {
	seq = load-seq
	rmb
	load-data
	rmb
    } while (seq != re-load-seq)

we specifically only care about loads, and the data loads must be
between the sequence number loads.

As such, load-acquire is not a natural match.

