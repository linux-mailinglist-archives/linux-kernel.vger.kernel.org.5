Return-Path: <linux-kernel+bounces-4209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56600817921
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0FA1F2810B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499073462;
	Mon, 18 Dec 2023 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEAoeHwM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A271449
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23BC433C8;
	Mon, 18 Dec 2023 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702921504;
	bh=kDVkRZAYV2bjlg4876dXBiXZOhzsZ7DaqA1eePR2E2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEAoeHwMxC0sPYX6XJSjfJAfU+/8NkyaKA/DkNb41kHu+wFOQgbfGHCyQO3z+S3BE
	 e32GnGhaMwrysGA9xBhZ+WQ3GU3ucUYtgPMFEGjWtUpIsqhHf3NI4sdXtAO0+nzgtW
	 l4/fVdPYTK2cOpbyu3nuJTchPHB0wiiwR0QZf/hKZIJGBmIX+8e/nefLYEpvfZFSqP
	 eV07W38K6MXjT+Dowf+NXOmFsJmkJyr4pu5J4+jTA0DMSlp+Xlo6J0SjqwjDFIDgd1
	 w4LiQbqpehpKFVMO2t52YuDLge3iXrA2dp74IzbUvfDv52a0QlfHoITNc4sfFIGr5j
	 1IovLSNIq3e9w==
Date: Mon, 18 Dec 2023 09:45:03 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com
Subject: Re: [PATCH V3] f2fs: show more discard status by sysfs
Message-ID: <ZYCFH4cyjjCVbpDF@google.com>
References: <1702897676-12851-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702897676-12851-1-git-send-email-zhiguo.niu@unisoc.com>

On 12/18, Zhiguo Niu wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information. More discard status can be shown so that we can check
> them through sysfs when needed.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v2: Improve the patch according to Chao's suggestions.
> changes of v3: Add a blank line for easy reading.
> ---
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>  fs/f2fs/sysfs.c                         | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 36c3cb5..c6970e5 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -498,6 +498,12 @@ Description:	Show status of f2fs checkpoint in real time.
>  		CP_RESIZEFS_FLAG		0x00004000
>  		=============================== ==============================
>  
> +What:		/sys/fs/f2fs/<disk>/stat/discard_status
> +Date:		November 2023
> +Contact:	"Zhiguo Niu" <zhiguo.niu@unisoc.com>
> +Description:	Show status of f2fs discard in real time, including
> +		"issued discard","queued discard" and "undiscard blocks".
> +
>  What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
>  Date:		January 2021
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 417fae96..312a4dc 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -134,6 +134,22 @@ static ssize_t cp_status_show(struct f2fs_attr *a,
>  	return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
>  }
>  
> +static ssize_t discard_status_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +	if (!dcc)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%llu, %llu, %u\n",
> +			(unsigned long long)atomic_read(
> +				&dcc->issued_discard),
> +			(unsigned long long)atomic_read(
> +				&dcc->queued_discard),
> +			dcc->undiscard_blks);

We cannot do this since it needs one value per one entry.

> +}
> +
>  static ssize_t pending_discard_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -1197,9 +1213,12 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>  
>  F2FS_GENERAL_RO_ATTR(sb_status);
>  F2FS_GENERAL_RO_ATTR(cp_status);
> +F2FS_GENERAL_RO_ATTR(discard_status);
> +
>  static struct attribute *f2fs_stat_attrs[] = {
>  	ATTR_LIST(sb_status),
>  	ATTR_LIST(cp_status),
> +	ATTR_LIST(discard_status),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(f2fs_stat);
> -- 
> 1.9.1

