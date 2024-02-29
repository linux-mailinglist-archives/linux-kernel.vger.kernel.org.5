Return-Path: <linux-kernel+bounces-86913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B886CCB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2632C1C21700
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BE13DBA4;
	Thu, 29 Feb 2024 15:19:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604312F362;
	Thu, 29 Feb 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219954; cv=none; b=NANCQa2OCtBA9qRs+j35c1XzmXMdsjy6tnkJgkZHQCFqroB+MDzw+FVzS0xvGeY/cp5rsa1zvsvuO1N83EE8dRbyVo1enN9pUrw2FPfO85DUo6n1Cxhn4nu24ByshSMyWi/pXC6jgm/rcl/dtj2yfwAoabr7hq92439Gr0VCKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219954; c=relaxed/simple;
	bh=AkQ/AaKsEPuD8c6bNddvXHBp1aND4HVn4Dv1rsPMEkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=balmccoC4WHyMnSdqlaXyIkZcrRINYj+Z+YBMaKzT7QRG8i3/nkFYdIWPGrbhrZZ1zlHOL9zwNSgBPo+VMNO3TCezEDpoRgPrR5PbGQwbdFHMhwZPSQVQEgJKeUsF12M0h5y3o+fpXJZP4DoMjGwMxT3p4+Jq1nW8tDlHA+SvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A192C433C7;
	Thu, 29 Feb 2024 15:19:13 +0000 (UTC)
Date: Thu, 29 Feb 2024 10:21:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linke <lilinke99@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
Message-ID: <20240229102119.7c475dee@gandalf.local.home>
In-Reply-To: <tencent_BE8C3169030CD9C2FC7548832C2994921609@qq.com>
References: <tencent_BE8C3169030CD9C2FC7548832C2994921609@qq.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 20:32:26 +0800
linke <lilinke99@qq.com> wrote:

> Hi Steven, sorry for the late reply.
> 
> > 
> > Now the reason for the above READ_ONCE() is because the variables *are*
> > going to be used again. We do *not* want the compiler to play any games
> > with that.
> >   
> 
> I don't think it is because the variables are going to be used again. 
> Compiler optimizations barely do bad things in single thread programs. It
> is because cpu_buffer->commit_page may change concurrently and should be
> accessed atomically.

So basically you are worried about read-tearing?

That wasn't mentioned in the change log.

> 
> 	/* Make sure commit page didn't change */
> 	curr_commit_page = READ_ONCE(cpu_buffer->commit_page);
> 	curr_commit_ts = READ_ONCE(curr_commit_page->page->time_stamp);
> 
> 	/* If the commit page changed, then there's more data */
> 	if (curr_commit_page != commit_page ||
> 	    curr_commit_ts != commit_ts)
> 		return 0;
> 
> This code read cpu_buffer->commit_page and time_stamp again to check
> whether commit page changed. It shows that cpu_buffer->commit_page and 
> time_stamp may be changed by other threads.
> 
>         commit_page = cpu_buffer->commit_page;
>         commit_ts = commit_page->page->time_stamp;
> 
> So the commit_page and time_stamp above is read while other threads may
> change it. I think it is a data race if it is not atomic. Thus it is 
> necessary to use READ_ONCE() here.

Funny part is, if the above timestamp read did a tear, then this would
definitely not match, and would return the correct value. That is, the
buffer is not empty because the only way for this to get corrupted is if
something is in the process of writing to it.

Now we could add a comment stating this.

So, I don't even think the reading of the commit_page is needed (it's long
size so it should not tear, and if it does, I consider that more a bug in
the compiler).

Please explain why READ_ONCE() is needed, and what exactly is it "fixing".
That is, what breaks if it's not there?

-- Steve


