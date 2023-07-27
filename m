Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D77656FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjG0PIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjG0PIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:08:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08DE47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oNHK2MbbJ6j1a4TfO0kZ5fTh+NDwsDl1r4u8RwZS2vw=; b=vZOntyDsid8d/Ee8U4oTNIWUM1
        qsAeBSbwte9KQNffQQN/iam3+iftr7Cp3gBnWSnZi4KsFsbEQ2+1UoVQV0WL/cEhtLcpLPz00ZYLw
        G3yoWRFdrF8SNl2e4fq6a6ooSY3bbpJqTukS9pBo1DJ8wtH+7OaBn6cpG6zokRUtXwZoK0WP50w98
        qP1b7tK+3Y9D98NbI/davY8tTF11caaPgW4bjd7gjHof7tiHwqJSb+mKCfCRubAqzS/u8skVPC7cH
        Cw0PZcY+VJ78Tb9nk6/qI8PUrwsPzWZVOuXZpNZv686Ne8+SZxCJospPNuuhQfBw9eJT/U9sfulOM
        b71xg4Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qP2aS-007a4H-Uu; Thu, 27 Jul 2023 15:07:33 +0000
Date:   Thu, 27 Jul 2023 16:07:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
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
Message-ID: <ZMKINJ9+WX1WWG8g@casper.infradead.org>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
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
> 
> I initially suggested using READ_ONCE() for this, and then Linus and
> me tried to reason it out and Linus suggested (if I understood him
> correctly) that you could make the ugly argument that this works
> because loads from the same location will not be reordered by the
> hardware. So on anything other than alpha, we'd still have the
> required address-dependency ordering because that happens for all
> loads, even plain loads, while on alpha, the READ_ONCE() includes a
> memory barrier. But that argument is weirdly reliant on
> architecture-specific implementation details.
> 
> The other option is to replace the READ_ONCE() with a
> smp_load_acquire(), at which point it becomes a lot simpler to show
> that the code is correct.

Aren't we straining at gnats here?  The context of this is handling a
page fault, and we used to take an entire rwsem for read.  I'm having
a hard time caring about "the extra expense" of an unnecessarily broad
barrier.

Cost of an L3 cacheline miss is in the thousands of cycles.  Cost of a
barrier is ... tens?
