Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9396D76568C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjG0O57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjG0O54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061EA0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45CB761EA2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7CC433C8;
        Thu, 27 Jul 2023 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690469874;
        bh=3qYlEqtxMD58VkVxR/PBqEwBgGSc0EGhT9TeKevi374=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qY0qn2J0FU/lOKX+NgKQtCeNuTWtVh2ltsS0IZsz4vQW9A6FnvLiq/yyW5u8umnwy
         +CGoMV7HMxnfO/d95G43xXAcU9fnVK8DIRxxjfaQ27fgoBgT2+YAe6rJmGmm6Lu9+7
         0s45pnWaArXDjC08aeYf7FJV5P48WBi6DkGJukykdhQHXrdKIOywlhtAB1DShVvAyl
         pWnEX1sumAZL2GNJ/ZDf5H/NXwW2VKMIki+dZJfJHCZXmlTzvTEYq5jNMjezdz+2Er
         qb7sq0DwWWnJe1qHXJWhprignPnWdYkE7m6BFS5XeVt5sXCxaPTj7M7JsBcCyiKUwl
         stPuijIOnmkNg==
Date:   Thu, 27 Jul 2023 15:57:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
Message-ID: <20230727145747.GB19940@willie-the-truck>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> On Thu, Jul 27, 2023 at 1:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jul 26, 2023 at 11:41:01PM +0200, Jann Horn wrote:
> > > Hi!
> > >
> > > Patch 1 here is a straightforward fix for a race in per-VMA locking code
> > > that can lead to use-after-free; I hope we can get this one into
> > > mainline and stable quickly.
> > >
> > > Patch 2 is a fix for what I believe is a longstanding memory ordering
> > > issue in how vma->anon_vma is used across the MM subsystem; I expect
> > > that this one will have to go through a few iterations of review and
> > > potentially rewrites, because memory ordering is tricky.
> > > (If someone else wants to take over patch 2, I would be very happy.)
> > >
> > > These patches don't really belong together all that much, I'm just
> > > sending them as a series because they'd otherwise conflict.
> > >
> > > I am CCing:
> > >
> > >  - Suren because patch 1 touches his code
> > >  - Matthew Wilcox because he is also currently working on per-VMA
> > >    locking stuff
> > >  - all the maintainers/reviewers for the Kernel Memory Consistency Model
> > >    so they can help figure out the READ_ONCE() vs smp_load_acquire()
> > >    thing
> >
> > READ_ONCE() has weaker ordering properties than smp_load_acquire().
> >
> > For example, given a pointer gp:
> >
> >         p = whichever(gp);
> >         a = 1;
> >         r1 = p->b;
> >         if ((uintptr_t)p & 0x1)
> >                 WRITE_ONCE(b, 1);
> >         WRITE_ONCE(c, 1);
> >
> > Leaving aside the "&" needed by smp_load_acquire(), if "whichever" is
> > "READ_ONCE", then the load from p->b and the WRITE_ONCE() to "b" are
> > ordered after the load from gp (the former due to an address dependency
> > and the latter due to a (fragile) control dependency).  The compiler
> > is within its rights to reorder the store to "a" to precede the load
> > from gp.  The compiler is forbidden from reordering the store to "c"
> > wtih the load from gp (because both are volatile accesses), but the CPU
> > is completely within its rights to do this reordering.
> >
> > But if "whichever" is "smp_load_acquire()", all four of the subsequent
> > memory accesses are ordered after the load from gp.
> >
> > Similarly, for WRITE_ONCE() and smp_store_release():
> >
> >         p = READ_ONCE(gp);
> >         r1 = READ_ONCE(gi);
> >         r2 = READ_ONCE(gj);
> >         a = 1;
> >         WRITE_ONCE(b, 1);
> >         if (r1 & 0x1)
> >                 whichever(p->q, r2);
> >
> > Again leaving aside the "&" needed by smp_store_release(), if "whichever"
> > is WRITE_ONCE(), then the load from gp, the load from gi, and the load
> > from gj are all ordered before the store to p->q (by address dependency,
> > control dependency, and data dependency, respectively).  The store to "a"
> > can be reordered with the store to p->q by the compiler.  The store to
> > "b" cannot be reordered with the store to p->q by the compiler (again,
> > both are volatile), but the CPU is free to reorder them, especially when
> > whichever() is implemented as a conditional store.
> >
> > But if "whichever" is "smp_store_release()", all five of the earlier
> > memory accesses are ordered before the store to p->q.
> >
> > Does that help, or am I missing the point of your question?
> 
> My main question is how permissible/ugly you think the following use
> of READ_ONCE() would be, and whether you think it ought to be an
> smp_load_acquire() instead.
> 
> Assume that we are holding some kind of lock that ensures that the
> only possible concurrent update to "vma->anon_vma" is that it changes
> from a NULL pointer to a non-NULL pointer (using smp_store_release()).
> 
> 
> if (READ_ONCE(vma->anon_vma) != NULL) {
>   // we now know that vma->anon_vma cannot change anymore
> 
>   // access the same memory location again with a plain load
>   struct anon_vma *a = vma->anon_vma;
> 
>   // this needs to be address-dependency-ordered against one of
>   // the loads from vma->anon_vma
>   struct anon_vma *root = a->root;
> }
> 
> 
> Is this fine? If it is not fine just because the compiler might
> reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> would it be fine after adding a barrier() directly after the
> READ_ONCE()?

I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable,
as I've run into cases where you have sequences such as:

	// Assume *ptr is initially 0 and somebody else writes it to 1
	// concurrently

	foo = *ptr;
	bar = READ_ONCE(*ptr);
	baz = *ptr;

and you can get foo == baz == 0 but bar == 1 because the compiler only
ends up reading from memory twice.

That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
when dereferencing pointer to pte table"), which was very unpleasant to
debug.

Will
