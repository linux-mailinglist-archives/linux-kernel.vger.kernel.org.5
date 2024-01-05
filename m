Return-Path: <linux-kernel+bounces-17351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADA824C18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDD72857EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D361876;
	Fri,  5 Jan 2024 00:19:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67135A2D;
	Fri,  5 Jan 2024 00:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA4C433C8;
	Fri,  5 Jan 2024 00:19:13 +0000 (UTC)
Date: Thu, 4 Jan 2024 19:20:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20240104192019.4d550363@gandalf.local.home>
In-Reply-To: <20240105111016.5a3c36d0@canb.auug.org.au>
References: <20240105111016.5a3c36d0@canb.auug.org.au>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 11:10:16 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/tracefs/inode.c
> 
> between commits:
> 
>   7e8358edf503 ("eventfs: Fix file and directory uid and gid ownership")
>   ad579864637a ("tracefs: Check for dentry->d_inode exists in set_gid()")
> 
> from Linus' tree and commit:
> 
>   da549bdd15c2 ("dentry: switch the lists of children to hlist")
> 
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

> diff --cc fs/tracefs/inode.c
> index bc86ffdb103b,61ca5fcf10f9..000000000000
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@@ -207,28 -206,14 +206,25 @@@ static void set_gid(struct dentry *pare

Oh, and this is the code that I'm removing and will be in linux-next soon.

-- Steve


>   
>   	change_gid(this_parent, gid);
>   repeat:
> - 	next = this_parent->d_subdirs.next;
> + 	dentry = d_first_child(this_parent);
>   resume:
> - 	while (next != &this_parent->d_subdirs) {
> + 	hlist_for_each_entry_from(dentry, d_sib) {
>  +		struct tracefs_inode *ti;
> - 		struct list_head *tmp = next;
> - 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
> - 		next = tmp->next;
>  +
>  +		/* Note, getdents() can add a cursor dentry with no inode */
>  +		if (!dentry->d_inode)
>  +			continue;
>  +
>   		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>   
>   		change_gid(dentry, gid);
>   
>  +		/* If this is the events directory, update that too */
>  +		ti = get_tracefs(dentry->d_inode);
>  +		if (ti && (ti->flags & TRACEFS_EVENT_INODE))
>  +			eventfs_update_gid(dentry, gid);
>  +
> - 		if (!list_empty(&dentry->d_subdirs)) {
> + 		if (!hlist_empty(&dentry->d_children)) {
>   			spin_unlock(&this_parent->d_lock);
>   			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
>   			this_parent = dentry;

