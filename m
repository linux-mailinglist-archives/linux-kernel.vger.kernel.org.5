Return-Path: <linux-kernel+bounces-6197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC138195C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A31F267F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5781D6AE;
	Wed, 20 Dec 2023 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KwwG/8Lx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEE4423
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4EFC433C8;
	Wed, 20 Dec 2023 00:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703032555;
	bh=XT/zovLOBmnZeQxmRj3HaYlA/gd3BKurq41D6Jrq9F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwwG/8LxoJGLo4BvzZqmImMTjb4Z3lchHZ236e2JuYFSqqOfWFtmsVmNRDA/qJsJf
	 uZaHFRRVEnwi15A6O1YGdAnMw8Wf96XsHf5K2lUKrbZ1F8ZF+XjIZfOVDjsVPJ50Nc
	 qa839JAIktgKGz8+DT5p838ZhgJ2duX74ItMm46A=
Date: Tue, 19 Dec 2023 16:35:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ahelenia =?UTF-8?B?WmllbWlhxYRza2E=?=
 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andrew Morton <akpm@linux-foudation.org>, Li kunyu
 <kunyu@nfschina.com>, Zhao Lei <zhao_lei1@hoperun.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Zhang Zhengming <zhang.zhengming@h3c.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: relay: remove relay_file_splice_read
 =?UTF-8?B?4oCS?= dead code, doesn't work
Message-Id: <20231219163554.a65b8d9e918aeb28e21b5c21@linux-foundation.org>
In-Reply-To: <dtexwpw6zcdx7dkx3xj5gyjp5syxmyretdcbcdtvrnukd4vvuh@tarta.nabijaczleweli.xyz>
References: <dtexwpw6zcdx7dkx3xj5gyjp5syxmyretdcbcdtvrnukd4vvuh@tarta.nabijaczleweli.xyz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 23:24:14 +0100 Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz> wrote:

> Documentation/filesystems/relay.rst says to use
> 	return debugfs_create_file(filename, mode, parent, buf,
> 	                           &relay_file_operations);
> and this is the only way relay_file_operations is used.
> 
> Thus: debugfs_create_file(&relay_file_operations)
>    -> __debugfs_create_file(&debugfs_full_proxy_file_operations,
>                             &relay_file_operations)
>    -> dentry{inode: {i_fop: &debugfs_full_proxy_file_operations},
>              d_fsdata: &relay_file_operations
>                        | DEBUGFS_FSDATA_IS_REAL_FOPS_BIT}
> 
> debugfs_full_proxy_file_operations.open is full_proxy_open, which
> extracts the &relay_file_operations from the dentry, and allocates
> via __full_proxy_fops_init() new fops, with trivial wrappers around
> release, llseek, read, write, poll, and unlocked_ioctl, then replaces
> the fops on the opened file therewith.
> 
> Naturally, all thusly-created debugfs files have .splice_read = NULL.
> This was introduced in
> commit 49d200deaa680501f19a247b1fffb29301e51d2b ("debugfs: prevent
>  access to removed files' private data") from 2016-03-22.
> 
> AFAICT, relay_file_operations is the only struct file_operations
> used for debugfs which defines a .splice_read callback.
> Hooking it up with
> >	diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> >	index 5063434be0fc..952fcf5b2afa 100644
> >	--- a/fs/debugfs/file.c
> >	+++ b/fs/debugfs/file.c
> >	@@ -328,6 +328,11 @@ FULL_PROXY_FUNC(write, ssize_t, filp,
> >	 			loff_t *ppos),
> >	 		ARGS(filp, buf, size, ppos));
> >
> >	+FULL_PROXY_FUNC(splice_read, long, in,
> >	+		PROTO(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe,
> >	+			size_t len, unsigned int flags),
> >	+		ARGS(in, ppos, pipe, len, flags));
> >	+
> >	 FULL_PROXY_FUNC(unlocked_ioctl, long, filp,
> >	 		PROTO(struct file *filp, unsigned int cmd, unsigned long arg),
> >	 		ARGS(filp, cmd, arg));
> >	@@ -382,6 +387,8 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
> >	 		proxy_fops->write = full_proxy_write;
> >	 	if (real_fops->poll)
> >	 		proxy_fops->poll = full_proxy_poll;
> >	+	if (real_fops->splice_read)
> >	+		proxy_fops->splice_read = full_proxy_splice_read;
> >	 	if (real_fops->unlocked_ioctl)
> >	 		proxy_fops->unlocked_ioctl = full_proxy_unlocked_ioctl;
> >	 }
> shows it just doesn't work, and splicing always instantly returns empty
> (subsequent reads actually return the contents).
> 
> No-one noticed it became dead code in 2016, who knows if it worked back
> then. Clearly no-one cares; just delete it.
> 

All checks out for me.  How on earth did you notice this?

> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -1073,167 +1073,6 @@ static ssize_t relay_file_read(struct file *filp,
>  	return written;
>  }
>  
> -static void relay_consume_bytes(struct rchan_buf *rbuf, int bytes_consumed)

And all this goop wasn't even inside #ifdef DEBUF_FS.



