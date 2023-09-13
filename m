Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144879E2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbjIMI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbjIMI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:59:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0981997;
        Wed, 13 Sep 2023 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L3SwR6hKceOlWWcSwzNum5BemzOa6jq4Kj6VEs6rV8E=; b=ngdjgQWjtCltwMErjnQ9HTxowL
        cLOO7rhFYpVazeMHkGoLPauY0qKo+dw6JvAtN5cfcuW+u6U4PTxQNXFIqJEoMpsh4/rqDXj0cXAK4
        Jc/8YLQIZYcjUnhPuy+EtjT2JR2CocNkPP6dI3yCwhDMYeufRDm2M7xnz3+8KnJ+gujganXTSHp8x
        3uUb4Sl6Ue3zbeoONFB43yWdQ/gDX0vvcbmTp0TciKoAZyxdLfsFbpBkNGy8fw3k1n1XBYWKzbFvI
        5YPVSYap5ZhmtT7nT6imFgAX+2zrj2ArF3EldtNqlHpKVghvqs956qnspB7V8G1kzyI7Vw7NEpH+c
        wtMMz6PA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgLiE-006wEO-20;
        Wed, 13 Sep 2023 08:59:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B37B6300348; Wed, 13 Sep 2023 10:59:07 +0200 (CEST)
Date:   Wed, 13 Sep 2023 10:59:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230913085907.GB692@noisy.programming.kicks-ass.net>
References: <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
 <20230912090342.GC35261@noisy.programming.kicks-ass.net>
 <ZQBZXSCyG+u2+i8E@casper.infradead.org>
 <20230912135213.GA22127@noisy.programming.kicks-ass.net>
 <ZQBuiJ2n0uBOdjnr@casper.infradead.org>
 <20230912142300.GC22127@noisy.programming.kicks-ass.net>
 <20230912152715.GS28202@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912152715.GS28202@frogsfrogsfrogs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:27:15AM -0700, Darrick J. Wong wrote:

> I could live with Longman's suggestion of an rwsem_assert_is_locked that
> only exists if DEBUG_RWSEMS is enabled.  Something like:
> 
> #ifdef CONFIG_DEBUG_RWSEMS
> static inline bool __rwsem_assert_is_locked(struct rw_semaphore *rwsem,
> 		const char *file, int line)
> {
> 	bool ret = rwsem_is_locked(rwsem);
> 	if (!ret)
> 		WARN(1, "!rwsem_is_locked(rwsem) at %s line %d", file, line);
> 	return ret;
> }
> #define rwsem_assert_is_locked(r) \
> 	__rwsem_assert_is_locked((r), __FILE__, __LINE__)
> #endif
> 
> and then XFS could do:
> 
> 	ASSERT(rwsem_assert_is_locked(&VFS_I(ip)->i_rwsem));
> 
> Wherein ASSERT is only #defined if CONFIG_XFS_DEBUG, and XFS_DEBUG
> selects DEBUG_RWSEMS, per Longman's suggestion.  That's work for what we
> want it for (simple cheap lock checking) without becoming a general
> lockabuse predicate.

Ack.
