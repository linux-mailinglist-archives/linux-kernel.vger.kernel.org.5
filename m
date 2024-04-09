Return-Path: <linux-kernel+bounces-136578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BA89D5AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229D7284D03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16037FBDD;
	Tue,  9 Apr 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bkbNjof0"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C07FBB8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655403; cv=none; b=PO2u6AxWeerzLM+JWXTQrU3rm9+BzhsGUAMslFm9drC9rYWbsGjkSM4ExikvQd2xADbj73pFmVj+VoKSgf1J5ItfcrKOvq2n18R79ZJqSBd6mz9Mx76COG5YgtMfTEkIcBAUmO1GKzuYLnb0J6vmTNsMG0CaTfPJqrkNSQKd+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655403; c=relaxed/simple;
	bh=g5pwg0HzlZrNiXTyaY1iTIZwrY4EawcSlV/lLzn+9Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9+/V5chAiV7Z7+72URfkXmyNjPu4xa66W1tXCkhUFtbshe1e1Q5JFgX7nHaXRMDngISeVQ0WMG4rhAKXNa5uFgW6G35zClOPRL6h0yNyIKutx1hphaxADy/WZtrmGRyKXKcTMYGkwQIIpdN+hUugiB611gX2DBNOC1EIMdIVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bkbNjof0; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712655399; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IihCW7ee09bCmiskyKydryQQZ6Rl3F+Bzk9wIUWO258=;
	b=bkbNjof053DkzhhsqKxCjvOGUTZBVYj+yteNE2HadtgacDoeWpy5TK1oEY29/6Z+o98gZy8z57AUjtgx7dGgCkScX2DYLv3r49TeX3DcarJgq37d7riji4o/24mFBY+jjD+BZ3jwUq3TsYtLSDTFw1Bqe4nmd4SUcdGp8yBUggY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4E4IXT_1712655383;
Received: from 30.221.148.154(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W4E4IXT_1712655383)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 17:36:38 +0800
Message-ID: <46253829-689c-4f06-8d08-a999c0ddbd1b@linux.alibaba.com>
Date: Tue, 9 Apr 2024 17:36:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if
 possible
Content-Language: en-US
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, dhavale@google.com, linux-kernel@vger.kernel.org
References: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/24 4:11 PM, Hongzhen Luo wrote:
> Use the superblock's UUID to generate the fsid when it's non-null.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c0eb139adb07..83bd8ee3b5ba 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	u64 id = 0;
> -
> -	if (!erofs_is_fscache_mode(sb))
> -		id = huge_encode_dev(sb->s_bdev->bd_dev);
>  
>  	buf->f_type = sb->s_magic;
>  	buf->f_bsize = sb->s_blocksize;
>  	buf->f_blocks = sbi->total_blocks;
>  	buf->f_bfree = buf->f_bavail = 0;
> -
>  	buf->f_files = ULLONG_MAX;
>  	buf->f_ffree = ULLONG_MAX - sbi->inos;
> -
>  	buf->f_namelen = EROFS_NAME_LEN;
>  
> -	buf->f_fsid    = u64_to_fsid(id);
> +	if (uuid_is_null(&sb->s_uuid))
> +		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
> +				huge_encode_dev(sb->s_bdev->bd_dev));
> +	else
> +		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);

How about

	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);

which looks cleaner.

Otherwise LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>



-- 
Thanks,
Jingbo

