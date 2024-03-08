Return-Path: <linux-kernel+bounces-96412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB7875BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3D72834B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1564621342;
	Fri,  8 Mar 2024 01:04:53 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1F225A8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859892; cv=none; b=RapA9/9B2zomjzsau/Fc1MJ2phqwbR5Fir69PF1g7hhsfEwU2NqluiUyQ99/D97mLU9qf7edYzTiFkrcfkg1PNrHjdc7+Djt8srPvWWbwQgEl28P8r5+aHkfaNwbWbGOJC0OUr21K30Nk+iA9X2nzwUYI26B/zhOSz3RmfbrvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859892; c=relaxed/simple;
	bh=GiTdVQy7bcAf5k45DkX69swwITTNxCxrjUbOrWnhtXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F3UJkjmGdFv9UrEvvaseQvVnUU/iXMwhDjSEGxVh5ypLyJeidl9HJd4IN2nIcSfGjqozjaHOkaSLCNFTi2sah8sYKewbtbLbcrVn34a0/8v6xluSH0p+TsujbV2pUQMowUOpGB+7jvCYRxxQYcxoRSKmCfMMWhu7fAY4WP1VHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TrSch10vFz1FM6W;
	Fri,  8 Mar 2024 09:04:36 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 017241400D3;
	Fri,  8 Mar 2024 09:04:46 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 09:04:45 +0800
Message-ID: <70dae3d9-a4d3-f9e2-6c8b-ec08eb6b1321@huawei.com>
Date: Fri, 8 Mar 2024 09:04:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>, <chengzhihao1@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <20240307101018.2021925-1-libaokun1@huawei.com>
 <60c18887-db8a-42a8-8a04-ef9d17263b15@linux.alibaba.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <60c18887-db8a-42a8-8a04-ef9d17263b15@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/7 22:18, Gao Xiang wrote:
>
>
> On 2024/3/7 18:10, Baokun Li wrote:
>> Lockdep reported the following issue when mounting erofs with a 
>> domain_id:
>>
>> ============================================
>> WARNING: possible recursive locking detected
>> 6.8.0-rc7-xfstests #521 Not tainted
>> --------------------------------------------
>> mount/396 is trying to acquire lock:
>> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>                         at: alloc_super+0xe3/0x3d0
>>
>> but task is already holding lock:
>> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>                         at: alloc_super+0xe3/0x3d0
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&type->s_umount_key#50/1);
>>    lock(&type->s_umount_key#50/1);
>>
>>   *** DEADLOCK ***
>>
>>   May be due to missing lock nesting notation
>>
>> 2 locks held by mount/396:
>>   #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>             at: alloc_super+0xe3/0x3d0
>>   #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
>>             at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
>>
>> stack backtrace:
>> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x64/0xb0
>>   validate_chain+0x5c4/0xa00
>>   __lock_acquire+0x6a9/0xd50
>>   lock_acquire+0xcd/0x2b0
>>   down_write_nested+0x45/0xd0
>>   alloc_super+0xe3/0x3d0
>>   sget_fc+0x62/0x2f0
>>   vfs_get_super+0x21/0x90
>>   vfs_get_tree+0x2c/0xf0
>>   fc_mount+0x12/0x40
>>   vfs_kern_mount.part.0+0x75/0x90
>>   kern_mount+0x24/0x40
>>   erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>>   erofs_fc_fill_super+0x213/0x380 [erofs]
>>
>> This is because the file_system_type of both erofs and the pseudo-mount
>> point of domain_id is erofs_fs_type, so two successive calls to
>> alloc_super() are considered to be using the same lock and trigger the
>> warning above.
>>
>> Therefore add a nodev file_system_type called erofs_anon_fs_type in
>> fscache.c to silence this complaint. Because kern_mount() takes a
>> pointer to struct file_system_type, not its (string) name. So we don't
>> need to call register_filesystem(). In addition, call init_pseudo() in
>> erofs_anon_init_fs_context() as suggested by Al Viro, so that we can
>> remove erofs_fc_fill_pseudo_super(), erofs_fc_anon_get_tree(), and
>> erofs_anon_context_ops.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>
> I will add
>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>
> when applying..
Okay, thanks for adding it.
>
> Also since it's a false positive and too close to the
> final so let's keep this patch in -next for a while and
> then aim for v6.9-rc1 instead.
>
> Thanks,
> Gao Xiang
Fine! Thanks!
-- 
With Best Regards,
Baokun Li
.

