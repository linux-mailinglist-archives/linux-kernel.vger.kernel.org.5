Return-Path: <linux-kernel+bounces-108701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B67880ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD776286F52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60D23B7A8;
	Wed, 20 Mar 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/VSNi34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0C3B78B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927532; cv=none; b=kXq0XiuhM+sZrJfjYX3TLSeLS1dIaazAT0CndPqDSPgo1rEWXCyi6APgpoiIW7IxmMHlSEVnbR5HilnKPUrAET1A2FsL1qnjRpuT3tWnaZe0u/9y0mGooHKORqDY6re9deHQWxxptlQTn5awrdy/iQKmZ98hQWFhkg+3/aC0f90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927532; c=relaxed/simple;
	bh=UWse2gnglAhc0xH0tJ6cvCLFl6BybxmQUSri4I1gnCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu5+GBFPQAshfFSHYiGBaC11pNvewAoYulBHZfZLCsRizHjsCHTaAdNwlLUg+JBMQFtLQFNYrZZzXiP+7dgLFXlLREEXxbiDzEXEyteGZXgiiCcD8cBKXxcxglSphCfMh/F5sOEHXsIS9oQj9173ybKZdOVZNQdgrxWNihBpDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/VSNi34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7449BC433C7;
	Wed, 20 Mar 2024 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927531;
	bh=UWse2gnglAhc0xH0tJ6cvCLFl6BybxmQUSri4I1gnCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g/VSNi34xdeWKPPNl+yWc9i0lyu0OKx5oneBkuQiq0/DsBsUPx4jJ7z5bjoYv9ImP
	 eqLOEncrr+uJ87Tn72fi6zFRdfLQ22t8K+8cTDsjwcKeUDIHUt1CL0e8fTov/d1ysh
	 AYOBgNP8/G0rqW3GlcX8lD0v9+fGkBFSughf0dYLzUz54k96t+6wOjvRBKBzz0Okdc
	 ZREp8Vmvwm+gYhHNtPtH6FGbXfzSnJcZrjnb9cZv6b/CbJvyVzFnfqIFy+gH1Zv8yk
	 tpCCfGJoXzBUKGN+WKO4lHEWeSxQVO7kHJvKSVWwO4KEuebjzO7xT7oguoML5bAoru
	 o4a97AaZOq9Rg==
Message-ID: <712f380c-68ef-4743-bd9b-7342e838ced7@kernel.org>
Date: Wed, 20 Mar 2024 17:38:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240319212316.4193790-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240319212316.4193790-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/20 5:23, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: covered the direct io case
> v3: covered the mkwrite case
> ---
>   fs/f2fs/data.c | 14 ++++++++++++--
>   fs/f2fs/file.c | 16 ++++++++--------
>   2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c21b92f18463..d3e5ab2736a6 100644
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
> +		    (f2fs_is_pinned_file(inode) && is_hole &&
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
> @@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   
>   	if (!f2fs_lookup_read_extent_cache_block(inode, index,
>   						 &dn.data_blkaddr)) {
> +		if (f2fs_is_pinned_file(inode)) {
> +			err = -EIO;
> +			goto out;
> +		}
> +
>   		if (locked) {
>   			err = f2fs_reserve_block(&dn, index);
>   			goto out;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82277e95c88f..4db3b21c804b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   	struct inode *inode = file_inode(vmf->vma->vm_file);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct dnode_of_data dn;
> -	bool need_alloc = true;
> +	bool need_alloc = !f2fs_is_pinned_file(inode);

Will this check races w/ pinfile get|set?

Thanks,

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
> -#endif
> +
>   	if (err) {
>   		unlock_page(page);
>   		goto out_sem;
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

