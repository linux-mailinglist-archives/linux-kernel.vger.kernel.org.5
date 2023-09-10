Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839BB79A09C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjIJXRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 19:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjIJXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 19:17:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E2184;
        Sun, 10 Sep 2023 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JHcf92QPbpxoV/BDIrCkFuoFwIyJCmqYEbR7oacx+1c=; b=Mw7H49FQH/Z49w/0iLemxbe5Nz
        J23I+cbhm7wO9uB6syLHmvg6f0VeXgDkYsaHReYvbd60gjKD8dVpdMVtX5jr42zd3nwxYytL7G4D/
        EcZ2inJz1QOkexzBFFUzC28mbR+DeeJAcf3I/56spPxi7HOlHN//AdRwAbvV5D08wWe1S1Vdl92nn
        teTxdQY3LpuSstD7FdPzbhk5bjmhNski0x19lFaNTw7a1EXn5m8rXTWguNYTq7oSBMF4/EoYzM9NG
        1LdokbVprnuQ6R7ND25ZWT/uURTLLX6I6djRMpJ0JlSvV2Cb94JyWK1alcupIqWWZtqGh+pO+CV74
        jhAETjfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfTg6-00F80P-V0; Sun, 10 Sep 2023 23:17:19 +0000
Date:   Mon, 11 Sep 2023 00:17:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZP5OfhXhPkntaEkc@casper.infradead.org>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP5JrYOge3tSAvj7@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:56:45AM +1000, Dave Chinner wrote:
> On Fri, Sep 08, 2023 at 12:44:34PM +0200, Peter Zijlstra wrote:
> > Agreed, and this is fine. However there's been some very creative
> > 'use' of the _is_locked() class of functions in the past that did not
> > follow 'common' sense.
> > 
> > If all usage was: I should be holding this, lets check. I probably
> > wouldn't have this bad feeling about things.
> 
> So your argument against such an interface is essentially "we can't
> have nice things because someone might abuse them"?

Some people are very creative ...

I was thinking about how to handle this better.  We could have

static inline void rwsem_assert_locked(const struct rw_semaphore *sem)
{
	BUG_ON(atomic_long_read(&sem->count) == 0);
}

static inline void rwsem_assert_write_locked(const struct rw_semaphore *sem)
{
	BUG_ON((atomic_long_read(&sem->count) & 1) != 1);
}

but then we'd also need to change how XFS currently uses the ASSERT()
macro to be ASSERT_LOCKED(ip, flags), and I understand this code is also
used in userspace, so it'd involve changing that shim, and we're getting
way past the amount of code I'm comfortable changing, and way past the
amount of time I should be spending on this.

And then there'd be the inevitable bikeshedding about "don't use BUG_ON"
and it's probably just for the best if I walk away at this point,
becoming the third person to fail to remove the mrlock.

I'll keep reading this thread to see if some consensus emerges, but I'm
not optimistic.
