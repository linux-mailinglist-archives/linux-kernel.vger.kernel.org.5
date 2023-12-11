Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA480DE23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjLKWLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjLKWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:11:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9892
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:11:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA37DC433C8;
        Mon, 11 Dec 2023 22:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702332713;
        bh=p4mTC7IdUW3BAEiY7Fj43iN3lLzUWPhxoUHrJSl7/3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6FpIddV6KkFrsbZYmwd5978cZd8hXi0DUBNnP1fFB8t5jhRk2LSA6uAbSqbqWtDn
         hf3WEIxG8CtDMne3DwwDefG0cT1ge8VCDv+zUm9vcZ98ParJH8Ve67PiDDQd4y/Znb
         DbUOQ8Gj4XqkF/5PbwqKs4oufTkbEK2MdqY2MWwXwVKl7B2HDSUCNMDQVcq4/Pn0w5
         mOddCznAR+Y4UMbGAU52Q+TPFGAGaveohOhAHP+OmFlksfQRWFk8SaCtSEE6wweAFI
         OYvzFD3VvCY6KvGu2nPB0SsMKVHAgN6FWJbS487buXrS7azRGQ+rxzR/0l+btJzY2l
         DO+RXJPyeKHyg==
Date:   Mon, 11 Dec 2023 14:11:52 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] f2fs: fix to restrict condition of compress inode
 conversion
Message-ID: <ZXeJKCNrxcit0eTC@google.com>
References: <20231210113547.3412782-1-chao@kernel.org>
 <20231210113547.3412782-5-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210113547.3412782-5-chao@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, Chao Yu wrote:
> This patch adds i_size check during compress inode conversion in order
> to avoid .page_mkwrite races w/ conversion.

Which race condition do you see?

> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 8 +++++++-
>  fs/f2fs/file.c | 5 ++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..c9b8a1953913 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4397,13 +4397,19 @@ static inline int set_compress_context(struct inode *inode)
>  #endif
>  }
>  
> +static inline bool inode_has_data(struct inode *inode)
> +{
> +	return (S_ISREG(inode->i_mode) &&
> +		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
> +}
> +
>  static inline bool f2fs_disable_compressed_file(struct inode *inode)
>  {
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  
>  	if (!f2fs_compressed_file(inode))
>  		return true;
> -	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> +	if (inode_has_data(inode))
>  		return false;
>  
>  	fi->i_flags &= ~F2FS_COMPR_FL;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1a3c29a9a6a0..8af4b29c3e1a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1922,8 +1922,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  
>  			f2fs_down_write(&F2FS_I(inode)->i_sem);
>  			if (!f2fs_may_compress(inode) ||
> -					(S_ISREG(inode->i_mode) &&
> -					F2FS_HAS_BLOCKS(inode))) {
> +					inode_has_data(inode)) {
>  				f2fs_up_write(&F2FS_I(inode)->i_sem);
>  				return -EINVAL;
>  			}
> @@ -3996,7 +3995,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>  		goto out;
>  	}
>  
> -	if (F2FS_HAS_BLOCKS(inode)) {
> +	if (inode_has_data(inode)) {
>  		ret = -EFBIG;
>  		goto out;
>  	}
> -- 
> 2.40.1
