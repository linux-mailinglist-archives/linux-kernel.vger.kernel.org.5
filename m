Return-Path: <linux-kernel+bounces-23844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA782B2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BD01F23C19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71252F95;
	Thu, 11 Jan 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2MEm62t"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E484524CE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e46bceed8so36387275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704989844; x=1705594644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDSYk7XYW6OJAyFvY7TTHo+xr/O1Sc5t/M2lwwtKZ4I=;
        b=W2MEm62tY4oCFHtvsWJG2vhUIpagMYTO6SiB7O8eUyS9t079Mb5J1ilhTYQIKzWm8o
         3FLNNkLxkLr6iNlLk5dnARceN9ngz+xISe64GAUCcCWtMhz8ZFKT+kZhs1wbEzxchqGZ
         MfxNdqWckoRsHngZGA4bmU2uXYb9XZ6Ud9wMMo64hT0CjCDYXoUi7Yr0GpGKpPRfl+8g
         Au+wgSwpRD0I+pqlNyaE/j3mm45PHVM8unB4uFHibxrf/DO1SNgI2SPlt7MiD/iMTtfM
         Z61Pl6WUwYTElUv8rE28VujfzMAmEHnAnYym/iPwsQlkn89cFKIO3nhg2JtK6qzUI8cO
         7YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989844; x=1705594644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDSYk7XYW6OJAyFvY7TTHo+xr/O1Sc5t/M2lwwtKZ4I=;
        b=Y9Z8RtsZjZVRfMH6P7gunjOHM3sqZmf9bd465gaDpd0a2E/TDq+qR/7PfHqyzF7xit
         shAUA0qzCYLkNIay9eABH0rEoNdVydOVNQ33P02+4NFJg/ZAkSCTkdW/FdJS9GNxL1um
         xNqXQqP+/qITrHAnRjTO5RrjaJww1AeABqwJ1+zZlFoxjlq1qzS3tDocjxx0bVF9PdvL
         GTeIrk9P701M1rBEP+lbWXeko70q/5iNLTm6kQFHqinL3uoW8WZB+dzAF+xUFACpXVpm
         XP+s4XvqDT+JL1razAGwPspzVAsUz+UIGmTGbJtGAdrZhPF2pF6XwRNXOM316X4BoqnS
         Nipw==
X-Gm-Message-State: AOJu0Yx23e0IBM/0lgdOfHLUKNB10UaG/z/QGGq5b+aC5PMcUtO7chRo
	N0qz17si5J23znnpaU0GNLKlDDZc9q1jrzhSG2Lp8ks=
X-Google-Smtp-Source: AGHT+IG988fV+y4v6eRMN4Qtm6s3lp6PVXdREEpYx8NOLeZVatTVFpsgszJvTsrdmt0s0u6BLPj8NZ9YrZBeedCU
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1c88:b0:40e:48b2:b337 with
 SMTP id k8-20020a05600c1c8800b0040e48b2b337mr147wms.5.1704989844417; Thu, 11
 Jan 2024 08:17:24 -0800 (PST)
Date: Thu, 11 Jan 2024 16:17:09 +0000
In-Reply-To: <20240111161712.1480333-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111161712.1480333-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111161712.1480333-3-vdonnefort@google.com>
Subject: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping functions
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()
  ring_buffer_map_fault()

And controls on the ring-buffer:

  ring_buffer_map_get_reader()  /* swap reader and head */

Mapping the ring-buffer also involves:

  A unique ID for each subbuf of the ring-buffer, currently they are
  only identified through their in-kernel VA.

  A meta-page, where are stored ring-buffer statistics and a
  description for the current reader

