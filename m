Return-Path: <linux-kernel+bounces-94923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7CE8746CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A704128870A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545EBEED7;
	Thu,  7 Mar 2024 03:31:23 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8293214
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782282; cv=none; b=Ce7wJRRtqE8t7AuGgecq2F3ERX9fJuJq0RmRwBHz7AkPreaaScAyEle0LzsbpTeTcXvc1Gfbl4AqfEFBZ8j5/4s/NeF+JAw4Re2ZBgd3XabOGib7lUziY7fRXEuBNh5HOVCmEGvPmZqYDAYWhbJXMQ+jDZX3zpazoulCUEjh8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782282; c=relaxed/simple;
	bh=OXciC5mWQg0GycSY840BaCLoqIDn+Lspd98Rl9lW3AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K7+6F7jXO8PdkRYo239FBHv+WZ0e7/61p6IzQUMLEbi88VyEjfxMVvtH0xWPMMFYbNPeaGGmCGGH3oVZJgMarreHGE/XXFKREeEKdkhlLM8PZkJgwr7Ayo9n/FSjgYMaer/VtqmDVUKTOogFMe11qNGbNmSS0PV55XQia+Gx40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TqvwF0TKXz1FJCs;
	Thu,  7 Mar 2024 11:31:09 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id E8B98180062;
	Thu,  7 Mar 2024 11:31:17 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:31:17 +0800
Message-ID: <7e9a15b9-f841-a7d4-7f72-7aee9cefb0f0@huawei.com>
Date: Thu, 7 Mar 2024 11:31:16 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <yukuai3@huawei.com>,
	<chengzhihao1@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Hi Xiang,

On 2024/3/7 10:52, Gao Xiang wrote:
> Hi Baokun,
>
> On 2024/3/7 10:44, Baokun Li wrote:
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
>> Therefore add a nodev file_system_type named erofs_anon_fs_type to
>> silence this complaint. In addition, to reduce code coupling, refactor
>> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() 
>> functions
>> and move the erofs_pseudo_mnt related code to fscache.c.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>
> IMHO, in the beginning, I'd like to avoid introducing another fs type
> for erofs to share (meta)data between filesystems since it will cause
> churn, could we use some alternative way to resolve this?
>
> Or Jingbo might have some other ideas?
>
> Thanks,
> Gao Xiang

The usual way to avoid this kind of false positive is to add a subclass to
the lock, but s_umount is allocated, initialised and locked in 
alloc_super(),
so we can't find a place to set the subclass.

Alternatively, kern_mount(&erofs_fs_type) could be moved to
erofs_module_init() or erofs_fc_parse_param() to avoid s_umount nesting,
but that would have looked a bit strange.

So the final choice was to add a new file_system_type to avoid this false
positive. Since you don't like the idea of adding a new file_system_type,
do you think it would be ok to move kern_mount(&erofs_fs_type) to
erofs_module_init() or erofs_fc_parse_param()?

Thanks!
-- 
With Best Regards,
Baokun Li
.

