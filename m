Return-Path: <linux-kernel+bounces-45472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257B84312E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCFC285FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55517AE64;
	Tue, 30 Jan 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gco8+ojf"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEA7D3EE;
	Tue, 30 Jan 2024 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657189; cv=none; b=uvKDeIVO0jEeGhE4qdDQI6IYGK28whJCax89R3x2V21h7C8w9aBSbNJeiEnO6p0cP+a6A6d8ZGgIiiQmqLB6UrxY9PpsBdSuTgHabCk4SbodhywOOP+//DGZH5GsE99ehxjoUrIEbrsZTmEWAqSMVt0koQae3iUIEDmfrQZyC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657189; c=relaxed/simple;
	bh=6IXl7hwaN6FZApfDgPZRgFs1muY8jzbmAVwsXx0pp1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcHJlTtlnRKy2HscmsFZSO24wbJ+kDzN+cpOB9t2Ch6G1x7ZiRVSKgjfIO2UCO487SmHBtDl6XDBABl/06QCK6rDMf3iHghC6To1P/tpCQVfuQrvbE9eJBBmf3KxFrpMQKLS451E1TW6iUMfr3OkcxcdA0+pTwkCOX00BFeayS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gco8+ojf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ovXdWdWNYgGA7B3xyrR7tVhfH+imWHZsvFTLCxc8o+0=; b=Gco8+ojfBQTJ8xOGroP0fKcDj1
	79CWr8dRBmREy7pvQee2gCLWrQyAG7hfb8iPHhHCpCE239QU70GxVCEyn1g+cmoYRcz48e97r0bNP
	w+AySpBO+Njgn8TD0CWgQr4UpTlcTQicwlHCEbXM8tj8xwCqxFzvwpRxKIO+FRycPdJ6G24ypXzWC
	zzgujH7d0Yi9mmZpUrOgh/UrosCzoM+ni5fic6K6luytzUpTvojHnJ7RqAIWzKQbo1N8wG3wyvr6b
	KlxdP7a2YjrGF66u6OV8Gk6IXLZlh8qjrIJejCXQ0HlpfQtV9qV69Aq7TlIXNHsLhj2UiW6P2J4PB
	nQjcs+sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUxUj-001iN4-1G;
	Tue, 30 Jan 2024 23:26:21 +0000
Date: Tue, 30 Jan 2024 23:26:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] tracefs: dentry lookup crapectomy
Message-ID: <20240130232621.GL2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-3-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130190355.11486-3-torvalds@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 11:03:52AM -0800, Linus Torvalds wrote:
> The dentry lookup for eventfs files was very broken, and had lots of
> signs of the old situation where the filesystem names were all created
> statically in the dentry tree, rather than being looked up dynamically
> based on the eventfs data structures.
> 
> You could see it in the naming - how it claimed to "create" dentries
> rather than just look up the dentries that were given it.
> 
> You could see it in various nonsensical and very incorrect operations,
> like using "simple_lookup()" on the dentries that were passed in, which
> only results in those dentries becoming negative dentries.  Which meant
> that any other lookup would possibly return ENOENT if it saw that
> negative dentry before the data rwas then later filled in.
> 
> You could see it in the immesnse amount of nonsensical code that didn't
> actually just do lookups.

> -static struct dentry *create_file(const char *name, umode_t mode,
> +static struct dentry *lookup_file(struct dentry *dentry,
> +				  umode_t mode,
>  				  struct eventfs_attr *attr,
> -				  struct dentry *parent, void *data,
> +				  void *data,
>  				  const struct file_operations *fop)
>  {
>  	struct tracefs_inode *ti;
> -	struct dentry *dentry;
>  	struct inode *inode;
>  
>  	if (!(mode & S_IFMT))
> @@ -307,12 +304,6 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  	if (WARN_ON_ONCE(!S_ISREG(mode)))
>  		return NULL;
>  
> -	WARN_ON_ONCE(!parent);
> -	dentry = eventfs_start_creating(name, parent);

Used to lock the inode of parent.

>  	if (unlikely(!inode))
>  		return eventfs_failed_creating(dentry);

.. and that still unlocks it.

> @@ -331,29 +322,25 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  	ti->flags = TRACEFS_EVENT_INODE;
>  	ti->private = NULL;			// Directories have 'ei', files not
>  
> -	d_instantiate(dentry, inode);
> +	d_add(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
>  	return eventfs_end_creating(dentry);

.. and so does this.

>  };

Where has that inode_lock() gone and how could that possibly work?

