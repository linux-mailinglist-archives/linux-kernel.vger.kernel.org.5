Return-Path: <linux-kernel+bounces-45505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE584319C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F91C2186C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB0537EC;
	Tue, 30 Jan 2024 23:55:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360D7EEFD;
	Tue, 30 Jan 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658925; cv=none; b=krfKDeEqoSV5he+ELbdmh/y/9u5s/bmPbVdYTLk2AqYgEa7Vcn23kRly+Nfu5r5sc/WwYVGnc4fUcAaSG8MzANdHE90hvlrEI4mUGJ3umpLHL64iIl1ozOdQTV3HwZEXzb9EDvtQzkX/O7J/d09uHgTtI0/Fufku50y7C86HGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658925; c=relaxed/simple;
	bh=JvgASyfstcPaEIcYgdpWGbMI3/ZlvPNS2e/6AkoMlO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+ses4wrANhEL2s5SDLcJ+Os1QH35VkrkCDlMV5nRSnx/hvXfnbELJ4AH1NpPDGPR3+VYmf1yXuJZm/dmNxg54ch8skDq76Q9bwJ0FiCz1PAwaAr0uW0PlxzbXLzVfqA8bndBhwAHfvf77xO1WH/xkQhgAHHrlSDrti3wOaKtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B6C43390;
	Tue, 30 Jan 2024 23:55:24 +0000 (UTC)
Date: Tue, 30 Jan 2024 18:55:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] tracefs: dentry lookup crapectomy
Message-ID: <20240130185536.7ff14cb2@gandalf.local.home>
In-Reply-To: <20240130232621.GL2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-3-torvalds@linux-foundation.org>
	<20240130232621.GL2087318@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 23:26:21 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Jan 30, 2024 at 11:03:52AM -0800, Linus Torvalds wrote:
> > The dentry lookup for eventfs files was very broken, and had lots of
> > signs of the old situation where the filesystem names were all created
> > statically in the dentry tree, rather than being looked up dynamically
> > based on the eventfs data structures.
> > 
> > You could see it in the naming - how it claimed to "create" dentries
> > rather than just look up the dentries that were given it.
> > 
> > You could see it in various nonsensical and very incorrect operations,
> > like using "simple_lookup()" on the dentries that were passed in, which
> > only results in those dentries becoming negative dentries.  Which meant
> > that any other lookup would possibly return ENOENT if it saw that
> > negative dentry before the data rwas then later filled in.
> > 
> > You could see it in the immesnse amount of nonsensical code that didn't
> > actually just do lookups.  
> 
> > -static struct dentry *create_file(const char *name, umode_t mode,
> > +static struct dentry *lookup_file(struct dentry *dentry,
> > +				  umode_t mode,
> >  				  struct eventfs_attr *attr,
> > -				  struct dentry *parent, void *data,
> > +				  void *data,
> >  				  const struct file_operations *fop)
> >  {
> >  	struct tracefs_inode *ti;
> > -	struct dentry *dentry;
> >  	struct inode *inode;
> >  
> >  	if (!(mode & S_IFMT))
> > @@ -307,12 +304,6 @@ static struct dentry *create_file(const char *name, umode_t mode,
> >  	if (WARN_ON_ONCE(!S_ISREG(mode)))
> >  		return NULL;
> >  
> > -	WARN_ON_ONCE(!parent);
> > -	dentry = eventfs_start_creating(name, parent);  
> 
> Used to lock the inode of parent.

Actually it's the tracefs_start_creating() locks the inode, the
eventfs_start_creating() doesn't.

-- Steve


> 
> >  	if (unlikely(!inode))
> >  		return eventfs_failed_creating(dentry);  
> 
> ... and that still unlocks it.
> 
> > @@ -331,29 +322,25 @@ static struct dentry *create_file(const char *name, umode_t mode,
> >  	ti->flags = TRACEFS_EVENT_INODE;
> >  	ti->private = NULL;			// Directories have 'ei', files not
> >  
> > -	d_instantiate(dentry, inode);
> > +	d_add(dentry, inode);
> >  	fsnotify_create(dentry->d_parent->d_inode, dentry);
> >  	return eventfs_end_creating(dentry);  
> 
> ... and so does this.
> 
> >  };  
> 
> Where has that inode_lock() gone and how could that possibly work?


