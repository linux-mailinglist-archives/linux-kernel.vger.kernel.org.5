Return-Path: <linux-kernel+bounces-118736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472F88BEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534DE1C3C564
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A45490D;
	Tue, 26 Mar 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUvqdQQE"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848A5CDC0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447474; cv=none; b=r3UG4lF8slaD/7Djn5NiXwS/jzd7TyOdQ9sB4glUTWKxZPJ2k1lBk5lms75M7nJVfO4oNfQFo6mWboMSV9XZTnw+UGyoM9zTV2AxPUp1vKLRO/s9EWNpPcHoKDNX94+khiTRNbbAdg32Qemf7ePQcMr4SKlfN/iaH3cz2JGjBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447474; c=relaxed/simple;
	bh=OHpYEOQw6FEN0KsVDOTAtb9TmPgJSiw5Kgl3pAQNED4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eydBQiXrlrfPTpT4RafcDStHUkUsUuOs+HNMuztiZYSJiF5t4PB4TYKJ1nWQC6Sew0TxLxXWGTu1qPYbp8C0IJov282xtgF2f08EhSn4XsuhN16ZDsjcCPM0/Zy02P8C+oAPYBjsqfusiWZ00aNXWqCWDlcmIc1kbiAylkd2uiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUvqdQQE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-414042da713so30320765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447470; x=1712052270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYRTxs7a6D6IBSC8XFocQMEHDIFaEvaqn/61ZMtiVHc=;
        b=ZUvqdQQERLcEamPphDwXlnuF+3POmrpvy7b3DauQ4PLgDp1v1IomUNl/kXrvM95JP4
         F0i8weMJs8b1j8uMxh0rPfWpYgNVaT0UOU5C9a0YrZCi1RA0yLnmZbvm6MpwbNhiDly8
         tsYsJzJgTbwSQQQvaRkTTB9xizbs+l/+ZRI3AXCL4KdRP+hG4b889BSQ34HddYmkMwyC
         1VCYPskIDAkZsSYfttpaVjgecMbrprHK5Y10yxpCmyRegPRWAKMc93g0ev3uIuRtiKqG
         53Zmy0I5gFST3USQhARs+c1TsJgJeaMcQCM4HqEEIZu2oA5KqBcd+0krYMD7+Dhs7EIj
         Gs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447470; x=1712052270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYRTxs7a6D6IBSC8XFocQMEHDIFaEvaqn/61ZMtiVHc=;
        b=Yf2nC4DqP4CialtrPxy19SEX3d2iNmc95QMGPxzaFnr3XRZkgicfumhu1sw2tHgqml
         b5EUSUAzT2C8wJGVM2BQr4wsWtP4z7nh0UVCyRV/D62sCjPsq8NAjU9DP3/zIhnGZunD
         Ab9N0qoMS5U+LzPiJ0xh5wPM40DMfYuPYTGyN5GaSyo0PSrtx54oEboFXWFarVe2Od/H
         USUDINq1YlQc5Ri5y9LdheAGksRZc4TOrIYNsUu2NyqBK4LIs+7airIVOHFLP/vOpHL5
         34Qxm08nB95eRNT1FVsX13YkvrhM39EyatzwBLLdZV48MU8vORQ0m9Ut0Hzu4KdoGoy2
         IEag==
X-Forwarded-Encrypted: i=1; AJvYcCWYssJuoz2skGSaYbrbyMVVtcxMjgTY0B/uo0KJTe9f9dx9zBnch5ep0qMOBPmGvccOMUF9/u+0rnuHei5lX38fjBqy5WZXitSNX44t
X-Gm-Message-State: AOJu0YyCES3ncFRXcKa9BNIBlRLuLxg9RgCe201tLESKfmvDCA1h+ucp
	O8qj2FF+2+vB+SjcoNcywBS2wrkXwpmJ/+0xGWcAijsgYykArBBpE6WmXJ7AubI8yh77tJ4GVZp
	uhEV/tfPnIbKUVLkwHw==
X-Google-Smtp-Source: AGHT+IHaniun7B19VQIjk46c9LGDc+fy0UOZK3v4jcArD+uA6YUz+UqpCjbNXnJeXNCor5o702cU5+6nq1B8mWdR
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d20:b0:414:908d:7263 with
 SMTP id l32-20020a05600c1d2000b00414908d7263mr5255wms.3.1711447470578; Tue,
 26 Mar 2024 03:04:30 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:03:27 +0000
In-Reply-To: <20240326100330.1321861-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326100330.1321861-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100330.1321861-3-vdonnefort@google.com>
Subject: [PATCH v19 2/5] ring-buffer: Introducing ring-buffer mapping functions
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for allowing the user-space to map a ring-buffer, add
a set of mapping functions:

  ring_buffer_{map,unmap}()

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
index dc5ae4e96aee..96d2140b471e 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -6,6 +6,8 @@
 #include <linux/seq_file.h>
 #include <linux/poll.h>
 
