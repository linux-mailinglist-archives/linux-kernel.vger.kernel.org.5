Return-Path: <linux-kernel+bounces-21006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77835828860
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A18286FF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8239AE1;
	Tue,  9 Jan 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOOvwQwS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F886381DA;
	Tue,  9 Jan 2024 14:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293A7C433F1;
	Tue,  9 Jan 2024 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704811355;
	bh=mFe9QpeoxVMNdlFbyCCgsJ1TbEWoIOKtZ4I/Vi0fQyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jOOvwQwSU6dVuWjtFSFks9wZP9bzTL3n/Q4Zz6wMolK33V5Ed+0ImnPosdPk25tx4
	 RffWM/W2DV6lpxm6sfm0/ERDHKOMZ/e2tmUM839ugUy879gN6XmVhoIizmi1nl2yvX
	 7FMqbLy8xCsa9bX2RkT7hFTcTQEpo0lDaRJp0TwI8mYBum633PrHlLRrMqRN2cwNXP
	 SV9pHeIFAj5GwnYInzj8ZkMKLbQvIGOX/Ic9G0AeaaCYGW9JghqHjav98Ow27FqHsZ
	 vR4WhLvoR7r13R2G/bmsrgKjur7bfpYANW6DhQFISNyEoDHDVt0IvReyUY8pKy0Lf5
	 nU3qVa2SH366g==
Date: Tue, 9 Jan 2024 23:42:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-Id: <20240109234230.e99da87104d58fee59ad75c6@kernel.org>
In-Reply-To: <20240105094729.2363579-2-vdonnefort@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
	<20240105094729.2363579-2-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 09:47:28 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> In preparation for allowing the user-space to map a ring-buffer, add
