Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24BC79860A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbjIHKo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIHKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195D1BC6;
        Fri,  8 Sep 2023 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CxXN7IaoL8RwVwQiUmo1siGJgoNZz5WFIpz2pAVAxuc=; b=KIE8pBuT0ZFIv86asxj0niU4H1
        3jPwIv8vg1avtC+nyDT0NIvw8I9ObyOPdsxNRjZ3vNAjDkNEptCLTUFypEo3+AFUy2bsdS0sUk0LI
        DrO4Icf0473OfWRp4uwkoWbT6Q9rbPJH8575k+dYGHfzAnkw1b6Li9kErMrBQBDyFs7PdHkxGxF+e
        cFawBf2j5TUjya/Y7hKCJKy77g/dikCTKSAgOlGqKH4hl1MSNVx/CEu/U/msdJNFtN9xpst2dlYwh
        FfqrbA3Z+sSVUsxSvR1rdDQtUYnjEgVtGl+qMoQ1re7dd6f4kOoypfVs15+QCyEYTUyDKEO0Gg4Sr
        4Y0QLQwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeYyZ-00HGsO-1U; Fri, 08 Sep 2023 10:44:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9763C300472; Fri,  8 Sep 2023 12:44:34 +0200 (CEST)
Date:   Fri, 8 Sep 2023 12:44:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230908104434.GB24372@noisy.programming.kicks-ass.net>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPpV+MeFqX6RHIYw@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 09:00:08AM +1000, Dave Chinner wrote:

> > Right, but if you're not the lock owner, your answer to the question is
> > a dice-roll, it might be locked, it might not be.
> 
> Except that the person writing the code knows the call chain that
> leads up to that code, and so they have a pretty good idea whether
> the object should be locked or not. If we are running that code, and
> the object is locked, then it's pretty much guaranteed that the
> owner of the lock is code that executed the check, because otherwise
> we have a *major lock implementation bug*.

Agreed, and this is fine. However there's been some very creative
'use' of the _is_locked() class of functions in the past that did not
follow 'common' sense.

If all usage was: I should be holding this, lets check. I probably
wouldn't have this bad feeling about things.

> > Most devs should run with lockdep on when writing new code, and I know
> > the sanitizer robots run with lockdep on.
> > 
> > In general there seems to be a ton of lockdep on coverage.
> 
> *cough*
> 
> Bit locks, semaphores, and all sorts of other constructs for IO
> serialisation (like inode_dio_wait()) have no lockdep coverage at
> all. IOWs, large chunks of many filesystems, the VFS and the VM have
> little to no lockdep coverage at all.

True, however I was commenting on the assertion that vm code has
duplicate asserts with the implication that was because not a lot of
people run with lockdep on.

> > > we also have VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm)
> > > to give us a good assertion when lockdep is disabled.
> > 
> > Is that really worth it still? I mean, much of these assertions pre-date
> > lockdep.
> 
> And we're trying to propagate them because lockdep isn't a viable
> option for day to day testing of filesystems because of it's
> overhead vs how infrequently it finds new problems.

... in XFS. Lockdep avoids a giant pile of broken from entering the
kernel and the robots still report plenty.

> > > XFS has a problem with using lockdep in general, which is that a worker
> > > thread can be spawned and use the fact that the spawner is holding the
> > > lock.  There's no mechanism for the worker thread to ask "Does struct
> > > task_struct *p hold the lock?".
> > 
> > Will be somewhat tricky to make happen -- but might be doable. It is
> > however an interface that is *very* hard to use correctly. Basically I
> > think you want to also assert that your target task 'p' is blocked,
> > right?
> > 
> > That is: assert @p is blocked and holds @lock.
> 
> That addresses the immediate symptom; it doesn't address the large
> problem with lockdep and needing non-owner rwsem semantics.
> 
> i.e. synchronous task based locking models don't work for
> asynchronous multi-stage pipeline processing engines like XFS. The
> lock protects the data object and follows the data object through
> the processing pipeline, whilst the original submitter moves on to
> the next operation to processes without blocking.
> 
> This is the non-blocking, async processing model that io_uring
> development is pushing filesystems towards, so assuming that we only
> hand a lock to a single worker task and then wait for it complete
> (i.e. synchronous operation) flies in the face of current
> development directions...

I was looking at things from an interface abuse perspective. How easy is
it to do the wrong thing. As said, we've had a bunch of really dodgy
code with the _is_locked class of functions, hence my desire to find
something else.

As to the whole non-owner locking, yes, that's problematic. I'm not
convinced async operations require non-owner locking, at the same time I
do see that IO completions pose a challence.

Coming from the schedulability and real-time corner, non-owner locks are
a nightmare because of the inversions. So yeah, fun to be had I'm sure.
