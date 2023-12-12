Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52980FA65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377793AbjLLWVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377794AbjLLWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:21:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C41AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:21:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC89C433C8;
        Tue, 12 Dec 2023 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702419710;
        bh=7cFmARrm89ttXaBnHHYYiLAUlMe92Q5W0oinMKe/Nkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcVIj+O5K6fJib72hHCkhW8pY6ilbGEl1+BDS7PkuYLwv8FPD136erGw3w/y1gvJe
         Lu1p1PPwCsnYxvsBkSOmMoKkt6NAa4mrFPwg5rGPr1KyDTTVVE6y+Dli0Y+YeFMT6J
         e8/mO/DEm0mmiKKVLb4seY7iYuhO0Ey9S5YxfGNFt2tN/NC8F9fMgm67DSEpt8nnyz
         WNaZNHaUSk7dJieU7LoPmqg8ca0aiAO/JlvkIckHVT07l6nWBowIWUS/uSrNvCQtgU
         ASkxWyE5FRrQFmZQhBCPD/IZf2ujOnjGThHfTuXHxiugSS2ZConsrC+A/RU/WS0myL
         CsqwKnEcu9u7A==
Date:   Tue, 12 Dec 2023 14:21:48 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] f2fs: fix to restrict condition of compress inode
 conversion
Message-ID: <ZXjc_I6__dijbwvN@google.com>
References: <20231210113547.3412782-1-chao@kernel.org>
 <20231210113547.3412782-5-chao@kernel.org>
 <ZXeJKCNrxcit0eTC@google.com>
 <5884e300-5384-4a49-9f8d-8cced50f4e6d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5884e300-5384-4a49-9f8d-8cced50f4e6d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Chao Yu wrote:
> On 2023/12/12 6:11, Jaegeuk Kim wrote:
> > On 12/10, Chao Yu wrote:
> > > This patch adds i_size check during compress inode conversion in order
> > > to avoid .page_mkwrite races w/ conversion.
> > 
> > Which race condition do you see?
> 
> Something like:
> 
> - f2fs_setflags_common
>  - check S_ISREG && F2FS_HAS_BLOCKS
> 					- mkwrite
> 					 - f2fs_get_block_locked
> 					  : update metadata in old inode's disk layout

Don't we need to prevent setting this for mmapped file?

>  - set_compress_context
> 
> Thanks,
> 
> > 
> > > 
> > > Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/f2fs.h | 8 +++++++-
> > >   fs/f2fs/file.c | 5 ++---
> > >   2 files changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 65294e3b0bef..c9b8a1953913 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -4397,13 +4397,19 @@ static inline int set_compress_context(struct inode *inode)
> > >   #endif
> > >   }
> > > +static inline bool inode_has_data(struct inode *inode)
> > > +{
> > > +	return (S_ISREG(inode->i_mode) &&
> > > +		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
> > > +}
> > > +
> > >   static inline bool f2fs_disable_compressed_file(struct inode *inode)
> > >   {
> > >   	struct f2fs_inode_info *fi = F2FS_I(inode);
> > >   	if (!f2fs_compressed_file(inode))
> > >   		return true;
> > > -	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> > > +	if (inode_has_data(inode))
> > >   		return false;
> > >   	fi->i_flags &= ~F2FS_COMPR_FL;
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 1a3c29a9a6a0..8af4b29c3e1a 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -1922,8 +1922,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > >   			f2fs_down_write(&F2FS_I(inode)->i_sem);
> > >   			if (!f2fs_may_compress(inode) ||
> > > -					(S_ISREG(inode->i_mode) &&
> > > -					F2FS_HAS_BLOCKS(inode))) {
> > > +					inode_has_data(inode)) {
> > >   				f2fs_up_write(&F2FS_I(inode)->i_sem);
> > >   				return -EINVAL;
> > >   			}
> > > @@ -3996,7 +3995,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> > >   		goto out;
> > >   	}
> > > -	if (F2FS_HAS_BLOCKS(inode)) {
> > > +	if (inode_has_data(inode)) {
> > >   		ret = -EFBIG;
> > >   		goto out;
> > >   	}
> > > -- 
> > > 2.40.1
