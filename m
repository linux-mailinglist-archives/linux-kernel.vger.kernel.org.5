Return-Path: <linux-kernel+bounces-51333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 175298489E4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B491F243DF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56298EBE;
	Sun,  4 Feb 2024 00:54:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E24629;
	Sun,  4 Feb 2024 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707008073; cv=none; b=DsQnLwwJU0H05Ma886+aSRKVk3fLb6vkDext26O5aq9NUQlIxySY5mgd6AEu8Hs0duRpzgxgrghL/1JEfH7mg43WT6aoxmMZaO7zffYco0yLFEAh1hpEAPJgmsK51BqH26EWs22mUBLlglaqpjRmRvPAtoxv1GQ3EoZJLPc7gBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707008073; c=relaxed/simple;
	bh=8+TMVLIlwovQgAOFetceIDM9IyzbQckUF0NQPc0zzsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsPsvsz8R8QG+UL0+x8tIG5NIQBeHH8k8slIgkD5B15tOCV10WDYj0UO/vvGivl94XBxEvwpWxvX+yUlNs6pEqSelTDs/xWUT8GBKwPJotE28JjcCrn8nqN1jaKvBPR1QIqymNdNdncvPQYRPV0auf1CgxmduH3HrNv9Xs1zwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C3C433C7;
	Sun,  4 Feb 2024 00:54:32 +0000 (UTC)
Date: Sat, 3 Feb 2024 19:54:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, g@google.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v13 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240203195430.51171d85@rorschach.local.home>
In-Reply-To: <ZbkiLjUKmgg6oXR5@google.com>
References: <20240129142802.2145305-1-vdonnefort@google.com>
	<20240129142802.2145305-3-vdonnefort@google.com>
	<20240130235510.c92a31ee6998697dd49d2600@kernel.org>
	<ZbkiLjUKmgg6oXR5@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 16:22:06 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:
> > > +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > > +{
> > > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > > +
> > > +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> > > +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> > > +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> > > +
> > > +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> > > +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> > > +	WRITE_ONCE(meta->read, cpu_buffer->read);
> > > +}
> > > +
> > >  static void
> > >  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> > >  {
> > > @@ -5204,6 +5225,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> > >  	cpu_buffer->lost_events = 0;
> > >  	cpu_buffer->last_overrun = 0;
> > >  
> > > +	if (cpu_buffer->mapped)  
> > 
> > There are some cpu_buffer->mapped are accessed via WRITE_ONCE/READ_ONCE()
> > but others are not. What makes those different?  
> 
> The cpu_buffer->mapped is READ_ONCE for the section where it is not protected
> with a lock. That is (in this version) only ring_buffer_swap_cpu().
> 
> That said... 
> 
> a. This is not enough protection at this level, Ideally the _map should also
> call synchronize_rcu() to make sure the _swap does see the ->mapped > 0.
> 
> b. With refcount for the snapshot in trace/trace.c, it is not possible for those
> functions to race. trace_arm_snapshot() and tracing_buffers_mmap() are mutually
> exclusive and already stabilized with the trace mutex.
> 
> So how about I completely remove those WRITE_ONCE/READ_ONCE and just rely on the
> protection given in trace/trace.c instead of duplicating it in
> trace/ring_buffer.c?

I would add a comment and replace the READ_ONCE with WARN_ON_ONCE():

	/* It is up to the callers to not swap mapped buffers */
	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
		ret = -EBUSY;
		goto out;
	}


-- Steve

