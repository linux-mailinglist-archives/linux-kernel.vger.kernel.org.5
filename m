Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7D7BE95A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377586AbjJISb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjJISb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8CD8;
        Mon,  9 Oct 2023 11:31:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22D3C433C7;
        Mon,  9 Oct 2023 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876309;
        bh=4gxbrpShdGC4qS8co5vAH5govaypuq0BqCjJYp1m48U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7PWTJiaos3J1quiROsIHMqb6CBB/nLNA3HsHDx0q/Q+WNLlX74D0FDfo2Ezk040B
         gmOGTgmDxaL845czpooTQ/FECgtYQpBPI5wzCN0hJNekpmkZTAK5NOcg296J74mjVE
         PkD3Wy1hInSOQ+wMsqmqTZeoy7rnjDeS6HCTBIyF0lj8HkfEK7YNSfbg+qq50y9AN8
         Eh6uuGkIcTlzrWJ9NYNtJjLvP01/UmPl/d/fkhO5+4V8ItqxbuabdS0ppQIawfi2KQ
         9XyB19nZ05+0LRUGRUF0/gfhN+o6KZTZdVfD1e4Kwyc4R1Rp6VwwgHDrbV6zxrebGN
         O1kC2UiEPiD/Q==
Date:   Mon, 9 Oct 2023 11:31:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cheng.lin130@zte.com.cn
Cc:     david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v5] xfs: introduce protection for drop nlink
Message-ID: <20231009183148.GA214073@frogsfrogsfrogs>
References: <202310091645572092816@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310091645572092816@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:45:57PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> When abnormal drop_nlink are detected on the inode,
> return error, to avoid corruption propagation.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---
>  fs/xfs/xfs_inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc500..752e6aeba 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -919,6 +919,14 @@ xfs_droplink(
>  	xfs_trans_t *tp,
>  	xfs_inode_t *ip)
>  {
> +

No need for the extra whitespace here.

> +	if (VFS_I(ip)->i_nlink == 0) {
> +		xfs_alert(ip->i_mount,
> +			  "%s: Attempt to drop inode (%llu) with nlink zero.",
> +			  __func__, ip->i_ino);
> +		return -EFSCORRUPTED;
> +	}

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> 
>  	drop_nlink(VFS_I(ip));
> -- 
> 2.18.1
