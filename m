Return-Path: <linux-kernel+bounces-140141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA08A0BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281511F28BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7981428EA;
	Thu, 11 Apr 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGxYfEmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193513DBB2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826533; cv=none; b=eY+xfhoTl5ZT1WV6sGhMlefp2BhXBwCFzyuNukdG2k1T7woiqcnoUCew3SYU7Jd2L4bSQI0cSxaC94hRjtrIiJF41aBFygYcp0CqYlvxgkL4yOYGtKJjL6vrE3a9kB0k/Eqc66g585kyMi0rndUKk24fFhbiDJrl5ruhLSFegJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826533; c=relaxed/simple;
	bh=Gquqvt7BvCwmrUDfJeZHRdOZSEe4nCpSW+y74D7X5l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NArYN3kvEDGeSfuR8EaRTi9sh6zEEkTSYymIpgj65XS0UxOZlRTSFJY03r1FO6hTnUDtt5CxrYV4Wu+HchaH21SGdGvMtKqpUdZd7HGuLKUhwQDdcq6ePnug6h7/9kwKGF26gIERb3+9O9XLOWf0ueFjZeDGsRSQWRZ6XRlgO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGxYfEmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D39EC433C7;
	Thu, 11 Apr 2024 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712826533;
	bh=Gquqvt7BvCwmrUDfJeZHRdOZSEe4nCpSW+y74D7X5l4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PGxYfEmGT3OK5xL+K/YyXcML/1FxTeRlfwW75CrszzB7DodFlhnw9jzcb1WhYzzC0
	 yXgigb+cnU9UUP68/x0Cqv9C0/E57xUGBv0fzKgTIQccjkrUOoAuXickdEierJQkG6
	 VxiLB0bp6wVNwOYkLcR4TEStKzOXtLTDS4c0SzSEcBEH/ZnS9BcLzLNneI913N+Suc
	 eSUir1ojQf7qEYjimqjEDSFRI12LyFd9AQJTYGUs8FxJgXMzrpQE4OOQk4SOD1X1XY
	 /0fjRHzaYY+Mjzgb6j9c9i29IewVLuhySLkEdxmAJtkYNvlHyqI7cWBk8WZBNGTtj0
	 iIA20elY4C6Cw==
Message-ID: <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>
Date: Thu, 11 Apr 2024 17:08:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix false alarm on invalid block
 address
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-3-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240409203411.1885121-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 4:34, Jaegeuk Kim wrote:
> f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> not the corruption case.

In which case we will read ahead invalid meta pages? recovery w/ META_POR?

Thanks,

> 
> Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/checkpoint.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index eac698b8dd38..b01320502624 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   		break;
>   	case META_SIT:
>   		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> -			goto err;
> +			goto check_only;
>   		break;
>   	case META_SSA:
>   		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
>   			blkaddr < SM_I(sbi)->ssa_blkaddr))
> -			goto err;
> +			goto check_only;
>   		break;
>   	case META_CP:
>   		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
>   			blkaddr < __start_cp_addr(sbi)))
> -			goto err;
> +			goto check_only;
>   		break;
>   	case META_POR:
>   		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>   			blkaddr < MAIN_BLKADDR(sbi)))
> -			goto err;
> +			goto check_only;
>   		break;
>   	case DATA_GENERIC:
>   	case DATA_GENERIC_ENHANCE:
> @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   	return true;
>   err:
>   	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +check_only:
>   	return false;
>   }
>   

