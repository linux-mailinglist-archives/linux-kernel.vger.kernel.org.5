Return-Path: <linux-kernel+bounces-13076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308F81FF69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56EEB224E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31215111A4;
	Fri, 29 Dec 2023 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGuOKo6X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63D11C80;
	Fri, 29 Dec 2023 12:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816BAC433C8;
	Fri, 29 Dec 2023 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703852645;
	bh=NowaqBRPZuI7+22YWcpMhYBdMu0ujinc3AWspFAjLAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGuOKo6X/6hIDOInVeUfDNqlezrXEjC2Jln3SAW/wa589fDcy2TZDoiih1PsU7zA0
	 1GAVzKRtqdWzYhQNpGaRrv0uNwcKUPCjy7tI/BHST7ME0eE0JsO1TxpKAbT/sYwDmp
	 +9OWkgP75WBKnSt4J6k4RMUCUKIhDwbOhTJVw8wOwTQzGPwKmXKaAVExNcUw4tVwxj
	 bT3BZRC9zbKRucIZZWdymsv0RiXxSBfq/f7Vucf3A8KVhPFbrHXi1NcyYdTZQrG8MJ
	 nDQ8QqIXXrAd5FoFJhLXZpFvXLfu5WMJLNdhtn4WgSDQQ3+w/pfb1dhcCDC5x0lxX3
	 AIhRtD01JMCUw==
Date: Fri, 29 Dec 2023 21:24:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix wake ups when buffer_percent is set to
 100
Message-Id: <20231229212401.d474300dc6b940eca8da7def@kernel.org>
In-Reply-To: <20231228230521.7dc92d1f@rorschach.local.home>
References: <20231226125902.4a057f1d@gandalf.local.home>
	<20231227075708.008225fc3c04444aac193b39@kernel.org>
	<20231228230521.7dc92d1f@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 23:05:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 27 Dec 2023 07:57:08 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 26 Dec 2023 12:59:02 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > The tracefs file "buffer_percent" is to allow user space to set a
> > > water-mark on how much of the tracing ring buffer needs to be filled in
> > > order to wake up a blocked reader.
> > > 
> > >  0 - is to wait until any data is in the buffer
> > >  1 - is to wait for 1% of the sub buffers to be filled
> > >  50 - would be half of the sub buffers are filled with data
> > >  100 - is not to wake the waiter until the ring buffer is completely full
> > > 
> > > Unfortunately the test for being full was:
> > > 
> > > 	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
> > > 	return (dirty * 100) > (full * nr_pages);
> > > 
> > > Where "full" is the value for "buffer_percent".
> > > 
> > > There is two issues with the above when full == 100.
> > > 
> > > 1. dirty * 100 > 100 * nr_pages will never be true
> > >    That is, the above is basically saying that if the user sets
> > >    buffer_percent to 100, more pages need to be dirty than exist in the
> > >    ring buffer!
> > > 
> > > 2. The page that the writer is on is never considered dirty, as dirty
> > >    pages are only those that are full. When the writer goes to a new
> > >    sub-buffer, it clears the contents of that sub-buffer.
> > > 
> > > That is, even if the check was ">=" it would still not be equal as the
> > > most pages that can be considered "dirty" is nr_pages - 1.
> > > 
> > > To fix this, add one to dirty and use ">=" in the compare.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > >  kernel/trace/ring_buffer.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 83eab547f1d1..32c0dd2fd1c3 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -881,9 +881,14 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
> > >  	if (!nr_pages || !full)
> > >  		return true;
> > >  
> > > -	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
> > > +	/*
> > > +	 * Add one as dirty will never equal nr_pages, as the sub-buffer
> > > +	 * that the writer is on is not counted as dirty.
> > > +	 * This is needed if "buffer_percent" is set to 100.
> > > +	 */
> > > +	dirty = ring_buffer_nr_dirty_pages(buffer, cpu) + 1;  
> > 
> > Is this "+ 1" required? If we have 200 pages and 1 buffer is dirty,
> > it is 0.5% dirty. Consider @full = 1%.
> 
> Yes it is required, as the comment above it states. dirty will never
> equal nr_pages. Without it, buffer_percent == 100 will never wake up.
> 
> The +1 is to add the page the writer is on, which is never considered
> "dirty".

Ah, got it. I thought the page under writing is dirty too (similar to
the memory page) That's my misunderstanding.

> 
> > 
> > @dirty = 1 + 1 = 2 and @dirty * 100 == 200. but 
> > @full * @nr_pages = 1 * 200 = 200.
> > Thus it hits (200 >= 200 is true) even if dirty pages are 0.5%.
> 
> Do we care?
> 
> What's the difference if it wakes up on 2 dirty pages or 1? It would be
> very hard to measure the difference.
> 
> But if you say 100, which means "I want to wake up when full" it will
> never wake up. Because it will always be nr_pages - 1.

OK, because we count only the complete page as dirty. In that case,
the number of readable page should be dirty + 1.

> 
> We could also say the +1 is the reader page too, because that's not
> counted as well.
> 
> In other words, we can bike shed this to make 1% accurate (which
> honestly, I have no idea what the use case for that would be) or we can
> fix the bug that has 100% which just means, wake me up if the buffer is
> full, and when the writer is on the last page, it is considered full.

Got it.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

