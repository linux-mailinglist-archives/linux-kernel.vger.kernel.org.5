Return-Path: <linux-kernel+bounces-60968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA778850BC0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED928334D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652005F564;
	Sun, 11 Feb 2024 22:18:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A385DF03;
	Sun, 11 Feb 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707689925; cv=none; b=OqsHtRYpwusIVVgIKqNsZFcIvKNN9XtCATSIPz9s8I42nVYTHzYMY6G2cuuhUrS0nYz/eTRSHePTANkVinan6+0LcCQ1DiHAe+j47C8qOu1QecepF/zrRvv+r7C9QMVW4DQbvqIuAggnuexYXg+azlbUYZyLxP/C+rNzl0YyL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707689925; c=relaxed/simple;
	bh=pn72yq37f60r7i4wrF/Ukl1TYB0FkigXHzooeCebWcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eySww3GgndqQJWvwnvjxzBnmzJAkB451Y4KMAvPX3BEH1ekgZJCmnvEQqvrClCaGbulZOJviNDu8SRb5inRFPnPQmyuZQJewJBcc4KBc/CJyn7GQ2NDJ/S1Go5RNdXTw/CKe62Jqcry5okzVAgs34jZfHUOSeEJlZOBScKGa+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D442C433F1;
	Sun, 11 Feb 2024 22:18:44 +0000 (UTC)
Date: Sun, 11 Feb 2024 17:18:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v16 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240211171837.6a4ea1a5@rorschach.local.home>
In-Reply-To: <20240209163448.944970-3-vdonnefort@google.com>
References: <20240209163448.944970-1-vdonnefort@google.com>
	<20240209163448.944970-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 16:34:44 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

I have some comment updates, but I also notice a need to change the
code slightly. Nothing major, but enough to perhaps have a v17.

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
> index 000000000000..182e05a3004a
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
> + * @nr_subbufs:		Number of subbfs in the ring-buffer.

   Number of subbufs?

And does that include the reader page? Should probably add that in the comment.

> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1

I'm guessing @nr_subbufs is not the reader page.

> + * @reader.read:	Number of bytes read on the reader subbuf.
> + * @flags:		Placeholder for now, no defined values.

Should explicitly state flags will be zero until new features are
supported. In other words, there is a defined value, that's zero ;-)


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
> +};
> +
> +#endif /* _TRACE_MMAP_H_ */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ca796675c0a1..4543fc51567d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -9,6 +9,7 @@
>  #include <linux/ring_buffer.h>
>  #include <linux/trace_clock.h>
>  #include <linux/sched/clock.h>
> +#include <linux/cacheflush.h>
>  #include <linux/trace_seq.h>
>  #include <linux/spinlock.h>
>  #include <linux/irq_work.h>
> @@ -338,6 +339,7 @@ struct buffer_page {
>  	local_t		 entries;	/* entries on this page */
>  	unsigned long	 real_end;	/* real end of data */
>  	unsigned	 order;		/* order of the page */
> +	u32		 id;		/* ID for external mapping */
>  	struct buffer_data_page *page;	/* Actual data page */
>  };
>  
> @@ -484,6 +486,12 @@ struct ring_buffer_per_cpu {
>  	u64				read_stamp;
>  	/* pages removed since last reset */
>  	unsigned long			pages_removed;
> +
> +	unsigned int			mapped;
> +	struct mutex			mapping_lock;
> +	unsigned long			*subbuf_ids;	/* ID to addr */

   /* ID to subbuf addr */

Just to be a little more clear.

> +	struct trace_buffer_meta	*meta_page;
> +
>  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
>  	long				nr_pages_to_update;
>  	struct list_head		new_pages; /* new pages to add */
> @@ -1548,6 +1556,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> +	mutex_init(&cpu_buffer->mapping_lock);
>  
>  	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>  			    GFP_KERNEL, cpu_to_node(cpu));
> @@ -1738,8 +1747,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
>  	return buffer->time_stamp_abs;
>  }
>  
> -static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
> -
>  static inline unsigned long rb_page_entries(struct buffer_page *bpage)
>  {
>  	return local_read(&bpage->entries) & RB_WRITE_MASK;
> @@ -5160,6 +5167,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>  	page->read = 0;
>  }
>  
> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	meta->reader.read = cpu_buffer->reader_page->read;
> +	meta->reader.id = cpu_buffer->reader_page->id;
> +	meta->reader.lost_events = cpu_buffer->lost_events;
> +
> +	meta->entries = local_read(&cpu_buffer->entries);
> +	meta->overrun = local_read(&cpu_buffer->overrun);
> +	meta->read = cpu_buffer->read;
> +
> +	/* Some archs do not have data cache coherency between kernel and user-space */
> +	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
> +}
> +
>  static void
>  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> @@ -5204,6 +5227,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  	cpu_buffer->lost_events = 0;
>  	cpu_buffer->last_overrun = 0;
>  
> +	if (READ_ONCE(cpu_buffer->mapped))

