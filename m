Return-Path: <linux-kernel+bounces-43462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB85841439
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D38286F99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5160F76056;
	Mon, 29 Jan 2024 20:25:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69557602D;
	Mon, 29 Jan 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559952; cv=none; b=JDm+uLuBHRTIVKj886F2TYkAjctwEdvkWpkTeKAsKedW1vcuu70of/56klmTO/K7ipMz+EZE2++4KwWno9aXFLdW5QoAtgDi1QIXZrlk0hPG0enMGN1ee/wvVEUYUV7ToQj/lV6YwUiIwpFWlHQZx1euWHo+orWYNzdBPLiLqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559952; c=relaxed/simple;
	bh=o9GlGvU+XorjS2WWxQTCkke0/L8lAaSfWR3HPgKbdVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6EMXz0lkX3ouvC8279/uZ9cH/AWS9xNFeIsbbtRQuvefKGYxMVGxyUiF4GRta1k1ok0URgQXeOVYHDnqahsJTGydZ7lybkgzS9dNcSRWbwUxcTqVUOA5kpZcnCr6jDpZj9jzOma/WZuAIMfTMfO2RTSVO4tUdq8uk3K/twkN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20004C433A6;
	Mon, 29 Jan 2024 20:25:51 +0000 (UTC)
Date: Mon, 29 Jan 2024 15:26:00 -0500
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
Message-ID: <20240129152600.7587d1aa@gandalf.local.home>
In-Reply-To: <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 11:51:52 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 29 Jan 2024 at 11:24, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So the patch was completely broken. Here's the one that should
> > actually compile (although still not actually *tested*).  
> 
> Note that this fixes the d_instantiate() ordering wrt initializing the inode.
> 
> But as I look up the call chain, I see many more fundamental mistakes.
> 
> Steven - the reason you think that the VFS doesn't have documentation
> is that we *do* have tons of documentation, but it's of the kind "Here
> is what you should do".
> 
> It is *not* of the kind that says "You messed up and did something
> else, and how do you recover from it?".

When I first worked on this, I did read all the VFS documentation, and it
was difficult to understand what I needed and what I didn't. It is focused
on a real file system and not a pseudo ones. Another mistake I made was
thinking that debugfs was doing things the "right" way as well. And having
a good idea of how debugfs worked, and thinking it was correct, just made
reading VFS documentation even more difficult as I couldn't relate what I
knew (about debugfs) with what was being explained. I thought it was
perfectly fine to use dentry as a handle for the file system. I did until
you told me it wasn't. That made a profound change in my understanding of
how things are supposed to work.

> 
> So the fundamental bug I now find is that eventfs_root_lookup() gets a
> target dentry, and for some unfathomable reason it then does
> 
>         ret = simple_lookup(dir, dentry, flags);
> 
> on it. Which is *completely* broken, because what "simple_lookup()"
> does is just say "oh, you didn't have a dentry of this kind before, so
> clearly a lookup must be a non-existent file". Remember: this is for
> 'tmpfs' kinds of filesystems where the dentry cache cotnains *ALL*
> files.

Sorry, I don't really understand what you mean by "ALL files"? You mean
that all files in the pseudo file system has a dentry to it (like debugfs,
and the rest of tracefs)?

> 
> For the tracefs kind of filesystem, it's TOTALLY BOGUS. What the
> "simple_lookup()" will do is just a plain
> 
>         d_add(dentry, NULL);
> 
> and nothing else. And guess what *that* does? It basically
> instantiates a negative dentry, telling all other lookups that the
> path does not exist.
> 
> So if you have two concurrent lookups, one will do that
> simple_lookup(), and the other will then - depending on timing -
> either see the negative dentry and return -ENOENT, or - if it comes in
> a bit later - see the new inode that then later gets added by the
> first lookup with d_instantiate().
> 
> See? That simple_lookup() is not just unnecessary, but it's also
> actively completely WRONG. Because it instantiates a NULL pointer,
> other processes that race with the lookup may now end up saying "that
> file doesn't exist", even though it should.
> 
> Basically, you can't use *any* of the "simple" filesystem helpers.
> Because they are all designed for that "the dentry tree is all there
> is" case.

Yeah, the above code did come about with me not fully understanding the
above. It's not that it wasn't documented, but I admit, when I read the VFS
documentation, I had a lot of trouble trying to make sense of things like
negative dentries and how they relate.

I now have a much better understanding of most of this, thanks to our
discussion here, and also knowing that using dentry as the main handle to a
file is *not* how to do it. When thinking it was, it made things much more
difficult to comprehend.

-- Steve

