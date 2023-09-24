Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB027AC790
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIXK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjIXK3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:29:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6A39B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/3akVz7429yUkO74jWnqSj0RP1sGbx4CbguPmd6QR70=; b=YFSyx6fR2RkEKaCzXGxU3s8hJi
        jo97uZO7CJBoAMZsYTEwrHWKB6UKHknoW8qNrYwtqnuHe6MZ6HE7UYLpP+kAaea/P4AwH7f0vdnyZ
        LhqrbgzhX43Ef/2v74a7CXWgWjFDF4gr2gzrRdBU/y1MRIeFxFPfpGg/6cKsRgOcImkCIkMTqi/La
        De6QZ9ZfYuYfqYbL97Qa0akIxqu0+HdFxZDZ2y0cYCKxu9z2NPDPsGL6TKLzywMp4SIoUK3G7j9ez
        qDGUco0haDrlv3IcQB4R0DDXiiINXiNzh5nHPDUWueRPtY05wSqgr91EKF6onMlXpDQcW2Uclkt2n
        9nE6YiyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkMMH-00CRQV-DX; Sun, 24 Sep 2023 10:29:01 +0000
Date:   Sun, 24 Sep 2023 11:29:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZRAPbXk4N2dntgyA@casper.infradead.org>
References: <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <87h6nkh5bw.ffs@tglx>
 <ZQ/i6CC86PzaYCzw@casper.infradead.org>
 <878r8wgg3b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r8wgg3b.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 09:55:52AM +0200, Thomas Gleixner wrote:
> On Sun, Sep 24 2023 at 08:19, Matthew Wilcox wrote:
> > On Sun, Sep 24, 2023 at 12:50:43AM +0200, Thomas Gleixner wrote:
> >> cond_resched() cannot nest and is obviously scope-less.
> >> 
> >> The TIF_ALLOW_RESCHED mechanism, which sparked this discussion only
> >> pretends to be scoped.
> >> 
> >> As Peter pointed out it does not properly nest with other mechanisms and
> >> it cannot even nest in itself because it is boolean.
> >
> > We can nest a single bit without turning it into a counter -- we
> > do this for memalloc_nofs_save() for example.  Simply return the
> > current value of the bit, and pass it to _restore().
> 
> Right.
> 
> That works, but the reverse logic still does not make sense:
> 
>         allow_resched();
>         ....
>         spin_lock();
> 
> while
>         resched_now_is_suboptimal();
>         ...
>         spin_lock();
> 
> works.

Oh, indeed.  I had in mind

	state = resched_now_is_suboptimal();
	spin_lock();
	...
	spin_unlock();
	resched_might_be_optimal_again(state);

... or we could bundle it up ...

	state = spin_lock_resched_disable();
	...
	spin_unlock_resched_restore(state);