> a set of mapping functions:
> 
>   ring_buffer_{map,unmap}()
>   ring_buffer_map_fault()
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
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index fa802db216f9..0841ba8bab14 100644
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
> @@ -221,4 +223,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>  #define trace_rb_cpu_prepare	NULL
>  #endif
>  
> +int ring_buffer_map(struct trace_buffer *buffer, int cpu);
> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> +struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
> +				   unsigned long pgoff);
> +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
>  #endif /* _LINUX_RING_BUFFER_H */
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> new file mode 100644
> index 000000000000..f950648b0ba9
> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_TRACE_MMAP_H_
> +#define _UAPI_TRACE_MMAP_H_
> +
> +#include <linux/types.h>
> +
> +struct trace_buffer_meta {

It is better to add a description about this data structure in
kerneldoc style, instead of adding a comment on each field,
because this structure will be exposed to user space.

> +	unsigned long	entries;
> +	unsigned long	overrun;
> +	unsigned long	read;
> +
> +	unsigned long	subbufs_touched;
> +	unsigned long	subbufs_lost;
> +	unsigned long	subbufs_read;
> +
> +	struct {
> +		unsigned long	lost_events;	/* Events lost at the time of the reader swap */
> +		__u32		id;		/* Reader subbuf ID from 0 to nr_subbufs - 1 */
> +		__u32		read;		/* Number of bytes read on the reader subbuf */
> +	} reader;
> +
> +	__u32		subbuf_size;		/* Size of each subbuf including the header */
> +	__u32		nr_subbufs;		/* Number of subbufs in the ring-buffer */
> +
> +	__u32		meta_page_size;		/* Size of the meta-page */
> +	__u32		meta_struct_len;	/* Len of this struct */
> +};
> +
> +#endif /* _UAPI_TRACE_MMAP_H_ */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 173d2595ce2d..63426e525781 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -338,6 +338,7 @@ struct buffer_page {
>  	local_t		 entries;	/* entries on this page */
>  	unsigned long	 real_end;	/* real end of data */
>  	unsigned	 order;		/* order of the page */
> +	u32		 id;		/* ID for external mapping */
>  	struct buffer_data_page *page;	/* Actual data page */
>  };
>  
> @@ -388,6 +389,7 @@ struct rb_irq_work {
>  	bool				waiters_pending;
>  	bool				full_waiters_pending;
>  	bool				wakeup_full;
> +	bool				is_cpu_buffer;

I think 'is_cpu_buffer' is a bit unclear (or generic),
what about 'meta_page_update'?

>  };
>  
>  /*
> @@ -484,6 +486,12 @@ struct ring_buffer_per_cpu {
>  	u64				read_stamp;
>  	/* pages removed since last reset */
>  	unsigned long			pages_removed;
> +
> +	int				mapped;
> +	struct mutex			mapping_lock;
> +	unsigned long			*subbuf_ids;	/* ID to addr */
> +	struct trace_buffer_meta	*meta_page;
> +
>  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
>  	long				nr_pages_to_update;
>  	struct list_head		new_pages; /* new pages to add */
> @@ -739,6 +747,33 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
>  	return (dirty * 100) > (full * nr_pages);
>  }
>  
> +static void rb_update_meta_page(struct rb_irq_work *rbwork)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +
> +	if (!rbwork->is_cpu_buffer)
> +		return;
> +	/*
> +	 * If the waiter is a cpu_buffer, this might be due to a
> +	 * userspace mapping. Let's update the meta-page.
> +	 */
> +	cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu,
> +				  irq_work);
> +
> +	if (READ_ONCE(cpu_buffer->mapped)) {
> +		/* Ensure the meta_page is ready */
> +		smp_rmb();
> +		WRITE_ONCE(cpu_buffer->meta_page->entries,
> +			   local_read(&cpu_buffer->entries));
> +		WRITE_ONCE(cpu_buffer->meta_page->overrun,
> +			   local_read(&cpu_buffer->overrun));
> +		WRITE_ONCE(cpu_buffer->meta_page->subbufs_touched,
> +			   local_read(&cpu_buffer->pages_touched));
> +		WRITE_ONCE(cpu_buffer->meta_page->subbufs_lost,
> +			   local_read(&cpu_buffer->pages_lost));
> +	}
> +}
> +
>  /*
>   * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
>   *
> @@ -749,6 +784,8 @@ static void rb_wake_up_waiters(struct irq_work *work)
>  {
>  	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
>  
> +	rb_update_meta_page(rbwork);
> +
>  	wake_up_all(&rbwork->waiters);
>  	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
>  		rbwork->wakeup_full = false;
> @@ -1541,6 +1578,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> +	mutex_init(&cpu_buffer->mapping_lock);
> +	cpu_buffer->irq_work.is_cpu_buffer = true;
>  
>  	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>  			    GFP_KERNEL, cpu_to_node(cpu));
> @@ -4544,6 +4583,14 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  		cpu_buffer->last_overrun = overwrite;
>  	}
>  
> +	if (cpu_buffer->mapped) {
> +		WRITE_ONCE(cpu_buffer->meta_page->reader.read, 0);
> +		WRITE_ONCE(cpu_buffer->meta_page->reader.id, reader->id);
> +		WRITE_ONCE(cpu_buffer->meta_page->reader.lost_events, cpu_buffer->lost_events);
> +		WRITE_ONCE(cpu_buffer->meta_page->subbufs_read,
> +			   local_read(&cpu_buffer->pages_read));
> +	}
> +
>  	goto again;
>  
>   out:
> @@ -4611,6 +4658,12 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
>  	length = rb_event_length(event);
>  	cpu_buffer->reader_page->read += length;
>  	cpu_buffer->read_bytes += length;
> +	if (cpu_buffer->mapped) {
> +		WRITE_ONCE(cpu_buffer->meta_page->reader.read,
> +			   cpu_buffer->reader_page->read);
> +		WRITE_ONCE(cpu_buffer->meta_page->read,
> +			   cpu_buffer->read);
> +	}
>  }
>  
>  static void rb_advance_iter(struct ring_buffer_iter *iter)
> @@ -5158,6 +5211,19 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>  	page->read = 0;
>  }
>  
> +static void rb_reset_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	WRITE_ONCE(meta->entries, 0);
> +	WRITE_ONCE(meta->overrun, 0);
> +	WRITE_ONCE(meta->read, cpu_buffer->read);
> +	WRITE_ONCE(meta->subbufs_touched, 0);
> +	WRITE_ONCE(meta->subbufs_lost, 0);
> +	WRITE_ONCE(meta->subbufs_read, local_read(&cpu_buffer->pages_read));
> +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> +}
> +
>  static void
>  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> @@ -5202,6 +5268,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  	cpu_buffer->lost_events = 0;
>  	cpu_buffer->last_overrun = 0;
>  
> +	if (cpu_buffer->mapped)
> +		rb_reset_meta_page(cpu_buffer);
> +
>  	rb_head_page_activate(cpu_buffer);
>  	cpu_buffer->pages_removed = 0;
>  }
> @@ -5416,6 +5485,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
>  	cpu_buffer_a = buffer_a->buffers[cpu];
>  	cpu_buffer_b = buffer_b->buffers[cpu];
>  
> +	if (READ_ONCE(cpu_buffer_a->mapped) || READ_ONCE(cpu_buffer_b->mapped)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>  	/* At least make sure the two buffers are somewhat the same */
>  	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
>  		goto out;
> @@ -5679,7 +5753,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	 * Otherwise, we can simply swap the page with the one passed in.
>  	 */
>  	if (read || (len < (commit - read)) ||
> -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> +	    cpu_buffer->mapped) {
>  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>  		unsigned int rpos = read;
>  		unsigned int pos = 0;
> @@ -5898,6 +5973,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  
>  		cpu_buffer = buffer->buffers[cpu];
>  
> +		if (cpu_buffer->mapped) {
> +			err = -EBUSY;
> +			goto error;
> +		}
> +
>  		/* Update the number of pages to match the new size */
>  		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
>  		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> @@ -5999,6 +6079,308 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
>  
> +#define subbuf_page(off, start) \
> +	virt_to_page((void *)(start + (off << PAGE_SHIFT)))
> +
> +#define foreach_subbuf_page(sub_order, start, page)		\
> +	page = subbuf_page(0, (start));				\
> +	for (int __off = 0; __off < (1 << (sub_order));		\
> +	     __off++, page = subbuf_page(__off, (start)))
> +
> +static inline void subbuf_map_prepare(unsigned long subbuf_start, int order)
> +{
> +	struct page *page;
> +
> +	/*
> +	 * When allocating order > 0 pages, only the first struct page has a
> +	 * refcount > 1. Increasing the refcount here ensures none of the struct
> +	 * page composing the sub-buffer is freeed when the mapping is closed.
> +	 */
> +	foreach_subbuf_page(order, subbuf_start, page)
> +		page_ref_inc(page);
> +}
> +
> +static inline void subbuf_unmap(unsigned long subbuf_start, int order)
> +{
> +	struct page *page;
> +
> +	foreach_subbuf_page(order, subbuf_start, page) {
> +		page_ref_dec(page);
> +		page->mapping = NULL;
> +	}
> +}
> +
> +static void rb_free_subbuf_ids(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	int sub_id;
> +
> +	for (sub_id = 0; sub_id < cpu_buffer->nr_pages + 1; sub_id++)
> +		subbuf_unmap(cpu_buffer->subbuf_ids[sub_id],
> +			     cpu_buffer->buffer->subbuf_order);
> +
> +	kfree(cpu_buffer->subbuf_ids);
> +	cpu_buffer->subbuf_ids = NULL;
> +}
> +
> +static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	if (cpu_buffer->meta_page)
> +		return 0;
> +
> +	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER));
> +	if (!cpu_buffer->meta_page)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
> +
> +	virt_to_page((void *)addr)->mapping = NULL;
> +	free_page(addr);
> +	cpu_buffer->meta_page = NULL;
> +}
> +
> +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> +				   unsigned long *subbuf_ids)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> +	struct buffer_page *first_subbuf, *subbuf;
> +	int id = 0;
> +
> +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> +	subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
> +	cpu_buffer->reader_page->id = id++;
> +
> +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> +	do {
> +		if (id >= nr_subbufs) {
> +			WARN_ON(1);
> +			break;
> +		}
> +
> +		subbuf_ids[id] = (unsigned long)subbuf->page;
> +		subbuf->id = id;
> +		subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
> +
> +		rb_inc_page(&subbuf);
> +		id++;
> +	} while (subbuf != first_subbuf);
> +
> +	/* install subbuf ID to kern VA translation */
> +	cpu_buffer->subbuf_ids = subbuf_ids;
> +
> +	meta->meta_page_size = PAGE_SIZE;
> +	meta->meta_struct_len = sizeof(*meta);
> +	meta->nr_subbufs = nr_subbufs;
> +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> +	meta->reader.id = cpu_buffer->reader_page->id;
> +	rb_reset_meta_page(cpu_buffer);
> +}
> +
> +static inline struct ring_buffer_per_cpu *
> +rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return ERR_PTR(-EINVAL);
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	mutex_lock(&cpu_buffer->mapping_lock);
> +
> +	if (!cpu_buffer->mapped) {
> +		mutex_unlock(&cpu_buffer->mapping_lock);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return cpu_buffer;
> +}
> +
> +static inline void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +}
> +
> +int ring_buffer_map(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long flags, *subbuf_ids;
> +	int err = 0;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return -EINVAL;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	mutex_lock(&cpu_buffer->mapping_lock);
> +
> +	if (cpu_buffer->mapped) {
> +		if (cpu_buffer->mapped == INT_MAX)
> +			err = -EBUSY;
> +		else
> +			WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
> +		mutex_unlock(&cpu_buffer->mapping_lock);
> +		return err;
> +	}
> +
> +	/* prevent another thread from changing buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +
> +	err = rb_alloc_meta_page(cpu_buffer);
> +	if (err)
> +		goto unlock;
> +
> +	/* subbuf_ids include the reader while nr_pages does not */
> +	subbuf_ids = kzalloc(sizeof(*subbuf_ids) * (cpu_buffer->nr_pages + 1),
> +			   GFP_KERNEL);
> +	if (!subbuf_ids) {
> +		rb_free_meta_page(cpu_buffer);
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	atomic_inc(&cpu_buffer->resize_disabled);
> +
> +	/*
> +	 * Lock all readers to block any subbuf swap until the subbuf IDs are
> +	 * assigned.
> +	 */
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
> +	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> +	/*
> +	 * Ensure rb_update_meta() will observe the meta-page before
                 ^rb_update_meta_page()

> +	 * cpu_buffer->mapped.
> +	 */
> +	smp_wmb();
> +	WRITE_ONCE(cpu_buffer->mapped, 1);
> +
> +	/* Init meta_page values unless the writer did it already */
> +	cmpxchg(&cpu_buffer->meta_page->entries, 0,
> +		local_read(&cpu_buffer->entries));
> +	cmpxchg(&cpu_buffer->meta_page->overrun, 0,
> +		local_read(&cpu_buffer->overrun));
> +	cmpxchg(&cpu_buffer->meta_page->subbufs_touched, 0,
> +		local_read(&cpu_buffer->pages_touched));
> +	cmpxchg(&cpu_buffer->meta_page->subbufs_lost, 0,
> +		local_read(&cpu_buffer->pages_lost));

Instead of using these cmpxchg, can we move this initialization before
smp_wmb()? Thus we can avoid conflict with rb_update_meta_page()

Thank you,

> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +unlock:
> +	mutex_unlock(&buffer->mutex);
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +
> +	return err;
> +}
> +
> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	int err = 0;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return -EINVAL;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	mutex_lock(&cpu_buffer->mapping_lock);
> +
> +	if (!cpu_buffer->mapped) {
> +		err = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped - 1);
> +	if (!cpu_buffer->mapped) {
> +		/* Wait for the writer and readers to observe !mapped */
> +		synchronize_rcu();
> +
> +		rb_free_subbuf_ids(cpu_buffer);
> +		rb_free_meta_page(cpu_buffer);
> +		atomic_dec(&cpu_buffer->resize_disabled);
> +	}
> +unlock:
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +
> +	return err;
> +}
> +
> +/*
> + *   +--------------+  pgoff == 0
> + *   |   meta page  |
> + *   +--------------+  pgoff == 1
> + *   | subbuffer 0  |
> + *   +--------------+  pgoff == 1 + (1 << subbuf_order)
> + *   | subbuffer 1  |
> + *         ...
> + */
> +struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
> +				   unsigned long pgoff)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
> +	unsigned long subbuf_id, subbuf_offset, addr;
> +	struct page *page;
> +
> +	if (!pgoff)
> +		return virt_to_page((void *)cpu_buffer->meta_page);
> +
> +	pgoff--;
> +
> +	subbuf_id = pgoff >> buffer->subbuf_order;
> +	if (subbuf_id > cpu_buffer->nr_pages)
> +		return NULL;
> +
> +	subbuf_offset = pgoff & ((1UL << buffer->subbuf_order) - 1);
> +	addr = cpu_buffer->subbuf_ids[subbuf_id] + (subbuf_offset * PAGE_SIZE);
> +	page = virt_to_page((void *)addr);
> +
> +	return page;
> +}
> +
> +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long reader_size;
> +	unsigned long flags;
> +
> +	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
> +	if (IS_ERR(cpu_buffer))
> +		return (int)PTR_ERR(cpu_buffer);
> +
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +consume:
> +	if (rb_per_cpu_empty(cpu_buffer))
> +		goto out;
> +
> +	reader_size = rb_page_size(cpu_buffer->reader_page);
> +
> +	/*
> +	 * There are data to be read on the current reader page, we can
> +	 * return to the caller. But before that, we assume the latter will read
> +	 * everything. Let's update the kernel reader accordingly.
> +	 */
> +	if (cpu_buffer->reader_page->read < reader_size) {
> +		while (cpu_buffer->reader_page->read < reader_size)
> +			rb_advance_reader(cpu_buffer);
> +		goto out;
> +	}
> +
> +	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
> +		goto out;
> +
> +	goto consume;
> +out:
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	rb_put_mapped_buffer(cpu_buffer);
> +
> +	return 0;
> +}
> +
>  /*
>   * We only allocate new buffers, never free them if the CPU goes down.
>   * If we were to free the buffer, then the user would lose any trace that was in
> -- 
> 2.43.0.472.g3155946c3a-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

