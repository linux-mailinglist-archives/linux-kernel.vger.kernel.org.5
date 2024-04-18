Return-Path: <linux-kernel+bounces-149624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B128A9398
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5505BB21D37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2851A381CC;
	Thu, 18 Apr 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivEC5vxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B82E3F7;
	Thu, 18 Apr 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423426; cv=none; b=DkcfxEVaqmSKg6ctcmdDB09LLyoth0YBYuyodtw0PcxHB4OEh7ARY3fiXd7k7JICs85sQvNmMKvrj0iFW4uC7RogLE7zFIXL1JYr+kmq5n2dvEAdnpTPpRlkltB6x6+7rzbI1YqZT6jhpaaXahYAkSKmUu23Lm35x/Bk6E5CTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423426; c=relaxed/simple;
	bh=CSDFagkcXxGKH8tnkyXtN1wJJsUiCZ1G3ZjHZ+/sC+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap4TCRwNXq3pDWSb4yjFhfgpsKuoanNZ60wZzlvDb1tRamHhMhTv/7FBBwgXfnUW6Cp5DT+g809vmUxCqLxVngz9FGPORdTvvMvPMw2g3Emkwy84NoAQ+9WigDU4zVHFhUfI1GqAqBMXwzjTCni+yqQX7VidA6lQ5erGVR1BRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivEC5vxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011FAC113CC;
	Thu, 18 Apr 2024 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713423426;
	bh=CSDFagkcXxGKH8tnkyXtN1wJJsUiCZ1G3ZjHZ+/sC+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivEC5vxqWrqfqt2Hm6Hn6iCeYNnzu7EovJKwwBeq+v6JmKEyBu07DwpmPD4RNFYKf
	 5IVcVvYCv+gDC3NlAZ6b6JJhWN6sIAIPrnWASwRu5O9CUGrD67PEcXoi4+wkw1Lpcj
	 8aVn2Scis3niA+iuLVqchYQlqtOaBv0PCWgjCLLPtzpU5J8jGyfv+Ehvt2mS/gxu9p
	 2sIPETtaHYjWpUb/R88DlxAWD0aaklYU8WnZnSPW33R4FCflNEQCzyzFH4L7ihkPJ8
	 oAFO9etY44YihR6fjnVF/SbJlRy5luMG4oD1RAzLE8X2lUDWAm/wl5MKj/ZHbD3nL/
	 CGXCDNI9sT8UQ==
Date: Thu, 18 Apr 2024 09:55:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZiDD-wdGIjOBcQ2U@kernel.org>
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-3-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406173649.3210836-3-vdonnefort@google.com>

On Sat, Apr 06, 2024 at 06:36:46PM +0100, Vincent Donnefort wrote:
> In preparation for allowing the user-space to map a ring-buffer, add
> a set of mapping functions:
> 
>   ring_buffer_{map,unmap}()
> 
> And controls on the ring-buffer:
> 
>   ring_buffer_map_get_reader()  /* swap reader and head */
> 
> Mapping the ring-buffer also involves:
> 
>   A unique ID for each subbuf of the ring-buffer, currently they are
>   only identified through their in-kernel VA.
> 
>   A meta-page, where are stored ring-buffer statistics and a
>   description for the current reader
> 
> The linear mapping exposes the meta-page, and each subbuf of the
> ring-buffer, ordered following their unique ID, assigned during the
> first mapping.
> 
> Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
> size will remain unmodified and the splice enabling functions will in
> reality simply memcpy the data instead of swapping subbufs.
> 
> CC: <linux-mm@kvack.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index dc5ae4e96aee..96d2140b471e 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -6,6 +6,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/poll.h>
>  
> +#include <uapi/linux/trace_mmap.h>
> +
>  struct trace_buffer;
>  struct ring_buffer_iter;
>  
> @@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>  #define trace_rb_cpu_prepare	NULL
>  #endif
>  
> +int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> +		    struct vm_area_struct *vma);
> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
>  #endif /* _LINUX_RING_BUFFER_H */
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> new file mode 100644
> index 000000000000..ffcd8dfcaa4f
> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _TRACE_MMAP_H_
> +#define _TRACE_MMAP_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct trace_buffer_meta - Ring-buffer Meta-page description
> + * @meta_page_size:	Size of this meta-page.
> + * @meta_struct_len:	Size of this structure.
> + * @subbuf_size:	Size of each sub-buffer.
> + * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> + * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
> + * @reader.read:	Number of bytes read on the reader subbuf.
> + * @flags:		Placeholder for now, 0 until new features are supported.
> + * @entries:		Number of entries in the ring-buffer.
> + * @overrun:		Number of entries lost in the ring-buffer.
> + * @read:		Number of entries that have been read.
> + * @Reserved1:		Reserved for future use.
> + * @Reserved2:		Reserved for future use.
> + */
> +struct trace_buffer_meta {
> +	__u32		meta_page_size;
> +	__u32		meta_struct_len;
> +
> +	__u32		subbuf_size;
> +	__u32		nr_subbufs;
> +
> +	struct {
> +		__u64	lost_events;
> +		__u32	id;
> +		__u32	read;
> +	} reader;
> +
> +	__u64	flags;
> +
> +	__u64	entries;
> +	__u64	overrun;
> +	__u64	read;
> +
> +	__u64	Reserved1;
> +	__u64	Reserved2;

Why do you need reserved fields? This structure always resides in the
beginning of a page and the rest of the page is essentially "reserved".

> +};
> +
> +#endif /* _TRACE_MMAP_H_ */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index cc9ebe593571..793ecc454039 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

.. 

> +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> +				   unsigned long *subbuf_ids)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> +	struct buffer_page *first_subbuf, *subbuf;
> +	int id = 0;
> +
> +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> +	cpu_buffer->reader_page->id = id++;
> +
> +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> +	do {
> +		if (WARN_ON(id >= nr_subbufs))
> +			break;
> +
> +		subbuf_ids[id] = (unsigned long)subbuf->page;
> +		subbuf->id = id;
> +
> +		rb_inc_page(&subbuf);
> +		id++;
> +	} while (subbuf != first_subbuf);
> +
> +	/* install subbuf ID to kern VA translation */
> +	cpu_buffer->subbuf_ids = subbuf_ids;
> +
> +	/* __rb_map_vma() pads the meta-page to align it with the sub-buffers */
> +	meta->meta_page_size = PAGE_SIZE << cpu_buffer->buffer->subbuf_order;

Isn't this a single page?

> +	meta->meta_struct_len = sizeof(*meta);
> +	meta->nr_subbufs = nr_subbufs;
> +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> +
> +	rb_update_meta_page(cpu_buffer);
> +}

..

> +#define subbuf_page(off, start) \
> +	virt_to_page((void *)((start) + ((off) << PAGE_SHIFT)))
> +
> +#define foreach_subbuf_page(sub_order, start, page)		\

Nit: usually iterators in kernel use for_each

> +	page = subbuf_page(0, (start));				\
> +	for (int __off = 0; __off < (1 << (sub_order));		\
> +	     __off++, page = subbuf_page(__off, (start)))

The pages are allocated with alloc_pages_node(.. subbuf_order) are
physically contiguous and struct pages for them are also contiguous, so
inside a subbuf_order allocation you can just do page++.

-- 
Sincerely yours,
Mike.

