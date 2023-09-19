Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1C7A57E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjISDby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjISDbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:31:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3121710E;
        Mon, 18 Sep 2023 20:31:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C131BC433C8;
        Tue, 19 Sep 2023 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695094306;
        bh=nvqgHfDJCZ+60fWr3N7pdaz5K4+PP37HC3/I0Jy5NuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5xHjgQwSJXbB2/DNsyXVpFuF1DSVtFbYjs+fbzR2FJsEIy/QRJRkwaSyKhx0z9sS
         z860uiDvcuMaDXQXbLxezLnOzMO8SZUmzmr9b0Vnjwh1VocnyIVjRMBENkUWq6RVT/
         lf5e7R2/9m/vF2xmTye5OWUBMpYbrJwilioMJ004rK70eUjTgXoVDZnbW8+yKCk4CV
         GNZwlCdouG0rKTifUm8esD+U/06CIgmBWP2rnTx8gdlPpUD1PIzd08mUVozV25S71J
         vrna9Gux5+2a0Aw9FfTf/7Ff2brA9QR1m7EQwZ8l5O5dfMiwlJKZhAfSKjmb0VTYzo
         q4XK1IWZyqFZA==
Date:   Mon, 18 Sep 2023 20:31:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v4] xfs: introduce protection for drop nlink
Message-ID: <20230919033146.GE348018@frogsfrogsfrogs>
References: <202309181450509388561@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309181450509388561@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:50:50PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> When abnormal drop_nlink are detected on the inode,
> return error, to avoid corruption propagation.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---
>  fs/xfs/xfs_inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc500..d16cb62ce 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -919,6 +919,14 @@ xfs_droplink(
>  	xfs_trans_t *tp,
>  	xfs_inode_t *ip)
>  {
> +
> +	if (VFS_I(ip)->i_nlink == 0) {
> +		xfs_alert(ip->i_mount,
> +			  "%s: Deleting inode %llu with no links.",
> +			  __func__, ip->i_ino);

We're not deleting the zero-nlink file, since we return without changing
the link count.

Also wondering why this doesn't use XFS_IS_CORRUPT?  That macro already
logs a message about there being problems:

	struct xfs_mount	*mp = ip->i_mount;

	if (XFS_IS_CORRUPT(mp, VFS_I(ip)->i_nlink == 0))
		return -EFSCORRUPTED;

--D

> +		return -EFSCORRUPTED;
> +	}
> +
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> 
>  	drop_nlink(VFS_I(ip));
> -- 
> 2.18.1
