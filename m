Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B556E79CB19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjILJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjILJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B742681;
        Tue, 12 Sep 2023 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OUN9qvOhvSclaajkaF7Yf2ZvZqXHPIr54l2XhmMy2iQ=; b=S5Uyc7toBN82oKnjq/FlDxHddn
        Rjo96XKH3esWhun3HPvT/LPYurgyYDtqSovgloklKRrD4xV/A6OSsQOpEmRQv+/Dc7Uxd6R2MsVph
        Tin0q0YT0h/IqrkCanL2ebgbXdndUBQ2vkkE0WDOIpl1K5K3z2CJpQGa9BXO12uItdSIpW9mHaNI6
        a4MgvZCXPavoAIZvD4CaI3mYb9TLW8IWuySpqgUskFMexlLLkjPBFbzqAUiAHFuvvbvm3Wo3kJR/K
        IDMyk/bIDSx8uJ6h+xTDqZacgvRG36C+IKFdR7hT3TTKQAb9n3e0xL7XeO55Dsv0pyvstVmyUxDYu
        e7MV/V/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfzJ9-006grO-DR; Tue, 12 Sep 2023 09:03:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8110D300348; Tue, 12 Sep 2023 11:03:42 +0200 (CEST)
Date:   Tue, 12 Sep 2023 11:03:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230912090342.GC35261@noisy.programming.kicks-ass.net>
References: <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP+U49yfkm0Fpfej@dread.disaster.area>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:29:55AM +1000, Dave Chinner wrote:

> So, once again, we have mixed messages from the lock maintainers.
> One says "no, it might get abused", another says "I'm fine with
> that", and now we have a maintainer disagreement stalemate.

I didn't say no, I was trying to see if there's alternatives because the
is_locked pattern has a history of abuse.

If not, then sure we can do this; it's not like I managed to get rid of
muteX_is_locked() -- and I actually tried at some point :/

And just now I grepped for it, and look what I find:

drivers/hid/hid-nintendo.c:     if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
drivers/nvdimm/btt.c:           if (mutex_is_locked(&arena->err_lock)

And there's more :-(

Also, please just calm down already..
