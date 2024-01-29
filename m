Return-Path: <linux-kernel+bounces-43589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F7F8415FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37C2825B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282250A9D;
	Mon, 29 Jan 2024 22:49:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855E4F1F5;
	Mon, 29 Jan 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568581; cv=none; b=gmgroQ64/SV0OEtLExoIchpL/brlbUxPjp1FKYku74eXm8Uo9FZwe/04s94eQaEOcfwRTHTU6IQNzI31frOWyMysJ8dLPOBjnQZJt9cophv8v+ukV7hauTdokTgtik3/FPGtY7RdI3KoeQcMTfyQRppqiTd+z2uGYXT14nDMZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568581; c=relaxed/simple;
	bh=KeLg8W/OSpqeBnocOacGal7XGwVN+UGJN0OY1ZfZUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCB/GpqRf83YygBuUyMXNaX0mHwDcpstTkFM+9I8NAfU9byy0mwjb3dt1FzsnX/QrXE/ERmHAde/GAhjKGDKo+YfCBfRKtigXJmSPcU8bHjVK549rJlleBtPhSXga3xJfhyGVaz0khtKw6QQlLQsyOMjAM1VqoSfq6KD++eAtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB80C433C7;
	Mon, 29 Jan 2024 22:49:39 +0000 (UTC)
Date: Mon, 29 Jan 2024 17:49:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129174950.5a17a86c@gandalf.local.home>
In-Reply-To: <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 14:42:47 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> @@ -324,7 +322,7 @@ static struct dentry *lookup_file(struct dentry *dentry,
>  	ti->flags = TRACEFS_EVENT_INODE;
>  	ti->private = NULL;			// Directories have 'ei', files not
>  
> -	d_instantiate(dentry, inode);
> +	d_add(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
>  	return eventfs_end_creating(dentry);
>  };
> @@ -365,7 +363,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
>          ei->dentry = dentry;	// Remove me!
>  
>  	inc_nlink(inode);
> -	d_instantiate(dentry, inode);
> +	d_add(dentry, inode);
>  	inc_nlink(dentry->d_parent->d_inode);
>  	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
>  	return eventfs_end_creating(dentry);
> @@ -786,7 +784,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
> -	d_instantiate(dentry, inode);
> +	d_add(dentry, inode);

Now I didn't change this last d_instantiate, because this is not called
through the lookup code. This is the root events directory and acts more
like debugfs. It's not "dynamically" added.

-- Steve


>  	inc_nlink(dentry->d_parent->d_inode);
>  	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
>  	tracefs_end_creating(dentry);


