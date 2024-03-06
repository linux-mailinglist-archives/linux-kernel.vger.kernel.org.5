Return-Path: <linux-kernel+bounces-93217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D6872C71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF632896E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890671B297;
	Wed,  6 Mar 2024 01:58:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F781FC18;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690295; cv=none; b=K1BSGT2zxvTX2KTycimW94jy2FeKoa2DAA8i/Ok4JpwSP6H0vgV0dKX3B97fsZ//kK8DoZSMiWrByNJWgEp+NWZg7p2qXtTJmuOJlKHapDV6Ol3EP557dPMfPkoAwQrkkxQdAzUpc/AHoDJB6FC4ZnLmG1Ai30b526+3zhzreGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690295; c=relaxed/simple;
	bh=FhZpnR+W7njdgbykATP512Ts6RKIPCFf6M9e5o5Ao0A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qBW35gJnRqq04QWRv6coyHg+gOBvzg24eLdyV+ievc0Th3gEMpjI4zifCaM/1pbRubyxhrOpcO9pN62O6frLhBl6td488ovLAjQN1QBPU9jhfuufQ+eb7Olp1cgnybEOPu7gskdwoPd40ZEwwR7eoM+MDicEpkDoyjE7q/N2Am8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E15C43330;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZi-00000000TDK-2NKC;
	Tue, 05 Mar 2024 21:00:06 -0500
Message-ID: <20240306020006.423802400@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH 7/8] ring-buffer: Add test if range of boot buffer is valid
References: <20240306015910.766510873@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a test against the ring buffer memory range to see if it has valid
data. The ring_buffer_meta structure is given a new field called
"first_buffer" which holds the address of the first sub-buffer. This is
used to both determine if the other fields are valid as well as finding
the offset between the old addresses of the sub-buffer from the previous
boot to the new addresses of the current boot.

Since the values for nr_subbufs and subbuf_size is to be the same, check
if the values in the meta page match the values calculated.

Take the range of the first_buffer and the total size of all the buffers
and make sure the saved head_buffer and commit_buffer fall in the range.

Iterate through all the sub-buffers to make sure that the values in the
sub-buffer "commit" field (the field that holds the amount of data on the
sub-buffer) is within the end of the sub-buffer. Also check the index
array to make sure that all the indexes are within nr_subbufs.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 142 ++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1e06ebe36ad1..e74185a4d864 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -44,6 +44,7 @@
 static void update_pages_handler(struct work_struct *work);
 
 struct ring_buffer_meta {
+	unsigned long	first_buffer;
 	unsigned long	head_buffer;
 	unsigned long	commit_buffer;
 	__u32		subbuf_size;
@@ -1554,20 +1555,101 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
 	return (void *)ptr;
 }
 
+/*
+ * See if the existing memory contains valid ring buffer data.
+ * As the previous kernel must be the same as this kernel, all
+ * the calculations (size of buffers and number of buffers)
+ * must be the same.
+ */
+static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
+			  struct trace_buffer *buffer, int nr_pages)
+{
+	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	struct buffer_data_page *subbuf;
+	unsigned long buffers_start;
+	unsigned long buffers_end;
+
+	/* The subbuffer's size and number of subbuffers must match */
+	if (meta->subbuf_size != subbuf_size ||
+	    meta->nr_subbufs != nr_pages + 1) {
+		pr_info("Ring buffer boot meta [%d] mismatch of subbuf_size/nr_pages\n", cpu);
+		return false;
+	}
+
+	buffers_start = meta->first_buffer;
+	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
+
+	/* Is the head and commit buffers within the range of buffers? */
+	if (meta->head_buffer < buffers_start ||
+	    meta->head_buffer >= buffers_end) {
+		pr_info("Ring buffer boot meta [%d] head buffer out of range\n", cpu);
+		return false;
+	}
+
+	if (meta->commit_buffer < buffers_start ||
+	    meta->commit_buffer >= buffers_end) {
+		pr_info("Ring buffer boot meta [%d] commit buffer out of range\n", cpu);
+		return false;
+	}
+
+	subbuf = rb_subbufs_from_meta(meta);
+
+	/* Is the meta buffers and the subbufs themselves have correct data? */
+	for (int i = 0; i < meta->nr_subbufs; i++) {
+		if (meta->buffers[i] < 0 ||
+		    meta->buffers[i] >= meta->nr_subbufs) {
+			pr_info("Ring buffer boot meta [%d] array out of range\n", cpu);
+			return false;
+		}
+
+		if ((unsigned)local_read(&subbuf->commit) > subbuf_size) {
+			pr_info("Ring buffer boot meta [%d] buffer invalid commit\n", cpu);
+			return false;
+		}
+
+		subbuf = (void *)subbuf + subbuf_size;
+	}
+
+	pr_info("Ring buffer meta is from previous boot!\n");
+	return true;
+}
+
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
+	unsigned long delta;
 	void *subbuf;
 	int cpu;
 
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		void *next_meta;
+
 		meta = rb_range_meta(buffer, nr_pages, cpu);
 