+#include <uapi/linux/trace_mmap.h>
+
 struct trace_buffer;
 struct ring_buffer_iter;
 
@@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 #define trace_rb_cpu_prepare	NULL
 #endif
 
+int ring_buffer_map(struct trace_buffer *buffer, int cpu,
+		    struct vm_area_struct *vma);
+int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
+int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
new file mode 100644
index 000000000000..ffcd8dfcaa4f
--- /dev/null
+++ b/include/uapi/linux/trace_mmap.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _TRACE_MMAP_H_
+#define _TRACE_MMAP_H_
+
+#include <linux/types.h>
+
+/**
+ * struct trace_buffer_meta - Ring-buffer Meta-page description
+ * @meta_page_size:	Size of this meta-page.
+ * @meta_struct_len:	Size of this structure.
+ * @subbuf_size:	Size of each sub-buffer.
+ * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
+ * @reader.lost_events:	Number of events lost at the time of the reader swap.
+ * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
+ * @reader.read:	Number of bytes read on the reader subbuf.
+ * @flags:		Placeholder for now, 0 until new features are supported.
+ * @entries:		Number of entries in the ring-buffer.
+ * @overrun:		Number of entries lost in the ring-buffer.
+ * @read:		Number of entries that have been read.
+ * @Reserved1:		Reserved for future use.
+ * @Reserved2:		Reserved for future use.
+ */
+struct trace_buffer_meta {
+	__u32		meta_page_size;
+	__u32		meta_struct_len;
+
+	__u32		subbuf_size;
+	__u32		nr_subbufs;
+
+	struct {
+		__u64	lost_events;
+		__u32	id;
+		__u32	read;
+	} reader;
+
+	__u64	flags;
+
+	__u64	entries;
+	__u64	overrun;
+	__u64	read;
+
+	__u64	Reserved1;
+	__u64	Reserved2;
+};
+
+#endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cc9ebe593571..1dc932e7963c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -9,6 +9,7 @@
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
 #include <linux/sched/clock.h>
+#include <linux/cacheflush.h>
 #include <linux/trace_seq.h>
 #include <linux/spinlock.h>
 #include <linux/irq_work.h>
@@ -338,6 +339,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
+	u32		 id;		/* ID for external mapping */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -484,6 +486,12 @@ struct ring_buffer_per_cpu {
 	u64				read_stamp;
 	/* pages removed since last reset */
 	unsigned long			pages_removed;
+
+	unsigned int			mapped;
+	struct mutex			mapping_lock;
+	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct trace_buffer_meta	*meta_page;
+
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -1599,6 +1607,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
 	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
+	mutex_init(&cpu_buffer->mapping_lock);
 
 	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 			    GFP_KERNEL, cpu_to_node(cpu));
@@ -1789,8 +1798,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
 	return buffer->time_stamp_abs;
 }
 
-static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
-
 static inline unsigned long rb_page_entries(struct buffer_page *bpage)
 {
 	return local_read(&bpage->entries) & RB_WRITE_MASK;
@@ -5211,6 +5218,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 	page->read = 0;
 }
 
+static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+
+	meta->reader.read = cpu_buffer->reader_page->read;
+	meta->reader.id = cpu_buffer->reader_page->id;
+	meta->reader.lost_events = cpu_buffer->lost_events;
+
+	meta->entries = local_read(&cpu_buffer->entries);
+	meta->overrun = local_read(&cpu_buffer->overrun);
+	meta->read = cpu_buffer->read;
+
+	/* Some archs do not have data cache coherency between kernel and user-space */
+	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -5255,6 +5278,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
+	if (cpu_buffer->mapped)
+		rb_update_meta_page(cpu_buffer);
+
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
 }
