Return-Path: <linux-kernel+bounces-93208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA4872C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3665B27247
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB679DE;
	Wed,  6 Mar 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEfbDRIV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362256FBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689923; cv=none; b=Vy4tfDzXvguHUycyndLczq9BrgEOUBPHZsfhj+qGeKLrLSerltFgBEpJggtuSBD97A1wFJvdmkan8oDgv6RqZeJdJQeg1wbs+cFP5MQbPPovmHaVTWa7fhMPvW6uU/S16/OSXG2wyx39qnYBZZDEnqbXYeUpGxttCCr+AOEniE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689923; c=relaxed/simple;
	bh=pjR8YIBGq1VNa51QiHXbbJg32nHSnWWaN8QomRREMxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFK0XL5RXKs1z8mGn/G1czPdc5LIkmweML7pIZtAaFYWdMoo9Sm7nuPENRvvhy7FUQ02Pp65LsjrrY8wky5H2cdBDBdRYwgD7gU1vat8Rx66zYyH7sE4A4CcjfT1oK+2FGAMXpANTaoVZJN+v5ggfXf+yiVAPFjrRt8h+1FR0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEfbDRIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A360EC433F1;
	Wed,  6 Mar 2024 01:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689922;
	bh=pjR8YIBGq1VNa51QiHXbbJg32nHSnWWaN8QomRREMxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mEfbDRIVBOG3N/to2d9M9OyD8pavLacY7xA6M0dCBYF3+yCwNfpKJHE6PZY9aSkyK
	 fxOg3yMuv9s6UwhwvaRHtz7NcMpxGTFX0yJRb3F0GqjdGT/As8DLtfzP1XUwnbzf7M
	 abS0A2sQH5ZHwcUPJu99IfhR31tYhQe5lJk5MCUVx/a9g0Of21GX2fMb9+S2hiG3cU
	 6Iiby7rxMELga0D8EgoYLg3n28/cqAx0a3sMruRb7oC6KdypIyF0+cWz/5nElMqfW0
	 5IJXL14zQJsqo3g0FziOt2u0dXLUStgqxeR5QESaB0pz93VzENEzJIdnNdTJfx6Qrd
	 yHYRhP//SuDmQ==
Message-ID: <61637917-440e-4ed1-8820-fc7af8b8b4f3@kernel.org>
Date: Wed, 6 Mar 2024 09:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: compress: relocate some judgments in
 f2fs_reserve_compress_blocks
Content-Language: en-US
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xiuhong.wang.cn@gmail.com
References: <20240305084023.3686070-1-xiuhong.wang@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240305084023.3686070-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/5 16:40, Xiuhong Wang wrote:
> The following f2fs_io test will get a "0" result instead of -EINVAL,
> unisoc # ./f2fs_io compress file
> unisoc # ./f2fs_io reserve_cblocks file
>   0
> it's not reasonable, so the judgement of
> atomic_read(&F2FS_I(inode)->i_compr_blocks) should be placed after
> the judgement of is_inode_flag_set(inode, FI_COMPRESS_RELEASED).
> 
> Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/file.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4ca6c693b33a..572d7bd4d161 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3720,18 +3720,18 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   	if (ret)
>   		return ret;
>   
> -	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
> -		goto out;
> -
>   	f2fs_balance_fs(sbi, true);
>   
>   	inode_lock(inode);
>   
>   	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
>   		ret = -EINVAL;
> -		goto unlock_inode;

Nitpick, maybe keep unlock_inode label is better.

> +		goto out;
>   	}
>   
> +	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
> +		goto out;

goto unlock_inode

Thanks,

> +
>   	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>   	filemap_invalidate_lock(inode->i_mapping);
>   
> @@ -3776,9 +3776,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>   		inode_set_ctime_current(inode);
>   		f2fs_mark_inode_dirty_sync(inode, true);
>   	}
> -unlock_inode:
> -	inode_unlock(inode);
>   out:
> +	inode_unlock(inode);
>   	mnt_drop_write_file(filp);
>   
>   	if (ret >= 0) {

