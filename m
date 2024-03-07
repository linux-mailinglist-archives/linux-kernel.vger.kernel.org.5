Return-Path: <linux-kernel+bounces-95022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F51B87484A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB1F2859A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C701CD35;
	Thu,  7 Mar 2024 06:46:15 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541101CD1E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793974; cv=none; b=WVDoFJnMDmMg0eCo2yZ+EQNMoNak5av1qotIacmBUjTgz9wliXpvh3IORmUrSx1KvQVWCaYiZ6j2K8h9E16v93CGEZy7H4awEAW6uF3R1Rp0vY88Eiupnde/ycXFAIf4lsiHWaGcjdZ87r1CXNWxZDFWqwXCjLhcZaaYaAfIkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793974; c=relaxed/simple;
	bh=K7PdIuP8GHCTUrhQj8aOd7YN/W2WNHpg97wjuZ+1p5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ce/qJ5kjVjq+N20SKUDEvFlXbOqgBBS8/136DovrGoYvJrmUpkU8punul0Llw6naIxIul0Myy1p4sfWttPBuPDAZ7/Tu9WmHExB5KGBenoPNSbDpbgKW5IGXA4PjR2TAw7WZE2o4SU7G05zEGr2eq701bBlFKPWIjU4yJpw0HUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tr0BW2mr0z1QB3F;
	Thu,  7 Mar 2024 14:43:47 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 93AED1A016C;
	Thu,  7 Mar 2024 14:46:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 14:46:08 +0800
Message-ID: <65d09bbe-9389-4502-1504-8c1557fe5e52@huawei.com>
Date: Thu, 7 Mar 2024 14:46:08 +0800
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
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Gao Xiang
	<hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>, <chengzhihao1@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
 <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/7 11:41, Jingbo Xu wrote:
> Hi Baokun,
>
> Thanks for catching this!
>
>
> On 3/7/24 10:52 AM, Gao Xiang wrote:
>> Hi Baokun,
>>
>> On 2024/3/7 10:44, Baokun Li wrote:
>>> Lockdep reported the following issue when mounting erofs with a
>>> domain_id:
>>>
>>> ============================================
>>> WARNING: possible recursive locking detected
>>> 6.8.0-rc7-xfstests #521 Not tainted
>>> --------------------------------------------
>>> mount/396 is trying to acquire lock:
>>> ffff907a8aaaa0e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>                          at: alloc_super+0xe3/0x3d0
>>>
>>> but task is already holding lock:
>>> ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>                          at: alloc_super+0xe3/0x3d0
>>>
>>> other info that might help us debug this:
>>>    Possible unsafe locking scenario:
>>>
>>>          CPU0
>>>          ----
>>>     lock(&type->s_umount_key#50/1);
>>>     lock(&type->s_umount_key#50/1);
>>>
>>>    *** DEADLOCK ***
>>>
>>>    May be due to missing lock nesting notation
>>>
>>> 2 locks held by mount/396:
>>>    #0: ffff907a8aaa90e0 (&type->s_umount_key#50/1){+.+.}-{3:3},
>>>              at: alloc_super+0xe3/0x3d0
>>>    #1: ffffffffc00e6f28 (erofs_domain_list_lock){+.+.}-{3:3},
>>>              at: erofs_fscache_register_fs+0x3d/0x270 [erofs]
>>>
>>> stack backtrace:
>>> CPU: 1 PID: 396 Comm: mount Not tainted 6.8.0-rc7-xfstests #521
>>> Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x64/0xb0
>>>    validate_chain+0x5c4/0xa00
>>>    __lock_acquire+0x6a9/0xd50
>>>    lock_acquire+0xcd/0x2b0
>>>    down_write_nested+0x45/0xd0
>>>    alloc_super+0xe3/0x3d0
>>>    sget_fc+0x62/0x2f0
>>>    vfs_get_super+0x21/0x90
>>>    vfs_get_tree+0x2c/0xf0
>>>    fc_mount+0x12/0x40
>>>    vfs_kern_mount.part.0+0x75/0x90
>>>    kern_mount+0x24/0x40
>>>    erofs_fscache_register_fs+0x1ef/0x270 [erofs]
>>>    erofs_fc_fill_super+0x213/0x380 [erofs]
>>>
>>> This is because the file_system_type of both erofs and the pseudo-mount
>>> point of domain_id is erofs_fs_type, so two successive calls to
>>> alloc_super() are considered to be using the same lock and trigger the
>>> warning above.
>>>
>>> Therefore add a nodev file_system_type named erofs_anon_fs_type to
>>> silence this complaint. In addition, to reduce code coupling, refactor
>>> out the erofs_anon_init_fs_context() and erofs_kill_pseudo_sb() functions
>>> and move the erofs_pseudo_mnt related code to fscache.c.
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> IMHO, in the beginning, I'd like to avoid introducing another fs type
>> for erofs to share (meta)data between filesystems since it will cause
>> churn, could we use some alternative way to resolve this?
> Yeah as Gao Xiang said, this is initially intended to avoid introducing
> anothoer file_system_type, say erofs_anon_fs_type.
>
> What we need is actually a method of allocating anonymous inode as a
> sentinel identifying each blob.  There is indeed a global mount, i.e.
> anon_inode_mnt, for allocating anonymous inode/file specifically.  At
> the time the share domain feature is introduced, there's only one
> anonymous inode, i.e. anon_inode_inode, and all the allocated anonymous
> files are bound to this single anon_inode_inode.  Thus we decided to
> implement a erofs internal pseudo mount for this usage.
>
> But I noticed that we can now allocate unique anonymous inodes from
> anon_inode_mnt since commit e7e832c ("fs: add LSM-supporting anon-inode
> interface"), though the new interface is initially for LSM usage.
>
Thank you for your feedback!

If I understand you correctly, you mean to remove erofs_pseudo_mnt
directly to avoid this false positive, and use anon_inode_create_getfile()
to create the required anonymous inode.

-- 
With Best Regards,
Baokun Li
.

