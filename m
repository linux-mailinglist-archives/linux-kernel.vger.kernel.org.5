Return-Path: <linux-kernel+bounces-109609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89DF881B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5403E1F213FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCFB5684;
	Thu, 21 Mar 2024 02:55:32 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9679C0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989731; cv=none; b=UTzS48RYTIYgOEbplLT96lessQg50YxaFX5G60/Sx08f6/p2g+dC6/jnu+zvyfk6L9knWBhT3qy5DxFbR9MQOqzUQUXFso9IUzju1+H2IRkwfskyHFi1zlS91cx6NRoQChAn0c3efiBx//jh6dKuOhA9bEiMJkxPmWpQOCTByPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989731; c=relaxed/simple;
	bh=+7lTDwmSBOUwi/jPMHGe79qJoB0iiS7yQSPs+9VAo8U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B4SrT7RCbdWZvCh1syrCbiY6m2ikkTecIATS+R3teRcjLpp7mnnp2cIe+sTDew8yVyJx4hVGIlQM8gn6zUJThiqPYsxDZ8BauN0TlDN4feoZOsev4PnOBuXbVaJeszgNxXaIBgsWPPdjvOA6CeOj7mqo21HxzJ4qlNM2rZ6F7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V0VPW3YkHzXjLb;
	Thu, 21 Mar 2024 10:52:47 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 10E7918007D;
	Thu, 21 Mar 2024 10:55:25 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 10:55:24 +0800
