Return-Path: <linux-kernel+bounces-118853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B788C047
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846831C30D6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75E481A5;
	Tue, 26 Mar 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZUDLLRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65114AB8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451515; cv=none; b=tGBdxaHFHmSBqgD+p3S3rfyGbMKetzTAmrQ1sF2ycM3GiKZwd0+bJVxWSBIbMeUHHaCUTMQpvAQ8N26zYBHPnOfH6OMqTlqT/2r9BnpdFehzzliZQJJnAzpA1ozuHUgfeM9Jr8wp16dAkQ/0T36fLHGrJ1IpAHz4vcTT2ndf/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451515; c=relaxed/simple;
	bh=XOachr2WIaie8cJhl/lzaSmTxBP/4J3wqYR/eRLBdO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z70Ma0CHYVy8FvBXdDITqoQ/hGqoPx4ei449CD3acqP1j+yt9s+TYghX5tlvlOa4ZQpTwd1j3s3wx3yLW74b0H9GzJFxBPNQ6f9shXYSJjyrHzwIsWZBrNIGYYyDO5cBYwHSyiBizisZ9dTbjsHcG7nyD8nW+L8QPJprSNoHMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZUDLLRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EACC433F1;
	Tue, 26 Mar 2024 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711451515;
	bh=XOachr2WIaie8cJhl/lzaSmTxBP/4J3wqYR/eRLBdO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UZUDLLRuPSnii715EPgehEkwLpc2bCCpy55jaWgGp7uH9FxbqW6+vaJAhstkh64Ho
	 Gp2OkGWlSF8rL6b5MobYtUjhJ33VzlDTeB+jQlCNoOyHba2er/P6yvjlddDKuq9CI0
	 SwiMQlt4FBmRFGIXM3Str9hGkUeWkCbme/wd5mNGTkAZHewRFc1hjyZuB1v9fUijfn
	 bhvkzlyOaCdIkKuEaHm5LXOWbNoBoljVZn2jRggs8ETEQ07HIcP/PwN0OanHRA6oFr
	 h6AymSgN3MVLdAhMD2Eu6CjqbXrt4UkovwTTKET5xqQx7IlY+/YbJjZGSJRgTo6rGn
	 t4GxWigrJrzwA==
Message-ID: <8a6b2768-8ab6-4275-8c4e-05b4eca83987@kernel.org>
Date: Tue, 26 Mar 2024 19:11:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: fix to adjust appropirate defragment pg_end
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1711346195-24555-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1711346195-24555-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/25 13:56, Zhiguo Niu wrote:
> A length that exceeds the real size of the inode may be
> specified from user, although these out-of-range areas
> are not mapped, but they still need to be check in
> while loop, which is unnecessary.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2: check i_size within inode lock according to Chao's suggestions
> ---
> ---
>   fs/f2fs/file.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 128e53d..cf63db7 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2608,9 +2608,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>   	bool fragmented = false;
>   	int err;
>   
> -	pg_start = range->start >> PAGE_SHIFT;
> -	pg_end = (range->start + range->len) >> PAGE_SHIFT;
> -
>   	f2fs_balance_fs(sbi, true);
>   
>   	inode_lock(inode);
> @@ -2629,10 +2626,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,

pg_start = range->start >> PAGE_SHIFT;
pg_end = min_t(pgoff_t, (range->start + range->len) >> PAGE_SHIFT,
			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));

>   
>   	/* writeback all dirty pages in the range */
>   	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
> -						range->start + range->len - 1);
> +						min_t(loff_t, range->start + range->len - 1,
> +						i_size_read(inode) - 1));

, pg_start << PAGE_SHIFT - 1, pg_end << PAGE_SHIFT - 1); ?

Thanks,

>   	if (err)
>   		goto out;
>   
> +	pg_start = range->start >> PAGE_SHIFT;
> +	pg_end = min_t(pgoff_t,
> +				(range->start + range->len) >> PAGE_SHIFT,
> +				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
> +
>   	/*
>   	 * lookup mapping info in extent cache, skip defragmenting if physical
>   	 * block addresses are continuous.

