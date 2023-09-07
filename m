Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB19797CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjIGTix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjIGTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:38:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E12CE9;
        Thu,  7 Sep 2023 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AwM1VwlwVIqM+B74AtASZ+ELYU+JQssLPAE0LrOcF/E=; b=ZVZBOxkLzTDNwduftx2feJdr/p
        ClCKXvMiMdqO9Xv57aM7SDVfJdMItDeRnmjJOuDhwWy9uIoaAWHsXN0Sl3DD9t9cyIflD517Hlxrv
        tTautZR2yS2w/xvPInpZA9+87k268fWTFbUAXN4YHNUF60eNef2UBsZvLfkNpnHLIK3lmi8ul/PqB
        WR3Y2sLgUGM9XqEMussOkvdUHSZCkC+5Xz092Ahu2oS/evQbKOoSR2RVU1Agj44veOdRnPkdmLsAV
        QcB72+bZf3iTkJoIaMWBRavKMdM8I4AgT7xpHdGmB4+o0PNNFMiRAztRIPPXiTXb3ZlYaxl0384O2
        bqWcy83Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeKpq-00D2qG-KL; Thu, 07 Sep 2023 19:38:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32FC4300687; Thu,  7 Sep 2023 21:38:38 +0200 (CEST)
Date:   Thu, 7 Sep 2023 21:38:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230907193838.GB14243@noisy.programming.kicks-ass.net>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPoift7B3UDQgmWB@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:20:30PM +0100, Matthew Wilcox wrote:
> On Thu, Sep 07, 2023 at 09:08:10PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 07, 2023 at 06:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Several places want to know whether the lock is held by a writer, instead
> > > of just whether it's held.  We can implement this for both normal and
> > > rt rwsems.  RWSEM_WRITER_LOCKED is declared in rwsem.c and exposing
> > > it outside that file might tempt other people to use it, so just use
> > > a comment to note that's what the 1 means, and help anybody find it if
> > > they're looking to change the implementation.
> > 
> > I'm presuming this is deep in a callchain where they know they hold the
> > lock, but they lost in what capacity?
> 
> No, it's just assertions.  You can see that in patch 3 where it's
> used in functions called things like "xfs_islocked".

Right, but if you're not the lock owner, your answer to the question is
a dice-roll, it might be locked, it might not be.

> > In general I strongly dislike the whole _is_locked family, because it
> > gives very poorly defined semantics if used by anybody but the owner.
> > 
> > If these new functions are indeed to be used only by lock holders to
> > determine what kind of lock they hold, could we please put:
> > 
> > 	lockdep_assert_held()
> > 
> > in them?
> 
> Patch 2 shows it in use in the MM code.  We already have a
> lockdep_assert_held_write(), but most people don't enable lockdep, so

Most devs should run with lockdep on when writing new code, and I know
the sanitizer robots run with lockdep on.

In general there seems to be a ton of lockdep on coverage.

> we also have VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm)
> to give us a good assertion when lockdep is disabled.

Is that really worth it still? I mean, much of these assertions pre-date
lockdep.

> XFS has a problem with using lockdep in general, which is that a worker
> thread can be spawned and use the fact that the spawner is holding the
> lock.  There's no mechanism for the worker thread to ask "Does struct
> task_struct *p hold the lock?".

Will be somewhat tricky to make happen -- but might be doable. It is
however an interface that is *very* hard to use correctly. Basically I
think you want to also assert that your target task 'p' is blocked,
right?

That is: assert @p is blocked and holds @lock.
