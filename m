Return-Path: <linux-kernel+bounces-136742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D989D7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E451F26C06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81486269;
	Tue,  9 Apr 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iBRm/NIy"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75658614B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661801; cv=none; b=tIqfP5AF1wAOIUwhRNEuZbuc1gK+54gGIecg2d1n6M9VLhCP/RVgDsQn6rHVYLeyhACBHCW4SbegLm1jrLJlrDmejEIkAzR/o/s0yNWDTtu1N9hFiOQRGORqnL7REGM3nLWELbVKsqhXa1qTU9iv1bEF077Zyw9YyqvgcnzMKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661801; c=relaxed/simple;
	bh=BavaRWHxbElAzWYLUhqQemKOYLqMdzD4eTgpCa6qcSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3179obNE9PBFrsMVaflRbebT+vRPnoW8w+HoFHzE9OQGrgXiYGhToD6iDzN8iDxFDAv2CxXUsyw9eMWhnleWdR9iUuwSQEVCZHt/Djo9ttmd9scgftdWx/uNP7xGO28e7oFa7cUg8Rujca4xRIBwmdwXdU/Bw8BvzPZinHqtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iBRm/NIy; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712661791; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8F8v19+lNA8F19IaULKt3ifweaKAfXQbovzALL2FXbA=;
	b=iBRm/NIyY0rWI1xtwAIe80mkRRwmOZC0f/iJL2lpKNejGXiicF8gCJWYR5bWBzRSMBFHU/VnPheb+6K76igxcrVQoert1uwQqauVN71kYxEFP/Y3qUoBxJ3QBkQyBm3+2oCXXtZPT8z2UEpoqUxL5Mca/4UOFfmFdmXZAybOu34=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4ERR40_1712661789;
Received: from 30.221.131.136(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W4ERR40_1712661789)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 19:23:10 +0800
Message-ID: <b052bf53-237f-4693-a5e4-b50d914db5fc@linux.alibaba.com>
Date: Tue, 9 Apr 2024 19:23:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: derive fsid from on-disk UUID for .statfs() if
 possible
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, dhavale@google.com, linux-kernel@vger.kernel.org
References: <20240409081135.6102-1-hongzhen@linux.alibaba.com>
 <46253829-689c-4f06-8d08-a999c0ddbd1b@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <46253829-689c-4f06-8d08-a999c0ddbd1b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/9 17:36, Jingbo Xu 写道:
>
> On 4/9/24 4:11 PM, Hongzhen Luo wrote:
>> Use the superblock's UUID to generate the fsid when it's non-null.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   fs/erofs/super.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index c0eb139adb07..83bd8ee3b5ba 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -923,22 +923,20 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>   {
>>   	struct super_block *sb = dentry->d_sb;
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>> -	u64 id = 0;
>> -
>> -	if (!erofs_is_fscache_mode(sb))
>> -		id = huge_encode_dev(sb->s_bdev->bd_dev);
>>   
>>   	buf->f_type = sb->s_magic;
>>   	buf->f_bsize = sb->s_blocksize;
>>   	buf->f_blocks = sbi->total_blocks;
>>   	buf->f_bfree = buf->f_bavail = 0;
>> -
>>   	buf->f_files = ULLONG_MAX;
>>   	buf->f_ffree = ULLONG_MAX - sbi->inos;
>> -
>>   	buf->f_namelen = EROFS_NAME_LEN;
>>   
>> -	buf->f_fsid    = u64_to_fsid(id);
>> +	if (uuid_is_null(&sb->s_uuid))
>> +		buf->f_fsid = u64_to_fsid(erofs_is_fscache_mode(sb) ? 0 :
>> +				huge_encode_dev(sb->s_bdev->bd_dev));
>> +	else
>> +		buf->f_fsid = uuid_to_fsid((__u8 *)&sb->s_uuid);
> How about
>
> 	buf->f_fsid = uuid_to_fsid(sb->s_uuid.b);
>
> which looks cleaner.
>
> Otherwise LGTM.
>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>
>
Thanks. I will send v2 later.

---

Hongzhen