The linear mapping exposes the meta-page, and each subbuf of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping subbufs.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..0841ba8bab14 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -221,4 +223,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff);
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..bde39a73ce65
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _TRACE_MMAP_H_
+#define _TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+/**
+ * struct trace_buffer_meta - Ring-buffer Meta-page description
+ * @entries:		Number of entries in the ring-buffer.
+ * @overrun:		Number of entries lost in the ring-buffer.
+ * @read:		Number of entries that have been read.
+ * @subbufs_touched:	Number of subbufs that have been filled.
+ * @subbufs_lost:	Number of subbufs lost to overrun.
+ * @subbufs_read:	Number of subbufs that have been read.
+ * @reader.lost_events:	Number of events lost at the time of the reader swap.
+ * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
+ * @reader.read:	Number of bytes read on the reader subbuf.
+ * @subbuf_size:	Size of each subbuf, including the header.
+ * @nr_subbufs:		Number of subbfs in the ring-buffer.
+ * @meta_page_size:	Size of this meta-page.
+ * @meta_struct_len:	Size of this structure.
+ */
+struct trace_buffer_meta {
+	unsigned long	entries;
+	unsigned long	overrun;
+	unsigned long	read;
+
+	unsigned long	subbufs_touched;
+	unsigned long	subbufs_lost;
+	unsigned long	subbufs_read;
+
+	struct {
+		unsigned long	lost_events;
+		__u32		id;
+		__u32		read;
+	} reader;
+
+	__u32		subbuf_size;
+	__u32		nr_subbufs;
+
+	__u32		meta_page_size;
+	__u32		meta_struct_len;
+};
+
+#endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index db73e326fa04..e9ff1c95e896 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -338,6 +338,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
+	u32		 id;		/* ID for external mapping */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -484,6 +485,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	int				mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*subbuf_ids;	/* ID to addr */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1542,6 +1549,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -5160,6 +5168,23 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+
+	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
+	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
+	WRITE_ONCE(meta->read, cpu_buffer->read);
+
+	WRITE_ONCE(meta->subbufs_touched, local_read(&cpu_buffer->pages_touched));
+	WRITE_ONCE(meta->subbufs_lost, local_read(&cpu_buffer->pages_lost));
+	WRITE_ONCE(meta->subbufs_read, local_read(&cpu_buffer->pages_read));
+
+	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
+	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
+	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5204,6 +5229,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_update_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5418,6 +5446,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	if (READ_ONCE(cpu_buffer_a->mapped) || READ_ONCE(cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5682,7 +5715,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5901,6 +5935,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		if (cpu_buffer->mapped) {
+			err = -EBUSY;
+			goto error;
+		}
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
@@ -6002,6 +6041,295 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
+#define subbuf_page(off, start) \
+	virt_to_page((void *)(start + (off << PAGE_SHIFT)))
+
+#define foreach_subbuf_page(sub_order, start, page)		\
+	page = subbuf_page(0, (start));				\
+	for (int __off = 0; __off < (1 << (sub_order));		\
+	     __off++, page = subbuf_page(__off, (start)))
+
+static inline void subbuf_map_prepare(unsigned long subbuf_start, int order)
+{
+	struct page *page;
+
+	/*
+	 * When allocating order > 0 pages, only the first struct page has a
+	 * refcount > 1. Increasing the refcount here ensures none of the struct
+	 * page composing the sub-buffer is freeed when the mapping is closed.
+	 */
+	foreach_subbuf_page(order, subbuf_start, page)
+		page_ref_inc(page);
+}
+
+static inline void subbuf_unmap(unsigned long subbuf_start, int order)
+{
+	struct page *page;
+
+	foreach_subbuf_page(order, subbuf_start, page) {
+		page_ref_dec(page);
+		page->mapping = NULL;
+	}
+}
+
+static void rb_free_subbuf_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	int sub_id;
+
+	for (sub_id = 0; sub_id < cpu_buffer->nr_pages + 1; sub_id++)
+		subbuf_unmap(cpu_buffer->subbuf_ids[sub_id],
+			     cpu_buffer->buffer->subbuf_order);
+
+	kfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
+}
+
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER | __GFP_ZERO));
+	if (!cpu_buffer->meta_page)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+
+	virt_to_page((void *)addr)->mapping = NULL;
+	free_page(addr);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *subbuf_ids)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
+	struct buffer_page *first_subbuf, *subbuf;
+	int id = 0;
+
+	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
+	cpu_buffer->reader_page->id = id++;
+
+	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
+	do {
+		if (id >= nr_subbufs) {
+			WARN_ON(1);
+			break;
+		}
+
+		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf->id = id;
+		subbuf_map_prepare(subbuf_ids[id], cpu_buffer->buffer->subbuf_order);
+
+		rb_inc_page(&subbuf);
+		id++;
+	} while (subbuf != first_subbuf);
+
+	/* install subbuf ID to kern VA translation */
+	cpu_buffer->subbuf_ids = subbuf_ids;
+
+	meta->meta_page_size = PAGE_SIZE;
+	meta->meta_struct_len = sizeof(*meta);
+	meta->nr_subbufs = nr_subbufs;
+	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+
+	rb_update_meta_page(cpu_buffer);
+}
+
+static inline struct ring_buffer_per_cpu *
+rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return ERR_PTR(-EINVAL);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cpu_buffer;
+}
+
+static inline void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	mutex_unlock(&cpu_buffer->mapping_lock);
+}
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long flags, *subbuf_ids;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->mapped) {
+		if (cpu_buffer->mapped == INT_MAX)
+			err = -EBUSY;
+		else
+			WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return err;
+	}
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err)
+		goto unlock;
+
+	/* subbuf_ids include the reader while nr_pages does not */
+	subbuf_ids = kzalloc(sizeof(*subbuf_ids) * (cpu_buffer->nr_pages + 1),
+			   GFP_KERNEL);
+	if (!subbuf_ids) {
+		rb_free_meta_page(cpu_buffer);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	atomic_inc(&cpu_buffer->resize_disabled);
+
+	/*
+	 * Lock all readers to block any subbuf swap until the subbuf IDs are
+	 * assigned.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+
+	WRITE_ONCE(cpu_buffer->mapped, 1);
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+unlock:
+	mutex_unlock(&buffer->mutex);
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	int err = 0;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -EINVAL;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	mutex_lock(&cpu_buffer->mapping_lock);
+
+	if (!cpu_buffer->mapped) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped - 1);
+	if (!cpu_buffer->mapped) {
+		/* Wait for the writer and readers to observe !mapped */
+		synchronize_rcu();
+
+		rb_free_subbuf_ids(cpu_buffer);
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+	}
+unlock:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+/*
+ *   +--------------+  pgoff == 0
+ *   |   meta page  |
+ *   +--------------+  pgoff == 1
+ *   | subbuffer 0  |
+ *   +--------------+  pgoff == 1 + (1 << subbuf_order)
+ *   | subbuffer 1  |
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	unsigned long subbuf_id, subbuf_offset, addr;
+	struct page *page;
+
+	if (!pgoff)
+		return virt_to_page((void *)cpu_buffer->meta_page);
+
+	pgoff--;
+
+	subbuf_id = pgoff >> buffer->subbuf_order;
+	if (subbuf_id > cpu_buffer->nr_pages)
+		return NULL;
+
+	subbuf_offset = pgoff & ((1UL << buffer->subbuf_order) - 1);
+	addr = cpu_buffer->subbuf_ids[subbuf_id] + (subbuf_offset * PAGE_SIZE);
+	page = virt_to_page((void *)addr);
+
+	return page;
+}
+
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long reader_size;
+	unsigned long flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+consume:
+	if (rb_per_cpu_empty(cpu_buffer))
+		goto out;
+
+	reader_size = rb_page_size(cpu_buffer->reader_page);
+
+	/*
+	 * There are data to be read on the current reader page, we can
+	 * return to the caller. But before that, we assume the latter will read
+	 * everything. Let's update the kernel reader accordingly.
+	 */
+	if (cpu_buffer->reader_page->read < reader_size) {
+		while (cpu_buffer->reader_page->read < reader_size)
+			rb_advance_reader(cpu_buffer);
+		goto out;
+	}
+
+	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
+		goto out;
+
+	goto consume;
+out:
+	rb_update_meta_page(cpu_buffer);
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	rb_put_mapped_buffer(cpu_buffer);
+
+	return 0;
+}
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
-- 
2.43.0.275.g3460e3d667-goog


