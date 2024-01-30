Return-Path: <linux-kernel+bounces-44763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF9784270A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47081F27FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34D7C0B9;
	Tue, 30 Jan 2024 14:39:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD27C08A;
	Tue, 30 Jan 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625572; cv=none; b=I0KwcYdQazS3s7I8A76XQJIl2z+1oY30f56NJEPBuLRufPvTX8DPaP7CIIJmcIXZFPQDZUg+ReRkiE5zijMM5LuSR8Mem+dtDv8Z76ISQJnAZue3TlnB4L4cRkxa928e9sONeJBkJMFwOvmaNnpMQqPXXDy7hfHnFlQzJzhu7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625572; c=relaxed/simple;
	bh=wqSBbOtqTFhUjK2zJYRQVHTlBD4gJby8xLhIvN0PEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZoZuhQ3lXQLkqRL+ZCCLIs90QdQ59UzWTOYVPyvTUb4oyFRuilDYTKy2HeoZfx1D0/2bq9h90P8wXwWGa4GO2SHTPYQLyib5fqPL6BTL2gkGpMzwfNP+HnTCgvzkzhICKHwTaeFKGH4dI7OB6FL6/EipnvKiYcio/DdWv2HBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BA7C433C7;
	Tue, 30 Jan 2024 14:39:31 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:39:42 -0500
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
Message-ID: <20240130093942.56206ff1@gandalf.local.home>
In-Reply-To: <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
	<CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 01:12:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 00:43, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'll go back to bed, but I think the fix is something trivial like this:  
> 
> Almost.
> 
> >   +     result = ERR_PTR(ENOENT);  
> 
> That needs a '-' in front of the ENOENT, otherwise you have a positive
> error number and things go wrong very quickly.
> 
> And that does indeed fix the lookup problem, but you end up with the
> same problem later when you do the eventfs_remove_dir(). Again the
> eventfs data structure changes, but we don't have a reliable dentry
> that we can invalidate.
> 
> The dentry cache is just very good at caching those old dentries, and
> the interface for eventfs_create_dir() and eventfs_remove_dir() is
> just not great.
> 
> If those did an actual path lookup (like eventfs_create_events_dir()
> does), we'd have the dentry, and it's trivial to get from dentry to
> eventfs_inode.
> 
> But going the other way is the broken thing because of how the
> dentries are just temporary caches.
> 
> I suspect the solution is to make eventfs_create_dir() do the same as
> the events directory case does, and actually pin the directory dentry
> and save it off.

I rather not have the create do that because that happens for every event
directory. On my machine that's:

  # find events -type d | wc -l
  2102

And that's regardless if tracefs is mounted or not. And that's how many are
also created with every instance creation. And doesn't pinning the dentry
also require it to be positive? That is, have a full inode allocated with
it?

I may try something that will still let me get rid of the ei->dentry.

> 
> Oh well. At least I understand what the problem is.


 Yep!


> Now I'm going to try to go back to sleep.

Hope you sleep better than I did. We just bought a new mattress, which felt
great in the store, but now after 4 or 5 hours sleeping in it, I wake up
with a sore back and have to sleep on the couch. And we bought the most
expensive "best" mattress in the store :-p

Oh, and NY State law has it that you can't return in once it is delivered.

-- Steve

