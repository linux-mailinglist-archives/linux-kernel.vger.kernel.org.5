Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF19764278
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGZXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGZXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44298110
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76A461BAF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBE5C433C8;
        Wed, 26 Jul 2023 23:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690413541;
        bh=OyzZD5MHFQ71H/7riF0ScWcazkzij12xVCuT2YfRhl0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KwAO6H00AZupIs+wOw57k4SWypFeb4kiLtPomsQBCR8dp2v6ehfiCEWYqQdg/AmH6
         49ifx71i+yGverkc41Ppyyv5imfJi8Zkw2Fhb3HvQLCCnpGY+4UpVHVcFFznJN2c7C
         TAgQSvYPhzj9kqdOxU8fdIZ/mhFQOtg67ZUqps9sPzuINfheocfcUJtmbV/0D5X5TZ
         XH9jGEBN7S4PQwd92OEINDKEwHleXv4DjNcwtCUxlNNeCPLC9PMBShRzAZICGk/cWg
         wU2GB+/5u3jo1MYNyKjCkjBedi58jSpdiHR6Mx7u/g17kPzgr1KMVLsMaFrg+5JCG5
         VcL9Hwff2A0/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5E83CE0AD7; Wed, 26 Jul 2023 16:19:00 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:19:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726214103.3261108-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726214103.3261108-1-jannh@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:41:01PM +0200, Jann Horn wrote:
> Hi!
> 
> Patch 1 here is a straightforward fix for a race in per-VMA locking code
> that can lead to use-after-free; I hope we can get this one into
> mainline and stable quickly.
> 
> Patch 2 is a fix for what I believe is a longstanding memory ordering
> issue in how vma->anon_vma is used across the MM subsystem; I expect
> that this one will have to go through a few iterations of review and
> potentially rewrites, because memory ordering is tricky.
> (If someone else wants to take over patch 2, I would be very happy.)
> 
> These patches don't really belong together all that much, I'm just
> sending them as a series because they'd otherwise conflict.
> 
> I am CCing:
> 
>  - Suren because patch 1 touches his code
>  - Matthew Wilcox because he is also currently working on per-VMA
>    locking stuff
>  - all the maintainers/reviewers for the Kernel Memory Consistency Model
>    so they can help figure out the READ_ONCE() vs smp_load_acquire()
>    thing

READ_ONCE() has weaker ordering properties than smp_load_acquire().

For example, given a pointer gp:

	p = whichever(gp);
	a = 1;
	r1 = p->b;
	if ((uintptr_t)p & 0x1)
		WRITE_ONCE(b, 1);
	WRITE_ONCE(c, 1);

Leaving aside the "&" needed by smp_load_acquire(), if "whichever" is
"READ_ONCE", then the load from p->b and the WRITE_ONCE() to "b" are
ordered after the load from gp (the former due to an address dependency
and the latter due to a (fragile) control dependency).  The compiler
is within its rights to reorder the store to "a" to precede the load
from gp.  The compiler is forbidden from reordering the store to "c"
wtih the load from gp (because both are volatile accesses), but the CPU
is completely within its rights to do this reordering.

But if "whichever" is "smp_load_acquire()", all four of the subsequent
memory accesses are ordered after the load from gp.

Similarly, for WRITE_ONCE() and smp_store_release():

	p = READ_ONCE(gp);
	r1 = READ_ONCE(gi);
	r2 = READ_ONCE(gj);
	a = 1;
	WRITE_ONCE(b, 1);
	if (r1 & 0x1)
		whichever(p->q, r2);

Again leaving aside the "&" needed by smp_store_release(), if "whichever"
is WRITE_ONCE(), then the load from gp, the load from gi, and the load
from gj are all ordered before the store to p->q (by address dependency,
control dependency, and data dependency, respectively).  The store to "a"
can be reordered with the store to p->q by the compiler.  The store to
"b" cannot be reordered with the store to p->q by the compiler (again,
both are volatile), but the CPU is free to reorder them, especially when
whichever() is implemented as a conditional store.

But if "whichever" is "smp_store_release()", all five of the earlier
memory accesses are ordered before the store to p->q.

Does that help, or am I missing the point of your question?

							Thanx, Paul

>  - people involved in the previous discussion on the security list
> 
> 
> Jann Horn (2):
>   mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock
>   mm: Fix anon_vma memory ordering
> 
>  include/linux/rmap.h | 15 ++++++++++++++-
>  mm/huge_memory.c     |  4 +++-
>  mm/khugepaged.c      |  2 +-
>  mm/ksm.c             | 16 +++++++++++-----
>  mm/memory.c          | 32 ++++++++++++++++++++------------
>  mm/mmap.c            | 13 ++++++++++---
>  mm/rmap.c            |  6 ++++--
>  mm/swapfile.c        |  3 ++-
>  8 files changed, 65 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
