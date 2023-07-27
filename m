Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BAD765866
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjG0QQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjG0QQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16392728
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46EBD61EC6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E7BC433C7;
        Thu, 27 Jul 2023 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474608;
        bh=5PFG1z3pRVnypkDZVwniaTTH6jGfFJ0ZkRrga6GBt08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PtppGcCLFWUUf/6l3hEDtuAkOADoiNfKlY62WB1ZnNOvywfUUG5BZJnncsG79USvK
         UUGrzGYRRaN1pNqGFXRhvmnLIWHMTxTUi9qpKP/y1k4MDU4E41d/BKeS1qVL3qbj0i
         BPbIIxdIFir6zajtxBo7tNR5xLZwW89ei5AWiLw25I3UyW8RCcWyHOVu1bzThYPaoM
         N4uVtmnoGAawjdLIb/+cCm1ajwCHGw3ZIu9qUMXrVCaakKb1q1cgxt4jzjZYIFgAgs
         WH4AuqlD2gz8UVv4kXhbzcA3O23JW35MwXfnJY5IKtOx+ATVT8wF1KTUEWQofBocGa
         Pt3q8sSKAVGOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 48A5DCE0B66; Thu, 27 Jul 2023 09:16:48 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:16:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
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
Message-ID: <d25defcf-1f78-4099-a1c6-10fc24799621@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
 <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:44:02AM -0400, Alan Stern wrote:
> On Thu, Jul 27, 2023 at 03:57:47PM +0100, Will Deacon wrote:
> > On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> 
> > > Assume that we are holding some kind of lock that ensures that the
> > > only possible concurrent update to "vma->anon_vma" is that it changes
> > > from a NULL pointer to a non-NULL pointer (using smp_store_release()).
> > > 
> > > 
> > > if (READ_ONCE(vma->anon_vma) != NULL) {
> > >   // we now know that vma->anon_vma cannot change anymore
> > > 
> > >   // access the same memory location again with a plain load
> > >   struct anon_vma *a = vma->anon_vma;
> > > 
> > >   // this needs to be address-dependency-ordered against one of
> > >   // the loads from vma->anon_vma
> > >   struct anon_vma *root = a->root;
> > > }
> 
> This reads a little oddly, perhaps because it's a fragment from a larger 
> piece of code.  Still, if I were doing something like this, I'd write it 
> as:
> 
> struct anon_vma *a;
> 
> a = READ_ONCE(vma->anon_vma);
> if (a != NULL) {
> 	struct anon_vma *root = a->root;
> 	...
> 
> thus eliminating the possibility of confusion from multiple reads of the 
> same address.
> 
> In this situation, the ordering of the two reads is guaranteed by the 
> address dependency.  And people shouldn't worry too much about using 
> that sort of ordering; RCU relies on it critically, all the time.

Agreed.  In contrast, control dependencies require quite a bit more care
and feeding, and are usually best avoided.

But even with the normal RCU address/data dependencies, it is possible
to get in trouble.  For but one example, comparing a pointer obtained
from rcu_dereference() to the address of a static structure is a good
way to break your address dependency.  (Just yesterday evening I talked
to someone who had spent quite a bit of time chasing one of these down,
so yes, this is quite real.)

> > > Is this fine? If it is not fine just because the compiler might
> > > reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> > > would it be fine after adding a barrier() directly after the
> > > READ_ONCE()?
> > 
> > I'm _very_ wary of mixing READ_ONCE() and plain loads to the same variable,
> > as I've run into cases where you have sequences such as:
> > 
> > 	// Assume *ptr is initially 0 and somebody else writes it to 1
> > 	// concurrently
> > 
> > 	foo = *ptr;
> > 	bar = READ_ONCE(*ptr);
> > 	baz = *ptr;
> > 
> > and you can get foo == baz == 0 but bar == 1 because the compiler only
> > ends up reading from memory twice.
> > 
> > That was the root cause behind f069faba6887 ("arm64: mm: Use READ_ONCE
> > when dereferencing pointer to pte table"), which was very unpleasant to
> > debug.
> 
> Indeed, that's the sort of thing that can happen when plain accesses are 
> involved in a race.

Agreed.  Furthermore, it is more important to comment plain C-language
accesses to shared variables than to comment the likes of READ_ONCE().
"OK, tell me again exactly why you think the compiler cannot mess you
up here?"

							Thanx, Paul
