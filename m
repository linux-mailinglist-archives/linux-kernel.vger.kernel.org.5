Return-Path: <linux-kernel+bounces-24785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD5C82C27A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9421F21C08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5D6E2D0;
	Fri, 12 Jan 2024 15:05:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FC41C62;
	Fri, 12 Jan 2024 15:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145AAC433F1;
	Fri, 12 Jan 2024 15:05:36 +0000 (UTC)
Date: Fri, 12 Jan 2024 10:06:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240112100641.3675edad@gandalf.local.home>
In-Reply-To: <ZaECnv7EJHo6sqcT@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<c3dba53f-66de-43f5-9b82-38aa807da67a@efficios.com>
	<20240111181814.362c42cf@gandalf.local.home>
	<ZaECnv7EJHo6sqcT@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 09:13:02 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > +
> > > +	unsigned long	subbufs_touched;
> > > +	unsigned long	subbufs_lost;
> > > +	unsigned long	subbufs_read;  
> > 
> > Now I'm thinking we may not want this exported, as I'm not sure it's useful.  
> 
> touched and lost are not useful now, but it'll be for my support of the
> hypervisor tracing, that's why I added them already.
> 
> subbufs_read could probably go away though as even in that case I can track that
> in the reader.

Yeah, but I think we can leave it off for now.

This is something we could extend the structure with. In fact, it can be
different for different buffers!

That is, since they are pretty meaningless for the normal ring buffer, I
don't think we need to export it. But if it's useful for your hypervisor
buffer, it can export it. It would be a good test to know if the extension
works. Of course, that means if the normal ring buffer needs more info, it
must also include this as well, as it will already be part of the extended
structure.


> 
> > 
> > Vincent, talking with Mathieu, he was suggesting that we only export what
> > we really need, and I don't think we need the above. Especially since they
> > are not exposed in the stats file.
> > 
> >   
> > > +
> > > +	struct {
> > > +		unsigned long	lost_events;
> > > +		__u32		id;
> > > +		__u32		read;
> > > +	} reader;  
> > 
> > The above is definitely needed, as all of it is used to read the
> > reader-page of the sub-buffer.
> > 
> > lost_events is the number of lost events that happened before this
> > sub-buffer was swapped out.
> > 
> > Hmm, Vincent, I just notice that you update the lost_events as:
> >   
> > > +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > > +{
> > > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > > +
> > > +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> > > +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> > > +	WRITE_ONCE(meta->read, cpu_buffer->read);
> > > +
> > > +	WRITE_ONCE(meta->subbufs_touched, local_read(&cpu_buffer->pages_touched));
> > > +	WRITE_ONCE(meta->subbufs_lost, local_read(&cpu_buffer->pages_lost));
> > > +	WRITE_ONCE(meta->subbufs_read, local_read(&cpu_buffer->pages_read));
> > > +
> > > +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> > > +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> > > +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> > > +}  
> > 
> > The lost_events may need to be handled differently, as it doesn't always
> > get cleared. So it may be stale data.  
> 
> My idea was to check this value after the ioctl(). If > 0 then events were lost
> between the that ioctl() and the previous swap.
> 
> But now if with "[PATCH] ring-buffer: Have mmapped ring buffer keep track of
> missed events" we put this information in the page itself, we can get rid of
> this field.
> 

I'm thinking both may be good, as the number of dropped events are not
added if there's no room to put it at the end of the ring buffer. When
there's no room, it just sets a flag that there was missed events but
doesn't give how many events were missed.

If anything, it should be in both locations. In the sub-buffer header, to
be consistent with the read/splice version, and in the meta page were if
there's no room to add the count, it can be accessed in the meta page.

-- Steve

