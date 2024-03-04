Return-Path: <linux-kernel+bounces-90005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E8686F8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771C0B20C56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919A4416;
	Mon,  4 Mar 2024 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEVOR3sc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AAA59
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522379; cv=none; b=jf2jLjT174aAfqjtzwUpFyV6Kd9ddhBqB3OTg6/WdSn31bXBY0u7ik/D6/Hbl4rQ/pVRLASG1wBRwcYGqjA8tOi1OqouAMCPYGQlFGaptcTHY/3XyQG4V4CWQmAHLeMX/3pwT9U4JwZnON9lBNAjjRqJPQkFgKf4Rr1T7yWBZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522379; c=relaxed/simple;
	bh=V+RFDPpTYUKW1qUvgdx7/B+Sd3EmYDwkX0GvYntj4Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMalEZc+bxw8b/U8WhPspr7Ms+5vXLGVEHOAGxKQg4aMg7gr8vnrZiQD3XOE2cvJz8hdqL029XFV0NUHKkiuSlX4wVD443/4ERsoa7L+Mzo5ezrzLX3bi+06bdaNEykXLl8W3EicP9XiK2hNcGi4j7KpZbURxM6q2m4GbyCkLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEVOR3sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A04C433C7;
	Mon,  4 Mar 2024 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709522378;
	bh=V+RFDPpTYUKW1qUvgdx7/B+Sd3EmYDwkX0GvYntj4Ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hEVOR3scu9UZ5CjncLG9Z95wY0CxECuIZGKuolA5DJt+FI5jqwFdmXFzTqerGuvCv
	 VeUQ5FUAoKvWq7BcZszk/dlUAXYOqyLNbUwgx/7fCtThCGDlavSAgKQ/VCJ/2uEmxh
	 C0OsJmFm9SAAK3l7DbtAZjRRyj+GF5yySbJ9z6tmplQEHW0aoBL5S/XbbWQvdvmPN5
	 7gS+QsNTrCoBuft9Vp/ULXpzk99WA7RorlDrUxQv3QHCSn+zdWiM8BCmJ5ZJfM9X9E
	 BQFMU6wTIO1R0pzU80veEcMaC/vNYBk4Lh9lNNjDot809r4z2bIMPvJ2je/PkEJubg
	 xkKUWkr7XSH4w==
Message-ID: <7dc371ad-2448-4dd4-9551-8caef0a00d48@kernel.org>
Date: Mon, 4 Mar 2024 11:19:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to check result of new_curseg in
 f2fs_allocate_segment_for_resize
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709292976-13118-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709292976-13118-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/1 19:36, Zhiguo Niu wrote:
> new_curseg may return error if get_new_segment fail, so its result
> should be check in its caller f2fs_allocate_segment_for_resize,
> alos pass this results to free_segment_range.

Zhiguo,

What about handling all error paths of new_curseg() and change_curseg()
in one patch?

Thanks,

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/f2fs.h    | 2 +-
>   fs/f2fs/gc.c      | 7 +++++--
>   fs/f2fs/segment.c | 9 +++++++--
>   3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4331012..39dda7d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3701,7 +3701,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>   void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>   					unsigned int start, unsigned int end);
>   int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
>   int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index c60b747..7a458fa 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2037,8 +2037,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>   	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
>   
>   	/* Move out cursegs from the target range */
> -	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++)
> -		f2fs_allocate_segment_for_resize(sbi, type, start, end);
> +	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
> +		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
> +		if (err)
> +			goto out;
> +	}
>   
>   	/* do GC to move out valid blocks in the range */
>   	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1bb3019..2a07b9d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3071,11 +3071,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
>   	return false;
>   }
>   
> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>   					unsigned int start, unsigned int end)
>   {
>   	struct curseg_info *curseg = CURSEG_I(sbi, type);
>   	unsigned int segno;
> +	int err = 0;
>   
>   	f2fs_down_read(&SM_I(sbi)->curseg_lock);
>   	mutex_lock(&curseg->curseg_mutex);
> @@ -3089,7 +3090,10 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>   		change_curseg(sbi, type);
>   	else
>   		new_curseg(sbi, type, true);
> -
> +	if (curseg->segno == NULL_SEGNO) {
> +		err = -ENOSPC;
> +		goto unlock;
> +	}
>   	stat_inc_seg_type(sbi, curseg);
>   
>   	locate_dirty_segment(sbi, segno);
> @@ -3102,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>   
>   	mutex_unlock(&curseg->curseg_mutex);
>   	f2fs_up_read(&SM_I(sbi)->curseg_lock);
> +	return err;
>   }
>   
>   static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,

