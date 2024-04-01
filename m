Return-Path: <linux-kernel+bounces-126398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C668936C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93953281E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB5EDE;
	Mon,  1 Apr 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQdDr8Xo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825A10E5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711935998; cv=none; b=sR2REGLP6/SSMs/3sr1hLFXi5zg1uOHs9PWSvghvm264DI3RSeB6WWJwe7VR4HTTnwerZGr7rkGnn0kHKGsY3F+xYEpsOunJp/b6L13CqBcpFYD3H5KO8saq19BUpLhz0OvyuRlbrWbck/UQZKM7C5XKtKm55ARAjbDH7yoZ2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711935998; c=relaxed/simple;
	bh=n3Cg0Rt5TLrDEys702tEPBe46QCsW8f9s+oMuGbfLkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjv5ntd49nsxaaiDCzJ7/SD0TjQs6sY3RrI6CCR+46xjYEfjS5AqldexBqRvcMvz81/BH0SYxKUG2T1Yixw6tXTVGr6MbPT8px78av9rch0WD2MjgdE7tEAYxvO2POjk5TVIUctLWXCqNcbfWsG5OAtPZS2nMoDwLnKAQ5fm2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQdDr8Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F186C433F1;
	Mon,  1 Apr 2024 01:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711935998;
	bh=n3Cg0Rt5TLrDEys702tEPBe46QCsW8f9s+oMuGbfLkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vQdDr8XofZ2TMfnX7FAAYbjaLXBv3dbgMZASp4rc9zGlBvl7QgOEiyK0q7Be/tvYD
	 I3gu5BDlIlsdUWJXD1JlSaBUsGDuUr9ePXpisxqCfUHiBxREsRsVbXz7+JKxfNGXGn
	 F5veV3CZtKzBW5rfiEoMBIdBw3JEHjJiNea5hp3BKQ1avNdK4+a+A2aq1qIlDRGkSQ
	 LwA6LE/GqKQNyRpgw4Z+4RHjv0AOqHYSuloESsHSV+S0DP5g2nRUJZh7CN9GCWsJiC
	 QxJeBdfBXZnt1rcnkJ5cbrWI9M+a9PjI7fA8TaAR2txuVRrmP+TGNnH3HNMgYPUr+z
	 6gP7cAbvKz8dw==
Message-ID: <4514eda4-0e32-4529-8b45-43222fbf739b@kernel.org>
Date: Mon, 1 Apr 2024 09:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240329191324.3233324-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240329191324.3233324-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/30 3:13, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage. To make it consistent across
> storage devices, we disallow it regardless of storage device types.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: covered the direct io case
> v3: covered the mkwrite case
> v4: moved pin file check position in prepare_write_begin()
> v5: removed unnecessary condition in f2fs_map_blocks() and disallowed
>      pre-written inodes for file pinning
> v6: check a hole for pinned files in mkwrite()
> ---
>   fs/f2fs/data.c | 20 ++++++++++++++++----
>   fs/f2fs/file.c | 20 +++++++++++---------
>   2 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c21b92f18463..1b02a9291176 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>   
>   	/* use out-place-update for direct IO under LFS mode */
>   	if (map->m_may_create &&
> -	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
> -		if (unlikely(f2fs_cp_error(sbi))) {
> +	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
> +			 !f2fs_is_pinned_file(inode)))) {
> +		if (unlikely(f2fs_cp_error(sbi)) ||
> +		    (f2fs_is_pinned_file(inode) &&
> +		     flag != F2FS_GET_BLOCK_PRE_DIO)) {
>   			err = -EIO;
>   			goto sync_out;
>   		}
> @@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   		f2fs_map_lock(sbi, flag);
>   		locked = true;
>   	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
> +		if (f2fs_is_pinned_file(inode))
> +			return -EIO;
>   		f2fs_map_lock(sbi, flag);
>   		locked = true;
>   	}
> @@ -3414,8 +3419,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   
>   		/* hole case */
>   		err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> -		if (!err && dn.data_blkaddr != NULL_ADDR)
> -			goto out;
> +		if (!err) {
> +			if (dn.data_blkaddr != NULL_ADDR) {
> +				goto out;
> +			} else if (f2fs_is_pinned_file(inode)) {
> +				err = -EIO;
> +				goto out;
> +			}
> +		}
> +
>   		f2fs_put_dnode(&dn);
>   		f2fs_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO);
>   		WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82277e95c88f..6793c96019a2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   	struct inode *inode = file_inode(vmf->vma->vm_file);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct dnode_of_data dn;
> -	bool need_alloc = true;
> +	bool need_alloc = !f2fs_is_pinned_file(inode);
>   	int err = 0;
>   	vm_fault_t ret;
>   
> @@ -114,19 +114,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   		goto out_sem;
>   	}
>   
> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
>   	if (need_alloc) {
>   		/* block allocation */
> -		set_new_dnode(&dn, inode, NULL, NULL, 0);
>   		err = f2fs_get_block_locked(&dn, page->index);
> -	}
> -
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
> -	if (!need_alloc) {
> -		set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	} else {
>   		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>   		f2fs_put_dnode(&dn);
> +		if (f2fs_is_pinned_file(inode) && dn.data_blkaddr == NULL_ADDR)

if (f2fs_is_pinned_file(inode) && !__is_valid_data_blkaddr(dn.data_blkaddr))

Thanks,

> +			err = -EIO;
>   	}
> -#endif
> +
>   	if (err) {
>   		unlock_page(page);
>   		goto out_sem;
> @@ -3235,7 +3233,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>   		goto done;
>   	}
>   
> -	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
> +	if (F2FS_HAS_BLOCKS(inode)) {
>   		ret = -EFBIG;
>   		goto out;
>   	}
> @@ -4611,6 +4609,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>   			return ret;
>   	}
>   
> +	/* For pinned files, it should be fallocate()-ed in advance. */
> +	if (f2fs_is_pinned_file(inode))
> +		return 0;
> +
>   	/* Do not preallocate blocks that will be written partially in 4KB. */
>   	map.m_lblk = F2FS_BLK_ALIGN(pos);
>   	map.m_len = F2FS_BYTES_TO_BLK(pos + count);

