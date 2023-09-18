Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676627A4155
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbjIRGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbjIRGfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:35:50 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6453B135;
        Sun, 17 Sep 2023 23:35:06 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Rpw5L2yXnz8XrRQ;
        Mon, 18 Sep 2023 14:35:02 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 38I6Yp8r057320;
        Mon, 18 Sep 2023 14:34:51 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 18 Sep 2023 14:34:53 +0800 (CST)
Date:   Mon, 18 Sep 2023 14:34:53 +0800 (CST)
X-Zmail-TransId: 2b056507ef8d6ce-e9441
X-Mailer: Zmail v1.0
Message-ID: <202309181434537700285@zte.com.cn>
In-Reply-To: <ZQfktqPJ5Qzs7unT@dread.disaster.area>
References: ZQeBY3kmww8qAjfP@dread.disaster.area,202309181144537682244@zte.com.cn,ZQfktqPJ5Qzs7unT@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 38I6Yp8r057320
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6507EF96.001/4Rpw5L2yXnz8XrRQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Yes, and that's perfectly fine. The transaction cancelling code has
> worked this way for the past 20 years or so...
> Indeed, you said your customer wants the system to stay alive if possible,
> right? Well, so do we.
> If the parent directory has a bogus nlink count, and that prevents
> us from removing items from the directory, then as long as we
> haven't dirtied anything and we can return a -EFSCORRUPTED error to
> userspace to say the unlink failed and we don't have to shut the
> filesystem down. All we now have is a directory that has objects in
> it that can't be removed....
> For a higher level perspective, we only need to shut the filesystem
> down if we cannot safely back out of the modification operation that
> was requested. Whilst the transaction is clean, we can safely return
> errors to userspace and continue operation because everything in
> memory and on disk is still consistent, even if we have found a
> corruption in non-crtical the metadata. Just returning an error to
> userspace can't make the problem any worse.
> This also is how we treat corruption that is found during read
> operations - we return -EFSCORRUPTED to userspace because something in
> the directory or inode we were trying to read from was corrupted. We
> do not need to shut down the filesystem because there is
> no risk of making things worse or the in-memory filesystem state
> getting out of sync with the on-disk state.
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
> This "in memory matches on disk" state is effectively what the dirty
> flag in the transaction tracks, and it's done as part of the normal
> running of a transaction as items are tagged for logging. Marking a
> transaction dirty that has nothign tagged for logging is actually an
> incorrect state; we may handle it correctly, but it should never
> actually occur and we should definitely not be open coding dirtying
> of transactions to create this state.
> IOWs, the transaction modification error handling paths already do
> the right thing according to the state carried by the transaction at
> the time the error was encountered.
Thanks for your detailed explainations, I get it.
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
