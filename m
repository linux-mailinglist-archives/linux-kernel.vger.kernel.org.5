Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD917FC252
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjK1Q3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjK1Q3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:29:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C060DD63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:29:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6B0C433C7;
        Tue, 28 Nov 2023 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701188963;
        bh=sIfDB3k+KYyERGoUwnCBqm5HDGxlFAUPH4Qei1wkjhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRJlA/ahfz20AacKT1Y1Of4TQTFUwixgP9x+n+Zg8MxGoLrFbZzVTHlmzJngIXSlm
         KvLYlbeFcxtpgjYOd0ovo7GztyLiVOq5JXlC5Dd9H4ib7svMvynWpDVHQunFUsprXX
         y+JQek9omRrnQmyHDMu7fwOMPqOdqR2Ul9yPHyII2oMD6fQJapIdDj1ur79bGOuReh
         jGcfR1lIq7KAqSKRqVy/ENDogMR3xYmQ+i7Ulya2kJWRQfq0pquVD7mMLhjJRqtm0G
         20yTn3PpgX8vZ6vXdz8HUPGK9zlPiB0hApXFkEYbMLdDS5RzyMiwWtbO8zQ31nQ+yW
         Pg1g/c9WzmcQg==
Date:   Tue, 28 Nov 2023 08:29:21 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <20231128162921.GU2766956@frogsfrogsfrogs>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
 <ZWWnQYo73yHnctvi@infradead.org>
 <39b76473-fe00-0f1b-62e3-ae349a9f80d3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b76473-fe00-0f1b-62e3-ae349a9f80d3@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:39:50PM +0800, Jiachen Zhang wrote:
> On 2023/11/28 16:39, Christoph Hellwig wrote:
> > On Tue, Nov 28, 2023 at 01:32:02PM +0800, Jiachen Zhang wrote:
> > > From: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > 
> > > xfs_da3_swap_lastblock() copy the last block content to the dead block,
> > > but do not update the metadata in it. We need update some metadata
> > > for some kinds of type block, such as dir3 leafn block records its
> > > blkno, we shall update it to the dead block blkno. Otherwise,
> > > before write the xfs_buf to disk, the verify_write() will fail in
> > > blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.
> > 
> > Do you have a reproducer for this?  It would be very helpful to add it
> > to xfstests.
> 
> Hi Christoph,
> 
> Thanks for the review!
> 
> It's hard to reproduce the issue. Currently we can reproduce it with
> some kernel code changes. We forcely reserve 0 t_blk_res for xfs_remove
> on kernel version 4.19:
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index f2d06e1e4906..c8f84b95a0ec 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2551,13 +2551,8 @@ xfs_remove(
>          * insert tries to happen, instead trimming the LAST
>          * block from the directory.
>          */
> -       resblks = XFS_REMOVE_SPACE_RES(mp);
> -       error = xfs_trans_alloc(mp, &M_RES(mp)->tr_remove, resblks, 0, 0,
> &tp);
> -       if (error == -ENOSPC) {
> -               resblks = 0;
> -               error = xfs_trans_alloc(mp, &M_RES(mp)->tr_remove, 0, 0, 0,
> -                               &tp);
> -       }
> +       resblks = 0;
> +       error = xfs_trans_alloc(mp, &M_RES(mp)->tr_remove, 0, 0, 0, &tp);
>         if (error) {
>                 ASSERT(error != -ENOSPC);
>                 goto std_return
> 
> 
> After insmod the new modified xfs.ko, run the following scripts, and it
> can reproduce the problem consistently on the final `umount mnt`:
> 
> fallocate -l 1G xfs.img
> mkfs.xfs -f xfs.img
> mkdir -p mnt
> losetup /dev/loop0 xfs.img
> mount -t xfs /dev/loop0 mnt
> pushd mnt
> mkdir dir3
> prefix="a_"
> for j in $(seq 0 13); do
>     for i in $(seq 0 2800); do
>             touch dir3/${prefix}_${i}_${j}
>     done
>     for i in $(seq 0 2500); do
>             rm -f dir3/${prefix}_${i}_${j}
>             if [ "$i" == "2094" ] && [ "$j" == "13" ]; then
>                     echo "should reproduce now, so break here!"
>                     break;
>             fi
>     done
> done
> popd
> umount mnt
> 
> 
> We are still trying to make a reproducer without any kernel changes. Do
> you have any suggestions on this?

Add a debugging knob that calls xfs_da3_swap_lastblock without trying
bunmapi, modify the script to activate the knob, then that can be turned
into an fstest.

> 
> > 
> > > 
> > > We will get this warning:
> > > 
> > >    XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
> > >    XFS (dm-0): Unmount and run xfs_repair
> > >    XFS (dm-0): First 128 bytes of corrupted metadata buffer:
> > >    00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
> > >    000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
> > >    000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
> > >    00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
> > >    00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
> > >    000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
> > >    00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
> > >    0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
> > >    XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
> > >    XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
> > >    XFS (dm-0): Please umount the filesystem and rectify the problem(s)

Aha, that might explain the weird recovery failures that I've been
seeing every now and then with my parent pointer recovery stress test.

> > > 
> > > >From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
> > > its blkno is 0x1a0.
> > > 
> > > Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
> > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > ---
> > >   fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> > > index e576560b46e9..35f70e4c6447 100644
> > > --- a/fs/xfs/libxfs/xfs_da_btree.c
> > > +++ b/fs/xfs/libxfs/xfs_da_btree.c
> > > @@ -2318,8 +2318,18 @@ xfs_da3_swap_lastblock(
> > >   	 * Copy the last block into the dead buffer and log it.
> > >   	 */
> > >   	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
> > > -	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
> > >   	dead_info = dead_buf->b_addr;
> > > +	/*
> > > +	 * Update the moved block's blkno if it's a dir3 leaf block
> > > +	 */
> > > +	if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
> > > +	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
> > > +	    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
> > > +		struct xfs_da3_blkinfo *dap = (struct xfs_da3_blkinfo *)dead_info;
> > > +
> > > +		dap->blkno = cpu_to_be64(dead_buf->b_bn);

	dap->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));

(IOWs, please send patches against latest upstream, not 4.19.)

((Code looks good to me too, compile errors and style notwithstanding.))

--D

> > > +	}
> > > +	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
> > 
> > The fix here looks correct to me, but also a little ugly and ad-hoc.
> > 
> > At last we should be using container_of and not casts for getting from a
> > xfs_da_blkinfo to a xfs_da3_blkinfo (even if there is bad precedence
> > for the cast in existing code).
> > 
> 
> Thanks, we will optimize the code in the next version of the patchset.
> 
> > But I think it would be useful to add a helper that stamps in the blkno
> > in for a caller that only has as xfs_da_blkinfo but no xfs_da3_blkinfo
> > and use in all the places that do it currently in an open coded fashion
> > e.g. xfs_da3_root_join, xfs_da3_root_split, xfs_attr3_leaf_to_node.
> > 
> > That should probably be done on top of the small backportable fix.
> > 
> 
> I think the idea to add helper is great, and we can do it after this
> fixes patch is merged.
> 
> 
> Thanks,
> Jiachen
> 
> 
