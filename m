Return-Path: <linux-kernel+bounces-153301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C88ACC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99917282603
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5020146D57;
	Mon, 22 Apr 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E/L9S3Bo"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC5146A67
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786003; cv=none; b=rmFuFU4P0hCxb14ZztebNHvMOXh48SvahqfIPRJYgEYRaLpcTlE24qXGgvg+pv/BShqqGPTi+RpieC7rTGj7mGZa1tRgZ0fs8DXMgNixKKhNyh+8mLcos726DExo4fOTicsk+86Ymfx3OkdnljRhSs1/xWzB89pkHUd1aBe2tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786003; c=relaxed/simple;
	bh=d+qjr44gML1gaxYF9gACrYlVsmqhQSoGqoG4HK93mU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcRZLyslYWRVwp3BMT3BA9x8VL91WfeVV0cTQwttNuML1UZUJos5Q2C5v/kodNHYyZ+2UJvlbeyS0wR+WUYK1pjq5QMSfnh/NpTUY51mAOwU+4igC/9G8y8Jv8vYQfS/J9HP188/0BRiS97guQYdbdM872l48TrKczXkkOTvRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E/L9S3Bo; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713785998; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S7SoECJTVFW/s3jcVtwRCqtgqjwR+nyvH9E4BtCL//g=;
	b=E/L9S3BoFd39mV9XfrsW86GGxRjQw2Z4T94Kp76V4hQG0W2XthW+IbFnvo1MxBUpbw/xNY1hOg91/xPK44NQnxMNbsGdwe7gC7/dKqPi0l2sdYgqbq5bLe8TaZhDeCNZ/EIB1Kl0z98gJQW1eLi3GuYy9MAHUS71gy7s16ysqGY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W534KMu_1713785996;
Received: from 30.221.150.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W534KMu_1713785996)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 19:39:58 +0800
Message-ID: <2a7edcc0-6890-412d-b2ba-8bfa8694beeb@linux.alibaba.com>
Date: Mon, 22 Apr 2024 19:39:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
 <8d751a33-af11-4aa8-8fad-cc24e825bde7@linux.alibaba.com>
 <4e8dd4f5-29dc-9459-6ba2-f399258952dc@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <4e8dd4f5-29dc-9459-6ba2-f399258952dc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/22/24 7:31 PM, Baokun Li wrote:
> Hi Jingbo,
> 
> On 2024/4/22 18:25, Jingbo Xu wrote:
>>
>> On 4/19/24 8:36 PM, Baokun Li wrote:
>>
>>> @@ -761,12 +747,15 @@ static void erofs_free_dev_context(struct
>>> erofs_dev_context *devs)
>>>     static void erofs_fc_free(struct fs_context *fc)
>>>   {
>>> -    struct erofs_fs_context *ctx = fc->fs_private;
>>> +    struct erofs_sb_info *sbi = fc->s_fs_info;
>>> +
>>> +    if (!sbi)
>>> +        return;
>>
>> This is the only difference comparing to the original code literally.
>> Is there any chance that fc->s_fs_info can be NULL when erofs_fc_free()
>> is called?
>>
>> Otherwise looks good to me.
>>
> When sget_fc() executes successfully, fc->s_fs_info is set to NULL,
> so the following NULL pointer dereference may occur:
> 
> do_new_mount
>   vfs_get_tree
>     erofs_fc_get_tree
>       get_tree_bdev
>         sget_dev
>           sget_fc
>             s = alloc_super
>             s->s_fs_info = fc->s_fs_info;
>             fc->s_fs_info = NULL;
>         fill_super
>         // return error
>         deactivate_locked_super
>           kfree(sbi);
>   put_fs_context
>     sbi = fc->s_fs_info
>     kfree(sbi->fsid)
> 

Alright, fc->s_fs_info is transferred to s->s_fs_info and set to NULL.

Feel free to add:

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

