Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22CC7A2A43
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjIOWOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjIOWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:13:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E58B7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTcrc1WI4o6opPx+ch/98DWgJ1PnGcifLTiurtvgQxc=; b=lub14jPrTEx+0tuussJqRGSykT
        OboUeGnY5+kd6utFHiv5AFJY3QeT91ddyUKUO2LqRkLqEFNSMz387BC92Q2XzMLagLtWpDIVhCiWU
        ufL9qda9jDZ1Ea/6a1cmbCeYv73E4MIU0zqDx+2LhveuTxsM3SYuJnKe4bL1zjWLNy9SvDyUc/Yyp
        +rk3BESsqhGmiAvxndPrnALHUkgvUP5DhiWz2Q7yLEe0jRrnogCyj3glVbmEtJN1/MPDqH82fHdd/
        9YPq+34iQ9ZwXIwvJyjDXIsFrYkAh/E3F3g603e1Hs8catbWno1ywoAfaOLHy2eh0o7kqlz78/xJe
        lSBlD5IQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhH48-00CNVR-S8; Fri, 15 Sep 2023 22:13:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 871903003F2; Sat, 16 Sep 2023 00:13:32 +0200 (CEST)
Date:   Sat, 16 Sep 2023 00:13:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230915221332.GC23174@noisy.programming.kicks-ass.net>
References: <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
 <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 02:50:48PM -0700, Linus Torvalds wrote:
> On Fri, 15 Sept 2023 at 14:32, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > It also got me thinking about named_guard() for the myriad of
> > conditional locks we have.
> >
> >         named_guard(try_mutex, foo_guard)(&foo->lock);
> >         if (foo_guard) {
> >                 // we got the lock, do our thing
> >         }
> 
> Hmm. It looks ugly to me. I really hate the "named_guard" thing. One
> of the reasons I liked the guard/scoped_guard() macros was because how
> it created _anonymous_ guards, and made it completely unnecessary to
> make up a pointless name.

Yeah, the anonymous thing is very nice.

My ulterior motive for the above was perhaps extending it to allow the
lock argument to be NULL. Which would give us a handy conditional
pattern.

	struct rw_semaphore *exec_update_lock = task ?  &task->exec_update_lock : NULL;
	named_guard(rwsem_read_interruptible, exec_lock_guard)(exec_update_lock);
	if (task && !exec_lock_guard)
		return -EINTR;

And yes, that is definitely not pretty, but it does provide a fairly
wide array of options.

> If trylock ends up being a common pattern, I think we should strive to
> make it a lot easier to use.
> 
> Can we make it act like "scoped_guard()", except the lock function is
> fundamentally conditional?
> 
> Call it "cond_guard()", and make the syntax otherwise be the same as
> "scoped_guard()", iow, using a unique ID for the guard name.
> 
> So
> 
>         cond_guard(try_mutex)(&foo->lock) {
>                 .. this is the "we got the lock" region ..
>         }
> 
> would I think be a much better syntax.
> 
> Could we live with that?

For the trypical use-case that is definitely the more appealing syntax.

Something like:

  #define cond_guard(_name, args...) \
	  for (CLASS(_name, scope)(args), *done = NULL; \
	       !done && scope; done = (void *)1)
	     
works for the simple cases, but something like: try_spinlock_irqsave
would be a bit of a challenge because that would end up with one of
those structs that is not a pointer and they don't cast to a boolean :/

I think I can make it work, I'll go have a play, but perhaps not now,
it's past midnight ;-)
