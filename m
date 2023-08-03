Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC7376E8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjHCMv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjHCMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:51:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17635A4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:51:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704970148dso9679887b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691067111; x=1691671911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MfGjcR1EbDev2T2p8ePs7pwG/cgdqcucLngAn3GtxI=;
        b=34BLKcNrv7ILUnQzR0No4vJffC0g7KFnL7oPUm8Qr4pHqROE/NoCWvXyIq9V72epKr
         k2IfowxMOsUcp0csaey+TohA4rGVPNtQ63ZZdqaLYi9uPEWH9n+N/5k7mNpz6cRRfwli
         3cpkrd5G8Ha5mTKMFHsU1OU/L7at+/M5GSgC2wBjJDSCA0BbWENE7C9OdrL3oNALiT7V
         sWIMCkqHBe8qaA4yzy96Vo3sOFCwKq8anKvMIxOHaUTduMWIk1tCM4wW04zYo+dJu3eQ
         HskZ3FA5TQEhSES4/+nnIIJJXcg0SuU52R/HwkO6RKaLo/ajZDLdRsnwpE0TB3GRC9hW
         lzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067111; x=1691671911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MfGjcR1EbDev2T2p8ePs7pwG/cgdqcucLngAn3GtxI=;
        b=JAQ69RNtkhRvqqOpAIo3FdNMEXyRd3WovhFnSLA9NQzf1MWpKql38qkJRW0LC2MOrq
         MPiQmkNGNoYO97v8O9zcBxCll4JGX5tjHDRRhN8E1k8tIOW8ncBf+hBynr5Ekf9rgr5X
         pzAeGG76TwizEivS16JC3/DsQjh5kYurpECcyUVJwL6ooDtGApBJR7trFbHA3IAwxOzZ
         sjJljL22Q3mTHIfZSdQEAV8FHtrTfKYuoa8wPceXPVlHSPeEP3uM3tsYqt8HKkY7ULB6
         3bNtA+1rwMgCbWLV/T/B6h2BEpo1PS//SFUneG3aDiKTmnopHGMTMqse/+IapW87JlBH
         q36Q==
X-Gm-Message-State: ABy/qLY2DZyVrIRInQFjT3Y4kNT7ByTBixCjfKW6zjFRIpF1Y4uonime
        L8ej8IGPe2/T8fZKA26T4DXrayfm+NLDL7im
X-Google-Smtp-Source: APBJJlH7EXtgCF49p0I4xP8By4/CaC9Dyx+90B9P+vdpLOLSl9Ghafoz+9odPb1nBO7TShy5Ik2bYeRBhFMwJ5Mr
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:b615:0:b0:565:a33a:a49f with SMTP
 id u21-20020a81b615000000b00565a33aa49fmr168360ywh.6.1691067111050; Thu, 03
 Aug 2023 05:51:51 -0700 (PDT)
Date:   Thu,  3 Aug 2023 13:51:36 +0100
In-Reply-To: <20230803125137.1779474-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230803125137.1779474-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803125137.1779474-2-vdonnefort@google.com>
Subject: [PATCH v6 1/2] ring-buffer: Introducing ring-buffer mapping functions
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()
  ring_buffer_map_fault()

And controls on the ring-buffer:

  ring_buffer_map_get_reader_page()  /* swap reader and head */

Mapping the ring-buffer also involves:

  A unique ID for each page of the ring-buffer, as currently the pages
  are only identified through their in-kernel VA.

  A meta-page, where are stored statistics about the ring-buffer and
  a page IDs list, ordered. A field gives what page is the reader
  one and one to gives where the ring-buffer starts in the list of data
  pages.

The linear mapping exposes the meta-page, and each page of the
ring-buffer, ordered following their unique ID, assigned during the
first mapping.

