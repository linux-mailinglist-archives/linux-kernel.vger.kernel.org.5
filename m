Return-Path: <linux-kernel+bounces-150973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F68AA74F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA461F21B29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78779F6;
	Fri, 19 Apr 2024 03:43:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3276110;
	Fri, 19 Apr 2024 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498232; cv=none; b=QGwZaUUh05uE++RXDrANfzf0MDJgvnqCWgQCBWzt2xebqu4KF3sW5aXrQBNO0lGtC3g5XkIOnVv13Kb3twW5qBSJfOP3kKl/GqqtIOpGPtg3EulhD/MpUyHHV/+uuwiJeddmfS2lDqBF9AqsNdmJQYK/htEbN92E3szN2ML311s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498232; c=relaxed/simple;
	bh=kBSqFsxANvvOgLqNo4dWQl2Wu6CSlvQdnMTIb0lxZk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCKF70bhL30jIN7QtZvYU0aw08/z04QAxGjhoFSBycHaFvKQv/e7SZD2/tvljSgR0pUgp6SwIajtrbu4jTQ/zRt+jXByIiZqUhKsN15SHT4nTRntJquAGPL+vN2V0M5uM4HDnvZntvOg0UYRltiiHPdq0iSY1j6ehPBEfdQTNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F217FC072AA;
	Fri, 19 Apr 2024 03:43:49 +0000 (UTC)
Date: Thu, 18 Apr 2024 23:43:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240418234346.4b4cb4dc@rorschach.local.home>
In-Reply-To: <ZiDD-wdGIjOBcQ2U@kernel.org>
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-3-vdonnefort@google.com>
 <ZiDD-wdGIjOBcQ2U@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 09:55:55 +0300
Mike Rapoport <rppt@kernel.org> wrote:

Hi Mike,

Thanks for doing this review!

> > +/**
> > + * struct trace_buffer_meta - Ring-buffer Meta-page description
> > + * @meta_page_size:	Size of this meta-page.
> > + * @meta_struct_len:	Size of this structure.
> > + * @subbuf_size:	Size of each sub-buffer.
> > + * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
> > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > + * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
> > + * @reader.read:	Number of bytes read on the reader subbuf.
> > + * @flags:		Placeholder for now, 0 until new features are supported.
> > + * @entries:		Number of entries in the ring-buffer.
> > + * @overrun:		Number of entries lost in the ring-buffer.
> > + * @read:		Number of entries that have been read.
> > + * @Reserved1:		Reserved for future use.
> > + * @Reserved2:		Reserved for future use.
> > + */
> > +struct trace_buffer_meta {
> > +	__u32		meta_page_size;
> > +	__u32		meta_struct_len;
> > +
> > +	__u32		subbuf_size;
> > +	__u32		nr_subbufs;
> > +
> > +	struct {
> > +		__u64	lost_events;
> > +		__u32	id;
> > +		__u32	read;
> > +	} reader;
> > +
> > +	__u64	flags;
> > +
> > +	__u64	entries;
> > +	__u64	overrun;
> > +	__u64	read;
> > +
> > +	__u64	Reserved1;
> > +	__u64	Reserved2;  
> 
> Why do you need reserved fields? This structure always resides in the
> beginning of a page and the rest of the page is essentially "reserved".

So this code is also going to be used in arm's pkvm hypervisor code,
where it will be using these fields, but since we are looking at
keeping the same interface between the two, we don't want these used by
this interface.

We probably should add a comment about that.

> 
> > +};
> > +
> > +#endif /* _TRACE_MMAP_H_ */
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index cc9ebe593571..793ecc454039 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c  
> 
> ... 
> 
> > +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> > +				   unsigned long *subbuf_ids)
> > +{
> > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> > +	struct buffer_page *first_subbuf, *subbuf;
> > +	int id = 0;
> > +
> > +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> > +	cpu_buffer->reader_page->id = id++;
> > +
> > +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> > +	do {
> > +		if (WARN_ON(id >= nr_subbufs))
> > +			break;
> > +
> > +		subbuf_ids[id] = (unsigned long)subbuf->page;
> > +		subbuf->id = id;
> > +
> > +		rb_inc_page(&subbuf);
> > +		id++;
> > +	} while (subbuf != first_subbuf);
> > +
> > +	/* install subbuf ID to kern VA translation */
> > +	cpu_buffer->subbuf_ids = subbuf_ids;
> > +
> > +	/* __rb_map_vma() pads the meta-page to align it with the sub-buffers */
> > +	meta->meta_page_size = PAGE_SIZE << cpu_buffer->buffer->subbuf_order;  
> 
> Isn't this a single page?

One thing we are doing is to make sure that the subbuffers are aligned
by their size. If a subbuffer is 3 pages, it should be aligned on 3
page boundaries. This was something that Linus suggested.

> 
> > +	meta->meta_struct_len = sizeof(*meta);
> > +	meta->nr_subbufs = nr_subbufs;
> > +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> > +
> > +	rb_update_meta_page(cpu_buffer);
> > +}  
> 
> ...
> 
> > +#define subbuf_page(off, start) \
> > +	virt_to_page((void *)((start) + ((off) << PAGE_SHIFT)))
> > +
> > +#define foreach_subbuf_page(sub_order, start, page)		\  
> 
> Nit: usually iterators in kernel use for_each

Ah, good catch. Yeah, that should be changed. But then ...

> 
> > +	page = subbuf_page(0, (start));				\
> > +	for (int __off = 0; __off < (1 << (sub_order));		\
> > +	     __off++, page = subbuf_page(__off, (start)))  
> 
> The pages are allocated with alloc_pages_node(.. subbuf_order) are
> physically contiguous and struct pages for them are also contiguous, so
> inside a subbuf_order allocation you can just do page++.
> 

I'm wondering if we should just nuke the macro. It was there because of
the previous implementation did things twice. But now it's just done
once here:

+	while (s < nr_subbufs && p < nr_pages) {
+		struct page *page;
+
+		foreach_subbuf_page(subbuf_order, cpu_buffer->subbuf_ids[s], page) {
+			if (p >= nr_pages)
+				break;
+
+			pages[p++] = page;
+		}
+		s++;
+	}

Perhaps that should just be:

	while (s < nr_subbufs && p < nr_pages) {
		struct page *page;
		int off;

		page = subbuf_page(0, cpu_buffer->subbuf_ids[s]);
		for (off = 0; off < (1 << subbuf_order); off++, page++, p++) {
			if (p >= nr_pages)
				break;

			pages[p] = page;
		}
		s++;
	}

 ?

-- Steve

