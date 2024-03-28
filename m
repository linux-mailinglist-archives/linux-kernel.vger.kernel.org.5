Return-Path: <linux-kernel+bounces-123811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C924890E63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7075CB2331E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599A04CB36;
	Thu, 28 Mar 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2MH9qbX"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9A1386A4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667859; cv=none; b=crJTEnhtW144pLUfmgaBFZ71oo6/np/LsgkkNXlA53LbGgSWXydN/4qVkPVUHeFEIi9n7JCDlbe1qptxnpVEO0JvqWf0aIJu6Gu/JyKDMRLq1C9UUp2a0PLEmWgrqRaau/bGM0io05hl6OSk0F4lRmUUbTSz5mSXure04z6E/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667859; c=relaxed/simple;
	bh=qz/ZOwPxzRAUN7QT+W8mgG5XKRE9+4Vi4VFJJD1vQso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSkN8dQpR2M+jdM/fhz6Q+CcdtPRy3JoQSSw7Tyj4va4VK2iN2alDCjXMDWXLgDH3fxSZsZB3MfKyJOjrA/5AQePMlqT+N3DgTGyXBERZgXHBgPOWZmKittT/ZVteQjTxkDBq7Nf9SKUF1BudMhCEjJTGAcOuLrLNIavJ1yDQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2MH9qbX; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-368713f2f23so6062885ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711667857; x=1712272657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2v90DUlKpjhOLZl1rw64Xlm3Q4Q6sm+btfgsYfxZw2Q=;
        b=Y2MH9qbX52ctw1mz7eLsvwEo+/hwzQ61hldlJlf194RwDhjG6sZgu+ypcubQ+Go+Lo
         1iioDaHDqTKFOi2QJ91Xg5F8KxpAszKRWUU5UQUhPdgONtdP3vFmD3+0jCBhUWQ//9eh
         pZWh5kv/N5lXUaE1CGlVaQyq8jaSeJVYNW+AhyjL59AQiqEyLfw3XURICckZd9NpQfpT
         O55H509nrov/GlfuXkjO+5eXKatEozyfrpIe5Tp50QddBPKQy/H9UgQVsZYQ92TTO2Xu
         L1o3qfJg4PiLUI3zLbZNkcmjV1g0HBz8TrvG8aAgJW3PPuOXiDL+T+Sl+j75Gjjj9Fc9
         cu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667857; x=1712272657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v90DUlKpjhOLZl1rw64Xlm3Q4Q6sm+btfgsYfxZw2Q=;
        b=Bkif/jscvLq9rfENHz/Leg0pqXxwmvAKKPHxHcjEaC+W4GOD7XB45BolmAVus4Zgl6
         6SpxHaGDEpjiJTNS6/LmtKhYIOT4eSXi0GM1Y9BHtu72gkk2cWVfAy2fjirhB9AwzXQT
         XoUgwwTg7P443496nXoQ6sP4BuTEVVpeCbvXuADe1BkXU7FKFuTIh2aG2hRaFxMZeBhj
         UL0M59BBriDxBq1Tl+gyfm9Gse/MwW2Bc2RyGNCAPjeUovfIbgcWkefXSqJUgdwxqe7U
         PrV4H/D1M9PggGiiacpumrvaQSjz5zYnmUdFJ6yxsGDqSpcGGKA8dW8kmagAq0HaxrLc
         ha4Q==
X-Gm-Message-State: AOJu0Yz6SJFbG0tF9eeY1S/7eaIrZ97Wfr8zgfoRbgl9ozdkdsD83ikT
	60nKetm+b8kpd662BoH420yyP07lh7TzmhKg7DFqRXv6lOaco/sZOIYewdCdAg==
