Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774A3765A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjG0RlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjG0RlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DE03A30FB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:41:18 -0700 (PDT)
Received: (qmail 11188 invoked by uid 1000); 27 Jul 2023 13:41:18 -0400
Date:   Thu, 27 Jul 2023 13:41:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <af1eed90-a1d5-4da0-84a0-05e61767ab37@rowland.harvard.edu>
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck>
 <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
 <CAHk-=whGjpt77tUYRQA6TxiGERp_rSbcNhuKaWbvoJ6yXPwhhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGjpt77tUYRQA6TxiGERp_rSbcNhuKaWbvoJ6yXPwhhQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:11:29AM -0700, Linus Torvalds wrote:
> On Thu, 27 Jul 2023 at 08:44, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > This reads a little oddly, perhaps because it's a fragment from a larger
> > piece of code.
> 
> Yes. As Jann already said, this is basically a preparatory step in a
> much longer sequence, and the code simply wants to make sure that any
> later code (possibly quite a bit later) will not see a NULL value.

...

> Do we even have the same-location rule in the LKMM?

Yes.  The comment in the source file calls it "Sequential Consistency 
Per Variable", under the category of "Fundamental coherence ordering".  
It applies even to plain accesses, not just to READ_ONCE or stronger.

But in the presence of data races (as in the example that Will posted 
earlier), all bets are off.  So if you want to use a plain access rather 
than READ_ONCE, you need to be certain that it won't race with anything.

Alan Stern
