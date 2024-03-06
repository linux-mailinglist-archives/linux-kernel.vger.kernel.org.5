Return-Path: <linux-kernel+bounces-93226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B924872C83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFD9285CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F550D29B;
	Wed,  6 Mar 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUfvk2ar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF46FBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690533; cv=none; b=dDO5wyJERIaNK/hB9TSKpJYlENIHGJE6Nlv5mLWBpewk9cukb3mD3vQ6qbmoJdrenbhylWV6Gusm9pvc5yQlN4YxHypbp0ZIpVoMBwnDASp+9/bqBogZrY9wDg06hUfOv58JfSOV0TDgu909lM5qVkFdrs+jb/FGM9kKa6b6NHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690533; c=relaxed/simple;
	bh=SqTqs8brnRlrOZ5UQ84OFtXIsP8I8DaSL4YqK61FhFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMHeXAlJ0X0ijMrrrJCmRoWcBeR4koeO5fqsgEVcHZ2HaduMgRqFEP3QtSWrZjiINV2LRUC/tVqz6qVDORON71hCVF21ePWvBPFbA0nQAu2E6npWiXUwnj6VcC541ddvUGQeXGx1y/pr/bks7kkQomoavKu6YqpIgVXNHW6M8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUfvk2ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D2AC43330;
	Wed,  6 Mar 2024 02:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709690533;
	bh=SqTqs8brnRlrOZ5UQ84OFtXIsP8I8DaSL4YqK61FhFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eUfvk2ar4wNc3wSGfsc6XVaxtcbMnX30g4OKHea/TZ1iPjUum/UDOrmkvPECKTXjZ
	 QtPl2A4SPSZCnpXx2WhY396QXfCy/dYB9AELjdhcI2WzhGcGjc5lzmLQwc/RItKOEj
	 JcHIzffzcr1rRPy4cwRosQ1qRvLAVZmWr0OaCK9alQWUSF/OKS4hcGNVrVGye0T0xg
	 sNa6cP4N0dJohnStgTkb7QkKiRUBeolVbOoL2Te0vRUtFucXVB+WYpt3x0AjgQ/H3D
	 xRkzY7wdjeupc6wC3SnS5PkHJwm9cCGTZZkKcJ8nfzXmep9av9/A1yYnNDb+nuw51Q
	 iklqA+dxA1INg==
Message-ID: <f4bc07b0-a32b-4074-a66e-9388cb1b4461@kernel.org>
Date: Wed, 6 Mar 2024 10:02:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: compress: fix reserve_cblocks counting error
 when out of space
Content-Language: en-US
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xiuhong.wang.cn@gmail.com
References: <20240305084023.3686070-1-xiuhong.wang@unisoc.com>
 <20240305084023.3686070-2-xiuhong.wang@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240305084023.3686070-2-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/5 16:40, Xiuhong Wang wrote:
> When a file only needs one direct_node, performing the following
> operations will cause the file to be unrepairable:
> 
> unisoc # ./f2fs_io compress test.apk
> unisoc #df -h | grep dm-48
> /dev/block/dm-48 112G 112G 1.2M 100% /data
> 
> unisoc # ./f2fs_io release_cblocks test.apk
> 924
> unisoc # df -h | grep dm-48
> /dev/block/dm-48 112G 112G 4.8M 100% /data
> 
> unisoc # dd if=/dev/random of=file4 bs=1M count=3
> 3145728 bytes (3.0 M) copied, 0.025 s, 120 M/s
> unisoc # df -h | grep dm-48
> /dev/block/dm-48 112G 112G 1.8M 100% /data
> 
> unisoc # ./f2fs_io reserve_cblocks test.apk
> F2FS_IOC_RESERVE_COMPRESS_BLOCKS failed: No space left on device
> 
> adb reboot
> unisoc # df -h  | grep dm-48
> /dev/block/dm-48             112G 112G   11M 100% /data
> unisoc # ./f2fs_io reserve_cblocks test.apk
> 0
> 
> This is because the file has only one direct_node. After returning
> to -ENOSPC, reserved_blocks += ret will not be executed. As a result,
> the reserved_blocks at this time is still 0, which is not the real
> number of reserved blocks. Therefore, fsck cannot be set to repair
> the file.
> 
> After this patch, the fsck flag will be set to fix this problem.
> 
> unisoc # df -h | grep dm-48
> /dev/block/dm-48             112G 112G  1.8M 100% /data
> unisoc # ./f2fs_io reserve_cblocks test.apk
> F2FS_IOC_RESERVE_COMPRESS_BLOCKS failed: No space left on device
> 
> adb reboot then fsck will be executed
> unisoc # df -h  | grep dm-48
> /dev/block/dm-48             112G 112G   11M 100% /data
> unisoc # ./f2fs_io reserve_cblocks test.apk
> 924
> 
> Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/file.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 572d7bd4d161..97a7233c7ea7 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3624,10 +3624,10 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>   	return ret;
>   }
>   
> -static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
> +static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
> +		unsigned int *reserved_blocks)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> -	unsigned int reserved_blocks = 0;
>   	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>   	block_t blkaddr;
>   	int i;
> @@ -3691,12 +3691,12 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   
>   		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
>   
> -		reserved_blocks += reserved;
> +		*reserved_blocks += reserved;
>   next:
>   		count -= cluster_size;
>   	}
>   
> -	return reserved_blocks;
> +	return 0;
>   }
>   
>   static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
> @@ -3740,6 +3740,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   	while (page_idx < last_idx) {
>   		struct dnode_of_data dn;
>   		pgoff_t end_offset, count;
> +		unsigned int tmp_reserved_blocks;
>   
>   		set_new_dnode(&dn, inode, NULL, NULL, 0);
>   		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
> @@ -3757,7 +3758,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
>   		count = round_up(count, F2FS_I(inode)->i_cluster_size);
>   
> -		ret = reserve_compress_blocks(&dn, count);
> +		ret = reserve_compress_blocks(&dn, count, &tmp_reserved_blocks);

How about passing &reserved_blocks into reserve_compress_blocks()?

Thanks,

> +		reserved_blocks += tmp_reserved_blocks;
>   
>   		f2fs_put_dnode(&dn);
>   
> @@ -3765,13 +3767,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   			break;
>   
>   		page_idx += count;
> -		reserved_blocks += ret;
>   	}
>   
>   	filemap_invalidate_unlock(inode->i_mapping);
>   	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>   
> -	if (ret >= 0) {
> +	if (!ret) {
>   		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
>   		inode_set_ctime_current(inode);
>   		f2fs_mark_inode_dirty_sync(inode, true);
> @@ -3780,7 +3781,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   	inode_unlock(inode);
>   	mnt_drop_write_file(filp);
>   
> -	if (ret >= 0) {
> +	if (!ret) {
>   		ret = put_user(reserved_blocks, (u64 __user *)arg);
>   	} else if (reserved_blocks &&
>   			atomic_read(&F2FS_I(inode)->i_compr_blocks)) {

