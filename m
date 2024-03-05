Return-Path: <linux-kernel+bounces-91561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207148713A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54BD1F21DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06828684;
	Tue,  5 Mar 2024 02:33:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1D26AD6;
	Tue,  5 Mar 2024 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606031; cv=none; b=Vpq5fY/mh9tpuve1e1pAcRV1ZA5A1/yOZkkOK6+JK1HJm3Yan0Gl//gxP2wv4K02GPB/8KxdLt8W3I9/EiUlq6RKGwh9Awjqg8ChdwEroA4glzsjxIHt+JovrcHe1BqKD5VWxdbfY/Yy2yYUAN9qIfKSY0NYCb5tkexLRlQAKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606031; c=relaxed/simple;
	bh=unSEVpgvFQOHSUq6Y/c148scLpjvR6nMaqI0LXc3blI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiAuyBodal++lRLsRAoN1bOcOzpq/cIoaLFdCZMpwH5Lxy51S/gae0H2fYX3tgusjIwJZgDMGu1TClzO0hefC1Oi2ttgObTAwkFrN8wZOSItuNLa44QTmYr6I8hUZlmvktThH9fILvOc7TYUaKcI/txds0EaXEmroiERkN9wJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC0C433F1;
	Tue,  5 Mar 2024 02:33:50 +0000 (UTC)
Date: Mon, 4 Mar 2024 21:35:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304213538.13fe1f3b@gandalf.local.home>
In-Reply-To: <cef0b07e-f90d-4759-ae54-0f091e87edab@efficios.com>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
	<20240304203516.45b7a551@gandalf.local.home>
	<20240304204119.7503ab0b@gandalf.local.home>
	<91f27ba1-15a4-402d-8301-e2b9d23f64b0@efficios.com>
	<20240304205943.081bea96@gandalf.local.home>
	<cef0b07e-f90d-4759-ae54-0f091e87edab@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 21:18:13 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-03-04 20:59, Steven Rostedt wrote:
> > On Mon, 4 Mar 2024 20:42:39 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> #define TRACE_OUTPUT_META_DATA_MAX_LEN		80
> >>
> >> and a runtime check in the code generating this header.
> >>
> >> This would avoid adding an unchecked upper limit.  
> > 
> > That would be a lot of complex code that is for debugging something that
> > has never happened in the past 16 years and Linus has already reprimanded
> > me on doing such things.  
> 
> Is it more complex than remembering the iterator position in
> print_trace_fmt() right before:
> 
>          if (tr->trace_flags & TRACE_ITER_CONTEXT_INFO) {
>                  if (iter->iter_flags & TRACE_FILE_LAT_FMT)
>                          trace_print_lat_context(iter);
>                  else
>                          trace_print_context(iter);
>          }

You forgot all of theses:

	if (iter->ent->type == TRACE_BPUTS &&
			trace_flags & TRACE_ITER_PRINTK &&
			trace_flags & TRACE_ITER_PRINTK_MSGONLY)
		return trace_print_bputs_msg_only(iter);

	if (iter->ent->type == TRACE_BPRINT &&
			trace_flags & TRACE_ITER_PRINTK &&
			trace_flags & TRACE_ITER_PRINTK_MSGONLY)
		return trace_print_bprintk_msg_only(iter);

	if (iter->ent->type == TRACE_PRINT &&
			trace_flags & TRACE_ITER_PRINTK &&
			trace_flags & TRACE_ITER_PRINTK_MSGONLY)
		return trace_print_printk_msg_only(iter);

	if (trace_flags & TRACE_ITER_BIN)
		return print_bin_fmt(iter);

	if (trace_flags & TRACE_ITER_HEX)
		return print_hex_fmt(iter);

	if (trace_flags & TRACE_ITER_RAW)
		return print_raw_fmt(iter);

	return print_trace_fmt(iter);

> 
> and then checking just after that the offset is not beyond 128
> bytes ? Perhaps there is even something internal to "iter"
> that already knows about this offset (?).
> 
> This would catch any context going beyond its planned upper
> limit early. Failing early and not just in rare corner cases
> is good.
> 
> And it's not for debugging, it's for validation of assumptions
> made about an upper bound limit defined for a compile-time
> check, so as the code evolves issues are caught early.

validating is debugging.

Seriously Mathieu. Why do we need that? The BUILD_BUG_ON() itself is
probably not even needed. Why do all this just to prevent an unlikely
situation of an event being dropped from printing?

It's not even lost (unless they are using trace_pipe, which very few people
use). If you see a "LINE TOO BIG" you can run:

  # trace-cmd extract
  # trace-cmd report

Which will pull out the raw data where the kernel trace_seq doesn't matter
and trace_cmd will handle it just fine (its trace_seq is dynamically
allocated and can increase in size when needed).

-- Steve

