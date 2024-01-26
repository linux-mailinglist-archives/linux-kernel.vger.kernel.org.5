Return-Path: <linux-kernel+bounces-39482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5483D1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56E81C23299
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE341EDE;
	Fri, 26 Jan 2024 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UJoqfeqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D8387;
	Fri, 26 Jan 2024 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231346; cv=none; b=dZHa8B3Ge4h9AzJ7dqjGKxrFdji7IOnrO60vTVGcmOm1pNFGY1WapKkoWMdGDnNlRHMUmu8sEYMBU0IhpOU68QSWqmyxYEYF4WX/VWz6GWSxc4hZBYYlTktb3UrBvYkhJGk8xNbZAz/F9wRvfA7uJIG9Yj8EHI0Y21eD3AlijnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231346; c=relaxed/simple;
	bh=ZcNBosLvwzHAld72+LuB55jLJ9C0jyjKAALEGkHTKFM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nKLdDST573B76tIl7a8+ep2MsbO5kPNt7U+/jQ9PHzOHHkC3kWC1MjQvDvthvtcSSxIPpouw1IWhG+6FIQSgGTUDNPfu5uUqwZOqLeKqYzWnPRAsU4+CIYBwz01wH86bOqPDqJg1wCbxV01xbb7TZLBCLQk9MQ5mxuAZv/br2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UJoqfeqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CBBC433F1;
	Fri, 26 Jan 2024 01:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706231345;
	bh=ZcNBosLvwzHAld72+LuB55jLJ9C0jyjKAALEGkHTKFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJoqfeqeIy/4MNN+brvu8oK2me7WSipoIos2XaP5hv0zYuiIKPWyMK5YLGSiOgMlp
	 Olif5eyyzRLcw+B5NLyI8Ly0QNOV+oAfNYp9QEdHn1NnYpdwKsWNQdfiSVqWmpuSFT
	 gtSew4R/pju2PGTBvhAj4vpekWnNDxxuq9ptwmWU=
Date: Thu, 25 Jan 2024 17:08:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3 5/5] ramfs: Initialize security of in-memory inodes
Message-Id: <20240125170858.1ce723a57c7fd2b9bfb5d28d@linux-foundation.org>
In-Reply-To: <20231116090125.187209-6-roberto.sassu@huaweicloud.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
	<20231116090125.187209-6-roberto.sassu@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 10:01:25 +0100 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a call security_inode_init_security() after ramfs_get_inode(), to let
> LSMs initialize the inode security field. Skip ramfs_fill_super(), as the
> initialization is done through the sb_set_mnt_opts hook.
> 
> Calling security_inode_init_security() call inside ramfs_get_inode() is
> not possible since, for CONFIG_SHMEM=n, tmpfs also calls the former after
> the latter.
> 
> Pass NULL as initxattrs() callback to security_inode_init_security(), since
> the purpose of the call is only to initialize the in-memory inodes.
> 

fwiw,

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please include this in the relevant security tree.

> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 4ac05a9e25bc..8006faaaf0ec 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -102,11 +102,20 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	int error = -ENOSPC;
>  
>  	if (inode) {
> +		error = security_inode_init_security(inode, dir,
> +						     &dentry->d_name, NULL,
> +						     NULL);
> +		if (error) {
> +			iput(inode);
> +			goto out;
> +		}
> +
>  		d_instantiate(dentry, inode);
>  		dget(dentry);	/* Extra count - pin the dentry in core */
>  		error = 0;
>  		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  	}
> +out:
>  	return error;
>  }
>  
> @@ -134,6 +143,15 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	inode = ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
>  	if (inode) {
>  		int l = strlen(symname)+1;
> +
> +		error = security_inode_init_security(inode, dir,
> +						     &dentry->d_name, NULL,
> +						     NULL);
> +		if (error) {
> +			iput(inode);
> +			goto out;
> +		}
> +
>  		error = page_symlink(inode, symname, l);
>  		if (!error) {
>  			d_instantiate(dentry, inode);
> @@ -143,6 +161,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  		} else
>  			iput(inode);
>  	}
> +out:
>  	return error;
>  }
>  
> @@ -150,12 +169,23 @@ static int ramfs_tmpfile(struct mnt_idmap *idmap,
>  			 struct inode *dir, struct file *file, umode_t mode)
>  {
>  	struct inode *inode;
> +	int error;
>  
>  	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
>  	if (!inode)
>  		return -ENOSPC;
> +
> +	error = security_inode_init_security(inode, dir,
> +					     &file_dentry(file)->d_name, NULL,
> +					     NULL);
> +	if (error) {
> +		iput(inode);
> +		goto out;
> +	}
> +
>  	d_tmpfile(file, inode);
> -	return finish_open_simple(file, 0);
> +out:
> +	return finish_open_simple(file, error);
>  }
>  
>  static const struct inode_operations ramfs_dir_inode_operations = {
> -- 
> 2.34.1

