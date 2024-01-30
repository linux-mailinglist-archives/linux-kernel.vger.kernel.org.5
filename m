Return-Path: <linux-kernel+bounces-45220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016AA842D45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA00D1F24C40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36569D36;
	Tue, 30 Jan 2024 19:49:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319F383BA;
	Tue, 30 Jan 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644157; cv=none; b=Ok/p6zJmSlCfEUAAvf9HHQo5RnuNANtwmt68SmojTOtUy18y5M4skxgZS9HAMN7YBanaT8W+okGBWPEy7XPql/gLobW7lcmXocl1hSbSJG/NKGHPH5DYMHwqlKy5SYsNoM+8ljUNoOui/oQ7sxKgldM/j1vVMUHfZ208N1eI3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644157; c=relaxed/simple;
	bh=nrCiuWxtJvHKV4rDKb7lAqpKGGBjaec7cZXTDNkW+RM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7MHCmE+Q+RNWObtGXiEeWsir8LiDydsTemEJGS7cTCGAV8LTgVuAc2UtsORljx5+BwMp/GCKSJWslX4ZTh9exBnmA6KqrFXkjEYGkQfw3Whp/1IJiZBIrhYOBB1fhoega3EnC3wdO3CKW+Cn58yJ5doLTiGgWx00ap8fRS8V0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1564C433C7;
	Tue, 30 Jan 2024 19:49:16 +0000 (UTC)
Date: Tue, 30 Jan 2024 14:49:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] eventfsfs: initialize the tracefs inode properly
Message-ID: <20240130144928.37434701@gandalf.local.home>
In-Reply-To: <20240130190355.11486-2-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-2-torvalds@linux-foundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:03:51 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> @@ -328,7 +328,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  	inode->i_ino = EVENTFS_FILE_INODE_INO;
>  
>  	ti = get_tracefs(inode);
> -	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->flags = TRACEFS_EVENT_INODE;
> +	ti->private = NULL;			// Directories have 'ei', files not

Although ti->private does need to be initialized here.

-- Steve

> +
>  	d_instantiate(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
>  	return eventfs_end_creating(dentry);

