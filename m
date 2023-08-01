Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08F76BB2D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHAR0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHAR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB5DE;
        Tue,  1 Aug 2023 10:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD16361590;
        Tue,  1 Aug 2023 17:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E919C433C7;
        Tue,  1 Aug 2023 17:26:05 +0000 (UTC)
Date:   Tue, 1 Aug 2023 13:26:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230801132603.0b18c0eb@gandalf.local.home>
In-Reply-To: <20230728164754.460767-2-vdonnefort@google.com>
References: <20230728164754.460767-1-vdonnefort@google.com>
        <20230728164754.460767-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 17:47:53 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> In preparation for allowing the user-space to map a ring-buffer, add
> a set of mapping functions:
> 
>   ring_buffer_{map,unmap}()
>   ring_buffer_map_fault()
> 
> And controls on the ring-buffer:
> 
>   ring_buffer_map_get_reader_page()  /* swap reader and head */
> 
> Mapping the ring-buffer also involves:
> 
>   A unique ID for each page of the ring-buffer, as currently the pages
>   are only identified through their in-kernel VA.
> 
>   A meta-page, where are stored statistics about the ring-buffer and
>   a page IDs list, ordered. A field gives what page is the reader
>   one and one to gives where the ring-buffer starts in the list of data
>   pages.
> 
> The linear mapping exposes the meta-page, and each page of the
> ring-buffer, ordered following their unique ID, assigned during the
> first mapping.
> 
> Once mapped, no page can get in or out of the ring-buffer: the buffer
> size will remain unmodified and the splice enabling functions will in
> reality simply memcpy the data instead of swapping pages.

So I tested these, and they look good. But I have some comments still.

> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 782e14f62201..980abfbd92ed 100644
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
> @@ -211,4 +213,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>  #define trace_rb_cpu_prepare	NULL
>  #endif
>  
> +int ring_buffer_map(struct trace_buffer *buffer, int cpu);
> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> +struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
> +				   unsigned long pgoff);
> +int ring_buffer_map_get_reader_page(struct trace_buffer *buffer, int cpu);
>  #endif /* _LINUX_RING_BUFFER_H */
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> new file mode 100644
> index 000000000000..653176cc50bc
> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_TRACE_MMAP_H_
> +#define _UAPI_TRACE_MMAP_H_
> +
> +#include <linux/types.h>
> +
> +struct ring_buffer_meta {

To be consistent with the naming of the internal structure, let's call this:

 struct trace_buffer_meta {


> +	unsigned long	entries;
> +	unsigned long	overrun;
> +	unsigned long	read;
> +
> +	unsigned long	pages_touched;
> +	unsigned long	pages_lost;
> +	unsigned long	pages_read;
> +
> +	__u32		meta_page_size;

We still want this meta structure size exported. That way if we ever extend
the interface, the applications will know if the kernel supports it or not.

	__u32		meta_struct_len; ?


> +	__u32		nr_data_pages;	/* Number of pages in the ring-buffer */
> +
> +	struct reader_page {
> +		__u32	id;		/* Reader page ID from 0 to nr_data_pages - 1 */
> +		__u32	read;		/* Number of bytes read on the reader page */
> +		unsigned long	lost_events; /* Events lost at the time of the reader swap */
> +	} reader_page;

I think we should define the structure outside the other structure, and
also rename it as reader_page is too generic. Perhaps call it
trace_buffer_read_page.


> +};
> +
> +#endif /* _UAPI_TRACE_MMAP_H_ */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index de061dd47313..8f367fd3dbdd 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -332,6 +332,7 @@ struct buffer_page {
>  	local_t		 entries;	/* entries on this page */
>  	unsigned long	 real_end;	/* real end of data */
>  	struct buffer_data_page *page;	/* Actual data page */
> +	u32		 id;		/* ID for external mapping */

I noticed that we have a whole in the current structure for 64 bit systems:

struct buffer_page {
	struct list_head list;		16 bytes depending on arch
	local_t		 write;		4 bytes
	unsigned	 read;		4 bytes
	local_t		 entries;	4 bytes

[ 4 byte whole on 64 bit archs ]

	unsigned long	 real_end;	8 bytes
	struct buffer_data_page *page;	8 bytes
};

If we put the id after entries, it will fill that whole.

struct buffer_page {
	struct list_head list;		/* list of buffer pages */
	local_t		 write;		/* index for next write */
	unsigned	 read;		/* index for next read */
	local_t		 entries;	/* entries on this page */
	u32		 id;		/* ID for external mapping */
	unsigned long	 real_end;	/* real end of data */
	struct buffer_data_page *page;	/* Actual data page */
};


>  };
>  
>  /*
> @@ -523,6 +524,12 @@ struct ring_buffer_per_cpu {
>  	rb_time_t			before_stamp;
>  	u64				event_stamp[MAX_NEST];
>  	u64				read_stamp;
> +
> +	int				mapped;
> +	struct mutex			mapping_lock;
> +	unsigned long			*page_ids;	/* ID to addr */
> +	struct ring_buffer_meta		*meta_page;
> +
>  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
>  	long				nr_pages_to_update;
>  	struct list_head		new_pages; /* new pages to add */
> @@ -1562,6 +1569,13 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
>  		/* Again, either we update tail_page or an interrupt does */
>  		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
>  	}
> +
> +	if (READ_ONCE(cpu_buffer->mapped)) {
> +		/* Ensure the meta_page is ready */
> +		smp_rmb();
> +		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
> +			   local_read(&cpu_buffer->pages_touched));
> +	}

I was thinking instead of doing this in the semi fast path, put this logic
into the rb_wakeup_waiters() code. That is, if a task is mapped, we call
the irq_work() to do this for us. It could even do more, like handle
blocked mapped waiters.

>  }
>  
>  static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
> @@ -1725,6 +1739,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
>  	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> +	mutex_init(&cpu_buffer->mapping_lock);
>  
>  	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
>  			    GFP_KERNEL, cpu_to_node(cpu));
> @@ -2521,6 +2536,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
>  		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
>  		local_inc(&cpu_buffer->pages_lost);
>  
> +		if (READ_ONCE(cpu_buffer->mapped)) {
> +			/* Ensure the meta_page is ready */
> +			smp_rmb();
> +			WRITE_ONCE(cpu_buffer->meta_page->overrun,
> +				   local_read(&cpu_buffer->overrun));
> +			WRITE_ONCE(cpu_buffer->meta_page->pages_lost,
> +				   local_read(&cpu_buffer->pages_lost));
> +		}
> +

Perhaps this too could be handled in the irq work?

>  		/*
>  		 * The entries will be zeroed out when we move the
>  		 * tail page.
> @@ -3183,6 +3207,14 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
>  static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	local_inc(&cpu_buffer->entries);
> +
> +	if (READ_ONCE(cpu_buffer->mapped)) {
> +		/* Ensure the meta_page is ready */
> +		smp_rmb();
> +		WRITE_ONCE(cpu_buffer->meta_page->entries,
> +			   local_read(&cpu_buffer->entries));
> +	}

As well as this.

In other words, since the irq_work will trigger when something is waiting
for it, it could handle all the updates.

