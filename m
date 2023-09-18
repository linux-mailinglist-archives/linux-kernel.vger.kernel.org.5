Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC317A3FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjIRDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjIRDpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:45:06 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BE10A;
        Sun, 17 Sep 2023 20:44:59 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RprK34GWKz8XrRF;
        Mon, 18 Sep 2023 11:44:55 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 38I3iqSr028467;
        Mon, 18 Sep 2023 11:44:52 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp06[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 18 Sep 2023 11:44:53 +0800 (CST)
Date:   Mon, 18 Sep 2023 11:44:53 +0800 (CST)
X-Zmail-TransId: 2b086507c7b56cf-2fc22
X-Mailer: Zmail v1.0
Message-ID: <202309181144537682244@zte.com.cn>
In-Reply-To: <ZQeBY3kmww8qAjfP@dread.disaster.area>
References: ZQJIyx419cw24ppF@dread.disaster.area,202309151750563356840@zte.com.cn,ZQeBY3kmww8qAjfP@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 38I3iqSr028467
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6507C7B7.001/4RprK34GWKz8XrRF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 15, 2023 at 05:50:56PM +0800, cheng.lin130@zte.com.cn wrote:
> > > On Wed, Sep 13, 2023 at 05:44:45PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > >
> > > > When abnormal drop_nlink are detected on the inode,
> > > > shutdown filesystem, to avoid corruption propagation.
> > > >
> > > > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > ---
> > > >  fs/xfs/xfs_inode.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > index 9e62cc500..40cc106ae 100644
> > > > --- a/fs/xfs/xfs_inode.c
> > > > +++ b/fs/xfs/xfs_inode.c
> > > > @@ -919,6 +919,15 @@ xfs_droplink(
> > > >      xfs_trans_t *tp,
> > > >      xfs_inode_t *ip)
> > > >  {
> > > > +
> > > > +    if (VFS_I(ip)->i_nlink == 0) {
> > > > +        xfs_alert(ip->i_mount,
> > > > +              "%s: Deleting inode %llu with no links.",
> > > > +              __func__, ip->i_ino);
> > > > +        tp->t_flags |= XFS_TRANS_DIRTY;
> > > Marking the transaction dirty is not necessary.
> > > Otherwise this seems fine.
> > Another strategy:
> > Set nlink to an invalid value(like XFS_NLINK_PINNED), and
> > Complete this transaction before shutdown fs. To make sure
> > nlink not be zero. If the nlink of a directory are zero, it may
> > be cleaned up.
> > Is that appropriate?
> No, all I'm asking you to do is drop dirtying of the transaction
> from this patch because it is a) unnecessary and b) a layering
> violation.
> It is unnecessary because the transaction will almost always be
> dirty before we get to xfs_droplink(). In the cases where it isn't
> dirty (e.g. xfs_remove() on a directory) we explicitly check that
> nlink == 2 before proceeding to call xfs_droplink(). Hence we can't
> actually get to xfs_droplink() with a clean transaction, and so
If the corrupted inode is a parent directory, when remove its
subdirectory, the parent's nlink will be decreased to 0. But the
transaction of subdirectory removing is not dirty (There are not
check about the parent directory). In this situation, the transaction
will be failed and the filesystem will be alive.

> marking it dirty here on underrun is unnecessary as returning an
> error from xfs_droplink() will result in shutting down the
> filesystem when the transaction is cancelled.
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
