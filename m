Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE778220D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjHUD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjHUD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:58:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B38E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 20:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CGxdXSBzJWwWURY8ZP4wMj116bZ6iqKmFjUPQ49ecdc=; b=WMEplBHXTiLDJzjGH2iUVo8B68
        0O85ITVzV8qv9LTrWCJsuU9eDYguuJ1kVNabXeAHn4rZibgcQWCnXaS9xeBJRAxdxadEz8bUFaBYT
        /xiJkoUWV9t2VaSEiVvGKzSczS1MRlYUPxJFPY1B2IHZVr69q4S3qKpmaurO/aYHE0j9GOJ2NCh0f
        efTk5KQYLLsfpalDH2BJZ3B6zoCGQwQ7E5Kmy/HZrEuIR8YTVJgtO+MxGo3ymm6oW4Wjefdm3dYEC
        SGyBGxYmvvc1WoZFyPYSn5CtflFaLXxmLnk2Dw+nz1t7cmd/JSYV4mCuUzuIL7Ei6j7Plel4OLhmr
        Tne/Ox/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXw3W-007z4Y-Nm; Mon, 21 Aug 2023 03:58:18 +0000
Date:   Mon, 21 Aug 2023 04:58:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in
 get_mmap_lock_carefully
Message-ID: <ZOLg2kmvKb4eGDrt@casper.infradead.org>
References: <20230820104303.2083444-1-mjguzik@gmail.com>
 <ZOJXgFJybD1ljCHL@casper.infradead.org>
 <20230821011303.hoeqjbmjaxajh255@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821011303.hoeqjbmjaxajh255@f>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:13:03AM +0200, Mateusz Guzik wrote:
> On Sun, Aug 20, 2023 at 07:12:16PM +0100, Matthew Wilcox wrote:
> > On Sun, Aug 20, 2023 at 12:43:03PM +0200, Mateusz Guzik wrote:
> > > Found by checking off-CPU time during kernel build (like so:
> > > "offcputime-bpfcc -Ku"), sample backtrace:
> > >     finish_task_switch.isra.0
> > >     __schedule
> > >     __cond_resched
> > >     lock_mm_and_find_vma
> > >     do_user_addr_fault
> > >     exc_page_fault
> > >     asm_exc_page_fault
> > >     -                sh (4502)
> > 
> > Now I'm awake, this backtrace really surprises me.  Do we not check
> > need_resched on entry?  It seems terribly unlikely that need_resched
> > gets set between entry and getting to this point, so I guess we must
> > not.
> > 
> > I suggest the version of the patch which puts might_sleep() before the
> > mmap_read_trylock() is the right one to apply.  It's basically what
> > we've done forever, except that now we'll be rescheduling without the
> > mmap lock held, which just seems like an overall win.
> > 
> 
> I can't sleep and your response made me curious, is that really safe
> here?
> 
> As I wrote in another email, the routine is concerned with a case of the
> kernel faulting on something it should not have. For a case like that I
> find rescheduling to another thread to be most concerning.

Hmm, initially I didn't see it, but you're concerned with something like:

        foo->bar = NULL;
        spin_lock(&foo->lock);
        printk("%d\n", foo->bar->baz);

And yeah, scheduling away in that case would be bad.

> That said I think I found a winner -- add need_resched() prior to
> trylock.
> 
> This adds less work than you would have added with might_sleep (a func
> call), still respects the preemption point, dodges exception table
> checks in the common case and does not switch away if the there is
> anything fishy going on.
> 
> Or just do that might_sleep.

The might_sleep() is clearly safe, but I thought of a different take on
the problem you've found, which is that we used to check need_resched
on _every_ page fault, because we used to take the mmap_lock on every
page fault.  Now we only check it on the minority of page faults which
can't be handled under the VMA lock.  But we can't just slam a
might_resched() into the start of the fault handler, because of the
problem you outlined above.

So how about something like this:

+++ b/arch/x86/mm/fault.c
@@ -1365,6 +1365,7 @@ void do_user_addr_fault(struct pt_regs *regs,
        if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
                vma_end_read(vma);

+       might_resched();
        if (!(fault & VM_FAULT_RETRY)) {
                count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
                goto done;

We found a VMA, so we know it isn't a NULL pointer dereference.  And we've
released the VMA lock at this point, so we won't be blocking anything from
making progress.  I'm not thrilled about having to replicate this in each
architecture, but I also don't love putting it in lock_vma_under_rcu()
(since someone might call that who actually can't schedule -- it certainly
wouldn't be obvious from the function name).

Then we can leave the might_sleep() exactly where it is in
get_mmap_lock_carefully(); it's really unlikely to trigger a reschedule.
