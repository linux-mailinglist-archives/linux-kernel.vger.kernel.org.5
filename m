Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2431B7FB470
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbjK1Ijd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjK1Ijc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:39:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A49D;
        Tue, 28 Nov 2023 00:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MBiIXNrb73AICT7WA99rxKEqLxagLVhyMJH3WI5+ja4=; b=zWz1azk3VLxkXYsQlPEi1xjc/b
        aDUAKoBcCKAtJSHGzPAXdG7Oh1RsrwqeNpCC1qZDwnPNC5muSd5auFDu1QWe+iLJ4lKJsa715dPyb
        bjX5hbgK4yG+VYVlGURf/OxkzYT0StuxL5nDHgkP1ENjGc9ZBBTpaBqIQN+FdDdFWGHvheBYKQ+7E
        YPQH2Ei4Ci9WIRDAXhOjk1lbnSRd52T3vNDb5eRxEzJWNp9G5DPAqQtub8ZOHXXUWRA20Ni4KvUvD
        7XFSp5NMWUtWaIKqzNMB/9LgNH2PJ1knUf01Q2sU3KGiICX2gk+JqiuEcWarsexGD/H39lczR3oZI
        oUl23Ewg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r7tcv-004Yn8-1K;
        Tue, 28 Nov 2023 08:39:29 +0000
Date:   Tue, 28 Nov 2023 00:39:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top
Subject: Re: [PATCH 2/2] xfs: update dir3 leaf block metadata after swap
Message-ID: <ZWWnQYo73yHnctvi@infradead.org>
References: <20231128053202.29007-1-zhangjiachen.jaycee@bytedance.com>
 <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128053202.29007-3-zhangjiachen.jaycee@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:32:02PM +0800, Jiachen Zhang wrote:
> From: Zhang Tianci <zhangtianci.1997@bytedance.com>
> 
> xfs_da3_swap_lastblock() copy the last block content to the dead block,
> but do not update the metadata in it. We need update some metadata
> for some kinds of type block, such as dir3 leafn block records its
> blkno, we shall update it to the dead block blkno. Otherwise,
> before write the xfs_buf to disk, the verify_write() will fail in
> blk_hdr->blkno != xfs_buf->b_bn, then xfs will be shutdown.

Do you have a reproducer for this?  It would be very helpful to add it
to xfstests.

> 
> We will get this warning:
> 
>   XFS (dm-0): Metadata corruption detected at xfs_dir3_leaf_verify+0xa8/0xe0 [xfs], xfs_dir3_leafn block 0x178
>   XFS (dm-0): Unmount and run xfs_repair
>   XFS (dm-0): First 128 bytes of corrupted metadata buffer:
>   00000000e80f1917: 00 80 00 0b 00 80 00 07 3d ff 00 00 00 00 00 00  ........=.......
>   000000009604c005: 00 00 00 00 00 00 01 a0 00 00 00 00 00 00 00 00  ................
>   000000006b6fb2bf: e4 44 e3 97 b5 64 44 41 8b 84 60 0e 50 43 d9 bf  .D...dDA..`.PC..
>   00000000678978a2: 00 00 00 00 00 00 00 83 01 73 00 93 00 00 00 00  .........s......
>   00000000b28b247c: 99 29 1d 38 00 00 00 00 99 29 1d 40 00 00 00 00  .).8.....).@....
>   000000002b2a662c: 99 29 1d 48 00 00 00 00 99 49 11 00 00 00 00 00  .).H.....I......
>   00000000ea2ffbb8: 99 49 11 08 00 00 45 25 99 49 11 10 00 00 48 fe  .I....E%.I....H.
>   0000000069e86440: 99 49 11 18 00 00 4c 6b 99 49 11 20 00 00 4d 97  .I....Lk.I. ..M.
>   XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 1423 of file fs/xfs/xfs_buf.c.  Return address = 00000000c0ff63c1
>   XFS (dm-0): Corruption of in-memory data detected.  Shutting down filesystem
>   XFS (dm-0): Please umount the filesystem and rectify the problem(s)
> 
> >From the log above, we know xfs_buf->b_no is 0x178, but the block's hdr record
> its blkno is 0x1a0.
> 
> Fixes: 24df33b45ecf ("xfs: add CRC checking to dir2 leaf blocks")
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> ---
>  fs/xfs/libxfs/xfs_da_btree.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
> index e576560b46e9..35f70e4c6447 100644
> --- a/fs/xfs/libxfs/xfs_da_btree.c
> +++ b/fs/xfs/libxfs/xfs_da_btree.c
> @@ -2318,8 +2318,18 @@ xfs_da3_swap_lastblock(
>  	 * Copy the last block into the dead buffer and log it.
>  	 */
>  	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
> -	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
>  	dead_info = dead_buf->b_addr;
> +	/*
> +	 * Update the moved block's blkno if it's a dir3 leaf block
> +	 */
> +	if (dead_info->magic == cpu_to_be16(XFS_DIR3_LEAF1_MAGIC) ||
> +	    dead_info->magic == cpu_to_be16(XFS_DIR3_LEAFN_MAGIC) ||
> +	    dead_info->magic == cpu_to_be16(XFS_ATTR3_LEAF_MAGIC)) {
> +		struct xfs_da3_blkinfo *dap = (struct xfs_da3_blkinfo *)dead_info;
> +
> +		dap->blkno = cpu_to_be64(dead_buf->b_bn);
> +	}
> +	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);

The fix here looks correct to me, but also a little ugly and ad-hoc.

At last we should be using container_of and not casts for getting from a
xfs_da_blkinfo to a xfs_da3_blkinfo (even if there is bad precedence
for the cast in existing code).

But I think it would be useful to add a helper that stamps in the blkno
in for a caller that only has as xfs_da_blkinfo but no xfs_da3_blkinfo
and use in all the places that do it currently in an open coded fashion
e.g. xfs_da3_root_join, xfs_da3_root_split, xfs_attr3_leaf_to_node.

That should probably be done on top of the small backportable fix.