Isn't the buffer_mutex held when we modify mapped? I believe it's held
here. I don't think we need a READ_ONCE() here. Is there a reason for it?

Hmm, looking down, it looks like you take the buffer->mutex after
setting mapped, is that necessary? If we take the buffer->mutex we can
sync the reset with mapping.

> +		rb_update_meta_page(cpu_buffer);
> +
>  	rb_head_page_activate(cpu_buffer);
>  	cpu_buffer->pages_removed = 0;
>  }
> @@ -5418,6 +5444,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
>  	cpu_buffer_a = buffer_a->buffers[cpu];
>  	cpu_buffer_b = buffer_b->buffers[cpu];
>  
> +	/* It's up to the callers to not try to swap mapped buffers */
> +	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>  	/* At least make sure the two buffers are somewhat the same */
>  	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
>  		goto out;
> @@ -5682,7 +5714,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	 * Otherwise, we can simply swap the page with the one passed in.
>  	 */
>  	if (read || (len < (commit - read)) ||
> -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> +	    READ_ONCE(cpu_buffer->mapped)) {

Here the buffer_mutex isn't held, but still, what's the purpose of the READ_ONCE?

I wonder if we just grab the reader_lock when setting the mapped
variable if that would be better than using READ/WRITE_ONCE, which I'm
not sure is helpful.


>  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>  		unsigned int rpos = read;
>  		unsigned int pos = 0;
> @@ -5901,6 +5934,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  
>  		cpu_buffer = buffer->buffers[cpu];
>  
> +		if (READ_ONCE(cpu_buffer->mapped)) {
> +			err = -EBUSY;
> +			goto error;
> +		}
> +
>  		/* Update the number of pages to match the new size */
>  		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
>  		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> @@ -6002,6 +6040,304 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
> +	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER | __GFP_ZERO));

The above is the main reason I'm looking for a v17. If that
alloc_page() fails, what exactly is going to be returned here? 

#define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
#define __va(x)                     ((void *)((unsigned long)(x)+PAGE_OFFSET))

I don't think that will be the result you expect. We need to do the
alloc_page(), test the result of that, and then call page_to_virt() on a
page that is not NULL.

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

I'm thinking for extra safety we could add:

	if (!addr)
		return;

So this function could be called twice without issue.

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

		if (WARN_ON(id >= nr_subbufs))
			break;

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
> +
> +	rb_update_meta_page(cpu_buffer);
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

Is there a reason not to take the buffer->mutex before setting mapped?

> +
> +	if (cpu_buffer->mapped) {
> +		if (cpu_buffer->mapped == UINT_MAX)
> +			err = -EBUSY;
> +		else
> +			WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);

As mentioned before, it may be better to take the reader_lock when
setting mapped and that should add the protection we want with mapped
set and other readers.

> +		mutex_unlock(&cpu_buffer->mapping_lock);
> +		return err;
> +	}
> +
> +	/* prevent another thread from changing buffer/sub-buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +
> +	err = rb_alloc_meta_page(cpu_buffer);
> +	if (err)
> +		goto unlock;
> +
> +	/* subbuf_ids include the reader while nr_pages does not */
> +	subbuf_ids = kzalloc(sizeof(*subbuf_ids) * (cpu_buffer->nr_pages + 1),
> +			   GFP_KERNEL);

Instead use:

	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);

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
> +	cpu_buffer->mapped = 1;
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
> +	unsigned long flags;
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
> +		goto out;
> +	} else if (cpu_buffer->mapped > 1) {
> +		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped - 1);
> +		goto out;
> +	}
> +
> +	mutex_lock(&buffer->mutex);
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
> +	cpu_buffer->mapped = 0;
> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +
> +	rb_free_subbuf_ids(cpu_buffer);
> +	rb_free_meta_page(cpu_buffer);
> +	atomic_dec(&cpu_buffer->resize_disabled);
> +
> +	mutex_unlock(&buffer->mutex);
> +out:
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
> +	rb_update_meta_page(cpu_buffer);
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	rb_put_mapped_buffer(cpu_buffer);
> +

Hmm, there's no protection here. If this task gets preempted for a long
time, it is possible that the cpu_buffer->reader_page can become NULL,
causing a NULL kernel dereference.

-- Steve


> +	/* Some archs do not have data cache coherency between kernel and user-space */
> +	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
> +
> +	return 0;
> +}
> +
>  /*
>   * We only allocate new buffers, never free them if the CPU goes down.
>   * If we were to free the buffer, then the user would lose any trace that was in


