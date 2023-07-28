Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC26F76745B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjG1SS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjG1SSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:18:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A093C1F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 252DA621CF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A71BC433C7;
        Fri, 28 Jul 2023 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690568303;
        bh=xS3JH0ac4EOyWddaobfJi6wjfpgQcUOBaFzhfO9ijNM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uoKmSpJAM7WBqZwGvJ5UKdxWqkplEHHF10EqOUebYlT33zKsGvrkUN+FJxnBhwVIB
         gid1Zh8gd6vhJ3zyV7hZyJrf9PKGOEy3Cf2CdILd2svD727hN0iP6kxUWtEHgTzX0l
         hgBgjoQpdxN6/D7D5EiexQwUMTbraQFoYZse6bSs6EvPZzfp76zNIKz3iZt5xSkQ1z
         MvZK4CJw8kSFTh0lUEPgVOfa+zej+JgCXMI+KpQ3I+E9dVbGi6DouFIN8zVjrY1aV6
         cUJHSOPxohUTcqBmhIaElpBlDodClnhw9QE08WeMZZWdnee8+UF+7CukZW/iDfdc0Q
         GykyDSaHTMc5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1ABBCE0B66; Fri, 28 Jul 2023 11:18:22 -0700 (PDT)
Date:   Fri, 28 Jul 2023 11:18:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
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
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
Message-ID: <ca3706a4-3153-449e-bef0-56183a668d57@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <BCDEA397-AA7A-4FDE-8046-C68625CDE166@joelfernandes.org>
 <20230728124412.GA21303@willie-the-truck>
 <CAEXW_YRtUd4jUP68jzMgDgWxAy8tdJQortK07TZgCxVLNAgaNA@mail.gmail.com>
 <9fd99405-a3ff-4ab7-b6b7-e74849f1d334@rowland.harvard.edu>
 <CAEXW_YS-axyXvX4-aMc9a2EWY59KAyHvirMewVuoNGOGSh35Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YS-axyXvX4-aMc9a2EWY59KAyHvirMewVuoNGOGSh35Vw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:03:09PM -0400, Joel Fernandes wrote:
> On Fri, Jul 28, 2023 at 1:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Jul 28, 2023 at 01:35:43PM -0400, Joel Fernandes wrote:
> > > On Fri, Jul 28, 2023 at 8:44 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 12:34:44PM -0400, Joel Fernandes wrote:
> > > > > > On Jul 27, 2023, at 10:57 AM, Will Deacon <will@kernel.org> wrote:
> > > > > > ﻿On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> > > > > >> if (READ_ONCE(vma->anon_vma) != NULL) {
> > > > > >>  // we now know that vma->anon_vma cannot change anymore
> > > > > >>
> > > > > >>  // access the same memory location again with a plain load
> > > > > >>  struct anon_vma *a = vma->anon_vma;
> > > > > >>
> > > > > >>  // this needs to be address-dependency-ordered against one of
> > > > > >>  // the loads from vma->anon_vma
> > > > > >>  struct anon_vma *root = a->root;
> > > > > >> }
> > > > > >>
> > > > > >>
> > > > > >> Is this fine? If it is not fine just because the compiler might
> > > > > >> reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> > > > > >> would it be fine after adding a barrier() directly after the
> > > > > >> READ_ONCE()?
> > > > > >
> > > > > > I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable,
> > > > > > as I've run into cases where you have sequences such as:
> > > > > >
> > > > > >    // Assume *ptr is initially 0 and somebody else writes it to 1
> > > > > >    // concurrently
> > > > > >
> > > > > >    foo = *ptr;
> > > > > >    bar = READ_ONCE(*ptr);
> > > > > >    baz = *ptr;
> > > > > >
> > > > > > and you can get foo == baz == 0 but bar == 1 because the compiler only
> > > > > > ends up reading from memory twice.
> > > > > >
> > > > > > That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> > > > > > when dereferencing pointer to pte table"), which was very unpleasant to
> > > > > > debug.
> > > > >
> > > > > Will, Unless I am missing something fundamental, this case is different though.
> > > > > This case does not care about fewer reads. As long as the first read is volatile, the subsequent loads (even plain)
> > > > > should work fine, no?
> > > > > I am not seeing how the compiler can screw that up, so please do enlighten :).
> > > >
> > > > I guess the thing I'm worried about is if there is some previous read of
> > > > 'vma->anon_vma' which didn't use READ_ONCE() and the compiler kept the
> > > > result around in a register. In that case, 'a' could be NULL, even if
> > > > the READ_ONCE(vma->anon_vma) returned non-NULL.
> > >
> > > If I can be a bit brave enough to say -- that appears to be a compiler
> > > bug to me. It seems that the compiler in such an instance violates the
> > > "Sequential Consistency Per Variable" rule? I mean if it can't even
> > > keep SCPV true for a same memory-location load (plain or not) for a
> > > sequence of code, how can it expect the hardware to.
> >
> > It's not a compiler bug.  In this example, some other thread performs a
> > write that changes vma->anon_vma from NULL to non-NULL.  This write
> > races with the plain reads, and compilers are not required to obey the
> > "Sequential Consistency Per Variable" rule (or indeed, any rule) when
> > there is a data race.
> 
> So you're saying the following code behavior is OK?
> 
> /* Say anon_vma can only ever transition from NULL to non-NULL values */
> a = vma->anon_vma;  // Reads NULL
> b = READ_ONCE(vma->anon_vma); // Reads non-NULL
> c = vma->anon_vma;  // Reads NULL!!!
> if (b) {
>   c->some_attribute++; // Oopsie
> }

Is there some way to obtain (a && !b) that does not involve a data race,
and they carte blanche for the compiler to do whatever it pleases?
I am not seeing one.

What am I missing?

							Thanx, Paul
