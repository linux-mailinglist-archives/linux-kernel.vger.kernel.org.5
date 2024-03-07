Return-Path: <linux-kernel+bounces-95036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936A874875
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D055F283CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1871CF8A;
	Thu,  7 Mar 2024 07:06:57 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8871BF34
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795216; cv=none; b=hthadSBkyfnLqg+22P2JtIPKxUdlHiS0dvd3SAs5TnjP4FJf72+whOLo04ibvwwMwiZQsOyzpI2tiTTYvX+mpXs5ywVLiJgL+CtxFCPA7Dylr1FUQmrRjWbgflzC+r65mm/P9IW+Y91v+zvb0LwMvSaxWZ7oEz9g7lEdfDiQziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795216; c=relaxed/simple;
	bh=zc1jTcxoOee8kEF73S15dBuM6q71pnLC82OIt6zwWcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKD35oZ9y5X6HexMnQLVLXCnp71jJGZwnzAkTdUf1J7JuMe19UT/z1L9+MR9/i7WkanLWTqG6cQ6z4tKw6Crh7BMYiftx0nG6RETyXp/oIDZBjHjIK+o1uVKCiXubRXxG3EVuXBRxiffqY2Ua43yFB+B/J40/pZzhTXcpFJuxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tr0fN5CQmz2BfJ8;
	Thu,  7 Mar 2024 15:04:28 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A7F21A0172;
	Thu,  7 Mar 2024 15:06:50 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:06:49 +0800
Message-ID: <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
Date: Thu, 7 Mar 2024 15:06:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <linux-erofs@lists.ozlabs.org>, <xiang@kernel.org>, <chao@kernel.org>,
	<huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>, <chengzhihao1@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240307050717.GB538574@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/7 13:07, Al Viro wrote:
> On Thu, Mar 07, 2024 at 10:44:59AM +0800, Baokun Li wrote:
>
>> +static int erofs_anon_init_fs_context(struct fs_context *fc)
>> +{
>> +	fc->ops = &erofs_anon_context_ops;
>> +	return 0;
>> +}
>
> ITYM
>          struct pseudo_fs_context *ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
> 	return ctx ? 0 : -ENOMEM;
>
> and to hell with erofs_anon_context_ops, along with its fill_super, calls
> of simple_fill_super(), etc.  Unless I'm missing something, you are not
> even creating dentries here, let alone making them possible to look up.
Totally agree! It does streamline a lot!
>> +static void erofs_kill_pseudo_sb(struct super_block *sb)
>> +{
>> +	kill_anon_super(sb);
>> +}
> *blink*
>
> What's wrong with simply using kill_anon_super as ->kill_sb?
Sure, I'll just use kill_anon_super().
>> +int erofs_anon_register_fs(void)
>> +{
>> +	return register_filesystem(&erofs_anon_fs_type);
>> +}
> What for?  The only thing it gives you is an ability to look it up by
> name.  Which is completely pointless, IMO,
The helper function here is to avoid extern erofs_anon_fs_type(), because
we define it in fscache.c, but also use it in super.c. Moreover, we 
don't need
to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
also use this helper function for code isolation.
>
>>   	if (!erofs_pseudo_mnt) {
>> -		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
>> +		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);
> ... since you are getting to it by direct reference to file_system_type
> anyway.  Same unregistering, of course...
Thanks for having a look!
-- 
With Best Regards,
Baokun Li
.