Subject: Re: [RFC PATCH 1/5] ubifs: Implement POSIX Access Control Lists
 (ACLs)
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-2-lizetao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <61bf91fb-f926-8fdf-0157-20f5ad2ae279@huawei.com>
Date: Thu, 21 Mar 2024 10:55:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240319161646.2153867-2-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/20 0:16, Li Zetao Ð´µÀ:
> Implement the ACLs feature for ubifs based on vfs Posix ACLs,
> details as follows:
>    * Initialize acl for newly created inode.
>    * Provides get/set interface to access ACLs.
> 
> ACLs feature relies on xattr implementation which using specific key
> names "system.posix_acl_default" and "system.posix_acl_access". Now Only
> the v2 version of POSIX ACLs is supported, and ubifs does not need to
> customize the storage format, which can simplify the implementation.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   fs/ubifs/acl.c   | 140 +++++++++++++++++++++++++++++++++++++++++++++++
>   fs/ubifs/ubifs.h |  13 +++++
>   fs/ubifs/xattr.c |   1 -
>   3 files changed, 153 insertions(+), 1 deletion(-)
>   create mode 100644 fs/ubifs/acl.c
> 
> diff --git a/fs/ubifs/acl.c b/fs/ubifs/acl.c
> new file mode 100644
> index 000000000000..253568baf097
> --- /dev/null
> +++ b/fs/ubifs/acl.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This file is part of UBIFS.
> + *
> + * Copyright (C) 2024 Huawei Tech. Co., Ltd.
> + *
> + * Authors: Li Zetao <lizetao1@huawei.com>
> + */
> +
> +/* This file implements POSIX Access Control Lists (ACLs) */
> +
> +#include "ubifs.h"
> +
> +#include <linux/posix_acl_xattr.h>
> +
> +struct posix_acl *ubifs_get_inode_acl(struct inode *inode, int type, bool rcu)
> +{
> +	char *xattr_value = NULL;
> +	const char *xattr_name;
> +	struct posix_acl *acl;
> +	ssize_t size;
> +
> +	if (rcu)
> +		return ERR_PTR(-ECHILD);
> +
> +	xattr_name = posix_acl_xattr_name(type);
> +	if (unlikely(!strcmp(xattr_name, "")))
> +		return ERR_PTR(-EINVAL);
The acl type has been guaranteed valid from vfs caller, there is no need 
to check converted name by 'strcmp', in theory, we can use it directly 
just like f2fs does. For this case, I suggest to unfold the 
posix_acl_xattr_name and convert it to corresponding name just like 
btrfs does.
> +
> +	size = ubifs_xattr_get(inode, xattr_name, NULL, 0);
> +	if (size > 0) {
> +		xattr_value = kzalloc(size, GFP_KERNEL);
> +		if (unlikely(!xattr_value))
> +			return ERR_PTR(-ENOMEM);
> +
> +		size = ubifs_xattr_get(inode, xattr_name, xattr_value, size);
> +	}
> +
> +	if (size > 0)
> +		acl = posix_acl_from_xattr(&init_user_ns, xattr_value, size);
> +	else if (size == -ENODATA || size == 0)
> +		acl = NULL;
> +	else
> +		acl = ERR_PTR(size);
> +
> +	kfree(xattr_value);
> +
> +	return acl;
> +}
> +
> +static int __ubifs_set_acl(struct inode *inode, int type, struct posix_acl *acl, int flags)
> +{
> +	void *xattr_value = NULL;
> +	const char *xattr_name;
> +	size_t size = 0;
> +	int error;
> +

> +	xattr_name = posix_acl_xattr_name(type);
> +	if (unlikely(!strcmp(xattr_name, "")))
> +		return -EINVAL;
> +
> +	if (unlikely(!strcmp(xattr_name, XATTR_NAME_POSIX_ACL_DEFAULT) && !S_ISDIR(inode->i_mode)))
> +		return acl ? -EACCES : 0;
> +
Similar to previous, replace above 6 lines, refer to __btrfs_set_acl but 
keep the error code same with __ext4_set_acl.
> +	if (acl) {
> +		size = posix_acl_xattr_size(acl->a_count);
> +		xattr_value = kmalloc(size, GFP_KERNEL);
> +		if (unlikely(!xattr_value))
> +			return -ENOMEM;
> +
> +		error = posix_acl_to_xattr(&init_user_ns, acl, xattr_value, size);
> +		if (unlikely(error < 0))
> +			goto out;
> +	}
> +
> +	error = ubifs_xattr_set(inode, xattr_name, xattr_value, size, flags, false);
There are 2 situations here, Updating acl and Removing acl. For the 
later case, funcion vfs_remove_acl will remove corresponding xattr, the 
xattr removing function in ubifs is ubifs_xattr_remove.
> +	if (likely(!error))
I prefer to remove the 'likely', UBIFS limits the max xattr count for 
each file(Goto create_xattr), non zero error returned is a common case 
on a small LEB flash.
> +		set_cached_acl(inode, type, acl);
> +out:
> +	kfree(xattr_value);
> +	return error;
> +}
> +
> +int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, struct posix_acl *acl, int type)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	umode_t old_mode = inode->i_mode;
> +	int error;
> +
> +	if (type == ACL_TYPE_ACCESS && acl) {
> +		error = posix_acl_update_mode(idmap, inode, &inode->i_mode, &acl);
> +		if (unlikely(error))
> +			return error;
> +	}
> +
> +	error = __ubifs_set_acl(inode, type, acl, 0);
> +	if (unlikely(error))
Mentioned in __ubifs_set_acl, error could be returned, just remove 
'unlikely'.
> +		inode->i_mode = old_mode;
> +
> +	return error;
> +
> +}
> +
> +/**
> + * ubifs_init_acl - initialize the ACLs for a new inode.
> + * @inode: newly created inode
> + * @dir: parent directory inode
> + *
> + * This function initialize ACLs, including inheriting the
initialize -> initializes
> + * default ACLs of parent directory or modifying the default
> + * ACLs according to the mode parameter in open() / creat()
> + * system calls.
> + */
> +int ubifs_init_acl(struct inode *inode, struct inode *dir)
> +{
> +	struct posix_acl *default_acl;
> +	struct posix_acl *acl;
> +	int error;
> +
> +	error = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
> +	if (unlikely(error))
> +		return error;
> +
> +	if (default_acl) {
> +		error = __ubifs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl, XATTR_CREATE);
> +		posix_acl_release(default_acl);
> +	} else {
> +		inode->i_default_acl = NULL;
> +	}
> +
> +	if (acl) {
> +		if (likely(!error))
Remove 'likely'.
> +			error = __ubifs_set_acl(inode, ACL_TYPE_ACCESS, acl, XATTR_CREATE);
> +		posix_acl_release(acl);
> +	} else {
> +		inode->i_acl = NULL;
> +	}
> +
> +	return error;
> +}
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 3916dc4f30ca..b0d3b076290d 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -2069,6 +2069,19 @@ static inline int ubifs_init_security(struct inode *dentry,
>   }
>   #endif
>   
> +#ifdef CONFIG_UBIFS_FS_POSIX_ACL
> +struct posix_acl *ubifs_get_inode_acl(struct inode *inode, int type, bool rcu);
> +int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, struct posix_acl *acl, int type);
> +int ubifs_init_acl(struct inode *inode, struct inode *dir);
> +
> +#else /* CONFIG_UBIFS_FS_POSIX_ACL */
> +#define ubifs_get_inode_acl NULL
> +#define ubifs_set_acl NULL
> +static inline int ubifs_init_acl(struct inode *inode, struct inode *dir)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_UBIFS_FS_POSIX_ACL */
>   
>   /* super.c */
>   struct inode *ubifs_iget(struct super_block *sb, unsigned long inum);
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 0847db521984..eb1c1f5d10df 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -40,7 +40,6 @@
>    * in the VFS inode cache. The xentries are cached in the LNC cache (see
>    * tnc.c).
>    *
> - * ACL support is not implemented.
>    */
>   
>   #include "ubifs.h"
> 


