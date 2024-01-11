Return-Path: <linux-kernel+bounces-24128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AF82B7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E7828A189
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEECA59146;
	Thu, 11 Jan 2024 23:22:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147EFBEF;
	Thu, 11 Jan 2024 23:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260CCC433C7;
	Thu, 11 Jan 2024 23:22:17 +0000 (UTC)
Date: Thu, 11 Jan 2024 18:23:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240111181814.362c42cf@gandalf.local.home>
In-Reply-To: <c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 11:34:58 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> The LTTng kernel tracer has supported mmap'd buffers for nearly 15 years [1],
> and has a lot of similarities with this patch series.
> 
> LTTng has the notion of "subbuffer id" to allow atomically exchanging a
> "reader" extra subbuffer with the subbuffer to be read. It implements
> "get subbuffer" / "put subbuffer" ioctls to allow the consumer (reader)
> to move the currently read subbuffer position. [2]
> 
> It would not hurt to compare your approach to LTTng and highlight
> similarities/differences, and the rationale for the differences.
> 
> Especially when it comes to designing kernel ABIs, it's good to make sure
> that all bases are covered, because those choices will have lasting impacts.
> 
> Thanks,
> 
> Mathieu
> 
> [1] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_mmap.c
> [2] https://git.lttng.org/?p=lttng-modules.git;a=blob;f=src/lib/ringbuffer/ring_buffer_vfs.c
> 

Hi Mathieu,

Thanks for sharing!

As we discussed a little bit in the tracing meeting we do somethings
differently but very similar too ;-)

The similarities as that all the sub-buffers are mapped. You have a
reader-sub-buffer as well.

The main difference is that you use an ioctl() that returns where to find
the reader-sub-buffer, where our ioctl() is just "I'm done, get me a new
reader-sub-buffer". Ours will update the meta page.

Our meta page looks like this:

> +struct trace_buffer_meta {
> +	unsigned long	entries;
> +	unsigned long	overrun;
> +	unsigned long	read;

If start tracing: trace-cmd start -e sched_switch and do:

 ~ cat /sys/kernel/tracing/per_cpu/cpu0/stats 
entries: 14
overrun: 0
commit overrun: 0
bytes: 992
oldest event ts: 84844.825372
now ts: 84847.102075
dropped events: 0
read events: 0

You'll see similar to the above.

 entries = entries
 overrun = overrun
 read = read

The above "read" is total number of events read.

Pretty staight forward ;-)


> +
> +	unsigned long	subbufs_touched;
> +	unsigned long	subbufs_lost;
> +	unsigned long	subbufs_read;

Now I'm thinking we may not want this exported, as I'm not sure it's useful.

Vincent, talking with Mathieu, he was suggesting that we only export what
we really need, and I don't think we need the above. Especially since they
are not exposed in the stats file.


> +
> +	struct {
> +		unsigned long	lost_events;
> +		__u32		id;
> +		__u32		read;
> +	} reader;

The above is definitely needed, as all of it is used to read the
reader-page of the sub-buffer.

lost_events is the number of lost events that happened before this
sub-buffer was swapped out.

Hmm, Vincent, I just notice that you update the lost_events as:

> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> +	WRITE_ONCE(meta->read, cpu_buffer->read);
> +
> +	WRITE_ONCE(meta->subbufs_touched, local_read(&cpu_buffer->pages_touched));
> +	WRITE_ONCE(meta->subbufs_lost, local_read(&cpu_buffer->pages_lost));
> +	WRITE_ONCE(meta->subbufs_read, local_read(&cpu_buffer->pages_read));
> +
> +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> +}

The lost_events may need to be handled differently, as it doesn't always
get cleared. So it may be stale data.


> +
> +	__u32		subbuf_size;
> +	__u32		nr_subbufs;

This gets is the information needed to read the mapped ring buffer.

> +
> +	__u32		meta_page_size;
> +	__u32		meta_struct_len;

The ring buffer gets mapped after "meta_page_size" and this structure is
"meta_struct_len" which will change if we add new data to it.

> +};

-- Steve