X-Google-Smtp-Source: AGHT+IFInokgXNwvxmves1sB7593Yy05RboA2wXjkpRWG1xq1peM7ZsU8Lp/hQxPmY5met5iGuy8kQ==
X-Received: by 2002:a05:6e02:1a8a:b0:368:8a16:50a9 with SMTP id k10-20020a056e021a8a00b003688a1650a9mr707277ilv.2.1711667856759;
        Thu, 28 Mar 2024 16:17:36 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e02152f00b00368825f7a15sm700693ilu.72.2024.03.28.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:17:35 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:17:33 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>, 
	Arnd Bergmann <arnd@arndb.de>, Martin Brandenburg <martin@omnibond.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, devel@lists.orangefs.org
Subject: Re: [PATCH 04/11] orangefs: convert strncpy() to strscpy()
Message-ID: <l27q6xcktcki7hfn3b6bvoyhu7hppyb2ouolwqfvracvdc4tte@qql4swc5yfbh>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-5-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about a truncated string copy with a 255 byte string getting
> copied to a buffer of the same length, losing the 0-termination:
> 
> In function 'orangefs_unmount',
>     inlined from 'orangefs_kill_sb' at arm-soc/fs/orangefs/super.c:619:6:
> fs/orangefs/super.c:406:9: error: 'strncpy' output may be truncated copying 255 bytes from a string of length 255 [-Werror=stringop-truncation]
>   406 |         strncpy(op->upcall.req.fs_umount.orangefs_config_server,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   407 |             devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I see that most string copies in orangefs are for the upcalls and use
> a buffer that is one short to get the implied termination from the
> zero-filled buffer, but some other instances lack the '-1' part.
> 
> Convert from strncpy() to strscpy() to avoids both the warning about
> the buffer size and the need for the explicit padding, since strscpy
> guarantees a zero-terminated buffer.
>

I think I got most of these with my patch sent earlier last week:

https://lore.kernel.org/all/20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com/

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/orangefs/dcache.c |  4 ++--
>  fs/orangefs/namei.c  | 33 +++++++++++++++------------------
>  fs/orangefs/super.c  | 16 +++++++---------
>  3 files changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
> index 8bbe9486e3a6..96ed9900f7a9 100644
> --- a/fs/orangefs/dcache.c
> +++ b/fs/orangefs/dcache.c
> @@ -33,9 +33,9 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
>  
>  	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
>  	new_op->upcall.req.lookup.parent_refn = parent->refn;
> -	strncpy(new_op->upcall.req.lookup.d_name,
> +	strscpy(new_op->upcall.req.lookup.d_name,
>  		dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +		ORANGEFS_NAME_MAX);
>  
>  	gossip_debug(GOSSIP_DCACHE_DEBUG,
>  		     "%s:%s:%d interrupt flag [%d]\n",
> diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> index c9dfd5c6a097..5e46d3bdcb05 100644
> --- a/fs/orangefs/namei.c
> +++ b/fs/orangefs/namei.c
> @@ -41,8 +41,8 @@ static int orangefs_create(struct mnt_idmap *idmap,
>  	fill_default_sys_attrs(new_op->upcall.req.create.attributes,
>  			       ORANGEFS_TYPE_METAFILE, mode);
>  
> -	strncpy(new_op->upcall.req.create.d_name,
> -		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.create.d_name,
> +		dentry->d_name.name, ORANGEFS_NAME_MAX);
>  
>  	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
>  
> @@ -137,8 +137,8 @@ static struct dentry *orangefs_lookup(struct inode *dir, struct dentry *dentry,
>  		     &parent->refn.khandle);
>  	new_op->upcall.req.lookup.parent_refn = parent->refn;
>  
> -	strncpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.lookup.d_name, dentry->d_name.name,
> +		ORANGEFS_NAME_MAX);
>  
>  	gossip_debug(GOSSIP_NAME_DEBUG,
>  		     "%s: doing lookup on %s under %pU,%d\n",
> @@ -192,8 +192,8 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
>  		return -ENOMEM;
>  
>  	new_op->upcall.req.remove.parent_refn = parent->refn;
> -	strncpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.remove.d_name, dentry->d_name.name,
> +		ORANGEFS_NAME_MAX);
>  
>  	ret = service_operation(new_op, "orangefs_unlink",
>  				get_interruptible_flag(inode));
> @@ -247,10 +247,9 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
>  			       ORANGEFS_TYPE_SYMLINK,
>  			       mode);
>  
> -	strncpy(new_op->upcall.req.sym.entry_name,
> -		dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> -	strncpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.sym.entry_name,
> +		dentry->d_name.name, ORANGEFS_NAME_MAX);
> +	strscpy(new_op->upcall.req.sym.target, symname, ORANGEFS_NAME_MAX);
>  
>  	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
>  
> @@ -324,8 +323,8 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	fill_default_sys_attrs(new_op->upcall.req.mkdir.attributes,
>  			      ORANGEFS_TYPE_DIRECTORY, mode);
>  
> -	strncpy(new_op->upcall.req.mkdir.d_name,
> -		dentry->d_name.name, ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.mkdir.d_name,
> +		dentry->d_name.name, ORANGEFS_NAME_MAX);
>  
>  	ret = service_operation(new_op, __func__, get_interruptible_flag(dir));
>  
> @@ -405,12 +404,10 @@ static int orangefs_rename(struct mnt_idmap *idmap,
>  	new_op->upcall.req.rename.old_parent_refn = ORANGEFS_I(old_dir)->refn;
>  	new_op->upcall.req.rename.new_parent_refn = ORANGEFS_I(new_dir)->refn;
>  
> -	strncpy(new_op->upcall.req.rename.d_old_name,
> -		old_dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> -	strncpy(new_op->upcall.req.rename.d_new_name,
> -		new_dentry->d_name.name,
> -		ORANGEFS_NAME_MAX - 1);
> +	strscpy(new_op->upcall.req.rename.d_old_name,
> +		old_dentry->d_name.name, ORANGEFS_NAME_MAX);
> +	strscpy(new_op->upcall.req.rename.d_new_name,
> +		new_dentry->d_name.name, ORANGEFS_NAME_MAX);
>  
>  	ret = service_operation(new_op,
>  				"orangefs_rename",
> diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> index d990f4356b30..c714380ab38b 100644
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@ -256,7 +256,7 @@ int orangefs_remount(struct orangefs_sb_info_s *orangefs_sb)
>  	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
>  	if (!new_op)
>  		return -ENOMEM;
> -	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> +	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
>  		orangefs_sb->devname,
>  		ORANGEFS_MAX_SERVER_ADDR_LEN);
>  
> @@ -403,8 +403,8 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
>  		return -ENOMEM;
>  	op->upcall.req.fs_umount.id = id;
>  	op->upcall.req.fs_umount.fs_id = fs_id;
> -	strncpy(op->upcall.req.fs_umount.orangefs_config_server,
> -	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> +	strscpy(op->upcall.req.fs_umount.orangefs_config_server,
> +	    devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
>  	r = service_operation(op, "orangefs_fs_umount", 0);
>  	/* Not much to do about an error here. */
>  	if (r)
> @@ -497,9 +497,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
>  	if (!new_op)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> -		devname,
> -		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> +	strscpy(new_op->upcall.req.fs_mount.orangefs_config_server,
> +		devname, ORANGEFS_MAX_SERVER_ADDR_LEN);
>  
>  	gossip_debug(GOSSIP_SUPER_DEBUG,
>  		     "Attempting ORANGEFS Mount via host %s\n",
> @@ -546,9 +545,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
>  	 * on successful mount, store the devname and data
>  	 * used
>  	 */
> -	strncpy(ORANGEFS_SB(sb)->devname,
> -		devname,
> -		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
> +	strscpy(ORANGEFS_SB(sb)->devname, devname,
> +		ORANGEFS_MAX_SERVER_ADDR_LEN);
>  
>  	/* mount_pending must be cleared */
>  	ORANGEFS_SB(sb)->mount_pending = 0;
> -- 
> 2.39.2
> 
Thanks
Justin

