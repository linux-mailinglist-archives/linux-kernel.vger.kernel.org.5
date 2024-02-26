Return-Path: <linux-kernel+bounces-80417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD88866847
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2841F21ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3BF4E2;
	Mon, 26 Feb 2024 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6+HRb/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749C817
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915245; cv=none; b=ruTV0J6OW3EOtDacZgXJQ3d53zHCtc3emhdjaneB15KibTsmfMXw0EtdIbJjv3+oeEMjp7E6AfTVv3i5K+r3ual9V62qBJHOXKZ9Yx625hW5JWVNK1jH7a0nwyceoslcoFMVBm6CirC4eK8ghJ0BqvLiQWLcQ71ynALtDvZRpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915245; c=relaxed/simple;
	bh=DuGF9S4m4uhmiHy72DnJgIonHHmX99UDPQZHNKqVFP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xz+uC5XU3PjJMSWx3OElauLs9dkQuvur5FBzqeQ479uEJm+KFHn/Ke+TWZZSRmIAN8CeYPhLrR8cdv8HcXbBAd9AX2dMEOsDzppoSCCeymQYx4wQ9uhd5gNqX7A4D+vDHCy7MoC0VXMd7rzrMQ1aZjnRGkhkOVPNWMSvdYqqNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6+HRb/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3693CC433F1;
	Mon, 26 Feb 2024 02:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708915245;
	bh=DuGF9S4m4uhmiHy72DnJgIonHHmX99UDPQZHNKqVFP4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=F6+HRb/9hWHnekgZ+zmflcvQfEybBYrxw8KGD0fT7IoNYR+T09ePn8ZhQqQpmAKCt
	 T71rbKStsjrTOarQmZhP7H4NFyyLWgr6iJkv04hsYvOfZgVKPC62tyPd2EV4L9C8Bg
	 SpnS/gVfqrZYUJKm7g6RhMSmBiQbvyIs69lA/8oLxhKW+hbL1aIElUc2GvuWAv4NUi
	 sGPYkLTPb1K9S2zQY5LHfeEqBXhM5BESicI/1A/ThQQeEINVbVmd2EEf4r+/JCj7J1
	 mDvS0zf9iEmNaDgyLsZRJLnQkHpah6zgr6BjQdn2rgYh45nlJLSMtJcfzRs+o1icyv
	 inYsj1VB/ehjA==
Message-ID: <afa444c5-7ac1-457e-9559-6d7c6623c426@kernel.org>
Date: Mon, 26 Feb 2024 10:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: check number of blocks in a current
 section
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/24 4:55, Jaegeuk Kim wrote:
> In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
> the number of blocks in a section instead of the segment.
> 
> In addtion, let's check the entire node sections when checking the avaiable
> node block space. It does not match one to one per temperature, but currently

I tested this patch w/ testcase in [1], it doesn't complain.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215914

> we don't have exact dirty page count per temperature. Hence, use a rough
> estimation.

Do we need more accurate per-temperature dirty node count for extreme
corner case?

e.g. node_blocks is counted from hot dirty nodes, and current hot_node
log has no enough free space for it.

Thanks,

> 
> Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/segment.h | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 3edd3809b6b5..15bf5edd9b3c 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -561,23 +561,23 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>   			unsigned int node_blocks, unsigned int dent_blocks)
>   {
>   
> -	unsigned int segno, left_blocks;
> +	unsigned segno, left_blocks;
>   	int i;
>   
> -	/* check current node segment */
> +	/* check current node sections, which counts very roughly */
> +	left_blocks = 0;
>   	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
>   		segno = CURSEG_I(sbi, i)->segno;
> -		left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
> -				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> -
> -		if (node_blocks > left_blocks)
> -			return false;
> +		left_blocks += CAP_BLKS_PER_SEC(sbi) -
> +				get_ckpt_valid_blocks(sbi, segno, true);
>   	}
> +	if (node_blocks > left_blocks)
> +		return false;
>   
> -	/* check current data segment */
> +	/* check current data section for dentry blocks. */
>   	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> -	left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
> -			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> +	left_blocks = CAP_BLKS_PER_SEC(sbi) -
> +			get_ckpt_valid_blocks(sbi, segno, true);
>   	if (dent_blocks > left_blocks)
>   		return false;
>   	return true;
> @@ -626,7 +626,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>   
>   	if (free_secs > upper_secs)
>   		return false;
> -	else if (free_secs <= lower_secs)
> +	if (free_secs <= lower_secs)
>   		return true;
>   	return !curseg_space;
>   }