Once mapped, no page can get in or out of the ring-buffer: the buffer
size will remain unmodified and the splice enabling functions will in
reality simply memcpy the data instead of swapping pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..980abfbd92ed 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -211,4 +213,9 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff);
+int ring_buffer_map_get_reader_page(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..41759b9ad9f2
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_TRACE_MMAP_H_
+#define _UAPI_TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+struct trace_buffer_read_page {
+	unsigned long	lost_events;	/* Events lost at the time of the reader swap */
+	__u32	id;			/* Reader page ID from 0 to nr_data_pages - 1 */
+	__u32	read;			/* Number of bytes read on the reader page */
+};
+
+struct trace_buffer_meta {
+	unsigned long	entries;
+	unsigned long	overrun;
+	unsigned long	read;
+
+	unsigned long	pages_touched;
+	unsigned long	pages_lost;
+	unsigned long	pages_read;
+
+	struct trace_buffer_read_page reader_page;
+
+	__u32		meta_page_size;		/* Size of the meta-page */
+	__u32		meta_struct_len;	/* Len of this struct */
+	__u32		nr_data_pages;		/* Number of pages in the ring-buffer */
+};
+
+#endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 52dea5dd5362..cf9a96883a33 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -330,6 +330,7 @@ struct buffer_page {
 	local_t		 write;		/* index for next write */
 	unsigned	 read;		/* index for next read */
 	local_t		 entries;	/* entries on this page */
+	u32		 id;		/* ID for external mapping */
 	unsigned long	 real_end;	/* real end of data */
 	struct buffer_data_page *page;	/* Actual data page */
 };
