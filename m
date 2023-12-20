Return-Path: <linux-kernel+bounces-6957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D64819FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F8FB25398
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2915364B5;
	Wed, 20 Dec 2023 13:28:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164C347B0;
	Wed, 20 Dec 2023 13:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2FFC433C7;
	Wed, 20 Dec 2023 13:28:32 +0000 (UTC)
Date: Wed, 20 Dec 2023 08:29:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/2] Introducing trace buffer mapping by user-space
Message-ID: <20231220082932.1b391355@gandalf.local.home>
In-Reply-To: <ZYLmvmzLOBfrrsSu@google.com>
References: <20231219184556.1552951-1-vdonnefort@google.com>
	<20231219153924.2ff9c132@gandalf.local.home>
	<ZYLmvmzLOBfrrsSu@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 13:06:06 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > @@ -771,10 +772,20 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> >  static void rb_wake_up_waiters(struct irq_work *work)
> >  {
> >  	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
> > -	struct ring_buffer_per_cpu *cpu_buffer =
> > -		container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	struct trace_buffer *buffer;
> > +	int cpu;
> >  
> > -	rb_update_meta_page(cpu_buffer);
> > +	if (rbwork->is_cpu_buffer) {
> > +		cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
> > +		rb_update_meta_page(cpu_buffer);
> > +	} else {
> > +		buffer = container_of(rbwork, struct trace_buffer, irq_work);
> > +		for_each_buffer_cpu(buffer, cpu) {
> > +			cpu_buffer = buffer->buffers[cpu];
> > +			rb_update_meta_page(cpu_buffer);
> > +		}
> > +	}  
> 
> Arg, somehow never reproduced the problem :-\. I suppose you need to cat
> trace/trace_pipe and mmap(trace/cpuX/trace_pipe) at the same time?

It triggered as soon as I ran "trace-cmd start -e sched_switch"

In other words, it broke the non mmap case. This function gets called for
both the buffer and cpu_buffer irq_work entries. You added the
container_of() to get access to cpu_buffer, when the rbwork could also be
for the main buffer too. The main buffer has no meta page, and it triggered
a NULL pointer dereference, as "cpu_buffer->mapped" returned true (because
it was on something of the buffer structure that wasn't zero), and then here:

	if (cpu_buffer->mapped) {
		WRITE_ONCE(cpu_buffer->meta_page->reader.read, 0);

It dereferenced cpu_buffer->meta_page->reader

which is only God knows what!

> 
> Updating the meta-page is only useful if the reader we are waking up is a
> user-space one, which would only happen with the cpu_buffer version of this
> function. We could limit the update of the meta_page only to this case?

I rather not add another irq_work entry. This workaround should be good
enough.

Thanks,

-- Steve

