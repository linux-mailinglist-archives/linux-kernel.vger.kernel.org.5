Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8A797F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjIHABV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIHABT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:01:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7199D;
        Thu,  7 Sep 2023 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kFxMwjKPpQPRz2kPrpu3oF5FvWBvyL3/WDSSiKgMZu0=; b=ODLmaq3brgjdrxOtQK5P2QaqtN
        uMwWXT4Y5V4aY9d5N/hH7PDlzh8ijv8er3X1mvjbcNskxEvs05ZDQUZvck2X5PlaND+ymUVfrRmuq
        KdSN3Ohl8MmUTXPy6fyL/vUs+C9X96otk+Bxsh8/PL4mhszDkeXFHnX85wzNPvK+bFNvQuCjZTGD7
        Y3q0oH4fFYB1P7yaAuaGZy+hCBPQd9N1QOcxEdBjvfo1BSu/MeTiqOwUC0yqga8aFpV61dCvDahxr
        MXbiqbPeyHG08SaqvmEkdTSpy/sio7q6dGjoHuUOY2bxmp4DoKRvMBQrcZlNduqn0Zse2XdAgvLJv
        Wx1x4dKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeOvn-00EJfd-Mq; Fri, 08 Sep 2023 00:01:03 +0000
Date:   Fri, 8 Sep 2023 01:01:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZPpkPyV8AWOjlgfm@casper.infradead.org>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907193838.GB14243@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 09:38:38PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 07, 2023 at 08:20:30PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 07, 2023 at 09:08:10PM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 07, 2023 at 06:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > Several places want to know whether the lock is held by a writer, instead
> > > > of just whether it's held.  We can implement this for both normal and
> > > > rt rwsems.  RWSEM_WRITER_LOCKED is declared in rwsem.c and exposing
> > > > it outside that file might tempt other people to use it, so just use
> > > > a comment to note that's what the 1 means, and help anybody find it if
> > > > they're looking to change the implementation.
> > > 
> > > I'm presuming this is deep in a callchain where they know they hold the
> > > lock, but they lost in what capacity?
> > 
> > No, it's just assertions.  You can see that in patch 3 where it's
> > used in functions called things like "xfs_islocked".
> 
> Right, but if you're not the lock owner, your answer to the question is
> a dice-roll, it might be locked, it might not be.

Sure, but if you are the lock owner, it's guaranteed to work.  And if
you hold it for read, and check that it's held for write, that will
definitely fail.  I agree "somebody else is holding it" gives you a
false negative, but most locks aren't contended, so it'll fail the
assertion often enough.

> > Patch 2 shows it in use in the MM code.  We already have a
> > lockdep_assert_held_write(), but most people don't enable lockdep, so
> 
> Most devs should run with lockdep on when writing new code, and I know
> the sanitizer robots run with lockdep on.
> 
> In general there seems to be a ton of lockdep on coverage.

Hm.  Enabling lockdep causes an xfstests run to go up from 6000 seconds
to 8000 seconds for me.  That's a significant reduction in the number
of test cycles I can run per day.

> > we also have VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm)
> > to give us a good assertion when lockdep is disabled.
> 
> Is that really worth it still? I mean, much of these assertions pre-date
> lockdep.

That's true.  Is it possible to do a cheaper version of lockdep where it
only records that you have the lock and doesn't, eg, check for locking
dependencies?  I haven't analysed lockdep to see what the expensive part
is; for all I know it's recording the holders, and this idea is
worthless.

> > XFS has a problem with using lockdep in general, which is that a worker
> > thread can be spawned and use the fact that the spawner is holding the
> > lock.  There's no mechanism for the worker thread to ask "Does struct
> > task_struct *p hold the lock?".
> 
> Will be somewhat tricky to make happen -- but might be doable. It is
> however an interface that is *very* hard to use correctly. Basically I
> think you want to also assert that your target task 'p' is blocked,
> right?
> 
> That is: assert @p is blocked and holds @lock.

Probably, although I think there might be a race where the worker thread
starts running before the waiter starts waiting?

In conversation with Darrick & Dave, XFS does this in order to avoid
overflowing the kernel stack.  So if you've been thinking about "we
could support segmented stacks", it would avoid having to support this
lockdep handoff.  It'd probably work a lot better for the scheduler too.
