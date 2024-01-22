Return-Path: <linux-kernel+bounces-32310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004518359DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315BA1C22269
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415471C2D;
	Mon, 22 Jan 2024 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgQlq/Gb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE181849
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705895183; cv=none; b=tJi2yyBjG/UnFrSzGZaHlUBDW89s1syJJNl0tTDO5Abe6rLHpcCiGME+kwdaGd+7tsIRziIAbdUkmMsPQpKGz0/Q7JMRP0yWX41OPrCiIG+4I+tEErZWCK9xZVHFXwKqIGw6864zZdij1kuFqzI9vEApcukLS5ejhQsOkRNmXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705895183; c=relaxed/simple;
	bh=zoejXegjHJcV0qb/kFDz+v6bQRItyzAV9KNxzAmqKVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWXBHdU/3rC8k2dBrvgzGgpVd5W+CcgZ2Sy+9FLdIVdCEn+noKHXy5Qpc0ZI/+SRhlwlQa+l1BRm9CUtB4dgcw2vyZLGyDlh1tIVHjpy9yBBDevIWB+Oro8YramHechQRa1vy1/Iz1m+ePYfwSDwDHGu0WoBJHhRLrW+zfsacoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgQlq/Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A32EC433F1;
	Mon, 22 Jan 2024 03:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705895182;
	bh=zoejXegjHJcV0qb/kFDz+v6bQRItyzAV9KNxzAmqKVc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fgQlq/GbB6+8LA5iWZU6GowrqI9gQMCYu/djK/+UMe3jkn2jikx8JQJ8xgs6FBP2p
	 XmDnpz28VN8vQMM5bUOUI5fHxSuL8KMsnqCn10buT6gv2qkSGku12PtWtwYYQFW5I0
	 afTn3oZEF+tKv8kUyaXJ4d2j2OqQh9KsAgtqVEAL6Xjs7TmnHzb3YiHA3jCyIoRPb7
	 GYqbtCQFne8Q7EF8haAgiIThDI9c+eXpUyQGln5kE/8BdLql6rOdbAN55QtdXOUi47
	 RY2aQh8gHfcs5tjbJZynf6fLJGQYMY7q16odOFBrH6YoxXqeflf/YQZ1DB8OpBrk37
	 ZPhrXHfW9qflg==
Message-ID: <74243f43-c129-4530-970c-4de2afcd307e@kernel.org>
Date: Mon, 22 Jan 2024 11:46:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] f2fs: fix potentail deadloop issue in do_recover_data
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/25 19:11, Zhiguo Niu wrote:
> There is a potentail deadloop issue in the corner case of
> CONFIG_F2FS_FAULT_INJECTION is enabled and the return value
> of f2fs_reserve_new_block is error but not -ENOSPC, such as
> this error case:
> if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
> 		return -EPERM;

I don't see any path to trigger this error? am I missing something?

> besides, the mainly error -ENOSPC has been handled as bug on,
> so other error cases can be proecssed normally without looping.

commit 975756c41332bc5e523e9f843271ed5ab6aaaaaa
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Thu May 19 11:57:21 2016 -0700

     f2fs: avoid ENOSPC fault in the recovery process

     This patch avoids impossible error injection, ENOSPC, during recovery process.

Please check above patch, I guess intention of adding such loop is
to avoid mount failure due to fault injection was triggered in
f2fs_reserve_new_block().

What about change as blew?
- keep the loop to avoid mount failure.
- remove bug_on() to avoid panic due to fault injection error.

#define DEFAULT_RETRY_COUNT		8

		for (loops = DEFAULT_RETRY_COUNT; loops > 0; loops--) {
			err = f2fs_reserve_new_block(&dn);
			if (!err ||
				!IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
				break;
		}

Thanks,

> 
> Fixes: 956fa1ddc132 ("f2fs: fix to check return value of f2fs_reserve_new_block()")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/recovery.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 21381b7..5d658f6 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -710,15 +710,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>   		 */
>   		if (dest == NEW_ADDR) {
>   			f2fs_truncate_data_blocks_range(&dn, 1);
> -			do {
> -				err = f2fs_reserve_new_block(&dn);
> -				if (err == -ENOSPC) {
> -					f2fs_bug_on(sbi, 1);
> -					break;
> -				}
> -			} while (err &&
> -				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
> -			if (err)
> +			err = f2fs_reserve_new_block(&dn);
> +			if (err == -ENOSPC)
> +				f2fs_bug_on(sbi, 1);
> +			else if (err)
>   				goto err;
>   			continue;
>   		}
> @@ -727,15 +722,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>   		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
>   
>   			if (src == NULL_ADDR) {
> -				do {
> -					err = f2fs_reserve_new_block(&dn);
> -					if (err == -ENOSPC) {
> -						f2fs_bug_on(sbi, 1);
> -						break;
> -					}
> -				} while (err &&
> -					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
> -				if (err)
> +				err = f2fs_reserve_new_block(&dn);
> +				if (err == -ENOSPC)
> +					f2fs_bug_on(sbi, 1);
> +				else if (err)
>   					goto err;
>   			}
>   retry_prev:

