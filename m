Return-Path: <linux-kernel+bounces-44777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4733842744
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92D31C26172
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E17E771;
	Tue, 30 Jan 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBZeAdoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C877CF3C;
	Tue, 30 Jan 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626515; cv=none; b=sFknstzfDyAC8d74hzGdxq9Y09/Pb1VRSX10kA33MhYpD67DXb/eq9JUAKiobgY2y3rR3SOkilfniQllQLV84YZzt7NU9EViR2C7kZ1YyjO8Llp8j5/2l2MQZNTZV0W4vFUjpmI1C9r+8W/owgsR4Loe8AX+xHDIQqJIvKsr4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626515; c=relaxed/simple;
	bh=RGJjrGZPbLUuFUjuCYyguun2Idc1ACjWA9E9iAYPwko=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HyU8TkfKD5C1Iryd+upM7oG6sbTkYcx4lRseKaKXnh01WEFhbOmmhoWQCXYfKfkOEiD/GXtG6qsfLLtM4uActLuBQJqZrcbSxa6Ph2D+zqgLarvu1DVbD6dofHs/gF8F4omIddWUPnChBmWco4VsJjLyCRX5mcStp8JRbe2eKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBZeAdoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF81C433F1;
	Tue, 30 Jan 2024 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626514;
	bh=RGJjrGZPbLUuFUjuCYyguun2Idc1ACjWA9E9iAYPwko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBZeAdoRPZZqG7mSl8LX5AwnaIOoyXN05Sl4OhvkBW00cbDUTrOVkFgTFiO2wqitt
	 K7uPztIuVBu3Y9PcY8nwXsM3tl62kwJYHdLDlddMlwvzEbxIzRZcJPzjHncWJMn05q
	 LBx/TNKfQ7fSpMFWOZJie2Tb3bLG0TzG8mcBVfSpTXp1mHTlktL3I6zoRGlsqh/D2u
	 ubDYBibMzYsX85sBj/cqPG1HbJIdiO8DuNcWEYFaygXKQ/m6aRhU0Q175FkGkEbKoC
	 EZTyvaAizpp2yKAIKMc/f2w7Nk6odmfBZcuGjzRoGMBwzXJLVpfdmANcuk6SZnh+nG
	 RGKqmI/zCi6NA==
Date: Tue, 30 Jan 2024 23:55:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v13 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-Id: <20240130235510.c92a31ee6998697dd49d2600@kernel.org>
In-Reply-To: <20240129142802.2145305-3-vdonnefort@google.com>
References: <20240129142802.2145305-1-vdonnefort@google.com>
	<20240129142802.2145305-3-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vincent,

Thanks for update the code.

On Mon, 29 Jan 2024 14:27:58 +0000
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
> index 000000000000..d4bb67430719
> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,43 @@
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
> + * @subbuf_size:	Size of each subbuf, including the header.
> + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> + * @reader.read:	Number of bytes read on the reader subbuf.
> + * @entries:		Number of entries in the ring-buffer.
> + * @overrun:		Number of entries lost in the ring-buffer.
> + * @read:		Number of entries that have been read.
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
> index 8179e0a8984e..081065e76d4a 100644
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
> @@ -484,6 +485,12 @@ struct ring_buffer_per_cpu {
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
> @@ -1548,6 +1555,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> +	mutex_init(&cpu_buffer->mapping_lock);
>  
>  	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>  			    GFP_KERNEL, cpu_to_node(cpu));
> @@ -5160,6 +5168,19 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>  	page->read = 0;
>  }
>  
> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> +
> +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> +	WRITE_ONCE(meta->read, cpu_buffer->read);
> +}
> +
>  static void
>  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> @@ -5204,6 +5225,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  	cpu_buffer->lost_events = 0;
>  	cpu_buffer->last_overrun = 0;
>  
> +	if (cpu_buffer->mapped)

There are some cpu_buffer->mapped are accessed via WRITE_ONCE/READ_ONCE()
but others are not. What makes those different?

> +		rb_update_meta_page(cpu_buffer);
> +
>  	rb_head_page_activate(cpu_buffer);
>  	cpu_buffer->pages_removed = 0;
>  }
> @@ -5418,6 +5442,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
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
> @@ -5682,7 +5711,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	 * Otherwise, we can simply swap the page with the one passed in.
>  	 */
>  	if (read || (len < (commit - read)) ||
> -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> +	    cpu_buffer->mapped) {
>  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>  		unsigned int rpos = read;
>  		unsigned int pos = 0;
> @@ -5901,6 +5931,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
> @@ -6002,6 +6037,295 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
> +
> +	WRITE_ONCE(cpu_buffer->mapped, 1);
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

How does this synchronize_rcu() work for ensuring to observe?
(All of those writers/readers are in non-preemptive critical section?)

Thank you,

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
> +	rb_update_meta_page(cpu_buffer);
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
> 2.43.0.429.g432eaa2c6b-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

