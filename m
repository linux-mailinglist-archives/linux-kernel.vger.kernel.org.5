Return-Path: <linux-kernel+bounces-25853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077482D6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBE2B21686
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F717727;
	Mon, 15 Jan 2024 10:06:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1732C68B;
	Mon, 15 Jan 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B51F12F4;
	Mon, 15 Jan 2024 02:07:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.91.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7F43F6C4;
	Mon, 15 Jan 2024 02:06:30 -0800 (PST)
Date: Mon, 15 Jan 2024 10:06:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Erick Archer <erick.archer@gmx.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] eventfs: Use kcalloc() instead of kzalloc()
Message-ID: <ZaUDoG5qnkC8G3qx@FVFF77S0Q05N>
References: <20240114105340.5746-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114105340.5746-1-erick.archer@gmx.com>

On Sun, Jan 14, 2024 at 11:53:40AM +0100, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Could you put something in the commit message explaining *why* this change
should be made?

I assume that this is so that overflows during multiplication can be caught and
handled in some way, but the commit message doesn't say that, and nor does the
linked github page.

The patch itself looks fine.

Thanks,
Mark.

> ---
>  fs/tracefs/event_inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index fdff53d5a1f8..f8196289692c 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -93,7 +93,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	/* Preallocate the children mode array if necessary */
>  	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
>  		if (!ei->entry_attrs) {
> -			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
> +			ei->entry_attrs = kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
>  						  GFP_NOFS);
>  			if (!ei->entry_attrs) {
>  				ret = -ENOMEM;
> @@ -874,7 +874,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  	}
> 
>  	if (size) {
> -		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
> +		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
>  		if (!ei->d_children) {
>  			kfree_const(ei->name);
>  			kfree(ei);
> @@ -941,7 +941,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  		goto fail;
> 
>  	if (size) {
> -		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
> +		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
>  		if (!ei->d_children)
>  			goto fail;
>  	}
> --
> 2.25.1
> 
> 