@@ -525,6 +526,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	int				mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*page_ids;	/* ID to addr */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -929,6 +936,22 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 	return (dirty * 100) > (full * nr_pages);
 }
 
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (unlikely(READ_ONCE(cpu_buffer->mapped))) {
+		/* Ensure the meta_page is ready */
+		smp_rmb();
+		WRITE_ONCE(cpu_buffer->meta_page->entries,
+			   local_read(&cpu_buffer->entries));
+		WRITE_ONCE(cpu_buffer->meta_page->overrun,
+			   local_read(&cpu_buffer->overrun));
+		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
+			   local_read(&cpu_buffer->pages_touched));
+		WRITE_ONCE(cpu_buffer->meta_page->pages_lost,
+			   local_read(&cpu_buffer->pages_lost));
+	}
+}
+
 /*
  * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
  *
@@ -938,6 +961,10 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
 static void rb_wake_up_waiters(struct irq_work *work)
 {
 	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
+	struct ring_buffer_per_cpu *cpu_buffer =
+		container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+
+	rb_update_meta_page(cpu_buffer);
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
@@ -1729,6 +1756,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -3485,7 +3513,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -4658,6 +4686,13 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 		cpu_buffer->last_overrun = overwrite;
 	}
 
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->meta_page->reader_page.read, 0);
+		WRITE_ONCE(cpu_buffer->meta_page->reader_page.id, reader->id);
+		WRITE_ONCE(cpu_buffer->meta_page->reader_page.lost_events, cpu_buffer->lost_events);
+		WRITE_ONCE(cpu_buffer->meta_page->pages_read, local_read(&cpu_buffer->pages_read));
+	}
+
 	goto again;
 
  out:
@@ -4724,6 +4759,13 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
+
+	if (cpu_buffer->mapped) {
+		WRITE_ONCE(cpu_buffer->meta_page->reader_page.read,
+			   cpu_buffer->reader_page->read);
+		WRITE_ONCE(cpu_buffer->meta_page->read,
+			   cpu_buffer->read);
+	}
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5254,6 +5296,19 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_reset_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+
+	WRITE_ONCE(meta->entries, 0);
+	WRITE_ONCE(meta->overrun, 0);
+	WRITE_ONCE(meta->read, cpu_buffer->read);
+	WRITE_ONCE(meta->pages_touched, 0);
+	WRITE_ONCE(meta->pages_lost, 0);
+	WRITE_ONCE(meta->pages_read, local_read(&cpu_buffer->pages_read));
+	WRITE_ONCE(meta->reader_page.read, cpu_buffer->reader_page->read);
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5298,6 +5353,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_reset_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5512,6 +5570,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
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
@@ -5754,7 +5817,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5871,6 +5935,264 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	int i;
+
+	for (i = 0; i < cpu_buffer->nr_pages + 1; i++)
+		virt_to_page((void *)cpu_buffer->page_ids[i])->mapping = NULL;
+
+	kfree(cpu_buffer->page_ids);
+	cpu_buffer->page_ids = NULL;
+}
+
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	cpu_buffer->meta_page = page_to_virt(alloc_page(GFP_USER));
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
+				   unsigned long *page_ids)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	unsigned int nr_data_pages = cpu_buffer->nr_pages + 1;
+	struct buffer_page *first_page, *bpage;
+	int id = 0;
+
+	page_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
+	cpu_buffer->reader_page->id = id++;
+
+	first_page = bpage = rb_set_head_page(cpu_buffer);
+	do {
+		if (id >= nr_data_pages) {
+			WARN_ON(1);
+			break;
+		}
+
+		page_ids[id] = (unsigned long)bpage->page;
+		bpage->id = id;
+
+		rb_inc_page(&bpage);
+		id++;
+	} while (bpage != first_page);
+
+	/* install page ID to kern VA translation */
+	cpu_buffer->page_ids = page_ids;
+
+	meta->meta_page_size = PAGE_SIZE;
+	meta->meta_struct_len = sizeof(*meta);
+	meta->nr_data_pages = nr_data_pages;
+	meta->reader_page.id = cpu_buffer->reader_page->id;
+	rb_reset_meta_page(cpu_buffer);
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
+	unsigned long flags, *page_ids;
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
+		WRITE_ONCE(cpu_buffer->mapped, cpu_buffer->mapped + 1);
+		goto unlock;
+	}
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+	atomic_inc(&cpu_buffer->resize_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err) {
+		atomic_dec(&cpu_buffer->resize_disabled);
+		goto unlock;
+	}
+
+	/* page_ids include the reader page while nr_pages does not */
+	page_ids = kzalloc(sizeof(*page_ids) * (cpu_buffer->nr_pages + 1),
+			   GFP_KERNEL);
+	if (!page_ids) {
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/*
+	 * Lock all readers to block any page swap until the page IDs are
+	 * assigned.
+	 */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	rb_setup_ids_meta_page(cpu_buffer, page_ids);
+	/*
+	 * Ensure rb_update_meta() will observe the meta-page before
+	 * cpu_buffer->mapped.
+	 */
+	smp_wmb();
+	WRITE_ONCE(cpu_buffer->mapped, 1);
+
+	/* Init meta_page values unless the writer did it already */
+	cmpxchg(&cpu_buffer->meta_page->entries, 0,
+		local_read(&cpu_buffer->entries));
+	cmpxchg(&cpu_buffer->meta_page->overrun, 0,
+		local_read(&cpu_buffer->overrun));
+	cmpxchg(&cpu_buffer->meta_page->pages_touched, 0,
+		local_read(&cpu_buffer->pages_touched));
+	cmpxchg(&cpu_buffer->meta_page->pages_lost, 0,
+		local_read(&cpu_buffer->pages_lost));
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+unlock:
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
+		/* Wait the writer and readers to observe !mapped */
+		synchronize_rcu();
+
+		rb_free_page_ids(cpu_buffer);
+		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
+	}
+
+unlock:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
+}
+
+/*
+ *   +--------------+
+ *   |   meta page  |  pgoff=0
+ *   +--------------+
+ *   |  data page1  |  page_ids=0
+ *   +--------------+
+ *   |  data page2  |  page_ids=1
+ *         ...
+ */
+struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
+				   unsigned long pgoff)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+
+	if (!pgoff)
+		return virt_to_page((void *)cpu_buffer->meta_page);
+
+	pgoff--;
+	if (pgoff > cpu_buffer->nr_pages)
+		return NULL;
+
+	return virt_to_page((void *)cpu_buffer->page_ids[pgoff]);
+}
+
+int ring_buffer_map_get_reader_page(struct trace_buffer *buffer, int cpu)
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
2.41.0.585.gd2178a4bd4-goog