@@ -5469,6 +5495,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
+	/* It's up to the callers to not try to swap mapped buffers */
+	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
@@ -5733,7 +5765,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
 	if (read || (len < (commit - read)) ||
-	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
+	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
+	    cpu_buffer->mapped) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
@@ -5956,6 +5989,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		if (cpu_buffer->mapped) {
+			err = -EBUSY;
+			goto error;
+		}
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
@@ -6057,6 +6095,358 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
+static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct page *page;
+
+	if (cpu_buffer->meta_page)
+		return 0;
+
+	page = alloc_page(GFP_USER | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+
+	cpu_buffer->meta_page = page_to_virt(page);
+
+	return 0;
+}
+
+static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
+
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
+	cpu_buffer->reader_page->id = id++;
+
+	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
+	do {
+		if (WARN_ON(id >= nr_subbufs))
+			break;
+
+		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf->id = id;
+
+		rb_inc_page(&subbuf);
+		id++;
+	} while (subbuf != first_subbuf);
+
+	/* install subbuf ID to kern VA translation */
+	cpu_buffer->subbuf_ids = subbuf_ids;
+
+	/* __rb_map_vma() pads the meta-page to align it with the sub-buffers */
+	meta->meta_page_size = PAGE_SIZE << cpu_buffer->buffer->subbuf_order;
+	meta->meta_struct_len = sizeof(*meta);
+	meta->nr_subbufs = nr_subbufs;
+	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+
+	rb_update_meta_page(cpu_buffer);
+}
+
+static struct ring_buffer_per_cpu *
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
+static void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	mutex_unlock(&cpu_buffer->mapping_lock);
+}
+
+/*
+ * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
+ * to be set-up or torn-down.
+ */
+static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
+			       bool inc)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(&cpu_buffer->mapping_lock);
+
+	if (inc && cpu_buffer->mapped == UINT_MAX)
+		return -EBUSY;
+
+	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
+		return -EINVAL;
+
+	mutex_lock(&cpu_buffer->buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	if (inc)
+		cpu_buffer->mapped++;
+	else
+		cpu_buffer->mapped--;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	mutex_unlock(&cpu_buffer->buffer->mutex);
+
+	return 0;
+}
+
+#define subbuf_page(off, start) \
+	virt_to_page((void *)((start) + ((off) << PAGE_SHIFT)))
+
+#define foreach_subbuf_page(sub_order, start, page)		\
+	page = subbuf_page(0, (start));				\
+	for (int __off = 0; __off < (1 << (sub_order));		\
+	     __off++, page = subbuf_page(__off, (start)))
+
+/*
+ *   +--------------+  pgoff == 0
+ *   |   meta page  |
+ *   +--------------+  pgoff == 1
+ *   |   000000000  |
+ *   +--------------+  pgoff == (1 << subbuf_order)
+ *   | subbuffer 0  |
+ *   |              |
+ *   +--------------+  pgoff == (2 * (1 << subbuf_order))
+ *   | subbuffer 1  |
+ *   |              |
+ *         ...
+ */
+static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
+			struct vm_area_struct *vma)
+{
+	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned int subbuf_pages, subbuf_order;
+	struct page **pages;
+	int p = 0, s = 0;
+	int err;
+
+	lockdep_assert_held(&cpu_buffer->mapping_lock);
+
+	subbuf_order = cpu_buffer->buffer->subbuf_order;
+	subbuf_pages = 1 << subbuf_order;
+
+	if (subbuf_order && pgoff % subbuf_pages)
+		return -EINVAL;
+
+	nr_subbufs = cpu_buffer->nr_pages + 1;
+	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;
+
+	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	if (!vma_pages || vma_pages > nr_pages)
+		return -EINVAL;
+
+	nr_pages = vma_pages;
+
+	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	if (!pgoff) {
+		unsigned long meta_page_padding;
+
+		pages[p++] = virt_to_page(cpu_buffer->meta_page);
+
+		/*
+		 * Pad with the zero-page to align the meta-page with the
+		 * sub-buffers.
+		 */
+		meta_page_padding = subbuf_pages - 1;
+		while (meta_page_padding-- && p < nr_pages)
+			pages[p++] = ZERO_PAGE(0);
+	} else {
+		/* Skip the meta-page */
+		pgoff -= subbuf_pages;
+
+		s += pgoff / subbuf_pages;
+	}
+
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
+
+	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
+
+	kfree(pages);
+
+	return err;
+}
+
+int ring_buffer_map(struct trace_buffer *buffer, int cpu,
+		    struct vm_area_struct *vma)
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
+		err = __rb_map_vma(cpu_buffer, vma);
+		if (!err)
+			err = __rb_inc_dec_mapped(cpu_buffer, true);
+		mutex_unlock(&cpu_buffer->mapping_lock);
+		return err;
+	}
+
+	/* prevent another thread from changing buffer/sub-buffer sizes */
+	mutex_lock(&buffer->mutex);
+
+	err = rb_alloc_meta_page(cpu_buffer);
+	if (err)
+		goto unlock;
+
+	/* subbuf_ids include the reader while nr_pages does not */
+	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
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
+	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	err = __rb_map_vma(cpu_buffer, vma);
+	if (!err) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		cpu_buffer->mapped = 1;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	} else {
+		kfree(cpu_buffer->subbuf_ids);
+		cpu_buffer->subbuf_ids = NULL;
+		rb_free_meta_page(cpu_buffer);
+	}
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
+	unsigned long flags;
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
+		goto out;
+	} else if (cpu_buffer->mapped > 1) {
+		__rb_inc_dec_mapped(cpu_buffer, false);
+		goto out;
+	}
+
+	mutex_lock(&buffer->mutex);
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
+	cpu_buffer->mapped = 0;
+
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+	kfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
+	rb_free_meta_page(cpu_buffer);
+	atomic_dec(&cpu_buffer->resize_disabled);
+
+	mutex_unlock(&buffer->mutex);
+out:
+	mutex_unlock(&cpu_buffer->mapping_lock);
+
+	return err;
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
+	/* Some archs do not have data cache coherency between kernel and user-space */
+	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+
+	rb_update_meta_page(cpu_buffer);
+
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
2.44.0.396.g6e790dbe36-goog


