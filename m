Return-Path: <linux-kernel+bounces-89576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27F86F235
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9124283724
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1285405F8;
	Sat,  2 Mar 2024 20:00:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7113FE42
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709409602; cv=none; b=cIF/zKrywiKL75pBmLNIKe5hWeyifJoJLdrws0v27BvvkZAZor9BAPboJrXDMAQwMt6QjfKqpSUwpwx1ZA6p4v1lhPznqcGQ/toX8YUifiHi3bFQeh/CTQ3/lKI+nA1sESFvPCvwcxbhTdkRypB8DZyUYnUELloePHyeFuatVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709409602; c=relaxed/simple;
	bh=U5Rq+R1WMj1Yv3GOTWlbyfwofTJDskewFguoi1iyjaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgXc3WzBQC16nVumNSpoI/c+6DG51Qlp47Ik+l9g7r+hVo10ojcjaaVT3PCXeGQkgmKTrbSY/U+Lsl7P6HvWX3zMwzIGB/5ZkpNOGcGln5hEi3xeT/a65Bs5E22iLk78EYkEgMXH4moq7rEIXxCBL4YypwUPyc3V6jm7sr7OI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C1DC433C7;
	Sat,  2 Mar 2024 20:00:00 +0000 (UTC)
Date: Sat, 2 Mar 2024 14:59:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
Message-ID: <20240302145958.05aabdd2@rorschach.local.home>
In-Reply-To: <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
References: <20240302111244.3a1674be@gandalf.local.home>
	<CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 09:24:37 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 2 Mar 2024 at 08:10, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - The change to allow trace_marker writes to be as big as the trace_seq can
> >   hold, and also the change that increases the size of the trace_seq to two
> >   pages, caused PowerPC kselftest trace_marker test to fail. The trace_marker
> >   kselftest writes up to subbuffer size which is determined by PAGE_SIZE.
> >   On PowerPC, the PAGE_SIZE can be 64K, which means the selftest will write
> >   a string that is around 64K in size. The output of the trace_marker is
> >   performed with a vsnprintf("%.*s", size, string), but this write would make
> >   the size greater than 32K, which is the max precision of "%.*s", and that
> >   causes a kernel warning. The fix is simply to keep the write of trace_marker
> >   less than or equal to max signed short.  
> 
> Please don't just add random limits that are based on other random limits.

It's not random limits, it's resource limits.

> 
> That printk warning is for "you did something obviously crazy".
> 
> That does NOT MEAN that you now should limit your strings to something
> JUST BORDERLINE CRAZY.

I don't have control over the strings. Anyone can do in user space:

	fd = open("/sys/kernel/tracing/trace_marker", O_WRONLY);
	r = write(fd, huge_string, 10000000);

And this code only gives you what is returned in 'r'. It doesn't error
out. It just limits what the max write size is. I just default it to
what the resources available are.

> 
> See?
> 
> There is not a way in hell that printing a 32kB string in tracing is
> valid. EVER.

Well, the limit is really PAGE_SIZE, which on most architectures is
4096, but on PowerPC, PAGE_SIZE is 64K. And the test in
tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc finds the
PAGE_SIZE and writes a string as long as it to see if it doesn't crash
the kernel. And all the resources can hold a 60K write. The problem
that this patch addresses is that the vsnprintf() used to move the data
into seq_file has a precision variable that checks for overflow, and it
has a max of 32K.

Yes, in most cases, 4K is the limit, which is why this doesn't trigger
on any architecture that has 4K page sizes.

> 
> So stop it. Stop making limits be some random implementation detail.
> Make limits *sane*.

The "implementation detail" is PAGE_SIZE. Similar to writing large
amounts of data to pipes and sockets. It may not write all data, but
just a smaller amount. The write doesn't error, it just says "this is
all I can write that you passed to me".

> 
> Make a *sane* limit for tracing. Not a "avoid being called crazy" limit.

What arbitrary limit do I do? It's just changes how the string will be
broken up, as "echo" or "cat" into trace_marker will continue writing the rest
of the string. It doesn't cause errors in the write. It simply breaks
the string up into smaller blocks.

> 
> Honestly, I suspect that a sane limit for tracing strings is likely on
> the order of tens or maybe hundreds of bytes. Not some kind of "fits
> in a short" that is just printk saying "I refuse to waste memory on
> the stack".

The error isn't printk, it's vsnprintf() that is writing to a seq_file
to user space. There's no stack or printk involved here.

	trace_seq_printf(s, ": %.*s", max, field->buf);

Where 's' is a trace_seq with a PAGE_SIZE buffer, that later gets passed
to seq_file.

> 
> Side note: for similar reasons the field-width is a 24-bit integer.
> And no, if you think that passing a 16MB field width is sane, you need
> to rethink your life. Again, that's a small implementation detail, not
> a "let's explore how stupid we can be".

I really don't understand what you mean by the above. This code is what
user space can write into the tracing ring buffer. If the ring buffer
sub-buffer is 64K, and user space does a 32K write into it, why prevent
that? The only limit here, is that the vsnprintf() has a max of signed
short for the precision it uses, which I used to prevent overflow.
That vsnprintf which writes into a memory buffer that will be sent out
via seq_file doesn't like huge strings greater than 32K, even though
what it is writing into is big enough to hold it.

-- Steve

