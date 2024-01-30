Return-Path: <linux-kernel+bounces-45239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F658842D79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23637B2110D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0810271B36;
	Tue, 30 Jan 2024 20:03:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3071B29;
	Tue, 30 Jan 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645030; cv=none; b=YLxArgaIv1Afd7S7u3cIAzZ/OsuQ7dN5B5Ah1Skh/GKMw3ZLWndhTVUOiQSsDZENcRHzuIb3bQQEfCqcOEPMzP2GxfQi1yBO6we6nctpjBdPBo5JRLzNBJ8RIsVtcIge1/Cz+Z8Tth+V29rl+VTRdjZObalMcqNt/ecT7WaylAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645030; c=relaxed/simple;
	bh=raqJis5H5REnlNnsblpFO5LfaAPo42f2Cmdcg4YjBRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDqtvRVHJQ614gpkZYL399YTe7oUg9wIOKHxAVSdavg1wgP9vZY04NbNgw69rnxUoq9YNIuy5/jHf1eGJ6N/MbEUr/fxbEUiaZeeFuRHqDuoxQHzNKAIeX3BHjJ17PB89h2HevJCK8r4YvS6qU6fRlnWbSHTJ/OAitwHvtZPOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6EEC433C7;
	Tue, 30 Jan 2024 20:03:48 +0000 (UTC)
Date: Tue, 30 Jan 2024 15:04:00 -0500
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
Message-ID: <20240130150400.119a3909@gandalf.local.home>
In-Reply-To: <CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
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
	<20240130132319.022817e8@gandalf.local.home>
	<CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
	<20240130143734.31b9b3f1@gandalf.local.home>
	<CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:54:56 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 11:37, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Do you want me to put this in my urgent branch and mark them for stable,
> > and then send them for 6.8?  
> 
> Hmm. I think the only one that fixes a _reported_ bug is that [PTCH
> 2/6]. And it turns out that while 'ti->private' really is entirely
> uninitialized (and I still think it's the cause of the kernel test
> robot report that started this thread), the ti->flags field _is_
> initialized to zero in tracefs_alloc_inode().
> 
> So even in that [PATCH 2/6], these parts:
> 
>   -     ti->flags |= TRACEFS_EVENT_INODE;
>   +     ti->flags = TRACEFS_EVENT_INODE;
> 
> aren't strictly needed (but aren't wrong either).
> 
> The 'make sure to initialize ti->private before exposing the dentry'
> part *definitely* needs to be part of 6.8, though. That has an
> outstanding actually triggered bug report on it.
> 
> I do think that tracefs_alloc_inode() should also initialize
> ti->private to NULL, but while that would fix the oops that the test
> robot reported, it wouldn't fix the data-race on any ti->private
> accesses.
> 
> So that "ti->private = ei" needs to be done before the d_instantiate()
> (that later became a d_add()) regardless. But not having random fields
> left uninitialized for future subtle bugs would be a good idea too.


I'll add a patch to add __GFP_ZERO to the tracefs inode allocation, and
modify your patch 2 to just move the ti->private = ei;


> 
> Anyway.
> 
> If you do run the full tracefs tests on the whole series, and there
> are no other major problems, I'll happily take it all for 6.8. And
> yes, even mark it for stable. I think the other bugs are much harder
> to hit, but I do think they exist. And code deletion is always good.

Sounds good.

> 
> So give it the full test attention, and *if* it all still looks good
> and there are no new subtle issues that crop up, let's just put this
> saga behind us asap.

Yes, I've been wanting to get away from eventfs for a month now.

Again, I really do appreciate the time you put in to fixing this for me.
I'm going to be backporting this to older Chromebooks as we really need to
cut down on the memory overhead of instances.

-- Steve

