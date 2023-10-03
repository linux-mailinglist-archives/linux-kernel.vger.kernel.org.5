Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D307B6FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjJCRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjJCRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:33:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595D9B;
        Tue,  3 Oct 2023 10:33:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA5EC433C8;
        Tue,  3 Oct 2023 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696354398;
        bh=PQdnMeXAjhP6tZYTGv5AYxPws/vb5p3nfnwhAt47/LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouq0LTrVu61iySOqqm5O2auMfuCrpnUMDz9gfuaA3YzXByVnHzjMoMIApl3dONpTO
         W8dOdmyW96N/R42rrfidj8sOpOtldjHDEA6XDyvuKvQRq9deU9Tcc7cKLd9BA4XuA7
         wDr2K1lliZUCWKXSuUXs7K8Gxr1dhZep8x3pJ5RHlWwxZFPnqCSxfWnp/JCE0j13eu
         UbXOrofDQ/Gy4+OFhkoqaGKLvgzzvDmr+73Wod0Xn9YgK0zusJ7c0YgfehKCD00z8/
         zDhrwXPsEYdaOpehEEXZNDlt8x9j5aeAurk02qyD5NihJrOMo5BIjKyARzIBNuIYsT
         np1ETV0mpw/4Q==
Date:   Tue, 3 Oct 2023 10:33:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     cheng.lin130@zte.com.cn, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v3] xfs: introduce protection for drop nlink
Message-ID: <20231003173317.GI21298@frogsfrogsfrogs>
References: <ZQqI5KNgghI5iFrC@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQqI5KNgghI5iFrC@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:53:40PM +1000, Dave Chinner wrote:
> On Mon, Sep 18, 2023 at 08:33:35PM -0700, Darrick J. Wong wrote:
> > On Mon, Sep 18, 2023 at 03:48:38PM +1000, Dave Chinner wrote:
> > > It is only when we are trying to modify something that corruption
> > > becomes a problem with fatal consequences. Once we've made a
> > > modification, the in-memory state is different to the on-disk state
> > > and whilst we are in that state any corruption we discover becomes
> > > fatal. That is because there is no way to reconcile the changes
> > > we've already made in memory with what is on-disk - we don't know
> > > that the in-memory changes are good because we tripped over
> > > corruption, and so we must not propagate bad in-memory state and
> > > metadata to disk over the top of what may be still be uncorrupted
> > > metadata on disk.
> > 
> > It'd be a massive effort, but wouldn't it be fun if one could attach
> > defer ops to a transaction that updated incore state on commit but
> > otherwise never appeared on disk?
> >
> > Let me cogitate on that during part 2 of vacation...
> 
> Sure, I'm interested to see what you might come up with.
> 
> My thoughts on rollback of dirty transactions come from a different
> perspective.
> 
> Conceptually being able to roll back individual transactions isn't
> that difficult. All it takes is a bit more memory and CPU - when we
> join the item to the transaction we take a copy of the item we are
> about to modify.
> 
> If we then cancel a dirty transaction, we then roll back all the
> dirty items to their original state before we unlock them.  This
> works fine for all the on-disk stuff we track in log items.
> 
> I have vague thoughts about how this could potentially be tied into
> the shadow buffers we already use for keeping a delta copy of all
> the committed in-memory changes in the CIL that we haven't yet
> committed to the journal - that's actually the entire delta between
> what is on disk and what we've changed prior to the current
> transaction we are cancelling.
> 
> Hence, in theory, a rollback for a dirty log item is simply "read it
> from disk again, copy the CIL shadow buffer delta into it".

<nod> That's more or less the same as what I was thinking.

> However, the complexity comes with trying to roll back associated
> in-memory state changes that we don't track as log items.  e.g.
> incore extent list changes, in memory inode flag state (e.g.
> XFS_ISTALE), etc. that's where all the hard problems to solve lie, I
> think.

Yeah.  I was thinking that each of those incore state changes could be
implemented as a defer_ops that have NOP ->create_intent and
->create_done functions.  The ->finish_item would actually update the
incore structure.  This would be a very large project, and I'm not sure
that it wouldn't be easier to snapshot the xfs_inode fields themselves,
similar to how inode log items snapshot xfs_dinode fields.

(Snapshotting probably doesn't work for the more complex incore
inode structures.)

Kent has been wrangling with this problem for a while in bcachefs and I
think he's actually gotten the rollbacks to work more or less correctly.
He told me that it was a significant restructuring of his codebase even
though *everything* is tracked in btrees and the cursor abstraction
there is more robust than xfs.

> Another problem is how do we rollback from the middle of an intent
> (defer ops) chain? We have to complete that chain for things to end
> up consistent on disk, so we can't just cancel the current
> transaction and say we are done and everything is clean.  Maybe
> that's what you are thinking of here - each chain has an "undo"
> intent chain that can roll back all the changes already made?

Yes.  Every time we call ->finish_item on a log intent item, we also log
a new intent item that undoes whatever that step did.  These items we'll
call "log undo intent" items, and put them on a separate list, e.g.
tp->t_undoops.  If the chain completes successfully then the last step
is to abort everything on t_undoops to release all that memory.

If the chain does not succeed, then we'd abort the intents on t_dfops,
splice t_undoops onto t_dfops, and call xfs_defer_finish to write the
log undo intent items to disk and finish them.  If /that/ fails then we
have to shutdown.

I think this also means that buffer updates that are logged from a
->finish_item function should not be cancelled per above, since the undo
intent item will take care of that.  That would be easy if btree updates
made by an efi/cui/rui items used ordered buffers instead of logging
them directly like we do now.

For bui items, I think we'd need ordered buffers for bmbt updates and
snapshotting inode items for the inode updates themselves.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
