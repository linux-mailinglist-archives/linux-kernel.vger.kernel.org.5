Return-Path: <linux-kernel+bounces-156791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD98B0839
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B21C21217
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B215A491;
	Wed, 24 Apr 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PEYVFZxx"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1EC142E62
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957722; cv=none; b=Q51nl+PsAYIrRA5KxtjBxJyNhgWMasEvWGM3Rf1eBRzsRiYpVJJ+CFpA3skz/ukP42PEbS3gxzO7vZ/uDF0BQ+5x34HAk1MwvoVT8QtFW1ONsE8pBYAVS6MmZwOpupEQ+AZ/LlAl2QKfNiVuZrzTcTvPpPUGi2zFSCVXyjib9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957722; c=relaxed/simple;
	bh=jXBd7jwfXzMtKsDnykh8KKkP0FF2C8w94PpTyyl1JWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dChzqJHxLgxyXOzJOylOLw9UodvhFbrNSY/D46dRjEPl/hTT13o2KFMfL1J1lq19h/tnpxP9xyqhtPohfJ0ztfQk46iC1f9sxjRahbqjw9neJ1mBLGkYsz7BTIc+eC4yclLeFXtYGwuIOGvcFt0LzdkHl4Cowu558yqkRbt4Q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PEYVFZxx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713957712; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ng39GRBnsItm8XR2jbJ/4RhY77ypkbK0TVgWZrO11AY=;
	b=PEYVFZxx4gqw0auyu2KoVl5LgWb6lQFQgUrQd/afgaqSL80lElcSgA4OoXbckITeasJgFyb97J8nuuKy/jdGU75eTZcKsgaLwvD5+gmGd4mU/V1noX+mELrRc8YX3pTNPUghyOk/1SdGoha/HbHfBMsG434O+4GlbLfpsQECDtI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W5C6jzC_1713957710;
Received: from 30.221.147.25(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5C6jzC_1713957710)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 19:21:51 +0800
Message-ID: <1c18da0e-b0cb-4eb2-9eab-19a68fa416cd@linux.alibaba.com>
Date: Wed, 24 Apr 2024 19:21:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc: huyue2@coolpad.com, dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240424084247.759432-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424084247.759432-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 4:42 PM, Hongbo Li wrote:
> When prepare_ondemand_read failed, wrong error message is printed.
> The prepare_read is also implemented in cachefiles, so we amend it.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/erofs/fscache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8aff1a724805..62da538d91cb 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
>  		if (WARN_ON(len == 0))
>  			source = NETFS_INVALID_READ;
>  		if (source != NETFS_READ_FROM_CACHE) {
> -			erofs_err(NULL, "prepare_read failed (source %d)", source);
> +			erofs_err(NULL, "prepare_ondemand_read failed (source %d)", source);
>  			return -EIO;
>  		}
>  


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

