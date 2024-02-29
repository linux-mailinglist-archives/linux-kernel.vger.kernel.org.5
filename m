Return-Path: <linux-kernel+bounces-86519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4B86C676
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661628B16E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3363504;
	Thu, 29 Feb 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7dYoOTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A8634FE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201401; cv=none; b=M4vZg9drazBq8XmxgVAEYsHNzP8QEZ4AjaVlH5c0tcZUIPVs4YzRuUTtlilfX07b1q4fZZCXyOJdm39NfSSX8FCtDG8dSosUNcFaDyhTpOsJ0yd8m72wdbCnfq6RfekaxuJV4QOry3cu1ZdoG4IHFlJ4KDaCBdUNtjxvHPyYWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201401; c=relaxed/simple;
	bh=NFCnMoMrVuC4cCuJvgRycjqyC2YcWg3DtXlKvOroRlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hi3JRTawwtMOqAXyQrNzT9YSgbTQC0mmU7QG50yAXG54PEG8sNW3qkoJbJGwMwYoJKk5EW9pw6T0JRCYCICHgoEVewJJ01vOM2gJ1qTUbwqCWBxOUMrj0fxuV3k+qSd3S1xZm7HCmrLj/oSUFR5TXd93PQw/g+i4xhcMFY21OVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7dYoOTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CA8C433C7;
	Thu, 29 Feb 2024 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201401;
	bh=NFCnMoMrVuC4cCuJvgRycjqyC2YcWg3DtXlKvOroRlc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7dYoOTyoUUwJfUYKS8oc/GOmVFCi8gYJOMVwQbnlmCkF71wUj/BjdSpyavLaqZAF
	 /yr1BrQ4NDTDhRqWHMrV6k5OtKvz0ncEGnszdFth4oVSBafR9nc3kcrpvxSfXl6kZz
	 PLjtxRSsf5QuzJ+CKvdXlBvik7E7v2mzKPGPIb3+WDmc4FrFyNH7B51w2e8KmgUUBh
	 DkAUyzz9sQ72N6vTA7Ht5/glAnJlC3jBMWQCQuNEDnniCiBhij7ERX6x/W93UbIyZV
	 dgtYvgHoNTqbhz4MAnlx80D1XtTPFJM4hs+egJ9ueV/Bf3tGygu6NxEzZnemyxjfBZ
	 U8DWDAUF7NBFg==
Message-ID: <2b81aa6f-db51-4a7c-97ab-2af2c2fea056@kernel.org>
Date: Thu, 29 Feb 2024 18:09:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] f2fs: fix blkofs_end correctly in
 f2fs_migrate_blocks()
Content-Language: en-US
To: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240226013208.2389246-1-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240226013208.2389246-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jaegeuk, Daeho,

Any comments on this serials?

Thanks,

On 2024/2/26 9:32, Chao Yu wrote:
> In f2fs_migrate_blocks(), when traversing blocks in last section,
> blkofs_end should be (start_blk + blkcnt - 1) % blk_per_sec, fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/data.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c21b92f18463..0c728e82d936 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3841,13 +3841,14 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	unsigned int blkofs;
>   	unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
> +	unsigned int end_blk = start_blk + blkcnt - 1;
>   	unsigned int secidx = start_blk / blk_per_sec;
>   	unsigned int end_sec;
>   	int ret = 0;
>   
>   	if (!blkcnt)
>   		return 0;
> -	end_sec = secidx + (blkcnt - 1) / blk_per_sec;
> +	end_sec = end_blk / blk_per_sec;
>   
>   	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>   	filemap_invalidate_lock(inode->i_mapping);
> @@ -3857,7 +3858,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>   
>   	for (; secidx <= end_sec; secidx++) {
>   		unsigned int blkofs_end = secidx == end_sec ?
> -			(blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
> +				end_blk % blk_per_sec : blk_per_sec - 1;
>   
>   		f2fs_down_write(&sbi->pin_sem);
>   

