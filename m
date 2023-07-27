Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1F7657F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjG0PoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjG0PoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:44:04 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 509152122
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:44:03 -0700 (PDT)
Received: (qmail 1994132 invoked by uid 1000); 27 Jul 2023 11:44:02 -0400
Date:   Thu, 27 Jul 2023 11:44:02 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Will Deacon <will@kernel.org>
Cc:     Jann Horn <jannh@google.com>, paulmck@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Message-ID: <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727145747.GB19940@willie-the-truck>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:57:47PM +0100, Will Deacon wrote:
> On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:

> > Assume that we are holding some kind of lock that ensures that the
> > only possible concurrent update to "vma->anon_vma" is that it changes
> > from a NULL pointer to a non-NULL pointer (using smp_store_release()).
> > 
> > 
> > if (READ_ONCE(vma->anon_vma) != NULL) {
> >   // we now know that vma->anon_vma cannot change anymore
> > 
> >   // access the same memory location again with a plain load
> >   struct anon_vma *a = vma->anon_vma;
> > 
> >   // this needs to be address-dependency-ordered against one of
> >   // the loads from vma->anon_vma
> >   struct anon_vma *root = a->root;
> > }

This reads a little oddly, perhaps because it's a fragment from a larger 
piece of code.  Still, if I were doing something like this, I'd write it 
as:

struct anon_vma *a;

a = READ_ONCE(vma->anon_vma);
if (a != NULL) {
	struct anon_vma *root = a->root;
	...

thus eliminating the possibility of confusion from multiple reads of the 
same address.

In this situation, the ordering of the two reads is guaranteed by the 
address dependency.  And people shouldn't worry too much about using 
that sort of ordering; RCU relies on it critically, all the time.

> > Is this fine? If it is not fine just because the compiler might
> > reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> > would it be fine after adding a barrier() directly after the
> > READ_ONCE()?
> 
> I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable,
> as I've run into cases where you have sequences such as:
> 
> 	// Assume *ptr is initially 0 and somebody else writes it to 1
> 	// concurrently
> 
> 	foo = *ptr;
> 	bar = READ_ONCE(*ptr);
> 	baz = *ptr;
> 
> and you can get foo == baz == 0 but bar == 1 because the compiler only
> ends up reading from memory twice.
> 
> That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> when dereferencing pointer to pte table"), which was very unpleasant to
> debug.

Indeed, that's the sort of thing that can happen when plain accesses are 
involved in a race.

Alan Stern
