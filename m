Return-Path: <linux-kernel+bounces-124197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E368E8913BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E911F22F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD73F9FA;
	Fri, 29 Mar 2024 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1l/nezy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31220319
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693522; cv=none; b=jFXTai8YR5fAtn8R7ZrAm+LDicm9klLQegALRUQXRi88wKTQYWsXNzRW1J9sXI/vlW2NS96ut81JQqzC1eYMkehmMKj8LORQuKJhv4DgJZnFV5eHZc7v1wzkZ+lIKB9W0QUEth6sgo16WgCmDLs6i5tDQDdn1BPMqfKQIiH8V8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693522; c=relaxed/simple;
	bh=vUpji8lxw+W9+6bxPOhocySoPz9eyx3y0fD1yHTt1v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dh3lbjzCzc66AdLbX8l15Z/eq7GP6zXxAldccGY082AULA/otylHb+MeGQ4wDT23gASQVJWgB/olbzT2bEj8JyMb3N12WF13A9nB7ESHNoux10ubGieMGGS4/hjmKYe0W+unjDMvaguvJk+uN1Y8w25UhDVwA3/SkkgbjFwhNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1l/nezy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9815C433F1;
	Fri, 29 Mar 2024 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711693521;
	bh=vUpji8lxw+W9+6bxPOhocySoPz9eyx3y0fD1yHTt1v4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S1l/nezyA+C9Xgtn9Texc5PiloCR+CjIGemPR69MRn4mNBh/+0+aT7iNIC0RJCjtT
	 yoTVbPUYlfy1NDIBbuCVDHfnsfaj9nvz6os5TQyvG8eqWyQzMzxswYuJAvT7gU3QLF
	 KBVaiuk+K/ebD3MIKxS73xsMgwwusddvMr/eKPxV8S4aFY9qP+XnKGfucfKKEpYqyz
	 +r4MHg1s/CxLvKTCo2cnt+nMZQmNDMwtdZ+Y9aejGtB7AzJpJxA8ie92KGKWFig13J
	 eXLF6o+CdM9FdHmbDO6LHV3BJgxn/XU7xmxdfOpV0SVyqhdZwGSptvPRoWW0khSlfI
	 PtU4ghkPLbSDQ==
Message-ID: <2afb0fcb-afb6-4cb6-bfa2-e8e186f79d8c@kernel.org>
Date: Fri, 29 Mar 2024 14:25:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240326203130.85748-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240326203130.85748-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/27 4:31, Daeho Jeong wrote:
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
> ---
>   fs/f2fs/data.c | 20 ++++++++++++++++----
>   fs/f2fs/file.c | 18 +++++++++---------
>   2 files changed, 25 insertions(+), 13 deletions(-)
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
> index 82277e95c88f..7aa53cf553a1 100644
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
> @@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
>   	}

It needs to check dn.data_blkaddr for pinfile? return EIO if it hits a hole?

Thanks,

> -#endif
> +
>   	if (err) {
>   		unlock_page(page);
>   		goto out_sem;
> @@ -3235,7 +3231,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>   		goto done;
>   	}
>   
> -	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
> +	if (F2FS_HAS_BLOCKS(inode)) {
>   		ret = -EFBIG;
>   		goto out;
>   	}
> @@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
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

