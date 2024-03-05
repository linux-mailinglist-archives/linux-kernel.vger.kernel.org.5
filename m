Return-Path: <linux-kernel+bounces-91466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C18711F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD801F23F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B963C1;
	Tue,  5 Mar 2024 00:47:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F73210;
	Tue,  5 Mar 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599640; cv=none; b=jZbT20p+zdZRWCJLsxrzhGbnfJWB7Tkpa7knX/ziT0BVN/4gydIkkrQ01DQ8azr9lMc86bp+qEZKRKAc9nUdwcaQTC5WUGm0ll1ptFoDGgtN8SCjoFE8QszneQrB/sAmYQ1p52z7wQpv+9e8pjCruyOsO15z5AW0Gu4m0vWgagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599640; c=relaxed/simple;
	bh=3DXoHz0jv23bY60mQlVYQKbh3ernvy1omqureJCjqks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMrBnBByDP8GR862qG7L049+1rv88GyDXEtfkLzfAUaVs6WmqiMNYuH4kxhe/AttYzhXk3ZHRkLI0p3nAfp4SpeOofCMOaQabJFKaRjTUPq/az97W59cyFfKIeG4fASaove2QLbt5TWylL/VrPnKb0hGfxYeGowHwQ68OIOQDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D05C433F1;
	Tue,  5 Mar 2024 00:47:19 +0000 (UTC)
Date: Mon, 4 Mar 2024 19:49:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Sachin Sant
 <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304194908.6d8d4fba@gandalf.local.home>
In-Reply-To: <fa113c5c-07c7-417b-8287-c9bf5f9b42a1@infradead.org>
References: <20240304192710.4c99677c@gandalf.local.home>
	<fa113c5c-07c7-417b-8287-c9bf5f9b42a1@infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 16:43:46 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8198bfc54b58..d68544aef65f 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7320,6 +7320,17 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >  	if ((ssize_t)cnt < 0)
> >  		return -EINVAL;
> >  
> > +	/*
> > +	 * TRACE_SEQ_SIZE is the total size of trace_seq buffer used
> > +	 * for output. As the print event outputs more than just
> > +	 * the string written, keep it smaller than the trace_seq
> > +	 * as it could drop the event if the extra data makes it bigger
> > +	 * than what the trace_seq can hold. Half he TRACE_SEQ_SIZE  
> 
> 	                                          the

I honestly think my 't' key isn't triggering as much. At least when before
hitting 'h', as I noticed I've been writing "he", "hey" and "here" a lot,
and spell check isn't (obviously) catching it ;-)

-- Steve


> 
> > +	 * is more than enough.
> > +	 */
> > +	if (cnt > TRACE_SEQ_SIZE / 2)
> > +		cnt = TRACE_SEQ_SIZE / 2;
> > +
> >  	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
> >   again:
> >  	size = cnt + meta_size;  
> 
> 


