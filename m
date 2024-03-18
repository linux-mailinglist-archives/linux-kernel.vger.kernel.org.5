Return-Path: <linux-kernel+bounces-105933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E6A87E696
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E06628188F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E332D044;
	Mon, 18 Mar 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRuIEI42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB02CCB3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756128; cv=none; b=guxhbWM5Q8Z/nBsmesrI2rUQ/T+TJyUkJ+gvFIA7UCHFKANQrZZNFrRHlSYFObUM/QJuQHRKEFi/Bs9z9EweQw8iK2Pw6YTtmUiebmVV5eJMTJII0YBDmUxup/gmBaI9oTrHzvoYsuc/rsnn422mz+JBFCn/NisfrFWw9wxIoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756128; c=relaxed/simple;
	bh=tda4FiMnApu30+uRV6hFBxyOyzn56uatU22g6W/0XNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebZOqURarvtnv5ahoUcwUJZVJDO1IngxawhTpu+ANvPPSmedu7ccnDOBiE7fcxDZa2FXAjTuZaSDACaGySVLRa8dF4WzTkl2webqKFXbo/f08ovwNdRcdsBrZOHgLx42dKh9KUnpjtG46afb6qL4iMNcQiKUQtjWATJZOBqUKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRuIEI42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C3CC433C7;
	Mon, 18 Mar 2024 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710756128;
	bh=tda4FiMnApu30+uRV6hFBxyOyzn56uatU22g6W/0XNE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vRuIEI42/m8mXeK6NKPHMDBhhvp0FuEujMLhLBq4QLB/RLzytZtRHLoONHaYdX5xm
	 /EATDIF6JGteWt7sHr4TlYY+5lTgKc/c1z+uu+dMwHjvirUE+D+NVbzjuH8SVctD8j
	 9Hl7EvLlFUITixFAJerQsT8RNTvOznr+XyuOKGHc5/fEapHHKS+aVccmcyRHH5Togi
	 PAZy2k/vyr/7WmxRRaRt6aiZdn6CXULpsjr3S0qYEYEryIUUkrsnhDdYDi5QGCt4m4
	 XlXrysdkRDGyP8cLWRrIr6wi9NBPrV1z1tEFcEfTCAskvC5LRkIN85xHGS8hlTj9R/
	 z0w+FiUb2FLFA==
Message-ID: <d25da09b-282e-48ae-a0e3-ad89b26fe8ab@kernel.org>
Date: Mon, 18 Mar 2024 18:02:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: add REQ_TIME time update for some user behaviors
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1710502356-11469-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1710502356-11469-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/15 19:32, Zhiguo Niu wrote:
> some user behaviors requested filesystem operations, which
> will cause filesystem not idle.
> Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2: update patch according to Chao's suggestions
> ---
> ---
>   fs/f2fs/file.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1761ad1..8c9d6ea 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2354,13 +2354,14 @@ static bool uuid_is_nonzero(__u8 u[16])
>   static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
>   {
>   	struct inode *inode = file_inode(filp);
> +	int ret;
>   
>   	if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
>   		return -EOPNOTSUPP;
>   
> +	ret = fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
>   	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> -
> -	return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
> +	return ret;
>   }
>   
>   static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
> @@ -2786,7 +2787,8 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>   	err = f2fs_defragment_range(sbi, filp, &range);
>   	mnt_drop_write_file(filp);
>   
> -	f2fs_update_time(sbi, REQ_TIME);
> +	if (range.len)
> +		f2fs_update_time(sbi, REQ_TIME);
>   	if (err < 0)
>   		return err;
>   
> @@ -3599,6 +3601,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>   
>   	filemap_invalidate_unlock(inode->i_mapping);
>   	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:

if (released_blocks)
	f2fs_update_time();

>   	inode_unlock(inode);
>   
> @@ -3768,6 +3771,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
>   		inode_set_ctime_current(inode);
>   		f2fs_mark_inode_dirty_sync(inode, true);
> +		f2fs_update_time(sbi, REQ_TIME);
>   	}
>   unlock_inode:

if (reserved_blocks)
	f2fs_update_time();

Thanks,

>   	inode_unlock(inode);
> @@ -3966,6 +3970,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>   	if (len)
>   		ret = f2fs_secure_erase(prev_bdev, inode, prev_index,
>   				prev_block, len, range.flags);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	filemap_invalidate_unlock(mapping);
>   	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> @@ -4175,6 +4180,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>   	if (ret)
>   		f2fs_warn(sbi, "%s: The file might be partially decompressed (errno=%d). Please delete the file.",
>   			  __func__, ret);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	inode_unlock(inode);
>   	file_end_write(filp);
> @@ -4254,6 +4260,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
>   	if (ret)
>   		f2fs_warn(sbi, "%s: The file might be partially compressed (errno=%d). Please delete the file.",
>   			  __func__, ret);
> +	f2fs_update_time(sbi, REQ_TIME);
>   out:
>   	inode_unlock(inode);
>   	file_end_write(filp);

