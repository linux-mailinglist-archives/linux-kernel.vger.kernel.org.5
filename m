Return-Path: <linux-kernel+bounces-12940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C381FCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 05:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D16028455C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6241FAF;
	Fri, 29 Dec 2023 04:05:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087B23A4;
	Fri, 29 Dec 2023 04:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5FFC433C8;
	Fri, 29 Dec 2023 04:05:23 +0000 (UTC)
Date: Thu, 28 Dec 2023 23:05:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix wake ups when buffer_percent is set to
 100
Message-ID: <20231228230521.7dc92d1f@rorschach.local.home>
In-Reply-To: <20231227075708.008225fc3c04444aac193b39@kernel.org>
References: <20231226125902.4a057f1d@gandalf.local.home>
	<20231227075708.008225fc3c04444aac193b39@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 07:57:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 26 Dec 2023 12:59:02 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The tracefs file "buffer_percent" is to allow user space to set a
> > water-mark on how much of the tracing ring buffer needs to be filled in
> > order to wake up a blocked reader.
> > 
> >  0 - is to wait until any data is in the buffer
> >  1 - is to wait for 1% of the sub buffers to be filled
> >  50 - would be half of the sub buffers are filled with data
> >  100 - is not to wake the waiter until the ring buffer is completely full
> > 
> > Unfortunately the test for being full was:
> > 
> > 	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
> > 	return (dirty * 100) > (full * nr_pages);
> > 
> > Where "full" is the value for "buffer_percent".
> > 
> > There is two issues with the above when full == 100.
> > 
> > 1. dirty * 100 > 100 * nr_pages will never be true
> >    That is, the above is basically saying that if the user sets
> >    buffer_percent to 100, more pages need to be dirty than exist in the
> >    ring buffer!
> > 
> > 2. The page that the writer is on is never considered dirty, as dirty
> >    pages are only those that are full. When the writer goes to a new
> >    sub-buffer, it clears the contents of that sub-buffer.
> > 
> > That is, even if the check was ">=" it would still not be equal as the
> > most pages that can be considered "dirty" is nr_pages - 1.
> > 
> > To fix this, add one to dirty and use ">=" in the compare.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/ring_buffer.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 83eab547f1d1..32c0dd2fd1c3 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -881,9 +881,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
> >  	if (!nr_pages || !full)
> >  		return true;
> >  
> > -	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
> > +	/*
> > +	 * Add one as dirty will never equal nr_pages, as the sub-buffer
> > +	 * that the writer is on is not counted as dirty.
> > +	 * This is needed if "buffer_percent" is set to 100.
> > +	 */
> > +	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;  
> 
> Is this "+ 1" required? If we have 200 pages and 1 buffer is dirty,
> it is 0.5% dirty. Consider @full = 1%.

Yes it is required, as the comment above it states. dirty will never
equal nr_pages. Without it, buffer_percent == 100 will never wake up.

The +1 is to add the page the writer is on, which is never considered
"dirty".

> 
> @dirty = 1 + 1 = 2 and @dirty * 100 == 200. but 
> @full * @nr_pages = 1 * 200 = 200.
> Thus it hits (200 >= 200 is true) even if dirty pages are 0.5%.

Do we care?

What's the difference if it wakes up on 2 dirty pages or 1? It would be
very hard to measure the difference.

But if you say 100, which means "I want to wake up when full" it will
never wake up. Because it will always be nr_pages - 1.

We could also say the +1 is the reader page too, because that's not
counted as well.

In other words, we can bike shed this to make 1% accurate (which
honestly, I have no idea what the use case for that would be) or we can
fix the bug that has 100% which just means, wake me up if the buffer is
full, and when the writer is on the last page, it is considered full.

-- Steve

