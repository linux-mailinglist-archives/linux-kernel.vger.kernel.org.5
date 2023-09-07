Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F9797C89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbjIGTIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjIGTIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52ED92;
        Thu,  7 Sep 2023 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B4i1Y+uIsJjker8fZgf0O6RAXwRq6XADTrBQGDyLQow=; b=ZFSi3eICHMVOlCUUhit/X0b6Td
        lHmhtDAQpQtTBZafTYoVSDoysU8usmnzoPrkPHxdLPxusXxUV2BDRK2gXpd8NC6oyfp+mDklLOFVq
        VrQ+zwK9Bq4h2AHDDzE32iZ0+tVPtFTHX6tbHjQjIZ4ywpy8uHEbNLx+Dc+kzqLwk5WmrltG5/FWQ
        b9OJzShdHcWFFOMUiZuzvy8SamI5lVY8RN9wFHwKzS7eO2XklI6OsR6zhWd5SRRYREmrDYESYGrpX
        hWp5W0GMIbPXXRVlbXl1mKObckmd31zT7ggmDZMfRNRU9ytT0XeKPC2M4uy6H7H1F53NoTCOVYGj5
        aEolLXBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeKMN-00CtmW-57; Thu, 07 Sep 2023 19:08:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9AB8300687; Thu,  7 Sep 2023 21:08:10 +0200 (CEST)
Date:   Thu, 7 Sep 2023 21:08:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230907190810.GA14243@noisy.programming.kicks-ass.net>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907174705.2976191-2-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 06:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> Several places want to know whether the lock is held by a writer, instead
> of just whether it's held.  We can implement this for both normal and
> rt rwsems.  RWSEM_WRITER_LOCKED is declared in rwsem.c and exposing
> it outside that file might tempt other people to use it, so just use
> a comment to note that's what the 1 means, and help anybody find it if
> they're looking to change the implementation.

I'm presuming this is deep in a callchain where they know they hold the
lock, but they lost in what capacity?

In general I strongly dislike the whole _is_locked family, because it
gives very poorly defined semantics if used by anybody but the owner.

If these new functions are indeed to be used only by lock holders to
determine what kind of lock they hold, could we please put:

	lockdep_assert_held()

in them?
