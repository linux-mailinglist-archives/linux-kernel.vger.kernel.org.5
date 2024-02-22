Return-Path: <linux-kernel+bounces-75772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D885EEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EE61F22F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29E12B9A;
	Thu, 22 Feb 2024 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUMp+bj6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51677101F1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565842; cv=none; b=uwE7he7ZvXQV8OBkk9XlYFPTLMn7ntUSY69M3NntWcEvU37Wt1DRx/70/EtHSUYWQVtx0WRitBv0VeGAEf5SoZGyWRuh9AHpbGZSfaPvKFAF5WasqfOzamPU6TMdlNyiQATW8foIza1dUkljy4MaxnUEhhJAZBbYg7c1b6/G3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565842; c=relaxed/simple;
	bh=PwtsuWG8E/oFESM40Xvr8zU779YojRz56nkBHgVSrRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GimbNkeUIlZ7dKDlZz7+zEJOM+kVTS/dExkQakudBXKQS1bSJnqNtFk2GUBTOUu8RinTuu3nPRsCUkup/lK5mwe852hYchOnQAc35zum6TqWxTaT/aMBXElPCo7Nkhdj9B6oEVFSne3ntfr+2VwLrPhyZ1D2+05crCOAy6wI6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUMp+bj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720F4C433F1;
	Thu, 22 Feb 2024 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708565841;
	bh=PwtsuWG8E/oFESM40Xvr8zU779YojRz56nkBHgVSrRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BUMp+bj6BPcHoZLgv5pdktQ/EWXRevuaUPtFYlEICYHxgy5L1Tkca46yLu+5zQKIN
	 PpzKahw6JzYh3LVEMAYvoN784KIChRNxArGJSqrdQwO9RdyK4TcBaLxk0UWF4YOw1C
	 P/IdR+BWTxxLsEzR0uOmwQ1nSJh9PkqaHU9McK/68XdVi0fKP2p7YFQX0H1D8PO5tO
	 F2HXq2Gk+SfNrVuUNDxRuWUJMz/FdeN9MLs5FFqorHs8FoWCen4g47U22iEtuwMDei
	 c4abj1Q55+ZemaJ17vquvBMrwl9wdgG4TcHm+SgA2avV929XeEF9kSPs8p8qZOapGe
	 6pa8CQ5EMunzQ==
Message-ID: <c2ab9d88-b947-42e5-a1a2-204d58e0c1a8@kernel.org>
Date: Thu, 22 Feb 2024 09:37:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] f2fs: stop checkpoint when get a out-of-bounds
 segment
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/20 14:11, Zhiguo Niu wrote:
> There is low probability that an out-of-bounds segment will be got
> on a small-capacity device. In order to prevent subsequent write requests
> allocating block address from this invalid segment, which may cause
> unexpected issue, stop checkpoint should be performed.
> 
> Also introduce a new stop cp reason: STOP_CP_REASON_NO_SEGMENT.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v4: use more suitable MACRO name according to Chao's suggestions
> changes of v3: correct MACRO spelling and update based on the lastes code
> ---
> ---
>   fs/f2fs/segment.c       | 7 ++++++-
>   include/linux/f2fs_fs.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c25aaec..e42e34c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2665,7 +2665,12 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>   	if (secno >= MAIN_SECS(sbi)) {
>   		secno = find_first_zero_bit(free_i->free_secmap,
>   							MAIN_SECS(sbi));
> -		f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> +		if (secno >= MAIN_SECS(sbi)) {
> +			f2fs_stop_checkpoint(sbi, false,
> +				STOP_CP_REASON_NO_SEGMENT);

We should relocate stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT) outside
segmap_lock spinlock, due to it may sleep in f2fs_flush_merged_writes().

Thanks,

> +			f2fs_bug_on(sbi, 1);
> +		}
> +
>   	}
>   	segno = GET_SEG_FROM_SEC(sbi, secno);
>   	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 9b69c50..755e9a4 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -75,6 +75,7 @@ enum stop_cp_reason {
>   	STOP_CP_REASON_CORRUPTED_SUMMARY,
>   	STOP_CP_REASON_UPDATE_INODE,
>   	STOP_CP_REASON_FLUSH_FAIL,
> +	STOP_CP_REASON_NO_SEGMENT,
>   	STOP_CP_REASON_MAX,
>   };
>   

