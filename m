Return-Path: <linux-kernel+bounces-27695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91A82F440
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30403B23A99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAC1CFB5;
	Tue, 16 Jan 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB6XfClO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF961CFA7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429765; cv=none; b=YbmFY2NDVxz+ra0/0o0cGA+XfY/DTpG2RuhnNpsyrIk/ESfaX4FpRf1/kyQjiGYkr08rTDEI7+SuwShz1CfZPpAUljZxi6eqLlL5DdK9FY48pC7/wyODWLkZWoNrIdIAjOy4kQyPrKKbdzfF6DvkCKbop0ifT89EQik5n/uxFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429765; c=relaxed/simple;
	bh=k0lm4Z5pZVIlvdj47Fd18SEn4w3dqXV3sFaKUhK4hEM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=obrAVNnxQ/uwWINyrBveguCnGXwMAgKq3Gd+ud72WaqYIpmSXZswsvz6E8r2khCBgaFm3MCLDDus/N6MclRrMNMa24skcWDxFR4dlg/Eqq+MGlMl/aiAuCtygmjFC46AkpCbT/HPXUmb8kTvSmJoCsUKtrohuWtjgDdHyMolAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB6XfClO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA09C433C7;
	Tue, 16 Jan 2024 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429765;
	bh=k0lm4Z5pZVIlvdj47Fd18SEn4w3dqXV3sFaKUhK4hEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB6XfClOzBAfEBHRluVhODZXPZDeUZgArWeFPXFNr02Zdq1FLIGhIlKeH8VSrcb+Z
	 s2CL8dfZW7zawGzP50trc+Nmo6XhMEc3ObvL8cH4OU6aROKEvrxyMyyqMykh7z4fe7
	 E/bgUXnEzautBuJ0TiaOCIz0DC7KdsFwm+2iCzt7mfuoKPtrODERpDjWqWnlLE286C
	 4y7fnad67uxrR47FOJsAHoVr85/4JS3U4o5alWlILPbEM/CfQm0QLMSHOnZHLG0dOu
	 p0bf293g9y6vXpMOgp7e4zpjF8UerC3kEIKw9V81tuC0qkxDVwOZXtWQlJRWhdrQL8
	 eGlR0EiNS4dzg==
Date: Tue, 16 Jan 2024 10:29:23 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: compress: fix to cover
 f2fs_disable_compressed_file() w/ i_sem
Message-ID: <ZabLA4EWNzNFGb5Q@google.com>
References: <20240111064406.2970205-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111064406.2970205-1-chao@kernel.org>

On 01/11, Chao Yu wrote:
> - f2fs_disable_compressed_file
>   - check inode_has_data
> 					- f2fs_file_mmap
> 					- mkwrite
> 					 - f2fs_get_block_locked
> 					 : update metadata in compressed
> 					   inode's disk layout
>   - fi->i_flags &= ~F2FS_COMPR_FL
>   - clear_inode_flag(inode, FI_COMPRESSED_FILE);
> 
> we should use i_sem lock to prevent above race case.
> 
> Meanwhile, this patch adds i_size check to restrict compress inode
> conversion condition.

Sorry, what was the reason to check i_size?

> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 18 ++++++++++++++++--
>  fs/f2fs/file.c |  5 ++---
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 74729db0b381..e2e0ca45f881 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4406,19 +4406,33 @@ static inline int set_compress_context(struct inode *inode)
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
> -	if (!f2fs_compressed_file(inode))
> +	f2fs_down_write(&F2FS_I(inode)->i_sem);
> +
> +	if (!f2fs_compressed_file(inode)) {
> +		f2fs_up_write(&F2FS_I(inode)->i_sem);
>  		return true;
> -	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
> +	}
> +	if (f2fs_is_mmap_file(inode) || inode_has_data(inode)) {
> +		f2fs_up_write(&F2FS_I(inode)->i_sem);
>  		return false;
> +	}
>  
>  	fi->i_flags &= ~F2FS_COMPR_FL;
>  	stat_dec_compr_inode(inode);
>  	clear_inode_flag(inode, FI_COMPRESSED_FILE);
>  	f2fs_mark_inode_dirty_sync(inode, true);
> +
> +	f2fs_up_write(&F2FS_I(inode)->i_sem);
>  	return true;
>  }
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0e4c871d6aed..5e5df234eb92 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1926,8 +1926,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  
>  			f2fs_down_write(&F2FS_I(inode)->i_sem);
>  			if (!f2fs_may_compress(inode) ||
> -					(S_ISREG(inode->i_mode) &&
> -					F2FS_HAS_BLOCKS(inode))) {
> +					inode_has_data(inode)) {
>  				f2fs_up_write(&F2FS_I(inode)->i_sem);
>  				return -EINVAL;
>  			}
> @@ -4011,7 +4010,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
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

