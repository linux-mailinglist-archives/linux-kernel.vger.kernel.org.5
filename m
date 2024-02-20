Return-Path: <linux-kernel+bounces-73260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D137185C028
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876051F2349A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197EC762C3;
	Tue, 20 Feb 2024 15:38:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557076031;
	Tue, 20 Feb 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443519; cv=none; b=HZnXLmdt580U3ZJTEO62hv1xmT5zGNQtHYjeJ5LoaZKpaR6QkSem1sGyMI1wK8zHiGd0nE3Vtr3HNcZaoHdmov3F7QKFeoGnOkS4GkjG/g1g7LP4pGCs2Rx/ESnzPXgbNPvvRARUD/4Ian1d1DaNLLt0klOgaPJtjVQzBzCDfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443519; c=relaxed/simple;
	bh=+GWUaKj8l/UOXz/ZncL8CGObQZYYkF42lOpmXt3dqRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2eVVX2V0bA+igMvwz2SpoqV8zi1sipwBuDKT35fgTWhLslLNl7PZSgY1j33ZYvsf70o/nPgZ8EwpPxCRGQEfaTYrM1QxOYvjjgLMORiOzIj0jqCPlZx8yA+VuAt3qCGiAaO1k/4stlMO+06oZFF02tyFYO+uiPjfE4wn9FDCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795D7C433F1;
	Tue, 20 Feb 2024 15:38:38 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:40:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240220104023.2182b5c3@gandalf.local.home>
In-Reply-To: <168765ff-98ea-42a1-82f7-56178bfcf7ec@efficios.com>
References: <20240219182032.2605d0a3@gandalf.local.home>
	<20240220091922.45848d9a@gandalf.local.home>
	<168765ff-98ea-42a1-82f7-56178bfcf7ec@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 09:50:13 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-02-20 09:19, Steven Rostedt wrote:
> > On Mon, 19 Feb 2024 18:20:32 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> >> Instead of using local_add_return() to reserve the ring buffer data,
> >> Mathieu Desnoyers suggested using local_cmpxchg(). This would simplify the
> >> reservation with the time keeping code.
> >>
> >> Although, it does not get rid of the double time stamps (before_stamp and
> >> write_stamp), using cmpxchg() does get rid of the more complex case when
> >> an interrupting event occurs between getting the timestamps and reserving
> >> the data, as when that happens, it just tries again instead of dealing
> >> with it.
> >>
> >> Before we had:
> >>
> >> 	w = local_read(&tail_page->write);
> >> 	/* get time stamps */
> >> 	write = local_add_return(length, &tail_page->write);
> >> 	if (write - length == w) {
> >> 		/* do simple case */
> >> 	} else {
> >> 		/* do complex case */
> >> 	}
> >>
> >> By switching the local_add_return() to a local_try_cmpxchg() it can now be:
> >>
> >> 	 w = local_read(&tail_page->write);
> >>   again:
> >> 	/* get time stamps */
> >> 	if (!local_try_cmpxchg(&tail_page->write, &w, w + length))
> >> 		goto again;
> >>
> >> 	 /* do simple case */  
> > 
> > Something about this logic is causing __rb_next_reserve() to sometimes
> > always return -EAGAIN and triggering the:
> > 
> >      RB_WARN_ON(cpu_buffer, ++nr_loops > 1000)
> > 
> > Which disables the ring buffer.
> > 
> > I'm not sure what it is, but until I do, I'm removing the patch from my
> > queue.  
> 
> Try resetting the info->add_timestamp flags to add_ts_default on goto again
> within __rb_reserve_next().
>

I was looking at that too, but I don't know how it will make a difference.

Note, the test that fails is in my test suite, and takes about a half hour
to get there. Running that suite takes up resources (it's my main test
suite for all changes). I'm currently testing other patches so I either
need to figure it out through inspection, or this will need to wait a while.

-- Steve

