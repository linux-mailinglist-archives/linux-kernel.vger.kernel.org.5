Return-Path: <linux-kernel+bounces-99744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DB878C85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0751F21AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707DF5CB5;
	Tue, 12 Mar 2024 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBC17MX9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546B524F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208246; cv=none; b=BJrbZtGiJSxQWAHs0dry9aaW2fpxrTwhXLt8Vu3m3ziI2dvAIq3yj3YDb+yFVVwtnKOHrvpqo5xiOaEm0uz8zXNRjsLOxK2jgMQ9MfHYEX/FaCbFPhfUdVPLrzeRbcBVyl249QwcQcMxtMN6ZJUZhQPpxCezRldA86/iBtFeXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208246; c=relaxed/simple;
	bh=5Vj2yV+2iZB9axYtdEYLw/0P7M4zjDA+EOXF1F8+bj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFhSJ7HyXR3KzR20MRfL1/w/IUDeCO7P+ABYr1waE3Feu6nZFCB9voUR3FG/6/wZy5RPHY1JeS5psYRt/fCE1u9la0eb/obt6CjY9RZ2BRwXXAHwv6mBteLxBeiYRvV5cfJVMUAIgnNQCd3FaQM9wLhMyOibVJoX4w8LgI71mu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBC17MX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4002C433F1;
	Tue, 12 Mar 2024 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710208246;
	bh=5Vj2yV+2iZB9axYtdEYLw/0P7M4zjDA+EOXF1F8+bj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gBC17MX9N5hKrFKfv+SDVlZvZk2vy+HU8nJNig+SsIOQVL7pFiDqvb1Qs6t8Q5URP
	 Hlo1RL0Mb1wdqFc8fWfFKvMrzwDpSaiKsCnFFR3iFoxTVyrjKSx37AaBO+TGKXV2OI
	 PPU0/WOy4nAZTGU0It8k/dTKj0Iv6jUdp6expw+6iN/qgYakVdtnmkpm78IhyFj35K
	 WD5QhLWjCAwdLWbwRQ4ffqozgIFInGJv0TxaTqzDx/Uc0g0sSS30siRhOrSfrX/Ar+
	 Bu/jkV7ydVjIiQyCffeG+bPcOn60HE5Vin0gahBOfEyDjMgQt8yVE+BEF0so3M9UX1
	 60SZl+Cj2FZBQ==
Message-ID: <ed15e402-d888-453a-b0f4-3fcff069e5fd@kernel.org>
Date: Tue, 12 Mar 2024 09:50:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: prevent writing without fallocate()
 for pinned files
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240311235921.1832684-1-daeho43@gmail.com>
 <20240311235921.1832684-2-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240311235921.1832684-2-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/12 7:59, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/data.c | 7 +++++++
>   fs/f2fs/file.c | 4 ++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c21b92f18463..5e4c11a719a0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3378,6 +3378,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   		f2fs_map_lock(sbi, flag);
>   		locked = true;
>   	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
> +		if (f2fs_is_pinned_file(inode))
> +			return -EIO;
>   		f2fs_map_lock(sbi, flag);
>   		locked = true;
>   	}
> @@ -3407,6 +3409,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   
>   	if (!f2fs_lookup_read_extent_cache_block(inode, index,
>   						 &dn.data_blkaddr)) {
> +		if (f2fs_is_pinned_file(inode)) {
> +			err = -EIO;
> +			goto out;
> +		}

Daeho,

Do we need to check in DIO path as well?

Thanks,

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

