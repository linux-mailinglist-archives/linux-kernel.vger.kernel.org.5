Return-Path: <linux-kernel+bounces-4657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34669818056
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EFE1C22AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC48480;
	Tue, 19 Dec 2023 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN0y24/C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF198460
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BEAC433C8;
	Tue, 19 Dec 2023 03:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702958400;
	bh=X9vOHMO2c6gHb12PdnxbGCbecCiIn2ZXcfJQ210ch5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UN0y24/C2FMO9YNlISh0hSmm2JZPCbcGiwDPmDBrQxW73rSXny5dz34aacmjZyk5r
	 7nhbYFZrMckqQtl+VJBNzVk4dcG5jNk3sp3q3Tfz0zblrJfJgmFRTTWG5kKVl3JNRE
	 0I8tcT9hlpgELWA/Zg6KZ0Vkrqr5yT9bEwq2xxFKC7kkqh4Dd3SDKBnJdybNJEJ92U
	 W/eU9fUwQ2Skfixq9TTinVc2Q7pUQkwgvSdk/4SbqKJb39YsJdIUw44/z79mTPzot7
	 nTv2CuzgG+mYnJJNpGruFiflt1ySgx8EbDaY/wVXvv+rHrv9px/TZE35o6CAE5uWaU
	 hamzAg//lIyzA==
Message-ID: <6c553a75-4842-4b28-9725-ba5e297ff793@kernel.org>
Date: Tue, 19 Dec 2023 11:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] f2fs: show more discard status by sysfs
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1702952464-22050-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1702952464-22050-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/19 10:21, Zhiguo Niu wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information. More discard status can be shown so that we can check
> them through sysfs when needed.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v2: Improve the patch according to Chao's suggestions.
> changes of v3: Add a blank line for easy reading.
> changes of v4: Split to three entries
> ---
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
>   fs/f2fs/sysfs.c                         | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 4f1d4e6..606a298 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -159,6 +159,21 @@ Date:		November 2021
>   Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>   Description:	Shows the number of pending discard commands in the queue.
>   
> +What:           /sys/fs/f2fs/<disk>/issued_discard

Add them to /sys/fs/f2fs/<disk>/stat/?

Thanks,

> +Date:           December 2023
> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> +Description:    Shows the number of issued discard.
> +
> +What:           /sys/fs/f2fs/<disk>/queued_discard
> +Date:           December 2023
> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> +Description:    Shows the number of queued discard.
> +
> +What:           /sys/fs/f2fs/<disk>/undiscard_blks
> +Date:           December 2023
> +Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
> +Description:    Shows the total number of undiscard blocks.
> +
>   What:		/sys/fs/f2fs/<disk>/max_victim_search
>   Date:		January 2014
>   Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 7099ffa..666efdd 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -143,6 +143,33 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>   				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>   }
>   
> +static ssize_t issued_discard_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	if (!SM_I(sbi)->dcc_info)
> +		return -EINVAL;
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
> +				&SM_I(sbi)->dcc_info->issued_discard));
> +}
> +
> +static ssize_t queued_discard_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	if (!SM_I(sbi)->dcc_info)
> +		return -EINVAL;
> +	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
> +				&SM_I(sbi)->dcc_info->queued_discard));
> +}
> +
> +static ssize_t undiscard_blks_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	if (!SM_I(sbi)->dcc_info)
> +		return -EINVAL;
> +	return sysfs_emit(buf, "%u\n",
> +				SM_I(sbi)->dcc_info->undiscard_blks);
> +}
> +
>   static ssize_t gc_mode_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -1025,6 +1052,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
>   F2FS_GENERAL_RO_ATTR(pending_discard);
> +F2FS_GENERAL_RO_ATTR(issued_discard);
> +F2FS_GENERAL_RO_ATTR(queued_discard);
> +F2FS_GENERAL_RO_ATTR(undiscard_blks);
>   F2FS_GENERAL_RO_ATTR(gc_mode);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> @@ -1084,6 +1114,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>   	ATTR_LIST(max_ordered_discard),
>   	ATTR_LIST(discard_io_aware),
>   	ATTR_LIST(pending_discard),
> +	ATTR_LIST(issued_discard),
> +	ATTR_LIST(queued_discard),
> +	ATTR_LIST(undiscard_blks),
>   	ATTR_LIST(gc_mode),
>   	ATTR_LIST(ipu_policy),
>   	ATTR_LIST(min_ipu_util),

