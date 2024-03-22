Return-Path: <linux-kernel+bounces-111389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF124886BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440CFB22C72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B333FB0A;
	Fri, 22 Mar 2024 11:57:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBC2B9DF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108654; cv=none; b=CaB0o+qsSPiT6FPV0lfoR1EaBQBrGmQznKd4PF2URPgm5l26mZEkc/9LQ4si3mpKQ78jeUPHh7hRTFVELa6aFTn2t7MSoJJBq+D0IkOWBHdmUoQPIwbrpk3EJ7YdVaUoQLva96ZkCT0D7m874IoeGthrf2qXvXGBCPABUsYZCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108654; c=relaxed/simple;
	bh=3U+7Avb3Ud9HwvQdmsRwCC4euMnigBREOCdk/yFSNCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FHqsx2GodBTV/oVgMMS6jD0/H6STr2JjmzlrDNFIRAJj+giXEMzR1qmYPWK9cbH9xl/WPF6yogB0CNdZlPdSIZPF5wpUlAOiUz9n0aLSkjNXFS+6Dtl7xgIq13T46V9sGCz2CDybNRMmxbF5etnZ3zk4FgKKBvoVPWUEeh/M2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V1LNV6nWqzwQ1N;
	Fri, 22 Mar 2024 19:54:50 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id CEA141400D7;
	Fri, 22 Mar 2024 19:57:25 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 19:57:25 +0800
Message-ID: <661736fb-bb3c-3519-1f4b-44dff285ea0b@huawei.com>
Date: Fri, 22 Mar 2024 19:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 2/5] ubifs: Initialize or update ACLs for inode
Content-Language: en-US
To: Zhihao Cheng <chengzhihao1@huawei.com>, <richard@nod.at>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-3-lizetao1@huawei.com>
 <2991c168-723d-48ef-8420-61e22a897239@huawei.com>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <2991c168-723d-48ef-8420-61e22a897239@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100005.china.huawei.com (7.185.36.185) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

On 2024/3/21 11:47, Zhihao Cheng wrote:
> 在 2024/3/20 0:16, Li Zetao 写道:
>> There are two scenarios where ACL needs to be updated, the first one
>> is when creating the inode, and the second one is in the chmod process.
>> When creating directories/files/device node/tmpfile, ACLs needs to be
>> initialized, but symlink do not.Why not support symlink? It looks like 
>> many filesystems(eg. ext4, f2fs, 
> btrfs) support it, except xfs.
Thanks for the reviews, but this is inconsistent with my understanding.
I think most file systems in Linux do not support it, because most file 
systems do not register the get/set functions of ACLs for symlink 
operations. And the posix_acl_create() will determine that it is a 
symlink type inode, and then skip the creation process. But except for 
bcachefs, it may be to solve the problem of certain scenarios, so it 
would be nice if anyone could explain it to us.
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   fs/ubifs/dir.c  | 16 ++++++++++++++++
>>   fs/ubifs/file.c |  4 ++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
>> index 551148de66cd..dfb6823cc953 100644
>> --- a/fs/ubifs/dir.c
>> +++ b/fs/ubifs/dir.c
>> @@ -316,6 +316,10 @@ static int ubifs_create(struct mnt_idmap *idmap, 
>> struct inode *dir,
>>           goto out_fname;
>>       }
>> +    err = ubifs_init_acl(inode, dir);
>> +    if (err)
>> +        goto out_inode;
>> +
> Attention, a new inconsistent problem point is imported by acl xattr 
> creation. See https://bugzilla.kernel.org/show_bug.cgi?id=218309.  @Richard
This problem is indeed a bit tricky.
>>       err = ubifs_init_security(dir, inode, &dentry->d_name);
>>       if (err)
>>           goto out_inode;
>> @@ -466,6 +470,10 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, 
>> struct inode *dir,
>>       }
>>       ui = ubifs_inode(inode);
>> +    err = ubifs_init_acl(inode, dir);
>> +    if (err)
>> +        goto out_inode;
>> +
>>       err = ubifs_init_security(dir, inode, &dentry->d_name);
>>       if (err)
>>           goto out_inode;
>> @@ -1013,6 +1021,10 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, 
>> struct inode *dir,
>>           goto out_fname;
>>       }
>> +    err = ubifs_init_acl(inode, dir);
>> +    if (err)
>> +        goto out_inode;
>> +
>>       err = ubifs_init_security(dir, inode, &dentry->d_name);
>>       if (err)
>>           goto out_inode;
>> @@ -1108,6 +1120,10 @@ static int ubifs_mknod(struct mnt_idmap *idmap, 
>> struct inode *dir,
>>       ui->data = dev;
>>       ui->data_len = devlen;
>> +    err = ubifs_init_acl(inode, dir);
>> +    if (err)
>> +        goto out_inode;
>> +
>>       err = ubifs_init_security(dir, inode, &dentry->d_name);
>>       if (err)
>>           goto out_inode;
> The whiteout inode is not set acl for rename(WHITEOUT) operation. It 
> looks like many filesystems(eg. ext4, f2fs, btrfs) support it, except 
> xfs. In my opinion, whiteout is a char dev, since char/block device is 
> supported, why not support whiteout?
> 
> If we support whiteout, we should make sure that the whiteout renameing 
> operation is atomic[1]. But I cannot come up with an idea how to combine 
> whiteout xattr(acl) creation and whiteout file creation into an atomic 
> operation, just like problem mentioned in [2],
Yes, thanks, I have fixed it in v2 version.
> 
> [1] 
> https://lore.kernel.org/linux-mtd/20211227032246.2886878-6-chengzhihao1@huawei.com/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=218309
>> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
>> index 5029eb3390a5..8f964f8b0f96 100644
>> --- a/fs/ubifs/file.c
>> +++ b/fs/ubifs/file.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/mount.h>
>>   #include <linux/slab.h>
>>   #include <linux/migrate.h>
>> +#include <linux/posix_acl.h>
>>   static int read_block(struct inode *inode, void *addr, unsigned int 
>> block,
>>                 struct ubifs_data_node *dn)
>> @@ -1298,6 +1299,9 @@ int ubifs_setattr(struct mnt_idmap *idmap, 
>> struct dentry *dentry,
>>       else
>>           err = do_setattr(c, inode, attr);
>> +    if (!err && (attr->ia_valid & ATTR_MODE))
>> +        err = posix_acl_chmod(idmap, dentry, inode->i_mode);
>> +
>>       return err;
>>   }
>>
> 