> +
>  	rb_end_commit(cpu_buffer);
>  }
>  
> @@ -3486,7 +3518,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
>  		return;
>  
>  	/*
> -	 * If this interrupted another event, 
> +	 * If this interrupted another event,
>  	 */
>  	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
>  		goto out;
> @@ -4658,6 +4690,13 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  		cpu_buffer->last_overrun = overwrite;
>  	}
>  
> +	if (cpu_buffer->mapped) {
> +		WRITE_ONCE(cpu_buffer->meta_page->reader_page.read, 0);
> +		WRITE_ONCE(cpu_buffer->meta_page->reader_page.id, reader->id);
> +		WRITE_ONCE(cpu_buffer->meta_page->reader_page.lost_events, cpu_buffer->lost_events);
> +		WRITE_ONCE(cpu_buffer->meta_page->pages_read, local_read(&cpu_buffer->pages_read));
> +	}
> +
>  	goto again;
>  
>   out:
> @@ -4724,6 +4763,13 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
>  
>  	length = rb_event_length(event);
>  	cpu_buffer->reader_page->read += length;
> +
> +	if (cpu_buffer->mapped) {
> +		WRITE_ONCE(cpu_buffer->meta_page->reader_page.read,
> +			   cpu_buffer->reader_page->read);
> +		WRITE_ONCE(cpu_buffer->meta_page->read,
> +			   cpu_buffer->read);
> +	}
>  }
>  
>  static void rb_advance_iter(struct ring_buffer_iter *iter)
> @@ -5253,6 +5299,19 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>  	page->read = 0;
>  }
>  
> +static void rb_reset_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct ring_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	WRITE_ONCE(meta->entries, 0);
> +	WRITE_ONCE(meta->overrun, 0);
> +	WRITE_ONCE(meta->read, cpu_buffer->read);
> +	WRITE_ONCE(meta->pages_touched, 0);
> +	WRITE_ONCE(meta->pages_lost, 0);
> +	WRITE_ONCE(meta->pages_read, local_read(&cpu_buffer->pages_read));
> +	WRITE_ONCE(meta->reader_page.read, cpu_buffer->reader_page->read);
> +}
> +
>  static void
>  rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> @@ -5297,6 +5356,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
>  	cpu_buffer->lost_events = 0;
>  	cpu_buffer->last_overrun = 0;
>  
> +	if (cpu_buffer->mapped)
> +		rb_reset_meta_page(cpu_buffer);
> +
>  	rb_head_page_activate(cpu_buffer);
>  }
>  
> @@ -5511,6 +5573,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
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
> @@ -5753,7 +5820,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	 * Otherwise, we can simply swap the page with the one passed in.
>  	 */
>  	if (read || (len < (commit - read)) ||
> -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> +	    cpu_buffer->mapped) {
>  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
>  		unsigned int rpos = read;
>  		unsigned int pos = 0;
> @@ -5870,6 +5938,255 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_read_page);
>  
> +static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	int i;
> +
> +	for (i = 0; i < cpu_buffer->nr_pages + 1; i++)
> +		virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
> +
> +	kfree(cpu_buffer->page_ids);
> +	cpu_buffer->page_ids = NULL;
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
> +	virt_to_page(addr)->mapping = NULL;
> +	free_page(addr);
> +	cpu_buffer->meta_page = NULL;
> +}
> +
> +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> +				   unsigned long *page_ids)
> +{
> +	struct ring_buffer_meta *meta = cpu_buffer->meta_page;
> +	unsigned int nr_data_pages = cpu_buffer->nr_pages + 1;
> +	struct buffer_page *first_page, *bpage;
> +	int id = 0;
> +
> +	page_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> +	cpu_buffer->reader_page->id = id++;
> +
> +	first_page = bpage = rb_set_head_page(cpu_buffer);
> +	do {
> +		if (id >= nr_data_pages) {
> +			WARN_ON(1);
> +			break;
> +		}
> +
> +		page_ids[id] = (unsigned long)bpage->page;
> +		bpage->id = id;
> +
> +		rb_inc_page(&bpage);
> +		id++;
> +	} while (bpage != first_page);
> +
> +	/* install page ID to kern VA translation */
> +	cpu_buffer->page_ids = page_ids;
> +
> +	meta->meta_page_size = PAGE_SIZE;
> +	meta->nr_data_pages = nr_data_pages;
> +	meta->reader_page.id = cpu_buffer->reader_page->id;
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
> +	unsigned long flags, *page_ids;
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
> +		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
> +		goto unlock;
> +	}
> +
> +	/* prevent another thread from changing buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +	atomic_inc(&cpu_buffer->resize_disabled);
> +	mutex_unlock(&buffer->mutex);
> +
> +	err = rb_alloc_meta_page(cpu_buffer);
> +	if (err) {
> +		atomic_dec(&cpu_buffer->resize_disabled);
> +		goto unlock;
> +	}
> +
> +	/* page_ids include the reader page while nr_pages does not */
> +	page_ids = kzalloc(sizeof(*page_ids) * (cpu_buffer->nr_pages + 1),
> +			   GFP_KERNEL);
> +	if (!page_ids) {
> +		rb_free_meta_page(cpu_buffer);
> +		atomic_dec(&cpu_buffer->resize_disabled);
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	/*
> +	 * Lock all readers to block any page swap until the page IDs are
> +	 * assigned.
> +	 */
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
> +	rb_setup_ids_meta_page(cpu_buffer, page_ids);
> +	/*
> +	 * Ensure the writer will observe the meta-page before
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
> +	cmpxchg(&cpu_buffer->meta_page->pages_touched, 0,
> +		local_read(&cpu_buffer->pages_touched));
> +	cmpxchg(&cpu_buffer->meta_page->pages_lost, 0,
> +		local_read(&cpu_buffer->pages_lost));
> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +unlock:
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
> +		/* Wait the writer and readers to observe !mapped */
> +		synchronize_rcu();
> +
> +		rb_free_page_ids(cpu_buffer);
> +		rb_free_meta_page(cpu_buffer);
> +		atomic_dec(&cpu_buffer->resize_disabled);
> +	}
> +
> +unlock:
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +
> +	return err;
> +}
> +
> +/*
> + *   +--------------+
> + *   |   meta page  |  pgoff=0
> + *   +--------------+
> + *   |  data page1  |  page_ids=0
> + *   +--------------+
> + *   |  data page2  |  page_ids=1
> + *         ...
> + */
> +struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
> +				   unsigned long pgoff)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
> +
> +	if (!pgoff)
> +		return virt_to_page((void *)cpu_buffer->meta_page);
> +
> +	pgoff--;
> +	if (pgoff > cpu_buffer->nr_pages)
> +		return NULL;
> +
> +	return virt_to_page(cpu_buffer->page_ids[pgoff]);
> +}
> +
> +int ring_buffer_map_get_reader_page(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long reader_size, flags;

Please put variable declarations on separate lines.

	unsigned long reader_size;
	unsigned long flags;

> +
> +	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
> +	if (IS_ERR(cpu_buffer))
> +		return (int)PTR_ERR(cpu_buffer);
> +
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +consume:
> +	if (rb_per_cpu_empty(cpu_buffer))
> +		goto out;
> +	reader_size = rb_page_size(cpu_buffer->reader_page);
> +	if (cpu_buffer->reader_page->read < reader_size) {

Please add a comment to what is going on here. I'm assuming that this is to
finish reading the reader page?

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

Thanks,

-- Steve
