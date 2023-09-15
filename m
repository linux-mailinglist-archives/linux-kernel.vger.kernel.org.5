Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002A7A188A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjIOIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:23:37 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE05C4C1E;
        Fri, 15 Sep 2023 01:21:54 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Rn6Zs1GXWz8XrRV;
        Fri, 15 Sep 2023 16:20:53 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 38F8KfxW021903;
        Fri, 15 Sep 2023 16:20:41 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 15 Sep 2023 16:20:43 +0800 (CST)
Date:   Fri, 15 Sep 2023 16:20:43 +0800 (CST)
X-Zmail-TransId: 2b09650413db226-51e14
X-Mailer: Zmail v1.0
Message-ID: <202309151620439011387@zte.com.cn>
In-Reply-To: <ZQJIyx419cw24ppF@dread.disaster.area>
References: 202309131744458239465@zte.com.cn,ZQJIyx419cw24ppF@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 38F8KfxW021903
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 650413E5.001/4Rn6Zs1GXWz8XrRV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 13, 2023 at 05:44:45PM +0800, cheng.lin130@zte.com.cn wrote:
> > From: Cheng Lin <cheng.lin130@zte.com.cn>
> >
> > When abnormal drop_nlink are detected on the inode,
> > shutdown filesystem, to avoid corruption propagation.
> >
> > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > ---
> >  fs/xfs/xfs_inode.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 9e62cc500..40cc106ae 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -919,6 +919,15 @@ xfs_droplink(
> >      xfs_trans_t *tp,
> >      xfs_inode_t *ip)
> >  {
> > +
> > +    if (VFS_I(ip)->i_nlink == 0) {
> > +        xfs_alert(ip->i_mount,
> > +              "%s: Deleting inode %llu with no links.",
> > +              __func__, ip->i_ino);
> > +        tp->t_flags |= XFS_TRANS_DIRTY;
> Marking the transaction dirty is not necessary.
> Otherwise this seems fine.
I found the transaction maybe not dirty at this point. Dirty the transaction
can make sure to shutdown fs in subsequent xfs_trans_cancel().
