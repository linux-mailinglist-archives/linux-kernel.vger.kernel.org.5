Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3047874F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbjHXQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbjHXQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958919A5;
        Thu, 24 Aug 2023 09:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A78E64542;
        Thu, 24 Aug 2023 16:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E65BC433C8;
        Thu, 24 Aug 2023 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692893569;
        bh=O4XTL4rB4zuJHdhNExBFZy/du5pB054CERvuMKtJo04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zd172NVLZC5LbrmylYiXnh7Z4wYQFOSuJ7DDolfUA3DHLZG6W+sqb89yxtAaMibyP
         CPrfKx29DslsV3KU+HncJRlvwUTzBZfkesWbzwQzKST6pAlPlkck5+80JLq60V0zku
         JMjFUyHvbjFQreQLB0ie88gbJmApjOxgISZZqEQwX2JpFsyTTTz7HtzjFXX52muSs2
         ieXZjrwZ0wq52Q3eXu/NIexjplxgEH6qXSAMMUct6nmJE9jnDFtZ1rE6km73vFH5SI
         n464ftVY7dDile8dPkSyHM6q6oLsPc9CzfPN833JM0xZPMxHCG7yEaAZMmuNTqTrhW
         GhECdY5okFEvA==
Date:   Thu, 24 Aug 2023 09:12:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiang.yong5@zte.com.cn, wang.liang82@zte.com.cn,
        liu.dong3@zte.com.cn
Subject: Re: [PATCH] xfs: introduce protection for drop nlink
Message-ID: <20230824161248.GM11263@frogsfrogsfrogs>
References: <202308241543526473806@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308241543526473806@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
> directory to become unusable until the next xfs_repair run.
> 
> Introduce protection for drop nlink to reduce the impact of this.
> And produce a warning for directory nlink error during remove.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---
>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc5..536dbe4 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
>  	xfs_trans_t *tp,
>  	xfs_inode_t *ip)
>  {
> +	xfs_mount_t     *mp;
> +
> +	if (VFS_I(ip)->i_nlink == 0) {
> +		mp = ip->i_mount;
> +		xfs_warn(mp, "%s: Deleting inode %llu with no links.",
> +			 __func__, ip->i_ino);
> +		return 0;
> +	}
> +
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> 
>  	drop_nlink(VFS_I(ip));

I'm not sure how nlink would ever get to 0xFFFFFFFF since the VFS won't
let a link count exceed s_max_links, and XFS sets that to 0x7FFFFFFF.
Unless, of course, you did that outside of Linux.

That said, why wouldn't you /pin/ the link count at -1U instead of
allowing it to overflow to zero?

Could you please take a look at this patch that's waiting in my
submission queue?

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=inode-repair-improvements&id=05f5a82efa6395c92038e18e008aaf7154238f27

--D

> @@ -2442,7 +2451,12 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
>  	 */
>  	if (is_dir) {
>  		ASSERT(VFS_I(ip)->i_nlink >= 2);
> -		if (VFS_I(ip)->i_nlink != 2) {
> +		if (VFS_I(ip)->i_nlink < 2) {
> +			xfs_warn(ip->i_mount,
> +			"%s: Remove dir (inode %llu) with invalid links.",
> +				 __func__, ip->i_ino);
> +		}
> +		if (VFS_I(ip)->i_nlink > 2) {
>  			error = -ENOTEMPTY;
>  			goto out_trans_cancel;
>  		}
> -- 
> 1.8.3.1
