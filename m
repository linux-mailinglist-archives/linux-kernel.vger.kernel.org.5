Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDBB7673E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjG1Rv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjG1Rvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:51:41 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 99C2235BF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:51:38 -0700 (PDT)
Received: (qmail 45940 invoked by uid 1000); 28 Jul 2023 13:51:37 -0400
Date:   Fri, 28 Jul 2023 13:51:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
Message-ID: <9fd99405-a3ff-4ab7-b6b7-e74849f1d334@rowland.harvard.edu>
References: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org>
 <20230728124412.GA21303@willie-the-truck>
 <CAEXW_YRtUd4jUP68jzMgDgWxAy8tdJQortK07TZgCxVLNAgaNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRtUd4jUP68jzMgDgWxAy8tdJQortK07TZgCxVLNAgaNA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:35:43PM -0400, Joel Fernandes wrote:
> On Fri, Jul 28, 2023 at 8:44 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jul 27, 2023 at 12:34:44PM -0400, Joel Fernandes wrote:
> > > > On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote:
> > > > ﻿On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> > > >> if (READ_ONCE(vma->anon_vma) != NULL) {
> > > >>  // we now know that vma->anon_vma cannot change anymore
> > > >>
> > > >>  // access the same memory location again with a plain load
> > > >>  struct anon_vma *a = vma->anon_vma;
> > > >>
> > > >>  // this needs to be address-dependency-ordered against one of
> > > >>  // the loads from vma->anon_vma
> > > >>  struct anon_vma *root = a->root;
> > > >> }
> > > >>
> > > >>
> > > >> Is this fine? If it is not fine just because the compiler might
> > > >> reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> > > >> would it be fine after adding a barrier() directly after the
> > > >> READ_ONCE()?
> > > >
> > > > I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable,
> > > > as I've run into cases where you have sequences such as:
> > > >
> > > >    // Assume *ptr is initially 0 and somebody else writes it to 1
> > > >    // concurrently
> > > >
> > > >    foo = *ptr;
> > > >    bar = READ_ONCE(*ptr);
> > > >    baz = *ptr;
> > > >
> > > > and you can get foo == baz == 0 but bar == 1 because the compiler only
> > > > ends up reading from memory twice.
> > > >
> > > > That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> > > > when dereferencing pointer to pte table"), which was very unpleasant to
> > > > debug.
> > >
> > > Will, Unless I am missing something fundamental, this case is different though.
> > > This case does not care about fewer reads. As long as the first read is volatile, the subsequent loads (even plain)
> > > should work fine, no?
> > > I am not seeing how the compiler can screw that up, so please do enlighten :).
> >
> > I guess the thing I'm worried about is if there is some previous read of
> > 'vma->anon_vma' which didn't use READ_ONCE() and the compiler kept the
> > result around in a register. In that case, 'a' could be NULL, even if
> > the READ_ONCE(vma->anon_vma) returned non-NULL.
> 
> If I can be a bit brave enough to say -- that appears to be a compiler
> bug to me. It seems that the compiler in such an instance violates the
> "Sequential Consistency Per Variable" rule? I mean if it can't even
> keep SCPV true for a same memory-location load (plain or not) for a
> sequence of code, how can it expect the hardware to.

It's not a compiler bug.  In this example, some other thread performs a 
write that changes vma->anon_vma from NULL to non-NULL.  This write 
races with the plain reads, and compilers are not required to obey the 
"Sequential Consistency Per Variable" rule (or indeed, any rule) when 
there is a data race.

Alan Stern
