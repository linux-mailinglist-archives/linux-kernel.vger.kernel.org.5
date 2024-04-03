Return-Path: <linux-kernel+bounces-129919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA0897205
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACBB1F28D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5814900E;
	Wed,  3 Apr 2024 14:11:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869AD148FF6;
	Wed,  3 Apr 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153494; cv=none; b=eKvW2BJZTWzTDzlRyQ2/0BU/h5QVuzHr9qLpViHGv0vQF4TozkI8PZvU8BN34LCZALEQ/rkiD0IeU0Nr37FKg+9HuulZ4+6REY5sRPcX8eb3+GdaCeAJpeCoHe9XWiz0GZpECRR0far0yuddHmh4qpPFuH4cRIjTsjyMpaHOTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153494; c=relaxed/simple;
	bh=qX07ZsCB0EC6H2GFhhQmJ+c5vUY68DX1wal7OOZPv5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNpPBD3MzWwR3S9zk46IKqJP43chDA38OzQRgsWUiz2ZmsIp3eW8oxcAxWInvMyVUM6KJfrGZOIkt0ipznCfNPlpse0bwYUoW1Fqpv88xjfagSfrC5vT9z62POqLOVvoe0i+0ofTUv79N/cfQkmqRrZTUa16oEBSGitL647Ghtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4056DC433F1;
	Wed,  3 Apr 2024 14:11:33 +0000 (UTC)
Date: Wed, 3 Apr 2024 10:13:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-mm@kvack.org
Subject: Re: [PATCH v19 RESEND 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240403101352.08c83aa4@gandalf.local.home>
In-Reply-To: <20240329144055.0ae2dd4b@gandalf.local.home>
References: <20240326100830.1326610-1-vdonnefort@google.com>
	<20240326100830.1326610-4-vdonnefort@google.com>
	<20240329144055.0ae2dd4b@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 14:40:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
> > +{
> > +	return VM_FAULT_SIGBUS;
> > +}  
> 
> If this is all it does, I don't believe it's needed.
> 
> > +
> > +#ifdef CONFIG_TRACER_MAX_TRACE
> > +static int get_snapshot_map(struct trace_array *tr)
> > +{
> > +	int err = 0;
> > +
> > +	/*
> > +	 * Called with mmap_lock held. lockdep would be unhappy if we would now
> > +	 * take trace_types_lock. Instead use the specific
> > +	 * snapshot_trigger_lock.
> > +	 */
> > +	spin_lock(&tr->snapshot_trigger_lock);
> > +
> > +	if (tr->snapshot || tr->mapped == UINT_MAX)
> > +		err = -EBUSY;
> > +	else
> > +		tr->mapped++;
> > +
> > +	spin_unlock(&tr->snapshot_trigger_lock);
> > +
> > +	/* Wait for update_max_tr() to observe iter->tr->mapped */
> > +	if (tr->mapped == 1)
> > +		synchronize_rcu();
> > +
> > +	return err;
> > +
> > +}
> > +static void put_snapshot_map(struct trace_array *tr)
> > +{
> > +	spin_lock(&tr->snapshot_trigger_lock);
> > +	if (!WARN_ON(!tr->mapped))
> > +		tr->mapped--;
> > +	spin_unlock(&tr->snapshot_trigger_lock);
> > +}
> > +#else
> > +static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
> > +static inline void put_snapshot_map(struct trace_array *tr) { }
> > +#endif
> > +
> > +static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> > +{
> > +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> > +	struct trace_iterator *iter = &info->iter;
> > +
> > +	WARN_ON(ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file));
> > +	put_snapshot_map(iter->tr);
> > +}
> > +
> > +static void tracing_buffers_mmap_open(struct vm_area_struct *vma) { }  
> 
> Same for the open.
> 
> 
> > +
> > +static const struct vm_operations_struct tracing_buffers_vmops = {
> > +	.open		= tracing_buffers_mmap_open,
> > +	.close		= tracing_buffers_mmap_close,
> > +	.fault		= tracing_buffers_mmap_fault,
> > +};  
> 
> I replaced this with:
> 
> static const struct vm_operations_struct tracing_buffers_vmops = {
> 	.close		= tracing_buffers_mmap_close,
> };
> 
> And it appears to work just fine. The mm code handles the NULL cases for
> .open and .fault.
> 
> Is there any reason to do something different than the mm defaults?

Hi Vincent,

Do you plan on sending out a v20 series?

-- Steve

