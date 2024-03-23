Return-Path: <linux-kernel+bounces-112190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D38876B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A29BB22585
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489891388;
	Sat, 23 Mar 2024 02:42:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128A522D;
	Sat, 23 Mar 2024 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711161737; cv=none; b=aPf7VppVDLOvAPM3doB9wEFYGou9qqsKpyk9SmfTtmSoCb9iZ5nI5koUugwsyzPxkPdzEzO3lRuHHHFgkQyXRGZaHdFXjC+oz41mHSTtrkSUdMMZ4YuWd8ivHIXOJJCH+Z3yMNzJzXX3wh+E5GQuUrEknTuIC8wZYd+xFDqUha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711161737; c=relaxed/simple;
	bh=czPBDG49zGfpUS6gXvCHWxsa3SivPj6DFoItki3pQXA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z3sDw9eEswY5dPLVvbFI6WbVvjF6hs2JTP8IHE36ZM8vIUdhRtLqM9zVnkSmUTsaSZLYIjX3p9r/PYsxHHD5a6mKxcA7Q+teAE/rGPHIvDcpIREu7T0tsxuWeY8+4r6f6f/lO5JPq76FjZupcOI2n90HU8/YWqGOvLfYN++NuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V1k1L5ny6zwQ28;
	Sat, 23 Mar 2024 10:39:34 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 599581400D7;
	Sat, 23 Mar 2024 10:42:10 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Mar 2024 10:42:09 +0800
Subject: Re: [RFC PATCH v2 2/5] ubifs: Implement POSIX Access Control Lists
 (ACLs)
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <linux-mtd@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240322154812.215369-1-lizetao1@huawei.com>
 <20240322154812.215369-3-lizetao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <daa0f858-ea85-1bf3-906c-4ef1a4998ccf@huawei.com>
Date: Sat, 23 Mar 2024 10:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240322154812.215369-3-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/22 23:48, Li Zetao Ð´µÀ:
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
> It should be noted that Linux supports updating the file mode through
> ACLs. However the acl may not exist, so ubifs_xattr_remove() returns
> -ENODATA. Such a scenario needs to be specially handled. At the same
> time, it needs to ensure that the updated inode is written to flash.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> v1 -> v2:
>    * Get xattr_name by direct expansion instead of posix_acl_xattr_name().
>    * Modify ubifs_xattr_remove to an external function to remove the xattr of ACL.
>    * Remove redundant likely() and unlikely().
>    * Fix updating file mode via ACL and support writing to flash.
> 
> v1: https://lore.kernel.org/all/20240319161646.2153867-2-lizetao1@huawei.com/
> 
>   fs/ubifs/Makefile |   1 +
>   fs/ubifs/acl.c    | 192 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/ubifs/ubifs.h  |  14 ++++
>   fs/ubifs/xattr.c  |   3 +-
>   4 files changed, 208 insertions(+), 2 deletions(-)
>   create mode 100644 fs/ubifs/acl.c
> 
[...]
> +static int ubifs_update_mode(struct inode *inode, umode_t mode)
> +{
> +	struct ubifs_inode *ui = ubifs_inode(inode);
> +	struct ubifs_info *c = inode->i_sb->s_fs_info;
> +	struct ubifs_budget_req req = { .dirtied_ino = 1,
> +				.dirtied_ino_d = ALIGN(ui->data_len, 8) };
> +	int release;
> +	int err;
> +
> +	err = ubifs_budget_space(c, &req);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&ui->ui_mutex);
> +	release = ui->dirty;
> +	inode->i_mode = mode;
> +	inode_set_ctime_current(inode);
> +	mark_inode_dirty_sync(inode);
> +	mutex_unlock(&ui->ui_mutex);
> +
> +	if (release)
> +		ubifs_release_budget(c, &req);
> +	if (IS_SYNC(inode))
> +		err = inode->i_sb->s_op->write_inode(inode, NULL);
> +
> +	return err;
> +}
> +
> +int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, struct posix_acl *acl, int type)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	umode_t mode = inode->i_mode;
> +	bool update_mode = false;
> +	int error;
> +
> +	if (type == ACL_TYPE_ACCESS && acl) {
> +		error = posix_acl_update_mode(idmap, inode, &mode, &acl);
> +		if (unlikely(error))
> +			return error;
> +
> +		if (inode->i_mode != mode)
> +			update_mode = true;
> +	}
> +
> +	error = __ubifs_set_acl(inode, type, acl, 0);
> +	if (!error && update_mode)
> +		error = ubifs_update_mode(inode, mode);

Updating inode mode to disk is a right thing. However, this makes 
ubifs_set_acl is not atomic, which is manifested in two points:
1. If ubifs_budget_space fails by ENOSPC, __ubifs_set_acl has stored 
xattrs into disk, but inode mode is not updated, which makes inode->mode 
be inconsistent with acl. This problem can be easily solved by moving 
ubifs_budget_space before the __ubifs_set_acl.
2. If ubifs_write_inode fails or a powercut happens between 
__ubifs_set_acl and ubifs_write_inode, inode->mode becomes inconsistent 
with acl. PS: Ext4 makes set_acl atomic by 'handle'.
> +
> +	return error;
> +
> +}

