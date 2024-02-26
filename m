Return-Path: <linux-kernel+bounces-80385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD618667A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C804C1F21868
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19515ACB;
	Mon, 26 Feb 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrNjPLsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51E14AB2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708911621; cv=none; b=Hjrk1tPwdPbYig/m17FuSLYoZYF2m91m9YIqVTpLLUuJlGXYnqJ5hisW1K2LOOQg20rBoNn58ep/Jfl9nr4mJBNehOQxq75Wy7YoWmxKnFEopb61LnDRxQDH2anzD9V0w5hGhU/i0FpTcoF70gHBeI6I/2C7jSC4XJzkKcOtc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708911621; c=relaxed/simple;
	bh=E+V1Y4RQYIY8ckr4RlbF6c3RFkZOqY1GrMDaYw72cxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCFLu0VNTWZupDzlmWEgcq3q6aewHLn0WHjvMFhjjaEitQ3sW/6wWxoTqwOFxB2ZIv06p2RoTus7y2BRe2DOHZsAXn2Y7yNXRNVSp37E2K2qQ2n82iE52fHdHQrHdjH32MAXUZsZciyElk2X+6ET1L6KzEJZD6A7S4ojLIJXrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrNjPLsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5D2C433F1;
	Mon, 26 Feb 2024 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708911620;
	bh=E+V1Y4RQYIY8ckr4RlbF6c3RFkZOqY1GrMDaYw72cxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KrNjPLsGKW+WDzp1mlaF7lz3WHQC+OTR01ypNb7let1Gi5PcJWumQ24Yer40nXFFw
	 U9oAnFIbKgH54Nbrd0X2KDy4bDTVdXKb5+19bei6CzSBTE0JVPSRZu0y4A7f4WK+59
	 iZvr/6ZVmEmQLghSf1uAZBQO6FccfOrYq74Yx0Rkmc7I6zWUJhmGBkx6BdhKr5YErr
	 rCtA0QjYYSVZkUS4+ay4pvq4eGI7AhmYdIlbyJkoR1m3Z02O0cpRI+qDo10nFRoRKv
	 pL+1MMeE0BZ36tP7ZvJkUtVFfFKOMIwCU0eQExuQvrYNsomJ3dJP+68WRRx2mmlbUK
	 gpquzszhZWWiA==
Message-ID: <af7ee622-d4ab-42ed-96b2-35d1d95e4cb6@kernel.org>
Date: Mon, 26 Feb 2024 09:40:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: compress: reserve blocks on released compress inode
 while writing
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240110091009.138206-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240110091009.138206-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/10 17:10, Yangtao Li wrote:
> Reserve blocks on released compress inode while writing, so
> compressed files with released space are allowed to be rewritten.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 86 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 51 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 15dabeac4690..749b5af17141 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3612,39 +3612,15 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   	return reserved_blocks;
>   }
>   
> -static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
> +static int f2fs_reserve_file(struct inode *inode, unsigned int *blocks)

f2fs_do_reserve_compress_blocks()?

>   {
> -	struct inode *inode = file_inode(filp);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	pgoff_t page_idx = 0, last_idx;
>   	unsigned int reserved_blocks = 0;
>   	int ret;
>   
> -	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> -		return -EOPNOTSUPP;
> -
> -	if (!f2fs_compressed_file(inode))
> -		return -EINVAL;
> -
> -	if (f2fs_readonly(sbi->sb))
> -		return -EROFS;
> -
> -	ret = mnt_want_write_file(filp);
> -	if (ret)
> -		return ret;
> -
> -	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
> -		goto out;
> -
>   	f2fs_balance_fs(F2FS_I_SB(inode), true);
>   
> -	inode_lock(inode);
> -
> -	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
> -		ret = -EINVAL;
> -		goto unlock_inode;
> -	}
> -
>   	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>   	filemap_invalidate_lock(inode->i_mapping);
>   
> @@ -3688,14 +3664,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
>   		inode->i_ctime = current_time(inode);
>   		f2fs_mark_inode_dirty_sync(inode, true);
> -	}
> -unlock_inode:
> -	inode_unlock(inode);
> -out:
> -	mnt_drop_write_file(filp);
> -
> -	if (ret >= 0) {
> -		ret = put_user(reserved_blocks, (u64 __user *)arg);
> +		if (blocks)
> +			*blocks = reserved_blocks;
>   	} else if (reserved_blocks &&
>   			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
>   		set_sbi_flag(sbi, SBI_NEED_FSCK);
> @@ -3710,6 +3680,49 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   	return ret;
>   }
>   
> +static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	unsigned int reserved_blocks = 0;
> +	int ret;
> +
> +	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
> +		return -EOPNOTSUPP;
> +
> +	if (!f2fs_compressed_file(inode))
> +		return -EINVAL;
> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
> +		goto out;
> +
> +	inode_lock(inode);
> +
> +	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
> +		ret = -EINVAL;
> +		goto unlock_inode;
> +	}
> +
> +	ret = f2fs_reserve_file(inode, &reserved_blocks);
> +
> +unlock_inode:
> +	inode_unlock(inode);
> +out:
> +	mnt_drop_write_file(filp);
> +
> +	if (ret >= 0)
> +		ret = put_user(reserved_blocks, (u64 __user *)arg);
> +
> +	return ret;
> +}
> +
>   static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
>   		pgoff_t off, block_t block, block_t len, u32 flags)
>   {
> @@ -4412,8 +4425,11 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
>   	if (IS_IMMUTABLE(inode))
>   		return -EPERM;
>   
> -	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
> -		return -EPERM;
> +	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
> +		err = f2fs_reserve_file(inode, NULL);

How about reserving blocks after generic_write_checks() in
f2fs_file_write_iter()?

Thanks,


> +		if (err < 0)
> +			return err;
> +	}
>   
>   	count = generic_write_checks(iocb, from);
>   	if (count <= 0)

