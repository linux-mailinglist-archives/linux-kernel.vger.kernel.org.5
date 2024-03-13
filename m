Return-Path: <linux-kernel+bounces-101035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD787A100
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A591F22A19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234DBA27;
	Wed, 13 Mar 2024 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlSXJSso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA7B654
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710294695; cv=none; b=aUd43DgY2d+UdWpQ/kjC5pQ9RaWtsEEioUVjo+VwwlIHDhoPccprmR9TKCmoYHY1J59aNOAgQ5Vk0IJOWp8vYHQz7byFL+U3s9w2zCQUeWuIinHLhnkOfLyXJ/jZis7nUKMNdoz3g2kT/Zn3HJzVHDRbzTD62eANLx65Z6RBgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710294695; c=relaxed/simple;
	bh=4kOZOKrwpxycV31Soe7VOjD1j4/cP7uDCINqygA075M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQZIye/OmszkrLbOEC6Vz7v0vGjcE4wIg9RUu/GuNgk434REyJfsw1sX+Au11OUcdvghUEW8EpGqh0qVZwPIqC9/BihaSacSQE8SEYgnOVN1/UCSsH34h0QZS1Rw2Q9McVe3tIoEcuzl5aTpcAFdraw5PN+ENE3Aa5QvMvTeajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlSXJSso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D13C433F1;
	Wed, 13 Mar 2024 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710294694;
	bh=4kOZOKrwpxycV31Soe7VOjD1j4/cP7uDCINqygA075M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BlSXJSsoEXr62v5CronP73gke/CQqDUcgdnXWx6npy6aPeRl5ixS96WvB2+4yACse
	 bNipCUllfqCXvzUkzgTaIo5x0KxFXfDFLqujzd97rxlYfJHvK3x9v3yVYc/ae5JrFS
	 lqpTQwcJ4iWSnNgn+0B7FMlvZA7fOe1upIydbgeHtiEnNhD51kgx4a0+mFSjVFCDha
	 biMmBOj4IAIeQ/TtBdXk+hye/I99gMDeUGeOR7t8Sxf+JaMyAFF/ZMYUKmZ8PSl/Hh
	 HlbBkjAQd81rCVBNRNYUd9plvvlf0IJXTl/YdHcDxMOnEALg5STJoxTpngisGjc2ME
	 rZEP/saa8AveA==
Message-ID: <9fefaf48-fdd8-491f-8d5d-6a57286e6071@kernel.org>
Date: Wed, 13 Mar 2024 09:51:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240312204934.2249696-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240312204934.2249696-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/13 4:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: covered the direct io case

Oh, one more missed case, mkwrite?

Thanks,

> ---
>   fs/f2fs/data.c | 14 ++++++++++++--
>   fs/f2fs/file.c |  4 ++++
>   2 files changed, 16 insertions(+), 2 deletions(-)
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
> index 82277e95c88f..f98730932fc4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4611,6 +4611,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
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

