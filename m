Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246C7897A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjHZPJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjHZPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:08:53 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E810D7;
        Sat, 26 Aug 2023 08:08:49 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RY0Zg0BDvz4xPYb;
        Sat, 26 Aug 2023 23:08:43 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 37QF8aq7036040;
        Sat, 26 Aug 2023 23:08:36 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 26 Aug 2023 23:08:40 +0800 (CST)
Date:   Sat, 26 Aug 2023 23:08:40 +0800 (CST)
X-Zmail-TransId: 2b0664ea1578ffffffffa8f-3ba54
X-Mailer: Zmail v1.0
Message-ID: <202308262308405490334@zte.com.cn>
In-Reply-To: <ZOlsvPa2imANAzRu@dread.disaster.area>
References: ZOfhoLql0TYiD5JW@dread.disaster.area,202308251709208292077@zte.com.cn,20230825175627.GK17912@frogsfrogsfrogs,ZOlsvPa2imANAzRu@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>, <djwong@kernel.org>
Cc:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 37QF8aq7036040
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64EA157B.000/4RY0Zg0BDvz4xPYb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Aug 25, 2023 at 10:56:27AM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 25, 2023 at 05:09:20PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
> > > >> From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > >> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
> > > >> directory to become unusable until the next xfs_repair run.
> > > > Hmmm.  How does this ever happen?
> > > > IMO, if it does happen, we need to fix whatever bug that causes it
> > > > to happen, not issue a warning and do nothing about the fact we
> > > > just hit a corrupt inode state...
> > > Yes, I'm very agree with your opinion. But I don't know how it happened,
> > > and how to reproduce it.
> >
> > Wait, is this the result of a customer problem?  Or static analysis?
It's a customer problem.

> >
> > > >> Introduce protection for drop nlink to reduce the impact of this.
> > > >> And produce a warning for directory nlink error during remove.
> > > >>
> > > >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > >> ---
> > > >>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
> > > >>  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > >> index 9e62cc5..536dbe4 100644
> > > >> --- a/fs/xfs/xfs_inode.c
> > > >> +++ b/fs/xfs/xfs_inode.c
> > > >> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
> >
> > I'm not sure why your diff program thinks this hunk is from
> > xfs_iunlink_remove, seeing as the line numbers of the chunk point to
> > xfs_droplink.  Maybe that's what's going on in this part of the thread?
> Yes.
> I don't expect patches to be mangled like this - I generally
> take the hunk prefix to indicate what code is being modified when
> reading patches, not expecting that the hunk is modifying code over
> a thousand lines prior to the function in the prefix...
> So, yeah, something went very wrong with the generation of this
> patch...
> -Dave.
It may be a problem with the git version. After using 2.18.1 instead of 1.8.3.1,
the patch looks normal.

> --
> Dave Chinner
> david@fromorbit.com

> > > Wait a second - this code doesn't match an upstream kernel. What
> > > kernel did you make this patch against?
> > It's kernel mainline linux-6.5-rc7

> ....and what did you use to generate the patch?  git diff?
>
> --D
It's  git format-patch 
git version 1.8.3.1
