Return-Path: <linux-kernel+bounces-14956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A728224FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9CA283128
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB61772E;
	Tue,  2 Jan 2024 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXIgUSAJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EC617728
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF529C433C8;
	Tue,  2 Jan 2024 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704236072;
	bh=BDXXal94Su2uaDJCUkGS/5w9XDeM8Wk9XYBMyM7Nyy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXIgUSAJIPast68Xs9QUwtAwEb5+BSCr0TB1o421tQFL8+5pnfBL1zyQa6b9v9egD
	 3OtmvJtck58DraxnNCz4+sbVzG/n/crMV/TeApm0tS+7MBFBEFhe+6FV7+YERN5ggb
	 O9duCK94c/aiKjVE6EmgUCFcthIM8pEVIdrObN/JBVT9qMjkwqs3Ml1jA2A+0k5pK7
	 136xGm69qonnce23kOtiZjXXbpGHVSx8sLEzkGGbaLRKERbD0b19NarsLRDaogT3qI
	 +Qdv7c6W59mlzJuzA0TsDff2dBCHdGWSVKuFgVCleyCQo6S0gxFNuPGDshRh5Qsvo/
	 FSVgUYqNGJ8XA==
Date: Tue, 2 Jan 2024 14:54:31 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] f2fs: fix to restrict condition of compress inode
 conversion
Message-ID: <ZZSUJxtwahorNVj5@google.com>
References: <20231210113547.3412782-1-chao@kernel.org>
 <20231210113547.3412782-5-chao@kernel.org>
 <ZXeJKCNrxcit0eTC@google.com>
 <5884e300-5384-4a49-9f8d-8cced50f4e6d@kernel.org>
 <ZXjc_I6__dijbwvN@google.com>
 <19a1340f-0a0d-40a0-9d00-0faf171480f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a1340f-0a0d-40a0-9d00-0faf171480f2@kernel.org>

On 12/28, Chao Yu wrote:
> On 2023/12/13 6:21, Jaegeuk Kim wrote:
> > On 12/12, Chao Yu wrote:
> > > On 2023/12/12 6:11, Jaegeuk Kim wrote:
> > > > On 12/10, Chao Yu wrote:
> > > > > This patch adds i_size check during compress inode conversion in order
> > > > > to avoid .page_mkwrite races w/ conversion.
> > > > 
> > > > Which race condition do you see?
> > > 
> > > Something like:
> > > 
> > > - f2fs_setflags_common
> > >   - check S_ISREG && F2FS_HAS_BLOCKS
> > > 					- mkwrite
> > > 					 - f2fs_get_block_locked
> > > 					  : update metadata in old inode's disk layout
> > 
> > Don't we need to prevent setting this for mmapped file?
> 
> Oh, we have used i_sem lock to prevent such race case, however
> we missed f2fs_disable_compressed_file():
> 
> - f2fs_disable_compressed_file
>  - check inode_has_data
> 						- f2fs_file_mmap
> 						- mkwrite
> 						 - f2fs_get_block_locked
> 						 : update metadata in compressed
> 						   inode's disk layout
>  - fi->i_flags &= ~F2FS_COMPR_FL
>  - clear_inode_flag(inode, FI_COMPRESSED_FILE);

So, needing i_sem for disabling it on mmapped file? It seems i_size would not
be enough?

> 
> Thanks,
> 
> > 
> > >   - set_compress_context
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/f2fs.h | 8 +++++++-
> > > > >    fs/f2fs/file.c | 5 ++---
> > > > >    2 files changed, 9 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > > index 65294e3b0bef..c9b8a1953913 100644
> > > > > --- a/fs/f2fs/f2fs.h
> > > > > +++ b/fs/f2fs/f2fs.h
> > > > > @@ -4397,13 +4397,19 @@ static inline int set_compress_context(struct inode *inode)
> > > > >    #endif
> > > > >    }
> > > > > +static inline bool inode_has_data(struct inode *inode)
> > > > > +{
> > > > > +	return (S_ISREG(inode->i_mode) &&
> > > > > +		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
> > > > > +}
> > > > > +
> > > > >    static inline bool f2fs_disable_compressed_file(struct inode *inode)
> > > > >    {
> > > > >    	struct f2fs_inode_info *fi = F2FS_I(inode);
> > > > >    	if (!f2fs_compressed_file(inode))
> > > > >    		return true;
> > > > > -	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> > > > > +	if (inode_has_data(inode))
> > > > >    		return false;
> > > > >    	fi->i_flags &= ~F2FS_COMPR_FL;
> > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > index 1a3c29a9a6a0..8af4b29c3e1a 100644
> > > > > --- a/fs/f2fs/file.c
> > > > > +++ b/fs/f2fs/file.c
> > > > > @@ -1922,8 +1922,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > > > >    			f2fs_down_write(&F2FS_I(inode)->i_sem);
> > > > >    			if (!f2fs_may_compress(inode) ||
> > > > > -					(S_ISREG(inode->i_mode) &&
> > > > > -					F2FS_HAS_BLOCKS(inode))) {
> > > > > +					inode_has_data(inode)) {
> > > > >    				f2fs_up_write(&F2FS_I(inode)->i_sem);
> > > > >    				return -EINVAL;
> > > > >    			}
> > > > > @@ -3996,7 +3995,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
> > > > >    		goto out;
> > > > >    	}
> > > > > -	if (F2FS_HAS_BLOCKS(inode)) {
> > > > > +	if (inode_has_data(inode)) {
> > > > >    		ret = -EFBIG;
> > > > >    		goto out;
> > > > >    	}
> > > > > -- 
> > > > > 2.40.1