+		if (rb_meta_valid(meta, cpu, buffer, nr_pages)) {
+			/* Make the mappings match the current address */
+			subbuf = rb_subbufs_from_meta(meta);
+			delta = (unsigned long)subbuf - meta->first_buffer;
+			meta->first_buffer += delta;
+			meta->head_buffer += delta;
+			meta->commit_buffer += delta;
+			continue;
+		}
+
+		if (cpu < nr_cpu_ids - 1)
+			next_meta = rb_range_meta(buffer, nr_pages, cpu + 1);
+		else
+			next_meta = (void *)buffer->range_addr_end;
+
+		memset(meta, 0, next_meta - (void *)meta);
+
 		meta->nr_subbufs = nr_pages + 1;
 		meta->subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
 
 		subbuf = rb_subbufs_from_meta(meta);
 
+		meta->first_buffer = (unsigned long)subbuf;
+
 		/*
 		 * The buffers[] array holds the order of the sub-buffers
 		 * that are after the meta data. The sub-buffers may
@@ -1659,10 +1741,26 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 	return 0;
 }
 
+/* Map the buffer_pages to the previous head and commit pages */
+static void rb_meta_buffer_update(struct ring_buffer_per_cpu *cpu_buffer,
+				  struct buffer_page *bpage)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+
+	if (meta->head_buffer == (unsigned long)bpage->page)
+		cpu_buffer->head_page = bpage;
+
+	if (meta->commit_buffer == (unsigned long)bpage->page) {
+		cpu_buffer->commit_page = bpage;
+		cpu_buffer->tail_page = bpage;
+	}
+}
+
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		long nr_pages, struct list_head *pages)
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
+	struct ring_buffer_meta *meta = NULL;
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
 	gfp_t mflags;
@@ -1697,6 +1795,10 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	 */
 	if (user_thread)
 		set_current_oom_origin();
+
+	if (buffer->range_addr_start)
+		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
+
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 
@@ -1709,11 +1811,14 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add_tail(&bpage->list, pages);
 
-		if (buffer->range_addr_start) {
+		if (meta) {
 			/* A range was given. Use that for the buffer page */
 			bpage->page = rb_range_buffer(cpu_buffer, i + 1);
 			if (!bpage->page)
 				goto free_pages;
+			/* If this is valid from a previous boot */
+			if (meta->head_buffer)
+				rb_meta_buffer_update(cpu_buffer, bpage);
 			bpage->range = 1;
 			bpage->id = i + 1;
 		} else {
@@ -1775,6 +1880,7 @@ static struct ring_buffer_per_cpu *
 rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_meta *meta;
 	struct buffer_page *bpage;
 	struct page *page;
 	int ret;
@@ -1815,6 +1921,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		bpage->page = rb_range_buffer(cpu_buffer, 0);
 		if (!bpage->page)
 			goto fail_free_reader;
+		if (cpu_buffer->ring_meta->head_buffer)
+			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
 	} else {
 		page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
@@ -1832,14 +1940,32 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	if (ret < 0)
 		goto fail_free_reader;
 
-	cpu_buffer->head_page
-		= list_entry(cpu_buffer->pages, struct buffer_page, list);
-	cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
+	/* If the boot meta was valid then this has already been updated */
+	meta = cpu_buffer->ring_meta;
+	if (!meta || !meta->head_buffer ||
+	    !cpu_buffer->head_page || !cpu_buffer->commit_page || !cpu_buffer->tail_page) {
+		if (meta && meta->head_buffer &&
+		    (cpu_buffer->head_page || cpu_buffer->commit_page || cpu_buffer->tail_page)) {
+			pr_warn("Ring buffer meta buffers not all mapped\n");
+			if (!cpu_buffer->head_page)
+				pr_warn("   Missing head_page\n");
+			if (!cpu_buffer->commit_page)
+				pr_warn("   Missing commit_page\n");
+			if (!cpu_buffer->tail_page)
+				pr_warn("   Missing tail_page\n");
+		}
 
-	rb_head_page_activate(cpu_buffer);
-	if (cpu_buffer->ring_meta) {
-		struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
-		meta->commit_buffer = meta->head_buffer;
+		cpu_buffer->head_page
+			= list_entry(cpu_buffer->pages, struct buffer_page, list);
+		cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
+
+		rb_head_page_activate(cpu_buffer);
+
+		if (cpu_buffer->ring_meta)
+			meta->commit_buffer = meta->head_buffer;
+	} else {
+		/* The valid meta buffer still needs to activate the head page */
+		rb_head_page_activate(cpu_buffer);
 	}
 
 	return cpu_buffer;
-- 
2.43.0



