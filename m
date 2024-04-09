Return-Path: <linux-kernel+bounces-136499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301689D4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406F51C216EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF67D094;
	Tue,  9 Apr 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n+3nZD00"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9495466E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652477; cv=none; b=K8yzbPWk7ODAIZttO2FZFdIWVf63K7it7tAJz7hgkhr0qFbM+ZFeHUPl2JRuJvNveeO8GQdbWUL5AznA4L+uu5Wca0SPtGxyy/U4492ml4kwFwYlFbA8TvYzowQHIHxjJuxLv+Rz71mqf24djoQWg8Gso+VI2oAFaTnKyufFPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652477; c=relaxed/simple;
	bh=el3TXw5D31KKwUR3W4iZvt+PANl/VSX8X2P72QHQ6I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovV1z13iYXZxw5wNR29IBlzYgiH9RKM14h/X3tAd7S0xpeHwH5eN97K0WB3AkIIO8VzgTz4LTmP2OfAp7D9TQ7Uy8NcJKB+GMJtdQlYmfT5knrUaNvDQcr2PLLi1n71wfmThkeia5fWqYjWtiOYAzCGk0Mo8TQGSrakgodfRl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n+3nZD00; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712652466; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NLmQBJY/YAR0kMQs21Xq2pa2nHPXvvDmIRP/f0OQLFw=;
	b=n+3nZD00jTkSfMN5CsxOR+vqo34YQRfEQzuVa7b95pOPeSp/Ph/CBJc3VZHXsu85OthO1bktIIrShcrH5eYuATTYO689WPHetEbzlfacNYc7N3Y2SCX1TVEE12AutkpUVECtHBmFYxmo5J+7uFuBIvWc/sGag8zaBoSOUpNy7GA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4E2Dby_1712652464;
Received: from 30.97.48.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4E2Dby_1712652464)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 16:47:46 +0800
Message-ID: <51fd6e0b-6fa2-4473-b22b-68c11230b2f5@linux.alibaba.com>
Date: Tue, 9 Apr 2024 16:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if
 possible
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-kernel@vger.kernel.org
References: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/9 16:11, Hongzhen Luo wrote:
> Use the superblock's UUID to generate the fsid when it's non-null.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/super.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c0eb139adb07..83bd8ee3b5ba 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   {
>   	struct super_block *sb = dentry->d_sb;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	u64 id = 0;
> -
> -	if (!erofs_is_fscache_mode(sb))
> -		id = huge_encode_dev(sb->s_bdev->bd_dev);
>   
>   	buf->f_type = sb->s_magic;
>   	buf->f_bsize = sb->s_blocksize;
>   	buf->f_blocks = sbi->total_blocks;
>   	buf->f_bfree = buf->f_bavail = 0;
> -
>   	buf->f_files = ULLONG_MAX;
>   	buf->f_ffree = ULLONG_MAX - sbi->inos;
> -
>   	buf->f_namelen = EROFS_NAME_LEN;
>   
> -	buf->f_fsid    = u64_to_fsid(id);
> +	if (uuid_is_null(&sb->s_uuid))
> +		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
> +				huge_encode_dev(sb->s_bdev->bd_dev));
> +	else
> +		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);
>   	return 0;
>   }
>   

