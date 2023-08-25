Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B18788E16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHYR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHYR4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:56:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57166128;
        Fri, 25 Aug 2023 10:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA53062BCB;
        Fri, 25 Aug 2023 17:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AC5C433C7;
        Fri, 25 Aug 2023 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692986188;
        bh=rI7H2kCpO6ovEX4lUcoSx7mUtF+QitCqkO3IBBb53Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWdw+/wnO3qF3Psjzz16cfg08Xto3H/gl8od6sl1fvVt/51kov1EICp3DGqBpv5g6
         KogW8ZRRKNI5jeXNusKyzguNHI/GlY3ZqC8D5P6p1ualwG/2QB/osHUf+B6R6ton1L
         gkzbuNqZvKxZzcUzizjaaGgnwinEmMZsa7PjkxFw+tFh3QDNoElC7bxFNvpqvnCqeN
         +TDAeS6C9TbsemE74es0KxL5Q3l3HV9mU2e27AHbFd3IZwiZmhNOBDoTP77XpRk6M1
         isolmYqwskT4VK2nOw26el1ofcNQaF5UhGrr0CN5Dqdum9ZGURKOVqolnBGREIPJjT
         nfhJ4dHwRCTgA==
Date:   Fri, 25 Aug 2023 10:56:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH] xfs: introduce protection for drop nlink
Message-ID: <20230825175627.GK17912@frogsfrogsfrogs>
References: <ZOfhoLql0TYiD5JW@dread.disaster.area>
 <202308251709208292077@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308251709208292077@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 05:09:20PM +0800, cheng.lin130@zte.com.cn wrote:
> > On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
> >> From: Cheng Lin <cheng.lin130@zte.com.cn>
> >> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
> >> directory to become unusable until the next xfs_repair run.
> > Hmmm.  How does this ever happen?
> > IMO, if it does happen, we need to fix whatever bug that causes it
> > to happen, not issue a warning and do nothing about the fact we
> > just hit a corrupt inode state...
> Yes, I'm very agree with your opinion. But I don't know how it happened,
> and how to reproduce it.

Wait, is this the result of a customer problem?  Or static analysis?

> >> Introduce protection for drop nlink to reduce the impact of this.
> >> And produce a warning for directory nlink error during remove.
> >>
> >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> >> ---
> >>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> >> index 9e62cc5..536dbe4 100644
> >> --- a/fs/xfs/xfs_inode.c
> >> +++ b/fs/xfs/xfs_inode.c
> >> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,

I'm not sure why your diff program thinks this hunk is from
xfs_iunlink_remove, seeing as the line numbers of the chunk point to
xfs_droplink.  Maybe that's what's going on in this part of the thread?

> >>      xfs_trans_t *tp,
> >>      xfs_inode_t *ip)
> >>  {
> >> +    xfs_mount_t     *mp;
> >> +
> >> +    if (VFS_I(ip)->i_nlink == 0) {
> >> +        mp = ip->i_mount;
> >> +        xfs_warn(mp, "%s: Deleting inode %llu with no links.",
> >> +             __func__, ip->i_ino);
> >> +        return 0;
> >> +    }
> > This is obviously incorrect - whiteout inodes (RENAME_WHITEOUT) have an
> > i_nlink of zero when they are removed from the unlinked list. As do
> > O_TMPFILE inodes - when they are linked into the filesystem, we
> > explicitly check for i_nlink being zero before calling
> > xfs_iunlink_remove().
> I am not familiar with the above process. You means there is such a
> scenario, even if it is (i_nlink==0), it still needs to run drop_nlink()
> in xfs_droplink()? But this will cause i_nlink to underflow to 0xffffffff.

xfs_iunlink_remove doesn't touch the link count.  I think Dave is
confused because of the misleading --show-c-function output.

> >> +
> >>      xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> >>
> >>      drop_nlink(VFS_I(ip));
> > Wait a second - this code doesn't match an upstream kernel. What
> > kernel did you make this patch against?
> It's kernel mainline linux-6.5-rc7

...and what did you use to generate the patch?  git diff?

--D

> 
> Thanks.
> > -Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
