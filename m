Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154A679D4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjILP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbjILP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:27:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F210EB;
        Tue, 12 Sep 2023 08:27:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0A0C433C8;
        Tue, 12 Sep 2023 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694532436;
        bh=zT75Ab5rlByJQL3D5lDMEHE8CDUMBia7LGb43n9vDS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxLTLAoCSRdKjo6pL+3MS5DEaBWsenCUs0N8SkssjHARH/CqFQEPOYzXQGjoXdE/c
         gld3jHG2xwr+gXWQdKrakUrMSSmclIDeErK6gBLn/ajuOfYbLShdEdOkL+lJ50pJ5l
         T3/os9dNfX1VZ0c+6oebRd5nuwD06sfPSMDaHa/m6q3Vc+hiPyOMI2pH2I5DaLWeUu
         ntiamSBnRmk5cgXF0A/Ofm8uQcoXZFXAliTPTlBt/jXBC8tp7MHOcWX9R3Ydig3gN2
         yAHJy+xkZTJtNq8X+quCVIqw7lR9lvQqHjAMpg/6wpwrzRK2JzYqp8ng5PQpLAefi/
         Oh8uXPlpH21CQ==
Date:   Tue, 12 Sep 2023 08:27:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230912152715.GS28202@frogsfrogsfrogs>
References: <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
 <20230912090342.GC35261@noisy.programming.kicks-ass.net>
 <ZQBZXSCyG+u2+i8E@casper.infradead.org>
 <20230912135213.GA22127@noisy.programming.kicks-ass.net>
 <ZQBuiJ2n0uBOdjnr@casper.infradead.org>
 <20230912142300.GC22127@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912142300.GC22127@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:23:00PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 12, 2023 at 02:58:32PM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 12, 2023 at 03:52:13PM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 12, 2023 at 01:28:13PM +0100, Matthew Wilcox wrote:
> > > > On Tue, Sep 12, 2023 at 11:03:42AM +0200, Peter Zijlstra wrote:
> > > > > If not, then sure we can do this; it's not like I managed to get rid of
> > > > > muteX_is_locked() -- and I actually tried at some point :/
> > > > > 
> > > > > And just now I grepped for it, and look what I find:
> > > > > 
> > > > > drivers/hid/hid-nintendo.c:     if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
> > > > > drivers/nvdimm/btt.c:           if (mutex_is_locked(&arena->err_lock)
> > > > > 
> > > > > And there's more :-(
> > > > 
> > > > Are these actually abuse?  I looked at these two, and they both seem to
> > > > be asking "Does somebody else currently have this mutex?" rather than
> > > > "Do I have this mutex?".
> > > 
> > > It's effectively a random number generator in that capacity. Someone
> > > might have it or might have had it when you looked and no longer have
> > > it, or might have it now but not when you asked.
> > 
> > Well, no.
> > 
> >                 if (mutex_is_locked(&arena->err_lock)
> >                                 || arena->freelist[lane].has_err) {
> >                         nd_region_release_lane(btt->nd_region, lane);
> > 
> >                         ret = arena_clear_freelist_error(arena, lane);
> > 
> > So that's "Is somebody currently processing an error, or have they
> > already finished setting an error".  Sure, it's somewhat racy, but
> > it looks like a performance optimisation, not something that needs
> > 100% accuracy.
> 
> We're arguing past one another I think. Yes mutex_is_locked() is a
> random number generator when asked for something you don't own. But it
> might not be a bug because the code is ok with races.
> 
> It is still fully dodgy IMO, such usage is pretty close to UB.

My 2 cents here:

I could live with Longman's suggestion of an rwsem_assert_is_locked that
only exists if DEBUG_RWSEMS is enabled.  Something like:

#ifdef CONFIG_DEBUG_RWSEMS
static inline bool __rwsem_assert_is_locked(struct rw_semaphore *rwsem,
		const char *file, int line)
{
	bool ret = rwsem_is_locked(rwsem);
	if (!ret)
		WARN(1, "!rwsem_is_locked(rwsem) at %s line %d", file, line);
	return ret;
}
#define rwsem_assert_is_locked(r) \
	__rwsem_assert_is_locked((r), __FILE__, __LINE__)
#endif

and then XFS could do:

	ASSERT(rwsem_assert_is_locked(&VFS_I(ip)->i_rwsem));

Wherein ASSERT is only #defined if CONFIG_XFS_DEBUG, and XFS_DEBUG
selects DEBUG_RWSEMS, per Longman's suggestion.  That's work for what we
want it for (simple cheap lock checking) without becoming a general
lockabuse predicate.

--D
