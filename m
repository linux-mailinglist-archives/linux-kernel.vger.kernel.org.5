Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B26767267
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjG1Qun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjG1QuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:50:14 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B855B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:47 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-3fe13f529f5so1116525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690562890; x=1691167690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0PukkB0tc/Dn84OU7MXZCMvQjT0YeeI90MbeTUb29Y=;
        b=54G4ROidNsPrK1STBgzuYI81pVgalrswmZ3bJZ7xzH1HQeZdinteHHvLdEXlVaDxM6
         yoTb/Hs7twY3Wa4TUtBxq42g8GIZxsvZ7Z5ZFcguQuu+Ai8LqE4EdNMpnYzct+koE5f3
         f1byaQoYJFIX6zrxtQompsFG/3ZFdBzBHxQaY4ZIpETEg/FbAxPTZ7dAKqPMt5FWjqfZ
         IiiOplMhxBywznFH6hDJmUJ2nhkpwsi6n2PtFYJAp7aNgbK/7IInopsXG1/ux4MLLBri
         G6FINu+mFtVMv3K3JKqwV8xTXDlsryPnddwXWfVpk0C4L8sGNM/nCY+6eyuluYibgSA/
         54LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562890; x=1691167690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0PukkB0tc/Dn84OU7MXZCMvQjT0YeeI90MbeTUb29Y=;
        b=XcIRvVUUf832Sj+auTEWIQ93d6N/TAl1iST05EEWt/4jkPnhUq29Z4XV6F8H48ZWwQ
         8D9q0NzD4gpN4oOV72zgjgM4QC6aUNdsTLfiMzhRKozdjBb7Val2u1cZrLKySsWr3DQ1
         yFJHnwCPrF9gLHBkbcWr1F03QZrZOFCKGPwoVOU3if6UdQ1/QGlMclV704WraE0/5MQ+
         OMmlwiZ8/YyCVwze53NzYNiyJbKzc/D/hC4SAEsf7Br0zI6pyBKTdPq+6i5AiQipZSag
         KgY49Mdq8AxPuFARBbk38oJjXs2uBzqRQo5AfXSl2V1cdEjvutlKtbTuXQ663qq2VGWN
         iN/A==
X-Gm-Message-State: ABy/qLZ8ijSHdKdxcK9dpzydYLYsTKhRhw3V8ADcac4iHArie6d0PvzU
        5v1TET/VlIK2XQ78oWvNcMLR5YjIrohW/WK5
X-Google-Smtp-Source: APBJJlFPHzKz7p4wJ211ku5772wUZJOzfZSObjVDdI5Q9nbfIVZDQH+2L1Doga8Xjw0EQiQAFi/zKVbW0Jzwie4Q
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:68cc:0:b0:313:e2c4:7bc8 with SMTP
 id p12-20020a5d68cc000000b00313e2c47bc8mr20241wrw.8.1690562890323; Fri, 28
 Jul 2023 09:48:10 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:47:53 +0100
In-Reply-To: <20230728164754.460767-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230728164754.460767-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230728164754.460767-2-vdonnefort@google.com>
Subject: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping functions
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..653176cc50bc
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_TRACE_MMAP_H_
+#define _UAPI_TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+struct ring_buffer_meta {
+	unsigned long	entries;
+	unsigned long	overrun;
+	unsigned long	read;
+
+	unsigned long	pages_touched;
+	unsigned long	pages_lost;
+	unsigned long	pages_read;
+
+	__u32		meta_page_size;
+	__u32		nr_data_pages;	/* Number of pages in the ring-buffer */
+
+	struct reader_page {
+		__u32	id;		/* Reader page ID from 0 to nr_data_pages - 1 */
+		__u32	read;		/* Number of bytes read on the reader page */
+		unsigned long	lost_events; /* Events lost at the time of the reader swap */
+	} reader_page;
+};
+
+#endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index de061dd47313..8f367fd3dbdd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -332,6 +332,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	struct buffer_data_page *page;	/* Actual data page */
+	u32		 id;		/* ID for external mapping */
 };
 
 /*
@@ -523,6 +524,12 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+
+	int				mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*page_ids;	/* ID to addr */
+	struct ring_buffer_meta		*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1562,6 +1569,13 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 		/* Again, either we update tail_page or an interrupt does */
 		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
 	}
+
+	if (READ_ONCE(cpu_buffer->mapped)) {
+		/* Ensure the meta_page is ready */
+		smp_rmb();
+		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
+			   local_read(&cpu_buffer->pages_touched));
+	}
 }
 
 static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
@@ -1725,6 +1739,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -2521,6 +2536,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
+		if (READ_ONCE(cpu_buffer->mapped)) {
+			/* Ensure the meta_page is ready */
+			smp_rmb();
+			WRITE_ONCE(cpu_buffer->meta_page->overrun,
+				   local_read(&cpu_buffer->overrun));
+			WRITE_ONCE(cpu_buffer->meta_page->pages_lost,
+				   local_read(&cpu_buffer->pages_lost));
+		}
+
 		/*
 		 * The entries will be zeroed out when we move the
 		 * tail page.
@@ -3183,6 +3207,14 @@ static inline void rb_event_discard(struct ring_buffer_event *event)
 static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	local_inc(&cpu_buffer->entries);
+
+	if (READ_ONCE(cpu_buffer->mapped)) {
+		/* Ensure the meta_page is ready */
+		smp_rmb();
+		WRITE_ONCE(cpu_buffer->meta_page->entries,
+			   local_read(&cpu_buffer->entries));
+	}
+
 	rb_end_commit(cpu_buffer);
 }
 
@@ -3486,7 +3518,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -4658,6 +4690,13 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -4724,6 +4763,13 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
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
@@ -5253,6 +5299,19 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_reset_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->meta_page;
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
@@ -5297,6 +5356,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_reset_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 }
 
@@ -5511,6 +5573,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
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
@@ -5753,7 +5820,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5870,6 +5938,255 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+static void rb_free_page_ids(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	int i;
+
+	for (i = 0; i < cpu_buffer->nr_pages + 1; i++)
+		virt_to_page(cpu_buffer->page_ids[i])->mapping = NULL;
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
+	virt_to_page(addr)->mapping = NULL;
+	free_page(addr);
+	cpu_buffer->meta_page = NULL;
+}
+
+static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
+				   unsigned long *page_ids)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->meta_page;
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
+	 * Ensure the writer will observe the meta-page before
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
+	return virt_to_page(cpu_buffer->page_ids[pgoff]);
+}
+
+int ring_buffer_map_get_reader_page(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	unsigned long reader_size, flags;
+
+	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
+	if (IS_ERR(cpu_buffer))
+		return (int)PTR_ERR(cpu_buffer);
+
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+consume:
+	if (rb_per_cpu_empty(cpu_buffer))
+		goto out;
+	reader_size = rb_page_size(cpu_buffer->reader_page);
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
2.41.0.487.g6d72f3e995-goog

