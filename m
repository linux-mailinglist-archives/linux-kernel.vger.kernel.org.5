Return-Path: <linux-kernel+bounces-109633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EA881BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F31F24120
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3FB672;
	Thu, 21 Mar 2024 03:48:11 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8D8F45
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992890; cv=none; b=afsz5/HMjEZvfdWVptqT1T/qCpSnDeS+tUSw+DKvTSbXOP//i/8dgA6RsVihmK7ud3NvSU3Xf15le1g0TkfD1VtmgFbzZZafMQmT3RGC/6v6+GMFUJVR2qW5byVO+9PGgmdiVvF+6sDeb2bCWAnIwgZcS6Y8MjGzF9/u1czDssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992890; c=relaxed/simple;
	bh=6QNI8buEq7UTX/W/unqutDITvGcOVJBmsU7RWxjS088=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j1+piig7cIGTIb7qP5UFnxAkCxPml7KHjYYRNAR08NTDAnurZox3ZImORCFHsm5f/6GE3D31q7jUGjV7LOrtKbPbwDP/vo5gjaUN60NEr7oXDP1TbcVUuTldUd4qo4IKuwYp0yaRvGUMR5AwJvcT/TWWGalEzAKeEdSQNJMA8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V0Wb039dMzNmCY;
	Thu, 21 Mar 2024 11:46:04 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D216140390;
	Thu, 21 Mar 2024 11:47:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 11:47:57 +0800
Subject: Re: [RFC PATCH 2/5] ubifs: Initialize or update ACLs for inode
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-3-lizetao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2991c168-723d-48ef-8420-61e22a897239@huawei.com>
Date: Thu, 21 Mar 2024 11:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240319161646.2153867-3-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/20 0:16, Li Zetao Ð´µÀ:
> There are two scenarios where ACL needs to be updated, the first one
> is when creating the inode, and the second one is in the chmod process.
> When creating directories/files/device node/tmpfile, ACLs needs to be
> initialized, but symlink do not.Why not support symlink? It looks like many filesystems(eg. ext4, f2fs, 
btrfs) support it, except xfs.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   fs/ubifs/dir.c  | 16 ++++++++++++++++
>   fs/ubifs/file.c |  4 ++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 551148de66cd..dfb6823cc953 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -316,6 +316,10 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
>   		goto out_fname;
>   	}
>   
> +	err = ubifs_init_acl(inode, dir);
> +	if (err)
> +		goto out_inode;
> +
Attention, a new inconsistent problem point is imported by acl xattr 
creation. See https://bugzilla.kernel.org/show_bug.cgi?id=218309.  @Richard
>   	err = ubifs_init_security(dir, inode, &dentry->d_name);
>   	if (err)
>   		goto out_inode;
> @@ -466,6 +470,10 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>   	}
>   	ui = ubifs_inode(inode);
>   
> +	err = ubifs_init_acl(inode, dir);
> +	if (err)
> +		goto out_inode;
> +
>   	err = ubifs_init_security(dir, inode, &dentry->d_name);
>   	if (err)
>   		goto out_inode;
> @@ -1013,6 +1021,10 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>   		goto out_fname;
>   	}
>   
> +	err = ubifs_init_acl(inode, dir);
> +	if (err)
> +		goto out_inode;
> +
>   	err = ubifs_init_security(dir, inode, &dentry->d_name);
>   	if (err)
>   		goto out_inode;
> @@ -1108,6 +1120,10 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   	ui->data = dev;
>   	ui->data_len = devlen;
>   
> +	err = ubifs_init_acl(inode, dir);
> +	if (err)
> +		goto out_inode;
> +
>   	err = ubifs_init_security(dir, inode, &dentry->d_name);
>   	if (err)
>   		goto out_inode;
The whiteout inode is not set acl for rename(WHITEOUT) operation. It 
looks like many filesystems(eg. ext4, f2fs, btrfs) support it, except 
xfs. In my opinion, whiteout is a char dev, since char/block device is 
supported, why not support whiteout?

If we support whiteout, we should make sure that the whiteout renameing 
operation is atomic[1]. But I cannot come up with an idea how to combine 
whiteout xattr(acl) creation and whiteout file creation into an atomic 
operation, just like problem mentioned in [2],

[1] 
https://lore.kernel.org/linux-mtd/20211227032246.2886878-6-chengzhihao1@huawei.com/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=218309
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 5029eb3390a5..8f964f8b0f96 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -41,6 +41,7 @@
>   #include <linux/mount.h>
>   #include <linux/slab.h>
>   #include <linux/migrate.h>
> +#include <linux/posix_acl.h>
>   
>   static int read_block(struct inode *inode, void *addr, unsigned int block,
>   		      struct ubifs_data_node *dn)
> @@ -1298,6 +1299,9 @@ int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	else
>   		err = do_setattr(c, inode, attr);
>   
> +	if (!err && (attr->ia_valid & ATTR_MODE))
> +		err = posix_acl_chmod(idmap, dentry, inode->i_mode);
> +
>   	return err;
>   }
>   
> 


