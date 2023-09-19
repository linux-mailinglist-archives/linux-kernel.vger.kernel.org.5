Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838D67A57EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjISDdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjISDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:33:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06DF10E;
        Mon, 18 Sep 2023 20:33:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430B5C433C8;
        Tue, 19 Sep 2023 03:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695094416;
        bh=LkrAcMJkX+W+jGridPGhkAI5FW5BVjJBEN9dcf/Fig4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1hVAGdu2qLo0P9RPYKkFP8jChK4MSTSSpoB/JxYAeQSLZgJTGS++fH/u/ckxeqj3
         ZTDL9PGVULj6rXshO84Y7OKZDDzMjlNJNpqF22mpAlxsVyjD83T2LYFE6HidnOyhiy
         pKY8lqeHgHbi2/mW9+lSGtHdqNgl8yPtxKXFuhbXTIWTpf5UvIews0PBGmFKf0a+Qg
         U+ViU3Qsfsdljsj/VsXUuctkL8qZW+cv2dU5662UVa/UAaxiZbARtOFn3LRluOPl4K
         5QHNI0tC+R2/pp6tFOAYEZVQdkCb8c4GScTpB/neb8cu+/0H/qVSW/xonn/slXN21w
         x488CwAZ1Eejg==
Date:   Mon, 18 Sep 2023 20:33:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     cheng.lin130@zte.com.cn, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v3] xfs: introduce protection for drop nlink
Message-ID: <20230919033335.GF348018@frogsfrogsfrogs>
References: <ZQeBY3kmww8qAjfP@dread.disaster.area>
 <202309181144537682244@zte.com.cn>
 <ZQfktqPJ5Qzs7unT@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQfktqPJ5Qzs7unT@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:48:38PM +1000, Dave Chinner wrote:
> On Mon, Sep 18, 2023 at 11:44:53AM +0800, cheng.lin130@zte.com.cn wrote:
> > > On Fri, Sep 15, 2023 at 05:50:56PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > > On Wed, Sep 13, 2023 at 05:44:45PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > > >
> > > > > > When abnormal drop_nlink are detected on the inode,
> > > > > > shutdown filesystem, to avoid corruption propagation.
> > > > > >
> > > > > > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > > > ---
> > > > > >  fs/xfs/xfs_inode.c | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > > > index 9e62cc500..40cc106ae 100644
> > > > > > --- a/fs/xfs/xfs_inode.c
> > > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > > @@ -919,6 +919,15 @@ xfs_droplink(
> > > > > >      xfs_trans_t *tp,
> > > > > >      xfs_inode_t *ip)
> > > > > >  {
> > > > > > +
> > > > > > +    if (VFS_I(ip)->i_nlink == 0) {
> > > > > > +        xfs_alert(ip->i_mount,
> > > > > > +              "%s: Deleting inode %llu with no links.",
> > > > > > +              __func__, ip->i_ino);
> > > > > > +        tp->t_flags |= XFS_TRANS_DIRTY;
> > > > > Marking the transaction dirty is not necessary.
> > > > > Otherwise this seems fine.
> > > > Another strategy:
> > > > Set nlink to an invalid value(like XFS_NLINK_PINNED), and
> > > > Complete this transaction before shutdown fs. To make sure
> > > > nlink not be zero. If the nlink of a directory are zero, it may
> > > > be cleaned up.
> > > > Is that appropriate?
> > > No, all I'm asking you to do is drop dirtying of the transaction
> > > from this patch because it is a) unnecessary and b) a layering
> > > violation.
> > > It is unnecessary because the transaction will almost always be
> > > dirty before we get to xfs_droplink(). In the cases where it isn't
> > > dirty (e.g. xfs_remove() on a directory) we explicitly check that
> > > nlink == 2 before proceeding to call xfs_droplink(). Hence we can't
> > > actually get to xfs_droplink() with a clean transaction, and so
> > If the corrupted inode is a parent directory, when remove its
> > subdirectory, the parent's nlink will be decreased to 0.  But the
> > transaction of subdirectory removing is not dirty (There are not
> > check about the parent directory). In this situation, the transaction
> > will be failed and the filesystem will be alive.
> 
> Yes, and that's perfectly fine. The transaction cancelling code has
> worked this way for the past 20 years or so...
> 
> Indeed, you said your customer wants the system to stay alive if possible,
> right? Well, so do we.
> 
> If the parent directory has a bogus nlink count, and that prevents
> us from removing items from the directory, then as long as we
> haven't dirtied anything and we can return a -EFSCORRUPTED error to
> userspace to say the unlink failed and we don't have to shut the
> filesystem down. All we now have is a directory that has objects in
> it that can't be removed....
> 
> For a higher level perspective, we only need to shut the filesystem
> down if we cannot safely back out of the modification operation that
> was requested. Whilst the transaction is clean, we can safely return
> errors to userspace and continue operation because everything in
> memory and on disk is still consistent, even if we have found a
> corruption in non-crtical the metadata. Just returning an error to
> userspace can't make the problem any worse.
> 
> This also is how we treat corruption that is found during read
> operations - we return -EFSCORRUPTED to userspace because something in
> the directory or inode we were trying to read from was corrupted. We
> do not need to shut down the filesystem because there is
> no risk of making things worse or the in-memory filesystem state
> getting out of sync with the on-disk state.
> 
> It is only when we are trying to modify something that corruption
> becomes a problem with fatal consequences. Once we've made a
> modification, the in-memory state is different to the on-disk state
> and whilst we are in that state any corruption we discover becomes
> fatal. That is because there is no way to reconcile the changes
> we've already made in memory with what is on-disk - we don't know
> that the in-memory changes are good because we tripped over
> corruption, and so we must not propagate bad in-memory state and
> metadata to disk over the top of what may be still be uncorrupted
> metadata on disk.

It'd be a massive effort, but wouldn't it be fun if one could attach
defer ops to a transaction that updated incore state on commit but
otherwise never appeared on disk?

Let me cogitate on that during part 2 of vacation...

--D

> This "in memory matches on disk" state is effectively what the dirty
> flag in the transaction tracks, and it's done as part of the normal
> running of a transaction as items are tagged for logging. Marking a
> transaction dirty that has nothign tagged for logging is actually an
> incorrect state; we may handle it correctly, but it should never
> actually occur and we should definitely not be open coding dirtying
> of transactions to create this state.
> 
> IOWs, the transaction modification error handling paths already do
> the right thing according to the state carried by the transaction at
> the time the error was encountered.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
