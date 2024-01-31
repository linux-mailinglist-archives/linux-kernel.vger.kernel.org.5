Return-Path: <linux-kernel+bounces-45512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF88431AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7C71C238C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681241C2E;
	Wed, 31 Jan 2024 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EUKWUUCT"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E6184F;
	Wed, 31 Jan 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659660; cv=none; b=JuGg0XaorsM14hBAgXuC1n1oyvnPrXAiz1Ku3wbDII4FEjP81L3nJik6Mj+Ko1Os8Rezu/TBn5Yd+i5vq/7RHrJPOAQKlPPAfKFiSa69iuJnemsHY+0xiYnmyWoBG5s/fOd2hahbvNdnYYKSaWHH1qgshc/qu5f5e1qCTja6UcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659660; c=relaxed/simple;
	bh=Q9vGSke0CeUMqvDrrQjbDeVNJVHShXMK2uoebpMoBEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyBs0BTxGGShxQxXwIAfIS3WidOZmmcIf2ZFtH+Iv91wghiKQ20ZOdYpypdS/Za+AkzMZ/vnw6wyBwLYbFOT3DTeok0+oNapk852ecfwFnwTp066V0UKazFEUoXx+1sg34oTPVVOW6oYCA4StYjMiu0syewcDdM9VIUcj3ekAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EUKWUUCT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K5UQD9zZvaq52bbDLYpIpYyrlxYHg6jTjLYeRl++9Vc=; b=EUKWUUCTpVrwKqNrLZx8yQsal4
	aH30WA2M/jM9ACLa9/dW9mk8jrsvRMwsee0xg2pjLqdhbJnkIcCWyWxAZVazIuXzvcTvk2kbKmolg
	5//JWQp0j5K4nfqSbl3yBeKMVN6MilXhr9jq/LdT8BpLz/e5atE/J2CtPTOlYnF9PnDILU2TZ9GiC
	Rv4SBCQpTMgG+HdsiJ+yPmeN/gGg2UzQgci4TGJXFSVqxcnT88Mq9CQmdjtO10fdXQixjUNav3a4W
	NuRnBc9NCe4NX0lpCezck3dlskdipouVz66i1DqblB5UpFBykSB64wljT1g3SSWNKARyOzj6eZFSL
	7m/j6CIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rUy8a-001jn2-2h;
	Wed, 31 Jan 2024 00:07:32 +0000
Date: Wed, 31 Jan 2024 00:07:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] tracefs: dentry lookup crapectomy
Message-ID: <20240131000732.GM2087318@ZenIV>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-3-torvalds@linux-foundation.org>
 <20240130232621.GL2087318@ZenIV>
 <20240130185536.7ff14cb2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130185536.7ff14cb2@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 30, 2024 at 06:55:36PM -0500, Steven Rostedt wrote:

> Actually it's the tracefs_start_creating() locks the inode, the
> eventfs_start_creating() doesn't.

Right.

> > 
> > >  	if (unlikely(!inode))
> > >  		return eventfs_failed_creating(dentry);  
> > 
> > ... and that still unlocks it.

This is still bogus, though - both the stray dput() and
dropping a reference to internal mount.

struct dentry *eventfs_failed_creating(struct dentry *dentry)
{
        dput(dentry);
	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
	return NULL;
}

