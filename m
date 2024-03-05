Return-Path: <linux-kernel+bounces-91497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2AA87125D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CBFB2283D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1C17C6A;
	Tue,  5 Mar 2024 01:33:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD018037;
	Tue,  5 Mar 2024 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602409; cv=none; b=PmdkJ4xlTTTQdgPhecaUwZ1xerpZmu1I9Iyb395eX/AChofS8hiuAMk4U3xmvtFN5DtBxOYJjxCV5DViDn2Zn8k9TBr5dKYyE69tyKt0k5HtrQK1eFVboFSEZREwupzWRB9GaABNOE2DYgfZAobvq3aLvfZvykHvNvctGpkwAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602409; c=relaxed/simple;
	bh=biGDkyvzPAl9aI4dKCIf9uUJJPcyOor9x961zx4tvfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYDMgSNtUImQYB5KkzLTPMA0cgNNB8XntQNXsy2eiK3O3vh2gqzBKEly94qdRdhAMSTd2885dHVeEiT7qL70GZM2vAtnWgKyXHYJeWxPNYAiGehQVEh2w+ZGwIDjgU9VGZ0wyeHFbG2oeQbch4mGAJ4LBqwV/4AXxWTY+UOC804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F21C433C7;
	Tue,  5 Mar 2024 01:33:28 +0000 (UTC)
Date: Mon, 4 Mar 2024 20:35:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304203516.45b7a551@gandalf.local.home>
In-Reply-To: <469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
References: <20240304192710.4c99677c@gandalf.local.home>
	<469d31a7-f358-4547-bb17-0979b3515924@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 20:15:57 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-03-04 19:27, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Since the size of trace_seq's buffer is the max an event can output, have
> > the trace_marker be half of the entire TRACE_SEQ_SIZE, which is 4K. That
> > will keep writes that has meta data written from being dropped (but
> > reported), because the total output of the print event is greater than
> > what the trace_seq can hold.  
> 
> Defining the trace_mark limit in terms of "TRACE_SEQ_SIZE / 2"
> seems backwards. It's basically using a define of the maximum
> buffer size for the pretty-printing output and defining the maximum
> input size of a system call to half of that.
> 
> I'd rather see, in a header file shared between tracing mark
> write implementation and output implementation:
> 
> #define TRACING_MARK_MAX_SIZE	4096
> 
> and then a static validation that this input fits within your
> pretty printing output in the output implementation file:
> 
> BUILD_BUG_ON(TRACING_MARK_MAX_SIZE + sizeof(meta data stuff...) > TRACE_SEQ_SIZE);

That's not the meta size I'm worried about. The sizeof(meta data) is the
raw event binary data, which is not related to the size of the event output.

 # cd /sys/kernel/tracing
 # echo hello > trace_marker
 # cat trace
[..]
           <...>-999     [001] .....  2296.140373: tracing_mark_write: hello
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   This is the meta data that is added to trace_seq

-- Steve



> 
> This way we clearly document that the tracing mark write
> input limit is 4kB, rather than something derived from
> the size of an output buffer.
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >   kernel/trace/trace.c | 16 +++++++++++-----
> >   1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8198bfc54b58..d68544aef65f 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7320,6 +7320,17 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >   	if ((ssize_t)cnt < 0)
> >   		return -EINVAL;
> >   
> > +	/*
> > +	 * TRACE_SEQ_SIZE is the total size of trace_seq buffer used
> > +	 * for output. As the print event outputs more than just
> > +	 * the string written, keep it smaller than the trace_seq
> > +	 * as it could drop the event if the extra data makes it bigger
> > +	 * than what the trace_seq can hold. Half he TRACE_SEQ_SIZE
> > +	 * is more than enough.
> > +	 */
> > +	if (cnt > TRACE_SEQ_SIZE / 2)
> > +		cnt = TRACE_SEQ_SIZE / 2;
> > +
> >   	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
> >    again:
> >   	size = cnt + meta_size;
> > @@ -7328,11 +7339,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
> >   	if (cnt < FAULTED_SIZE)
> >   		size += FAULTED_SIZE - cnt;
> >   
> > -	if (size > TRACE_SEQ_BUFFER_SIZE) {
> > -		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
> > -		goto again;
> > -	}
> > -
> >   	buffer = tr->array_buffer.buffer;
> >   	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
> >   					    tracing_gen_ctx());  
> 


