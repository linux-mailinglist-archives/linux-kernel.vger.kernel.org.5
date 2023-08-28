Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261B78A4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjH1Dag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjH1DaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:30:03 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D0127;
        Sun, 27 Aug 2023 20:29:59 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RYwzR3Frnz8XrRL;
        Mon, 28 Aug 2023 11:29:55 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 37S3To8B061842;
        Mon, 28 Aug 2023 11:29:50 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp06[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 28 Aug 2023 11:29:51 +0800 (CST)
Date:   Mon, 28 Aug 2023 11:29:51 +0800 (CST)
X-Zmail-TransId: 2b0864ec14afffffffff988-0518b
X-Mailer: Zmail v1.0
Message-ID: <202308281129517963677@zte.com.cn>
In-Reply-To: <ZOpuadBnaY5QxpVN@dread.disaster.area>
References: 20230825180201.GL17912@frogsfrogsfrogs,202308262254116460369@zte.com.cn,ZOpuadBnaY5QxpVN@dread.disaster.area
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <david@fromorbit.com>
Cc:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 37S3To8B061842
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64EC14B3.000/4RYwzR3Frnz8XrRL
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Aug 26, 2023 at 10:54:11PM +0800, cheng.lin130@zte.com.cn wrote:
> > > On Fri, Aug 25, 2023 at 04:32:22PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > > On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > >> From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > >> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
> > > > >> directory to become unusable until the next xfs_repair run.
> > > > >>
> > > > >> Introduce protection for drop nlink to reduce the impact of this.
> > > > >> And produce a warning for directory nlink error during remove.
> > > > >>
> > > > >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > >> ---
> > > > >>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
> > > > >>  1 file changed, 15 insertions(+), 1 deletion(-)
> > > > >>
> > > > >> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > >> index 9e62cc5..536dbe4 100644
> > > > >> --- a/fs/xfs/xfs_inode.c
> > > > >> +++ b/fs/xfs/xfs_inode.c
> > > > >> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
> > > > >>      xfs_trans_t *tp,
> > > > >>      xfs_inode_t *ip)
> > > > >>  {
> > > > >> +    xfs_mount_t     *mp;
> > > > >> +
> > > > >> +    if (VFS_I(ip)->i_nlink == 0) {
> > > > >> +        mp = ip->i_mount;
> > > > >> +        xfs_warn(mp, "%s: Deleting inode %llu with no links.",
> > > > >> +             __func__, ip->i_ino);
> > > > >> +        return 0;
> > > > >> +    }
> > > > >> +
> > > > >>      xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> > > > >>
> > > > >>      drop_nlink(VFS_I(ip));
> > > > > I'm not sure how nlink would ever get to 0xFFFFFFFF since the VFS won't
> > > > > let a link count exceed s_max_links, and XFS sets that to 0x7FFFFFFF.
> > > > > Unless, of course, you did that outside of Linux.
> > > > In VFS drop_nlink() only produce a warning, when (inode->i_nlink == 0),
> > > > not prevent its self-reduce(inode->__i_nlink--), cause it underflow
> > > > from 0 to 0xffffffff.
> > > It is interesting that vfs_unlink doesn't check the link counts of
> > > either the parent or the child.  Maybe it should, since the VFS
> > > link/mkdir/rename functions check.
> > > I wonder if this is a historical leftover from the days when the VFS
> > > did no checking at all?
> > VFS produce a warning means it has discovered an abnormal situation.
> > I don't know why it just produce a warning. But, in other fs like
> > fuse/nfs/overlayfs/ext4, there is further protection for this situation.
> Well, the question is how the link count got corrupted in the first
> place....
> > > > In the old kernel version, this situation was
> > > > encountered, but I don't know how it happened. It was already a scene
> > > > with directory errors: "Too many links".
> How do you overflow the directory link count in XFS? You can't fit
> 2^31 unique names in the directory data segment - the directory will
> ENOSPC at 32GB of name data, and that typically occurs with at most
> 300-500 million dirents (depending on name lengths) in the
> directory.
> IOWs, normal operation shouldn't be able overflow the directory link
> count at all, and so underruns shouldn't occur, either.
Customer's explanation: in the nlink incorrect directory, not many directories
will be created, and normally there are only 2 regular files.
And only found this one directory with incorrect nlink when xfs_repair.
  systemd-fsck[5635]: Phase 2 - using internal log
  systemd-fsck[5635]: - zero log...
  systemd-fsck[5635]: - scan filesystem freespace and inode maps...
  systemd-fsck[5635]: agi unlinked bucket 9 is 73 in ag 22 (inode=23622320201)
  systemd-fsck[5635]: - 21:46:00: scanning filesystem freespace - 32 of 32 allocation groups done
  systemd-fsck[5635]: - found root inode chunk
  ...
  systemd-fsck[5635]: Phase 7 - verify and correct link counts...
  systemd-fsck[5635]: resetting inode 23622320201 nlinks from 4294967284 to 2
  systemd-fsck[5635]: - 22:06:34: verify and correct link counts - 32 of 32 allocation groups done
  systemd-fsck[5635]: done
> > > >  kernel: WARNING: CPU: 12 PID: 12928 at fs/inode.c:286 drop_nlink+0x3e/0x50
> > > >  kernel: CPU: 12 PID: 12928 Comm: gbased Tainted: G        W  OE  ------------ T 3.10.0-693.21.1.el7.x86_64 #1
> So this is a RHEL 7 kernel, and it is tainted with unknown out of
> tree (3rd party) kernel modules. Hence if could be memory corruption
> from whatever drivers are loaded.  It's also old enough that it is
> posible this is a v4 filesystem, and if so, it could be that storage
> media corruption occurred and it wasn't detected.
> > > >  kernel: Hardware name: HPE ProLiant BL460c Gen10/ProLiant BL460c Gen10, BIOS I41 01/23/2021
> > > >  kernel: Call Trace:-------------------
> > > >  kernel: [<ffffffff816c5fce>] dump_stack+0x19/0x1b
> > > >  kernel: [<ffffffff8108dfa8>] __warn+0xd8/0x100/*
> > > >  kernel: [<ffffffff8108e0ed>] warn_slowpath_null+0x1d/0x20
> > > >  kernel: [<ffffffff8122cdfe>] drop_nlink+0x3e/0x50
> > > >  kernel: [<ffffffffc03cdc78>] xfs_droplink+0x28/0x60 [xfs]
> > > >  kernel: [<ffffffffc03cf87a>] xfs_remove+0x2aa/0x320 [xfs]
> > > >  kernel: [<ffffffffc03c9f7a>] xfs_vn_unlink+0x5a/0xa0 [xfs]
> > > >  kernel: [<ffffffff8121f19c>] vfs_rmdir+0xdc/0x150
> > > >  kernel: [<ffffffff81221e41>] do_rmdir+0x1f1/0x220
> > > >  kernel: [<ffffffff81223046>] SyS_rmdir+0x16/0x20
> > > >  kernel: [<ffffffff816d86d5>] system_call_fastpath+0x1c/0x21
> Without actually knowing the root cause, and directory link count
> overflows not being possible in normal operation, I'm not sure that
> we should be jumping to conclusions that the directory link count
> code in the upstream kernel is actually broken and needs fixing.
> > > > > That said, why wouldn't you /pin/ the link count at -1U instead of
> > > > > allowing it to overflow to zero?
> > > > > Could you please take a look at this patch that's waiting in my
> > > > > submission queue?
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=inode-repair-improvements&id=05f5a82efa6395c92038e18e008aaf7154238f27
> This is protecting against regular files with too many hardlinks;
> a directory will never have the link count set to XFS_NLINK_PINNED
> because it just can't have that many entries in it....
> > > > I think the XFS_NLINK_PINNEED(~0U) can be used prevent Overflow in inc_nlink().
> > > > Is it better to compare i_nlink with (0U) in drop_nlink() to prevent Underflow?
> > > > (like this patch does, do not make i_nlink underflow from 0 to 0xffffffff)
> > > Is it a problem if a directory i_nlink underflows to XFS_NLINK_PINNED?
> > > At that point the directory will never be freed, and xfs_repair/scrub
> > > get to figure out the correct link count.
> I think that's wrong. The directory inode gets unlinked when the
> link count goes to zero, before the underflow occurs and can be
> detected. i.e. The warning occurs when the link could goes from 0 to
> -1 and this is after it has been unlinked on the transition between
> 1 to 0. If there are more entries removed from the directory at this
> point, the NLINK_PINNED detection then kicks in and we don't drop
> the nlink of the directory any further.
> But at this point, the damage has already been done - the directory
> is on the unlinked list at this point, and now it has a non-zero
> nlink count which means the VFS will not drop the inode and it
> remains cached. i.e. we have a corrupt runtime state where an inode
> is on the unlinked list yet isn't scheduled for inactivation/freeing
> when the last reference to it goes away. Indeed, inactivation won't
> trigger unlinked list removal, either, because the link count is not
> zero.
> I suspect at this point we have multiple on-disk corruptions in the
> filesystem. The parent directory points to an inode on the unlinked
> list, and if we crash at this point we have an inode on the unlinked
> that will be skipped by the recovery code because i_nlink is not
> zero (same iput_final/drop_inode problem). This ends up with a
> corrupt in-memory unlinked list on the next mount (i.e. inode on the
> list that isn't in memory...), and nothing good happens from that...
> > > --D
> > Yes, with i_nlink underflows to XFS_NLINK_PINNED, the directory will become
> > unavailable until be repaired. But the running service on this directory will be
> > failed. If i_nlink is protected from underflow, the use of the directory can continue,
> > and the continuity of services is guaranteed. The incorrect count also will be fixed
> > at next repair.
> I think that given what an underflow represents - some kind of
> corruption - and the fact that it can propagate in nasty ways if we
> allow operation to continue, we should be shutting down the
> filesystem if we detect an underflow on a directory inode. This will
> force repair of the filesystem as soon as possible.
> IOWs, we're already in bad situation when this warning is issued for
> directories, and so not dropping the nlink count after it has
> already underflowed doesn't matter one bit - we should be shutting
> down the filesystem, not trying to continue onwards as it nothing
> happened...
> Cheers,
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
If it's just a incorrect count of one dicrectory, after ignore it, the fs
can work normally(with error). Is it worth stopping the entire fs
immediately for this condition?
